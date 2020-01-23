---
date: "2010-10-22T00:00:00Z"
hidden: true
title: Setting up Unicorn with Nginx
updated_at: Nov 2012
---

Unicorn is an interesting Unix Ruby HTTP server which [makes great use of Unix][tomayko]:

> Unicorn is an HTTP server for Rack applications designed to only serve fast
> clients on low-latency, high-bandwidth connections and take advantage of
> features in Unix/Unix-like kernels.

In this post I'll describe Unicorn's design then walk you through setting it up.

# Unicorn's design 

Unicorn follows the Unix philosophy:

> Do one thing and do it right.

For instance, load balancing in Unicorn is done by the OS kernel and Unicorn's
processes are controlled by Unix signals.

Unicorn's design is officially described [here][udesign]. I will list some of
the things which I consider core for why Unicorn is an interesting alternative.

## Load balancing

> Load balancing between worker processes is done by the OS kernel. All workers share a common set of listener sockets and does non-blocking accept() on them. The kernel will decide which worker process to give a socket to and workers will sleep if there is nothing to accept().

Load balancers conventionally reverse proxy the request to the worker that is *most likely*
to be ready. This assumption is usually based purely on whenever that worker
last served a request. This suffers from two evident disadvantages:

* Some requests take longer to complete (e.g. heavy I/O, slow client)
* Software fails and times out

The common load balancer does not account for this, queueing clients at
workers behind slow requests.

Unicorn solves this problem with a pull-model rather than a push-model. All
requests are initially queued at the master on a Unix socket, workers
`accept(2)` (pull) requests off the queue (shared Unix socket) when they are
ready. Thus requests are always handled by a worker which can handle request
immediately. This solves the problems mentioned above.

## Slow clients

Slow clients slow down everything. Twitter has shed some light on this issue in
[their blog post][twitter] on why they moved to Unicorn:

> Every server has a fixed number of workers that handle incoming requests.
> During peak hours, we may get more simultaneous requests than available
> workers. We respond by putting those requests in a queue.

Welcome to Unicorn's world of evented I/O:

> This is unnoticeable to users when the queue is short and we handle requests
> quickly, but large systems have outliers. Every so often a request will take
> unusually long, and everyone waiting behind that request suffers. Worse, if an
> individual worker's line gets too long, we have to drop requests. You may be
> presented with an adorable whale just because you landed in the wrong queue at
> the wrong time.

And then they continue to talk about supermarket queues, [read the whole thing][twitter].

In the conventional web server using the busyness heuristic to determine where
to push the request, you have many short queues at each worker. Easily, a lot of
fast requests can end up behind slow requests, because they are distributed
essentially randomly, which means your request can timeout simply because you
were unlucky enough to end up behind a slow request.

Because of Unicorn's long queue model, this will not happen. Instead, you will
be taken off the long queue quickly and slow requests will fail in isolation.

## Deploying

With Unicorn one can deploy with *zero* downtime. This is rad stuff:

> You can upgrade Unicorn, your entire application, libraries and even your Ruby interpreter without dropping clients.

The Unicorn master and worker processes [respond][usignal] to Unix signals.
Here's what Github does:

> First we send the existing Unicorn master a `USR2 SIGNAL`. This tells it to
> begin starting a new master process, reloading all our app code. When the new
> master is fully loaded it forks all the workers it needs. The first worker
> forked notices there is still an old master and sends it a QUIT signal.

> When the old master receives the QUIT, it starts gracefully shutting down its
> workers. Once all the workers have finished serving requests, it dies. We now
> have a fresh version of our app, fully loaded and ready to receive requests,
> without any downtime: the old and new workers all share the Unix Domain Socket
> so nginx doesn’t have to even care about the transition.

> We can also use this process to upgrade Unicorn itself.

Unicorn's signal handling is described [here](http://unicorn.bogomips.org/SIGNALS.html).
Github has [shared their init][init] for Unicorn, which sends the appropriate signals
according to the spec for various actions. This makes 100% uptime possible,
without any significant speed drop since children are slowly restarted.

# Rails on Unicorns

We're going to set up [nginx][nginx] in front of Unicorn.

## nginx

Start by installing [nginx][nginx] via your favorite package manager. Afterwards
we need to configure it for Unicorn. We'll grab [the `nginx.conf` example
configuration shipped with Unicorn][unginx], the nginx configuration file is
usually located at `/etc/nginx/nginx.conf`, so place it there, and tweak it to
your likings, read the comments--they're quite good.

In `nginx.conf` you may have stumbled upon this line:

{{< highlight bash >}}
user nobody nogroup; # for systems with a "nogroup"
{{< / highlight >}}

While this works, it's generally adviced to run as a seperate user (which we
have more control over than nobody) for security reasons and increased control.
We'll create an nginx user and a web group.

{{< highlight bash >}}
$ sudo useradd -s /sbin/nologin -r nginx
$ sudo usermod -a -G web nginx
{{< / highlight >}}

Configure your static path in `nginx.conf` to `/var/www`, and change the owner
of that directory to the web group:

{{< highlight bash >}}
$ sudo mkdir /var/www
$ sudo chgrp -R web /var/www # set /var/www owner group to "web"
$ sudo chmod -R 775 /var/www # group write permission
{{< / highlight >}}

Add yourself to the web group to be able to modify the contents of `/var/www`:

{{< highlight bash >}}
$ sudo usermod -a -G web USERNAME
{{< / highlight >}}

## Unicorn

Now we have nginx running. Install the Unicorn gem:

{{< highlight bash >}}
$ gem install unicorn
{{< / highlight >}}

You should now have Unicorn installed: `unicorn` (for non-Rails rack
applications) and `unicorn_rails` (for Rails applications version >= 1.2) should
be in your path.

Time to take it for a spin! (You may wish to re-login with `su - USERNAME` if
you haven't already, this ensures your permission tokens are set, otherwise you
will not have write permission to `/var/www`.)

{{< highlight bash >}}
$ cd /var/www
$ rails new unicorn
{{< / highlight >}}

There we go, we now have our Unicorn Rails test app in `/var/www`! Let's fetch a
Unicorn config file. We'll set our starting point in the example configuration
that ships with the Unicorn source:

{{< highlight bash >}}
$ curl -o config/unicorn.rb https://raw.github.com/defunkt/unicorn/master/examples/unicorn.conf.rb
{{< / highlight >}}

You will want to tweak a few things to set the right paths:

{{< highlight ruby >}}
APP_PATH = "/var/www/unicorn"
working_directory APP_PATH

stderr_path APP_PATH + "/log/unicorn.stderr.log"
stdout_path APP_PATH + "/log/unicorn.stderr.log"

pid APP_PATH + "/tmp/pid/unicorn.pid"
{{< / highlight >}}

Then Unicorn is configured!

## Rainbow magic

Start the nginx deamon, this depends on your OS. Then start Unicorn:

{{< highlight bash >}}
$ unicorn_rails -c /var/www/unicorn/config/unicorn.rb -D
{{< / highlight >}}

`-D` deamonizes it. `-c` specifies the configuration file. In production you
will probably want to pass `-E production` as well, to run the app in the
production Rack environment.

That's it! Visiting [localhost](http://localhost) should take you to the Rails default page.

[tomayko]: http://tomayko.com/writings/unicorn-is-unix
[gconfig]: http://gist.github.com/206253
[udesign]: http://unicorn.bogomips.org/DESIGN.html
[usignal]: http://unicorn.bogomips.org/SIGNALS.html
[twitter]: http://engineering.twitter.com/2010/03/unicorn-power.html
[unginx]: http://github.com/defunkt/unicorn/blob/master/examples/nginx.conf
[nginx]: http://nginx.org
[init]: http://github.com/defunkt/unicorn/blob/master/examples/init.sh

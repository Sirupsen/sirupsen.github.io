---
date: "2013-09-02T00:00:00Z"
title: Unix Background Queue
---

For a side-project to be run on a single machine I needed a background queue.
I like self-contained software like sqlite, but I didn't know of any
self-contained background queue. They usually rely on some kind of broker,
whether that is Redis or a database. I decided it would be fun to write one!
Here's the weekend story of toying with Unix, Ruby C extensions, MRI and Ruby to
create [localjob][localjob].

## Unix inter-process communication

To engineer my self-contained solution I looked into Unix's IPC functionality,
the classics include:

1. Files. Persistent, would require handling file locking to work for this case.
2. Signals. Only for commands, no information passing.
3. Sockets. Good choice, but would require self-handling of persistence.
4. Named pipes. Producers block until consumed, do not persist.
5. Shared memory. Not persistent. Requires using semaphores or something similar
   to avoid race conditions.

I stumbled upon the [POSIX message queue][pmq7] during my research, which has everything
I was looking for:

1. Persistent. This gives the ability to push messages to the queue while
   nothing is listening, and the simplicity of being able to restart workers
   without maintaining a master transition. Note it's only persistent till
   system shutdown.
2. Simplicity. Locks and most race conditions are handled for me.
3. File descriptors. On Linux (not guaranteed by POSIX) the message queue is
   implemented as file descriptors, this means it's trivial to add multiple
   queue support. It's simply a matter of listening on a file descriptor for
   each queue and act when something happens, as [`select(2)`][select2] does.

## Creating a Ruby wrapper for the POSIX message queue

Ruby's standard library does not provide access to the POSIX message queue,
which meant I'd have to [roll my own][posix-mqueue] with a Ruby C extension.

POSIX message queue provides blocking calls like `mq_receive(3)` and
`mq_send(3)`. In Ruby, threads are handled by context switching between threads,
however, with blocking I/O not handled correctly a thread can block the entire
VM. This means only the blocking thread, which does nothing useful, will run.

To handle this situation you must call `rb_thread_wait_fd(fd)` before the
blocking I/O call, where `fd` is the file descriptioner. That way the Ruby
thread scheduler can do a `select(2)` on the file descriptioners and decide
which thread to run, ignoring those that are currently waiting for I/O. Below is
the source for a function to handle this in a C extension.

<script src="https://gist.github.com/Sirupsen/6416163.js"></script>

It was a fun experience creating a Ruby C extension. A lot of grepping in MRI to
find the right methods. Despite being undocumented, the api is pretty nice to
work with. The resulting gem is [posix-mqueue][posix-mqueue].

## Localjob is born

With access from Ruby to the POSIX message queue with posix-mqueue, I could
start writing [localjob][localjob]. Because the POSIX message queue already does
almost everything a background queue needs, it's a very small library, but does
a good bunch of the things you'd expect from a background queue! I'll go through
a few of the more interesting parts of Localjob.

### Signal interruptions

To kill a worker you send it a signal, localjob currently only traps `SIGQUIT`,
for graceful shutdown. That means if it's currently working on a job, it won't
throw it away forever and terminate, but will finish the job and then terminate.

It's implemented with an instance variable `waiting`. If the worker is waiting
for I/O, it's true. In the signal trap if `waiting` is true it's safe to
terminate. If not, it's currently handling a job, and another instance variable,
`shutdown`, is set to true. When the worker is done processing the current job
it'll notice that and finally terminate. Simple implementation that doesn't
handle job exceptions and multiple queues:

{{< highlight ruby >}}
Signal.trap "QUIT" do
  exit if @waiting
  @shutdown = true
end

@shutdown = false

loop do
  exit if @shutdown
  @waiting = true
  job = queue.shift
  @waiting = false
  process job
end
{{< / highlight >}}

### Multiple queues

I mentioned before that POSIX message queues in Linux are implemented as file
descriptors. This comes in handy when you want to support workers popping off
multiple queues. We just call `select(2)` on each of the queue file descriptors,
and that call will block until one of queues is ready for read, which in this
context means it has one or more jobs.

This can lead to a race condition if multiple workers are waiting and one pops
before another. To handle this, instead we issue a nonblocking call
`mq_timedreceive(3)` on the file descriptioner returned by `select(2)`.
`posix-mqueue` for that method will throw an exception if receiving a message
would block, which it would in the case that another worker already took the
job. Thus we can simply iterate over the descriptors and see which one doesn't
block, and therefore still has a job for the worker:

{{< highlight ruby >}}
def multiple_queue_shift
  (queue,), = IO.select(@queues)

  # This calls mq_timedreceive(3) via posix-mqueue 
  # (wrapped in Localjob to # deserialize as well).
  # It'll raise an exception if it would block, which
  # means the queue is empty.
  queue.shift

  # The job was taken by another worker, and no jobs
  # have been pushed in the meanwhile. Start over.
rescue POSIX::Mqueue::QueueEmpty
  retry
end
{{< / highlight >}}

## Localjob and posix-mqueue

[Localjob][localjob] and [posix-mqueue][posix-mqueue] are both open source, let
me know if have any interesting ideas for the projects or if you are going to
use them!

[localjob]: https://github.com/Sirupsen/localjob
[posix-mqueue]: https://github.com/Sirupsen/posix-mqueue
[pmq7]: http://man7.org/linux/man-pages/man7/mq_overview.7.html
[select2]: http://man7.org/linux/man-pages/man2/select.2.html
[clausgist]: https://gist.github.com/clausd/6416463

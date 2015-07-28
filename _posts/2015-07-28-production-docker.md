---
layout: post
title: Why Docker is Not Yet Succeeding Widely in Production
---

Docker's momentum has been increasing by the week, and from that it’s clearly
touching on real problems. However, for many production users today, the pros do
not outweigh the cons. Docker has done fantastically well at making containers
appeal to developers for development, testing and CI environments—however, it
has yet to disrupt production. In light of [DockerCon 2015’s “Docker in
Production” theme](https://blog.docker.com/2015/06/docker-ready-for-production/)
I’d like to discuss publicly the challenges Docker has yet to overcome to see
wide adoption for the production use case. None of the issues mentioned here are
new; they all exist on GitHub in some form. Most I’ve already discussed in
[conference][dockercon-eu-talk] [talks][goto-chg-talk] or with the Docker team.
This post is explicitly not to point out what is no longer an issue: For
instance the new registry overcomes many shortcomings of the old. Many areas
that remain problematic are not mentioned here, but I believe that what follows
are the most important issues to address in the short term to enable more
organizations to take the leap to running containers in production. The list is
heavily biased from my experience of running [Docker at
Shopify][dockercon-eu-talk], where we’ve been running the core platform on
containers [for more than a year at scale][scale-slide]. With a technology
moving as fast as Docker, it’s impossible to keep everything current. Please
[reach out][reach-out] if you spot inaccuracies.

## Image building

Building container images for large applications is still a challenge. If we are
to rely on container images for testing, CI, and emergency deploys, we need to
have an image ready in less than a minute. Dockerfiles make this almost
impossible for large applications. While easy to use, they sit at an abstraction
layer too high to enable complex use-cases:

- Out-of-band caching for particularly heavy-weight and application-specific
dependencies
- Accessing secrets at build time without committing them to the
image
- Full control over layers in the final image
- Parallelization of building layers

Most people do not need these features, but for large applications many of them
are prerequisites for fast builds. Configuration management software like Chef
and Puppet is widespread, but feel too heavy handed for image building. I bet
such systems will be phased out of existence in their current form within the
next decade with containers. However, many applications rely on them for
provisioning, deployment and orchestration. Dockerfiles cannot realistically
capture the complexity now managed by config management, but this complexity
needs to be managed somewhere. At Shopify we ended up [creating our own system
from scratch][dockercon-eu-build] using the docker commit API. This is painful.
I wish this on nobody and I am eager to throw it out, but we had to to unblock
ourselves. Few will go to this length to wrangle containers to production.

What is going to emerge in this space is unclear, and currently it’s not an area
where much exploration is being done (one example is [dockramp][dockramp],
another [packer][packer]).  The Docker Engine will [undergo work in the
future][builder-roadmap] to split the building primitives (adding files, setting
entrypoints, and so on) from the client (Dockerfile). [Work merged for
1.8][docker-cp] will already make this easier, opening the field for
experimentation by configuration management vendors, hobbyists, and companies.
Given the history of provisioning systems it’s unrealistic to believe a standard
will settle for this problem, [like it has for the runtime][opencontainers]. The
horizon for scalable image building is quite unclear. To my knowledge nobody is
actively iterating and unfortunately it’s been this way for over a year.

## Garbage collection

Every major deployment of Docker ends up writing a garbage collector [to remove
old images from hosts][docker-forums-gc]. Various heuristics are used, such as
removing images older than x days, and enforcing at most y images present on the
host. Spotify recently [open-sourced theirs][spotify-gc]. We wrote our own a
long time ago as well. I can understand how it can be tough to design a
predictable UI for this, but it’s absolutely needed in core. Most people
discover their need by accident when their production boxes scream for space.
Eventually you’ll run into the same image for the Docker registry overflowing
with large images, however, that problem is on the [distribution
roadmap][distribution-roadmap-gc].

## Iteration speed and state of core

Docker Engine has focused on stability in the 1.x releases. Pre-1.5, little work
was done to lower the barrier of entry for production uptake. Developing the
public mental model of containers is integral to Docker’s success and they’re
rightly terrified of damaging it. Iteration speed suffers when each UX change
goes through excessive process. As of 1.7, Docker features [experimental
releases][exp-releases] spearheaded by networking and storage plugins. These
features are explicitly marked as “not ready for production” and may be pulled
out of core or undergo major changes anytime. For companies already betting for
Docker this is great news: it allows the core team to iterate faster on new
features and not be concerned with breaking backwards compatibility between
minor versions in the spirit of best design. It’s still difficult for companies
to modify Docker core as it either requires a fork – a slippery slope and a
maintenance burden – or getting accepted upstream which for interesting patches
is often laborious. As of 1.7, with the announcement of plugins, the strategy
for this problem is clear: Make every opinionated component pluggable, finally
showing the fruits of the “batteries swappable, but included” philosophy first
introduced (although rather vaguely) at [DockerCon Europe
2014][dockercon-eu-keynote]. At DockerCon in June it was great to [hear this
articulated under the umbrella of Plumbing][dockercon-na-plumbing] as a top
priority of the team (most importantly for me personally because plumbing was
[mascotted by my favorite marine mammal][walrus-docker], the walrus). While the
future finally looks promising, this remains a pain point today as it has been
for the past two years.

## Logging

One example of an area that could’ve profited from change earlier is logging.
Hardly a glamorous problem but nonetheless a universal one. There’s currently no
great, generic solution. In the wild they’re all over the map: tail log files,
log inside the container, log to the host through a mount, log to the host’s
syslog, expose them via something like [fluentd][fluentd], log directly to the
network from their applications or log to a file and have another process send
the logs to Kafka. [In 1.6, support for logging drivers][docker-16] was merged
into core; however, drivers have to be accepted in core ([which is hardly
easy][fluentd-pr]). In 1.7, [experimental support for out-of-process
plugins][plugins-17] was merged, but – to my disappointment – it didn’t ship
with a logging driver. I believe this is planned for 1.8, but couldn’t find that
on official record. At that point, vendors will be able to write their own
logging drivers. Sharing within the community will be trivial and no longer will
larger applications have to resort to engineering a custom solution.

## Secrets

In the same category of less than captivating but widespread pickles, we find
secrets. Most people migrating to containers rely on configuration management to
provision [secrets on machines securely][chef-databags]; however, continuing
down the path of configuration management for secrets in containers is clunky.
Another alternative is distributing them with the image, but that poses security
risks and makes it difficult to securely recycle images between development, CI,
and production. The most pure solution is to access secrets over the network,
keeping the filesystem of containers stateless. Until recently nothing
container-oriented existed in this space, but recently two compelling secret
brokers, [Vault][vault] and [Keywhiz][keywhiz], were open-sourced. At Shopify we
developed [ejson a year and a half ago][ejson-post] to solve this problem to
manage asymmetrically encrypted secrets files in JSON; however, it makes some
assumptions about the environment it runs in that make it less ideal as a
general solution compared to secret brokers (read [this post][ejson-post] if
you’re curious).

## Filesystems

Docker relies on [CoW][cow] (Copy on Write) from the filesystem ([great LWN
series on union filesystems][unionfs-lwn], which enable CoW). This is to make
sure that if you have 100 containers running from an image, you don’t need 100 *
<size of image> disk space. Instead, each container creates a CoW layer on top
of the image and only uses disk space when it changes a file from the original
image. Good container citizens have a minimal impact on the filesystem inside
the container, as such changes means the container takes on state, which is a
no-no. Such state should be stored on a volume that maps to the host or over the
network. Additionally, layering saves space between deployments as images are
often similar and have layers in common. The problem with file systems that
support CoW on Linux is that they’re all somewhat new. Experience with a handful
of them at Shopify on a couple hundreds of hosts under significant load:

* **AUFS**. Seen entire partitions lock up where we had to remount it. Sluggish
and uses a lot of memory. The code-base is large and difficult to read, which is
likely why it hasn’t been accepted into upstream and thus requires a custom
kernel.
* **BTRFS**. Has a learning curve through a new set of tools as du and ls don’t
work.  As with AUFS, we’ve seen partitions freeze and kernels lock up despite
playing cat and mouse with kernel versions to stay up to date. When nearing disk
space capacity, BTRFS acts unpredictably, and the same goes if you have 1000s of
these CoW layers (subvolumes in BTRFS-terminology). BTRFS uses a lot of memory.
* **OverlayFS**. This was merged into the Linux kernel in 3.18, and has been [quite
stable and fast for us][redhat-fs]. It uses [a lot less memory][memory-overlay]
as it manages to share the page cache between inodes. Unfortunately it requires
you run a recent kernel not adopted by most distributions, which often means
building your own.

Luckily for Docker, Overlay will soon be ubiquitous, but the default of AUFS is
still quite unsafe for production when running a large amount of nodes in our
experience. It’s hard to say what to do here though since most distributions
don’t ship with a kernel that’s ready for Overlay either (it’s been [proposed
and rejected][overlay-default-pr] as the default for that reason), although this
is definitely where the space is heading. It seems we just have to wait.

## Reliance on edgy kernel features

Just as Docker relies on the frontier of file systems, it also leverages a large
number of recent additions to the kernel, namely namespaces and (not-so-recent,
but also not too commonly used) cgroups. These features (especially namespaces)
are not yet battle-hardened from wide adoption in the industry. We run into
obscure bugs with these [once in a while][cgroup-bug]. We run with the network
namespace disabled in production because we’ve experienced a fair amount of
soft-lockups that we’ve traced to the implementation, but haven’t had the
resources to fix upstream. Cgroup uses [a fair amount of
memory][redhat-cgroup-memory], and I’ve heard unreliable reports from the wild.
As containers see more and more use, it’s likely the larger companies that will
pioneer this stability work.

An [example of hardening][phusion-pid1] we’ve run into in production would be
zombie processes.  A container runs in a PID namespace which means that the
first process inside the container has pid 1. The init in the container needs to
perform the special duty of [acknowledging dead children][pid-namespace-man].
When a process dies, it doesn’t immediately disappear from the kernel process
data structure but rather becomes a zombie process. This ensures that its parent
can detect its death via `wait(2)`. However, if a child process is orphaned its
parent is set to init. When that process then dies, it’s init’s job to
acknowledge the death of the child with `wait(2)`—otherwise the zombie sticks
around forever. This way you can exhaust the kernel process data structure with
zombie processes, and from there on you’re on your own. This is a fairly common
scenario for process-based master/worker models. If a worker shells out and it
takes a long time the master might kill the worker waiting for the shelled
command with SIGKILL (unless you’re using [process groups and killing the entire
group at once][pgroup-man] which most don’t). The forked process that was
shelled out to will then be inherited by init. When it finally finishes, init
needs to `wait(2)` on it. Docker Engine can solve this problem by the Docker
Engine acknowledging zombies within the containers with
`PR_SET_CHILD_SUBREAPER`, as described in [#11529][docker-issue-pid1].

## Security

Runtime security is still somewhat of a question mark for containers, and to get
it production hardened is a classic chicken and egg security problem. In our
case, we don’t rely on containers providing any additional security guarantees.
However, many use cases do. For this reason [most vendors still run containers
in virtual machines][joyent-vm], which have battle-tested security. I hope to
see VMs die within the next decade as operating system virtualization wins the
battle, [as someone once said on the Linux mailing list][lwn-hypervisors-sad]:
"I once heard that hypervisors are the living proof of operating system's
incompetence". Containers provide the [perfect
middle-ground][ibuildthecloud-caas] between virtual machines (hardware level
virtualization) and PaaS (application level). I know that more work is being
done for the runtime, such as being able to blacklist system calls. Security
around images has been [cause for concern][jonathan-image-security] but Docker
is actively working on improving this with [libtrust][libtrust] and
[notary][notary] which will be part of the [new distribution
layer][distribution].

## Image layers and transportation

The first iteration of Docker took a clever shortcut for image builds,
transportation and runtime. Instead of choosing the right tool for each problem,
it chose one that worked OK for all cases: filesystem layers. This abstraction
leaks all the way down to running the container in production. This is perfectly
acceptable minimum viable product pragmatism, but each problem can be solved
much more efficiently:

* **Image builds** could be represented as a directed graph of work. This allows
figuring out caching and parallelization for fast, predictable builds.
* **Image transportation** instead of using image layers it could perform
[binary diffing][data-dedup]. This is a topic that has been studied for decades.
The distribution and runtime layer are getting more and more separated, opening
up for this sort of optimization.
* **Runtime** should just do a single CoW layer rather than using the arbitrary
image layer abstraction again. If you’re using a union filesystem such as AUFS
on the first read you’re traversing a linked list of files to assemble the final
file.  This is slow and completely unnecessary.

The layer model is a problem for transportation (and for building, as covered
earlier). It means that you have to be extremely careful about what is in each
layer of your image as otherwise you easily end up transporting 100s of MBs of
data for a large application. If you have large links within your own datacenter
this is less of a problem, but if you wish to use a registry service such as
Docker Hub this is transferred over the open Internet. [Image distribution is
being worked on actively currently][docker-distribution-roadmap]. There’s a lot
of incentive for Docker Inc to make this solid, secure and fast. Just as for
building, I hope that this will be opened for plugins to allow a great solution
to surface. As opposed to the builder this is somewhere people can generally
agree on a sane default, with specialized mechanisms such as bittorrent
distribution.

## Conclusion

Many other topics haven’t been discussed on purpose, such as storage,
networking, multi-tenancy, orchestration and service discovery. What Docker
needs today is more people going to production with containers alone at scale.
Unfortunately, many companies are trying to overcompensate from their current
stack by [shooting for the stars of a PaaS][dockercon-eu-talk-unicorn-slide]
from the get go. This approach only works if you’re small or planning on doing
greenfield deployments with Docker—which rarely run into all the obscurities of
production. To see more widespread production usage, we need to tip the pro/con
scale in favour of Docker by resolving some of the issues highlighted above.

Docker is putting itself in an exciting place as the interface to PaaS be it
discovery, networking or service discovery with applications not having to care
about the underlying infrastructure. This is great news, because as Solomon
says, the best thing about Docker is that it gets people to agree on something.
We’re finally starting to agree on more than just images and the runtime.

All of the topics above I’ve discussed in length with the great people at Docker
Inc, and GitHub Issues exist in some capacity for all of them. What I’ve
attempted to do here, is simply provide an opinionated view of the most
important areas to ramp down the barrier of entry. I’m excited for the
future—but we’ve still got a lot of work left to make production more
accessible.

My [talk at DockerCon EU 2014][dockercon-eu-talk] on Docker in production at Shopify

[Talk at DockerCon 2015](https://www.youtube.com/watch?v=ZDeAEZHby_A) on Resilient Routing and Discovery.

[dockercon-eu-talk]: https://www.youtube.com/watch?v=Qr0sATj9IVc
[goto-chg-talk]: https://www.youtube.com/watch?v=ZDeAEZHby_A
[scale-slide]: https://speakerdeck.com/sirupsen/dockercon-2015-resilient-routing-and-discovery#3
[reach-out]: http://twitter.com/Sirupsen
[dockercon-eu-build]: https://www.youtube.com/watch?v=Qr0sATj9IVc&t=14m50s
[dockramp]: https://github.com/jlhawn/dockramp
[packer]: https://packer.io/
[builder-roadmap]: https://github.com/docker/docker/blob/933d9f2e0d61345a11f272487a223f4085bb798a/ROADMAP.md#122-builder
[docker-cp]: https://github.com/docker/docker/pull/13171
[opencontainers]: http://www.opencontainers.org/
[docker-forums-gc]: https://forums.docker.com/t/command-to-remove-all-unused-images/20/15
[spotify-gc]: https://github.com/spotify/docker-gc
[distribution-roadmap-gc]: https://github.com/docker/distribution/blob/master/ROADMAP.md#deletes
[exp-releases]: https://github.com/docker/docker/tree/5fdc10239624aa3b623f46af28bf237b0f33299f/experimental
[dockercon-eu-keynote]: https://www.youtube.com/watch?v=QmRBB7u-4TE
[dockercon-na-plumbing]: https://www.youtube.com/watch?v=at72dhg-SZY
[walrus-docker]: http://image.slidesharecdn.com/keynoted1-150625182929-lva1-app6891/95/dockercon-sf-2015-keynote-day-1-59-638.jpg?cb=1436479368
[fluentd]: http://www.fluentd.org/
[docker-16]: https://blog.docker.com/2015/04/docker-release-1-6/
[fluentd-pr]: https://github.com/docker/docker/pull/11485
[plugins-17]: https://github.com/docker/docker/blob/a628155a7211041b9e671980ead195ddc6e63c6b/CHANGELOG.md#170-2015-06-16
[chef-databags]: http://docs.chef.io/data_bags.html
[vault]: http://vaultproject.io/
[keywhiz]: https://github.com/square/keywhiz
[ejson-post]: https://www.shopify.com/technology/26892292-secrets-at-shopify-introducing-ejson
[cow]: https://en.wikipedia.org/wiki/Copy-on-write
[unionfs-lwn]: http://lwn.net/Articles/325369/
[redhat-fs]: http://developerblog.redhat.com/2014/09/30/overview-storage-scalability-docker/
[memory-overlay]: https://twitter.com/burkelibbey/status/566314803225186304
[overlay-default-pr]: https://github.com/docker/docker/pull/12354
[cgroup-bug]: https://lkml.org/lkml/2014/10/24/456
[redhat-cgroup-memory]: https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Resource_Management_Guide/sec-memory.html
[phusion-pid1]: https://blog.phusion.nl/2015/01/20/docker-and-the-pid-1-zombie-reaping-problem/
[pid-namespace-man]: http://man7.org/linux/man-pages/man7/pid_namespaces.7.html
[pgroup-man]: http://man7.org/linux/man-pages/man2/setpgid.2.html
[docker-issue-pid1]: https://github.com/docker/docker/issues/11529
[joyent-vm]: https://www.joyent.com/blog/understanding-triton-containers
[lwn-hypervisors-sad]: https://lwn.net/Articles/524952/
[ibuildthecloud-caas]: http://www.ibuildthecloud.com/blog/2014/08/19/containers-as-a-service-caas-is-the-cloud-operating-system/
[jonathan-image-security]: https://titanous.com/posts/docker-insecurity
[libtrust]: https://github.com/docker/libtrust
[notary]: https://github.com/docker/notary
[distribution]: https://github.com/docker/distribution
[data-dedup]: https://en.wikipedia.org/wiki/Data_deduplication
[docker-distribution-roadmap]: https://github.com/docker/docker/blob/master/ROADMAP.md
[dockercon-eu-talk-unicorn-slide]: https://speakerdeck.com/sirupsen/dockercon-eu-docker-at-shopify-from-this-looks-fun-to-production#12

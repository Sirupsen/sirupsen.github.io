---
date: "2010-07-23T00:00:00Z"
hidden: true
title: The switch to Github Pages
updated_at: Nov 2012
---

<div class="intro">I ditched my VPS to migrate my blog to Github
Pages. A simple blogging platform for hackers.</div>

I hosted my previous Wordpress blog on my dad's server. Limiting me in terms
of technological mobility. The lack of free deployment methods kept me from
using languages other than PHP.

I decided to rent a VPS. I looked at [low end box][low] for a light option,
since a personal blog like this requires minimal power. Although I wanted to
retain enough power to stand a Slashdot as when I published [What I wish a Ruby
programmer had told me one year ago][wish], requiring juice which isn't needed
the majority of the time. Adding a caching layer to avoid the dynamic web server
layer seemed like a redundant move, which it turned out to be.

Pretty soon I had to switch VPS host due to latency issues, at the thought of
migrating my blog once again, the thought of hosting it independently became
intrusive. My blog was mostly static anyhow: Wrote [Markdown][markdown] blog
posts in Vim, no comment system or other dynamic interaction.

I looked into [Github Pages][pages], which runs [Jekyll][jekyll] allowing you to
host a sophisticated static blog, with support for the mandatory hacker features
such as code highlighting and clever handling of the static blog posts. It's
super easy to set up. Deployment is performed just by pushing to a Github
repository with the name "username".github.com", i.e. I push to
[Sirupsen/sirupsen.github.com][source] at Github.
Here's a guide to [migrate to Jekyll from other blogging engines][migrate].

I've since cancelled my VPS. I no longer have to worry about a server or uptime.

[low]: http://www.lowendbox.com/
[pages]: http://pages.github.com
[jekyll]: http://github.com/mojombo/jekyll
[markdown]: http://daringfireball.net/projects/markdown/
[source]: https://github.com/Sirupsen/sirupsen.github.com
[liquid]: http://www.liquidmarkup.org/
[wish]: /what-I-wish-a-ruby-programmer-had-told-me-one-year-ago/
[migrate]: http://wiki.github.com/mojombo/jekyll/blog-migrations

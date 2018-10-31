---
layout: post
title: Get started right with RVM
updated_at: "Nov 2012"
hidden: true
---

I've always run Ruby with [RVM](http://rvm.beginrescueend.com/). After
[@chopmo's](http://twitter.com/chopmo) talk at [Aarhusrb](http://aarhusrb.dk) on
RVM, I realized how much more I could get out of RVM. I found I basically use
RVM as just a way to switch between Ruby versions and implementations, rather
than leveraging the power of gemsets, installing gems on a user basis and the
`.rvmrc` file. This post is a compiled version of what I learned from the
previously mentioned talk and digging into the [RVM documentation](http://rvm.beginrescueend.com/).

## Installing RVM

If you haven't already, install RVM at the user level:

{% highlight bash %}
$ bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )
{% endhighlight %}

With > 1 RVM users on the system, you may want to look into a system-wide
[system-wide installation](http://rvm.beginrescueend.com/deployment/system-wide/).
Otherwise, it is recommended to stay with the default user-wide installation.

To inject RVM into your environment `.bashrc`, `.bash_profile`, add the bit of
bash it mentions at the end of the installation:

{% highlight bash %}
$ echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> .bashrc
{% endhighlight %}

### Fixing slow gem installations

Installing Ruby gems is by default a slow affair due to `ri` and `rdoc`
documentation generation. Most likely you do not use this, and can disable it in
return for vastly improved installation speeds:

{% highlight ruby %}
gem: --no-ri --no-rdoc
{% endhighlight %}

Verify whether the `rvm` command works and check system specific notes:

{% highlight bash %}
$ rvm notes
{% endhighlight %}

## Uninstalling all gems in system Ruby (Optional)

This step can safely be skipped, I simply performed it to clean my system.

With RVM installed, you can simply empty your current, global gemset (this'll
make more sense in a minute):

{% highlight bash %}
$ rvm gemset empty
{% endhighlight %}

You can easily take a backup of all your installed Gem's and their versions with
RVM:

{% highlight bash %}
$ rvm gemset export backup.gems
{% endhighlight %}

If you want to restore, it's simply a matter of running:

{% highlight bash %}
$ rvm gemset import backup.gems
{% endhighlight %}

I'll mention why `rvm gemset {import,export}` is as nifty as it is further down.

## Installing Rubies

In RVM jargon Rubies are essentially Ruby versions, let's go ahead and install
`Ruby MRI 1.9.3` (this is the default interpreter originally developed by Matz)
first, and set that as our default interpreter. Afterwards, we'll install `Ruby
1.8.7`, use RVM to easily switch between these two Rubies.

Installing `1.9.3` is the trivial matter of issuing:

{% highlight bash %}
$ rvm install 1.9.3
{% endhighlight %}

This can take a while, since it compiles from source. When this process has
finished, switch to it with the following command to verify it works:

{% highlight bash %}
$ rvm 1.9.3 # shortcut for rvm use 1.9.3
$ ruby -v
ruby 1.9.3p194 (2012-04-20 revision 35410) [x86_64-darwin11.4.0]
{% endhighlight %}

By default, your default interpreter is the system Ruby provided by your
operating system, for instance in OS X this is `MRI Ruby 1.8.7`. You want to set
this to a Ruby maintained by RVM to make use of all RVM's features:
    
{% highlight bash %}
$ rvm --default 1.9.3
{% endhighlight %}

Restart your shell, and run `ruby -v` to verify it is not the default Ruby.
Let's install `1.8.7` along with `1.9.3`:

{% highlight bash %}
$ rvm install 1.8.7
{% endhighlight %}

We can then switch to it just as before:

{% highlight bash %}
$ rvm 1.8.7
{% endhighlight %}

You are now up and running with two Rubies! With RVM, you can also install
different interpreters such as Rubinius, JRuby or Maglev following the
same installation procedure as above.

## Gemsets

### What?

The shortest explanation, is found within the name. Gem-sets.  
RVM's documentation puts it like this:

> RVM gives you compartmentalized independent ruby setups. This means that ruby,
> gems and irb are all separate and self-contained from system and from each
> other.   You may even have separate named gemsets.  Let's say, for example,
> that you are testing two versions of a gem with ruby 1.9.3-head. You can
> install one to the default 1.9.3-head and create a named gemset for the other
> version and switch between them easily.

Ideally you have a Gemset for each project that you are working on. This keeps
your system clean, and eliminates "Gem clutter" and version mismatches. Also
running `bundle install` will use the project defined gemset to also store the
gems.

### Contemporary note on gem versions and gemsets

When I wrote this article, `bundler` wasn't commonly found in Ruby projects as
it is now. `bundler` now solves the problems gemsets solved, by ensuring the
correct versions of the gems for the specific projects are loaded into the
environment by running scripts in your project with `bundler exec` rather than
`ruby`. `bundler` projects thus make simpler approaches to the problem RVM solves
possible, the most popular alternative nowadays is
[rbenv](https://github.com/sstephenson/rbenv) which I use on most of my systems
these days.

### Creating and using a gemset

Let's go ahead and create a gemset:

{% highlight bash %}
$ rvm gemset create foo # Create gemset 'foo'
'foo' gemset created (/home/sirup/.rvm/gems/ruby-1.9.3-p0@foo).

$ rvm 1.9.3@foo # Switch to Ruby 1.9.3 with gemset 'foo'
$ gem list # Lists installed gems
*** LOCAL GEMS ***
{% endhighlight %}

We'll go ahead and install a few gems in our new gemset, note that we are not
using `sudo` to install gems, as the gemsets are stored in your user directory,
and thus does not require administrator privileges: 

{% highlight bash %}
$ gem install rails
$ gem list
gem list
*** LOCAL GEMS ***

abstract (1.0.0)
actionmailer (3.0.0)
actionpack (3.0.0)
activemodel (3.0.0)
[..]
{% endhighlight %}

Switching back to our default, global gemset, will reveal that `rails` and its
associated gems above, was indeed installed in an isolated gemset.
    
{% highlight bash %}
$ rvm 1.9.3 # explicit: rvm 1.9.3@global
$ gem list
{% endhighlight %}

As expected, `gem list` returns an empty list since there are no gems in the
global gemset which we cleared earlier.

### Dumping and loading gemsets

Exporting a gemset is easy with RVM as previously mentioned:

{% highlight bash %}
$ rvm 1.9.3@foo
$ rvm gemset export rails.gems
$ cat rails.gems
abstract -v1.0.0
actionmailer -v3.0.0
actionpack -v3.0.0
activemodel -v3.0.0
[..]
{% endhighlight %}

You can then toss `rails.gems` to someone else, who'd be able to import that
gemset as follows:

{% highlight bash %}
$ rvm use 1.9.3@rails --create # shortcut to create, then switch to it
$ rvm gemset import rails.gems
{% endhighlight %}

Installing all the gems from `rails.gems` with the right versions. This works
great in teams, because of all the version conflicts that otherwise happen if
you just install the newest versions of everything.

### Contemporary note on exporting and importing gemsets

Nowadays we have `bundler` which also solves this problem, which used to be a
massive pain. Nonetheless, it still has a wide array of usages today.

### The global and default gemset

Two interesting gemsets are the `global` (`~/.rvm/gemsets/global.gems`) and
`default` (`~/.rvm/gemsets/default.gems`) gemsets.  

Gems in the `global gemset`, will be added to the global gemset in *every* new
Ruby you install. `rake`, `rdoc` and `bundler` are good examples of handy global
gems. The gems in the `default gemset` are the gems included in every newly
created gemset.

## rvmrc

There are three different kinds of `rvmrc` files:

* System `/etc/rvmrc`
    - System wide configuration
* User `~/.rvmrc`
    - User wide configuration
* Project `.rvmrc`
    - Project wide configuration

The most interesting one is the project `.rvmrc`. Every time you `cd`, RVM looks
for a file called `.rvmrc`. If it finds it, it executes it. The following
`.rvmrc` file would switch to `Ruby MRI 1.8.7` and gemset `project` every time
we change into that directory:

{% highlight bash %}
$ echo "rvm 1.8.7@project" > ~/projects/ruby-1.8.7-project/.rvmrc
{% endhighlight %}

I received [a tip](http://twitter.com/wayneeseguin/status/24387445101) from
RVM's creator [@wayneeseguin](http://twitter.com/wayneeseguin), that we can be
even more sneaky about this:

{% highlight bash %}
$ rvm --create --rvmrc 1.8.7@project
{% endhighlight %}

This will create the gemset, and the `.rvmrc` file for the project all in one
command!

To demonstrate what we just did:

{% highlight bash %}
~/projects $ ruby -v
ruby 1.9.3p194 (2012-04-20 revision 35410) [x86_64-darwin11.4.0]
~/projects $ cd ruby-1.8.7-project/
~/projects/ruby-1.8.7-project $ ruby -v
ruby 1.8.7 (2012-02-08 patchlevel 358) [universal-darwin12.0]
~/projects/ruby-1.8.7-project $ rvm gemset name
project
{% endhighlight %}

My favorite configuration option is `rvm_gemset_create_on_use_flag=1`, having
this line in `/etc/rvmrc` or `~/.rvmrc`, gemsets will be automatically created
if they do not exist when you switch to them:

{% highlight bash %}
$ rvm gemset list
gemsets for ruby-1.9.3-p194 (found in /home/sirup/.rvm/gems/ruby-1.9.3-p0)
gemsets for ruby-1.8.7-p358 (found in /home/sirup/.rvm/gems/ruby-1.9.3-p358)

foo
global
$ rvm gemset use foobar
Now using gemset 'foobar'
{% endhighlight %}

[@wayneeseguin](http://twitter.com/wayneeseguin) sent in [another tip](http://twitter.com/wayneeseguin/status/24387379953) about how to add [`bash` and `zsh` completion](http://rvm.beginrescueend.com/workflow/completion/). 

You can read more about `rvmrc` in [RVM's documentation](http://rvm.beginrescueend.com/workflow/rvmrc/).

## Conclusion

This is all briefly describing what can be found in [RVM's (fantastic)
documentation](http://rvm.beginrescueend.com/). For basic use, this article
should cover the main topics, however, RVM can still do a whole lot more than I
addressed here. The goal of this post was simply to get you started well, and
right, with RVM.

[Discuss this on Hacker News](http://news.ycombinator.com/item?id=1686435)

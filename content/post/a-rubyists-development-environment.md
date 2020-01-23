---
date: "2010-09-19T00:00:00Z"
hidden: true
title: A Rubyist's development environment
---

I consider myself as a Rubyist and a minimalist. I want my tools to be few, and sharp. That means I only want few tools, but I want to master these tools.
Now it's been about a year since I started programming, this post is supposed to give you a look into my toolbox. I hope it can be of inspiration to you.

I've open sourced all my dotfiles [on Github][dotfiles].

## Operating System: Linux and Mac

My primary development platform is my desktop running [Arch Linux](http://sirupsen.com/my-experience-with-arch-linux "See my blog post about my experience with Arch Linux"). It's a dual screen setup, which I learned to *love*. I also own a Macbook, primarily used for schoolwork and field coding.

As for my desktop setup of noteworthy tools besides my editor, I use bleeding-edge Chromium as my browser. I might switch to [Uzbl](http://www.uzbl.org/) someday. I use [Openbox](http://openbox.org/wiki) as my window manager. Sakura as my terminal, simply because it's lightweight, simple to setup and it does its job.

I have Openbox [configured to act like Vim](http://github.com/Sirupsen/dotfiles/blob/master/.config/openbox/rc.xml), and for Chromium I use [Vimium](https://chrome.google.com/extensions/detail/dbepggeogbaibhgnhhndojpepiihcmeb) to achieve the same Vim behavior. In theory I *never* have to touch my mouse.

### Shell

As for my shell I just use `bash`. I know the cool kids use `zsh`, but I simply haven't bothered to set it up, and I'm really quite happy with `bash`. 

My bash configuration is pretty simple. It just defines some default values, source a few things, and add to my `$PATH`. It also sets my `PS1` which consists of only the current directory. I figured that I *already know* my username, and hostname. Furthermore I really don't need to know the entire absolute path of the current directory.

## Editor: Vim

I've been through many editors. Many. Believe me. A little less than a year ago, a friend recommended me Vim. And I started digging into it. In the beginning, it was hard. But he promised me it'd be worth it. So I sticked to it. In the start, I felt less productive in Vim, because it was somewhat hard to learn. After a few days in it however, I began taking advantage of the endless sets of commands, this all resulted in a *more* productive me. I now love Vim, and nowadays I almost do all of my text-processing in it: I take notes in Vim, I'm writing this very blog post in Vim, and I make kickass code in Vim.

My Vim setup really is nothing special. I use a few plugins, and I have a small configuration file which is just parts stolen and compiled from others. I can't remember who I stole what from, though. So they are not credited. I use Monaco as my Vim (and terminal) font, I simply like this font a lot. [Screenshot](http://imgur.com/IdNuY.png).

## Syncing: Dropbox

As I have multiple computers, I sync *everything* with Dropbox. This also has the benefit of being (additional, I have everything under `git`, too) backup. My Dropbox holds mostly configuration files and code. The rest is in the cloud. With everything in my Dropbox, I make symbolic links from the Dropbox.

### Configuration between multiple computers

As I have multiple computers, I want [my configuration files][dotfiles] (*dotfiles*) to change on other computers as soon as I have changed it somewhere else. In the beginning I had an ugly Rake task to do all this symbolic linking, but later I discovered [Homesick][homesick]. 

> Homesick is sorta like rip, but for dotfiles. It uses git to clone a repository containing dotfiles, and saves them in `~/.homesick`. It then allows you to symlink all the dotfiles into place with a single command.

When you clone a `castle`, as they are called in Homesick, it puts the castle in `~/.homesick/repos/<repo>`, for instance:

{{< highlight bash >}}
$ homesick clone Sirupsen/dotfiles # goes to ~/homesick/repos/Sirupsen/dotfiles
{{< / highlight >}}

Instead of updating the dotfiles with Git via pulling, however, I wanted it to go through Dropbox, so changes are reflected on my other computers instantly. Later, I can commit these changes:

{{< highlight bash >}}
$ ln -s Dropbox/dotfiles ~/.homesick/repos/
{{< / highlight >}}

Now I can symlink everything easily:

{{< highlight bash >}}
$ homesick symlink dotfiles
{{< / highlight >}}

## Using dual screen for coding

When I work, I usually work on two monitors. A 19", and a 24".

On my 19" I have Pidgin running. This makes me able to talk to colleagues, or friends while working on my other monitor. I might also shring my windows here, and have another terminal open with tests.

On my 24" I have my browser running in the right side, taking up about 50% of horizontal space. When i am coding, this is great for documentation and general googling, githubing and ticket managing while coding. I have experimented with fullscreen Vim, however I just don't need more than these 80 columns horizontally, so this setup works great. More vertical space is always nice, I've heard great things about having a screen that can be turned around to a portrait view for coding. I usually have my terminal running beneath my Vim window, it's super easy to switch between them with my Openbox Vim configuration.

[homesick]: http://github.com/technicalpickles/homesick
[dotfiles]: http://github.com/Sirupsen/dotfiles

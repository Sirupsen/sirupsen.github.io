---
date: "2010-04-06T00:00:00Z"
hidden: true
title: My experience with Arch Linux
---

After about 8 months with [Ubuntu][1], I decided it was time for change. I had for a while wanted to switch to some other distribution, not because I did not like Ubuntu, more because I wanted to learn more about Linux, and try something new. And I felt Ubuntu limited me in this direction. Furthermore, I wanted to have a system which I did not feel I had to reinstall whenever new major updates came out, I wanted a system I could improve over time. I wanted a system where I could switch desktop environment/window manager quickly, and without googling myself on how to then remove all the old, now useless, packages. And rolling-release seems to be the solution, to that problem.

I quickly found a distro. which seemed to fit my requirements, [Arch Linux][2]. Arch Linux is lightweight, and simple. I found a quote on the Wiki, which describes it quite well: 

> "Linux, with a nice package manager." 

And my edition:

> "Linux, with an nice package manager, and a kick-ass Wiki." 

That Wiki seriously provides the best information on everything you'll ever need to know - I have yet to run into a problem which is not described here.

With Arch, you basically start with bare-bones Linux, which can boot into a CLI, has the basic stuff like Vi, grep, and these kind of basic Unix tools, that you'd have to install anyway, as well as a tool with which you can install packages. From there, you simply start building your system with the [Arch Linux beginner's guide][3] (which is extremely well written). You install Vim, Xorg, Drivers, and so on. As it was my first (and hopefully only on this computer) install, I took good time to do each step, to understand what I was installing, and why I was installing it. Once I had Xorg up (I already felt like I had learned a lot more about how Linux works at a lower level. I was already starting to really like Arch Linux.

At some point when Xorg was set up, I wanted a [Window Manager][4]. And it's really a dungeon there. There are hundreds of different Window Managers, tiling, not-tiling, and these big desktop environments (Gnome, KDE). I had already decided I didn't want to go for a desktop environment, since then I'd have loads of gui-configuring-tools, and not learn exactly where configuration files are located (*oh how I search the knowledge*). I quickly figured out that [Openbox][5] was very popular on the Arch Linux forums. So I decided to install it, and found the neat [Arkid theme][6], somebody had posted it in a screenshot thread on the Arch Linux forums. I've found Openbox to be great, and fit my needs.

From there, it was just a matter of setting up all the stuff I usually set up when I install Ubuntu: Vim, Chrome, Pidgin, a music player, Dropbox, and so on. And Pacman (the Arch Linux package manager) made this a pleasing experience. I ran into a few packages which I could not install with Pacman however. But, I quickly figured there was something called [AUR][7] (the Arch User Repository), in which I have yet to not find a package, this helps me get minimum headaches, since the AUR packages usually compile OTB, running the right **./configure** etc. And of course, my fellow Arch Linux users have also provided me with tools which allows easy installation from AUR. I found a tool called [Clyde][8], which works great. Basically a layer on Pacman with [AUR][8] support.

I've been running this system for a few weeks (as of this update, months), and I feel at home. I love it really. If you are looking to try something new, and already got some Linux experience, then you should defiantly go and try Arch Linux! Should you run into issues you have trouble addressing the people at #archlinux on chat.freenode.net are helpful.

Here's a screenshot of my Archbox, because everyone loves screenshots.

[![](/static/images/arch.png)][9]

 [1]: http://www.ubuntu.com/
 [2]: http://www.archlinux.org/
 [3]: http://wiki.archlinux.org/index.php/Beginners'_Guide
 [4]: http://wiki.archlinux.org/index.php/Window_manager
 [5]: http://openbox.org/wiki/Main_Page
 [6]: http://rent0n86.deviantart.com/art/Arkid-148937983
 [7]: http://aur.archlinux.org/
 [8]: http://bbs.archlinux.org/viewtopic.php?id=91860
 [9]: http://img202.imageshack.us/img202/8011/201004050121043200x1080.png

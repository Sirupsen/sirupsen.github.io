---
layout: post
title: Installing Node and Karma for AngularJS Testing on Windows
---

<div class="intro">
  Sometimes you need to set up your dev environment on a Windows machine. For me, that typically means running into errors I wouldn't see on my Mac or a Linux box. This is a concise list of steps to save me a bunch of Googling in the future.
</div>

1. Slightly unrelated, but I would install (Git Bash)[http://git-scm.com/downloads] first, you need it any way (probably) and it's better than Windows' default cmd.exe.

2. Open up Git Bash and check to see if node is already installed on the system: 
	node --version

3. If it's not, or it's < v0.8, head over to (nodejs)[http://nodejs.org/] and click the green install button. Run the Windows installer (.msi), all of the default settings will work just fine.

4. Re-open Git Bash (so it recognizes the newly installed node commands)

5. Install Karma (npm is the Node Packaged Modules command):
	npm install -g karma

6. Now we need to test if everything's getting along with each other. I suggest installing the AngularJS tutorial app for a quick test to, well, test with. In git bash 'cd' to the htdocs folder -- or whatever folder serves up your localhost pages, and clone the app:
	git clone git://github.com/angular/angular-phonecat.git

7. Change directory to the project:
	cd angular-phonecat

8. Checkout the branch that has the first tests available:
	git checkout -f step-2

9. Try running the tests, enter:
	./scripts/test.sh
This should start a new instance of Chrome and you'll see something like this output to Git Bash:
	info: Karma server started at http://localhost:9876/
	info (launcher): Starting  browser "Chrome"
	info (Chrome 22.0): Connected on socket id tPUm9DXcLHtZTKbAEO-n
	Chrome 22.0: Executed 2 of 2 SUCCESS (0.093 secs / 0.004 secs)

10. Did you get an 'error (launcher): Cannot start Chrome', or something about Chrome's path? Enter:
	export CHROME_BIN='C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'
Double check that, that is indeed the path to chrome.exe on your machine.

Now you should be in business, write tests and be merry.

<div class="intro">
  Like many before me, several now nameless blogs that I've started lay abandoned. They were blogs that barely made it beyond Hello World. Maybe it was a due to a lack of direction or perhaps they fell victim to cloning syndrome -- closely mimicking the goals of large mainstream blogs. Heck, who wouldn't want to be a problogger?
</div>

Dare I say this time is different? Yes, largely because I have two simple goals.

1. To learn and to educate myself. This is contrary to every previous attempt where I only sought to pass knowledge on to readers. Here I will seek to gain knowledge. 
2. To track my progress in moving away from working as a freelance front end developer to a fulfilling full time development position. Preferably in the venerable Silicon Valley or Denver -- this is more of a geographical preference than a target set on any particular companies.


##A bit about me

I picked up my first book on web development in 1999, *HTML Complete the first edition*. Fun fact: this behemoth contains 1,028 pages, a decidedly large book for a 5th grader to add to his backpack. I devoured that book cover to cover many times over that year. I was fascinated by seeing my creations published on Geocities and Angel Fire.

I continued to practice and extend my knowledge of web development and design through high school, adding CSS (no more tables and font tags!), JavaScript, PHP, and MySQL. Then I enlisted in the Navy in 2007, a year after graduating high school. Fast forward to 2010 after a medical discharge -- perhaps another story for another day. I came home empty handed ready to start anew. Put the landscape of front end development that I knew so well had changed dramatically over a few short years!

I was left behind. So now I have work to do. Challenge accepted.


##What I'm learning and what I'm working on

I'm up to speed on JavaScript frameworks such as jQuery and YUI. Once you've extensively dug through the documentation of one and built a few apps, it's quite easy to switch gears and adapt to whatever flavor of framework the project you're currently assigned to uses.

I'm using Anki to memorize a good majority of *JavaScript the Good Parts* and to commit large portions of the Mozilla Developer Network JavaScript reference material to memory.

I'm working on a side project to play with the File API, Local Storage, AngularJS, CSS preprocessing, and a few other fun toys that HTML 5 brings to the table. This side project is a mash-up of several open source language re-compilers/translators, so you can easy test and compare different options side by side. It uses [Ace](ace.ajax.org) code editors to save time and keep the UI familiar &amp; pretty.

And I co-founded a small start-up, [Mosurv](www.mosurv.co), which has been a major learning experience. That too is another story for another day.

Thanks for reading!
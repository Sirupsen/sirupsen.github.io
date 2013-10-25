---
layout: post
title: Installing Node and Karma for AngularJS Testing on Windows
---

<div class="intro">
  Sometimes you need to set up your dev environment on a Windows machine. For me, that typically means running into errors I wouldn't see on my Mac or a Linux box. This is a concise list of steps to save me a bunch of Googling in the future.
</div>

1) Slightly unrelated, but I would install (Git Bash)[http://git-scm.com/downloads] first, you need it any way (probably) and it's better than Windows' default cmd.exe.

2) Open up Git Bash and check to see if node is already installed on the system: 

	node --version

3) If it's not, or it's < v0.8, head over to (nodejs)[http://nodejs.org/] and click the green install button. Run the Windows installer (.msi), all of the default settings will work just fine.

4) Re-open Git Bash (so it recognizes the newly installed node commands)

5) Install Karma (npm is the Node Packaged Modules command):

npm install -g karma

6) Now we need to test if everything's getting along with each other. I suggest installing the AngularJS tutorial app for a quick test to, well, test with. In git bash 'cd' to the htdocs folder -- or whatever folder serves up your localhost pages, and clone the app:

	git clone git://github.com/angular/angular-phonecat.git

7) Change directory to the project:

	cd angular-phonecat

8) Checkout the branch that has the first tests available:

	git checkout -f step-2

9) Try running the tests, enter:

	./scripts/test.sh
	
This should start a new instance of Chrome and you'll see something like this output to Git Bash:

	info: Karma server started at http://localhost:9876/
	info (launcher): Starting  browser "Chrome"
	info (Chrome 22.0): Connected on socket id tPUm9DXcLHtZTKbAEO-n
	Chrome 22.0: Executed 2 of 2 SUCCESS (0.093 secs / 0.004 secs)

10) Did you get an 'error (launcher): Cannot start Chrome', or something about Chrome's path? Enter:

	export CHROME_BIN='C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'

Double check that, that is indeed the path to chrome.exe on your machine.

Now you should be in business, write tests and be merry.
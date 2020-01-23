---
date: "2010-04-20T00:00:00Z"
draft: true
title: Create your first Ruby Gem and release it to Gemcutter
---

A few days ago I was set off to create my first RubyGem. There are many resources on how to do this, but it took me a good while to gather all the information I figured I'd need for my application, so I've decided to gather my bit of knowledge in this article.

This article's goal is kick start the creation of your first Gem. To make this experience more enjoyable, I've chosen to use a gem called [Jeweler][jw].

**Note:** I am by no means a "ruby-pro". I have only created a single Gem, but I thought this article could be helpful to a lot of people, and thus I wrote it. If you have any corrections, questions, or suggestions please either email me at sirup@sirupsen.dk or comment below.

<!--more-->
<h2>Preparing</h2>
<p>.. for world domination!</p>

<p>I assume you already know a bit of <a href="http://www.ruby-lang.org/en/">Ruby</a>, that you know what <a href="http://rubygems.org/">RubyGems</a> is, and you have already downloaded a few gems, and used some of them in your work. Now your are simply seeking to create your own Gems. You are indeed in for a fun time, coding gems is lots of fun!</p>

<p>Before we can begin, install the <a href="http://github.com/technicalpickles/jeweler">Jeweler</a> gem via RubyGems:</p>
<pre>$ gem install jeweler</pre>

<p>Jeweler is a tool to create the basic skeleton for your Gem, as well as managing the gem.</p>

<h2>Creating your gem</h2>
<p>.. with your mighty companion <strong>Jeweler</strong></p>

<p>Once Jeweler is installed, you want to create your Gem skeleton. I'm going to create a simple Hello World gem for the sake of example, and later on explain a bit about how you could manage your own Gem (at the very least my 2 cents about how a gem should be done).</p>
<pre>$ jeweler helloworld # Should be all small letters</pre>
<pre>	create	.gitignore
	create	Rakefile
	create	LICENSE
	create	README.rdoc
	create	.document
	create	lib
	create	lib/helloworld.rb
	create	test
	create	test/helper.rb
	create	test/test_helloworld.rb
Jeweler has prepared your gem in helloworld</pre>

<p>Now your gem skeleton is ready! Let's get in there and check it out.</p>

<pre>$ cd helloworld
$ ls
<span style="color: #008000;"><strong>lib/</strong></span>  LICENSE  Rakefile  README.rdoc  <span style="color: #008000;"><strong>test/</strong></span></pre>

<p>This structure might look familiar to you. (Assuming you are like me and have already stalked a few Gems' sources over at <a href="https://github.com/">Github</a>) Now I'll attempt to explain what these files and folders are.</p>

<h3>lib/</h3>

<p>This is where your application lives, this is where you'll probably spend the most of your time working on your gem. It is common to have a folder inside this folder called whatever your gem is called (in this example, that would be <strong>helloworld</strong>), in which your app. is split into a few files, for organizations sake. And then have<strong> lib/&lt;gem name&gt;.rb </strong>require these files (as <strong>/lib/&lt;gem name&gt;.rb </strong>is what is required by Ruby whenever somebody requires your gem in their own project).</p>
<h4><strong>My 2 cents on organizing stuff in here <em>(skippable)</em></strong></h4>
As said, I am in no way an expert. But this is how I would do it.

<p>My first gem is a gem for a file storage service (<a href="http://anyhub.net/">Anyhub</a>) which should do two things:</p>

<ul>
	<li>Create a library for easy Ruby interaction with Anyhub</li>
	<li>Contain a small CLI for Anyhub based on it's own library</li>
</ul>

<p>So I figured I would have a module, containing a few classes:</p>

<ul>
	<li>Upload (for uploading files to Anyhub)</li>
	<li>Account (to manage ones Anyhub account)</li>
	<li>Runner (to manage the CLI)</li>
</ul>

<p>The Upload class would simply be able to use the account class, to check if an account was configured in a config file (f.e. <em>account_config.yaml</em>). If a config file was present, it would upload the file(s) specified in arguments to the script. Otherwise, it would return an error. Runner (the CLI) would respond to this error, allowing the user to type in his details so they could be used for the ongoing upload, as well as any following uploads (by saving the details to <em>account_config.yaml </em>via the Account class).</p>

<p>Now, I had made a perfectly good module. The only thing it needed was arguments send to Runner, which would activate it all. By doing a little research I figured if I created the directory <strong>bin/ </strong>and threw in a file here, this file would automatically be inserted into the installers own bin (f.e. <strong>/usr/bin</strong> on Linux if installed for all users). So I created the <strong>bin/</strong> directory, and a file in here called <strong><a href="http://github.com/Sirupsen/Anyhub/blob/master/bin/anyhub">anyhub</a></strong><strong> </strong>with a Ruby shebang at the top. This file simply instanced the Runner class with ARGV.</p>

<p>Now this is just my little not-so-fancy gem theory. It's not exactly done this way (yet) because Anyhub didn't have an API at first - so I created the first version without the Account class, so it might not be exactly like this at the Github repo. just yet.</p>

<a href="http://github.com/Sirupsen/Anyhub">Anyhub gem @ Github.</a>
<h3>LICENSE</h3>
<p>Simply a file which contains the license for your project. By default MIT with Jeweler.</p>

<h3>Rakefile</h3>
<p>Rake configuration for your project. It is here you can define rake tasks, and configure your project (in terms of the name of it, dependencies, description and similar).</p>

<h3>Readme.rdoc</h3>
<p>The Readme file for your project. If you create a Github repo. it'll show up there. It is also "the index" for your Gems' documentation.</p>

<h3>test/</h3>
<p>It is here you create your tests.</p>

<h2>Configuring your Gem</h2>
<p>Remember a few lines ago, I told you how you could configure your Gem via <strong>Rakefile</strong>? As you might have already guessed, we're going to open that very file now, to configure our example Gem.</p>

<p>After <strong>rubygems</strong> and <strong>rake </strong>has been required by <strong>Rakefile </strong>we see some fancy code, and then something which looks like some configuration. This is indeed where we configure our example Gem. You mostly only need to configure the summary and description the first time, I did it like this:</p>
<pre>begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "helloworld"
    gem.summary = %Q{I'm a helloworld gem! I like to hello the world.}
    gem.description = %Q{This is a fancy little test gem.}
    gem.email = "sirup@sirupsen.dk"
    gem.homepage = "http://github.com/Sirupsen/helloworld"
    gem.authors = ["Sirupsen"]
    gem.add_development_dependency "thoughtbot-shoulda", "&gt;= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/  20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install   jeweler"
end</pre>

<h3>A little something more on configuring</h3>
<p>.. which can be skipped.</p>

<p>If your gem has any dependencies, you can add them here. Dependencies in this context mean<em> "gems which my gem depends on"</em>. You <strong>should</strong> add them, because if you do they are automatically installed along with your Gem whenever somebody tries to install your Gem. If you don't, they'll just get a good ton of errors when they try using your gem.</p>

<p>Do add dependencies, simply add this to your <strong>Rakefile</strong>:</p>
<pre>gem.add_dependency "gem", "version"</pre>

<p>For example, in my gem I used the <strong>Curb </strong>Gem, and therefore I added this to my <strong>Rakefile</strong>:</p>
<pre>gem.add_dependency "curb", "&gt;= 0"</pre>
<p>(<strong>&gt;= 0</strong> just means "I don't care about which version of the Gem it is, as long as it's there", mostly because I couldn't find much version-specific documentation Curb, otherwise I would have done this properly.)</p>

<h2>Let's add some sample code</h2>
<p>Now it's time to add some code to our <strong>helloworld </strong>Gem. I simply open <strong>/lib/helloworld.rb</strong>, and add these few lines of code:</p>
<pre>module HelloWorld
  def self.do
    "Hello World from the all mighty helloworld Gem!"
  end
end</pre>

<p>So <strong>HelloWorld.do</strong> would return the string <em>"Hello World from the all mighty helloworld Gem!". </em>Great, so far, so good.</p>

<h2>Version</h2>
<p>In order to finish our Gem, we need a version file. Now because Jeweler is so awesome, we don't even need to use our editor to do this, simply execute the following command:</p>
<pre>$ rake version:write</pre>

<p>And the VERSION file is created. It's not <em>that</em> fancy though.</p>
<pre>$ cat VERSION
0.0.0</pre>

<p>But that seems correct. This is our first Gem build, so of course, the version is 0.0.0 as of now!</p>

<h2>Install it!</h2>
<p>Now you can install the Gem. It's very easy:</p>

<pre>$ rake install
Password:
(in /home/sirup/Code/Ruby/helloworld)
Generated: helloworld.gemspec
helloworld.gemspec is valid.
WARNING:  no rubyforge_project specified
  Successfully built RubyGem
  Name: helloworld
  Version: 0.0.0
  File: helloworld-0.0.0.gem
Executing "gem install ./pkg/helloworld-0.0.0.gem":
gem install ./pkg/helloworld-0.0.0.gem
Successfully installed helloworld-0.0.0
1 gem installed
Installing ri documentation for helloworld-0.0.0...
Updating class cache with 1983 classes...
Installing RDoc documentation for helloworld-0.0.0...</pre>

<h2>Moment of truth</h2>
<pre>irb --simple-prompt
&gt;&gt; require 'helloworld'
=&gt; true
&gt;&gt; HelloWorld.do
=&gt; "Hello World from the all mighty helloworld Gem!"</pre>

<p>(<strong>Note</strong>: If you are <strong>not</strong> using Ruby 1.9, you might need to <em>require 'rubygems'</em> before requiring <strong>helloworld</strong>)</p>

<p>Awesome, it works. I hope this has helped you towards creating your first gem. You are welcome to leave a comment, or contact me if you run into any trouble.</p>

<h2>Further information</h2>
<p>You'll find it all if you visit <a href="http://github.com/technicalpickles/jeweler">Jeweler at Github</a>. Below is for quick reference.</p>

<h3>Github</h3>
<p>I advice you to commit all your code, and push it to Github. Makes it easy for other people to view the source, post issues, and participate in your project.</p>

<p>Github because it's sort of the standard for Ruby open source projects.</p>

<h3>Releasing Gem at Gemcutter</h3>
<p>If you feel like sharing your Gem to the world (and you probably do). Register an account at <a href="http://rubygems.org/">Gemcutter</a>.</p>

<p>And now you are ready to release your Gem. Simply run:</p>
<pre>$  rake gemcutter:release</pre>

<p>To release your gem. (You can also release it at RubyForge instead if you wish so, see <a href="http://github.com/technicalpickles/jeweler/blob/master/README.markdown">the Jeweler readme</a>) You might be asked to sign in to your account, simply do so whenever prompted.</p>

<h3>Workflow</h3>
<p>.. taken directly from the <a href="http://wiki.github.com/technicalpickles/jeweler/workflow">Jeweler Wiki.</a></p>
<ol>
	<li><code>gem install jeweler</code></li>
	<li><a href="http://wiki.github.com/technicalpickles/jeweler/create-a-new-project">Create a new project</a> and customize it, or <a href="http://wiki.github.com/technicalpickles/jeweler/configure-an-existing-project">configure an existing project</a></li>
	<li>Write good code, and commit it</li>
	<li>Bump the version with one of the rake tasks:
<ul>
	<li><code>rake version:bump:patch</code> 1.5.3 → 1.5.4</li>
	<li><code>rake version:bump:minor</code> 1.5.3 → 1.6.0</li>
	<li><code>rake version:bump:major</code> 1.5.3 → 2.0.0</li>
	<li><code>rake version:write MAJOR=2 MINOR=3 PATCH=6</code> 1.5.3 → 2.3.6</li>
</ul>
</li>
	<li>Release it
<ul>
	<li><code>rake release</code></li>
	<li>Optionally release it to <a href="http://wiki.github.com/technicalpickles/jeweler/rubyforge">Rubyforge</a>: <code>rake rubyforge:release</code></li>
	<li>Optionally release it to <a href="http://wiki.github.com/technicalpickles/jeweler/gemcutter">Gemcutter</a>: <code>rake gemcutter:release</code></li>
</ul>
</li>
	<li>Go to #2</li>

</ol>


[jw]: http://github.com/technicalpickles/jeweler

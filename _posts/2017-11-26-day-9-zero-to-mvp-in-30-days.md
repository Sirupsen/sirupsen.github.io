---
layout: post
title: Day 9 - Zero to MVP in 30 Days - Torching some cash
---

<div class="intro">
  Hi there!

  If you’re new to this series, I laid down some ground rules <a href="https://hackernoon.com/day-0-zero-to-mvp-in-30-days-31c83db6aadf">in day zero</a>, and explain the idea for my first project <a href="https://hackernoon.com/day-1-zero-to-mvp-in-30-days-idea-number-1-18536868e282">on day one</a>. I document, a little every day, what I’m working on.
</div>

-------------

I’ve realized, especially with today’s update where I’m discussing torching some money on social advertising and Nginx boilerplate, that I sometimes throw a weird hodgepodge of stuff at you. I almost edited this post down to one topic, but I think this mix of random thoughts is the most honest representation of my day-to-day during this challenge.

So let’s get into it.

-------------

## Burning some cash, like the Joker but on a scale my wife won’t kick me out of bed for

First, let me lead up to *why* I’m burning a bit of cash on ad experiments. Today has been pretty lively for a Sunday:

* Chat on [bystander.io](http://bystander.io) is working. I’ve had **3** amazing live chats today with lovely people. Now this may not sound like much. But this is a B2B SaaS landing page that’s been live for less than 24 hours and has no advertising or backlinks other than those related to this little series.
* I have **7** new signups for the early access form on the landing page today. These exclude the few signups I’ve been able to battle for via cold outreach.
* Traffic to the landing page and stats to this blog continue to grow. While the stats for this series may not mean much in terms of validating Bystander, it sure does mean a lot to me and keeps me incredibly motivated (seriously, thank you to everyone reading and messaging me)

For those curious how this little series documenting my journey has grown on Medium from day zero:

![](/static/images/mvp_day9/image_0.png)

Now, back on topic the topic of throwing away some cash.

This budding interest in Bystander gives me the confidence to move a bit farther. A big goal over the next two days is setting up an option to preorder. Preordering will save businesses 50% over the period they purchase. I’ve never tried the preordering method of validation, and I’d like to see if we can make it work here.

My assumptions now, are, a business who makes the leap for a preorder is someone I’m in active communication with. I don’t expect a landing page alone to be able to convert someone into prepaying for a B2B SaaS solution. 

**So why ads?**

They’re a cheap way for me to test my copy and assumptions at a larger scale than I currently can organically. For trying to get folks to preorder I want to have the best copy and value proposition I can possibly have with my current resources and traffic.

Now, first time ad accounts usually offer bonuses that are quite generous for the scale were working with. I want to keep my spend below 200 dollars here. But LinkedIn, for example, will give you $50 credit to start with, taking advantage of this and similar bonuses stretches that small testing budget quite a bit farther.

Each campaign on both Facebook and LinkedIn **are both running 3 different ads**.

With each add set, I’m testing two different things:

1. My headlines & subheadlines

2. My audience’s by job title: user experience professionals VS. support leaders VS. project managers

Here’s an example LinkedIn ad for the User Experience camp:

![](/static/images/mvp_day9/image_1.png)

I don’t expect conversions in this small run at advertising. The scale of my spend is tiny, it’s my first go ad advertising Bystander, and my primary goal is to see if I can pin down a measurable difference on my audience and headlines to help focus my early efforts. 

Plus, I can’t learn about advertising by just reading, I need to just start. And at the very least, I’m spending a bit of money for your entertainment 😂

----------------------

## Going into some details and small changes in Bystander’s stack

Some folks have kindly expressed an interest in the stack I’m working with for [Bystander.io](bystander.io). I touched on this briefly [on day 2](https://hackernoon.com/day-2-zero-to-mvp-in-30-days-beginning-validation-and-app-buildout-c70dddcf2d44), but I thought it may interest some folks on a more detailed look at the stack and the tools I use on a daily basis.

I come from a front-end development background originally. But most recently spent time as a Senior Engineer in Customer Support. Support engineering is a strange beast, you get really wide knowledge on an unbelievable number of technologies and customer stacks. But it’s like exploring an ankle deep ocean of tech — you find things fast, in any setting, and fix them. You don’t generally have a need to further explore code (or the time!)

Going solo on a project, I mostly stick to what I know, and may toss *just one* new piece into the stack that I’m interested in trying or learning. You do have to stay interested and excited after all! The hours are long when you try something new.

I’ve made the mistake of trying to build a project with all the new cool things a few times before, and progress ends up so slow I lose motivation and abandon ship.

So! The stack for this [Bystander](https://bystander.io/)...

**Backend:**

* **Node** latest stable with **[Express](https://expressjs.com/)**.
* **MongoDB** with **[Mongoose](http://mongoosejs.com/)**
* **[Auth0](http://auth0.com/)** for authentication and access control, authentication is something that’s been solved a million times. But working on a solo project, authentication-as-a-service saves me a ton of time. And it let’s me be confident in an otherwise scary space. Their content team is top notch too, if any of that interests you, check out [their blog](https://auth0.com/blog/).

Express+Mongoose+Auth0 let me make APIs with protected endpoints incredibly fast.

**On the frontend:**

* **[Angular 5](https://angular.io/)**, which requires [Typescript](https://www.typescriptlang.org/). I find Typescript an absolute joy to work with. It’s a superset of JS that let’s you develop with JS as a strongly typed language. So, working with Angular in and IDE like [Webstorm](https://www.jetbrains.com/webstorm/) gives you typeahead on all the things and lets you catch compile errors.
* For a design and component framework, my original plan was to go with [Nebular](http://akveo.com/ngx-admin/#/pages/dashboard), but the screenshots I currently made available actually leverage a **[Bootstrap official theme](https://themes.getbootstrap.com/products/dashboard)**, with components I’ve already sliced down into Angular components/services for a previous project. I’m still tempted by Nebular as it feels more modern, but really, I need to double down and focus on function rather than form.
* The new (to me!) tech I’m playing with for this project is **Redux**, although in the form of **[NgRx](https://github.com/ngrx/platform)** (Angular’s flavor of Redux) NgRx/Redux put your application’s state into a single object. So you get some reallllyyy cool benefits when it comes to debugging. [This talk by Ngrx maintainers](https://www.youtube.com/watch?v=cyaAhXHhxgk) is worth a watch. Plus, even without having an interest in Redux or NgRx, this is the best format I’ve ever seen for two developers presenting a talk. Brandon and Mike did an awesome job on this.

**Hosting Related:**

* [Digital ocean](http://digitalocean.com/) droplets: one for marketing+blog, one for the app’s node instance. Scalability comes when I actually have customers.
* [Nginx](https://nginx.org/en/)
* [Cloudflare](https://www.cloudflare.com/). Cause it’s easy to use and their free services have a real impact.
* [MongoDB’s own database-as-a-service](https://www.mongodb.com/cloud/atlas) (Thanks to [a kind reader](https://medium.com/@DaveThe0nly/looking-at-mlab-pricing-have-you-considered-mongo-atlas-https-www-mongodb-com-cloud-atlas-c029f92ff980) for recommending them over MLab)

**Applications I use daily:**

* [Sublime Text](https://www.sublimetext.com/), still hard to beat once you get it set up with the plugins needed for your project. Although, because of Angular 5 I’m spending less time in there and more time in…
* [Webstorm](http://webstorm.com/)[ which I touched on earlier.](http://webstorm.com/)
* [iTerm2](https://www.iterm2.com/) makes it so your terminal is awesome. If you don’t already use iTerm2, I’d Google around a bit to see how other folks set it up. That will save you some time on getting the visual side going. I LOVE tabs and color coding so I can see where I have different services running locally:

![](/static/images/mvp_day9/image_2.png)

Red, Blue two different running stances of an app on different ports so I can test two branches live. Which are my active tabs where I actually need to work in the console.

* [Skitch](https://evernote.com/products/skitch) to take screenshots and annotate them for documenting this journey. It’s free and amazing.
* [LICEcap](https://www.cockos.com/licecap/) when I need to quickly record a Gif of part of my screen. Also free and super simple to use.
* My own Slack (free) workspace to pipe notifications and data to me. Checking different emails, chat messages from Bystander.io, keeping up with Tweets, and follows on medium... Pretty much anything I ever need to tab over to, to check any sort of notification, I just yank that into a slack channel to avoid distractions and save a ton of time. 

Plus I don’t have room for new tabs when I’m working:

![](/static/images/mvp_day9/image_3.png)

I know I need to close some tabs when the icons go away, or my laptop’s fan is giving me a headache

* Spotify to listen to weird stuff.

And I work until 11pm/midnight, so I keep Night Shift turned on, it definitely helps me. For any screen that isn’t iOS based, I use [Flux](https://justgetflux.com/) for the same purpose.

![](/static/images/mvp_day9/image_4.png)

And that’s about everything! What tools are essential in your workflow? Is there anything you use that might save me some time? ‘Cause I could certainly do with a bit more time!

----------------------

## Tomorrow, Day 10!

* Begin hooking up Stripe to add a pre-order option.
* Lots and lots of follow up. I need to touch base with new subscribers, folks I’m cold emailing, and the few people from live chat.
* More cold outreach (it never stops)
* Rollover from today’s list, to get Bystander’s Ghost blog into a template I like
* 5 million more things that Ican’tfitintotheday

Thanks for reading, this turned out quite long! And of course, feel free to email me with any questions or feedback! My email is on the sidebar. And I’ll see you all tomorrow!


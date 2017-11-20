---
layout: post
title: Day 2 - Zero to MVP in 30 Days - Beginning validation and app buildout
---

<div class="intro">
  Hi there!

  Today’s going to be on the shorter side as I’m still busy emailing folks. Also, I’d love to do a comprehensive post on my early validation attempts in a few days, after I’ve tried a few more channels. 
</div>

## The start of validation

I have three primary goals with this early stage of validation:

1.  Find which group of people have the best response rate
2.  Find which channel of sourcing these folks yields the best response rate
3.  Of course, find a real interest in my idea

#1 and #2 are to let me find one or two specific channels that work in terms of response rate, and double down in what works.

Yesterday, I mentioned there were 5 different groups of people I might sell this to. Today, I’ve focused my efforts on the two groups I assume will have the best response: **UX leadership/seniors and Product Managers**.

I hit my goal of reaching out to 10 targeted prospects, and even this small number turned out to be a great exercise in finding my audience. For the first few rounds, **I’ll be testing two different cold audience channels**:
**Leveraging Twitter search** (you can search for tweets containing images which is super handy in my case: _filter:image “error message”_) Using this, I found companies who were having a recent influx of customers pinging support with errors Bystander.io could help fix.
**Blog posts about error messages** This helped in solidifying who’s thinking about these user-facing error messages the most -- authors were exclusively UX folks. I followed this breadcrumb trail to see what business either the authors or interested commenters belonged to.

So for my cold outreach, I had a blog post to discuss or a real example use-case from their customers.

Here’s a pixelated view of my prospecting spreadsheet:

![](/static/images/03_Validation_Google_Sheets.png)

There’s better ways to track this, but at this early scale a Google doc will do just fine!

Tomorrow, now that I have the beginnings of a method to prospect these two channels, I’ll push out messages to another group of folks. And I’ll message 10 people in a new channel, to begin opening up testing response rates from different sources in parallel to these two.

-------------------------------------------------------------

## Scaffolding the actual app.

Yesterday I also mentioned I’d like to get a seed going for the app itself. A this point we want the pipes that can leveraged in any idea we might pivot into, so we scrap as little development time as possible if we kill this first idea.

I started out as a front end dev, and I’m most comfortable with JavaScript. So we’ll be going fullstack JS to make sure I can move fast, using technology I’m most familiar with (there is one exception, we’ll get to that!)

The (MEAN+extras) stack:

-  **Angular 5+** on the front end (a frontend that requires Typescript will be a nice help while we’re building)
-  **Bootstrap**: it looks like we’ll go with the [Nebular theme](https://github.com/akveo/nebular) as a starting point.
-  **Node** on the backend with **Express**
-  **MongoDB** + **mongoose** (hosted on MLabs for the free development tier while we hack things together)
-  **Auth0** for authentication, this will save a ton of time, and their technical content team is amazing.
-  Now, for the unfamiliar, something I’ve really wanted to put to use in a project is **Redux**. I know it’s only recommended for larger apps as there’s a lot of boilerplate and a bit of a learning curve. But, this inclusion is to sprinkle in a fun challenge. And the debugging options with a single source of state are awesome. We’ll use **NgRx**.


----------------------------------------------------------------

## Tomorrow, day 3! 

More validation, of course.

I think I’ll pull the trigger on [Product Hunt’s Ship](https://www.producthunt.com/ship). I don’t like putting up a full landing page until I have static mockups for screenshots, so I’d like to test Ship as a pre-official-landing-page solution.

I’ll set up my authentication service in Angular to wire up [Auth0](https://auth0.com/), using some of [Kim Maida’s awesome posts](https://auth0.com/blog/real-world-angular-series-part-1/) to help speed this along.

And I’ll try to fix my woodstove, ‘cause it’s cold in here.

As always if you have any feedback or want to chat my email is on the sidebar :-) Thanks for reading!




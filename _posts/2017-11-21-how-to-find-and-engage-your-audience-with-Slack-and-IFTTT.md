---
layout: post
title: How to find and engage your audience with Slack and IFTTT
---

<div class="intro">
  Building a minimum viable audience to pair with your minimum viable product is one strategy to help stack the product launch cards in your favor.
</div>

In the “Zero to MVP in 30 Days” challenge I’m currently working on, I’m also starting with an audience of zero. Finding my audience and building rapport is a high priority.

But my time is precious during this challenge. And tabbing over to Hacker News, Reddit, Quora, and other communities my target audience may belong to, to find discussions I can jump in on definitely distracts me from other work that needs to get done.

With that in mind, I took a bit of time to set up an automatic stream of curated content to a Slack channel, all for free. Saving me a ton of time, and I hope to pass that saved time onto you.

Our goal in this post is for you to have a slack channel resembling:

![](/static/images/curation/Blog_Post_content-curation_bystander_Slack.png)

**In this post we’ll look at setting up content streams from these kinds of channels:**

* New content with your preferred keywords from sources that have RSS feeds like Reddit, StackOverflow, and articles on Indie Hackers.
* New content or comments containing keywords from Hacker News using some community built tools
* Creating an RSS feed for a site that doesn’t provide a feed, to grab new content that we wouldn’t otherwise be able to subscribe to, like Quora.
* Twitter searches
* Using Google Alerts to create more opportunities, like finding blogs accepting guest posts in your niche

**Pre requisites:**

* A [free slack workspace](https://slack.com/create#email) or existing workspace
* Create a channel in Slack to pipe this feed of content to
* A [IFTTT](https://ifttt.com) account (**IF** **T**his **T**hen **T**hat is also free)

----------------------------------------------------------

## Pages that already have RSS feeds

The first thing we’ll want to do for any source you’re interested in tracking is check to see if they already provide an RSS feed we can tap into. 

There are [browser extensions](https://chrome.google.com/webstore/detail/rss-subscription-extensio/nlbjncdgjeocebhnmkbbbdekmmmcbfjd/related?hl=en) that can display if a page you’re currently viewing has a feed. I opt to just inspect the page’s source and Cmd+F for ".xml" as we’ll see shortly.

**Let’s use Indie Hackers articles as an example:**

Indie Hackers is a source that gives us an official RSS feed to work with. For me, Indie Hackers is a great place to find folks who are doing something similar to my Zero to MVP in 30 Days challenge, and the volume of posts isn’t overbearing so I’d like to pipe in all their new articles.

Let’s go to Indie Hackers and look at Courtland’s source code:

![](/static/images/curation/Blog_Post_content-curation_Rss_IH_1.png)

And find the link to the feed he provides there:

![](/static/images/curation/Blog_Post_content-curation_Rss_IH_2.png)

Great! Now let’s head to [IFTTT’s page to create a new applet](https://ifttt.com/create), and select "RSS" as the “this” (the trigger) of the applet.

![](/static/images/curation/04_bonus_curate_gif_01.gif)

Here we can choose to either trigger the applet for all new items from the feed, or only new feed items that contain a certain phrase. We’re going with all updates for this first example.

Let’s paste in the Indie Hacker’s feed and move on to select Post to Slack as the "that" of our new applet.

![](/static/images/curation/04_bonus_curate_gif_02.gif)

On this screen we can clean up how the content is being fed to Slack. Here’s the changes I make, but definitely experiment to see what works for you! And click on "Add ingredient" to see what other data from the RSS feed is available to you.

![](/static/images/curation/Blog_Post_content-curation_Rss_IH_4.png)

Here’s how that comes out in a Slack notification:

![](/static/images/curation/Blog_Post_content-curation_Rss_IH_5.png)

On the final step: enter in a better name than the default to help us find things later. You’ll likely end up with a lot of applets, and using better names now will help you find them later as you edit them to fine tune keywords and sources.

![](/static/images/curation/Blog_Post_content-curation_Rss_IH_6.png)

Some sources that have RSS feeds are a firehouse. StackOverflow and other Stackexchange communities are a good example of this. Let’s look a finding an RSS feed for a specific topic on Stackoverflow to help make sure we only get content we’re interested in.

Google is our friend here, if we’re looking to get content out of a large site, chances are [someone else has already tried solving this problem](https://meta.stackexchange.com/questions/5857/rss-feed-for-searches). Shoot! It looks like getting a feed for searches is out. But we can use tags! 

They have a tag called "[custom-error-pages](https://stackoverflow.com/questions/tagged/custom-error-pages)" that looks like something I might want to follow for my audience. The link to their RSS feed hides at the bottom of their pages:

![](/static/images/curation/Blog_Post_content-curation_Rss_IH_7.png)

We can grab that, and repeat the steps we used for the Indie Hackers feed.

Rinse and repeat these steps for any source you’re interested that has a feed available. Don’t forget IFTTT’s Keyword RSS option, if a source has content for or by your audience, but it’s a bit too broad, you can use keywords to further filter the RSS feeds. 

And [check to see if there’s a Stackexchange for your audience](https://stackexchange.com/sites) specifically. 

------------------------

## Hacker News

I’m going to leverage HN as an example source of a firehouse that doesn’t have feeds available, but does have solutions built by the community.

[HNRSS](https://edavis.github.io/hnrss/) is one such tool that popped up in my Google search. And they let us set up feeds for both **new posts and new comments** (and to further filter those by keyword if we like)

I recommend hitting Hacker News and testing some exact search phrases to see what will bring in results relevant to you. HN search works like most search, wrapping a search term in double quotes will limit your search exact phrase matches. (Try searching **"Ask HN" books** as an example, this will bring up all the Ask HN threads that are about books)

And while testing your search terms, don’t forget to sort your results by date to see what the new content looks like for your term, not just the popular content.

Once you’ve found some terms that are pulling in the result you want, use a tool like HNRSS to create RSS feeds for those terms and wire up your IFTTT applets similar to the method used for Indie Hackers feeds.

![](/static/images/curation/Blog_Post_content-curation_Rss_IH_8.png)

-----------------

## But I have a source and there’s no RSS feed, and no community tools!

Then we’ll just need to slice and dice that page to create our own RSS feed! This will require working with HTML, and [we’ll use Feed43 to create our own feeds for free](http://feed43.com/)!

Let’s use Indie Hacker’s Forum posts as our example. Indie Hackers RSS feed only covers articles, but I want to monitor and jump in on new forum posts too.

As a primer, [this tutorial](http://feed43.com/understanding-patterns.html) and also [this tutorial](http://feed43.com/step-by-step.html) from Feed43 will help illustrate how we’re picking apart a page.

The first thing we need to do is get the Indie Hackers Forum loaded up on Feed43, go ahead and click "Create your own feed" on their homepage and pull the Indie Hackers forum in:

![](/static/images/curation/Blog_Post_content-curation_Rss_IH_9.png)

Now we need to find the closest container on the page that hold our future RSS feed’s items. So in this case we’re after the container that houses individual threads. Reading a 100 kilobytes in a textarea on Feed43’s site isn’t ideal though. So let’s inspect a forum post’s element right on the Indie Hackers page to find the necessary container element:

![](/static/images/curation/Blog_Post_content-curation_Rss_IH_10.png)

And next we’ll want to expand on of the individual threads so we can format our search pattern based on the hierarchy. Our goal is to pull out the URL, the title of the post, and the author.

![](/static/images/curation/Blog_Post_content-curation_Rss_IH_11.png)

Each **{{ "{%"}}}** tells Feed43 we want this piece, and each **`{*}`** tell Feed43 to "skip until the next character in your query". 

So we find the individual thread’s container in #1 (the red part) then add a **`{*}`** to tell Feed43 to skip until we get to the first piece of information we want. That first piece is the href in the anchor element (the link to a thread) and the **{{ "{%"}}}** between the href’s double quotes says "we want the contents that would normally be here to be a part of our feed."

Then we use another **`{*}`** To skip until we get to the next part, the thread’s title, and so on.

Here’s how that will look in Feed43:

![](/static/images/curation/Blog_Post_content-curation_Rss_IH_12.png)

We can test how our part looks by hitting the "extract" button. I suggest, as you build your own feeds, to test each part as you go. Building up pieces of data you want one at a time and hitting “Extract” will help you troubleshoot as you go to make sure you end up pulling out the correct data.

Each {{ "{%"}}} tag we use in the search query will be assigned a number and can be used when creating the feed. So the link (from the {{ "{%"}}} place in the href attribute) will be available as {{ "{%1"}}} and the title of a post will be {{ "{%2"}}} while the author is {{ "{%3"}}}

Letting us format our feed like like:

![](/static/images/curation/Blog_Post_content-curation_Rss_IH_13.png)

If it all looks good (you can [view my feed we just created here](http://feed43.com/0217338220276521.xml) if you like) then we can run through our IFTTT steps from earlier to get our new feed piped into our Slack channel. 

And we can now turn most any site we want into a source to feed our Slack channel, and if we need just certain keywords from a site like this, where we create our own RSS feed, don’t forget IFTTT’s RSS trigger has an option to only trigger if a feed contains a certain phrase.

----------------------

## Want to pull in Tweets too?

Twitter has their own set of triggers for IFTTT. Of most interest to us is probably [the search trigger](https://ifttt.com/create/if-new-tweet-from-search?sid=2), to pull in Tweets from a specific search.

I’d recommend pulling up [Twitter’s documentation on advanced search](https://support.twitter.com/articles/71577), their section on refining can be combined refine a search to your needs. And test out a pile of queries on Twitter’s home page until you get narrow results that suit you. 

For example, searching just "error messages" is a freakin’ firehouse. But if I search for [filter:images “error message”](https://twitter.com/search?src=typd&q=filter%3Aimages%20%E2%80%9Cerror%20message%E2%80%9D) to only grab Tweets that have an image (hopefully of an error I can chase down) and the exact phrase “error message” I get much better results.

Once you find terms you like, pipe them to our channel with a new IFTTT applet, using Twitter’s triggers instead of the RSS triggers we’ve been using.

--------------------

## Google Alerts for creative stuff

With [Google Alerts](https://www.google.com/alerts) we can set up RSS feeds to do things like: 

* Find guest blogging opportunities in our niche
* Monitor the blogs Google indexes for new posts/pages filtered your Alert’s search term
* Create an alert for your side project’s or company’s name to act on
* And a bunch more things. If you Google "how to use Google alerts" you’ll find a ton of ideas to work from.

The alerts are straightforward, you can create an alert using any search term you would punch into Google.

Looking for new guest post opportunities in "user experience" would look like:

![](/static/images/curation/Blog_Post_content-curation_Rss_IH_14.png)

Then we just grab the RSS feed Google gives us for the alert (set this in the "deliver to" option pictured in the screenshot) and run through our usual IFTTT steps.

----------------------

## Wrapping up

Whew! That ran long. So, since we’re mostly leveraging RSS (with Twitter being the exception) why don’t I just use an RSS reader?

* I like IFTTT’s ability to filtering incoming feed items by keyword
* I’m never in a feed reader any more, but I do keep Slack open
* IFTTT lets us format incoming feeds to all be in a similar format we can easily digest: source name, item title, item link, and item author
* It sounds silly but **using emojis on the slack comments like a checkmark to indicate I commented on an item**, or an "X" emoji to indicate I want to prune that keyword source to exclude that kind of post, really helps pull this together

If you set this up, I hope it saves you a bunch of time by not needing to check on a pile of sites and blogs, and made you more productive by removing an excuse to spend time on your favorite sites instead of working on your thing.

Should you run into a source you’re having trouble getting to work, drop me a message, I’m happy to take a look.

And as a shameless plug, I wrote this up as a side effect from [my "Zero to MVP in 30 Days" challenge](http://matthewodette.com/day-2-zero-to-mvp-in-30-days-copy), where I’m blogging every single day. If that sounds interesting come have a look!

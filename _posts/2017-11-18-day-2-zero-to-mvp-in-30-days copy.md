---
layout: post
title: Day 1 - Zero to MVP in 30 Days: Idea number 1 
---

<div class="intro">
  For the first idea, I’ll be going with the “scratch your own itch” approach. In my last role as Senior Support Engineer, a pattern that came up over and over again was: toasts, those popup error boxes, causing customers frustration and confusion.
</div>

Customers would write in, often with screenshots of the same error. And the support team would try to find a workaround, letting our customers move past the error. To see what this looks like, go search Twitter for “Error Message” -- it’s a constant stream of folks pinging support. 

These repeated support touches are reducing lifetime customer value (the more they talk to support, the more they cost you in support hours), can contribute to or cause churn, and can even eat up a bit of engineering time when your support team makes duplicate or unnecessary issues.

Now. There are a lot of tools for logging scripting errors, whether they’re clientside or serverside. **But tracking the visual errors that we author ourselves and present our users is a different story.**

I present to you idea number one: **Bystander.io a tool to track visual user-facing errors, how much they’re costing you, and a framework with the accompanying analytics to reduce the cost those errors.**

-------------------------------------------------------------

## Some use cases? Sure!

I was going to run off to Twitter or Google to look for examples of poor error experiences that would see an immediate benefit from this service. But as luck would have it, today I ran into a few perfect cases setting up DNS records and some other accounts.

_For these examples I’m not picking on anyone in particular, but using timely and real examples I came across. We’ve all seen similar errors in services we use every day._

### Namecheap - Example use-case 1:

Setting up DNS records in Namecheap, I ran into this goodie: 
_(note: removing the trailing period in the records was just to recreate the error for screen capture)_

![](/static/images/01_namecheap_error.gif)

So, where does our app come into play here? Bystander.io would detect and alert you on an uptick in this blank error displaying to your customers.. With the library active, you’d be able to replay the user’s session, similar to what you see in the gif. This would let you see exactly what the customer is experiencing and how they’re trying to get around the issue.

Then looking at the accompanying logs, your team could see we’re trying to update records with an expired authentication token.

With that, you could have your team push out a change to instead display a module explaining the session has expired and send them to the login page for reauthentication.

### IFTTT - Example use-case 2:

I was trying to go back to edit the settings on an If This Then That applet. But, my simple change was not saving for some reason. (More on what these IFTTT’s are for in tomorrow's post!)

![](/static/images/01_Error_on_IFTTT.gif)

With this it turns out we had a nice error message created for us. But it was hidden above the fold with no indication that I had an alert to help me fix the issue… Actually at first I wasn’t sure there was an issue.

How could Bystander.io help? A few different ways, we could detect that the user is clicking save multiple times, **and we can detect that the only error message element loaded outside of the user’s viewport**. How cool is that?

How might your team solve this? Shake the save button, disable it, and use a message near the submit button to let us know we need to fix and issues pointed out in the form above.

----------------------------------------------------------------

Awesome. But I’ll need my potential customers to get their engineering teams to buy-in, adding a new tool is more work for them, right?

## Let's see some sort of proof of concept

My bare bones proof of technical concept for the Bystander.io library teams need to install on their site.

**Initial requirements for the library:**

-  Be so simple to install, a copy and paster could get it done. **Check.**
-  Track when the customers desired visual elements (alert boxes, form errors, etc) exist in the dom. **Check.** [MutationObserver’s](https://developer.mozilla.org/en-US/docs/Web/API/MutationObserver) are cool.
-  Track when those target elements are actually in the user’s viewport. **Check.** [IntersectionObserver’s](https://developer.mozilla.org/en-US/docs/Web/API/Intersection_Observer_API) are cool.
-  If desired, record all dom changes and keys/clicks to replay the user’s session and see if/how they solved the error, contacted support, or abandoned their task.
-  If desired record, all console errors and network requests for the full picture.

Let’s see that. Note: this library will be invisible to the user, **it’s just to record and pipe the sessions and data we need to help you recover value from your errors**.

![](/static/images/03_Bystander_library_demo.gif)

We initiate the library here with an array of CSS selectors that target our app’s specific error containers.

As a target element is added to the dom or revealed to the user after being hidden, we record the session and data. We’ll use our IntersectionObserver to make sure we aren’t repeating full recording of issues the user moves in and view.

And that’s the rough start of Bystander.io’s library! We can make it work technically, which was the goal of this exercise.

----------------------------------------------------------------

## Now to look towards validation.

**The benefit assumptions we’ll explore and use for validation:**

-  Reduce the number of touches to support caused by your user-facing errors. Saving your team money by reducing support hours.
-  Reduce strain on users caused by error messages, looking to have a reduction in churn and maintain or even improve customer happiness.
-  Save some engineering time in the form of less duplicate or unnecessary bug reports created from your support team.

The who:

Initially, I suspect targeting SaaS companies with over some number of employees (40?) and over a certain age (>1 year?) will be the best use of my time. The team needs to be large enough, and the app old enough, that they could realize the benefits from this kind of error tracking in a short amount of time.

One thing that’s tripping me up though, and I’ll need to test by reaching out to folks: who is our most likely entry point to a buyer in an organization?

1.  **Support leaders?** They’re close to the itch here, and should have a pulse on how much friction user-facing errors might be causing their organization.
2.  **UX members?** They may have an active interest in seeing how users actually operate when they run into their errors. And desire a tools to analyze and improve that interaction.
3.  **Project Managers?** It’s easy to punch a search into Twitter and see a ton of folks writing in about error messages. Maybe reaching out to relevant PMs within organizations could work?
4.  **Engineering?** My instinct is to rule them out, but I should test the waters all the same. They already have a list of things they need to ship and a list of issues to fix. As long as an error message is being display to the user, and the error isn’t crashing the app for the user, they might not have interest in further analytics right away?
5.  **Managers/Founders?** I think this could work on the smaller side of my target customer, but not for larger orgs unless I can find someone who has publicly expressed a need/interest.

Who should I prioritize here?

----------------------------------------------------------------

## Tomorrow, day 2.

Whew! That ran long and I do (so far!) need to rush these posts out the door, so I might make an edit or two when I get a fresh set of eyes on this.

For tomorrow, we’ll actually find and message some people to start our validation journey. **The plan is to message 10 potential customers tomorrow**. Ten may sound a bit low, but I’ll be leveraging some of that time to fine tune me sources or where to find potential customers and begin to layout a repeatable to scale up validation attempts.

**I’ll also look towards scaffolding the tech for the actual app side of things**. Now, we’re going into this knowing we could kill this idea quickly. This scaffolding will be the boring stuff needed for any app we land on: auth, user roles, front end framework/libraries, etc.

If you work at a SaaS company or have a project with users running into errors, how does this idea sound to you? Definitely happy to chat, my email is on the sidebar.

Thanks for reading!




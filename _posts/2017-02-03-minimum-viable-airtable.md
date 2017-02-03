---
layout: post
title: Minimum Viable Airtable
---

In [How I Use Airtable](http://sirupsen.com/airtable/) I described some of my
Airtables. In this post, I'd like to talk about how I think about Airtable vs.
Spreadsheets vs. Apps. Often I'm asked why Google Sheets isn't adequate. The
answer is that it is, but in the same way that you can build a house given only
nails, wood, and a hammer. Airtable gives you screws, cement, brick, and most
other tools to build a 21st century home.

When I want to organize data, which at the end of the day what most applications
do, that data is uniquely mine. An app will impose someone else's idiosyncrasies
on my data. Countless apps for shopping lists exist, but they own my data and
dictate how I will be using it. I can't evolve a system that works uniquely
for me from it. I religiously believe in [Gall's law](https://en.wikipedia.org/wiki/John_Gall_(author)#Gall.27s_law) that any
complex, working system _has_ to evolve from a simple system that works. I think
that Airtable provides a unique opportunity for anyone to create their own
unique systems. It's no longer just for people who can code.

While you may have the ambition to turn your idea into a full-blown app, that
takes hours, days or weeks. Creating an Airtable for your first prototype to get
intimate with the data and get something out there takes minutes. Some systems
just don't deserve the time investment of a full-blown app up front. Worse, good
ideas never get started because the upfront cost is high. That's why today any
personal system I build starts as an Airtable. I follow this 4-phase system when
prototyping with Airtable, starting with the Minimum Viable Airtable:

## Phase 1: Minimum Viable Airtable

As an example, I organize books recommended by friends. While Goodreads has the
functionality to save books with a `to-read` label, it doesn't allow me to
capture people's personal recommendations, which at the end of the day is what
matters most to the next book I end up reading. Instead of not solving the
problem or spending hours building an app disconnected from all other tools I
use, I built a simple Airtable in 10 minutes to keep track of books and their
recommendations:

<iframe class="airtable-embed"
src="https://airtable.com/embed/shrCBVNb1yS0KXS2E?backgroundColor=gray&viewControls=on"
frameborder="0" onmousewheel="" width="100%" height="533" style="background:
transparent; border: 1px solid #ccc;"></iframe>

This is already valuable by itself. I can share this with friends; I could even
create an Airtable Survey for people to enter in their recommendations and share
the view publicly. That's a stellar prototype. At this point in the process,
there's nothing fancy going on at all. It's a pure and simple Airtable. If I
find enough value to iterate further into phase 2, I might. Most of my bases
remain and thrive in phase 1.

## Phase 2: Airtable with Integrations

If you're spending a lot of time in your Airtable doing things that could be
automated, it might be time to add some integrations.
[Zapier](https://zapier.com/) allows a stunning amount of automation with email,
Slack, Evernote, or just about any other application you can think of. An
example might be that you'd like to announce to a Slack channel (or email) when
a lead in your table converts into a customer to congratulate the sales team! Or
perhaps you integrate with a dashboard application to create graphs and
dashboards from your Airtable data. This is the time to explore what other
applications can do with your data. You can focus on automation and business
logic, not how to present and modify the data. Presenting and modifying the data
is often the most time-consuming part in an app's infancy. 

If you're a developer(or know someone), you can use the [Airtable
API](https://airtable.com/api) to write your integrations. As described in [How
I Use Airtable](http://sirupsen.com/airtable/) I've written integrations to
create [flash cards from Airtable
records](https://github.com/sirupsen/anki-airtable) and automate my tea-brewing
process. I wrote an [API client for Ruby](https://github.com/sirupsen/airrecord)
to make this as easy as possible. My favorite integration is a script that
imports single-word Kindle highlights into Airtable to learn the words, later
converted into flash cards.

The beauty is that any time invested in this automation you can leverage for
other Airtables. My flash-card integration started as useful for one Airtable,
but now I have about five using it. As more of your tables move to this phase,
Airtable is becoming a razor sharp tool to solve an extremely broad array of
problems.

In this phase, you're building simple automation on top of the Airtable created
in Phase 1. The time investment in the system is still small at this point, but
you're still getting a lot of value.

## Phase 3: Almost-App, Heavy Integrations, Airtable Backend

This step is the awkwardly beautiful phase in between a full-blown application
and something scrappy in Airtable. With the investments made in (1) and (2)
you're a master of your data, the domain, and the schema. You should already
have developed opinions about the optimum way of organizing your data. 

Airtable is your backend; you're essentially treating it like any other
database. You're still using Airtable to get a view of your data and do some
administrative duties, but some of this has been taken over by a customly
written frontend or integrations. You might be the only person knowing Airtable
backs it, showing other people a custom frontend supported by Airtable. This is
the stage where you've found enough value in your Airtable to consider paying
someone to help you write integrations.

Airtable is still providing value at this stage because you don't have to move
your data, you're still prototyping, and you get an admin area for free by
signing into Airtable. 

## Phase 4: Bye Airtable! I'm building an app!

If you reach this stage, congratulations. Your prototype has evolved all the way
from Airtable to a full-blown application. Airtable taught you about the schema
of your data and justified your time investment to make it from (2) to (4),
making it easy to lounge from silly idea to scrappy execution. The layout of the
data makes it easy to migrate from (3) to (4). Your idea is now validated to the
point where you've decided to make it into an app. You migrate the data to your
own database for maximum power and start building your app. A well-executed
domain-specific application will beat an Airtable in many cases (if the system
aligns with your own habits, otherwise a personal Airtable might beat it, as
described in the intro). That's why Airtable hasn't replaced every application
on my phone that deals with structuring of data, such as tracking weightlifting.

What started for you as an Airtable of Kindle highlights has turned into a
multi-national vocabulary enhancing empire as you strengthen the vocabulary of
10,000s of people. What started as a book endorsement Airtable 6 months ago you
made in 10 minutes has progressed to the world's most prestiogious ranking of
books about spirit animals (you found an unexpected niche). On the contrary, you
found out that the world is not ready for the Airtable you built for optimizing
five features of tea-brewing for perfection—but it's working amazingly for you
(and for your friends to tease you about), sitting patiently in phase 2.

Airtable has made you a millionaire, and this blog post has inspired you to
participate in the MINIMUM VIABLE AIRTABLE (MVA) movement. You've become a
vociferous advocate, endorsing Airtable left and right (even more than in phase
(2)).

Let's return back to the Spreadsheet problem raised in the introduction. Why not
use spreadsheets? Spreadsheets are great, especially if you're dealing with a
massive amount of numbers and awkward data layouts. However, if your spreadsheet
is well-structured, it inherently follows a relational model which Airtable
enforces directly. Spreadsheets work well for (1), but they don't work with (2)
and (3) because Google Sheets' API is horrendous to work with. Airtable shines
through all 4 stages. Airtable's API models the data in a way that's identical
to how a relational databases work. Something most developers will recognize,
unlike Sheet's cell-driven API. It makes the transition from (3) to (4) much
more seamless. It makes writing integrations easier because all Airtables follow
a structured design by default.

Additionally, Airtable has a beautiful user interface that it makes it easy to
model your data correctly, the same way you would in a relational database. The
recruiting team used Airtable to track hires for a while, and it was impressive
to see the lengths they went to to clean up and structure the data. Great tools
inspire great work.

---
date: "2016-11-20T00:00:00Z"
title: How I use Airtable
---

My favorite new app of the year is [Airtable](http://airtable.com/). It
complements [Workflowy](https://workflowy.com/) well, which I use for
unstructured notes. Airtable is for anything where structure is starting to form
in these otherwise unstructured lists in Workflowy.

I think of Airtable as a relational database for my personal data. It has a
fantastic user-interface, which means that I can focus on creating schemas that
make sense. When writing integrations I can focus solely on the business logic,
knowing that the Airtable interface will mostly work. Most applications deserve
to start as a simple spreadsheet before evolving into a domain-specific thing.
Airtable excels at this. I call this "Minimum Viable Airtable", I wrote more
about this in [this post](http://sirupsen.com/minimum-viable-airtable/).

I often get asked how I use Airtable, and why I'm so excited about it--I don't
always have the opportunity to do my full Airtable spiel. This post exists for
those times when I didn't have the chance to walk you through my bases in person
in an overly enthusiastic tone.

Another thing to note is that for each one of my use-cases there's very likely a
full-blown, domain-specific application out there that does it better. However,
each one of those tables I get to control the complexity and can gradually
increase it. Most domain-specific applications start out way too complex.

> A complex system that works is invariably found to have evolved from a simple
> system that worked. A complex system designed from scratch never works and
> cannot be patched up to make it work. You have to start over with a working
> simple system. – John Gall

For example for my shopping list base, currently it's not at a state where it
does anything fancy like auto recommendations. However, all the data is there to
do that at a later date. If I write a simple algorithm myself rather than a
full-blown machine-learning crazy and unpredictable AI like for my tea base, I
think it will be much more useful.

This is key about building Airtables and applications in general. Start with
the simplest possible thing that brings value, then slowly increase complexity
as you get comfortable with the domain.

## Books

This is a simple base I use to track books and who's endorsed them. It helps me
decide which book to read next. When I hear recommendations of books I'll note
it down here to guide my next decision. Whenever I enter a new book, it
automatically populates it with metadata from Goodreads.

![](/static/images/airtable/books.gif)

## Tea

[The base](https://airtable.com/shr766dr8JhU0jumT) first of all has a list of
all the teas I've bought:

![](/static/images/airtable/teas.png)

This serves as a starting point with price, type, picture and vendor. If you
click on each record, you'll see more details. This Base started as just a table
of all my teas and my rating of them. Later, following Gall's law, I introduced
the complexity of periodically recording brews of teas:

![](/static/images/airtable/brews.png)

Later I wrote an integration with the Airtable API that'd automatically suggest
how to brew a tea when entering it in, learning from the previous brews. Most of
the time this happens on the Airtable app. I add the new record when I brew the
tea in my kitchen, and then it'll suggest how to brew it:

![](/static/images/airtable/tea.gif)

Later I even added an integration that will send me a push notification on my
phone when the tea is done brewing based on the offset between the "Time" column
and when the record was created.

![](/static/images/airtable/notification.PNG)

## Words

Every time I highlight a word on my Kindle I have a script on my server that'll
automatically put it into an Airtable, find the root of the word, de-dup and
upload the pronunciation of the word.

![](/static/images/airtable/kindle.png)
![](/static/images/airtable/words.png)

Once in a while (when [my Chrome
extension](https://github.com/Sirupsen/tivitybalancer) tells me to) I'll go and
learn some of these words, write example sentences, add images and definitions.

![](/static/images/airtable/learning.png)

When I first created this and started learning words at random and tried to put
them to practise I often got odd looks as I had learned words that no-one uses.
I set out to solve that by devising a score for each word on how common it is,
which is what you see in the table. I'll always learn more common words I don't
know first. Many of the words in this table are in my passive vocabulary (I know
them when I see them), but not in my active vocabulary (I don't use them
myself). I use this table to attempt to move them into my active vocabulary.

However, as anyone who's learned another language knows, seeing a word once is
not enough. You need to see it more than once. You need to start using it. For
that, flash cards are excellent. I use [Anki](http://ankisrs.net/) personally,
and review it religiously every morning on a variety of subjects (topic for
another post). To learn these words better, I built an [Anki extension to sync
with Airtable](http://github.com/sirupsen/anki-airtable). Every time I populate
a new word, it'll automatically create flash cards to help push the word into
long-term memory.

![](/static/images/airtable/flash_card.gif)

You may notice the "Uses" column above. I wrote a Chrome extension that'll
increment the amount of times I've used a word by one if I ever use it in my
browser.

![](/static/images/airtable/words_ext.gif)

This is to encourage me to use new words more, next step to improve this is to
figure out how to use the data on word usage to push me to use words more.

## Produce

The Produce Airtable lists produce and when it's in season in Ottawa, Ontario
where I live.

<iframe class="airtable-embed" src="https://airtable.com/embed/shrEvBABjhDXCOkMe?backgroundColor=pink&viewControls=on" frameborder="0" onmousewheel="" width="100%" height="533" style="background: transparent; border: 1px solid #ccc;"></iframe>

Of course, this Airtable also automatically generates flash cards like the Words
base. This means I know all the seasons for produce in my area by heart, and
where in the world they originate from. The former is helpful to guide my
cooking by season, and the latter to get inspiration for which cuisines from
around the world a certain ingredient is endemic to. E.g. Swiss chard originates
in the Mediterranean, so looking for Italian recipes may yield better results
than venturing into Japanese cooking. On the contrary, eggplant originates in
Asia so looking to Asia for inspiration in cooking it may be a great idea. I
wrote more about this in [another
post](http://sirupsen.com/season-driven-cooking/).

## Around the World Cuisine

With a couple of friends we have a potluck dinner every couple of months from a
random country. We go to the website [random.coutry](http://random.country/) and
then everyone has to bring a dish from that country. We've been through quite a
few countries such as Hong Kong, Bangladesh, Greece, and Brazil. I've started
tracking some of these and other countries I've done independently in an Airtable.

![](/static/images/airtable/around_the_world.png)

The goal is to have cooked a dish from most countries that I wouldn't be
embarrassed to serve to someone from that country. Luckily, working at Shopify I
have access to people from all over the world to try cooking food for. I've
brought Ghormeh Sabzi to an Iranian at work, and Feijoada to Brazilians. It's an
excellent way to get exposed to new cooking techniques and countries, and of
course Airtable is an excellent way of tracking them. It'll be even better when
they have a view that shows records on a map one day.

## Shopping

I use this base to track what I need to buy. It's a running list of mostly
groceries. Each item is linked to a meta-item which has relations to what that
particular item costs in various stores. I track the price of the most common
items I buy in the stores I visit the most. This allows me to use a rollup field
to show the prices in various stores in the overview. The `O`, or `L` indicate
whether the product is **o**rganic or **l**ocal.

![](/static/images/airtable/groceries.png)
![](/static/images/airtable/vendors.png)

Because I track when certain items are purchased, I'm planning to investigate
this data at a later date to see what I buy the most, where and perhaps play
with automating the population of those lists.


## Nature

I don't really know anything about trees or flowers. When everyone started
playing Pokemon Go, I started walking around taking pictures of plants, flowers
and trees I didn't know. I went home to find out what they were, and then
automatically generated flash cards with the extension mentioned earlier.

![](/static/images/airtable/flowers.png)
![](/static/images/airtable/trees.png)

This has greatly improved the amount of trees and flowers I know. You can see
the full base [here](https://airtable.com/shrGYC5sNPLqD49fp).

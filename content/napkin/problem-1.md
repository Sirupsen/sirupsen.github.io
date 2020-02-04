---
date: 2019-10-19T00:00:00Z
title: Napkin Problem 1
---

Napkin friends around the world: it's time for your very first system' estimation problem! Confused why you're receiving this email? Likely you [attended my talk at SRECON 19](https://www.usenix.org/conference/srecon19emea), where I said that I'd start a newsletter with occasional problems to practise your back-of-the-envelope computer calculation skills--if enough of you subscribed! Enough of you did, so here we are!  
  
**Problem #1: How much will the storage of logs cost for a standard, monolithic 100,000 RPS web application?**  
  
Reply to this email with your answer and how you arrived there. Then I'll send you mine.  
  
**Hints**  
  
You can find many numbers you might need on [sirupsen/base-rates.](https://github.com/sirupsen/base-rates) If you don't, consider submitting a PR! I hope for that repo to grow to be the canonical source for system's napkin math.   
  
Don't overcomplicate the solution by including e.g. CDN logs, slow query logs, etc. Keep it simple.  
  
You might want to refresh your memory on [Fermi Problems](https://en.wikipedia.org/wiki/Fermi_problem). Remember that you need less precision than you think. Remember that your goal is just to get the exponent right, x in n \* 10^x.  
  
[Wolframalpha](https://www.wolframalpha.com) is good at calculating with units, you may use that the first few times--but over time the goal is for you to be able to do these calculations with no aids!  
  
Consider using spaced repetition to remember the numbers you need for today's problem, e.g. [http://communis.io/](http://communis.io/) is a messenger bot.

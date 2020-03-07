---
date: 2019-11-02T00:00:00Z
title: Napkin Problem 2
---

Fellow computer-napkin-mathers, it's time for napkin problem #2. The last
problem's solution you'll find at the end! I've updated
[sirupsen/napkin-math](https://github.com/sirupsen/napkin-math) with last week's
tips and tricks--consult that repo if you need a refresher. My goal for that
repo is to become a great resource for napkin calculations in the domain of
computers. My talk from SRECON's video was published this week, you can see it
[here.](https://www.youtube.com/watch?v=IxkSlnrRFqc)
 
**Problem #2: Your SSD-backed database has a usage-pattern that rewards you with
a 80% page-cache hit-rate (i.e. 80% of disk reads are served directly out of
memory instead of going to the SSD). The median is 50 distinct disk pages for a
query to gather its query results (e.g. InnoDB pages in MySQL). What is the
expected average query time from your database?**
 
Reply to this email with your answer, happy to provide you mine ahead of time if
you're curious.

_Solution to this problem is [available in the next edition](/napkin/problem-3/)_

**Last Problem's Solution**

**Question:** **How much will the storage of logs cost for a standard,
monolithic 100,000 RPS web application?**

**Answer:** First I jotted down the basics and convert them to scientific
notation for easy calculation `~1 *10^3 bytes/request (1 KB)`, `9 * 10^4
seconds/day`, and `10^5 requests/second`. Then multiplied these numbers into
storage per day: `10^3 bytes/request * 9 * 10^4 seconds/day * 10^5
requests/second = 9 * 10^12 bytes/day = 9 Tb/day`. Then we need to use the
monthly cost for disk storage from
[sirupsen/napkin-math](https://github.com/sirupsen/napkin-math) (or your cloud's
pricing calculator) -- `$0.01 GB/month`. So we have `9 Tb/day * $0.01 GB/month`. We
do some unit conversions (you could do this by hand to practise, or on
Wolframalpha) and get to `$3 * 10^3 per month`, or $3,000 per month. Most of
those who replied got somewhere between $1,000 and $10,000 -- well within an
order of magnitude!

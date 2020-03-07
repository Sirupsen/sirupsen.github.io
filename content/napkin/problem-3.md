---
date: 2019-12-15T00:00:00Z
title: Napkin Problem 3
---

Napkin friends, from near and far, it's time for napkin problem number three! If you are wondering why you're receiving this email, you likely [watched my talk on napkin math.](https://www.youtube.com/watch?v=IxkSlnrRFqc)

This weeks problem is higher level, which is different from the past few. This makes it more difficult, but I hope you enjoy it!

**Napkin Problem 3** 

You are considering how you might implement a set-membership service. Your use-case is to build a service to filter products by particular attributes, e.g. efficiently among all products for a merchant get shoes that are: black, size 10, and brand X.

Before getting fancy, you'd like to examine whether the simplest possible algorithm would be sufficiently fast: store, for each attribute, a list of all product ids for that attribute (see drawing below). Each query to your service will take the form: `shoe AND black AND size-10 AND brand-x`. To serve the query, you find the intersection (i.e. product ids that match in all terms) between all the attributes. This should return the product ids for all products that match that condition. In the case of the drawing below, only P3 (of those visible) matches those conditions.

![Picture illustrating the attributes and product ids.](https://gallery.tinyletterapp.com/6285c917bb5e97f61e87a98c4e93442d8cfe38a6/images/7dfa1786-d88e-41bd-b336-30a9092db882.png) 

The largest merchants have 1,000,000 different products. Each product will be represented in this naive data-structure as a 64-bit integer. While simply shown as a list here, you can assume that we can perform the intersections between rows efficiently in O(n) operations. In other words, in the worst case you have to read all the integers for each attribute only once per term in the query. We could implement this in a variety of ways, but the point of the back-of-the-envelope calculation is to not get lost in the weeds of implementation too early. 
  
What would you estimate the worst-case performance of an average query with 4 AND conditions to be? Based on this result and your own intuition, would you say this algorithm is sufficient or would you investigate something more sophisticated?  
  
As always, you can find resources at [github.com/sirupsen/napkin-math](https://github.com/sirupsen/napkin-math). The talk linked is the best introduction tot he topic.  
  
Please reply with your answer!  

_Solution to this problem is [available in the next edition](/napkin/problem-4/)_
  
**Answer to Problem 2**  
  
_Your SSD-backed database has a usage-pattern that rewards you with a 80%
page-cache hit-rate (i.e. 80% of  disk reads are served directly out of memory
instead of going to the SSD). The median is 50 distinct disk pages for a query
to gather its query results (e.g. InnoDB pages in MySQL). What is the expected
average query time from your database?_  
  
`50 * 0.8 = 40` disk reads come out of the memory cache. The remaining 10 SSD
reads require a random SSD seek, each of which will take about `100 us` as per
[the reference](https://github.com/sirupsen/napkin-math). The reference says 64
bytes, but the OS will read a full page at a time from SSD, so this will be
roughly right. So call it a lower bound of `1ms` of SSD time. The page-cache
reads will all be less than a microsecond, so we won't even factor them in. It's
typically the case that we can ignore any memory latency as soon as I/O is
involved. Somewhere between 1-10ms seems reasonable, when you add in
database-overhead and that 1ms for disk-access is a lower-bound.

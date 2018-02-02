---
layout: post
title: Peak Complexity
---

With the teams I work with, we operate with the idea of ‘peak complexity’: the
time at which a project reaches peak complexity. Peak complexity has proved a
useful mental model to us for reasoning about complexity; when to step back and
refactor, staffing; how many people should be working on a project, and
prioritization; how quickly can we move on this today without shooting ourselves
in the foot.

What we find is that to make something simpler, we typically have to raise the
complexity momentarily. If you want to organize a messy closet, you take out
everything, arrange it on the floor, and figure out what goes back in, and what
doesn't. When all your winter coats, toques, and spare umbrellas are laid out on
the floor, you’re at peak complexity. The state of your house is *worse* than it
was before you started—but it’s necessary for you to organize.

When you’re cleaning your house, you likely do this one messy place at a time:
the bedroom closet, then the attic, and lastly, the dreaded basement. Why?
Because doing it all at once would be utter mayhem; costumes, stamp collections,
coats, and lego sets everywhere. We’re managing peak complexity to one messy
floor-patch at a time.

![](/static/images/peak-complexity.png)

This model works with software, too. As we embark on a complex project, we need
to consider where we are on that complexity mountain. We have a complexity
budget to manage. The more complexity you add, the harder it is to onboard new
members to the team. Typically, your bus factor is high, because few people can
manage this complexity. With high complexity, the probability of error increases
non-linearly. Consider your project’s inflection points and structure it to have
many small ones, rather than one giant, compounding Mount Everest. The bigger
the mountain, the more mountain caves you leave for unknown-unknowns.

The worst thing you can do is build a complexity mountain and not harvest the
simplicity gains on the other side. The descent may require a smaller team and
take less time than it took to climb, but is incredibly important work. As I’ve
written about before, the more you can [simplify the mental model of the
software](/drafts), the more leverage you build. Failing to recognize peak
complexity and staying at the peak is how you end up supporting your project
forever.

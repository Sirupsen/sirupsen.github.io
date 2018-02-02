---
layout: post
title: Peak Complexity
---

With the teams I work with, we operate with the idea of _peak complexity_: the
time at which a project reaches its highest complexity. Peak complexity has
proved a useful mental model to us for reasoning about complexity. It helps
inform decisions about when to step back and refactor, how many people should be
working on the project at a given point in time, and how we should structure the
project.

What we find is that to make something simpler, we typically have to raise the
complexity momentarily. If you want to organize a messy closet, you take out
everything and arrange it on the floor. When all your winter coats, toques, and
spare umbrellas are laid out beneath you, you’re at peak complexity. The state
of your house is *worse* than it was before you started. We accept this step as
necessary to organize. Only when it's all laid out can you decide what goes back
in, and what doesn't.

When you’re cleaning your house, you do this one messy place at a time: the
bedroom closet, then the attic, and lastly, the dreaded basement. Doing it all
at once would be utter mayhem; costumes, stamp collections, coats, and lego sets
everywhere. We’re managing our series of peak complexity points to one messy
floor-patch at a time.

![](/static/images/peak-complexity.png)

This model works for software, too. As we embark on a complex project, we need
to consider the pending complexity mountain(s). We have a complexity budget to
manage. The more complexity you add, the harder it is to onboard new members to
the team. Typically, your bus factor increases, because few people can manage
this complexity at a time. With high complexity, the probability of error
increases non-linearly. It's key to consider your project’s inflection points
and structure it to have many small peaks. This avoids creating one giant Mount
Everest. You want many small hills, delivering value every step of the way. The
bigger the mountain, the more mountain caves you leave for unknown-unknowns.

![](/static/images/peak-complexity-smaller.png)

The worst thing you can do is build a complexity mountain and not harvest the
simplicity gains on the other side. The descent may require a smaller team and
take less time than it took to climb, but is incredibly important work. As I’ve
written about before, the more you can [simplify the mental model of the
software](/drafts), the more leverage you build. Failing to recognize peak
complexity and staying at the peak is how you end up supporting your project
forever.

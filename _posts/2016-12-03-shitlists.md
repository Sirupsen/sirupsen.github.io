---
layout: post
title: Shitlist Driven Development
published: false
---

Recently the team I work with completed a project to [allow Shopify to run in
multiple datacenters](https://www.youtube.com/watch?v=7UyDK2bDjc4). This project
was a refactoring project in disguise. When you undertake large refactoring of a
code-base with 100s of developers and 100,000s of lines of code, you can't align
by sending an email. The merge-conflicts a single pull request would entail
makes me shiver. When deprecating in a large code-base the only way to reliably
avoid new deprecated behaviour is a failing test that tells you what to do.
Otherwise the pace that new deprecated code is introduced can easily outpace the
speed at which you can remove them, or be a massive source of frustration.

Typically deprecations come in the form of soft warnings: Logging to `stderr`,
capital letters and exclamation marks in the documentation, or a legacy prefix
to the method or class name. At the end of the day, everyone needs to get work
done, and if they see a code-path already being used from 10 places in the
code-base despite these soft warnings--it doesn't seem crazy to introduce
another. However, if another project is blocked on these deprecated code-paths,
piling on may have a large cost.

To solve this problem [Florian Weingarten](https://twitter.com/fw1729) on our
team introduced what he calls "shitlists". A shitlist is essentially a whitelist
of deprecated behaviour. Existing deprecated behaviour is OK, and listed. New
usage of the deprecated API is banned, and fails a test with a well-defined
error. 

They come in many forms, but could look like this:

```ruby
Shitlist = [
  ClassA,
  ClassB,
  ClassC
]

def push_job_that_does_crazy_things(klass)
  if Shitlist.include?(klass)
    # Existing deprecated behaviour is called.
  else
    raise Shitlist::Error, <<-EOS
You're pushing a job that does crazy things. This API has been deprecated in
this code-base. <team> is actively trying to get rid of this code-path, because
<reason>. We suggest you instead do <alternative>. If you have questions, please
ping <team>.
  EOS
end
```

A shitlist could be something as simple as a `git grep` for a certain code-path:

```ruby
test "no new introductions of legacy code path" do
  actual = `git grep some_legacy_method_with_a_unique_name`
  assert_equal 321, actual
end
```

Other times you can reach into another API and get a count or list:

```ruby
RedisShitlist = [
  Session,
  FragmentCache,
  AuthenticationTokens,
]

test "no new redis models introduced" do
  assert_equal RedisShitlist, RedisModel.descendants
end
```

If you have a linter for a project, you may be able to encode rules. For example
you might use [Foodcritic](http://www.foodcritic.io/) for Chef, or
[Rubocop](https://github.com/bbatsov/rubocop) for Ruby.

Sometimes the shit list is quite complicated, and much more domain-specific.

Building the shitlist gives the team responsible for it a number of advantages:

1. **Strong feedback loop.** The goal is to reduce the `Shitlist` to an empty
   Array and always raise or remove the cod entirely. Remove a class from the
   list, fix the code and the tests, celebrate and move on.
2. **Stopped the bleeding.** New deprecated behaviour is not introduced unless
   the team is contacted or some other action defined in the error is taken.
3. **Success metric**. If you have shitlists for everything that needs to be
   done for your project, you have metrics that you can track. Every week you
   can look at how these lists are shrinking. Refactoring for months at a time
   can be exhausting, but if you see that you're making progress with metrics
   moving, it's much more rewarding.

It is important that the shitlist errors are actionable. If you hit the shitlist
of another team, you need to know what to do next. Ideally the error explains
exactly what you need to do, and no humans need to talk, but reaching out to the
owner of the shit-list should always be part of the shitlist.

If you own a shitlist, you must empathize with the problems of everyone who's
running into problems. If you simply deprecate new behaviour and don't offer an
alternative, you will be the source of frustration. If the value of emptying the
shitlist far outweighs the value of adding to the shitlist, it may be OK to not
offer a direct other solution but ask the person who ran into the error to
revise their solution.

It is important that people run into shitlists as early in development as
possible. If you run into a shitlist after spending hours implementing your
solution, you will be less than popular. Some shitlists may require an entire
re-architecting of some teams' solutions. 

Months, in our case more than a year, of refactoring can be overwhelming and
unrewarding work. With the strong feedback loop that shitlists introduce you can
see the light at the end of the tunnel. You know that nothing is added to the
shitlist without you knowing about it.

Creating shitlists in some cases can be extremely difficult. Some take hours to
create, others weeks, and in our case one took months to come up with. You'll
have to place the cost of developing the shitlist against the cost of not having
it. In some cases logging when you hit a bad code-path may be enough (simple
soft warning deprecation) if you assert the risk of new behaviour small and the
complexity of introducing the shitlist big.

Delegating with shitlists is great. Due to the tight feedback loop, asking other
teams or onboarding new team members becomes much easier. Remove something on
the shitlist, fix the code and the tests, then move on. Sometimes during large
refactorings you may need other teams with more domain expertise of a certain
area of the code-base to help. The shitlist becomes a great rock to point people
at.

If you are about to embark on a large refactor, I highly recommend adding
shitlists to your toolbox. Your project will look much less daunting when it
goes from an opaque objective to a list of shitlists.

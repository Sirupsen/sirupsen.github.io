---
date: "2013-03-13T00:00:00Z"
title: Keeping it simple with Test::Unit
---

I’ve been using Ruby for over 3 years and have written tests for about as long.
That’s something great about the Ruby community, [it encourages
you][dhh-why-ruby] to do proper testing. Through this time I’ve worked with many
different testing frameworks.

I’ve come to appreciate the simplicity of [Test::Unit][test-unit].
[RSpec][rspec] adds a level of complication with its DSL that I do not see the
appeal of. Tests should be the most transparent part of your stack. They are
your definitive documentation, and something you will come back to again and
again. And what is more lucid than the programming language you've been using
for years? I understand and appreciate the behavior of Ruby, and it shouldn't feel
like I'm writing a "bad spec" if I use that instead of my testing DSL.

{{< highlight ruby >}}
assert [1,2,3].include?(1)
{{< / highlight >}}

Just feels so much more natural to me, than doing the same in a DSL:

{{< highlight ruby >}}
[1,2,3].should include(1)
{{< / highlight >}}

Even worse, why do `[1,2,3].should start_with(1)` when `assert_equal 1,
[1,2,3][0]` suffices? Or `actual.should be(expected)` instead of `assert_equal
expected, actual`?

When I'm been writing RSpec, I feel like I focus on writing idiomatic specs in
lieu of effective tests. Ruby is transparent to me. I write my objects in Ruby, and
I like to test them in Ruby. Not a testing language written on top of Ruby.

Specs I find hard to read. What I need, is often buried inside nested contexts
of shared behavior. I have to backtrack to figure out what the test is doing.
This makes it quite a joy to write tests when you get into it, but a pain to
read them after a few months. If you use a lot of contexts, [your object is
probably doing too much][gose]. I usually only have 5-10 test cases per testing
file. They are easy to read. They share no behavior. The tests are independent.
They are Ruby.

It's paramount that you do test. What testing framework you choose is secondary,
and a highly subjective matter. There really is no universal "RSpec vs.
Test::Unit" conclusion. I prefer Test::Unit-like frameworks because they're
clear and Ruby. I could implement the basic behavior of Test::Unit in a few
hours if I had to. Because it's so simple, I'm left only with the issue of
creating a thorough test for my object. Not the issue of living up to idiomatic
standards for my framework.

[rspec]: http://rspec.info
[cucumber]: http://cukes.info
[minitest]: https://github.com/seattlerb/minitest
[test-unit]: https://github.com/test-unit/test-unit
[bacon]: https://github.com/chneukirchen/bacon
[rspec-mocks]: https://github.com/rspec/rspec-mocks
[mocha]: https://github.com/freerange/mocha
[rr]: https://github.com/btakita/rr
[dhh-why-ruby]: http://vimeo.com/17420638
[gose]: http://www.amazon.com/Growing-Object-Oriented-Software-Guided-Tests/dp/0321503627
[dhh-on-testing]: http://www.rubyinside.com/dhh-offended-by-rspec-debate-4610.html

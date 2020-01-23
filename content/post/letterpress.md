---
date: "2013-09-08T00:00:00Z"
title: Letterpress Cheater Algorithm
---

A few months ago when Letterpress was hot, I thought about an efficient
algorithm for a cheater application. A trivial solution in Ruby is quite slow
for this problem, which motivated me to check out alternative approaches.
Abbreviated, the problem is the following:

> Given 25 random letters (`letters`), find every string in an array of strings (`words`) that
> consists of only those letters. 

I'll start by walking through a naive solution before presenting a data
structure to solve this problem efficiently.

## Naive algorithm

The naive approach for this problem is to simply loop through all elements of
`words` and check whether these words can be formed from the characters in
`letters` with a frequency map:

{{< highlight ruby >}}
letters = "ovrkqlwislrecrtgmvpfprzey"

# Create the frequency map
letters = letters.each_char.inject(Hash.new(0)) { |map, char| (map[char] += 1) && map }

words.select { |word|
  word.each_char.inject(letters.clone) { |freq, char| 
    (freq[char] -= 1) < 0 ? break : freq
  } && word
}.uniq
{{< / highlight >}}

A frequency map looks like this:

{{< highlight ruby >}}
{"o"=>1, "v"=>2, "r"=>4, "k"=>1, "q"=>1, "l"=>2, "w"=>1, "i"=>1, 
"s"=>1, "e"=>2, "c"=>1, "t"=>1, "g"=>1, "m"=>1, "p"=>2, "f"=>1,
"z"=>1, "y"=>1}
{{< / highlight >}}

For an average word length `m` and `n` words in `words` this runs in O(n m)
time.  In my tests, this algorithm runs in about 2-4s on my Macbook on the
dictionary in `/usr/share/dict/words`. That is not fast enough if this was to be
used for a web application for example, so we dig deeper.

A simple iteration on this naive algorithm, is the observation that if a
character is not in `letters`, then we do not have to loop through all the words
that start with this letter in `words`. E.g. if there's no letter c in
`letters`, we can skip to the words beginning with d when we encounter the first
word which begins with c in `words` and so on.

{{< highlight ruby >}}
groups = words.group_by { |s| s.first }

groups.map { |char, group|
  next if letters[char] == 0

  group.select { |word|
    word.each_char.inject(letters.clone) { |freq, char| 
      (freq[char] -= 1) < 0 ? break : freq
    } && word
  }
}.flatten.uniq
{{< / highlight >}}

The speed of this iteration depends on how many words in `letters` start with
each character in `words`. Say that `k` is the highest number of words that
starts with any character in `words`, and `d` is the number of distinct
characters from which we can form words, then this runs in worst-case O(d k)
time. In my tests, this was about twice as fast as the previous algorithm.
Another iteration is threading the processing of each group.

## Using a Trie

The idea of grouping is similar to the original solution I had in mind, but
instead of just grouping on the first character, group on all characters! This
creates a neat, recursive structure called a Trie. 

For instance, if we put in the word "band", "ban" and "boo" in the data
structure, it will look like this:

{{< highlight ruby >}}
{
  b: {
    o: {
      o: {
      }
    }
    a: {
      n: {
        d: {
        }
      }
    }
  }
}
{{< / highlight >}}

That way we can check that "boo" is in the structure with something like:
`map[:b][:o][:o]`. However, that would also imply that "bo" is in the structure,
which it is not. We need a state on each of the maps that tells whether a word
ends at this letter. 

{{< highlight ruby >}}
class Trie
  attr_accessor :word, :nodes

  def initialize
    @word, @nodes = false, {}
  end
end
{{< / highlight >}}

With that in place, we can create a method to create the data structure
described above, by going through each character in the added string, creating
new Tries as we go:

{{< highlight ruby >}}
def <<(word)
  node = word.each_char.inject(self) { |node, char| 
    node.nodes[char] ||= Trie.new 
  }
  node.word = true
end
{{< / highlight >}}

With that comes the interesting part. The problem is now, given this data
structure, how do we find all the entries in the data structure, which is the
end of a word that we can get to with `letters`?

Once again we make use of the frequency map explained in the previous section,
and then we recursively visit nodes in the data structure. The frequency map is
updated as we go down the recursion, so invalid paths can be detected.

{{< highlight ruby >}}
def find(letters)
  recursive_find frequency_map(letters), ""
end

def recursive_find(used, word)
  words = nodes.reject { |c, v| used[c] == 0 }.map { |char, node|
  node.recursive_find(used.merge(char => used[char] - 1),
                      word + char)
  }.flatten

  words << word if self.word
  words
end
{{< / highlight >}}

The full implementation of the data structure can be seen in [this
Gist](https://gist.github.com/Sirupsen/6481936#file-gistfile1-rb-L3-L31).

## Benchmarks

I made a [few small optimizations to the
trie](https://gist.github.com/Sirupsen/6481936) showed here to make it faster.
There's still plenty of things that could be done to make it faster, such as
concurrent searching, and there's probably a bunch of things that can be found
profiling. Either way, it's clear that it is much faster to use a trie over the
naive methods presented earlier. The trie uses a lot of memory, this could be
optimized by converting it into a [radix
tree](http://en.wikipedia.org/wiki/Radix_tree), which could also yield small
performance benefits.

           user     system      total        real
    Benchmarking 'ovrkqlwislrecrtgmvpfprzey'
    faster trie  0.090000   0.000000   0.090000 (  0.089411)
    blog trie  0.390000   0.040000   0.430000 (  0.452724)
    naive  3.290000   0.140000   3.430000 (  3.467491)
    group  2.230000   0.050000   2.280000 (  2.290674)

    Benchmarking 'abcdefghifghijklmnopqrstuvxyz'
    faster trie  0.670000   0.000000   0.670000 (  0.671967)
    blog trie  3.020000   0.070000   3.090000 (  3.094881)
    naive  4.450000   0.050000   4.500000 (  4.596610)
    group  4.120000   0.050000   4.170000 (  4.208492)

    Benchmarking 'odidwocswkbafvydehsbiviez'
    faster trie  0.030000   0.000000   0.030000 (  0.030700)
    blog trie  0.100000   0.010000   0.110000 (  0.103797)
    naive  2.550000   0.010000   2.560000 (  2.566604)
    group  1.640000   0.010000   1.650000 (  1.658194)

    Benchmarking 'rtlyifebuzkxndovzyzodelap'
    faster trie  0.150000   0.000000   0.150000 (  0.154702)
    blog trie  0.630000   0.010000   0.640000 (  0.633183)
    naive  2.810000   0.010000   2.820000 (  2.822617)
    group  2.140000   0.000000   2.140000 (  2.147578)


About 0.1-0.2s in the worst case on actual Letterpress games is absolutely fine
for use in a service. The second case, which takes the most time, is a stress
test with every letter of the alphabet. It would never happen in Letterpress.

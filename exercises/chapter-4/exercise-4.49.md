# Exercise 4.49

Alyssa P. Hacker is more
interested in generating interesting sentences than in parsing them.  She
reasons that by simply changing the procedure `parse-word` so that it
ignores the “input sentence” and instead always succeeds and generates an
appropriate word, we can use the programs we had built for parsing to do
generation instead.  Implement Alyssa’s idea, and show the first half-dozen or
so sentences generated.[^1]

[^1]: Although Alyssa’s idea works just fine (and is
surprisingly simple), the sentences that it generates are a bit boring—they
don’t sample the possible sentences of this language in a very interesting way.
In fact, the grammar is highly recursive in many places, and Alyssa’s technique
“falls into” one of these recursions and gets stuck.  See [Exercise 4.50](../chapter-4/exercise-4.50.md)
for a way to deal with this.

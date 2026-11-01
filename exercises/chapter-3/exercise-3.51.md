# Exercise 3.51

In order to take a closer look at
delayed evaluation, we will use the following procedure, which simply returns
its argument after printing it:

```scheme
(define (show x)
  (display-line x)
  x)
```

What does the interpreter print in response to evaluating each expression in
the following sequence?[^1]

```scheme
(define x 
  (stream-map 
   show 
   (stream-enumerate-interval 0 10)))

(stream-ref x 5)
(stream-ref x 7)
```

[^1]: Exercises such as [Exercise 3.51](../chapter-3/exercise-3.51.md) and
[Exercise 3.52](../chapter-3/exercise-3.52.md) are valuable for testing our understanding of how
`delay` works.  On the other hand, intermixing delayed evaluation with
printing—and, even worse, with assignment—is extremely confusing, and
instructors of courses on computer languages have traditionally tormented their
students with examination questions such as the ones in this section.  Needless
to say, writing programs that depend on such subtleties is odious programming
style.  Part of the power of stream processing is that it lets us ignore the
order in which events actually happen in our programs.  Unfortunately, this is
precisely what we cannot afford to do in the presence of assignment, which
forces us to be concerned with time and change.

# Exercise 2.31

Abstract your answer to
[Exercise 2.30](../chapter-2/exercise-2.30.md) to produce a procedure `tree-map` with the property
that `square-tree` could be defined as

```scheme
(define (square-tree tree) 
  (tree-map square tree))
```

# Exercise 2.39

Complete the following
definitions of `reverse` ([Exercise 2.18](../chapter-2/exercise-2.18.md)) in terms of
`fold-right` and `fold-left` from [Exercise 2.38](../chapter-2/exercise-2.38.md):

```scheme
(define (reverse sequence)
  (fold-right 
   (lambda (x y) ⟨??⟩) nil sequence))

(define (reverse sequence)
  (fold-left 
   (lambda (x y) ⟨??⟩) nil sequence))
```

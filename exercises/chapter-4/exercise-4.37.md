# Exercise 4.37

Ben Bitdiddle claims that the
following method for generating Pythagorean triples is more efficient than the
one in [Exercise 4.35](../chapter-4/exercise-4.35.md).  Is he correct?  (Hint: Consider the number of
possibilities that must be explored.)

```scheme
(define (a-pythagorean-triple-between low high)
  (let ((i (an-integer-between low high))
        (hsq (* high high)))
    (let ((j (an-integer-between i high)))
      (let ((ksq (+ (* i i) (* j j))))
        (require (>= hsq ksq))
        (let ((k (sqrt ksq)))
          (require (integer? k))
          (list i j k))))))
```

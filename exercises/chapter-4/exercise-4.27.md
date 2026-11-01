# Exercise 4.27

Suppose we type in the following
definitions to the lazy evaluator:

```scheme
(define count 0)
(define (id x) (set! count (+ count 1)) x)
```

Give the missing values in the following sequence of interactions, and explain
your answers.[^1]

```scheme
(define w (id (id 10)))

;;; L-Eval input:
count

;;; L-Eval value:
⟨response⟩

;;; L-Eval input:
w

;;; L-Eval value:
⟨response⟩

;;; L-Eval input:
count

;;; L-Eval value:
⟨response⟩
```

[^1]: This exercise demonstrates that the interaction between
lazy evaluation and side effects can be very confusing.  This is just what you
might expect from the discussion in Chapter 3.

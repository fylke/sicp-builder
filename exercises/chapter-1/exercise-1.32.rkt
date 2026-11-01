#lang sicp
;; Exercise 1.32
;;
;; - (a) Show that `sum` and `product` ([Exercise 1.31](../chapter-1/exercise-1.31.rkt)) are both special
;; cases of a still more general notion called `accumulate` that combines a
;; collection of terms, using some general accumulation function:
;;
;;       ```scheme
;;       (accumulate
;;        combiner null-value term a next b)
;;       ```
;;
;;       `Accumulate` takes as arguments the same term and range specifications as
;; `sum` and `product`, together with a `combiner` procedure (of
;; two arguments) that specifies how the current term is to be combined with the
;; accumulation of the preceding terms and a `null-value` that specifies what
;; base value to use when the terms run out.  Write `accumulate` and show how
;; `sum` and `product` can both be defined as simple calls to
;; `accumulate`.
;;
;; - (b) If your `accumulate` procedure generates a recursive process, write one
;; that generates an iterative process.  If it generates an iterative process,
;; write one that generates a recursive process.

;; Test: raco test tests/chapter-1/exercise-1.32.test.rkt
;; Your exercises/chapter-1/exercise-1.32.rkt must (#%provide accumulate accumulate-iter sum product)
;;   (accumulate combiner null-value term a next b)      -- combine (term x) for x = a, (next a), ... <= b
;;                                                          with combiner, starting from null-value
;;   (accumulate-iter combiner null-value term a next b) -- the same, by the other kind of process
;;                                                          (iterative if accumulate is recursive, or vice versa)
;;   (sum term a next b), (product term a next b)        -- defined as simple calls to accumulate
;; Tests only use commutative, associative combiners.


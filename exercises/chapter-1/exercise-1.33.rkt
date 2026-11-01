#lang sicp
;; Exercise 1.33
;;
;; You can obtain an even more
;; general version of `accumulate` ([Exercise 1.32](../chapter-1/exercise-1.32.rkt)) by introducing the
;; notion of a *filter* on the terms to be combined.  That is, combine
;; only those terms derived from values in the range that satisfy a specified
;; condition.  The resulting `filtered-accumulate` abstraction takes the same
;; arguments as accumulate, together with an additional predicate of one argument
;; that specifies the filter.  Write `filtered-accumulate` as a procedure.
;; Show how to express the following using `filtered-accumulate`:
;;
;; - (a) the sum of the squares of the prime numbers in the interval $a$ to $b$
;; (assuming that you have a `prime?` predicate already written)
;;
;; - (b) the product of all the positive integers less than $n$ that are relatively
;; prime to $n$ (i.e., all positive integers ${i < n}$ such that
;; ${\text{GCD}(i, n) = 1}$).

;; Test: raco test tests/chapter-1/exercise-1.33.test.rkt
;; Your exercises/chapter-1/exercise-1.33.rkt must
;;   (#%provide filtered-accumulate sum-of-prime-squares product-of-relatively-prime)
;;   (filtered-accumulate combiner null-value term a next b filter?)
;;       -- like accumulate, but only terms for which (filter? x) is true, where x is the
;;          value from the range a, (next a), ... <= b, are combined (the predicate is the LAST argument)
;;   (sum-of-prime-squares a b)       -- sum of the squares of the primes in [a, b] (a >= 2)
;;   (product-of-relatively-prime n)  -- product of all positive integers i < n with gcd(i, n) = 1
;; (define prime? yourself; use filtered-accumulate for the last two)


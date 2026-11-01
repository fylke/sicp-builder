#lang sicp
;; Exercise 1.18
;;
;; Using the results of
;; [Exercise 1.16](../chapter-1/exercise-1.16.rkt) and [Exercise 1.17](../chapter-1/exercise-1.17.rkt), devise a procedure that generates
;; an iterative process for multiplying two integers in terms of adding, doubling,
;; and halving and uses a logarithmic number of steps.[^1]
;;
;; [^1]: This algorithm,
;; which is sometimes known as the “Russian peasant method” of multiplication,
;; is ancient.  Examples of its use are found in the Rhind Papyrus, one of the two
;; oldest mathematical documents in existence, written about 1700 B.C.
;; (and copied from an even older document) by an Egyptian scribe named A’h-mose.

;; Test: raco test tests/chapter-1/exercise-1.18.test.rkt
;; Your exercises/chapter-1/exercise-1.18.rkt must (#%provide fast-mul)
;;   (fast-mul a b) -- a * b for an integer a and a non-negative integer b, by an iterative
;;                     process using only addition, double and halve (logarithmic steps)
;; (define double and halve yourself)


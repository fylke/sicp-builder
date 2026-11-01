#lang sicp
;; Exercise 2.7
;;
;; Alyssa’s program is incomplete
;; because she has not specified the implementation of the interval abstraction.
;; Here is a definition of the interval constructor:
;;
;; ```scheme
;; (define (make-interval a b) (cons a b))
;; ```
;;
;; Define selectors `upper-bound` and `lower-bound` to complete the
;; implementation.

;; Test: raco test tests/chapter-2/exercise-2.07.test.rkt
;; Your exercises/chapter-2/exercise-2.07.rkt must (#%provide make-interval lower-bound upper-bound)
;;   (make-interval a b) -- the interval from a to b (a <= b); the book defines it as (cons a b)
;;   (lower-bound i)     -- the lower end of i
;;   (upper-bound i)     -- the upper end of i


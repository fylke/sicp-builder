#lang sicp
;; Exercise 3.1
;;
;; An *accumulator* is a
;; procedure that is called repeatedly with a single numeric argument and
;; accumulates its arguments into a sum.  Each time it is called, it returns the
;; currently accumulated sum.  Write a procedure `make-accumulator` that
;; generates accumulators, each maintaining an independent sum.  The input to
;; `make-accumulator` should specify the initial value of the sum; for
;; example
;;
;; ```scheme
;; (define A (make-accumulator 5))
;;
;; (A 10)
;; 15
;;
;; (A 10)
;; 25
;; ```

;; Test: raco test tests/chapter-3/exercise-3.01.test.rkt
;; Your exercises/chapter-3/exercise-3.01.rkt must (#%provide make-accumulator)
;;   (make-accumulator initial-sum) -> procedure of one number that adds it to the
;;                                     running sum and returns the new sum


#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.01.rkt must (#%provide make-accumulator)
;;   (make-accumulator initial-sum) -> procedure of one number that adds it to the
;;                                     running sum and returns the new sum

(test-case "accumulates the example from the book"
  (define make-accumulator (solution "3.01" 'make-accumulator))
  (define A (make-accumulator 5))
  (check-equal? (A 10) 15)
  (check-equal? (A 10) 25))

(test-case "accumulators are independent"
  (define make-accumulator (solution "3.01" 'make-accumulator))
  (define A (make-accumulator 0))
  (define B (make-accumulator 100))
  (check-equal? (A 1) 1)
  (check-equal? (B 1) 101)
  (check-equal? (A 2) 3)
  (check-equal? (B -50) 51))

(test-case "works with zero and negative numbers"
  (define make-accumulator (solution "3.01" 'make-accumulator))
  (define A (make-accumulator 0))
  (check-equal? (A 0) 0)
  (check-equal? (A -3) -3)
  (check-equal? (A 3) 0))

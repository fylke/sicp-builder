#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.08.rkt must (#%provide f)
;;   (f x) -> a procedure with state such that (+ (f 0) (f 1)) is 0 when the operands
;;            are evaluated left to right (and 1 when right to left).
;; This language evaluates operands left to right. The test calls f only in this one
;; evaluation, starting from a fresh f, so don't rely on being called more than once.

(test-case "(+ (f 0) (f 1)) evaluates to 0 with left-to-right evaluation"
  (define f (solution "3.08" 'f))
  (check-equal? (+ (f 0) (f 1)) 0))

#lang sicp
;; Exercise 3.8
;;
;; When we defined the evaluation
;; model in 1.1.3, we said that the first step in evaluating an
;; expression is to evaluate its subexpressions.  But we never specified the order
;; in which the subexpressions should be evaluated (e.g., left to right or right
;; to left).  When we introduce assignment, the order in which the arguments to a
;; procedure are evaluated can make a difference to the result.  Define a simple
;; procedure `f` such that evaluating
;;
;; ```scheme
;; (+ (f 0) (f 1))
;; ```
;;
;; will return 0 if
;; the arguments to `+` are evaluated from left to right but will return 1 if
;; the arguments are evaluated from right to left.

;; Test: raco test tests/chapter-3/exercise-3.08.test.rkt
;; Your exercises/chapter-3/exercise-3.08.rkt must (#%provide f)
;;   (f x) -> a procedure with state such that (+ (f 0) (f 1)) is 0 when the operands
;;            are evaluated left to right (and 1 when right to left).
;; This language evaluates operands left to right. The test calls f only in this one
;; evaluation, starting from a fresh f, so don't rely on being called more than once.


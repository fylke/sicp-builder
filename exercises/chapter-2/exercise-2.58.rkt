#lang sicp
;; Exercise 2.58
;;
;; Suppose we want to modify the
;; differentiation program so that it works with ordinary mathematical notation,
;; in which `+` and `*` are infix rather than prefix operators.  Since
;; the differentiation program is defined in terms of abstract data, we can modify
;; it to work with different representations of expressions solely by changing the
;; predicates, selectors, and constructors that define the representation of the
;; algebraic expressions on which the differentiator is to operate.
;;
;; - (a) Show how to do this in order to differentiate algebraic expressions presented
;; in infix form, such as `(x + (3 * (x + (y + 2))))`.  To simplify the task,
;; assume that `+` and `*` always take two arguments and that
;; expressions are fully parenthesized.
;;
;; - (b) The problem becomes substantially harder if we allow standard algebraic
;; notation, such as `(x + 3 * (x + y + 2))`, which drops unnecessary
;; parentheses and assumes that multiplication is done before addition.  Can you
;; design appropriate predicates, selectors, and constructors for this notation
;; such that our derivative program still works?

;; Test: raco test tests/chapter-2/exercise-2.58.test.rkt
;; Your exercises/chapter-2/exercise-2.58.rkt must (#%provide deriv deriv-b)
;;   (deriv exp var)   -- part (a): the differentiator for fully parenthesized infix
;;                        expressions with two-argument + and *, e.g. (x + (3 * (x + (y + 2))))
;;   (deriv-b exp var) -- part (b): the differentiator for standard infix notation with
;;                        dropped parentheses and * binding tighter than +,
;;                        e.g. (x + 3 * (x + y + 2))
;; You must define the supporting representation procedures yourself. Expressions use only
;; numbers, symbols, + and *. The tests evaluate the results numerically, so any correct form
;; is accepted.


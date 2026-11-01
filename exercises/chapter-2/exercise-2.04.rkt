#lang sicp
;; Exercise 2.4
;;
;; Here is an alternative procedural
;; representation of pairs.  For this representation, verify that `(car (cons
;; x y))` yields `x` for any objects `x` and `y`.
;;
;; ```scheme
;; (define (cons x y)
;;   (lambda (m) (m x y)))
;;
;; (define (car z)
;;   (z (lambda (p q) p)))
;; ```
;;
;; What is the corresponding definition of `cdr`? (Hint: To verify that this
;; works, make use of the substitution model of 1.1.5.)

;; Test: raco test tests/chapter-2/exercise-2.04.test.rkt
;; Your exercises/chapter-2/exercise-2.04.rkt must (#%provide cons car cdr)
;;   (cons x y) -- a pair built only from procedures (no real pairs!)
;;   (car z)    -- first component of z
;;   (cdr z)    -- second component of z
;; All three are your own definitions (shadowing the built-ins in your file).


#lang sicp
;; Exercise 1.35
;;
;; Show that the golden ratio
;; $\varphi$ (1.2.2) is a fixed point of the transformation
;; ${x \mapsto 1 + 1 / x}$, and use this fact to compute $\varphi$ by means
;; of the `fixed-point` procedure.

;; Test: raco test tests/chapter-1/exercise-1.35.test.rkt
;; Your exercises/chapter-1/exercise-1.35.rkt must (#%provide golden-ratio)
;;   golden-ratio -- a number (not a procedure): the golden ratio, computed with
;;                   fixed-point of x -> 1 + 1/x
;; (define tolerance and fixed-point yourself, as in the book)


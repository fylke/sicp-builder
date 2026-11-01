#lang sicp
;; Exercise 2.57
;;
;; Extend the differentiation
;; program to handle sums and products of arbitrary numbers of (two or more)
;; terms.  Then the last example above could be expressed as
;;
;; ```scheme
;; (deriv '(* x y (+ x 3)) 'x)
;; ```
;;
;; Try to do this by changing only the representation for sums and products,
;; without changing the `deriv` procedure at all.  For example, the
;; `addend` of a sum would be the first term, and the `augend` would be
;; the sum of the rest of the terms.

;; Test: raco test tests/chapter-2/exercise-2.57.test.rkt
;; Your exercises/chapter-2/exercise-2.57.rkt must (#%provide deriv)
;;   (deriv exp var) -- the book's differentiator, working on sums and products of any
;;                      number (two or more) of terms, e.g. (deriv '(* x y (+ x 3)) 'x)
;; You must define the whole differentiator yourself (variable?, same-variable?, sum?,
;; make-sum, addend, augend, product?, make-product, multiplier, multiplicand, deriv).
;; The tests evaluate the results numerically, so any correct form is accepted.


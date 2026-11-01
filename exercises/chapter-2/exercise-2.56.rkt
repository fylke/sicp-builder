#lang sicp
;; Exercise 2.56
;;
;; Show how to extend the basic
;; differentiator to handle more kinds of expressions.  For instance, implement
;; the differentiation rule
;;
;; $$
;;   {d(u^{\kern0.1ex n}) \over dx} \,=\, {nu^{\kern0.1ex n-1} \, {du \over dx}}
;; $$
;;
;; by adding a new clause to the `deriv` program and defining appropriate
;; procedures `exponentiation?`, `base`, `exponent`, and
;; `make-exponentiation`.  (You may use the symbol `**` to denote
;; exponentiation.)  Build in the rules that anything raised to the power 0 is 1
;; and anything raised to the power 1 is the thing itself.

;; Test: raco test tests/chapter-2/exercise-2.56.test.rkt
;; Your exercises/chapter-2/exercise-2.56.rkt must (#%provide deriv exponentiation? base
;;                                                  exponent make-exponentiation)
;;   (deriv exp var)              -- the book's symbolic differentiator, extended with the rule
;;                                   for exponentiation (**)
;;   (exponentiation? e)          -- is e of the form (** u n)?
;;   (base e) (exponent e)        -- u and n of (** u n)
;;   (make-exponentiation u n)    -- the expression (** u n); n = 0 gives 1, n = 1 gives u
;; You must also define the rest of the book's differentiator yourself (variable?,
;; same-variable?, sum?, make-sum, product?, make-product, ... with the usual
;; simplifications for 0 and 1 and for numbers).


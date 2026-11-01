#lang sicp
;; Exercise 2.5
;;
;; Show that we can represent pairs of
;; nonnegative integers using only numbers and arithmetic operations if we
;; represent the pair $a$ and $b$ as the integer that is the product ${2^a 3^b}$.
;; Give the corresponding definitions of the procedures `cons`,
;; `car`, and `cdr`.

;; Test: raco test tests/chapter-2/exercise-2.05.test.rkt
;; Your exercises/chapter-2/exercise-2.05.rkt must (#%provide cons car cdr)
;;   (cons a b) -- the integer 2^a * 3^b (a, b nonnegative integers)
;;   (car z)    -- recovers a
;;   (cdr z)    -- recovers b
;; All three are your own definitions (shadowing the built-ins in your file).


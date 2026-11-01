#lang sicp
;; Exercise 2.61
;;
;; Give an implementation of
;; `adjoin-set` using the ordered representation.  By analogy with
;; `element-of-set?` show how to take advantage of the ordering to produce a
;; procedure that requires on the average about half as many steps as with the
;; unordered representation.

;; Test: raco test tests/chapter-2/exercise-2.61.test.rkt
;; Your exercises/chapter-2/exercise-2.61.rkt must (#%provide adjoin-set)
;;   (adjoin-set x set) -- add x to a set of numbers represented as an ordered (increasing)
;;                         list without duplicates; the result is again ordered, and x is not
;;                         added twice. It should stop as soon as it has found x's place
;;                         (the tests check that the rest of the list is not examined).


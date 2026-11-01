#lang sicp
;; Exercise 2.62
;;
;; Give a ${\Theta(n)}$
;; implementation of `union-set` for sets represented as ordered lists.

;; Test: raco test tests/chapter-2/exercise-2.62.test.rkt
;; Your exercises/chapter-2/exercise-2.62.rkt must (#%provide union-set)
;;   (union-set set1 set2) -- union of two sets of numbers represented as ordered (increasing)
;;                            lists without duplicates; the result is an ordered list without
;;                            duplicates, computed in Theta(n) steps


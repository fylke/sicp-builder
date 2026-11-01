#lang sicp
;; Exercise 2.59
;;
;; Implement the `union-set`
;; operation for the unordered-list representation of sets.

;; Test: raco test tests/chapter-2/exercise-2.59.test.rkt
;; Your exercises/chapter-2/exercise-2.59.rkt must (#%provide union-set)
;;   (union-set set1 set2) -- the set (list without duplicates) of everything in set1 or set2
;; You must define element-of-set? (and anything else you use) yourself; the tests only
;; look at union-set. The order of the elements in the result does not matter.


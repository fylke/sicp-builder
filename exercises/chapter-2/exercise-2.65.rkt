#lang sicp
;; Exercise 2.65
;;
;; Use the results of [Exercise 2.63](../chapter-2/exercise-2.63.rkt)
;; and [Exercise 2.64](../chapter-2/exercise-2.64.rkt) to give ${\Theta(n)}$ implementations of
;; `union-set` and `intersection-set` for sets implemented as (balanced)
;; binary trees.[^1]
;;
;; [^1]: [Exercise 2.63](../chapter-2/exercise-2.63.rkt) through [Exercise 2.65](../chapter-2/exercise-2.65.rkt) are due
;; to Paul Hilfinger.

;; Test: raco test tests/chapter-2/exercise-2.65.test.rkt
;; Your exercises/chapter-2/exercise-2.65.rkt must (#%provide union-set intersection-set)
;;   (union-set set1 set2)        -- union of two sets of numbers, each represented as a
;;                                   balanced binary tree, in Theta(n) steps
;;   (intersection-set set1 set2) -- intersection of two such sets
;; Trees use the book's representation: the empty tree is '(), and a tree is the list
;; (entry left-branch right-branch). The result may be any binary search tree with the
;; right elements (the tests only look at its in-order contents).
;; You must define in your file whatever helpers you use (entry, left-branch, right-branch,
;; make-tree, tree->list, list->tree, ...).


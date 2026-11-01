#lang sicp
;; Exercise 2.28
;;
;; Write a procedure `fringe`
;; that takes as argument a tree (represented as a list) and returns a list whose
;; elements are all the leaves of the tree arranged in left-to-right order.  For
;; example,
;;
;; ```scheme
;; (define x
;;   (list (list 1 2) (list 3 4)))
;;
;; (fringe x)
;; (1 2 3 4)
;;
;; (fringe (list x x))
;; (1 2 3 4 1 2 3 4)
;; ```

;; Test: raco test tests/chapter-2/exercise-2.28.test.rkt
;; Your exercises/chapter-2/exercise-2.28.rkt must (#%provide fringe)
;;   (fringe tree) -- list of all the leaves of tree (a list), left to right


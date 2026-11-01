#lang sicp
;; Exercise 2.31
;;
;; Abstract your answer to
;; [Exercise 2.30](../chapter-2/exercise-2.30.rkt) to produce a procedure `tree-map` with the property
;; that `square-tree` could be defined as
;;
;; ```scheme
;; (define (square-tree tree)
;;   (tree-map square tree))
;; ```

;; Test: raco test tests/chapter-2/exercise-2.31.test.rkt
;; Your exercises/chapter-2/exercise-2.31.rkt must (#%provide tree-map square-tree)
;;   (tree-map proc tree) -- tree with proc applied to every leaf
;;   (square-tree tree)   -- defined as (tree-map square tree)
;; Define square yourself.


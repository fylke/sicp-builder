#lang sicp
;; Exercise 2.30
;;
;; Define a procedure
;; `square-tree` analogous to the `square-list` procedure of
;; [Exercise 2.21](../chapter-2/exercise-2.21.rkt).  That is, `square-tree` should behave as follows:
;;
;; ```scheme
;; (square-tree
;;  (list 1
;;        (list 2 (list 3 4) 5)
;;        (list 6 7)))
;; (1 (4 (9 16) 25) (36 49))
;; ```
;;
;; Define `square-tree` both directly (i.e., without using any higher-order
;; procedures) and also by using `map` and recursion.

;; Test: raco test tests/chapter-2/exercise-2.30.test.rkt
;; Your exercises/chapter-2/exercise-2.30.rkt must (#%provide square-tree square-tree-map)
;;   (square-tree tree)     -- tree with every leaf squared, defined directly (no map)
;;   (square-tree-map tree) -- the same, defined with map and recursion
;;                             (the book names both square-tree; the second is called
;;                             square-tree-map here)
;; Define square yourself if you need it.


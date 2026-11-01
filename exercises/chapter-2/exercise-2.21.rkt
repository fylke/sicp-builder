#lang sicp
;; Exercise 2.21
;;
;; The procedure `square-list`
;; takes a list of numbers as argument and returns a list of the squares of those
;; numbers.
;;
;; ```scheme
;; (square-list (list 1 2 3 4))
;; (1 4 9 16)
;; ```
;;
;; Here are two different definitions of `square-list`.  Complete both of
;; them by filling in the missing expressions:
;;
;; ```scheme
;; (define (square-list items)
;;   (if (null? items)
;;       nil
;;       (cons ⟨??⟩ ⟨??⟩)))
;;
;; (define (square-list items)
;;   (map ⟨??⟩ ⟨??⟩))
;; ```

;; Test: raco test tests/chapter-2/exercise-2.21.test.rkt
;; Your exercises/chapter-2/exercise-2.21.rkt must (#%provide square-list square-list-map)
;;   (square-list items)     -- list of the squares of items, recursive version using cons
;;   (square-list-map items) -- the same, defined with map
;;                              (the book gives both the name square-list; here the second
;;                              one is called square-list-map)
;; You define square yourself if you need it.


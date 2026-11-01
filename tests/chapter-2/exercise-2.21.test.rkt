#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.21.rkt must (#%provide square-list square-list-map)
;;   (square-list items)     -- list of the squares of items, recursive version using cons
;;   (square-list-map items) -- the same, defined with map
;;                              (the book gives both the name square-list; here the second
;;                              one is called square-list-map)
;; You define square yourself if you need it.

(test-case "square-list (recursive)"
  (define square-list (solution "2.21" 'square-list))
  (check-equal? (square-list (list 1 2 3 4)) '(1 4 9 16))
  (check-equal? (square-list '()) '())
  (check-equal? (square-list (list -3 0 5)) '(9 0 25)))

(test-case "square-list-map"
  (define square-list-map (solution "2.21" 'square-list-map))
  (check-equal? (square-list-map (list 1 2 3 4)) '(1 4 9 16))
  (check-equal? (square-list-map '()) '())
  (check-equal? (square-list-map (list -3 0 5)) '(9 0 25)))

(test-case "both agree on non-integers"
  (define square-list (solution "2.21" 'square-list))
  (define square-list-map (solution "2.21" 'square-list-map))
  (check-equal? (square-list (list 0.5 1/2 2)) '(0.25 1/4 4))
  (check-equal? (square-list-map (list 0.5 1/2 2)) '(0.25 1/4 4)))

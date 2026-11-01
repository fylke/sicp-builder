#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.30.rkt must (#%provide square-tree square-tree-map)
;;   (square-tree tree)     -- tree with every leaf squared, defined directly (no map)
;;   (square-tree-map tree) -- the same, defined with map and recursion
;;                             (the book names both square-tree; the second is called
;;                             square-tree-map here)
;; Define square yourself if you need it.

(define book-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))
(define book-result '(1 (4 (9 16) 25) (36 49)))

(test-case "square-tree (direct): book example"
  (define square-tree (solution "2.30" 'square-tree))
  (check-equal? (square-tree book-tree) book-result))

(test-case "square-tree (direct): other trees"
  (define square-tree (solution "2.30" 'square-tree))
  (check-equal? (square-tree '()) '())
  (check-equal? (square-tree '(1 2 3)) '(1 4 9))
  (check-equal? (square-tree '(((2)) -3 (0 (1)))) '(((4)) 9 (0 (1)))))

(test-case "square-tree-map: book example"
  (define square-tree-map (solution "2.30" 'square-tree-map))
  (check-equal? (square-tree-map book-tree) book-result))

(test-case "square-tree-map: other trees"
  (define square-tree-map (solution "2.30" 'square-tree-map))
  (check-equal? (square-tree-map '()) '())
  (check-equal? (square-tree-map '(1 2 3)) '(1 4 9))
  (check-equal? (square-tree-map '(((2)) -3 (0 (1)))) '(((4)) 9 (0 (1)))))

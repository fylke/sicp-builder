#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.31.rkt must (#%provide tree-map square-tree)
;;   (tree-map proc tree) -- tree with proc applied to every leaf
;;   (square-tree tree)   -- defined as (tree-map square tree)
;; Define square yourself.

(test-case "tree-map with a numeric procedure"
  (define tree-map (solution "2.31" 'tree-map))
  (check-equal? (tree-map (lambda (x) (+ x 1)) '(1 (2 (3 4) 5) (6 7))) '(2 (3 (4 5) 6) (7 8)))
  (check-equal? (tree-map (lambda (x) (* x 10)) '(1 2 3)) '(10 20 30)))

(test-case "tree-map keeps the shape"
  (define tree-map (solution "2.31" 'tree-map))
  (check-equal? (tree-map (lambda (x) 'z) '(a (b (c)) d)) '(z (z (z)) z))
  (check-equal? (tree-map (lambda (x) x) '()) '())
  (check-equal? (tree-map (lambda (x) (list x)) '(1 (2))) '((1) ((2)))))

(test-case "square-tree: book example"
  (define square-tree (solution "2.31" 'square-tree))
  (check-equal? (square-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))
                '(1 (4 (9 16) 25) (36 49)))
  (check-equal? (square-tree '()) '()))

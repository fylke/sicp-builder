#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.28.rkt must (#%provide fringe)
;;   (fringe tree) -- list of all the leaves of tree (a list), left to right

(test-case "book examples"
  (define fringe (solution "2.28" 'fringe))
  (define x (list (list 1 2) (list 3 4)))
  (check-equal? (fringe x) '(1 2 3 4))
  (check-equal? (fringe (list x x)) '(1 2 3 4 1 2 3 4)))

(test-case "flat list and empty list"
  (define fringe (solution "2.28" 'fringe))
  (check-equal? (fringe '()) '())
  (check-equal? (fringe '(1 2 3)) '(1 2 3)))

(test-case "unbalanced nesting"
  (define fringe (solution "2.28" 'fringe))
  (check-equal? (fringe '(1 (2 (3 (4 5))) 6)) '(1 2 3 4 5 6))
  (check-equal? (fringe '((((a))) b)) '(a b))
  (check-equal? (fringe '(((1 2) 3) 4 (5 (6 7)))) '(1 2 3 4 5 6 7)))

(test-case "empty sublists contribute no leaves"
  (define fringe (solution "2.28" 'fringe))
  (check-equal? (fringe '(1 () (2 ()) 3)) '(1 2 3)))

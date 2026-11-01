#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.35.rkt must (#%provide count-leaves)
;;   (count-leaves t) -- number of leaves of the tree t, defined as an accumulation
;; You must define accumulate yourself; it is not tested here.

(test-case "flat lists"
  (define count-leaves (solution "2.35" 'count-leaves))
  (check-equal? (count-leaves '()) 0)
  (check-equal? (count-leaves '(1 2 3)) 3))

(test-case "book trees"
  (define count-leaves (solution "2.35" 'count-leaves))
  (define x (list (list 1 2) (list 3 4)))
  (check-equal? (count-leaves x) 4)
  (check-equal? (count-leaves (list x x)) 8))

(test-case "unbalanced and deep trees"
  (define count-leaves (solution "2.35" 'count-leaves))
  (check-equal? (count-leaves '(1 (2 (3 (4))))) 4)
  (check-equal? (count-leaves '(((((a)))))) 1)
  (check-equal? (count-leaves '((1 2 3) 4 ((5) 6) 7)) 7))

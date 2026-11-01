#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.39.rkt must (#%provide reverse-fold-right reverse-fold-left)
;;   (reverse-fold-right sequence) -- reverse of sequence, defined with fold-right
;;   (reverse-fold-left sequence)  -- reverse of sequence, defined with fold-left
;;                                    (the book names both reverse)
;; You must define fold-right and fold-left yourself (Exercise 2.38); they are not tested here.

(test-case "reverse with fold-right"
  (define rev (solution "2.39" 'reverse-fold-right))
  (check-equal? (rev (list 1 4 9 16 25)) '(25 16 9 4 1))
  (check-equal? (rev '()) '())
  (check-equal? (rev (list 1)) '(1))
  (check-equal? (rev '((1 2) (3 4) 5)) '(5 (3 4) (1 2))))

(test-case "reverse with fold-left"
  (define rev (solution "2.39" 'reverse-fold-left))
  (check-equal? (rev (list 1 4 9 16 25)) '(25 16 9 4 1))
  (check-equal? (rev '()) '())
  (check-equal? (rev (list 1)) '(1))
  (check-equal? (rev '((1 2) (3 4) 5)) '(5 (3 4) (1 2))))

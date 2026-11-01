#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.38.rkt must (#%provide fold-right fold-left)
;;   (fold-right op initial sequence) -- the book's accumulate
;;   (fold-left op initial sequence)  -- the book's fold-left
;; You define both yourself.

(test-case "fold-right"
  (define fold-right (solution "2.38" 'fold-right))
  (check-equal? (fold-right / 1 (list 1 2 3)) 3/2)
  (check-equal? (fold-right list nil (list 1 2 3)) '(1 (2 (3 ()))))
  (check-equal? (fold-right + 0 (list 1 2 3 4)) 10)
  (check-equal? (fold-right cons nil (list 1 2 3)) '(1 2 3)))

(test-case "fold-left"
  (define fold-left (solution "2.38" 'fold-left))
  (check-equal? (fold-left / 1 (list 1 2 3)) 1/6)
  (check-equal? (fold-left list nil (list 1 2 3)) '(((() 1) 2) 3))
  (check-equal? (fold-left + 0 (list 1 2 3 4)) 10)
  (check-equal? (fold-left - 0 (list 1 2 3)) -6))

(test-case "empty sequences return the initial value"
  (define fold-right (solution "2.38" 'fold-right))
  (define fold-left (solution "2.38" 'fold-left))
  (check-equal? (fold-right + 42 '()) 42)
  (check-equal? (fold-left + 42 '()) 42))

(test-case "associative operations agree"
  (define fold-right (solution "2.38" 'fold-right))
  (define fold-left (solution "2.38" 'fold-left))
  (check-equal? (fold-right * 1 (list 2 3 4 5)) (fold-left * 1 (list 2 3 4 5)))
  (check-equal? (fold-right max 0 (list 3 9 2)) (fold-left max 0 (list 3 9 2))))

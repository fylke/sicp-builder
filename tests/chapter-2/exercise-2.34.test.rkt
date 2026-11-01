#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.34.rkt must (#%provide horner-eval)
;;   (horner-eval x coefficient-sequence) -- value at x of the polynomial whose coefficients
;;                                           a0, a1, ..., an are given in that order
;; You must define accumulate yourself; it is not tested here.

(test-case "book example: 1 + 3x + 5x^3 + x^5 at x = 2"
  (define horner-eval (solution "2.34" 'horner-eval))
  (check-equal? (horner-eval 2 (list 1 3 0 5 0 1)) 79))

(test-case "constant and linear polynomials"
  (define horner-eval (solution "2.34" 'horner-eval))
  (check-equal? (horner-eval 7 (list 5)) 5)
  (check-equal? (horner-eval 4 (list 1 2)) 9)
  (check-equal? (horner-eval 0 (list 3 4 5)) 3))

(test-case "empty polynomial"
  (define horner-eval (solution "2.34" 'horner-eval))
  (check-equal? (horner-eval 3 '()) 0))

(test-case "other polynomials"
  (define horner-eval (solution "2.34" 'horner-eval))
  (check-equal? (horner-eval 3 (list 1 2 3)) 34)
  (check-equal? (horner-eval -2 (list 1 0 1)) 5)
  (check-equal? (horner-eval -2 (list 0 0 0 1)) -8)
  (check-= (horner-eval 0.5 (list 1 1 1 1)) 1.875 1e-9))

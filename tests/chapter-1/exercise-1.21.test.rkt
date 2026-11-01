#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-1/exercise-1.21.rkt must (#%provide smallest-divisor)
;;   (smallest-divisor n) -- the smallest divisor (greater than 1) of the integer n >= 2
;; (define find-divisor, divides?, square yourself, as in the book)

(test-case "the numbers from the exercise"
  (define smallest-divisor (solution "1.21" 'smallest-divisor))
  (check-equal? (smallest-divisor 199) 199)
  (check-equal? (smallest-divisor 1999) 1999)
  (check-equal? (smallest-divisor 19999) 7))

(test-case "other numbers"
  (define smallest-divisor (solution "1.21" 'smallest-divisor))
  (check-equal? (smallest-divisor 2) 2)
  (check-equal? (smallest-divisor 3) 3)
  (check-equal? (smallest-divisor 4) 2)
  (check-equal? (smallest-divisor 9) 3)
  (check-equal? (smallest-divisor 25) 5)
  (check-equal? (smallest-divisor 49) 7)
  (check-equal? (smallest-divisor 91) 7)
  (check-equal? (smallest-divisor 121) 11)
  (check-equal? (smallest-divisor 1001) 7)
  (check-equal? (smallest-divisor 10403) 101)
  (check-equal? (smallest-divisor 1000003) 1000003))

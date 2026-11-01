#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.72.rkt must (#%provide squares-three-ways)
;;   squares-three-ways -> stream of the numbers that can be written as the sum of two
;;   positive squares in three different ways (pairs i <= j), in increasing order,
;;   each number once: 325 425 650 ...
;; Define weighted-pairs etc. (Exercise 3.70) yourself in the file.

(define (head s n)
  (if (or (= n 0) (null? s))
      '()
      (cons (car s) (head (force (cdr s)) (- n 1)))))

(test-case "first number"
  (define squares-three-ways (solution "3.72" 'squares-three-ways))
  (check-equal? (car squares-three-ways) 325))

(test-case "first eight numbers"
  (define squares-three-ways (solution "3.72" 'squares-three-ways))
  (check-equal? (head squares-three-ways 8) '(325 425 650 725 845 850 925 1025)))

#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.71.rkt must (#%provide ramanujan-numbers)
;;   ramanujan-numbers -> stream of the numbers that can be written as the sum of two
;;   positive cubes in two different ways, in increasing order: 1729 4104 13832 ...
;; Define weighted-pairs etc. (Exercise 3.70) yourself in the file.

(define (head s n)
  (if (or (= n 0) (null? s))
      '()
      (cons (car s) (head (force (cdr s)) (- n 1)))))

(test-case "first Ramanujan number"
  (define ramanujan-numbers (solution "3.71" 'ramanujan-numbers))
  (check-equal? (car ramanujan-numbers) 1729))

(test-case "first six Ramanujan numbers"
  (define ramanujan-numbers (solution "3.71" 'ramanujan-numbers))
  (check-equal? (head ramanujan-numbers 6) '(1729 4104 13832 20683 32832 39312)))

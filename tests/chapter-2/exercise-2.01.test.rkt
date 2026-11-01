#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.01.rkt must (#%provide make-rat numer denom)
;;   (make-rat n d)  -- the rational n/d, reduced to lowest terms, sign normalised
;;   (numer r)       -- numerator of r
;;   (denom r)       -- denominator of r (positive)
;; You define all three yourself (including whatever gcd handling you need).

(test-case "positive arguments are reduced"
  (define make-rat (solution "2.01" 'make-rat))
  (define numer (solution "2.01" 'numer))
  (define denom (solution "2.01" 'denom))
  (check-equal? (numer (make-rat 1 2)) 1)
  (check-equal? (denom (make-rat 1 2)) 2)
  (check-equal? (numer (make-rat 6 9)) 2)
  (check-equal? (denom (make-rat 6 9)) 3))

(test-case "negative numerator stays negative"
  (define make-rat (solution "2.01" 'make-rat))
  (define numer (solution "2.01" 'numer))
  (define denom (solution "2.01" 'denom))
  (check-equal? (numer (make-rat -1 2)) -1)
  (check-equal? (denom (make-rat -1 2)) 2)
  (check-equal? (numer (make-rat -6 9)) -2)
  (check-equal? (denom (make-rat -6 9)) 3))

(test-case "negative denominator moves the sign to the numerator"
  (define make-rat (solution "2.01" 'make-rat))
  (define numer (solution "2.01" 'numer))
  (define denom (solution "2.01" 'denom))
  (check-equal? (numer (make-rat 1 -2)) -1)
  (check-equal? (denom (make-rat 1 -2)) 2)
  (check-equal? (numer (make-rat 6 -9)) -2)
  (check-equal? (denom (make-rat 6 -9)) 3))

(test-case "two negatives give a positive rational"
  (define make-rat (solution "2.01" 'make-rat))
  (define numer (solution "2.01" 'numer))
  (define denom (solution "2.01" 'denom))
  (check-equal? (numer (make-rat -1 -2)) 1)
  (check-equal? (denom (make-rat -1 -2)) 2)
  (check-equal? (numer (make-rat -6 -9)) 2)
  (check-equal? (denom (make-rat -6 -9)) 3))

(test-case "zero numerator"
  (define make-rat (solution "2.01" 'make-rat))
  (define numer (solution "2.01" 'numer))
  (define denom (solution "2.01" 'denom))
  (check-equal? (numer (make-rat 0 5)) 0)
  (check-equal? (numer (make-rat 0 -5)) 0)
  (check-true (> (denom (make-rat 0 -5)) 0)))

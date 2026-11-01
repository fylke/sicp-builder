#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.05.rkt must (#%provide estimate-integral)
;;   (estimate-integral P x1 x2 y1 y2 trials) -> Monte Carlo estimate of the area of the
;;     region where predicate (P x y) holds, inside the rectangle [x1,x2] x [y1,y2]
;; Define random-in-range and monte-carlo yourself in the same file (they are used by
;; estimate-integral but need not be provided).

(test-case "region covering the whole rectangle gives its exact area"
  (define estimate-integral (solution "3.05" 'estimate-integral))
  (check-= (estimate-integral (lambda (x y) #t) 2.0 8.0 4.0 10.0 100) 36.0 1e-9))

(test-case "empty region gives zero"
  (define estimate-integral (solution "3.05" 'estimate-integral))
  (check-= (estimate-integral (lambda (x y) #f) 2.0 8.0 4.0 10.0 100) 0 1e-9))

(test-case "the predicate receives points inside the rectangle"
  (define estimate-integral (solution "3.05" 'estimate-integral))
  (define ok #t)
  (estimate-integral (lambda (x y)
                       (if (not (and (<= 2 x 8) (<= 4 y 10))) (set! ok #f))
                       #t)
                     2.0 8.0 4.0 10.0 500)
  (check-true ok))

(test-case "the predicate is evaluated once per trial"
  (define estimate-integral (solution "3.05" 'estimate-integral))
  (define n 0)
  (estimate-integral (lambda (x y) (set! n (+ n 1)) #t) 0.0 1.0 0.0 1.0 250)
  (check-equal? n 250))

(test-case "estimates pi from the unit circle"
  (define estimate-integral (solution "3.05" 'estimate-integral))
  (check-= (estimate-integral (lambda (x y) (<= (+ (* x x) (* y y)) 1.0))
                              -1.0 1.0 -1.0 1.0 50000)
           3.14159 0.15))

(test-case "estimates the area of the circle of radius 3 centered at (5, 7)"
  (define estimate-integral (solution "3.05" 'estimate-integral))
  (check-= (estimate-integral (lambda (x y)
                                (<= (+ (* (- x 5) (- x 5)) (* (- y 7) (- y 7))) 9))
                              2.0 8.0 4.0 10.0 50000)
           28.274 1.5))

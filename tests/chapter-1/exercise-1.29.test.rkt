#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-1/exercise-1.29.rkt must (#%provide simpson)
;;   (simpson f a b n) -- Simpson's Rule approximation of the integral of f from a to b
;;                        using an even number n of intervals
;; (define cube, sum, etc. yourself)

(define (cube x) (* x x x))

(test-case "cube from 0 to 1 (exact for cubics)"
  (define simpson (solution "1.29" 'simpson))
  (check-= (simpson cube 0 1 100) 0.25 1e-9)
  (check-= (simpson cube 0 1.0 1000) 0.25 1e-9))

(test-case "smallest n"
  (define simpson (solution "1.29" 'simpson))
  (check-= (simpson (lambda (x) (* x x)) 0 3 2) 9 1e-9))

(test-case "other intervals and functions"
  (define simpson (solution "1.29" 'simpson))
  (check-= (simpson cube 1 3 4) 20 1e-9)
  (check-= (simpson (lambda (x) 5) 2 4 10) 10 1e-9)
  (check-= (simpson (lambda (x) x) -2 2 8) 0 1e-9)
  (check-= (simpson (lambda (x) (+ (* 2 x x x) (* 3 x) 1)) -1 2 6) 15 1e-9))

(test-case "non-polynomial function is accurate (all weights right)"
  (define simpson (solution "1.29" 'simpson))
  (check-= (simpson (lambda (x) (/ 1.0 x)) 1 2 100) 0.6931471805599453 1e-8)
  (check-= (simpson (lambda (x) (/ 1.0 (+ 1 (* x x)))) 0 1 100) 0.7853981633974483 1e-8))

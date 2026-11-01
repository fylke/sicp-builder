#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-1/exercise-1.44.rkt must (#%provide smooth n-fold-smooth)
;;   (smooth f)          -- the smoothed version of f: x -> average of f(x-dx), f(x), f(x+dx)
;;   (n-fold-smooth f n) -- f smoothed n times (n >= 1), using smooth and repeated
;; (define dx, and repeated/compose, yourself)

;; Impulse-like function: 0 for x <= 0, 1 for x > 0. Whatever dx is, smoothing it
;; once at 0 gives (0 + 0 + 1)/3.
(define (step x) (if (> x 0) 1.0 0.0))

(test-case "smooth averages three values"
  (define smooth (solution "1.44" 'smooth))
  (check-= ((smooth step) 0) (/ 1.0 3) 1e-9)
  (check-= ((smooth step) 100) 1.0 1e-9)
  (check-= ((smooth step) -100) 0.0 1e-9))

(test-case "smooth of a smooth function stays close"
  (define smooth (solution "1.44" 'smooth))
  (check-= ((smooth (lambda (x) (* x x))) 3) 9 1e-3)
  (check-= ((smooth (lambda (x) (+ (* 2 x) 1))) 4) 9 1e-6))

(test-case "n-fold-smooth"
  (define n-fold-smooth (solution "1.44" 'n-fold-smooth))
  (check-= ((n-fold-smooth step 1) 0) (/ 1.0 3) 1e-9)
  (check-= ((n-fold-smooth step 2) 0) (/ 1.0 3) 1e-9)
  (check-= ((n-fold-smooth step 3) 0) (/ 10.0 27) 1e-9))

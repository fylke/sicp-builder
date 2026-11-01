#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.78.rkt must (#%provide solve-2nd)
;;   (solve-2nd a b dt y0 dy0) -> stream of successive values of y for d2y/dt2 - a dy/dt - b y = 0,
;;   with y(0) = y0, dy/dt(0) = dy0, using integral with a delayed integrand (Exercise 3.77).
;;   Element k is the explicit-Euler value: y_(k+1) = y_k + dt*dy_k, dy_(k+1) = dy_k + dt*ddy_k,
;;   where ddy_k = a*dy_k + b*y_k.
;; Define integral and the stream helpers yourself in the file.

(define (head s n)
  (if (or (= n 0) (null? s))
      '()
      (cons (car s) (head (force (cdr s)) (- n 1)))))

(define (check-list actual expected)
  (check-equal? (length actual) (length expected))
  (for-each (lambda (a e) (check-= a e 1e-9)) actual expected))

(define (euler a b dt y dy n)
  (if (= n 0)
      '()
      (cons y (euler a b dt (+ y (* dt dy)) (+ dy (* dt (+ (* a dy) (* b y)))) (- n 1)))))

(test-case "first elements for a = 0, b = 1"
  (define solve-2nd (solution "3.78" 'solve-2nd))
  ;; y'' = y, y0 = 1, y'0 = 0, dt = 0.5: y = 1, 1, 1.25, 1.75
  (check-list (head (solve-2nd 0 1 0.5 1 0) 4) '(1 1 1.25 1.75)))

(test-case "matches the Euler recurrence, a = 3, b = -2"
  (define solve-2nd (solution "3.78" 'solve-2nd))
  (check-list (head (solve-2nd 3 -2 0.1 1 1) 12) (euler 3 -2 0.1 1 1 12)))

(test-case "matches the Euler recurrence, a = 0, b = -1 (oscillation)"
  (define solve-2nd (solution "3.78" 'solve-2nd))
  (check-list (head (solve-2nd 0 -1 0.01 1 0) 50) (euler 0 -1 0.01 1 0 50)))

(test-case "initial velocity is used"
  (define solve-2nd (solution "3.78" 'solve-2nd))
  (check-list (head (solve-2nd 1 1 0.1 0 2) 5) (euler 1 1 0.1 0 2 5)))

(test-case "approximates the exact solution of y'' = y"
  (define solve-2nd (solution "3.78" 'solve-2nd))
  (let ((ys (head (solve-2nd 0 1 0.001 1 1) 1001)))
    (check-= (car (reverse ys)) (exp 1) 0.01)))

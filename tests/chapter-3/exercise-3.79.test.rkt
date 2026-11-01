#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.79.rkt must (#%provide general-solve-2nd)
;;   (general-solve-2nd f dt y0 dy0) -> stream of values of y for d2y/dt2 = (f dy/dt y),
;;   where f is a procedure of two arguments (dy y); y(0) = y0, dy/dt(0) = dy0.
;;   Element k is the explicit-Euler value: y_(k+1) = y_k + dt*dy_k, dy_(k+1) = dy_k + dt*(f dy_k y_k).
;; Define integral and the stream helpers yourself in the file.

(define (head s n)
  (if (or (= n 0) (null? s))
      '()
      (cons (car s) (head (force (cdr s)) (- n 1)))))

(define (check-list actual expected)
  (check-equal? (length actual) (length expected))
  (for-each (lambda (a e) (check-= a e 1e-9)) actual expected))

(define (euler f dt y dy n)
  (if (= n 0)
      '()
      (cons y (euler f dt (+ y (* dt dy)) (+ dy (* dt (f dy y))) (- n 1)))))

(test-case "constant acceleration"
  (define general-solve-2nd (solution "3.79" 'general-solve-2nd))
  ;; y'' = 2, y0 = 0, y'0 = 0, dt = 1: y = 0 0 2 6 12
  (check-list (head (general-solve-2nd (lambda (dy y) 2) 1 0 0) 5) '(0 0 2 6 12)))

(test-case "f may depend on dy and y (the book's equation, a = 3, b = -2)"
  (define general-solve-2nd (solution "3.79" 'general-solve-2nd))
  (define (f dy y) (+ (* 3 dy) (* -2 y)))
  (check-list (head (general-solve-2nd f 0.1 1 1) 12) (euler f 0.1 1 1 12)))

(test-case "argument order is (dy y)"
  (define general-solve-2nd (solution "3.79" 'general-solve-2nd))
  (define (f dy y) (- dy (* 10 y)))
  (check-list (head (general-solve-2nd f 0.1 1 2) 8) (euler f 0.1 1 2 8)))

(test-case "nonlinear: y'' = -y^3 - dy"
  (define general-solve-2nd (solution "3.79" 'general-solve-2nd))
  (define (f dy y) (- (- (* y y y)) dy))
  (check-list (head (general-solve-2nd f 0.05 1 0) 15) (euler f 0.05 1 0 15)))

(test-case "approximates the exact solution of y'' = -y"
  (define general-solve-2nd (solution "3.79" 'general-solve-2nd))
  (let ((ys (head (general-solve-2nd (lambda (dy y) (- y)) 0.0001 0 1) 10001)))
    (check-= (car (reverse ys)) (sin 1) 0.01)))

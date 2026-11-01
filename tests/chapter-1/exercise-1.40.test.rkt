#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-1/exercise-1.40.rkt must (#%provide cubic)
;;   (cubic a b c) -- the procedure x -> x^3 + a x^2 + b x + c
;; (this test supplies the book's newtons-method itself)

(define dx 0.00001)
(define tolerance 0.00001)
(define (cube x) (* x x x))
(define (deriv g) (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))
(define (newton-transform g) (lambda (x) (- x (/ (g x) ((deriv g) x)))))
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2) (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next) next (try next))))
  (try first-guess))
(define (newtons-method g guess) (fixed-point (newton-transform g) guess))

(test-case "cubic evaluates the polynomial"
  (define cubic (solution "1.40" 'cubic))
  (check-= ((cubic 1 2 3) 2) 19 1e-9)
  (check-= ((cubic 0 0 0) 3) 27 1e-9)
  (check-= ((cubic 3 -6 -8) 2) 0 1e-9)
  (check-= ((cubic 5 7 11) 0) 11 1e-9)
  (check-= ((cubic 1 0 0) 3) 36 1e-9)
  (check-= ((cubic 0 1 0) 3) 30 1e-9)
  (check-= ((cubic 2 -1 4) -2) 6 1e-9))

(test-case "newtons-method finds zeros of cubics"
  (define cubic (solution "1.40" 'cubic))
  (check-= (newtons-method (cubic 0 0 -8) 1.0) 2 1e-3)
  (let ((root (newtons-method (cubic 3 -6 -8) 1.0)))
    (check-= ((cubic 3 -6 -8) root) 0 1e-3))
  (let ((root (newtons-method (cubic 1 1 1) 1.0)))
    (check-= ((cubic 1 1 1) root) 0 1e-3)))

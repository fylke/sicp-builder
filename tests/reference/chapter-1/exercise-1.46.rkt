#lang sicp
(#%provide iterative-improve sqrt fixed-point)

(define (iterative-improve good-enough? improve)
  (define (iter guess)
    (if (good-enough? guess)
        guess
        (iter (improve guess))))
  iter)

(define (average x y) (/ (+ x y) 2))

(define (sqrt x)
  ((iterative-improve
    (lambda (guess) (< (abs (- (* guess guess) x)) 0.00001))
    (lambda (guess) (average guess (/ x guess))))
   1.0))

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  ((iterative-improve
    (lambda (guess) (< (abs (- guess (f guess))) tolerance))
    f)
   first-guess))

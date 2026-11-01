#lang sicp
(#%provide integral)

(define (stream-car s) (car s))
(define (stream-cdr s) (force (cdr s)))

(define (integral delayed-integrand initial-value dt)
  (cons-stream
   initial-value
   (let ((integrand (force delayed-integrand)))
     (if (null? integrand)
         the-empty-stream
         (integral (delay (stream-cdr integrand))
                   (+ (* dt (stream-car integrand)) initial-value)
                   dt)))))

#lang sicp
(#%provide make-rat numer denom)

(define (make-rat n d)
  (let ((g (gcd n d))
        (s (if (< d 0) -1 1)))
    (cons (* s (/ n g)) (* s (/ d g)))))
(define (numer x) (car x))
(define (denom x) (cdr x))

#lang sicp
(#%provide cons car cdr)

(define (expt-of b n)
  (if (= n 0) 1 (* b (expt-of b (- n 1)))))
(define (cons a b) (* (expt-of 2 a) (expt-of 3 b)))
(define (count-divisions n d)
  (if (= (remainder n d) 0)
      (+ 1 (count-divisions (/ n d) d))
      0))
(define (car z) (count-divisions z 2))
(define (cdr z) (count-divisions z 3))

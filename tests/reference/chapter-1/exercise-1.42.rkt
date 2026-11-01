#lang sicp
(#%provide compose)

(define (compose f g)
  (lambda (x) (f (g x))))

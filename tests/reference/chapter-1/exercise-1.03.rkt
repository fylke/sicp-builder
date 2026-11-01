#lang sicp
(#%provide sum-of-squares-of-larger)

(define (square x) (* x x))
(define (sum-of-squares-of-larger a b c)
  (- (+ (square a) (square b) (square c))
     (square (min a b c))))

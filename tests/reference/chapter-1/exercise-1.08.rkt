#lang sicp
(#%provide cube-root)

(define (improve guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))
(define (good-enough? guess x)
  (< (abs (- (improve guess x) guess)) (* guess 1e-10)))
(define (cube-root-iter guess x)
  (if (good-enough? guess x)
      guess
      (cube-root-iter (improve guess x) x)))
(define (cube-root x) (cube-root-iter 1.0 x))

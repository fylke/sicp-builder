#lang sicp
(#%provide product product-iter factorial pi-approx)

(define (product term a next b)
  (if (> a b)
      1
      (* (term a) (product term (next a) next b))))

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

(define (factorial n)
  (product (lambda (x) x) 1 inc n))

(define (pi-approx n)
  (define (term k)
    (/ (* 2.0 k (+ (* 2.0 k) 2))
       (* (+ (* 2.0 k) 1) (+ (* 2.0 k) 1))))
  (* 4 (product-iter term 1 inc n)))

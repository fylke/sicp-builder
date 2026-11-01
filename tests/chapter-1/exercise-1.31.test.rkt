#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-1/exercise-1.31.rkt must (#%provide product product-iter factorial pi-approx)
;;   (product term a next b)      -- product of (term x) for x = a, (next a), ... while x <= b (empty product is 1)
;;   (product-iter term a next b) -- the same, by the other kind of process (iterative if `product`
;;                                   is recursive, or recursive if `product` is iterative)
;;   (factorial n)                -- n!, defined with product (factorial 0 = 1)
;;   (pi-approx n)                -- approximation of pi from Wallis's formula using n steps
;;                                   (accurate to about 3 decimals for n = 10000)

(define (identity x) x)

(define (check-product-procedure product)
  (check-equal? (product identity 1 inc 5) 120)
  (check-equal? (product (lambda (x) (* x x)) 1 inc 4) 576)
  (check-equal? (product identity 1 inc 0) 1)
  (check-equal? (product identity 3 inc 3) 3)
  (check-equal? (product identity 1 (lambda (x) (+ x 2)) 9) 945)
  (check-= (product (lambda (x) (/ 1.0 x)) 1 inc 4) (/ 1.0 24) 1e-12))

(test-case "product"
  (check-product-procedure (solution "1.31" 'product)))

(test-case "product-iter"
  (check-product-procedure (solution "1.31" 'product-iter)))

(test-case "factorial"
  (define factorial (solution "1.31" 'factorial))
  (check-equal? (factorial 0) 1)
  (check-equal? (factorial 1) 1)
  (check-equal? (factorial 5) 120)
  (check-equal? (factorial 10) 3628800)
  (check-equal? (factorial 20) 2432902008176640000))

(test-case "pi-approx"
  (define pi-approx (solution "1.31" 'pi-approx))
  (check-= (pi-approx 10000) 3.141592653589793 1e-3)
  (check-= (pi-approx 100) 3.141592653589793 0.05))

#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-1/exercise-1.32.rkt must (#%provide accumulate accumulate-iter sum product)
;;   (accumulate combiner null-value term a next b)      -- combine (term x) for x = a, (next a), ... <= b
;;                                                          with combiner, starting from null-value
;;   (accumulate-iter combiner null-value term a next b) -- the same, by the other kind of process
;;                                                          (iterative if accumulate is recursive, or vice versa)
;;   (sum term a next b), (product term a next b)        -- defined as simple calls to accumulate
;; Tests only use commutative, associative combiners.

(define (identity x) x)

(define (check-accumulate-procedure accumulate)
  (check-equal? (accumulate + 0 identity 1 inc 10) 55)
  (check-equal? (accumulate * 1 identity 1 inc 5) 120)
  (check-equal? (accumulate + 0 (lambda (x) (* x x)) 1 inc 4) 30)
  (check-equal? (accumulate max 0 identity 1 inc 7) 7)
  (check-equal? (accumulate + 100 identity 5 inc 4) 100)
  (check-equal? (accumulate * 7 identity 5 inc 4) 7)
  (check-equal? (accumulate + 0 identity 1 (lambda (x) (+ x 3)) 10) 22))

(test-case "accumulate"
  (check-accumulate-procedure (solution "1.32" 'accumulate)))

(test-case "accumulate-iter"
  (check-accumulate-procedure (solution "1.32" 'accumulate-iter)))

(test-case "sum"
  (define sum (solution "1.32" 'sum))
  (check-equal? (sum identity 1 inc 100) 5050)
  (check-equal? (sum (lambda (x) (* x x x)) 1 inc 10) 3025)
  (check-equal? (sum identity 3 inc 2) 0))

(test-case "product"
  (define product (solution "1.32" 'product))
  (check-equal? (product identity 1 inc 6) 720)
  (check-equal? (product identity 1 inc 0) 1)
  (check-equal? (product (lambda (x) (* 2 x)) 1 inc 3) 48))

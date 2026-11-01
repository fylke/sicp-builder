#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-1/exercise-1.33.rkt must
;;   (#%provide filtered-accumulate sum-of-prime-squares product-of-relatively-prime)
;;   (filtered-accumulate combiner null-value term a next b filter?)
;;       -- like accumulate, but only terms for which (filter? x) is true, where x is the
;;          value from the range a, (next a), ... <= b, are combined (the predicate is the LAST argument)
;;   (sum-of-prime-squares a b)       -- sum of the squares of the primes in [a, b] (a >= 2)
;;   (product-of-relatively-prime n)  -- product of all positive integers i < n with gcd(i, n) = 1
;; (define prime? yourself; use filtered-accumulate for the last two)

(define (identity x) x)

(test-case "filtered-accumulate with a sum"
  (define filtered-accumulate (solution "1.33" 'filtered-accumulate))
  (check-equal? (filtered-accumulate + 0 identity 1 inc 10 even?) 30)
  (check-equal? (filtered-accumulate + 0 (lambda (x) (* x x)) 1 inc 10 odd?) 165)
  (check-equal? (filtered-accumulate + 0 identity 1 inc 10 (lambda (x) #f)) 0)
  (check-equal? (filtered-accumulate + 0 identity 1 inc 10 (lambda (x) #t)) 55))

(test-case "filtered-accumulate with a product and empty ranges"
  (define filtered-accumulate (solution "1.33" 'filtered-accumulate))
  (check-equal? (filtered-accumulate * 1 identity 1 inc 10 odd?) 945)
  (check-equal? (filtered-accumulate + 42 identity 5 inc 4 even?) 42)
  (check-equal? (filtered-accumulate * 1 identity 1 inc 5 (lambda (x) #f)) 1))

(test-case "sum of squares of primes"
  (define sum-of-prime-squares (solution "1.33" 'sum-of-prime-squares))
  (check-equal? (sum-of-prime-squares 2 10) 87)
  (check-equal? (sum-of-prime-squares 2 2) 4)
  (check-equal? (sum-of-prime-squares 7 7) 49)
  (check-equal? (sum-of-prime-squares 8 10) 0)
  (check-equal? (sum-of-prime-squares 10 20) 940))

(test-case "product of numbers relatively prime to n"
  (define product-of-relatively-prime (solution "1.33" 'product-of-relatively-prime))
  (check-equal? (product-of-relatively-prime 10) 189)
  (check-equal? (product-of-relatively-prime 7) 720)
  (check-equal? (product-of-relatively-prime 12) 385)
  (check-equal? (product-of-relatively-prime 9) 2240))

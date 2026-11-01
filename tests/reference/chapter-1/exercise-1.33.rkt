#lang sicp
(#%provide filtered-accumulate sum-of-prime-squares product-of-relatively-prime)

(define (filtered-accumulate combiner null-value term a next b filter?)
  (cond ((> a b) null-value)
        ((filter? a)
         (combiner (term a)
                   (filtered-accumulate combiner null-value term (next a) next b filter?)))
        (else (filtered-accumulate combiner null-value term (next a) next b filter?))))

(define (square x) (* x x))
(define (prime? n)
  (define (iter d)
    (cond ((> (square d) n) true)
          ((= (remainder n d) 0) false)
          (else (iter (+ d 1)))))
  (and (>= n 2) (iter 2)))

(define (sum-of-prime-squares a b)
  (filtered-accumulate + 0 square a inc b prime?))

(define (product-of-relatively-prime n)
  (filtered-accumulate * 1 (lambda (i) i) 1 inc (- n 1)
                       (lambda (i) (= (gcd i n) 1))))

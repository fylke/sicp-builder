#lang sicp
(#%provide fools-fermat-test?)

(define (square x) (* x x))
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m))
        (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (fools-fermat-test? n)
  (define (try a)
    (cond ((= a n) true)
          ((= (expmod a n n) a) (try (+ a 1)))
          (else false)))
  (try 1))

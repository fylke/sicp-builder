#lang sicp
(#%provide miller-rabin-test fast-prime?)

(define (square x) (* x x))

;; returns 0 as soon as a nontrivial square root of 1 is found
(define (expmod base exp m)
  (define (check-square r)
    (if (and (not (= r 1))
             (not (= r (- m 1)))
             (= (remainder (square r) m) 1))
        0
        (remainder (square r) m)))
  (cond ((= exp 0) 1)
        ((even? exp) (check-square (expmod base (/ exp 2) m)))
        (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (miller-rabin-test n)
  (define (try-it a)
    (= (expmod a (- n 1) n) 1))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((miller-rabin-test n) (fast-prime? n (- times 1)))
        (else false)))

#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.62.rkt must (#%provide div-series tangent-series)
;;   (div-series s1 s2) -> the series s1/s2; signals an error if s2's constant term is 0
;;   tangent-series     -> the series of tan x, built with div-series from sine and cosine
;; Define mul-series, invert-unit-series, sine-series, cosine-series and the stream helpers
;; yourself in the file (Exercises 3.59-3.61).

(define (head s n)
  (if (or (= n 0) (null? s))
      '()
      (cons (car s) (head (force (cdr s)) (- n 1)))))

(define (check-series actual expected)
  (check-equal? (length actual) (length expected))
  (for-each (lambda (a e) (check-= a e 1e-9)) actual expected))

(define (fact n) (if (= n 0) 1 (* n (fact (- n 1)))))
(define (gen f n) (cons-stream (f n) (gen f (+ n 1))))
(define zeros (cons-stream 0 zeros))
(define (series . coeffs)
  (if (null? coeffs)
      zeros
      (cons-stream (car coeffs) (apply series (cdr coeffs)))))
(define sin-s
  (gen (lambda (n)
         (if (= (remainder n 2) 0)
             0
             (/ (if (= (remainder (quotient n 2) 2) 0) 1 -1) (fact n))))
       0))
(define cos-s
  (gen (lambda (n)
         (if (= (remainder n 2) 1)
             0
             (/ (if (= (remainder (quotient n 2) 2) 0) 1 -1) (fact n))))
       0))

(test-case "tangent-series is 0 1 0 1/3 0 2/15 0 17/315"
  (define tangent-series (solution "3.62" 'tangent-series))
  (check-series (head tangent-series 8) '(0 1 0 1/3 0 2/15 0 17/315)))

(test-case "div-series sin cos is the tangent series"
  (define div-series (solution "3.62" 'div-series))
  (check-series (head (div-series sin-s cos-s) 8) '(0 1 0 1/3 0 2/15 0 17/315)))

(test-case "division by a constant"
  (define div-series (solution "3.62" 'div-series))
  (check-series (head (div-series (series 3 6) (series 3)) 4) '(1 2 0 0)))

(test-case "denominator whose constant term is not 1"
  (define div-series (solution "3.62" 'div-series))
  (check-series (head (div-series (series 1) (series 2 1)) 5) '(1/2 -1/4 1/8 -1/16 1/32))
  (check-series (head (div-series (series 4 4) (series 2 2)) 4) '(2 0 0 0)))

(test-case "numerator with a higher power"
  (define div-series (solution "3.62" 'div-series))
  (check-series (head (div-series (series 0 1) (series 1 1)) 5) '(0 1 -1 1 -1)))

(test-case "a zero constant term in the denominator is an error"
  (define div-series (solution "3.62" 'div-series))
  (check-exn (lambda (e) #t)
             (lambda () (head (div-series (series 1 1) (series 0 1)) 3))))

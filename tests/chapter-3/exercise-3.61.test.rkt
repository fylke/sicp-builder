#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.61.rkt must (#%provide invert-unit-series)
;;   (invert-unit-series s) -> the series 1/s for a power series s whose constant term is 1
;; Define mul-series (Exercise 3.60) and the stream helpers yourself in the file.

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
(define (add-s a b)
  (cons-stream (+ (car a) (car b)) (add-s (force (cdr a)) (force (cdr b)))))
(define (scale-s s k)
  (cons-stream (* k (car s)) (scale-s (force (cdr s)) k)))
(define (mul-s a b)
  (cons-stream (* (car a) (car b))
               (add-s (scale-s (force (cdr b)) (car a))
                      (mul-s (force (cdr a)) b))))
(define exp-s (gen (lambda (n) (/ 1 (fact n))) 0))
(define cos-s
  (gen (lambda (n)
         (if (= (remainder n 2) 1)
             0
             (/ (if (= (remainder (quotient n 2) 2) 0) 1 -1) (fact n))))
       0))

(test-case "1/1 is 1"
  (define invert-unit-series (solution "3.61" 'invert-unit-series))
  (check-series (head (invert-unit-series (series 1)) 5) '(1 0 0 0 0)))

(test-case "1/(1 + x) = 1 - x + x^2 - ..."
  (define invert-unit-series (solution "3.61" 'invert-unit-series))
  (check-series (head (invert-unit-series (series 1 1)) 6) '(1 -1 1 -1 1 -1)))

(test-case "1/(1 - x) = 1 + x + x^2 + ..."
  (define invert-unit-series (solution "3.61" 'invert-unit-series))
  (check-series (head (invert-unit-series (series 1 -1)) 5) '(1 1 1 1 1)))

(test-case "1/(1 + 2x + 3x^2)"
  (define invert-unit-series (solution "3.61" 'invert-unit-series))
  (check-series (head (invert-unit-series (series 1 2 3)) 5) '(1 -2 1 4 -11)))

(test-case "the inverse of e^x is e^(-x)"
  (define invert-unit-series (solution "3.61" 'invert-unit-series))
  (check-series (head (invert-unit-series exp-s) 6) '(1 -1 1/2 -1/6 1/24 -1/120)))

(test-case "s * (1/s) = 1 for the cosine series"
  (define invert-unit-series (solution "3.61" 'invert-unit-series))
  (check-series (head (mul-s cos-s (invert-unit-series cos-s)) 8) '(1 0 0 0 0 0 0 0)))

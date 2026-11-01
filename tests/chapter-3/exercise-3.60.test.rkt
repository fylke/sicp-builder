#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.60.rkt must (#%provide mul-series)
;;   (mul-series s1 s2) -> the product of two power series given as coefficient streams
;; Define add-streams, scale-stream, stream-map etc. yourself in the file.

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
(define ones (cons-stream 1 ones))
(define exp-s (gen (lambda (n) (/ 1 (fact n))) 0))
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

(test-case "(1 + x)^2"
  (define mul-series (solution "3.60" 'mul-series))
  (check-series (head (mul-series (series 1 1) (series 1 1)) 6) '(1 2 1 0 0 0)))

(test-case "different polynomials"
  (define mul-series (solution "3.60" 'mul-series))
  (check-series (head (mul-series (series 2 3) (series 4 5)) 5) '(8 22 15 0 0))
  (check-series (head (mul-series (series 1 2 3) (series 1)) 5) '(1 2 3 0 0)))

(test-case "series with a zero constant term"
  (define mul-series (solution "3.60" 'mul-series))
  (check-series (head (mul-series (series 0 1) (series 0 1)) 5) '(0 0 1 0 0))
  (check-series (head (mul-series (series 0 1) (series 3 0 5)) 5) '(0 3 0 5 0)))

(test-case "infinite series: 1/(1-x) squared is 1 2 3 4 ..."
  (define mul-series (solution "3.60" 'mul-series))
  (check-series (head (mul-series ones ones) 6) '(1 2 3 4 5 6)))

(test-case "e^x * e^x = e^(2x)"
  (define mul-series (solution "3.60" 'mul-series))
  (check-series (head (mul-series exp-s exp-s) 7)
                '(1 2 2 4/3 2/3 4/15 4/45)))

(test-case "sin^2 + cos^2 = 1"
  (define mul-series (solution "3.60" 'mul-series))
  (check-series (head (add-s (mul-series sin-s sin-s) (mul-series cos-s cos-s)) 10)
                '(1 0 0 0 0 0 0 0 0 0)))

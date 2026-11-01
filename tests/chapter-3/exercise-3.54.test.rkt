#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.54.rkt must (#%provide mul-streams factorials)
;;   (mul-streams s1 s2)  -> the stream of elementwise products
;;   factorials           -> the stream 1, 2, 6, 24, 120, ... (element n, from 0, is (n+1)!)
;; Define add-streams, integers, stream-car/stream-cdr, etc. yourself in the file.

(define (head s n)
  (if (or (= n 0) (null? s))
      '()
      (cons (car s) (head (force (cdr s)) (- n 1)))))

(define (ints n) (cons-stream n (ints (+ n 1))))

(define (nth-stream s n)
  (if (= n 0) (car s) (nth-stream (force (cdr s)) (- n 1))))

(test-case "mul-streams multiplies elementwise"
  (define mul-streams (solution "3.54" 'mul-streams))
  (check-equal? (head (mul-streams (ints 1) (ints 1)) 5) '(1 4 9 16 25))
  (check-equal? (head (mul-streams (ints 1) (ints 10)) 3) '(10 22 36)))

(test-case "mul-streams with a constant stream"
  (define mul-streams (solution "3.54" 'mul-streams))
  (define twos (cons-stream 2 twos))
  (check-equal? (head (mul-streams twos (ints 0)) 4) '(0 2 4 6)))

(test-case "factorials"
  (define factorials (solution "3.54" 'factorials))
  (check-equal? (head factorials 8) '(1 2 6 24 120 720 5040 40320)))

(test-case "factorials goes far without trouble"
  (define factorials (solution "3.54" 'factorials))
  (check-equal? (nth-stream factorials 13) 87178291200))

#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.76.rkt must (#%provide smooth make-zero-crossings)
;;   (smooth s) -> stream whose elements are the average of two successive elements of s
;;   (make-zero-crossings input-stream last-value) -> the zero-crossing stream of Exercise 3.74,
;;       called as (make-zero-crossings data 0); it must not do any smoothing itself
;; Define sign-change-detector (Exercise 3.74; 0 counts as positive) and stream-map yourself.

(define (head s n)
  (if (or (= n 0) (null? s))
      '()
      (cons (car s) (head (force (cdr s)) (- n 1)))))

(define (check-list actual expected)
  (check-equal? (length actual) (length expected))
  (for-each (lambda (a e) (check-= a e 1e-9)) actual expected))

(define (from-list-then-fours l)
  (if (null? l)
      (cons-stream 4 (from-list-then-fours l))
      (cons-stream (car l) (from-list-then-fours (cdr l)))))

(define (ints n) (cons-stream n (ints (+ n 1))))

(define data '(1 2 1.5 1 0.5 -0.1 -2 -3 -2 -0.5 0.2 3 4))

(test-case "smooth averages successive elements"
  (define smooth (solution "3.76" 'smooth))
  (check-list (head (smooth (ints 1)) 4) '(1.5 2.5 3.5 4.5))
  (check-list (head (smooth (from-list-then-fours '(0 10 -10))) 5) '(5 0 -3 4 4)))

(test-case "smooth of the example signal"
  (define smooth (solution "3.76" 'smooth))
  (check-list (head (smooth (from-list-then-fours data)) 12)
              '(1.5 1.75 1.25 0.75 0.2 -1.05 -2.5 -2.5 -1.25 -0.15 1.6 3.5)))

(test-case "make-zero-crossings on the raw example signal"
  (define make-zero-crossings (solution "3.76" 'make-zero-crossings))
  (check-equal? (head (make-zero-crossings (from-list-then-fours data) 0) 13)
                '(0 0 0 0 0 -1 0 0 0 0 1 0 0)))

(test-case "zero crossings of the smoothed signal"
  (define smooth (solution "3.76" 'smooth))
  (define make-zero-crossings (solution "3.76" 'make-zero-crossings))
  (check-equal? (head (make-zero-crossings (smooth (from-list-then-fours data)) 0) 12)
                '(0 0 0 0 0 -1 0 0 0 0 1 0)))

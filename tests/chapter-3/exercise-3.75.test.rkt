#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.75.rkt must (#%provide make-zero-crossings)
;;   (make-zero-crossings input-stream last-value last-avpt) -> zero crossings of the signal
;;   obtained by averaging each value with the previous value (last-value is the previous raw
;;   value, last-avpt the previous averaged value); called as (make-zero-crossings data 0 0).
;; Define sign-change-detector (Exercise 3.74; 0 counts as positive) yourself in the file.

(define (head s n)
  (if (or (= n 0) (null? s))
      '()
      (cons (car s) (head (force (cdr s)) (- n 1)))))

(define (from-list-then-fours l)
  (if (null? l)
      (cons-stream 4 (from-list-then-fours l))
      (cons-stream (car l) (from-list-then-fours (cdr l)))))

(define data '(1 2 1.5 1 0.5 -0.1 -2 -3 -2 -0.5 0.2 3 4))

(test-case "zero crossings of the smoothed example signal"
  (define make-zero-crossings (solution "3.75" 'make-zero-crossings))
  (check-equal? (head (make-zero-crossings (from-list-then-fours data) 0 0) 13)
                '(0 0 0 0 0 0 -1 0 0 0 0 1 0)))

(test-case "the previous averaged value (not the raw value) is compared"
  (define make-zero-crossings (solution "3.75" 'make-zero-crossings))
  ;; raw 2 -2 2 -2 ..: averages 1 0 0 0 0 ... after start, no crossing; a raw-vs-average bug
  ;; reports spurious crossings
  (check-equal? (head (make-zero-crossings
                       (cons-stream 2 (cons-stream -2 (cons-stream 2 (cons-stream -2 (cons-stream 2 (cons-stream -2 (from-list-then-fours '())))))))
                       0 0)
                      7)
                '(0 0 0 0 0 0 0)))

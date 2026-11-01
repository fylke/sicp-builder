#lang sicp
;; Exercise 1.3 style warm-up: runs with `racket exercises/example.rkt`.
(#%require rackunit)

(define (square x) (* x x))

(define (sum-of-squares-of-two-largest a b c)
  (- (+ (square a) (square b) (square c))
     (square (min a b c))))

(check-equal? (sum-of-squares-of-two-largest 1 2 3) 13)

;; Streams (section 3.5): cons-stream is built in; the selectors are defined as in the book.
(define (stream-car s) (car s))
(define (stream-cdr s) (force (cdr s)))
(define ones (cons-stream 1 ones))
(check-equal? (stream-car (stream-cdr ones)) 1)

;; The picture language of section 2.2.4 is a separate module:
;;   (require sicp-pict)
;;   (paint einstein)

(display "ok")
(newline)

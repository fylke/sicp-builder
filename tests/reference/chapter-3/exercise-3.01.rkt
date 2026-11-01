#lang sicp
(#%provide make-accumulator)

(define (make-accumulator sum)
  (lambda (x)
    (set! sum (+ sum x))
    sum))

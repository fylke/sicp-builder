#lang sicp
(#%provide make-zero-crossings)

(define (stream-car s) (car s))
(define (stream-cdr s) (force (cdr s)))

(define (sign-change-detector current last)
  (cond ((and (>= last 0) (< current 0)) -1)
        ((and (< last 0) (>= current 0)) 1)
        (else 0)))

(define (make-zero-crossings input-stream last-value last-avpt)
  (let ((avpt (/ (+ (stream-car input-stream) last-value) 2)))
    (cons-stream
     (sign-change-detector avpt last-avpt)
     (make-zero-crossings (stream-cdr input-stream)
                          (stream-car input-stream)
                          avpt))))

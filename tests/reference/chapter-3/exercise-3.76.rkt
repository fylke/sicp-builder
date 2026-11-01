#lang sicp
(#%provide smooth make-zero-crossings)

(define (stream-car s) (car s))
(define (stream-cdr s) (force (cdr s)))

(define (stream-map proc . argstreams)
  (if (null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))

(define (sign-change-detector current last)
  (cond ((and (>= last 0) (< current 0)) -1)
        ((and (< last 0) (>= current 0)) 1)
        (else 0)))

(define (smooth s)
  (stream-map (lambda (a b) (/ (+ a b) 2)) s (stream-cdr s)))

(define (make-zero-crossings input-stream last-value)
  (cons-stream
   (sign-change-detector (stream-car input-stream) last-value)
   (make-zero-crossings (stream-cdr input-stream) (stream-car input-stream))))

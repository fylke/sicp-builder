#lang sicp
(#%provide sign-change-detector zero-crossings-of)

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

(define (zero-crossings-of sense-data)
  (stream-map sign-change-detector
              sense-data
              (cons-stream 0 sense-data)))

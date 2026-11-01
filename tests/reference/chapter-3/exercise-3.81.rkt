#lang sicp
(#%provide rand-stream)

(define (stream-car s) (car s))
(define (stream-cdr s) (force (cdr s)))

(define (rand-update x)
  (remainder (+ (* 1103515245 x) 12345) 2147483648))

(define initial-seed 1)

(define (rand-from requests x)
  (if (null? requests)
      the-empty-stream
      (let ((request (stream-car requests)))
        (if (eq? request 'generate)
            (let ((next (rand-update x)))
              (cons-stream next (rand-from (stream-cdr requests) next)))
            (rand-from (stream-cdr requests) (cadr request))))))

(define (rand-stream requests)
  (rand-from requests initial-seed))

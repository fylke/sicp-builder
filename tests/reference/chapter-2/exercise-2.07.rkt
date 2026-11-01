#lang sicp
(#%provide make-interval lower-bound upper-bound)

(define (make-interval a b) (cons a b))
(define (lower-bound i) (car i))
(define (upper-bound i) (cdr i))

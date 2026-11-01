#lang sicp
(#%provide same-parity)

(define (same-parity x . rest)
  (define (same? y) (eq? (even? x) (even? y)))
  (define (keep items)
    (cond ((null? items) '())
          ((same? (car items)) (cons (car items) (keep (cdr items))))
          (else (keep (cdr items)))))
  (cons x (keep rest)))

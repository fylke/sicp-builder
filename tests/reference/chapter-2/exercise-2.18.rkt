#lang sicp
(#%provide reverse)

(define (reverse l)
  (define (iter rest result)
    (if (null? rest)
        result
        (iter (cdr rest) (cons (car rest) result))))
  (iter l '()))

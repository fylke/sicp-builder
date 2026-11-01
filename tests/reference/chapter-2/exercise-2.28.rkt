#lang sicp
(#%provide fringe)

(define (fringe tree)
  (cond ((null? tree) '())
        ((pair? tree) (append (fringe (car tree)) (fringe (cdr tree))))
        (else (list tree))))

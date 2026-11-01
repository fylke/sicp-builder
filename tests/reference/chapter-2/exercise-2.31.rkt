#lang sicp
(#%provide tree-map square-tree)

(define (square x) (* x x))

(define (tree-map proc tree)
  (cond ((null? tree) '())
        ((pair? tree) (cons (tree-map proc (car tree))
                            (tree-map proc (cdr tree))))
        (else (proc tree))))

(define (square-tree tree) (tree-map square tree))

#lang sicp
(#%provide square-tree square-tree-map)

(define (square x) (* x x))

(define (square-tree tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))

(define (square-tree-map tree)
  (map (lambda (sub)
         (cond ((null? sub) sub)
               ((pair? sub) (square-tree-map sub))
               (else (square sub))))
       tree))

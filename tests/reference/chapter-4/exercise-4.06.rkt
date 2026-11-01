#lang sicp
(#%provide let->combination)

(define (let->combination exp)
  (let ((bindings (cadr exp))
        (body (cddr exp)))
    (cons (cons 'lambda
                (cons (map car bindings) body))
          (map cadr bindings))))

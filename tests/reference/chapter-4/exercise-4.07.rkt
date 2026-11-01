#lang sicp
(#%provide let*->nested-lets)

(define (let*->nested-lets exp)
  (define (nest bindings body)
    (if (null? bindings)
        (if (and (pair? body) (null? (cdr body)))
            (car body)
            (cons 'let (cons '() body)))
        (list 'let
              (list (car bindings))
              (nest (cdr bindings) body))))
  (nest (cadr exp) (cddr exp)))

#lang sicp
(#%provide let->combination)

(define (let->combination exp)
  (let ((name-or-bindings (cadr exp)))
    (if (symbol? name-or-bindings)
        (let* ((name name-or-bindings)
               (bindings (caddr exp))
               (body (cdddr exp))
               (parameters (map car bindings))
               (initial-values (map cadr bindings)))
          (list 'letrec
                (list (list name (cons 'lambda (cons parameters body))))
                (cons name initial-values)))
        (let ((bindings name-or-bindings)
              (body (cddr exp)))
          (cons (cons 'lambda
                      (cons (map car bindings) body))
                (map cadr bindings))))))

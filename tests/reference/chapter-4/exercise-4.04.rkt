#lang sicp
(#%provide and->if or->if)

(define (and->if exp)
  (define (expand expressions)
    (cond ((null? expressions) #t)
          ((null? (cdr expressions)) (car expressions))
          (else (list 'if (car expressions)
                      (expand (cdr expressions))
                      #f))))
  (expand (cdr exp)))

(define (or->if exp)
  (define (contains-symbol? expression target)
    (cond ((symbol? expression) (eq? expression target))
          ((pair? expression)
           (or (contains-symbol? (car expression) target)
               (contains-symbol? (cdr expression) target)))
          (else #f)))
  (define (fresh-temporary)
    (define (find n)
      (let ((candidate
             (string->symbol
              (string-append "or-value-" (number->string n)))))
        (if (contains-symbol? exp candidate)
            (find (+ n 1))
            candidate)))
    (find 0))
  (define (expand expressions)
    (cond ((null? expressions) #f)
          ((null? (cdr expressions)) (car expressions))
          (else
           (let ((temporary (fresh-temporary)))
             (list 'let
                   (list (list temporary (car expressions)))
                   (list 'if temporary temporary
                         (expand (cdr expressions))))))))
  (expand (cdr exp)))

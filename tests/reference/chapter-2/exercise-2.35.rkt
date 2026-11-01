#lang sicp
(#%provide count-leaves)

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence) (accumulate op initial (cdr sequence)))))

(define (count-leaves t)
  (accumulate +
              0
              (map (lambda (sub)
                     (cond ((null? sub) 0)
                           ((pair? sub) (count-leaves sub))
                           (else 1)))
                   t)))

#lang sicp
(#%provide cycle?)

;; Floyd's tortoise and hare: constant space
(define (cycle? x)
  (define (loop slow fast)
    (cond ((not (pair? fast)) #f)
          ((not (pair? (cdr fast))) #f)
          (else
           (let ((slow (cdr slow))
                 (fast (cdr (cdr fast))))
             (if (eq? slow fast)
                 #t
                 (loop slow fast))))))
  (loop x x))

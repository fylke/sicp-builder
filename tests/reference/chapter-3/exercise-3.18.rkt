#lang sicp
(#%provide cycle?)

(define (cycle? x)
  (let ((seen '()))
    (define (walk x)
      (cond ((not (pair? x)) #f)
            ((memq x seen) #t)
            (else (set! seen (cons x seen))
                  (walk (cdr x)))))
    (walk x)))

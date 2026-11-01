#lang sicp
(#%provide count-pairs)

(define (count-pairs x)
  (let ((seen '()))
    (define (walk x)
      (if (or (not (pair? x)) (memq x seen))
          'done
          (begin (set! seen (cons x seen))
                 (walk (car x))
                 (walk (cdr x)))))
    (walk x)
    (length seen)))

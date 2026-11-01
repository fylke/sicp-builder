#lang sicp
(#%provide make-monitored)

(define (make-monitored f)
  (let ((count 0))
    (define (mf m)
      (cond ((eq? m 'how-many-calls?) count)
            ((eq? m 'reset-count) (set! count 0) count)
            (else (set! count (+ count 1))
                  (f m))))
    mf))

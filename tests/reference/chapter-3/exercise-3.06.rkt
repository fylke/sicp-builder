#lang sicp
(#%provide rand)

(define (rand-update x) (remainder (+ (* 1103515245 x) 12345) 2147483648))

(define rand
  (let ((x 1))
    (lambda (m)
      (cond ((eq? m 'generate)
             (set! x (rand-update x))
             x)
            ((eq? m 'reset)
             (lambda (new-value) (set! x new-value) x))
            (else (error "Unknown request: RAND" m))))))

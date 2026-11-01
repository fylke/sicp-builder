#lang sicp
(#%provide split)

(define (split first-combine second-combine)
  (define (go painter n)
    (if (= n 0)
        painter
        (let ((smaller (go painter (- n 1))))
          (first-combine painter (second-combine smaller smaller)))))
  go)

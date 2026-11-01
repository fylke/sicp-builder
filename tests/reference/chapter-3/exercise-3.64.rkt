#lang sicp
(#%provide stream-limit)

(define (stream-limit s tolerance)
  (let ((a (car s))
        (rest (force (cdr s))))
    (let ((b (car rest)))
      (if (< (abs (- b a)) tolerance)
          b
          (stream-limit rest tolerance)))))

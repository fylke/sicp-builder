#lang sicp
(#%provide f)

(define f
  (let ((state 1))
    (lambda (x)
      (set! state (* state x))
      state)))

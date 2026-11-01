#lang sicp
;; Your exercises/chapter-4/exercise-4.07.rkt must (#%provide let*->nested-lets).
;; let*->nested-lets: (let*->nested-lets exp) rewrites sequential let* bindings as nested lets.
;; No additional definitions are required.
(#%require rackunit "../lib.rkt")

(test-case "let* bindings nest in order and retain the body"
  (define f (solution "4.07" 'let*->nested-lets))
  (check-equal? (f '(let* ((x 3) (y (+ x 2)) (z (+ x y 5))) (* x z)))
                '(let ((x 3))
                   (let ((y (+ x 2)))
                     (let ((z (+ x y 5))) (* x z)))))
  (check-equal? (f '(let* () 17)) 17))

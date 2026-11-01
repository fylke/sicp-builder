#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-1/exercise-1.36.rkt must (#%provide x-x-1000 x-x-1000-damped)
;;   x-x-1000        -- a number (not a procedure): solution of x^x = 1000 found by fixed-point
;;                      of x -> log(1000)/log(x), without average damping
;;   x-x-1000-damped -- the same, but with average damping
;; (define fixed-point yourself, modified to print its approximations)

(define (check-solution x)
  (check-= x 4.555532270803653 1e-3)
  (check-= (expt x x) 1000 0.1))

(test-case "x^x = 1000 without average damping"
  (check-solution (solution "1.36" 'x-x-1000)))

(test-case "x^x = 1000 with average damping"
  (check-solution (solution "1.36" 'x-x-1000-damped)))

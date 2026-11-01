#lang sicp
;; Exercise 1.36
;;
;; Modify `fixed-point` so that
;; it prints the sequence of approximations it generates, using the `newline`
;; and `display` primitives shown in [Exercise 1.22](../chapter-1/exercise-1.22.rkt).  Then find a
;; solution to ${x^x = 1000}$ by finding a fixed point of $x \mapsto {\log(1000) / \log(x)}$.  (Use Scheme’s primitive `log`
;; procedure, which computes natural logarithms.)  Compare the number of steps
;; this takes with and without average damping.  (Note that you cannot start
;; `fixed-point` with a guess of 1, as this would cause division by
;; ${\log(1) = 0}$.)

;; Test: raco test tests/chapter-1/exercise-1.36.test.rkt
;; Your exercises/chapter-1/exercise-1.36.rkt must (#%provide x-x-1000 x-x-1000-damped)
;;   x-x-1000        -- a number (not a procedure): solution of x^x = 1000 found by fixed-point
;;                      of x -> log(1000)/log(x), without average damping
;;   x-x-1000-damped -- the same, but with average damping
;; (define fixed-point yourself, modified to print its approximations)


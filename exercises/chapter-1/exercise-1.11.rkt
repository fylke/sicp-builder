#lang sicp
;; Exercise 1.11
;;
;; A function $f$ is defined by
;; the rule that ${f(n) = n}$ if ${n < 3}$ and ${f(n)} = {f(n-1)} + {2f(n-2)} + {3f(n-3)}$ if ${n \ge 3}$.
;; Write a procedure that computes $f$ by means of a recursive process.  Write a procedure that
;; computes $f$ by means of an iterative process.

;; Test: raco test tests/chapter-1/exercise-1.11.test.rkt
;; Your exercises/chapter-1/exercise-1.11.rkt must (#%provide f-recursive f-iterative)
;;   (f-recursive n) -- f(n) = n if n < 3, else f(n-1) + 2 f(n-2) + 3 f(n-3), by a recursive process
;;   (f-iterative n) -- the same function, by an iterative process


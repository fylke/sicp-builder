#lang sicp
;; Exercise 1.45
;;
;; We saw in 1.3.3
;; that attempting to compute square roots by naively finding a fixed point of
;; ${y \mapsto x / y}$ does not converge, and that this can be fixed by average
;; damping.  The same method works for finding cube roots as fixed points of the
;; average-damped ${y \mapsto x / y^2}$.  Unfortunately, the process does not
;; work for fourth roots—a single average damp is not enough to make a
;; fixed-point search for ${y \mapsto x / y^3}$ converge.  On the other hand, if
;; we average damp twice (i.e., use the average damp of the average damp of
;; ${y \mapsto x / y^3}$) the fixed-point search does converge.  Do some experiments
;; to determine how many average damps are required to compute $n^{\text{th}}$ roots as a
;; fixed-point search based upon repeated average damping of ${y \mapsto x / y^{\kern0.1em n-1}}$.
;; Use this to implement a simple procedure for computing
;; $n^{\text{th}}$ roots using `fixed-point`, `average-damp`, and the
;; `repeated` procedure of [Exercise 1.43](../chapter-1/exercise-1.43.rkt).  Assume that any arithmetic
;; operations you need are available as primitives.

;; Test: raco test tests/chapter-1/exercise-1.45.test.rkt
;; Your exercises/chapter-1/exercise-1.45.rkt must (#%provide nth-root)
;;   (nth-root x n) -- the n-th root of the positive number x (n >= 2) found by a fixed-point
;;                     search with the right number of average damps, for any n
;; (define fixed-point, average-damp, repeated, ... yourself)


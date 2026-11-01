#lang sicp
;; Exercise 1.39
;;
;; A continued fraction
;; representation of the tangent function was published in 1770 by the German
;; mathematician J.H. Lambert:
;;
;; $$
;; {\tan x} \,=\, {\frac{x}{1 - \frac{x^2}{3 - \frac{x^2}{5 - \dots}}}\,,}
;; $$
;;
;; where $x$ is in radians.  Define a procedure `(tan-cf x k)` that
;; computes an approximation to the tangent function based on Lambert’s formula.
;; `k` specifies the number of terms to compute, as in [Exercise 1.37](../chapter-1/exercise-1.37.rkt).

;; Test: raco test tests/chapter-1/exercise-1.39.test.rkt
;; Your exercises/chapter-1/exercise-1.39.rkt must (#%provide tan-cf)
;;   (tan-cf x k) -- Lambert's continued fraction approximation of tan x (x in radians),
;;                   truncated after k terms
;; (define cont-frac yourself)


#lang sicp
;; Exercise 3.62
;;
;; Use the results of [Exercise 3.60](../chapter-3/exercise-3.60.rkt)
;; and [Exercise 3.61](../chapter-3/exercise-3.61.rkt) to define a procedure `div-series` that
;; divides two power series.  `Div-series` should work for any two series,
;; provided that the denominator series begins with a nonzero constant term.  (If
;; the denominator has a zero constant term, then `div-series` should signal
;; an error.)  Show how to use `div-series` together with the result of
;; [Exercise 3.59](../chapter-3/exercise-3.59.rkt) to generate the power series for tangent.

;; Test: raco test tests/chapter-3/exercise-3.62.test.rkt
;; Your exercises/chapter-3/exercise-3.62.rkt must (#%provide div-series tangent-series)
;;   (div-series s1 s2) -> the series s1/s2; signals an error if s2's constant term is 0
;;   tangent-series     -> the series of tan x, built with div-series from sine and cosine
;; Define mul-series, invert-unit-series, sine-series, cosine-series and the stream helpers
;; yourself in the file (Exercises 3.59-3.61).


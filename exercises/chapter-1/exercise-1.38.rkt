#lang sicp
;; Exercise 1.38
;;
;; In 1737, the Swiss mathematician
;; Leonhard Euler published a memoir *De Fractionibus Continuis*, which
;; included a continued fraction expansion for ${e - 2}$, where $e$ is the base
;; of the natural logarithms.  In this fraction, the $N_i$ are all 1, and
;; the $D_i$ are successively 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, ….
;; Write a program that uses your `cont-frac` procedure from [Exercise 1.37](../chapter-1/exercise-1.37.rkt)
;; to approximate $e$, based on Euler’s expansion.

;; Test: raco test tests/chapter-1/exercise-1.38.test.rkt
;; Your exercises/chapter-1/exercise-1.38.rkt must (#%provide e-approx)
;;   (e-approx k) -- approximation of e = 2 + (Euler's continued fraction with N_i = 1 and
;;                   D_i = 1, 2, 1, 1, 4, 1, 1, 6, ...) truncated after k terms
;; (define cont-frac yourself)


#lang sicp
;; Exercise 3.60
;;
;; With power series represented as
;; streams of coefficients as in [Exercise 3.59](../chapter-3/exercise-3.59.rkt), adding series is implemented
;; by `add-streams`.  Complete the definition of the following procedure for
;; multiplying series:
;;
;; ```scheme
;; (define (mul-series s1 s2)
;;   (cons-stream ⟨??⟩ (add-streams ⟨??⟩ ⟨??⟩)))
;; ```
;;
;; You can test your procedure by verifying that ${\sin^2x + \cos^2x = 1,}$
;; using the series from [Exercise 3.59](../chapter-3/exercise-3.59.rkt).

;; Test: raco test tests/chapter-3/exercise-3.60.test.rkt
;; Your exercises/chapter-3/exercise-3.60.rkt must (#%provide mul-series)
;;   (mul-series s1 s2) -> the product of two power series given as coefficient streams
;; Define add-streams, scale-stream, stream-map etc. yourself in the file.


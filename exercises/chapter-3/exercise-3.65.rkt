#lang sicp
;; Exercise 3.65
;;
;; Use the series
;;
;; $$
;;   \ln 2 \,=\, 1 - {1\over2} + {1\over3} - {1\over4} + \dots
;; $$
;;
;; to compute three sequences of approximations to the natural logarithm of 2, in
;; the same way we did above for $\pi$.  How rapidly do these sequences
;; converge?

;; Test: raco test tests/chapter-3/exercise-3.65.test.rkt
;; Your exercises/chapter-3/exercise-3.65.rkt must (#%provide ln2-stream ln2-euler ln2-accelerated)
;;   ln2-stream      -> partial sums of 1 - 1/2 + 1/3 - 1/4 ... (first element 1, floating point)
;;   ln2-euler       -> ln2-stream after one Euler transform
;;   ln2-accelerated -> ln2-stream with repeated Euler transforms (tableau, first elements)
;; Define partial-sums, euler-transform etc. yourself in the file.


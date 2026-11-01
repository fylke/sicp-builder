#lang sicp
;; Exercise 3.55
;;
;; Define a procedure
;; `partial-sums` that takes as argument a stream $S$ and returns the
;; stream whose elements are $S_0$, ${S_0 + S_1}$, ${S_0 + S_1} + {S_2, \dots}$.
;; For example, `(partial-sums integers)` should be the
;; stream 1, 3, 6, 10, 15, ….

;; Test: raco test tests/chapter-3/exercise-3.55.test.rkt
;; Your exercises/chapter-3/exercise-3.55.rkt must (#%provide partial-sums)
;;   (partial-sums s) -> the stream S0, S0+S1, S0+S1+S2, ...
;; Define add-streams, stream-map, stream-car/stream-cdr etc. yourself in the file.


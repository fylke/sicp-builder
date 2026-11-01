#lang sicp
;; Exercise 3.67
;;
;; Modify the `pairs` procedure
;; so that `(pairs integers integers)` will produce the stream of *all*
;; pairs of integers ${(i, j)}$ (without the condition ${i \le j}$).  Hint:
;; You will need to mix in an additional stream.

;; Test: raco test tests/chapter-3/exercise-3.67.test.rkt
;; Your exercises/chapter-3/exercise-3.67.rkt must (#%provide pairs)
;;   (pairs s t) -> stream of ALL pairs (list (s_i) (t_j)), including those with i > j
;; Define interleave, stream-map etc. yourself in the file.


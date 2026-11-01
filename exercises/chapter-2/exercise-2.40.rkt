#lang sicp
;; Exercise 2.40
;;
;; Define a procedure
;; `unique-pairs` that, given an integer $n$, generates the sequence of
;; pairs ${(i, j)}$ with ${1 \le j} < {i \le n}$.  Use `unique-pairs`
;; to simplify the definition of `prime-sum-pairs` given above.

;; Test: raco test tests/chapter-2/exercise-2.40.test.rkt
;; Your exercises/chapter-2/exercise-2.40.rkt must (#%provide unique-pairs prime-sum-pairs)
;;   (unique-pairs n)     -- the sequence of pairs (i j) (as two-element lists) with
;;                           1 <= j < i <= n (any order)
;;   (prime-sum-pairs n)  -- the list of triples (i j (+ i j)) for those pairs (i j) from
;;                           unique-pairs whose sum is prime (any order)
;; You must define the supporting procedures (prime?, accumulate, flatmap,
;; enumerate-interval, ...) yourself; they are not tested here.


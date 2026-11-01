#lang sicp
;; Exercise 2.41
;;
;; Write a procedure to find all
;; ordered triples of distinct positive integers $i$, $j$, and $k$ less than
;; or equal to a given integer $n$ that sum to a given integer $s$.

;; Test: raco test tests/chapter-2/exercise-2.41.test.rkt
;; Your exercises/chapter-2/exercise-2.41.rkt must (#%provide triples-with-sum)
;;   (triples-with-sum n s) -- all sets of three distinct positive integers i, j, k <= n
;;                             with i + j + k = s, as a list of three-element lists
;;                             (each set once; the order inside a triple and the order of
;;                             the triples do not matter)
;; You must define the supporting procedures (flatmap, enumerate-interval, ...) yourself.


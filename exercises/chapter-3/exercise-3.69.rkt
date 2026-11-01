#lang sicp
;; Exercise 3.69
;;
;; Write a procedure `triples`
;; that takes three infinite streams, $S$, $T$, and $U$, and produces the
;; stream of triples ${(S_i, T_j, U_k)}$ such that ${i \le j \le k}$.
;; Use `triples` to generate the stream of all Pythagorean
;; triples of positive integers, i.e., the triples ${(i, j, k)}$ such that
;; ${i \le j}$ and ${i^2 + j^2 = k^2}$.

;; Test: raco test tests/chapter-3/exercise-3.69.test.rkt
;; Your exercises/chapter-3/exercise-3.69.rkt must (#%provide triples pythagorean-triples)
;;   (triples s t u)      -> stream of lists (list Si Tj Uk) with i <= j <= k
;;   pythagorean-triples  -> stream of (list i j k) with i <= j <= k and i^2 + j^2 = k^2,
;;                           built from (triples integers integers integers)
;; Define integers, pairs, interleave, stream-map, stream-filter yourself in the file.


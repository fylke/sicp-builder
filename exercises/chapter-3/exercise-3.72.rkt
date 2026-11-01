#lang sicp
;; Exercise 3.72
;;
;; In a similar way to [Exercise 3.71](../chapter-3/exercise-3.71.rkt)
;; generate a stream of all numbers that can be written as the sum of two
;; squares in three different ways (showing how they can be so written).

;; Test: raco test tests/chapter-3/exercise-3.72.test.rkt
;; Your exercises/chapter-3/exercise-3.72.rkt must (#%provide squares-three-ways)
;;   squares-three-ways -> stream of the numbers that can be written as the sum of two
;;   positive squares in three different ways (pairs i <= j), in increasing order,
;;   each number once: 325 425 650 ...
;; Define weighted-pairs etc. (Exercise 3.70) yourself in the file.


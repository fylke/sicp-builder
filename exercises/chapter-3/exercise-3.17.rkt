#lang sicp
;; Exercise 3.17
;;
;; Devise a correct version of the
;; `count-pairs` procedure of [Exercise 3.16](../chapter-3/exercise-3.16.rkt) that returns the number of
;; distinct pairs in any structure.  (Hint: Traverse the structure, maintaining an
;; auxiliary data structure that is used to keep track of which pairs have already
;; been counted.)

;; Test: raco test tests/chapter-3/exercise-3.17.test.rkt
;; Your exercises/chapter-3/exercise-3.17.rkt must (#%provide count-pairs)
;;   (count-pairs x) -> the number of distinct pairs in the structure x
;;                      (must terminate on structures containing cycles)


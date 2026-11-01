#lang sicp
;; Exercise 2.48
;;
;; A directed line segment in the
;; plane can be represented as a pair of vectors—the vector running from the
;; origin to the start-point of the segment, and the vector running from the
;; origin to the end-point of the segment.  Use your vector representation from
;; [Exercise 2.46](../chapter-2/exercise-2.46.rkt) to define a representation for segments with a constructor
;; `make-segment` and selectors `start-segment` and `end-segment`.

;; Test: raco test tests/chapter-2/exercise-2.48.test.rkt
;; Your exercises/chapter-2/exercise-2.48.rkt must (#%provide make-vect xcor-vect ycor-vect
;;                                                  make-segment start-segment end-segment)
;;   (make-vect x y), (xcor-vect v), (ycor-vect v) -- your vectors from Exercise 2.46
;;                                                    (define them yourself)
;;   (make-segment start end) -- the directed segment from vector start to vector end
;;   (start-segment s) (end-segment s) -- its endpoints


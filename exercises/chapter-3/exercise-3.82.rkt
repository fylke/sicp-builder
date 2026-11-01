#lang sicp
;; Exercise 3.82
;;
;; Redo [Exercise 3.5](../chapter-3/exercise-3.05.rkt) on Monte
;; Carlo integration in terms of streams.  The stream version of
;; `estimate-integral` will not have an argument telling how many trials to
;; perform.  Instead, it will produce a stream of estimates based on successively
;; more trials.

;; Test: raco test tests/chapter-3/exercise-3.82.test.rkt
;; Your exercises/chapter-3/exercise-3.82.rkt must (#%provide estimate-integral)
;;   (estimate-integral P x1 x2 y1 y2) -> stream of Monte Carlo estimates of the area of the
;;   region of the rectangle [x1,x2] x [y1,y2] where the predicate (P x y) is true; element k
;;   is the estimate after k+1 random trials (area of rectangle * fraction of hits so far).
;; Define random-in-range and the stream helpers yourself in the file.


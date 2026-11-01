#lang sicp
;; Exercise 2.10
;;
;; Ben Bitdiddle, an expert systems
;; programmer, looks over Alyssa’s shoulder and comments that it is not clear what
;; it means to divide by an interval that spans zero.  Modify Alyssa’s code to
;; check for this condition and to signal an error if it occurs.

;; Test: raco test tests/chapter-2/exercise-2.10.test.rkt
;; Your exercises/chapter-2/exercise-2.10.rkt must (#%provide make-interval lower-bound upper-bound
;;                                                  div-interval)
;;   (make-interval a b) -- the interval from a to b; (lower-bound i), (upper-bound i) its ends
;;   (div-interval x y)  -- x / y; it must signal an error (with `error`) if y spans zero
;; You must define Alyssa's other procedures that div-interval needs (e.g. mul-interval)
;; yourself, but they are not tested here.


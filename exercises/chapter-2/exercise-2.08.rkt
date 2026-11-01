#lang sicp
;; Exercise 2.8
;;
;; Using reasoning analogous to
;; Alyssa’s, describe how the difference of two intervals may be computed.  Define
;; a corresponding subtraction procedure, called `sub-interval`.

;; Test: raco test tests/chapter-2/exercise-2.08.test.rkt
;; Your exercises/chapter-2/exercise-2.08.rkt must (#%provide make-interval lower-bound upper-bound
;;                                                  sub-interval)
;;   (make-interval a b) -- the interval from a to b; (lower-bound i), (upper-bound i) its ends
;;                          (define these yourself, as in Exercise 2.7)
;;   (sub-interval x y)  -- the interval of all possible values of (a - b), a in x, b in y


#lang sicp
;; Exercise 2.12
;;
;; Define a constructor
;; `make-center-percent` that takes a center and a percentage tolerance and
;; produces the desired interval.  You must also define a selector `percent`
;; that produces the percentage tolerance for a given interval.  The `center`
;; selector is the same as the one shown above.

;; Test: raco test tests/chapter-2/exercise-2.12.test.rkt
;; Your exercises/chapter-2/exercise-2.12.rkt must (#%provide make-interval lower-bound upper-bound
;;                                                  make-center-percent center percent)
;;   (make-interval a b) -- the interval from a to b; (lower-bound i), (upper-bound i) its ends
;;   (make-center-percent c p) -- the interval centred at c with tolerance p percent
;;   (center i)  -- the midpoint of i
;;   (percent i) -- the percentage tolerance of i (width / center * 100)
;; You define all of these yourself (center as in the book).


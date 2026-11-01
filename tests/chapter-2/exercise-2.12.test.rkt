#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.12.rkt must (#%provide make-interval lower-bound upper-bound
;;                                                  make-center-percent center percent)
;;   (make-interval a b) -- the interval from a to b; (lower-bound i), (upper-bound i) its ends
;;   (make-center-percent c p) -- the interval centred at c with tolerance p percent
;;   (center i)  -- the midpoint of i
;;   (percent i) -- the percentage tolerance of i (width / center * 100)
;; You define all of these yourself (center as in the book).

(test-case "make-center-percent gives the right bounds"
  (define lower-bound (solution "2.12" 'lower-bound))
  (define upper-bound (solution "2.12" 'upper-bound))
  (define make-center-percent (solution "2.12" 'make-center-percent))
  (define i (make-center-percent 100 10))
  (check-= (lower-bound i) 90 1e-9)
  (check-= (upper-bound i) 110 1e-9)
  (define j (make-center-percent 5 0.5))
  (check-= (lower-bound j) 4.975 1e-9)
  (check-= (upper-bound j) 5.025 1e-9))

(test-case "center"
  (define make-center-percent (solution "2.12" 'make-center-percent))
  (define center (solution "2.12" 'center))
  (check-= (center (make-center-percent 100 10)) 100 1e-9)
  (check-= (center (make-center-percent 6.8 5)) 6.8 1e-9))

(test-case "percent"
  (define make-center-percent (solution "2.12" 'make-center-percent))
  (define percent (solution "2.12" 'percent))
  (check-= (percent (make-center-percent 100 10)) 10 1e-9)
  (check-= (percent (make-center-percent 6.8 5)) 5 1e-9)
  (check-= (percent (make-center-percent 50 0)) 0 1e-9))

(test-case "percent of an interval made from bounds"
  (define make-interval (solution "2.12" 'make-interval))
  (define percent (solution "2.12" 'percent))
  (check-= (percent (make-interval 9 11)) 10 1e-9)
  (check-= (percent (make-interval 95 105)) 5 1e-9))

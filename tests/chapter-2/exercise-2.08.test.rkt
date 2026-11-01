#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.08.rkt must (#%provide make-interval lower-bound upper-bound
;;                                                  sub-interval)
;;   (make-interval a b) -- the interval from a to b; (lower-bound i), (upper-bound i) its ends
;;                          (define these yourself, as in Exercise 2.7)
;;   (sub-interval x y)  -- the interval of all possible values of (a - b), a in x, b in y

(test-case "difference of two intervals"
  (define make-interval (solution "2.08" 'make-interval))
  (define lower-bound (solution "2.08" 'lower-bound))
  (define upper-bound (solution "2.08" 'upper-bound))
  (define sub-interval (solution "2.08" 'sub-interval))
  (define d (sub-interval (make-interval 5 7) (make-interval 1 2)))
  (check-= (lower-bound d) 3 1e-9)
  (check-= (upper-bound d) 6 1e-9))

(test-case "order of the arguments matters"
  (define make-interval (solution "2.08" 'make-interval))
  (define lower-bound (solution "2.08" 'lower-bound))
  (define upper-bound (solution "2.08" 'upper-bound))
  (define sub-interval (solution "2.08" 'sub-interval))
  (define d (sub-interval (make-interval 1 2) (make-interval 5 7)))
  (check-= (lower-bound d) -6 1e-9)
  (check-= (upper-bound d) -3 1e-9))

(test-case "an interval minus itself is not zero"
  (define make-interval (solution "2.08" 'make-interval))
  (define lower-bound (solution "2.08" 'lower-bound))
  (define upper-bound (solution "2.08" 'upper-bound))
  (define sub-interval (solution "2.08" 'sub-interval))
  (define d (sub-interval (make-interval -1 1) (make-interval -1 1)))
  (check-= (lower-bound d) -2 1e-9)
  (check-= (upper-bound d) 2 1e-9))

(test-case "negative and mixed intervals"
  (define make-interval (solution "2.08" 'make-interval))
  (define lower-bound (solution "2.08" 'lower-bound))
  (define upper-bound (solution "2.08" 'upper-bound))
  (define sub-interval (solution "2.08" 'sub-interval))
  (define d (sub-interval (make-interval -4 -2) (make-interval -3 1)))
  (check-= (lower-bound d) -5 1e-9)
  (check-= (upper-bound d) 1 1e-9)
  (define e (sub-interval (make-interval 2 2) (make-interval 0.5 1.5)))
  (check-= (lower-bound e) 0.5 1e-9)
  (check-= (upper-bound e) 1.5 1e-9))

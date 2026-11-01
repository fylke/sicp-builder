#lang sicp
(#%require rackunit (only racket/base exn:fail?) "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.10.rkt must (#%provide make-interval lower-bound upper-bound
;;                                                  div-interval)
;;   (make-interval a b) -- the interval from a to b; (lower-bound i), (upper-bound i) its ends
;;   (div-interval x y)  -- x / y; it must signal an error (with `error`) if y spans zero
;; You must define Alyssa's other procedures that div-interval needs (e.g. mul-interval)
;; yourself, but they are not tested here.

(test-case "dividing by an interval that does not span zero"
  (define make-interval (solution "2.10" 'make-interval))
  (define lower-bound (solution "2.10" 'lower-bound))
  (define upper-bound (solution "2.10" 'upper-bound))
  (define div-interval (solution "2.10" 'div-interval))
  (define q (div-interval (make-interval 1 2) (make-interval 4 8)))
  (check-= (lower-bound q) 1/8 1e-9)
  (check-= (upper-bound q) 1/2 1e-9)
  (define r (div-interval (make-interval 2 4) (make-interval -2 -1)))
  (check-= (lower-bound r) -4 1e-9)
  (check-= (upper-bound r) -1 1e-9))

(test-case "a numerator that spans zero is fine"
  (define make-interval (solution "2.10" 'make-interval))
  (define lower-bound (solution "2.10" 'lower-bound))
  (define upper-bound (solution "2.10" 'upper-bound))
  (define div-interval (solution "2.10" 'div-interval))
  (define q (div-interval (make-interval -1 1) (make-interval 2 4)))
  (check-= (lower-bound q) -1/2 1e-9)
  (check-= (upper-bound q) 1/2 1e-9))

(test-case "dividing by an interval that spans zero signals an error"
  (define make-interval (solution "2.10" 'make-interval))
  (define div-interval (solution "2.10" 'div-interval))
  (check-exn exn:fail? (lambda () (div-interval (make-interval 1 2) (make-interval -1 1))))
  (check-exn exn:fail? (lambda () (div-interval (make-interval 1 2) (make-interval -3 0.5))))
  (check-exn exn:fail? (lambda () (div-interval (make-interval -1 1) (make-interval -2 3)))))

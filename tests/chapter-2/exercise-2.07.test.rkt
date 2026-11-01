#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.07.rkt must (#%provide make-interval lower-bound upper-bound)
;;   (make-interval a b) -- the interval from a to b (a <= b); the book defines it as (cons a b)
;;   (lower-bound i)     -- the lower end of i
;;   (upper-bound i)     -- the upper end of i

(test-case "lower-bound"
  (define make-interval (solution "2.07" 'make-interval))
  (define lower-bound (solution "2.07" 'lower-bound))
  (check-equal? (lower-bound (make-interval 1 5)) 1)
  (check-equal? (lower-bound (make-interval -3 -1)) -3)
  (check-equal? (lower-bound (make-interval 2 2)) 2))

(test-case "upper-bound"
  (define make-interval (solution "2.07" 'make-interval))
  (define upper-bound (solution "2.07" 'upper-bound))
  (check-equal? (upper-bound (make-interval 1 5)) 5)
  (check-equal? (upper-bound (make-interval -3 -1)) -1)
  (check-equal? (upper-bound (make-interval 2 2)) 2))

(test-case "bounds of non-integers"
  (define make-interval (solution "2.07" 'make-interval))
  (define lower-bound (solution "2.07" 'lower-bound))
  (define upper-bound (solution "2.07" 'upper-bound))
  (check-equal? (lower-bound (make-interval 0.5 1.5)) 0.5)
  (check-equal? (upper-bound (make-interval 1/2 3/2)) 3/2))

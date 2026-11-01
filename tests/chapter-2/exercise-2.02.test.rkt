#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.02.rkt must (#%provide make-point x-point y-point
;;                                                  make-segment start-segment end-segment
;;                                                  midpoint-segment)
;;   (make-point x y)        -- a point
;;   (x-point p) (y-point p) -- its coordinates
;;   (make-segment p q)      -- the segment from point p to point q
;;   (start-segment s) (end-segment s) -- its endpoints
;;   (midpoint-segment s)    -- the midpoint of s, as a point
;; You define all of these yourself.

(test-case "point selectors"
  (define make-point (solution "2.02" 'make-point))
  (define x-point (solution "2.02" 'x-point))
  (define y-point (solution "2.02" 'y-point))
  (check-equal? (x-point (make-point 3 4)) 3)
  (check-equal? (y-point (make-point 3 4)) 4))

(test-case "segment selectors"
  (define make-point (solution "2.02" 'make-point))
  (define x-point (solution "2.02" 'x-point))
  (define y-point (solution "2.02" 'y-point))
  (define make-segment (solution "2.02" 'make-segment))
  (define start-segment (solution "2.02" 'start-segment))
  (define end-segment (solution "2.02" 'end-segment))
  (define s (make-segment (make-point 1 2) (make-point 5 9)))
  (check-equal? (x-point (start-segment s)) 1)
  (check-equal? (y-point (start-segment s)) 2)
  (check-equal? (x-point (end-segment s)) 5)
  (check-equal? (y-point (end-segment s)) 9))

(test-case "midpoint of a segment"
  (define make-point (solution "2.02" 'make-point))
  (define x-point (solution "2.02" 'x-point))
  (define y-point (solution "2.02" 'y-point))
  (define make-segment (solution "2.02" 'make-segment))
  (define midpoint-segment (solution "2.02" 'midpoint-segment))
  (define m (midpoint-segment (make-segment (make-point 0 0) (make-point 4 6))))
  (check-= (x-point m) 2 1e-9)
  (check-= (y-point m) 3 1e-9))

(test-case "midpoint with fractions and negative coordinates"
  (define make-point (solution "2.02" 'make-point))
  (define x-point (solution "2.02" 'x-point))
  (define y-point (solution "2.02" 'y-point))
  (define make-segment (solution "2.02" 'make-segment))
  (define midpoint-segment (solution "2.02" 'midpoint-segment))
  (define m (midpoint-segment (make-segment (make-point 1 2) (make-point 2 5))))
  (check-= (x-point m) 1.5 1e-9)
  (check-= (y-point m) 3.5 1e-9)
  (define n (midpoint-segment (make-segment (make-point -3 4) (make-point 5 -10))))
  (check-= (x-point n) 1 1e-9)
  (check-= (y-point n) -3 1e-9))

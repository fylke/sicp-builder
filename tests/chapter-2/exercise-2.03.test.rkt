#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.03.rkt must (#%provide make-point x-point y-point
;;                                                  make-rectangle perimeter area)
;;   (make-point x y)         -- a point (define it yourself, as in Exercise 2.2)
;;   (x-point p) (y-point p)  -- its coordinates
;;   (make-rectangle p q)     -- the axis-parallel rectangle with opposite corners p and q
;;                               (in either order)
;;   (perimeter r) (area r)   -- perimeter and area of r
;; Keep an abstraction barrier: only make-rectangle's representation may change.

(test-case "perimeter"
  (define make-point (solution "2.03" 'make-point))
  (define make-rectangle (solution "2.03" 'make-rectangle))
  (define perimeter (solution "2.03" 'perimeter))
  (check-= (perimeter (make-rectangle (make-point 0 0) (make-point 4 3))) 14 1e-9)
  (check-= (perimeter (make-rectangle (make-point 1 1) (make-point 3 5))) 12 1e-9))

(test-case "area"
  (define make-point (solution "2.03" 'make-point))
  (define make-rectangle (solution "2.03" 'make-rectangle))
  (define area (solution "2.03" 'area))
  (check-= (area (make-rectangle (make-point 0 0) (make-point 4 3))) 12 1e-9)
  (check-= (area (make-rectangle (make-point 1 1) (make-point 3 5))) 8 1e-9))

(test-case "corners in any order and with negative coordinates"
  (define make-point (solution "2.03" 'make-point))
  (define make-rectangle (solution "2.03" 'make-rectangle))
  (define perimeter (solution "2.03" 'perimeter))
  (define area (solution "2.03" 'area))
  (define r1 (make-rectangle (make-point 4 3) (make-point 0 0)))
  (define r2 (make-rectangle (make-point 0 3) (make-point 4 0)))
  (define r3 (make-rectangle (make-point -1 -1) (make-point 1 1)))
  (check-= (perimeter r1) 14 1e-9)
  (check-= (area r1) 12 1e-9)
  (check-= (perimeter r2) 14 1e-9)
  (check-= (area r2) 12 1e-9)
  (check-= (perimeter r3) 8 1e-9)
  (check-= (area r3) 4 1e-9))

(test-case "degenerate rectangle"
  (define make-point (solution "2.03" 'make-point))
  (define make-rectangle (solution "2.03" 'make-rectangle))
  (define perimeter (solution "2.03" 'perimeter))
  (define area (solution "2.03" 'area))
  (define r (make-rectangle (make-point 2 2) (make-point 2 2)))
  (check-= (perimeter r) 0 1e-9)
  (check-= (area r) 0 1e-9))

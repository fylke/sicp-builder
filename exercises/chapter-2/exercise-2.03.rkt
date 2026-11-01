#lang sicp
;; Exercise 2.3
;;
;; Implement a representation for
;; rectangles in a plane.  (Hint: You may want to make use of [Exercise 2.2](../chapter-2/exercise-2.02.rkt).)
;; In terms of your constructors and selectors, create procedures that compute the
;; perimeter and the area of a given rectangle.  Now implement a different
;; representation for rectangles.  Can you design your system with suitable
;; abstraction barriers, so that the same perimeter and area procedures will work
;; using either representation?

;; Test: raco test tests/chapter-2/exercise-2.03.test.rkt
;; Your exercises/chapter-2/exercise-2.03.rkt must (#%provide make-point x-point y-point
;;                                                  make-rectangle perimeter area)
;;   (make-point x y)         -- a point (define it yourself, as in Exercise 2.2)
;;   (x-point p) (y-point p)  -- its coordinates
;;   (make-rectangle p q)     -- the axis-parallel rectangle with opposite corners p and q
;;                               (in either order)
;;   (perimeter r) (area r)   -- perimeter and area of r
;; Keep an abstraction barrier: only make-rectangle's representation may change.


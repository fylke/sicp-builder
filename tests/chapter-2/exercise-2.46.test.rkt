#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.46.rkt must (#%provide make-vect xcor-vect ycor-vect
;;                                                  add-vect sub-vect scale-vect)
;;   (make-vect x y)         -- the 2D vector (x, y)
;;   (xcor-vect v) (ycor-vect v) -- its coordinates
;;   (add-vect v w)          -- v + w
;;   (sub-vect v w)          -- v - w
;;   (scale-vect s v)        -- the scalar s times v

(test-case "constructor and selectors"
  (define make-vect (solution "2.46" 'make-vect))
  (define xcor-vect (solution "2.46" 'xcor-vect))
  (define ycor-vect (solution "2.46" 'ycor-vect))
  (check-equal? (xcor-vect (make-vect 3 4)) 3)
  (check-equal? (ycor-vect (make-vect 3 4)) 4))

(test-case "add-vect"
  (define make-vect (solution "2.46" 'make-vect))
  (define xcor-vect (solution "2.46" 'xcor-vect))
  (define ycor-vect (solution "2.46" 'ycor-vect))
  (define add-vect (solution "2.46" 'add-vect))
  (define v (add-vect (make-vect 1 2) (make-vect 10 -5)))
  (check-= (xcor-vect v) 11 1e-9)
  (check-= (ycor-vect v) -3 1e-9))

(test-case "sub-vect"
  (define make-vect (solution "2.46" 'make-vect))
  (define xcor-vect (solution "2.46" 'xcor-vect))
  (define ycor-vect (solution "2.46" 'ycor-vect))
  (define sub-vect (solution "2.46" 'sub-vect))
  (define v (sub-vect (make-vect 1 2) (make-vect 10 -5)))
  (check-= (xcor-vect v) -9 1e-9)
  (check-= (ycor-vect v) 7 1e-9))

(test-case "scale-vect"
  (define make-vect (solution "2.46" 'make-vect))
  (define xcor-vect (solution "2.46" 'xcor-vect))
  (define ycor-vect (solution "2.46" 'ycor-vect))
  (define scale-vect (solution "2.46" 'scale-vect))
  (define v (scale-vect 3 (make-vect 1 -2)))
  (check-= (xcor-vect v) 3 1e-9)
  (check-= (ycor-vect v) -6 1e-9)
  (define w (scale-vect 0.5 (make-vect 4 6)))
  (check-= (xcor-vect w) 2 1e-9)
  (check-= (ycor-vect w) 3 1e-9)
  (define z (scale-vect 0 (make-vect 4 6)))
  (check-= (xcor-vect z) 0 1e-9)
  (check-= (ycor-vect z) 0 1e-9))

(test-case "operations compose"
  (define make-vect (solution "2.46" 'make-vect))
  (define xcor-vect (solution "2.46" 'xcor-vect))
  (define ycor-vect (solution "2.46" 'ycor-vect))
  (define add-vect (solution "2.46" 'add-vect))
  (define sub-vect (solution "2.46" 'sub-vect))
  (define scale-vect (solution "2.46" 'scale-vect))
  (define a (make-vect 1 2))
  (define b (make-vect 3 5))
  (define v (sub-vect (add-vect a (scale-vect 2 b)) a))
  (check-= (xcor-vect v) 6 1e-9)
  (check-= (ycor-vect v) 10 1e-9))

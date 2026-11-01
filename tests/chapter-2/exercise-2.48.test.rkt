#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.48.rkt must (#%provide make-vect xcor-vect ycor-vect
;;                                                  make-segment start-segment end-segment)
;;   (make-vect x y), (xcor-vect v), (ycor-vect v) -- your vectors from Exercise 2.46
;;                                                    (define them yourself)
;;   (make-segment start end) -- the directed segment from vector start to vector end
;;   (start-segment s) (end-segment s) -- its endpoints

(test-case "start-segment"
  (define make-vect (solution "2.48" 'make-vect))
  (define xcor-vect (solution "2.48" 'xcor-vect))
  (define ycor-vect (solution "2.48" 'ycor-vect))
  (define make-segment (solution "2.48" 'make-segment))
  (define start-segment (solution "2.48" 'start-segment))
  (define s (make-segment (make-vect 1 2) (make-vect 3 4)))
  (check-equal? (xcor-vect (start-segment s)) 1)
  (check-equal? (ycor-vect (start-segment s)) 2))

(test-case "end-segment"
  (define make-vect (solution "2.48" 'make-vect))
  (define xcor-vect (solution "2.48" 'xcor-vect))
  (define ycor-vect (solution "2.48" 'ycor-vect))
  (define make-segment (solution "2.48" 'make-segment))
  (define end-segment (solution "2.48" 'end-segment))
  (define s (make-segment (make-vect 1 2) (make-vect 3 4)))
  (check-equal? (xcor-vect (end-segment s)) 3)
  (check-equal? (ycor-vect (end-segment s)) 4))

(test-case "segments are directed"
  (define make-vect (solution "2.48" 'make-vect))
  (define make-segment (solution "2.48" 'make-segment))
  (define start-segment (solution "2.48" 'start-segment))
  (define end-segment (solution "2.48" 'end-segment))
  (define a (make-vect 0 0))
  (define b (make-vect 5 5))
  (define s (make-segment a b))
  (define t (make-segment b a))
  (check-eq? (start-segment s) (end-segment t))
  (check-eq? (end-segment s) (start-segment t))
  (check-not-eq? (start-segment s) (start-segment t)))

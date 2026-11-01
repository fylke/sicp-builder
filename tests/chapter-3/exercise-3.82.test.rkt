#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.82.rkt must (#%provide estimate-integral)
;;   (estimate-integral P x1 x2 y1 y2) -> stream of Monte Carlo estimates of the area of the
;;   region of the rectangle [x1,x2] x [y1,y2] where the predicate (P x y) is true; element k
;;   is the estimate after k+1 random trials (area of rectangle * fraction of hits so far).
;; Define random-in-range and the stream helpers yourself in the file.

(define (nth s n)
  (if (= n 0) (car s) (nth (force (cdr s)) (- n 1))))

(test-case "a predicate that is always true gives the area of the rectangle at every step"
  (define estimate-integral (solution "3.82" 'estimate-integral))
  (let ((s (estimate-integral (lambda (x y) #t) 2 5 -1 3)))
    (check-= (nth s 0) 12 1e-9)
    (check-= (nth s 1) 12 1e-9)
    (check-= (nth s 100) 12 1e-9)))

(test-case "a predicate that is never true gives 0"
  (define estimate-integral (solution "3.82" 'estimate-integral))
  (let ((s (estimate-integral (lambda (x y) #f) 0 1 0 1)))
    (check-= (nth s 0) 0 1e-9)
    (check-= (nth s 50) 0 1e-9)))

(test-case "the stream is infinite and uses successively more trials"
  (define estimate-integral (solution "3.82" 'estimate-integral))
  (let ((s (estimate-integral (lambda (x y) (< x 0.5)) 0 1 0 1)))
    (check-true (pair? s))
    (check-true (number? (nth s 0)))
    (check-true (number? (nth s 1000)))))

(test-case "the unit circle: area is about pi"
  (define estimate-integral (solution "3.82" 'estimate-integral))
  (let ((s (estimate-integral (lambda (x y) (<= (+ (* x x) (* y y)) 1)) -1.0 1.0 -1.0 1.0)))
    (check-= (nth s 30000) 3.14159 0.15)))

(test-case "the region below the diagonal of the unit square has area 1/2"
  (define estimate-integral (solution "3.82" 'estimate-integral))
  (let ((s (estimate-integral (lambda (x y) (< y x)) 0 1 0 1)))
    (check-= (nth s 20000) 0.5 0.05)))

(test-case "the rectangle's position is respected"
  (define estimate-integral (solution "3.82" 'estimate-integral))
  ;; the region x > 3 inside [2,4] x [0,1] is half of the rectangle of area 2
  (let ((s (estimate-integral (lambda (x y) (> x 3)) 2 4 0 1)))
    (check-= (nth s 20000) 1 0.1)))

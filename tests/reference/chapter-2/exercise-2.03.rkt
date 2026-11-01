#lang sicp
(#%provide make-point x-point y-point make-rectangle perimeter area)

(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (make-rectangle p q) (cons p q))
(define (rect-width r)
  (abs (- (x-point (car r)) (x-point (cdr r)))))
(define (rect-height r)
  (abs (- (y-point (car r)) (y-point (cdr r)))))

(define (perimeter r) (* 2 (+ (rect-width r) (rect-height r))))
(define (area r) (* (rect-width r) (rect-height r)))

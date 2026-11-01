#lang sicp
(#%provide nth-root)

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (average x y) (/ (+ x y) 2))
(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (compose f g)
  (lambda (x) (f (g x))))
(define (repeated f n)
  (if (= n 1)
      f
      (compose f (repeated f (- n 1)))))

;; floor(log2 n) damps are needed
(define (damps-needed n)
  (if (< n 2) 0 (+ 1 (damps-needed (quotient n 2)))))

(define (nth-root x n)
  (define damps (damps-needed n))
  (define f (lambda (y) (/ x (expt y (- n 1)))))
  (fixed-point (if (= damps 0) f ((repeated average-damp damps) f))
               1.0))

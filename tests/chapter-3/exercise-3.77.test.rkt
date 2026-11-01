#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.77.rkt must (#%provide integral)
;;   (integral delayed-integrand initial-value dt) -> the stream of the integral of the stream
;;   that (force delayed-integrand) yields; the integrand is passed delayed, e.g.
;;   (integral (delay dy) y0 dt), and must not be forced before the first element is needed.

(define (head s n)
  (if (or (= n 0) (null? s))
      '()
      (cons (car s) (head (force (cdr s)) (- n 1)))))

(define (check-list actual expected)
  (check-equal? (length actual) (length expected))
  (for-each (lambda (a e) (check-= a e 1e-9)) actual expected))

(define (stream-map f s)
  (if (null? s)
      the-empty-stream
      (cons-stream (f (car s)) (stream-map f (force (cdr s))))))

(define (from-list l)
  (if (null? l)
      '()
      (cons-stream (car l) (from-list (cdr l)))))

(define ones (cons-stream 1 ones))

(test-case "integral of a constant stream"
  (define integral (solution "3.77" 'integral))
  (check-list (head (integral (delay ones) 0 1) 5) '(0 1 2 3 4))
  (check-list (head (integral (delay ones) 10 0.5) 4) '(10 10.5 11 11.5)))

(test-case "initial value comes first, without forcing the integrand"
  (define integral (solution "3.77" 'integral))
  (check-equal? (car (integral (delay (error "forced too early")) 5 1)) 5))

(test-case "finite integrand gives a finite stream"
  (define integral (solution "3.77" 'integral))
  (check-list (head (integral (delay (from-list '(1 2 3))) 0 1) 10) '(0 1 3 6)))

(test-case "solve y' = y with a loop through delay"
  (define integral (solution "3.77" 'integral))
  (define (solve f y0 dt)
    (let ((y '*) (dy '*))
      (set! y (integral (delay dy) y0 dt))
      (set! dy (stream-map f y))
      y))
  (let ((ys (head (solve (lambda (y) y) 1 0.01) 6)))
    (check-list ys (list 1 1.01 (* 1.01 1.01) (expt 1.01 3) (expt 1.01 4) (expt 1.01 5)))))

(test-case "solve y' = -2y"
  (define integral (solution "3.77" 'integral))
  (define (solve f y0 dt)
    (let ((y '*) (dy '*))
      (set! y (integral (delay dy) y0 dt))
      (set! dy (stream-map f y))
      y))
  (check-list (head (solve (lambda (y) (* -2 y)) 1 0.1) 4)
              (list 1 0.8 0.64 0.512)))

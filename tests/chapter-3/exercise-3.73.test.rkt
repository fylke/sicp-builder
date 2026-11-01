#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.73.rkt must (#%provide RC)
;;   (RC R C dt) -> a procedure (lambda (i v0) ...) that takes a stream i of currents and an
;;   initial voltage v0 and returns the stream of voltages
;;   v_k = v0 + (1/C) * dt * (i_0 + ... + i_(k-1)) + R * i_k
;; Define integral and the stream helpers yourself in the file.

(define (head s n)
  (if (or (= n 0) (null? s))
      '()
      (cons (car s) (head (force (cdr s)) (- n 1)))))

(define (check-list actual expected)
  (check-equal? (length actual) (length expected))
  (for-each (lambda (a e) (check-= a e 1e-9)) actual expected))

(define ones (cons-stream 1 ones))
(define (ints n) (cons-stream n (ints (+ n 1))))
(define zeros (cons-stream 0 zeros))

(test-case "constant current"
  (define RC (solution "3.73" 'RC))
  (check-list (head ((RC 3 2 1) ones 0) 4) '(3 3.5 4 4.5)))

(test-case "initial voltage"
  (define RC (solution "3.73" 'RC))
  (check-list (head ((RC 5 1 0.5) ones 10) 4) '(15 15.5 16 16.5)))

(test-case "zero current keeps the initial voltage"
  (define RC (solution "3.73" 'RC))
  (check-list (head ((RC 5 1 0.5) zeros 7) 3) '(7 7 7)))

(test-case "varying current"
  (define RC (solution "3.73" 'RC))
  ;; R=1, C=2, dt=0.1, i = 0 1 2 3, v0 = 1
  (check-list (head ((RC 1 2 0.1) (ints 0) 1) 4) '(1 2 3.05 4.15)))

(test-case "the returned procedure can be reused"
  (define RC (solution "3.73" 'RC))
  (let ((circuit (RC 1 1 1)))
    (check-list (head (circuit ones 0) 3) '(1 2 3))
    (check-list (head (circuit ones 5) 3) '(6 7 8))))

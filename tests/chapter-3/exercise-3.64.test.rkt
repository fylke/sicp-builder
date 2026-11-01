#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.64.rkt must (#%provide stream-limit)
;;   (stream-limit s tolerance) -> the second element of the first pair of successive
;;   elements of the stream s whose difference is smaller than tolerance (in absolute value)

(define (from-list l)
  (if (null? l)
      '()
      (cons-stream (car l) (from-list (cdr l)))))

(define (halves n) (cons-stream (/ 1 (expt 2 n)) (halves (+ n 1))))

(test-case "halving sequence"
  (define stream-limit (solution "3.64" 'stream-limit))
  (check-= (stream-limit (halves 0) 0.1) 1/16 1e-12))

(test-case "returns the later element of the pair"
  (define stream-limit (solution "3.64" 'stream-limit))
  (check-= (stream-limit (from-list '(5 3 3.05 3.06)) 0.1) 3.05 1e-12))

(test-case "negative differences count by absolute value"
  (define stream-limit (solution "3.64" 'stream-limit))
  (check-= (stream-limit (from-list '(0 -1 -1.05 -1.06)) 0.1) -1.05 1e-12))

(test-case "first pair already within tolerance"
  (define stream-limit (solution "3.64" 'stream-limit))
  (check-= (stream-limit (from-list '(1 1.01 7 7.001)) 0.1) 1.01 1e-12))

(test-case "does not look further than needed"
  (define stream-limit (solution "3.64" 'stream-limit))
  (define s (cons-stream 0 (cons-stream 10 (cons-stream 10.01 (error "forced too far")))))
  (check-= (stream-limit s 0.1) 10.01 1e-12))

(test-case "square roots converge"
  (define stream-limit (solution "3.64" 'stream-limit))
  (define (improve g) (/ (+ g (/ 2.0 g)) 2))
  (define (sqrt-stream g) (cons-stream g (sqrt-stream (improve g))))
  (check-= (stream-limit (sqrt-stream 1.0) 1e-6) (sqrt 2) 1e-6))

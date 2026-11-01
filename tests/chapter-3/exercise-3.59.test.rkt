#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.59.rkt must
;;   (#%provide integrate-series exp-series cosine-series sine-series)
;;   (integrate-series s) -> the stream a0, a1/2, a2/3, ... (coefficients of the integral
;;                           without its constant term)
;;   exp-series, cosine-series, sine-series -> coefficient streams of e^x, cos x, sin x
;; Define stream-map, integers, scale-stream etc. yourself in the file.

(define (head s n)
  (if (or (= n 0) (null? s))
      '()
      (cons (car s) (head (force (cdr s)) (- n 1)))))

(define (check-series actual expected)
  (check-equal? (length actual) (length expected))
  (for-each (lambda (a e) (check-= a e 1e-9)) actual expected))

(define ones (cons-stream 1 ones))
(define (ints n) (cons-stream n (ints (+ n 1))))

(test-case "integrate-series of the constant series 1 1 1 ..."
  (define integrate-series (solution "3.59" 'integrate-series))
  (check-series (head (integrate-series ones) 6) '(1 1/2 1/3 1/4 1/5 1/6)))

(test-case "integrate-series of 1 2 3 4 ..."
  (define integrate-series (solution "3.59" 'integrate-series))
  (check-series (head (integrate-series (ints 1)) 5) '(1 1 1 1 1)))

(test-case "integrate-series of other series"
  (define integrate-series (solution "3.59" 'integrate-series))
  (define twos-and-zeros (cons-stream 2 (cons-stream 0 twos-and-zeros)))
  (check-series (head (integrate-series twos-and-zeros) 6) '(2 0 2/3 0 2/5 0)))

(test-case "exp-series is 1 1 1/2 1/6 1/24 ..."
  (define exp-series (solution "3.59" 'exp-series))
  (check-series (head exp-series 8) '(1 1 1/2 1/6 1/24 1/120 1/720 1/5040)))

(test-case "cosine-series is 1 0 -1/2 0 1/24 ..."
  (define cosine-series (solution "3.59" 'cosine-series))
  (check-series (head cosine-series 8) '(1 0 -1/2 0 1/24 0 -1/720 0)))

(test-case "sine-series is 0 1 0 -1/6 0 1/120 ..."
  (define sine-series (solution "3.59" 'sine-series))
  (check-series (head sine-series 8) '(0 1 0 -1/6 0 1/120 0 -1/5040)))

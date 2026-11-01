#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.55.rkt must (#%provide partial-sums)
;;   (partial-sums s) -> the stream S0, S0+S1, S0+S1+S2, ...
;; Define add-streams, stream-map, stream-car/stream-cdr etc. yourself in the file.

(define (head s n)
  (if (or (= n 0) (null? s))
      '()
      (cons (car s) (head (force (cdr s)) (- n 1)))))

(define (ints n) (cons-stream n (ints (+ n 1))))

(test-case "partial sums of the integers"
  (define partial-sums (solution "3.55" 'partial-sums))
  (check-equal? (head (partial-sums (ints 1)) 8) '(1 3 6 10 15 21 28 36)))

(test-case "partial sums of a constant stream"
  (define partial-sums (solution "3.55" 'partial-sums))
  (define ones (cons-stream 1 ones))
  (check-equal? (head (partial-sums ones) 5) '(1 2 3 4 5)))

(test-case "partial sums with negative and zero elements"
  (define partial-sums (solution "3.55" 'partial-sums))
  (define alternating (cons-stream 1 (cons-stream -1 alternating)))
  (check-equal? (head (partial-sums alternating) 6) '(1 0 1 0 1 0))
  (check-equal? (head (partial-sums (ints 0)) 5) '(0 1 3 6 10)))

(test-case "partial sums are lazy"
  (define partial-sums (solution "3.55" 'partial-sums))
  (define (boom n)
    (cons-stream n (if (= n 4) (error "forced too far") (boom (+ n 1)))))
  (check-equal? (head (partial-sums (boom 1)) 3) '(1 3 6)))

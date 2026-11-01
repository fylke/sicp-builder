#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.56.rkt must (#%provide S)
;;   S -> the stream, in ascending order without repeats, of all positive integers whose
;;        only prime factors are 2, 3 and 5: 1 2 3 4 5 6 8 9 10 12 ...
;; Define merge and scale-stream (and the stream helpers) yourself in the file.

(define (head s n)
  (if (or (= n 0) (null? s))
      '()
      (cons (car s) (head (force (cdr s)) (- n 1)))))

(define (nth-stream s n)
  (if (= n 0) (car s) (nth-stream (force (cdr s)) (- n 1))))

(test-case "first Hamming numbers"
  (define S (solution "3.56" 'S))
  (check-equal? (head S 25)
                '(1 2 3 4 5 6 8 9 10 12 15 16 18 20 24 25 27 30 32 36 40 45 48 50 54)))

(test-case "a few further Hamming numbers"
  (define S (solution "3.56" 'S))
  (check-equal? (nth-stream S 99) 1536)
  (check-equal? (nth-stream S 999) 51200000))

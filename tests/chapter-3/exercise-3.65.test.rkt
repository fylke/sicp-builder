#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.65.rkt must (#%provide ln2-stream ln2-euler ln2-accelerated)
;;   ln2-stream      -> partial sums of 1 - 1/2 + 1/3 - 1/4 ... (first element 1, floating point)
;;   ln2-euler       -> ln2-stream after one Euler transform
;;   ln2-accelerated -> ln2-stream with repeated Euler transforms (tableau, first elements)
;; Define partial-sums, euler-transform etc. yourself in the file.

(define (head s n)
  (if (or (= n 0) (null? s))
      '()
      (cons (car s) (head (force (cdr s)) (- n 1)))))

(define (check-list actual expected)
  (check-equal? (length actual) (length expected))
  (for-each (lambda (a e) (check-= a e 1e-8)) actual expected))

(test-case "ln2-stream partial sums"
  (define ln2-stream (solution "3.65" 'ln2-stream))
  (check-list (head ln2-stream 4) (list 1 0.5 (/ 5.0 6) (/ 7.0 12))))

(test-case "ln2-stream converges slowly towards ln 2"
  (define ln2-stream (solution "3.65" 'ln2-stream))
  (check-= (car (reverse (head ln2-stream 1000))) 0.6926474305598203 1e-9))

(test-case "ln2-euler"
  (define ln2-euler (solution "3.65" 'ln2-euler))
  (check-list (head ln2-euler 4) '(0.7 0.6904761904761905 0.6944444444444444 0.6924242424242424)))

(test-case "ln2-accelerated"
  (define ln2-accelerated (solution "3.65" 'ln2-accelerated))
  (check-list (head ln2-accelerated 6)
              '(1.0 0.7 0.6932773109243697 0.6931488693329254
                0.6931471960735491 0.6931471806635636)))

(test-case "ln2-accelerated is close to ln 2 quickly"
  (define ln2-accelerated (solution "3.65" 'ln2-accelerated))
  (check-= (car (reverse (head ln2-accelerated 7))) (log 2) 1e-9))

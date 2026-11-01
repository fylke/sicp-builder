#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.20.rkt must (#%provide same-parity)
;;   (same-parity x . rest) -- list of x and all of the rest that have the same even/odd
;;                             parity as x, in order (use dotted-tail notation)

(test-case "book examples"
  (define same-parity (solution "2.20" 'same-parity))
  (check-equal? (same-parity 1 2 3 4 5 6 7) '(1 3 5 7))
  (check-equal? (same-parity 2 3 4 5 6 7) '(2 4 6)))

(test-case "a single argument"
  (define same-parity (solution "2.20" 'same-parity))
  (check-equal? (same-parity 5) '(5))
  (check-equal? (same-parity 4) '(4)))

(test-case "nothing else matches"
  (define same-parity (solution "2.20" 'same-parity))
  (check-equal? (same-parity 1 2 4 6) '(1))
  (check-equal? (same-parity 2 1 3 5) '(2)))

(test-case "zero and negative numbers"
  (define same-parity (solution "2.20" 'same-parity))
  (check-equal? (same-parity -1 2 -3 4 -5 0) '(-1 -3 -5))
  (check-equal? (same-parity 0 1 -2 3 -4) '(0 -2 -4)))

(test-case "order is preserved and duplicates are kept"
  (define same-parity (solution "2.20" 'same-parity))
  (check-equal? (same-parity 3 9 1 8 1 7) '(3 9 1 1 7)))

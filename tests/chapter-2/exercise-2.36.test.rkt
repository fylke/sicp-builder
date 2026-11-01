#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.36.rkt must (#%provide accumulate-n)
;;   (accumulate-n op init seqs) -- accumulate op/init over the first elements of all the
;;                                  sequences in seqs, then over the second elements, etc.
;; You must define accumulate yourself (it is not tested here).

(define s '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))

(test-case "book example"
  (define accumulate-n (solution "2.36" 'accumulate-n))
  (check-equal? (accumulate-n + 0 s) '(22 26 30)))

(test-case "other operations"
  (define accumulate-n (solution "2.36" 'accumulate-n))
  (check-equal? (accumulate-n * 1 s) '(280 880 1944))
  (check-equal? (accumulate-n cons nil s) '((1 4 7 10) (2 5 8 11) (3 6 9 12)))
  (check-equal? (accumulate-n max 0 s) '(10 11 12)))

(test-case "sequences of a single element"
  (define accumulate-n (solution "2.36" 'accumulate-n))
  (check-equal? (accumulate-n + 0 '((1) (2) (3))) '(6))
  (check-equal? (accumulate-n + 0 '((5 6 7))) '(5 6 7)))

(test-case "empty sequences"
  (define accumulate-n (solution "2.36" 'accumulate-n))
  (check-equal? (accumulate-n + 0 '(() ())) '()))

#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-1/exercise-1.12.rkt must (#%provide pascal)
;;   (pascal row col) -- the element in column col of row row of Pascal's triangle,
;;                       both counted from 1 (so (pascal 1 1) = 1, (pascal 3 2) = 2)

(test-case "edges are 1"
  (define pascal (solution "1.12" 'pascal))
  (check-equal? (pascal 1 1) 1)
  (check-equal? (pascal 5 1) 1)
  (check-equal? (pascal 5 5) 1)
  (check-equal? (pascal 10 10) 1))

(test-case "inner elements"
  (define pascal (solution "1.12" 'pascal))
  (check-equal? (pascal 3 2) 2)
  (check-equal? (pascal 4 2) 3)
  (check-equal? (pascal 4 3) 3)
  (check-equal? (pascal 5 3) 6))

(test-case "whole rows"
  (define pascal (solution "1.12" 'pascal))
  (define (row n)
    (do ((c n (- c 1))
         (acc '() (cons (pascal n c) acc)))
        ((= c 0) acc)))
  (check-equal? (row 5) '(1 4 6 4 1))
  (check-equal? (row 7) '(1 6 15 20 15 6 1))
  (check-equal? (row 9) '(1 8 28 56 70 56 28 8 1)))

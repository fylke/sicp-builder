#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.61.rkt must (#%provide adjoin-set)
;;   (adjoin-set x set) -- add x to a set of numbers represented as an ordered (increasing)
;;                         list without duplicates; the result is again ordered, and x is not
;;                         added twice. It should stop as soon as it has found x's place
;;                         (the tests check that the rest of the list is not examined).

(test-case "insert in the middle"
  (define adjoin-set (solution "2.61" 'adjoin-set))
  (check-equal? (adjoin-set 3 '(1 2 4 5)) '(1 2 3 4 5))
  (check-equal? (adjoin-set 6 '(1 5 7 9)) '(1 5 6 7 9)))

(test-case "insert at either end"
  (define adjoin-set (solution "2.61" 'adjoin-set))
  (check-equal? (adjoin-set 0 '(1 2)) '(0 1 2))
  (check-equal? (adjoin-set 9 '(1 2)) '(1 2 9)))

(test-case "empty set"
  (define adjoin-set (solution "2.61" 'adjoin-set))
  (check-equal? (adjoin-set 1 '()) '(1)))

(test-case "elements already in the set are not duplicated"
  (define adjoin-set (solution "2.61" 'adjoin-set))
  (check-equal? (adjoin-set 2 '(1 2 3)) '(1 2 3))
  (check-equal? (adjoin-set 1 '(1 2 3)) '(1 2 3))
  (check-equal? (adjoin-set 3 '(1 2 3)) '(1 2 3)))

(test-case "negative and fractional numbers"
  (define adjoin-set (solution "2.61" 'adjoin-set))
  (check-equal? (adjoin-set -1 '(-5 0 5)) '(-5 -1 0 5))
  (check-equal? (adjoin-set 1/2 '(0 1)) '(0 1/2 1)))

(test-case "stops looking once the position is found"
  (define adjoin-set (solution "2.61" 'adjoin-set))
  ;; the tails are not lists, so any code that walks past the insertion point fails
  (check-equal? (adjoin-set 0 (cons 1 'tail)) (cons 0 (cons 1 'tail)))
  (check-equal? (adjoin-set 2 (cons 1 (cons 5 'tail))) (cons 1 (cons 2 (cons 5 'tail))))
  (check-equal? (adjoin-set 1 (cons 1 'tail)) (cons 1 'tail)))

(test-case "a long ordered list"
  (define adjoin-set (solution "2.61" 'adjoin-set))
  (define (up-to n) (if (= n 0) '() (append (up-to (- n 1)) (list (* 2 n)))))
  (define big (up-to 500))
  (check-equal? (length (adjoin-set 501 big)) 501)
  (check-equal? (length (adjoin-set 500 big)) 500)
  (check-equal? (list-ref (adjoin-set 501 big) 250) 501))

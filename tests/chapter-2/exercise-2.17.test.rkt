#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.17.rkt must (#%provide last-pair)
;;   (last-pair l) -- the list containing only the last element of the nonempty list l

(test-case "book example"
  (define last-pair (solution "2.17" 'last-pair))
  (check-equal? (last-pair (list 23 72 149 34)) '(34)))

(test-case "one-element and two-element lists"
  (define last-pair (solution "2.17" 'last-pair))
  (check-equal? (last-pair (list 1)) '(1))
  (check-equal? (last-pair (list 1 2)) '(2)))

(test-case "elements may be lists or symbols"
  (define last-pair (solution "2.17" 'last-pair))
  (check-equal? (last-pair (list 1 (list 2 3))) '((2 3)))
  (check-equal? (last-pair (list (list 1 2) 3)) '(3))
  (check-equal? (last-pair '(a b c d e)) '(e)))

(test-case "returns the last pair itself, not a copy"
  (define last-pair (solution "2.17" 'last-pair))
  (define l (list 1 2 3 4))
  (check-eq? (last-pair l) (cdddr l)))

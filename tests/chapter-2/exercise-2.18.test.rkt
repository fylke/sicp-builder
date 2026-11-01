#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.18.rkt must (#%provide reverse)
;;   (reverse l) -- the list of the elements of l in reverse order
;; Define it yourself (it shadows the built-in reverse in your file).

(test-case "book example"
  (define my-reverse (solution "2.18" 'reverse))
  (check-equal? (my-reverse (list 1 4 9 16 25)) '(25 16 9 4 1)))

(test-case "empty and one-element lists"
  (define my-reverse (solution "2.18" 'reverse))
  (check-equal? (my-reverse '()) '())
  (check-equal? (my-reverse (list 7)) '(7)))

(test-case "only the top level is reversed"
  (define my-reverse (solution "2.18" 'reverse))
  (check-equal? (my-reverse '((1 2) (3 4) 5)) '(5 (3 4) (1 2)))
  (check-equal? (my-reverse '(a b c)) '(c b a)))

(test-case "does not modify its argument"
  (define my-reverse (solution "2.18" 'reverse))
  (define l (list 1 2 3))
  (my-reverse l)
  (check-equal? l '(1 2 3)))

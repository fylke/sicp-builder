#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.32.rkt must (#%provide subsets)
;;   (subsets s) -- the list of all subsets of the set s (a list), built with the book's
;;                  template: (append rest (map <??> rest))
;;                  e.g. (subsets '(1 2 3)) is (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))

(test-case "book example"
  (define subsets (solution "2.32" 'subsets))
  (check-equal? (subsets (list 1 2 3)) '(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))))

(test-case "empty set and singleton"
  (define subsets (solution "2.32" 'subsets))
  (check-equal? (subsets '()) '(()))
  (check-equal? (subsets (list 1)) '(() (1))))

(test-case "two elements"
  (define subsets (solution "2.32" 'subsets))
  (check-equal? (subsets (list 'a 'b)) '(() (b) (a) (a b))))

(test-case "a set of n elements has 2^n subsets"
  (define subsets (solution "2.32" 'subsets))
  (check-equal? (length (subsets (list 1 2 3 4))) 16)
  (check-equal? (length (subsets (list 1 2 3 4 5 6))) 64)
  (check-not-false (member '(1 3 4) (subsets (list 1 2 3 4)))))

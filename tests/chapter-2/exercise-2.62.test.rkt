#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.62.rkt must (#%provide union-set)
;;   (union-set set1 set2) -- union of two sets of numbers represented as ordered (increasing)
;;                            lists without duplicates; the result is an ordered list without
;;                            duplicates, computed in Theta(n) steps

(test-case "overlapping sets"
  (define union-set (solution "2.62" 'union-set))
  (check-equal? (union-set '(1 3 5) '(2 3 6)) '(1 2 3 5 6))
  (check-equal? (union-set '(1 2 3 4) '(3 4 5 6)) '(1 2 3 4 5 6)))

(test-case "disjoint sets"
  (define union-set (solution "2.62" 'union-set))
  (check-equal? (union-set '(1 2) '(3 4)) '(1 2 3 4))
  (check-equal? (union-set '(3 4) '(1 2)) '(1 2 3 4))
  (check-equal? (union-set '(1 4 7) '(2 5 8)) '(1 2 4 5 7 8)))

(test-case "empty sets"
  (define union-set (solution "2.62" 'union-set))
  (check-equal? (union-set '() '()) '())
  (check-equal? (union-set '() '(1 2)) '(1 2))
  (check-equal? (union-set '(1 2) '()) '(1 2)))

(test-case "identical and contained sets"
  (define union-set (solution "2.62" 'union-set))
  (check-equal? (union-set '(1 2 3) '(1 2 3)) '(1 2 3))
  (check-equal? (union-set '(1 2 3 4 5) '(2 4)) '(1 2 3 4 5))
  (check-equal? (union-set '(2 4) '(1 2 3 4 5)) '(1 2 3 4 5)))

(test-case "negative numbers"
  (define union-set (solution "2.62" 'union-set))
  (check-equal? (union-set '(-3 0 2) '(-5 -3 1)) '(-5 -3 0 1 2)))

(test-case "large sets (needs a linear-time algorithm)"
  (define union-set (solution "2.62" 'union-set))
  (define (multiples k n)
    (define (iter i acc) (if (= i 0) acc (iter (- i 1) (cons (* k i) acc))))
    (iter n '()))
  (define start (runtime))
  (define result (union-set (multiples 2 30000) (multiples 3 20000)))
  (define elapsed (- (runtime) start))
  (check-equal? (length result) 40000)
  (check-equal? (list-ref result 5) 9)
  (check-true (< elapsed 5000000) "union-set took more than 5 seconds"))

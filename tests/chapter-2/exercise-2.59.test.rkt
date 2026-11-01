#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.59.rkt must (#%provide union-set)
;;   (union-set set1 set2) -- the set (list without duplicates) of everything in set1 or set2
;; You must define element-of-set? (and anything else you use) yourself; the tests only
;; look at union-set. The order of the elements in the result does not matter.

(define (all-in? a b)
  (or (null? a)
      (and (member (car a) b) (all-in? (cdr a) b))))
(define (no-duplicates? l)
  (or (null? l)
      (and (not (member (car l) (cdr l))) (no-duplicates? (cdr l)))))
(define (set-equal? result expected)
  (and (no-duplicates? result)
       (= (length result) (length expected))
       (all-in? result expected)
       (all-in? expected result)))

(test-case "overlapping sets"
  (define union-set (solution "2.59" 'union-set))
  (check-true (set-equal? (union-set '(1 2 3) '(3 4 5)) '(1 2 3 4 5)))
  (check-true (set-equal? (union-set '(5 1 9) '(9 2 5 7)) '(1 2 5 7 9))))

(test-case "disjoint sets"
  (define union-set (solution "2.59" 'union-set))
  (check-true (set-equal? (union-set '(1 2) '(3 4)) '(1 2 3 4))))

(test-case "empty sets"
  (define union-set (solution "2.59" 'union-set))
  (check-equal? (union-set '() '()) '())
  (check-true (set-equal? (union-set '() '(1 2)) '(1 2)))
  (check-true (set-equal? (union-set '(1 2) '()) '(1 2))))

(test-case "identical and nested sets"
  (define union-set (solution "2.59" 'union-set))
  (check-true (set-equal? (union-set '(1 2 3) '(3 2 1)) '(1 2 3)))
  (check-true (set-equal? (union-set '(1 2 3) '(2)) '(1 2 3)))
  (check-true (set-equal? (union-set '(a b) '(b c)) '(a b c))))

#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.60.rkt must (#%provide element-of-set? adjoin-set
;;                                                  union-set intersection-set)
;; Sets are lists in which elements may be repeated, e.g. (2 3 2 1 3 2 2).
;;   (element-of-set? x set)
;;   (adjoin-set x set)
;;   (union-set set1 set2)
;;   (intersection-set set1 set2)
;; You define all four yourself. The tests only compare which elements the results contain
;; (repeats and order are ignored).

(define (all-in? a b)
  (or (null? a)
      (and (member (car a) b) (all-in? (cdr a) b))))
(define (same-elements? a b)
  (and (all-in? a b) (all-in? b a)))

(test-case "element-of-set?"
  (define element-of-set? (solution "2.60" 'element-of-set?))
  (check-true (element-of-set? 2 '(2 3 2 1 3 2 2)))
  (check-true (element-of-set? 1 '(2 3 2 1 3 2 2)))
  (check-false (element-of-set? 5 '(2 3 2 1 3 2 2)))
  (check-false (element-of-set? 1 '())))

(test-case "adjoin-set"
  (define adjoin-set (solution "2.60" 'adjoin-set))
  (define element-of-set? (solution "2.60" 'element-of-set?))
  (check-true (same-elements? (adjoin-set 4 '(1 2 2)) '(1 2 4)))
  (check-true (same-elements? (adjoin-set 2 '(1 2 2)) '(1 2)))
  (check-true (same-elements? (adjoin-set 1 '()) '(1)))
  (check-true (element-of-set? 4 (adjoin-set 4 '(1 2 2)))))

(test-case "union-set"
  (define union-set (solution "2.60" 'union-set))
  (check-true (same-elements? (union-set '(2 3 2) '(1 3 1)) '(1 2 3)))
  (check-true (same-elements? (union-set '() '(1 1 2)) '(1 2)))
  (check-true (same-elements? (union-set '(1 1 2) '()) '(1 2)))
  (check-equal? (union-set '() '()) '()))

(test-case "intersection-set"
  (define intersection-set (solution "2.60" 'intersection-set))
  (check-true (same-elements? (intersection-set '(2 3 2 1 3) '(3 3 4 1)) '(1 3)))
  (check-true (same-elements? (intersection-set '(1 1 1) '(1)) '(1)))
  (check-true (same-elements? (intersection-set '(1 2) '(3 3 4)) '()))
  (check-true (same-elements? (intersection-set '() '(1 2)) '()))
  (check-true (same-elements? (intersection-set '(1 2) '()) '())))

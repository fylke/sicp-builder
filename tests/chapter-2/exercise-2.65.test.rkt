#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.65.rkt must (#%provide union-set intersection-set)
;;   (union-set set1 set2)        -- union of two sets of numbers, each represented as a
;;                                   balanced binary tree, in Theta(n) steps
;;   (intersection-set set1 set2) -- intersection of two such sets
;; Trees use the book's representation: the empty tree is '(), and a tree is the list
;; (entry left-branch right-branch). The result may be any binary search tree with the
;; right elements (the tests only look at its in-order contents).
;; You must define in your file whatever helpers you use (entry, left-branch, right-branch,
;; make-tree, tree->list, list->tree, ...).

(define (tree-elements tree)
  (if (null? tree)
      '()
      (append (tree-elements (cadr tree))
              (cons (car tree) (tree-elements (caddr tree))))))

;; returns (tree . remaining-elements)
(define (partial elts n)
  (if (= n 0)
      (cons '() elts)
      (let* ((left-size (quotient (- n 1) 2))
             (left (partial elts left-size))
             (this (cadr left))
             (right (partial (cddr left) (- n left-size 1))))
        (cons (list this (car left) (car right)) (cdr right)))))

(define (tree-of elements) (car (partial elements (length elements))))

(define (run-union s1 s2)
  (define union-set (solution "2.65" 'union-set))
  (tree-elements (union-set (tree-of s1) (tree-of s2))))

(define (run-intersection s1 s2)
  (define intersection-set (solution "2.65" 'intersection-set))
  (tree-elements (intersection-set (tree-of s1) (tree-of s2))))

(test-case "union-set"
  (check-equal? (run-union '(1 3 5) '(2 3 6)) '(1 2 3 5 6))
  (check-equal? (run-union '(1 2 3 4 5 6 7) '(4 5 6 7 8 9 10)) '(1 2 3 4 5 6 7 8 9 10))
  (check-equal? (run-union '(1 2) '(3 4)) '(1 2 3 4))
  (check-equal? (run-union '(1 2 3) '(1 2 3)) '(1 2 3)))

(test-case "union-set with empty sets"
  (check-equal? (run-union '() '()) '())
  (check-equal? (run-union '() '(1 2 3)) '(1 2 3))
  (check-equal? (run-union '(1 2 3) '()) '(1 2 3)))

(test-case "intersection-set"
  (check-equal? (run-intersection '(1 3 5) '(2 3 6)) '(3))
  (check-equal? (run-intersection '(1 2 3 4 5 6 7) '(4 5 6 7 8 9 10)) '(4 5 6 7))
  (check-equal? (run-intersection '(1 2 3) '(1 2 3)) '(1 2 3)))

(test-case "intersection-set with disjoint or empty sets"
  (check-equal? (run-intersection '(1 2) '(3 4)) '())
  (check-equal? (run-intersection '() '(1 2 3)) '())
  (check-equal? (run-intersection '(1 2 3) '()) '())
  (check-equal? (run-intersection '() '()) '()))

(test-case "results are usable as trees (set operations compose)"
  (define union-set (solution "2.65" 'union-set))
  (define intersection-set (solution "2.65" 'intersection-set))
  (define a (tree-of '(1 3 5 7 9)))
  (define b (tree-of '(2 3 4 5 6)))
  (define c (tree-of '(5 6 7 8)))
  (check-equal? (tree-elements (intersection-set (union-set a b) c)) '(5 6 7)))

(test-case "larger sets (needs linear time)"
  (define union-set (solution "2.65" 'union-set))
  (define intersection-set (solution "2.65" 'intersection-set))
  (define (multiples k n)
    (define (iter i acc) (if (= i 0) acc (iter (- i 1) (cons (* k i) acc))))
    (iter n '()))
  (define a (tree-of (multiples 2 5000)))
  (define b (tree-of (multiples 3 3000)))
  (check-equal? (length (tree-elements (union-set a b))) 6500)
  (check-equal? (length (tree-elements (intersection-set a b))) 1500))

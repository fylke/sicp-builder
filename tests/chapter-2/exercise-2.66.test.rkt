#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.66.rkt must (#%provide lookup)
;;   (lookup given-key set-of-records) -- the record whose key is given-key, or #f if there is none
;; The set of records is a binary tree in the book's representation: the empty tree is '(),
;; a tree is the list (entry left-branch right-branch), and each entry is a record of the form
;; (key value) where key is a number; the tree is ordered by key.
;; You must define key (the selector, (key record) = (car record)) and any tree selectors yourself.

(define tree
  '((5 five)
    ((2 two) ((1 one) () ()) ((3 three) () ()))
    ((8 eight) ((7 seven) () ()) ((9 nine) () ()))))

(test-case "finds records at the root, inner nodes and leaves"
  (define lookup (solution "2.66" 'lookup))
  (check-equal? (lookup 5 tree) '(5 five))
  (check-equal? (lookup 2 tree) '(2 two))
  (check-equal? (lookup 8 tree) '(8 eight))
  (check-equal? (lookup 1 tree) '(1 one))
  (check-equal? (lookup 3 tree) '(3 three))
  (check-equal? (lookup 7 tree) '(7 seven))
  (check-equal? (lookup 9 tree) '(9 nine)))

(test-case "returns #f when the key is absent"
  (define lookup (solution "2.66" 'lookup))
  (check-false (lookup 4 tree))
  (check-false (lookup 0 tree))
  (check-false (lookup 10 tree))
  (check-false (lookup 6 tree)))

(test-case "empty set of records"
  (define lookup (solution "2.66" 'lookup))
  (check-false (lookup 1 '())))

(test-case "single record"
  (define lookup (solution "2.66" 'lookup))
  (check-equal? (lookup 3 '((3 three) () ())) '(3 three))
  (check-false (lookup 4 '((3 three) () ()))))

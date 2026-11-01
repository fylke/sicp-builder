#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.64.rkt must (#%provide list->tree)
;;   (list->tree elements) -- the balanced binary tree of the ordered list elements
;; Trees use the book's representation: the empty tree is '(), and a tree is the list
;; (entry left-branch right-branch). Define list->tree and partial-tree as in the exercise,
;; plus make-tree (section 2.3.3).

(test-case "empty list and one element"
  (define list->tree (solution "2.64" 'list->tree))
  (check-equal? (list->tree '()) '())
  (check-equal? (list->tree '(1)) '(1 () ())))

(test-case "small lists"
  (define list->tree (solution "2.64" 'list->tree))
  (check-equal? (list->tree '(1 2)) '(1 () (2 () ())))
  (check-equal? (list->tree '(1 2 3)) '(2 (1 () ()) (3 () ())))
  (check-equal? (list->tree '(1 2 3 4)) '(2 (1 () ()) (3 () (4 () ())))))

(test-case "the list (1 3 5 7 9 11) from the exercise"
  (define list->tree (solution "2.64" 'list->tree))
  (check-equal? (list->tree '(1 3 5 7 9 11))
                '(5 (1 () (3 () ())) (9 (7 () ()) (11 () ())))))

(test-case "seven elements give a perfect tree"
  (define list->tree (solution "2.64" 'list->tree))
  (check-equal? (list->tree '(1 2 3 4 5 6 7))
                '(4 (2 (1 () ()) (3 () ())) (6 (5 () ()) (7 () ())))))

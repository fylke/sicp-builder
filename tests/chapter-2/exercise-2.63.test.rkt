#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.63.rkt must (#%provide tree->list-1 tree->list-2)
;;   (tree->list-1 tree), (tree->list-2 tree) -- the two procedures of the exercise,
;;                                               each converting a binary tree to a list
;; Trees use the book's representation: the empty tree is '(), and a tree is the list
;; (entry left-branch right-branch). So you must also define entry, left-branch,
;; right-branch and make-tree yourself, exactly as in section 2.3.3.

(define t1 '(7 (3 (1 () ()) (5 () ())) (9 () (11 () ()))))
(define t2 '(3 (1 () ()) (7 (5 () ()) (9 () (11 () ())))))
(define t3 '(5 (3 (1 () ()) ()) (9 (7 () ()) (11 () ()))))

(define (check-conversion convert)
  (check-equal? (convert t1) '(1 3 5 7 9 11))
  (check-equal? (convert t2) '(1 3 5 7 9 11))
  (check-equal? (convert t3) '(1 3 5 7 9 11)))

(test-case "tree->list-1 on the trees of Figure 2.16"
  (check-conversion (solution "2.63" 'tree->list-1)))

(test-case "tree->list-2 on the trees of Figure 2.16"
  (check-conversion (solution "2.63" 'tree->list-2)))

(test-case "empty and one-element trees"
  (define tree->list-1 (solution "2.63" 'tree->list-1))
  (define tree->list-2 (solution "2.63" 'tree->list-2))
  (check-equal? (tree->list-1 '()) '())
  (check-equal? (tree->list-2 '()) '())
  (check-equal? (tree->list-1 '(4 () ())) '(4))
  (check-equal? (tree->list-2 '(4 () ())) '(4)))

(test-case "unbalanced trees"
  (define tree->list-1 (solution "2.63" 'tree->list-1))
  (define tree->list-2 (solution "2.63" 'tree->list-2))
  (define left-chain '(3 (2 (1 () ()) ()) ()))
  (define right-chain '(1 () (2 () (3 () ()))))
  (check-equal? (tree->list-1 left-chain) '(1 2 3))
  (check-equal? (tree->list-2 left-chain) '(1 2 3))
  (check-equal? (tree->list-1 right-chain) '(1 2 3))
  (check-equal? (tree->list-2 right-chain) '(1 2 3)))

(test-case "a larger tree"
  (define tree->list-1 (solution "2.63" 'tree->list-1))
  (define tree->list-2 (solution "2.63" 'tree->list-2))
  (define (chain i n)
    (if (> i n) '() (list i '() (chain (+ i 1) n))))
  (define big (chain 1 300))
  (check-equal? (length (tree->list-1 big)) 300)
  (check-equal? (tree->list-1 big) (tree->list-2 big))
  (check-equal? (car (tree->list-2 big)) 1))

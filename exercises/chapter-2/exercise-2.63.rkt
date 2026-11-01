#lang sicp
;; Exercise 2.63
;;
;; Each of the following two
;; procedures converts a binary tree to a list.
;;
;; ```scheme
;; (define (tree->list-1 tree)
;;   (if (null? tree)
;;       '()
;;       (append
;;        (tree->list-1
;;         (left-branch tree))
;;        (cons (entry tree)
;;              (tree->list-1
;;               (right-branch tree))))))
;;
;; (define (tree->list-2 tree)
;;   (define (copy-to-list tree result-list)
;;     (if (null? tree)
;;         result-list
;;         (copy-to-list
;;          (left-branch tree)
;;          (cons (entry tree)
;;                (copy-to-list
;;                 (right-branch tree)
;;                 result-list)))))
;;   (copy-to-list tree '()))
;; ```
;;
;; - (a) Do the two procedures produce the same result for every tree?  If not, how do
;; the results differ?  What lists do the two procedures produce for the trees in
;; Figure 2.16?
;;
;; - (b) Do the two procedures have the same order of growth in the number of steps
;; required to convert a balanced tree with $n$ elements to a list?  If not,
;; which one grows more slowly?

;; Test: raco test tests/chapter-2/exercise-2.63.test.rkt
;; Your exercises/chapter-2/exercise-2.63.rkt must (#%provide tree->list-1 tree->list-2)
;;   (tree->list-1 tree), (tree->list-2 tree) -- the two procedures of the exercise,
;;                                               each converting a binary tree to a list
;; Trees use the book's representation: the empty tree is '(), and a tree is the list
;; (entry left-branch right-branch). So you must also define entry, left-branch,
;; right-branch and make-tree yourself, exactly as in section 2.3.3.


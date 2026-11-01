#lang sicp
;; Exercise 2.66
;;
;; Implement the `lookup`
;; procedure for the case where the set of records is structured as a binary tree,
;; ordered by the numerical values of the keys.

;; Test: raco test tests/chapter-2/exercise-2.66.test.rkt
;; Your exercises/chapter-2/exercise-2.66.rkt must (#%provide lookup)
;;   (lookup given-key set-of-records) -- the record whose key is given-key, or #f if there is none
;; The set of records is a binary tree in the book's representation: the empty tree is '(),
;; a tree is the list (entry left-branch right-branch), and each entry is a record of the form
;; (key value) where key is a number; the tree is ordered by key.
;; You must define key (the selector, (key record) = (car record)) and any tree selectors yourself.


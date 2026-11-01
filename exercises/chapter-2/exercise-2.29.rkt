#lang sicp
;; Exercise 2.29
;;
;; A binary mobile consists of two
;; branches, a left branch and a right branch.  Each branch is a rod of a certain
;; length, from which hangs either a weight or another binary mobile.  We can
;; represent a binary mobile using compound data by constructing it from two
;; branches (for example, using `list`):
;;
;; ```scheme
;; (define (make-mobile left right)
;;   (list left right))
;; ```
;;
;; A branch is constructed from a `length` (which must be a number) together
;; with a `structure`, which may be either a number (representing a simple
;; weight) or another mobile:
;;
;; ```scheme
;; (define (make-branch length structure)
;;   (list length structure))
;; ```
;;
;; - (a) Write the corresponding selectors `left-branch` and `right-branch`,
;; which return the branches of a mobile, and `branch-length` and
;; `branch-structure`, which return the components of a branch.
;;
;; - (b) Using your selectors, define a procedure `total-weight` that returns the
;; total weight of a mobile.
;;
;; - (c) A mobile is said to be *balanced* if the torque applied by its top-left
;; branch is equal to that applied by its top-right branch (that is, if the length
;; of the left rod multiplied by the weight hanging from that rod is equal to the
;; corresponding product for the right side) and if each of the submobiles hanging
;; off its branches is balanced. Design a predicate that tests whether a binary
;; mobile is balanced.
;;
;; - (d) Suppose we change the representation of mobiles so that the constructors are
;;
;;       ```scheme
;;       (define (make-mobile left right)
;;         (cons left right))
;;
;;       (define (make-branch length structure)
;;         (cons length structure))
;;       ```
;;
;;       How much do you need to change your programs to convert to the new
;; representation?

;; Test: raco test tests/chapter-2/exercise-2.29.test.rkt
;; Your exercises/chapter-2/exercise-2.29.rkt must (#%provide make-mobile make-branch
;;     left-branch right-branch branch-length branch-structure total-weight balanced?)
;;   (make-mobile left right)       -- a mobile from two branches
;;   (make-branch length structure) -- a branch; structure is a number (weight) or a mobile
;;   (left-branch m) (right-branch m)           -- the branches of mobile m
;;   (branch-length b) (branch-structure b)     -- the components of branch b
;;   (total-weight m)  -- total weight hanging from mobile m
;;   (balanced? m)     -- true if m (and every submobile) is balanced
;; You define all of these yourself; the tests work with either list or cons representation.


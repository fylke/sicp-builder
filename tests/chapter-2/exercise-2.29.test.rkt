#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.29.rkt must (#%provide make-mobile make-branch
;;     left-branch right-branch branch-length branch-structure total-weight balanced?)
;;   (make-mobile left right)       -- a mobile from two branches
;;   (make-branch length structure) -- a branch; structure is a number (weight) or a mobile
;;   (left-branch m) (right-branch m)           -- the branches of mobile m
;;   (branch-length b) (branch-structure b)     -- the components of branch b
;;   (total-weight m)  -- total weight hanging from mobile m
;;   (balanced? m)     -- true if m (and every submobile) is balanced
;; You define all of these yourself; the tests work with either list or cons representation.

(test-case "selectors"
  (define make-mobile (solution "2.29" 'make-mobile))
  (define make-branch (solution "2.29" 'make-branch))
  (define left-branch (solution "2.29" 'left-branch))
  (define right-branch (solution "2.29" 'right-branch))
  (define branch-length (solution "2.29" 'branch-length))
  (define branch-structure (solution "2.29" 'branch-structure))
  (define m (make-mobile (make-branch 2 3) (make-branch 4 (make-mobile (make-branch 1 5) (make-branch 1 5)))))
  (check-equal? (branch-length (left-branch m)) 2)
  (check-equal? (branch-structure (left-branch m)) 3)
  (check-equal? (branch-length (right-branch m)) 4)
  (check-true (pair? (branch-structure (right-branch m))))
  (check-equal? (branch-length (left-branch (branch-structure (right-branch m)))) 1)
  (check-equal? (branch-structure (right-branch (branch-structure (right-branch m)))) 5))

(test-case "total-weight"
  (define make-mobile (solution "2.29" 'make-mobile))
  (define make-branch (solution "2.29" 'make-branch))
  (define total-weight (solution "2.29" 'total-weight))
  (check-equal? (total-weight (make-mobile (make-branch 2 3) (make-branch 3 2))) 5)
  (define sub (make-mobile (make-branch 1 2) (make-branch 1 2)))
  (check-equal? (total-weight sub) 4)
  (check-equal? (total-weight (make-mobile (make-branch 3 sub) (make-branch 4 3))) 7)
  (check-equal? (total-weight (make-mobile (make-branch 1 sub) (make-branch 1 sub))) 8))

(test-case "a simple balanced and unbalanced mobile"
  (define make-mobile (solution "2.29" 'make-mobile))
  (define make-branch (solution "2.29" 'make-branch))
  (define balanced? (solution "2.29" 'balanced?))
  (check-true (balanced? (make-mobile (make-branch 2 3) (make-branch 3 2))))
  (check-false (balanced? (make-mobile (make-branch 1 3) (make-branch 3 2)))))

(test-case "balanced with submobiles"
  (define make-mobile (solution "2.29" 'make-mobile))
  (define make-branch (solution "2.29" 'make-branch))
  (define balanced? (solution "2.29" 'balanced?))
  (define sub (make-mobile (make-branch 1 2) (make-branch 1 2)))
  (check-true (balanced? (make-mobile (make-branch 3 sub) (make-branch 4 3))))
  (check-true (balanced? (make-mobile (make-branch 1 sub) (make-branch 1 sub)))))

(test-case "top level balanced but a submobile is not"
  (define make-mobile (solution "2.29" 'make-mobile))
  (define make-branch (solution "2.29" 'make-branch))
  (define balanced? (solution "2.29" 'balanced?))
  (define bad-sub (make-mobile (make-branch 1 2) (make-branch 2 2)))
  (check-false (balanced? (make-mobile (make-branch 3 bad-sub) (make-branch 4 3))))
  (check-false (balanced? (make-mobile (make-branch 4 3) (make-branch 3 bad-sub)))))

(test-case "torque uses the total weight of a submobile"
  (define make-mobile (solution "2.29" 'make-mobile))
  (define make-branch (solution "2.29" 'make-branch))
  (define balanced? (solution "2.29" 'balanced?))
  (define sub (make-mobile (make-branch 1 2) (make-branch 1 2)))
  (check-false (balanced? (make-mobile (make-branch 1 sub) (make-branch 1 2)))))

#lang sicp
;; Exercise 2.60
;;
;; We specified that a set would be
;; represented as a list with no duplicates.  Now suppose we allow duplicates.
;; For instance, the set ${\{1, 2, 3\}}$ could be represented as the list `(2 3 2 1
;; 3 2 2)`.  Design procedures `element-of-set?`, `adjoin-set`,
;; `union-set`, and `intersection-set` that operate on this
;; representation.  How does the efficiency of each compare with the corresponding
;; procedure for the non-duplicate representation?  Are there applications for
;; which you would use this representation in preference to the non-duplicate one?

;; Test: raco test tests/chapter-2/exercise-2.60.test.rkt
;; Your exercises/chapter-2/exercise-2.60.rkt must (#%provide element-of-set? adjoin-set
;;                                                  union-set intersection-set)
;; Sets are lists in which elements may be repeated, e.g. (2 3 2 1 3 2 2).
;;   (element-of-set? x set)
;;   (adjoin-set x set)
;;   (union-set set1 set2)
;;   (intersection-set set1 set2)
;; You define all four yourself. The tests only compare which elements the results contain
;; (repeats and order are ignored).


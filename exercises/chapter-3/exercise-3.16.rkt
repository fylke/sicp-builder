#lang sicp
;; Exercise 3.16
;;
;; Ben Bitdiddle decides to write a
;; procedure to count the number of pairs in any list structure.  “It’s easy,”
;; he reasons.  “The number of pairs in any structure is the number in the
;; `car` plus the number in the `cdr` plus one more to count the current
;; pair.”  So Ben writes the following procedure:
;;
;; ```scheme
;; (define (count-pairs x)
;;   (if (not (pair? x))
;;       0
;;       (+ (count-pairs (car x))
;;          (count-pairs (cdr x))
;;          1)))
;; ```
;;
;; Show that this procedure is not correct.  In particular, draw box-and-pointer
;; diagrams representing list structures made up of exactly three pairs for which
;; Ben’s procedure would return 3; return 4; return 7; never return at all.

;; Test: raco test tests/chapter-3/exercise-3.16.test.rkt
;; Your exercises/chapter-3/exercise-3.16.rkt must
;;   (#%provide struct-3 struct-4 struct-7 struct-cycle)
;; Each is a list structure made of exactly three pairs, for which Ben's count-pairs
;; (the book's version, defined in this test) returns:
;;   struct-3     -> 3
;;   struct-4     -> 4
;;   struct-7     -> 7
;;   struct-cycle -> never returns (the structure contains a cycle)


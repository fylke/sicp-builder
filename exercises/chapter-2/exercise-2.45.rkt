#lang sicp
;; Exercise 2.45
;;
;; `Right-split` and
;; `up-split` can be expressed as instances of a general splitting operation.
;; Define a procedure `split` with the property that evaluating
;;
;; ```scheme
;; (define right-split (split beside below))
;; (define up-split (split below beside))
;; ```
;;
;; produces procedures `right-split` and `up-split` with the same
;; behaviors as the ones already defined.

;; Test: raco test tests/chapter-2/exercise-2.45.test.rkt
;; Your exercises/chapter-2/exercise-2.45.rkt must (#%provide split)
;;   (split first-combine second-combine) -- returns a procedure (painter n) such that
;;       (split beside below)  behaves like right-split
;;       (split below beside)  behaves like up-split
;;   i.e. (go painter 0) is painter, and otherwise
;;       (first-combine painter (second-combine smaller smaller))
;;   where smaller is (go painter (- n 1)).
;; The tests use stand-ins for beside and below that just build lists, so you do not
;; need any painters.


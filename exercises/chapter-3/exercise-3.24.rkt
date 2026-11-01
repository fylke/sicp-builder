#lang sicp
;; Exercise 3.24
;;
;; In the table implementations
;; above, the keys are tested for equality using `equal?` (called by
;; `assoc`).  This is not always the appropriate test.  For instance, we
;; might have a table with numeric keys in which we don’t need an exact match to
;; the number we’re looking up, but only a number within some tolerance of it.
;; Design a table constructor `make-table` that takes as an argument a
;; `same-key?` procedure that will be used to test “equality” of keys.
;; `Make-table` should return a `dispatch` procedure that can be used to
;; access appropriate `lookup` and `insert!` procedures for a local
;; table.

;; Test: raco test tests/chapter-3/exercise-3.24.test.rkt
;; Your exercises/chapter-3/exercise-3.24.rkt must (#%provide make-table)
;;   (make-table same-key?) -> a two-dimensional table (as in section 3.3.3) whose keys are
;;       compared with (same-key? a b) instead of equal?. It is a dispatch procedure:
;;       ((table 'lookup-proc) key-1 key-2)        -> the value, or #f if there is none
;;       ((table 'insert-proc!) key-1 key-2 value) -> stores value (replacing a match)


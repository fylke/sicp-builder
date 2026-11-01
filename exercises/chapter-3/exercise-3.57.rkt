#lang sicp
;; Exercise 3.57
;;
;; How many additions are performed
;; when we compute the $n^{\text{th}}$ Fibonacci number using the definition of
;; `fibs` based on the `add-streams` procedure?  Show that the number of
;; additions would be exponentially greater if we had implemented `(delay ⟨exp⟩)`
;; simply as `(lambda () ⟨exp⟩)`, without using the
;; optimization provided by the `memo-proc` procedure described in
;; 3.5.1.[^1]
;;
;; [^1]: This exercise shows how call-by-need is closely related
;; to ordinary memoization as described in [Exercise 3.27](../chapter-3/exercise-3.27.rkt).  In that exercise,
;; we used assignment to explicitly construct a local table.  Our call-by-need
;; stream optimization effectively constructs such a table automatically, storing
;; values in the previously forced parts of the stream.

;; No automatic test for this exercise.


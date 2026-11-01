#lang sicp
;; Exercise 3.19
;;
;; Redo [Exercise 3.18](../chapter-3/exercise-3.18.rkt) using an
;; algorithm that takes only a constant amount of space.  (This requires a very
;; clever idea.)

;; Test: raco test tests/chapter-3/exercise-3.19.test.rkt
;; Your exercises/chapter-3/exercise-3.19.rkt must (#%provide cycle?)
;;   (cycle? x) -> #t if taking successive cdrs of x would never reach the end of the
;;                 list (x contains a cycle), #f otherwise. Use constant extra space.
;; (The space bound cannot be checked here, but the lists below are large enough that a
;; quadratic seen-list approach will be slow.)


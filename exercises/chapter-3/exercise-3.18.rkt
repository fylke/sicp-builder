#lang sicp
;; Exercise 3.18
;;
;; Write a procedure that examines a
;; list and determines whether it contains a cycle, that is, whether a program
;; that tried to find the end of the list by taking successive `cdr`s would
;; go into an infinite loop.  [Exercise 3.13](../chapter-3/exercise-3.13.rkt) constructed such lists.

;; Test: raco test tests/chapter-3/exercise-3.18.test.rkt
;; Your exercises/chapter-3/exercise-3.18.rkt must (#%provide cycle?)
;;   (cycle? x) -> #t if taking successive cdrs of x would never reach the end of the
;;                 list (x contains a cycle), #f otherwise


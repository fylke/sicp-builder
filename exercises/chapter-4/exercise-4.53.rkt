#lang sicp
;; Exercise 4.53
;;
;; With `permanent-set!` as
;; described in [Exercise 4.51](../chapter-4/exercise-4.51.rkt) and `if-fail` as in [Exercise 4.52](../chapter-4/exercise-4.52.rkt),
;; what will be the result of evaluating
;;
;; ```scheme
;; (let ((pairs '()))
;;   (if-fail
;;    (let ((p (prime-sum-pair
;;              '(1 3 5 8)
;;              '(20 35 110))))
;;      (permanent-set! pairs
;;                      (cons p pairs))
;;      (amb))
;;    pairs))
;; ```

;; No automatic test for this exercise.


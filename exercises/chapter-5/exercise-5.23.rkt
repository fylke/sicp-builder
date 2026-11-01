#lang sicp
;; Exercise 5.23
;;
;; Extend the evaluator to handle
;; derived expressions such as `cond`, `let`, and so on
;; (4.1.2).  You may “cheat” and assume that the syntax transformers such
;; as `cond->if` are available as machine operations.[^1]
;;
;; [^1]: This isn’t
;; really cheating.  In an actual implementation built from scratch, we would use
;; our explicit-control evaluator to interpret a Scheme program that performs
;; source-level transformations like `cond->if` in a syntax phase that runs
;; before execution.

;; No automatic test for this exercise.


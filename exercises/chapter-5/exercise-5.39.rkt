#lang sicp
;; Exercise 5.39
;;
;; Write a procedure
;; `lexical-address-lookup` that implements the new lookup operation.  It
;; should take two arguments—a lexical address and a run-time environment—and
;; return the value of the variable stored at the specified lexical address.
;; `Lexical-address-lookup` should signal an error if the value of the
;; variable is the symbol `*unassigned*`.[^1] Also write a procedure
;; `lexical-address-set!` that implements the operation that changes the
;; value of the variable at a specified lexical address.
;;
;; [^1]: This is the modification
;; to variable lookup required if we implement the scanning method to eliminate
;; internal definitions ([Exercise 5.43](../chapter-5/exercise-5.43.rkt)).  We will need to eliminate these
;; definitions in order for lexical addressing to work.

;; No automatic test for this exercise.


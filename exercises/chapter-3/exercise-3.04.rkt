#lang sicp
;; Exercise 3.4
;;
;; Modify the `make-account`
;; procedure of [Exercise 3.3](../chapter-3/exercise-3.03.rkt) by adding another local state variable so that,
;; if an account is accessed more than seven consecutive times with an incorrect
;; password, it invokes the procedure `call-the-cops`.

;; Test: raco test tests/chapter-3/exercise-3.04.test.rkt
;; Your exercises/chapter-3/exercise-3.04.rkt must
;;   (#%provide make-account call-the-cops cops-called)
;;   (make-account balance password)  -> password-protected account as in Exercise 3.3
;;   (call-the-cops)  -> you define it; the account calls it (no arguments) after more
;;                       than seven consecutive wrong-password accesses
;;   (cops-called)    -> you define it; returns how many times call-the-cops has run so
;;                       the test can observe it (e.g. increment a counter in call-the-cops)


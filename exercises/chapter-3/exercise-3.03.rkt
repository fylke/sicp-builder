#lang sicp
;; Exercise 3.3
;;
;; Modify the `make-account`
;; procedure so that it creates password-protected accounts.  That is,
;; `make-account` should take a symbol as an additional argument, as in
;;
;; ```scheme
;; (define acc
;;   (make-account 100 'secret-password))
;; ```
;;
;; The resulting account object should process a request only if it is accompanied
;; by the password with which the account was created, and should otherwise return
;; a complaint:
;;
;; ```scheme
;; ((acc 'secret-password 'withdraw) 40)
;; 60
;;
;; ((acc 'some-other-password 'deposit) 50)
;; "Incorrect password"
;; ```

;; Test: raco test tests/chapter-3/exercise-3.03.test.rkt
;; Your exercises/chapter-3/exercise-3.03.rkt must (#%provide make-account)
;;   (make-account balance password) -> account: (acc password 'withdraw) and
;;     (acc password 'deposit) return one-argument procedures that return the new
;;     balance ("Insufficient funds" if overdrawn). With a wrong password the
;;     returned procedure must return the string "Incorrect password".


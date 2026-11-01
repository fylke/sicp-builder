#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.07.rkt must (#%provide make-account make-joint)
;;   (make-account balance password)  -> password-protected account (Exercise 3.3):
;;       ((acc password 'withdraw) n) / ((acc password 'deposit) n) return the new balance,
;;       a wrong password gives "Incorrect password"
;;   (make-joint acc password new-password) -> a second access to acc, using new-password

(test-case "the joint account acts on the original account"
  (define make-account (solution "3.07" 'make-account))
  (define make-joint (solution "3.07" 'make-joint))
  (define peter-acc (make-account 100 'open-sesame))
  (define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))
  (check-equal? ((paul-acc 'rosebud 'withdraw) 30) 70)
  (check-equal? ((peter-acc 'open-sesame 'deposit) 10) 80)
  (check-equal? ((paul-acc 'rosebud 'deposit) 20) 100))

(test-case "the joint account does not accept the old password"
  (define make-account (solution "3.07" 'make-account))
  (define make-joint (solution "3.07" 'make-joint))
  (define peter-acc (make-account 100 'open-sesame))
  (define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))
  (check-equal? ((paul-acc 'open-sesame 'withdraw) 10) "Incorrect password")
  (check-equal? ((paul-acc 'wrong 'deposit) 10) "Incorrect password")
  (check-equal? ((peter-acc 'open-sesame 'deposit) 0) 100))

(test-case "the original account does not accept the joint password"
  (define make-account (solution "3.07" 'make-account))
  (define make-joint (solution "3.07" 'make-joint))
  (define peter-acc (make-account 100 'open-sesame))
  (define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))
  (check-equal? ((peter-acc 'rosebud 'withdraw) 10) "Incorrect password"))

(test-case "insufficient funds through the joint account"
  (define make-account (solution "3.07" 'make-account))
  (define make-joint (solution "3.07" 'make-joint))
  (define acc (make-account 50 'a))
  (define joint (make-joint acc 'a 'b))
  (check-equal? ((joint 'b 'withdraw) 60) "Insufficient funds"))

(test-case "several joint accounts on one account"
  (define make-account (solution "3.07" 'make-account))
  (define make-joint (solution "3.07" 'make-joint))
  (define acc (make-account 100 'a))
  (define j1 (make-joint acc 'a 'b))
  (define j2 (make-joint acc 'a 'c))
  (check-equal? ((j1 'b 'withdraw) 10) 90)
  (check-equal? ((j2 'c 'withdraw) 10) 80)
  (check-equal? ((acc 'a 'withdraw) 10) 70))

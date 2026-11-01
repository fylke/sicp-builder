#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.03.rkt must (#%provide make-account)
;;   (make-account balance password) -> account: (acc password 'withdraw) and
;;     (acc password 'deposit) return one-argument procedures that return the new
;;     balance ("Insufficient funds" if overdrawn). With a wrong password the
;;     returned procedure must return the string "Incorrect password".

(test-case "withdraw and deposit with the right password"
  (define make-account (solution "3.03" 'make-account))
  (define acc (make-account 100 'secret-password))
  (check-equal? ((acc 'secret-password 'withdraw) 40) 60)
  (check-equal? ((acc 'secret-password 'deposit) 50) 110)
  (check-equal? ((acc 'secret-password 'withdraw) 110) 0))

(test-case "insufficient funds"
  (define make-account (solution "3.03" 'make-account))
  (define acc (make-account 100 'pw))
  (check-equal? ((acc 'pw 'withdraw) 101) "Insufficient funds")
  (check-equal? ((acc 'pw 'withdraw) 100) 0))

(test-case "wrong password is refused"
  (define make-account (solution "3.03" 'make-account))
  (define acc (make-account 100 'secret-password))
  (check-equal? ((acc 'some-other-password 'deposit) 50) "Incorrect password")
  (check-equal? ((acc 'some-other-password 'withdraw) 50) "Incorrect password"))

(test-case "a refused request does not change the balance"
  (define make-account (solution "3.03" 'make-account))
  (define acc (make-account 100 'pw))
  ((acc 'bad 'withdraw) 50)
  ((acc 'bad 'deposit) 50)
  (check-equal? ((acc 'pw 'deposit) 0) 100))

(test-case "accounts have independent balances and passwords"
  (define make-account (solution "3.03" 'make-account))
  (define a (make-account 100 'a-pw))
  (define b (make-account 10 'b-pw))
  (check-equal? ((a 'a-pw 'withdraw) 30) 70)
  (check-equal? ((b 'b-pw 'deposit) 5) 15)
  (check-equal? ((b 'a-pw 'deposit) 5) "Incorrect password"))

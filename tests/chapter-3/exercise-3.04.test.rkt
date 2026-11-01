#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.04.rkt must
;;   (#%provide make-account call-the-cops cops-called)
;;   (make-account balance password)  -> password-protected account as in Exercise 3.3
;;   (call-the-cops)  -> you define it; the account calls it (no arguments) after more
;;                       than seven consecutive wrong-password accesses
;;   (cops-called)    -> you define it; returns how many times call-the-cops has run so
;;                       the test can observe it (e.g. increment a counter in call-the-cops)

(define (bad acc n)
  (if (> n 0)
      (begin ((acc 'wrong 'withdraw) 1)
             (bad acc (- n 1)))))

(test-case "still works as in Exercise 3.3"
  (define make-account (solution "3.04" 'make-account))
  (define acc (make-account 100 'pw))
  (check-equal? ((acc 'pw 'withdraw) 40) 60)
  (check-equal? ((acc 'pw 'deposit) 10) 70)
  (check-equal? ((acc 'nope 'deposit) 50) "Incorrect password"))

(test-case "seven wrong passwords do not call the cops"
  (define make-account (solution "3.04" 'make-account))
  (define cops-called (solution "3.04" 'cops-called))
  (define before (cops-called))
  (define acc (make-account 100 'pw))
  (bad acc 7)
  (check-equal? (cops-called) before))

(test-case "the eighth consecutive wrong password calls the cops"
  (define make-account (solution "3.04" 'make-account))
  (define cops-called (solution "3.04" 'cops-called))
  (define before (cops-called))
  (define acc (make-account 100 'pw))
  (bad acc 8)
  (check-equal? (cops-called) (+ before 1)))

(test-case "a correct password resets the consecutive count"
  (define make-account (solution "3.04" 'make-account))
  (define cops-called (solution "3.04" 'cops-called))
  (define before (cops-called))
  (define acc (make-account 100 'pw))
  (bad acc 7)
  (check-equal? ((acc 'pw 'deposit) 1) 101)
  (bad acc 7)
  (check-equal? (cops-called) before)
  (check-equal? ((acc 'pw 'deposit) 1) 102))

(test-case "failures are counted per account"
  (define make-account (solution "3.04" 'make-account))
  (define cops-called (solution "3.04" 'cops-called))
  (define before (cops-called))
  (define a (make-account 100 'pw))
  (define b (make-account 100 'pw))
  (bad a 5)
  (bad b 5)
  (check-equal? (cops-called) before))

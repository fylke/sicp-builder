#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.19.rkt must (#%provide cc first-denomination
;;                                                  except-first-denomination no-more?)
;;   (cc amount coin-values)  -- number of ways to change `amount` using the coins in the list
;;                               coin-values (the book's cc, rewritten for a list of coins)
;;   (first-denomination coin-values)        -- the first coin of the list
;;   (except-first-denomination coin-values) -- the list without its first coin
;;   (no-more? coin-values)                  -- true if the list is empty
;; You define all of these yourself.

(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(test-case "list operations on coin lists"
  (define first-denomination (solution "2.19" 'first-denomination))
  (define except-first-denomination (solution "2.19" 'except-first-denomination))
  (define no-more? (solution "2.19" 'no-more?))
  (check-equal? (first-denomination (list 50 25 10)) 50)
  (check-equal? (except-first-denomination (list 50 25 10)) '(25 10))
  (check-equal? (except-first-denomination (list 1)) '())
  (check-true (no-more? '()))
  (check-false (no-more? (list 1)))
  (check-false (no-more? (list 50 25))))

(test-case "US coins"
  (define cc (solution "2.19" 'cc))
  (check-equal? (cc 100 us-coins) 292)
  (check-equal? (cc 10 us-coins) 4)
  (check-equal? (cc 11 us-coins) 4)
  (check-equal? (cc 0 us-coins) 1))

(test-case "UK coins"
  (define cc (solution "2.19" 'cc))
  (check-equal? (cc 100 uk-coins) 104561))

(test-case "no coins"
  (define cc (solution "2.19" 'cc))
  (check-equal? (cc 10 '()) 0)
  (check-equal? (cc 0 '()) 1))

(test-case "the order of the coins does not matter"
  (define cc (solution "2.19" 'cc))
  (check-equal? (cc 100 (list 1 5 10 25 50)) 292)
  (check-equal? (cc 100 (list 5 1 50 10 25)) 292)
  (check-equal? (cc 100 (list 0.5 1 2 5 10 20 50 100)) 104561))

(test-case "small cases"
  (define cc (solution "2.19" 'cc))
  (check-equal? (cc 5 (list 1 2)) 3)
  (check-equal? (cc 3 (list 2)) 0)
  (check-equal? (cc 4 (list 2)) 1))

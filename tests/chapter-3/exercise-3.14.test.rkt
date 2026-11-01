#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.14.rkt must (#%provide mystery)
;;   (mystery x) -> the book's mystery procedure: reverses the list x in place
;;                  (reusing its pairs) and returns the reversed list

(test-case "reverses a list"
  (define mystery (solution "3.14" 'mystery))
  (check-equal? (mystery (list 'a 'b 'c 'd)) '(d c b a)))

(test-case "empty and one-element lists"
  (define mystery (solution "3.14" 'mystery))
  (check-equal? (mystery '()) '())
  (check-equal? (mystery (list 1)) '(1)))

(test-case "after (define w (mystery v)), v is just (a)"
  (define mystery (solution "3.14" 'mystery))
  (define v (list 'a 'b 'c 'd))
  (define w (mystery v))
  (check-equal? v '(a))
  (check-equal? w '(d c b a)))

(test-case "reuses the original pairs"
  (define mystery (solution "3.14" 'mystery))
  (define v (list 'a 'b 'c))
  (define second (cdr v))
  (define third (cddr v))
  (define w (mystery v))
  (check-eq? w third)
  (check-eq? (cdr w) second)
  (check-eq? (cddr w) v))

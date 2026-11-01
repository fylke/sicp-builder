#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.02.rkt must (#%provide make-monitored)
;;   (make-monitored f) -> procedure mf of one argument: calls f and counts the call;
;;                         'how-many-calls? returns the count, 'reset-count resets it to 0

(test-case "returns f's result and counts calls"
  (define make-monitored (solution "3.02" 'make-monitored))
  (define s (make-monitored sqrt))
  (check-equal? (s 100) 10)
  (check-equal? (s 'how-many-calls?) 1)
  (check-equal? (s 16) 4)
  (check-equal? (s 25) 5)
  (check-equal? (s 'how-many-calls?) 3))

(test-case "a fresh monitored procedure has zero calls"
  (define make-monitored (solution "3.02" 'make-monitored))
  (define s (make-monitored (lambda (x) (* x x))))
  (check-equal? (s 'how-many-calls?) 0))

(test-case "asking how many calls is not itself counted"
  (define make-monitored (solution "3.02" 'make-monitored))
  (define s (make-monitored (lambda (x) x)))
  (s 1)
  (s 'how-many-calls?)
  (s 'how-many-calls?)
  (check-equal? (s 'how-many-calls?) 1))

(test-case "reset-count sets the counter back to zero"
  (define make-monitored (solution "3.02" 'make-monitored))
  (define s (make-monitored (lambda (x) (+ x 1))))
  (s 1)
  (s 2)
  (s 'reset-count)
  (check-equal? (s 'how-many-calls?) 0)
  (check-equal? (s 10) 11)
  (check-equal? (s 'how-many-calls?) 1))

(test-case "monitored procedures keep separate counters"
  (define make-monitored (solution "3.02" 'make-monitored))
  (define a (make-monitored (lambda (x) x)))
  (define b (make-monitored (lambda (x) x)))
  (a 1)
  (a 2)
  (b 3)
  (check-equal? (a 'how-many-calls?) 2)
  (check-equal? (b 'how-many-calls?) 1))

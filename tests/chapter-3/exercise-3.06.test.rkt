#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.06.rkt must (#%provide rand)
;;   (rand 'generate)           -> the next pseudo-random number
;;   ((rand 'reset) new-value)  -> resets the generator's state to new-value
;; Define your own rand-update (or similar) in the file; any generator will do as long
;; as the sequence after a reset is a deterministic function of new-value.

(define (take-n rand n)
  (if (= n 0)
      '()
      (let ((x (rand 'generate)))
        (cons x (take-n rand (- n 1))))))

(test-case "generate returns numbers"
  (define rand (solution "3.06" 'rand))
  (check-true (number? (rand 'generate)))
  (check-true (number? (rand 'generate))))

(test-case "the sequence is not constant"
  (define rand (solution "3.06" 'rand))
  (define xs (take-n rand 5))
  (check-false (and (= (car xs) (cadr xs)) (= (cadr xs) (caddr xs)))))

(test-case "reset with the same value repeats the sequence"
  (define rand (solution "3.06" 'rand))
  ((rand 'reset) 42)
  (define first-run (take-n rand 6))
  (take-n rand 3)
  ((rand 'reset) 42)
  (check-equal? (take-n rand 6) first-run))

(test-case "different reset values give different sequences"
  (define rand (solution "3.06" 'rand))
  ((rand 'reset) 1)
  (define a (take-n rand 5))
  ((rand 'reset) 2)
  (define b (take-n rand 5))
  (check-not-equal? a b))

(test-case "reset to a value, generate, reset again, still repeatable"
  (define rand (solution "3.06" 'rand))
  ((rand 'reset) 7)
  (define x1 (rand 'generate))
  (define x2 (rand 'generate))
  ((rand 'reset) 7)
  (check-equal? (rand 'generate) x1)
  (check-equal? (rand 'generate) x2))

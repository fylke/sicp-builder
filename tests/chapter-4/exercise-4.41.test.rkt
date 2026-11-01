#lang sicp
;; Your exercises/chapter-4/exercise-4.41.rkt must (#%provide multiple-dwelling).
;; multiple-dwelling: (multiple-dwelling) returns the floors for Baker, Cooper, Fletcher, Miller, and Smith, in that order.
;; No additional definitions are required.
(#%require rackunit "../lib.rkt")

(test-case "ordinary search finds the unique multiple-dwelling assignment"
  (define f (solution "4.41" 'multiple-dwelling))
  (check-equal? (f) '(3 2 4 5 1)))

#lang sicp
;; Your exercises/chapter-4/exercise-4.04.rkt must (#%provide and->if or->if).
;; and->if: (and->if exp) converts an and expression to nested if expressions.
;; or->if: (or->if exp) converts or to value-preserving if expressions using the first unused or-value-N temporary.
;; No additional definitions are required.
(#%require rackunit "../lib.rkt")

(test-case "and expansion preserves short-circuit result values"
  (define f (solution "4.04" 'and->if))
  (check-equal? (f '(and)) #t)
  (check-equal? (f '(and last)) 'last)
  (check-equal? (f '(and first second last))
                '(if first (if second last #f) #f)))

(test-case "or expansion returns the first true value and uses a fresh name"
  (define f (solution "4.04" 'or->if))
  (check-equal? (f '(or)) #f)
  (check-equal? (f '(or first)) 'first)
  (check-equal? (f '(or (check x) fallback))
                '(let ((or-value-0 (check x)))
                   (if or-value-0 or-value-0 fallback)))
  (check-equal? (f '(or (check or-value-0) fallback))
                '(let ((or-value-1 (check or-value-0)))
                   (if or-value-1 or-value-1 fallback))))

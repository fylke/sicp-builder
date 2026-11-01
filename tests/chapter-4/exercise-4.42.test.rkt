#lang sicp
;; Your exercises/chapter-4/exercise-4.42.rkt must (#%provide liars-puzzle).
;; liars-puzzle: (liars-puzzle) returns the ranks of Betty, Ethel, Joan, Kitty, and Mary, in that order (rank 1 is first place).
;; No additional definitions are required.
(#%require rackunit "../lib.rkt")

(test-case "each girl's two statements have exactly one truth"
  (define f (solution "4.42" 'liars-puzzle))
  (check-equal? (f) '(3 5 2 1 4)))

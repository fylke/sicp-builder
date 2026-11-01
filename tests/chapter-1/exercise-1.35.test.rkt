#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-1/exercise-1.35.rkt must (#%provide golden-ratio)
;;   golden-ratio -- a number (not a procedure): the golden ratio, computed with
;;                   fixed-point of x -> 1 + 1/x
;; (define tolerance and fixed-point yourself, as in the book)

(test-case "golden ratio"
  (define golden-ratio (solution "1.35" 'golden-ratio))
  (check-= golden-ratio 1.618033988749895 1e-4))

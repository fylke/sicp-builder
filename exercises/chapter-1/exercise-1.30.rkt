#lang sicp
;; Exercise 1.30
;;
;; The `sum` procedure above
;; generates a linear recursion.  The procedure can be rewritten so that the sum
;; is performed iteratively.  Show how to do this by filling in the missing
;; expressions in the following definition:
;;
;; ```scheme
;; (define (sum term a next b)
;;   (define (iter a result)
;;     (if ⟨??⟩
;;         ⟨??⟩
;;         (iter ⟨??⟩ ⟨??⟩)))
;;   (iter ⟨??⟩ ⟨??⟩))
;; ```

;; Test: raco test tests/chapter-1/exercise-1.30.test.rkt
;; Your exercises/chapter-1/exercise-1.30.rkt must (#%provide sum)
;;   (sum term a next b) -- sum of (term x) for x = a, (next a), ... while x <= b,
;;                          generating an ITERATIVE process


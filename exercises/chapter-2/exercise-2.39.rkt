#lang sicp
;; Exercise 2.39
;;
;; Complete the following
;; definitions of `reverse` ([Exercise 2.18](../chapter-2/exercise-2.18.rkt)) in terms of
;; `fold-right` and `fold-left` from [Exercise 2.38](../chapter-2/exercise-2.38.rkt):
;;
;; ```scheme
;; (define (reverse sequence)
;;   (fold-right
;;    (lambda (x y) ⟨??⟩) nil sequence))
;;
;; (define (reverse sequence)
;;   (fold-left
;;    (lambda (x y) ⟨??⟩) nil sequence))
;; ```

;; Test: raco test tests/chapter-2/exercise-2.39.test.rkt
;; Your exercises/chapter-2/exercise-2.39.rkt must (#%provide reverse-fold-right reverse-fold-left)
;;   (reverse-fold-right sequence) -- reverse of sequence, defined with fold-right
;;   (reverse-fold-left sequence)  -- reverse of sequence, defined with fold-left
;;                                    (the book names both reverse)
;; You must define fold-right and fold-left yourself (Exercise 2.38); they are not tested here.


#lang sicp
;; Exercise 2.33
;;
;; Fill in the missing expressions
;; to complete the following definitions of some basic list-manipulation
;; operations as accumulations:
;;
;; ```scheme
;; (define (map p sequence)
;;   (accumulate (lambda (x y) ⟨??⟩)
;;               nil sequence))
;;
;; (define (append seq1 seq2)
;;   (accumulate cons ⟨??⟩ ⟨??⟩))
;;
;; (define (length sequence)
;;   (accumulate ⟨??⟩ 0 sequence))
;; ```

;; Test: raco test tests/chapter-2/exercise-2.33.test.rkt
;; Your exercises/chapter-2/exercise-2.33.rkt must (#%provide map append length)
;;   (map p sequence)        -- list of (p x) for x in sequence
;;   (append seq1 seq2)      -- seq1 followed by seq2
;;   (length sequence)       -- number of elements
;; each defined with accumulate (shadowing the built-ins in your file). You must define
;; accumulate yourself; it is not tested here.


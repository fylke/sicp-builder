#lang sicp
;; Exercise 2.6
;;
;; In case representing pairs as
;; procedures wasn’t mind-boggling enough, consider that, in a language that can
;; manipulate procedures, we can get by without numbers (at least insofar as
;; nonnegative integers are concerned) by implementing 0 and the operation of
;; adding 1 as
;;
;; ```scheme
;; (define zero (lambda (f) (lambda (x) x)))
;;
;; (define (add-1 n)
;;   (lambda (f) (lambda (x) (f ((n f) x)))))
;; ```
;;
;; This representation is known as *Church numerals*, after its inventor,
;; Alonzo Church, the logician who invented the λ-calculus.
;;
;; Define `one` and `two` directly (not in terms of `zero` and
;; `add-1`).  (Hint: Use substitution to evaluate `(add-1 zero)`).  Give
;; a direct definition of the addition procedure `+` (not in terms of
;; repeated application of `add-1`).

;; Test: raco test tests/chapter-2/exercise-2.06.test.rkt
;; Your exercises/chapter-2/exercise-2.06.rkt must (#%provide zero add-1 one two plus)
;;   zero        -- the Church numeral 0 (given in the book)
;;   (add-1 n)   -- the Church numeral n+1 (given in the book)
;;   one, two    -- the Church numerals 1 and 2, defined directly (not via add-1)
;;   (plus a b)  -- the sum of Church numerals a and b, defined directly
;;                  (the exercise calls it +; it is named `plus` here so it
;;                  does not clash with the built-in +)


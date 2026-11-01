#lang sicp
;; Exercise 3.35
;;
;; Ben Bitdiddle tells Louis that
;; one way to avoid the trouble in [Exercise 3.34](../chapter-3/exercise-3.34.rkt) is to define a squarer as a
;; new primitive constraint.  Fill in the missing portions in Ben’s outline for a
;; procedure to implement such a constraint:
;;
;; ```scheme
;; (define (squarer a b)
;;   (define (process-new-value)
;;     (if (has-value? b)
;;         (if (< (get-value b) 0)
;;             (error "square less than 0:
;;                     SQUARER"
;;                    (get-value b))
;;             ⟨alternative1⟩)
;;         ⟨alternative2⟩))
;;   (define (process-forget-value) ⟨body1⟩)
;;   (define (me request) ⟨body2⟩)
;;   ⟨rest of definition⟩
;;   me)
;; ```

;; Test: raco test tests/chapter-3/exercise-3.35.test.rkt
;; Your exercises/chapter-3/exercise-3.35.rkt must (#%provide make-connector set-value!
;;   get-value has-value? forget-value! squarer)
;; The constraint system of section 3.3.5 is NOT part of the exercise: copy the book's
;; code (connectors, adder, multiplier, constant, ...) into your file and add squarer.
;;   (make-connector) (set-value! connector n informant) (get-value c) (has-value? c)
;;   (forget-value! c retractor)       -> as in the book
;;   (squarer a b)                     -> primitive constraint: b is the square of a.
;;       Given b >= 0 it sets a to the (non-negative) square root; given b < 0 it signals
;;       an error; given a it sets b to a*a.


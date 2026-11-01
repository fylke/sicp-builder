#lang sicp
;; Exercise 2.1
;;
;; Define a better version of
;; `make-rat` that handles both positive and negative arguments.
;; `Make-rat` should normalize the sign so that if the rational number is
;; positive, both the numerator and denominator are positive, and if the rational
;; number is negative, only the numerator is negative.

;; Test: raco test tests/chapter-2/exercise-2.01.test.rkt
;; Your exercises/chapter-2/exercise-2.01.rkt must (#%provide make-rat numer denom)
;;   (make-rat n d)  -- the rational n/d, reduced to lowest terms, sign normalised
;;   (numer r)       -- numerator of r
;;   (denom r)       -- denominator of r (positive)
;; You define all three yourself (including whatever gcd handling you need).


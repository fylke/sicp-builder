#lang sicp
;; Exercise 1.46
;;
;; Several of the numerical methods
;; described in this chapter are instances of an extremely general computational
;; strategy known as *iterative improvement*.  Iterative improvement says
;; that, to compute something, we start with an initial guess for the answer, test
;; if the guess is good enough, and otherwise improve the guess and continue the
;; process using the improved guess as the new guess.  Write a procedure
;; `iterative-improve` that takes two procedures as arguments: a method for
;; telling whether a guess is good enough and a method for improving a guess.
;; `Iterative-improve` should return as its value a procedure that takes a
;; guess as argument and keeps improving the guess until it is good enough.
;; Rewrite the `sqrt` procedure of 1.1.7 and the
;; `fixed-point` procedure of 1.3.3 in terms of
;; `iterative-improve`.

;; Test: raco test tests/chapter-1/exercise-1.46.test.rkt
;; Your exercises/chapter-1/exercise-1.46.rkt must (#%provide iterative-improve sqrt fixed-point)
;;   (iterative-improve good-enough? improve) -- returns a procedure of a guess that keeps
;;                                               improving it until (good-enough? guess)
;;   (sqrt x)                -- square root of x > 0, written with iterative-improve
;;   (fixed-point f guess)   -- fixed point of f starting at guess, written with iterative-improve
;;                              (stop when successive values differ by less than your tolerance)


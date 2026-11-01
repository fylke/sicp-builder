#lang sicp
;; Exercise 1.44
;;
;; The idea of *smoothing* a
;; function is an important concept in signal processing.  If $f$ is a function
;; and ${dx}$ is some small number, then the smoothed version of $f$ is the
;; function whose value at a point $x$ is the average of ${f(x - dx)}$,
;; ${f(x)}$, and ${f(x + dx)}$.  Write a procedure
;; `smooth` that takes as input a procedure that computes $f$ and returns a
;; procedure that computes the smoothed $f$.  It is sometimes valuable to
;; repeatedly smooth a function (that is, smooth the smoothed function, and so on)
;; to obtain the **n*-fold smoothed function*.  Show how to generate
;; the *n*-fold smoothed function of any given function using `smooth` and
;; `repeated` from [Exercise 1.43](../chapter-1/exercise-1.43.rkt).

;; Test: raco test tests/chapter-1/exercise-1.44.test.rkt
;; Your exercises/chapter-1/exercise-1.44.rkt must (#%provide smooth n-fold-smooth)
;;   (smooth f)          -- the smoothed version of f: x -> average of f(x-dx), f(x), f(x+dx)
;;   (n-fold-smooth f n) -- f smoothed n times (n >= 1), using smooth and repeated
;; (define dx, and repeated/compose, yourself)


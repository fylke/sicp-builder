#lang sicp
;; Exercise 3.79
;;
;; Generalize the `solve-2nd`
;; procedure of [Exercise 3.78](../chapter-3/exercise-3.78.rkt) so that it can be used to solve general
;; second-order differential equations ${d^2 y / dt^2} = {f(dy / dt, y)}$.

;; Test: raco test tests/chapter-3/exercise-3.79.test.rkt
;; Your exercises/chapter-3/exercise-3.79.rkt must (#%provide general-solve-2nd)
;;   (general-solve-2nd f dt y0 dy0) -> stream of values of y for d2y/dt2 = (f dy/dt y),
;;   where f is a procedure of two arguments (dy y); y(0) = y0, dy/dt(0) = dy0.
;;   Element k is the explicit-Euler value: y_(k+1) = y_k + dt*dy_k, dy_(k+1) = dy_k + dt*(f dy_k y_k).
;; Define integral and the stream helpers yourself in the file.


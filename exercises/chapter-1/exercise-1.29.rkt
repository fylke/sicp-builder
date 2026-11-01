#lang sicp
;; Exercise 1.29
;;
;; Simpson’s Rule is a more accurate
;; method of numerical integration than the method illustrated above.  Using
;; Simpson’s Rule, the integral of a function $f$ between $a$ and $b$ is
;; approximated as
;;
;; $$
;; \frac{h}{3}(y_0 + {4y_1} + {2y_2} + {4y_3} + {2y_4} + \dots + {2y_{n-2}} + {4y_{n-1} + y_n),}
;; $$
;;
;; where ${h = (b - a)/n}$, for some even integer $n$, and
;; $y_k = {f(a + kh)}$.  (Increasing $n$ increases the
;; accuracy of the approximation.)  Define a procedure that takes as arguments
;; $f$, $a$, $b$, and $n$ and returns the value of the integral, computed
;; using Simpson’s Rule.  Use your procedure to integrate `cube` between 0
;; and 1 (with ${n = 100}$ and ${n = 1000}$), and compare the results to those of
;; the `integral` procedure shown above.

;; Test: raco test tests/chapter-1/exercise-1.29.test.rkt
;; Your exercises/chapter-1/exercise-1.29.rkt must (#%provide simpson)
;;   (simpson f a b n) -- Simpson's Rule approximation of the integral of f from a to b
;;                        using an even number n of intervals
;; (define cube, sum, etc. yourself)


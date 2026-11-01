#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-1/exercise-1.38.rkt must (#%provide e-approx)
;;   (e-approx k) -- approximation of e = 2 + (Euler's continued fraction with N_i = 1 and
;;                   D_i = 1, 2, 1, 1, 4, 1, 1, 6, ...) truncated after k terms
;; (define cont-frac yourself)

(test-case "first few truncations"
  (define e-approx (solution "1.38" 'e-approx))
  (check-= (e-approx 1) 3.0 1e-9)
  (check-= (e-approx 2) (+ 2 (/ 2.0 3)) 1e-9)
  (check-= (e-approx 3) 2.75 1e-9)
  (check-= (e-approx 4) (+ 2 (/ 1.0 (+ 1 (/ 1.0 (+ 2 (/ 1.0 (+ 1 (/ 1.0 1)))))))) 1e-9))

(test-case "converges to e"
  (define e-approx (solution "1.38" 'e-approx))
  (check-= (e-approx 20) 2.718281828459045 1e-7)
  (check-= (e-approx 100) 2.718281828459045 1e-12))

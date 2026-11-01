#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-1/exercise-1.39.rkt must (#%provide tan-cf)
;;   (tan-cf x k) -- Lambert's continued fraction approximation of tan x (x in radians),
;;                   truncated after k terms
;; (define cont-frac yourself)

(test-case "few terms"
  (define tan-cf (solution "1.39" 'tan-cf))
  (check-= (tan-cf 0.5 1) 0.5 1e-12)
  (check-= (tan-cf 2.0 2) (/ 2.0 (- 1 (/ 4.0 3))) 1e-12)
  (check-= (tan-cf 1.0 3) (/ 1.0 (- 1 (/ 1.0 (- 3 (/ 1.0 5))))) 1e-12))

(test-case "converges to tan"
  (define tan-cf (solution "1.39" 'tan-cf))
  (check-= (tan-cf 1.0 15) 1.5574077246549023 1e-9)
  (check-= (tan-cf 0.5 15) 0.5463024898437905 1e-9)
  (check-= (tan-cf -1.0 15) -1.5574077246549023 1e-9)
  (check-= (tan-cf 0.0 10) 0.0 1e-12)
  (check-= (tan-cf 3.0 30) -0.1425465430742778 1e-9))

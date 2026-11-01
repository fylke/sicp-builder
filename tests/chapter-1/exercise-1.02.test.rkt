#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-1/exercise-1.02.rkt must (#%provide result)
;;   result : number -- the value of the prefix-form expression from the exercise,
;;            i.e. (/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7)))

(test-case "result is -37/150"
  (define result (solution "1.02" 'result))
  (check-= result -37/150 1e-9))

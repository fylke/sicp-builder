#lang sicp
;; Exercise 1.2
;;
;; Translate the following expression
;; into prefix form:
;;
;; $$
;; {\frac{5 + 4 + (2 - (3 - (6 + \frac{4}{5})))}{3(6 - 2)(2 - 7)}.}
;; $$

;; Test: raco test tests/chapter-1/exercise-1.02.test.rkt
;; Your exercises/chapter-1/exercise-1.02.rkt must (#%provide result)
;;   result : number -- the value of the prefix-form expression from the exercise,
;;            i.e. (/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7)))


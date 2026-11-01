#lang sicp
;; Exercise 2.25
;;
;; Give combinations of `car`s
;; and `cdr`s that will pick 7 from each of the following lists:
;;
;; ```scheme
;; (1 3 (5 7) 9)
;; ((7))
;; (1 (2 (3 (4 (5 (6 7))))))
;; ```

;; Test: raco test tests/chapter-2/exercise-2.25.test.rkt
;; Your exercises/chapter-2/exercise-2.25.rkt must (#%provide seven-a seven-b seven-c)
;;   (seven-a l) -- picks 7 out of a list shaped like (1 3 (5 7) 9)
;;   (seven-b l) -- picks 7 out of a list shaped like ((7))
;;   (seven-c l) -- picks 7 out of a list shaped like (1 (2 (3 (4 (5 (6 7))))))
;; Each is a procedure of one argument built only from car and cdr (combinations of them).


#lang sicp
;; Exercise 1.40
;;
;; Define a procedure `cubic`
;; that can be used together with the `newtons-method` procedure in
;; expressions of the form
;;
;; ```scheme
;; (newtons-method (cubic a b c) 1)
;; ```
;;
;; to approximate zeros of the cubic ${x^3 + ax^2 + bx + c}$.

;; Test: raco test tests/chapter-1/exercise-1.40.test.rkt
;; Your exercises/chapter-1/exercise-1.40.rkt must (#%provide cubic)
;;   (cubic a b c) -- the procedure x -> x^3 + a x^2 + b x + c
;; (this test supplies the book's newtons-method itself)


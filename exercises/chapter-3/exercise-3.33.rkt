#lang sicp
;; Exercise 3.33
;;
;; Using primitive multiplier,
;; adder, and constant constraints, define a procedure `averager` that takes
;; three connectors `a`, `b`, and `c` as inputs and establishes the
;; constraint that the value of `c` is the average of the values of `a`
;; and `b`.

;; Test: raco test tests/chapter-3/exercise-3.33.test.rkt
;; Your exercises/chapter-3/exercise-3.33.rkt must (#%provide make-connector set-value!
;;   get-value has-value? forget-value! averager)
;; The constraint system of section 3.3.5 is NOT part of the exercise: copy the book's
;; code (connectors, adder, multiplier, constant, ...) into your file and add averager.
;;   (make-connector)                  -> a new connector
;;   (set-value! connector n informant) (get-value c) (has-value? c) (forget-value! c retractor)
;;                                     -> as in the book
;;   (averager a b c)                  -> constraint: c is the average of a and b
;;                                        (built from adder, multiplier and constant)


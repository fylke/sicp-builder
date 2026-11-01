#lang sicp
;; Exercise 3.28
;;
;; Define an or-gate as a primitive
;; function box.  Your `or-gate` constructor should be similar to
;; `and-gate`.

;; Test: raco test tests/chapter-3/exercise-3.28.test.rkt
;; Your exercises/chapter-3/exercise-3.28.rkt must
;;   (#%provide make-wire get-signal set-signal! propagate or-gate)
;; The digital-circuit simulator of section 3.3.4 is NOT part of the exercise: copy the
;; book's code (wires, agenda, inverter, and-gate, ...) into your file and add your or-gate.
;;   (make-wire)                 -> a new wire, signal 0
;;   (get-signal wire)           -> the wire's current signal (0 or 1)
;;   (set-signal! wire v)        -> sets the signal (action procedures are triggered)
;;   (propagate)                 -> runs the agenda until it is empty
;;   (or-gate a1 a2 output)      -> primitive or-gate function box


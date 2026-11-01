#lang sicp
;; Exercise 3.29
;;
;; Another way to construct an
;; or-gate is as a compound digital logic device, built from and-gates and
;; inverters.  Define a procedure `or-gate` that accomplishes this.  What is
;; the delay time of the or-gate in terms of `and-gate-delay` and
;; `inverter-delay`?

;; Test: raco test tests/chapter-3/exercise-3.29.test.rkt
;; Your exercises/chapter-3/exercise-3.29.rkt must
;;   (#%provide make-wire get-signal set-signal! propagate or-gate)
;; The digital-circuit simulator of section 3.3.4 is NOT part of the exercise: copy the
;; book's code (wires, agenda, inverter, and-gate, ...) into your file and add your or-gate,
;; built only from and-gates and inverters.
;;   (make-wire)                 -> a new wire, signal 0
;;   (get-signal wire)           -> the wire's current signal (0 or 1)
;;   (set-signal! wire v)        -> sets the signal (action procedures are triggered)
;;   (propagate)                 -> runs the agenda until it is empty
;;   (or-gate a1 a2 output)      -> compound or-gate


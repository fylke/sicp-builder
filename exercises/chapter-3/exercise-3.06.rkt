#lang sicp
;; Exercise 3.6
;;
;; It is useful to be able to reset a
;; random-number generator to produce a sequence starting from a given value.
;; Design a new `rand` procedure that is called with an argument that is
;; either the symbol `generate` or the symbol `reset` and behaves as
;; follows: `(rand 'generate)` produces a new random number; `((rand
;; 'reset) ⟨new-value⟩)` resets the internal state variable to the
;; designated `⟨`*new-value*`⟩`.  Thus, by resetting the state, one can generate
;; repeatable sequences.  These are very handy to have when testing and debugging
;; programs that use random numbers.

;; Test: raco test tests/chapter-3/exercise-3.06.test.rkt
;; Your exercises/chapter-3/exercise-3.06.rkt must (#%provide rand)
;;   (rand 'generate)           -> the next pseudo-random number
;;   ((rand 'reset) new-value)  -> resets the generator's state to new-value
;; Define your own rand-update (or similar) in the file; any generator will do as long
;; as the sequence after a reset is a deterministic function of new-value.


#lang sicp
;; Exercise 3.81
;;
;; [Exercise 3.6](../chapter-3/exercise-3.06.rkt) discussed
;; generalizing the random-number generator to allow one to reset the
;; random-number sequence so as to produce repeatable sequences of “random”
;; numbers.  Produce a stream formulation of this same generator that operates on
;; an input stream of requests to `generate` a new random number or to
;; `reset` the sequence to a specified value and that produces the desired
;; stream of random numbers.  Don’t use assignment in your solution.

;; Test: raco test tests/chapter-3/exercise-3.81.test.rkt
;; Your exercises/chapter-3/exercise-3.81.rkt must (#%provide rand-stream)
;;   (rand-stream requests) -> stream of random numbers, one for each 'generate request in the
;;   stream requests; a request (list 'reset n) sets the generator state to n and produces no output.
;;   The numbers produced depend only on the state (no assignment); after (reset n) the same
;;   numbers always follow. The requests are the symbol generate or lists (reset <number>).
;; Define rand-update and the stream helpers yourself in the file.


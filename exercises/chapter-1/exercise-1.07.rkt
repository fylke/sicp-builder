#lang sicp
;; Exercise 1.7
;;
;; The `good-enough?` test used
;; in computing square roots will not be very effective for finding the square
;; roots of very small numbers.  Also, in real computers, arithmetic operations
;; are almost always performed with limited precision.  This makes our test
;; inadequate for very large numbers.  Explain these statements, with examples
;; showing how the test fails for small and large numbers.  An alternative
;; strategy for implementing `good-enough?` is to watch how `guess`
;; changes from one iteration to the next and to stop when the change is a very
;; small fraction of the guess.  Design a square-root procedure that uses this
;; kind of end test.  Does this work better for small and large numbers?

;; Test: raco test tests/chapter-1/exercise-1.07.test.rkt
;; Your exercises/chapter-1/exercise-1.07.rkt must (#%provide sqrt)
;;   (sqrt x) -- square root of a positive number x, using Newton's method with your
;;               improved good-enough? test (must work for very small and very large x)
;; (define sqrt-iter, good-enough?, improve, etc. yourself)


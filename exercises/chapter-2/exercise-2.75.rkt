#lang sicp
;; Exercise 2.75
;;
;; Implement the constructor
;; `make-from-mag-ang` in message-passing style.  This procedure should be
;; analogous to the `make-from-real-imag` procedure given above.

;; Test: raco test tests/chapter-2/exercise-2.75.test.rkt
;; Your exercises/chapter-2/exercise-2.75.rkt must (#%provide make-from-mag-ang)
;;   (make-from-mag-ang mag ang) -- a complex number in message-passing style: a procedure that
;;                                  takes one of the messages 'real-part, 'imag-part,
;;                                  'magnitude, 'angle and returns the corresponding value;
;;                                  any other message signals an error


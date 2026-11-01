#lang sicp
(#%require rackunit "../lib.rkt" (only racket/base exn:fail?))

;; Your exercises/chapter-2/exercise-2.75.rkt must (#%provide make-from-mag-ang)
;;   (make-from-mag-ang mag ang) -- a complex number in message-passing style: a procedure that
;;                                  takes one of the messages 'real-part, 'imag-part,
;;                                  'magnitude, 'angle and returns the corresponding value;
;;                                  any other message signals an error

(define eps 1e-9)
(define pi (* 4 (atan 1)))

(test-case "magnitude and angle are returned as given"
  (define make-from-mag-ang (solution "2.75" 'make-from-mag-ang))
  (define z (make-from-mag-ang 5 0.7))
  (check-= (z 'magnitude) 5 eps)
  (check-= (z 'angle) 0.7 eps))

(test-case "real and imaginary parts"
  (define make-from-mag-ang (solution "2.75" 'make-from-mag-ang))
  (define z (make-from-mag-ang 2 (/ pi 3)))
  (check-= (z 'real-part) 1 eps)
  (check-= (z 'imag-part) (sqrt 3) eps))

(test-case "angle 0 and pi/2"
  (define make-from-mag-ang (solution "2.75" 'make-from-mag-ang))
  (define a (make-from-mag-ang 3 0))
  (define b (make-from-mag-ang 4 (/ pi 2)))
  (check-= (a 'real-part) 3 eps)
  (check-= (a 'imag-part) 0 eps)
  (check-= (b 'real-part) 0 eps)
  (check-= (b 'imag-part) 4 eps))

(test-case "negative real part"
  (define make-from-mag-ang (solution "2.75" 'make-from-mag-ang))
  (define z (make-from-mag-ang 1 pi))
  (check-= (z 'real-part) -1 eps)
  (check-= (z 'imag-part) 0 eps))

(test-case "unknown operation signals an error"
  (define make-from-mag-ang (solution "2.75" 'make-from-mag-ang))
  (define z (make-from-mag-ang 1 1))
  (check-exn exn:fail? (lambda () (z 'bogus))))

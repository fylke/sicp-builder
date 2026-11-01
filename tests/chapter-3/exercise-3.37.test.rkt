#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.37.rkt must (#%provide make-connector set-value!
;;   get-value has-value? forget-value! c+ c- c* c/ cv)
;; The constraint system of section 3.3.5 is NOT part of the exercise: copy the book's
;; code (connectors, adder, multiplier, constant, ...) into your file and add the
;; expression-oriented operators:
;;   (c+ x y) (c- x y) (c* x y) (c/ x y)  -> a new connector constrained to x+y, x-y, x*y, x/y
;;   (cv value)                           -> a new connector holding the constant value
;;   (make-connector) (set-value! connector n informant) (get-value c) (has-value? c)
;;   (forget-value! c retractor)          -> as in the book

(test-case "c+ c- c* c/ on known values"
  (define make-connector (solution "3.37" 'make-connector))
  (define set-value! (solution "3.37" 'set-value!))
  (define get-value (solution "3.37" 'get-value))
  (define c+ (solution "3.37" 'c+))
  (define c- (solution "3.37" 'c-))
  (define c* (solution "3.37" 'c*))
  (define c/ (solution "3.37" 'c/))
  (define x (make-connector))
  (define y (make-connector))
  (define sum (c+ x y))
  (define diff (c- x y))
  (define prod (c* x y))
  (define quot (c/ x y))
  (set-value! x 12 'user)
  (set-value! y 4 'user)
  (check-equal? (get-value sum) 16)
  (check-equal? (get-value diff) 8)
  (check-equal? (get-value prod) 48)
  (check-equal? (get-value quot) 3))

(test-case "c/ gives exact fractions"
  (define make-connector (solution "3.37" 'make-connector))
  (define set-value! (solution "3.37" 'set-value!))
  (define get-value (solution "3.37" 'get-value))
  (define c/ (solution "3.37" 'c/))
  (define x (make-connector))
  (define y (make-connector))
  (define q (c/ x y))
  (set-value! x 9 'user)
  (set-value! y 5 'user)
  (check-equal? (get-value q) 9/5))

(test-case "cv is a constant connector"
  (define get-value (solution "3.37" 'get-value))
  (define has-value? (solution "3.37" 'has-value?))
  (define cv (solution "3.37" 'cv))
  (define five (cv 5))
  (check-true (has-value? five))
  (check-equal? (get-value five) 5))

(test-case "constants combine with connectors"
  (define make-connector (solution "3.37" 'make-connector))
  (define set-value! (solution "3.37" 'set-value!))
  (define get-value (solution "3.37" 'get-value))
  (define c+ (solution "3.37" 'c+))
  (define c* (solution "3.37" 'c*))
  (define cv (solution "3.37" 'cv))
  (define x (make-connector))
  (define y (c+ (c* (cv 2) x) (cv 1)))
  (set-value! x 10 'user)
  (check-equal? (get-value y) 21))

(test-case "operators run backwards: c- from the result"
  (define make-connector (solution "3.37" 'make-connector))
  (define set-value! (solution "3.37" 'set-value!))
  (define get-value (solution "3.37" 'get-value))
  (define c- (solution "3.37" 'c-))
  (define x (make-connector))
  (define y (make-connector))
  (define z (c- x y))
  (set-value! z 3 'user)
  (set-value! y 4 'user)
  (check-equal? (get-value x) 7))

(test-case "celsius-fahrenheit converter in expression style"
  (define make-connector (solution "3.37" 'make-connector))
  (define set-value! (solution "3.37" 'set-value!))
  (define get-value (solution "3.37" 'get-value))
  (define has-value? (solution "3.37" 'has-value?))
  (define forget-value! (solution "3.37" 'forget-value!))
  (define c+ (solution "3.37" 'c+))
  (define c* (solution "3.37" 'c*))
  (define c/ (solution "3.37" 'c/))
  (define cv (solution "3.37" 'cv))
  (define (celsius-fahrenheit-converter x)
    (c+ (c* (c/ (cv 9) (cv 5))
            x)
        (cv 32)))
  (define C (make-connector))
  (define F (celsius-fahrenheit-converter C))
  (set-value! C 25 'user)
  (check-equal? (get-value F) 77)
  (forget-value! C 'user)
  (check-false (has-value? F))
  (set-value! F 212 'user)
  (check-equal? (get-value C) 100))

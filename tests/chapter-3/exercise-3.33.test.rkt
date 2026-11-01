#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.33.rkt must (#%provide make-connector set-value!
;;   get-value has-value? forget-value! averager)
;; The constraint system of section 3.3.5 is NOT part of the exercise: copy the book's
;; code (connectors, adder, multiplier, constant, ...) into your file and add averager.
;;   (make-connector)                  -> a new connector
;;   (set-value! connector n informant) (get-value c) (has-value? c) (forget-value! c retractor)
;;                                     -> as in the book
;;   (averager a b c)                  -> constraint: c is the average of a and b
;;                                        (built from adder, multiplier and constant)

(test-case "c is the average once a and b are known"
  (define make-connector (solution "3.33" 'make-connector))
  (define set-value! (solution "3.33" 'set-value!))
  (define get-value (solution "3.33" 'get-value))
  (define has-value? (solution "3.33" 'has-value?))
  (define averager (solution "3.33" 'averager))
  (define a (make-connector))
  (define b (make-connector))
  (define c (make-connector))
  (averager a b c)
  (check-false (has-value? c))
  (set-value! a 10 'user)
  (check-false (has-value? c))
  (set-value! b 20 'user)
  (check-equal? (get-value c) 15))

(test-case "the average can be fractional"
  (define make-connector (solution "3.33" 'make-connector))
  (define set-value! (solution "3.33" 'set-value!))
  (define get-value (solution "3.33" 'get-value))
  (define averager (solution "3.33" 'averager))
  (define a (make-connector))
  (define b (make-connector))
  (define c (make-connector))
  (averager a b c)
  (set-value! a 1 'user)
  (set-value! b 2 'user)
  (check-equal? (get-value c) 3/2))

(test-case "b is computed from a and c"
  (define make-connector (solution "3.33" 'make-connector))
  (define set-value! (solution "3.33" 'set-value!))
  (define get-value (solution "3.33" 'get-value))
  (define averager (solution "3.33" 'averager))
  (define a (make-connector))
  (define b (make-connector))
  (define c (make-connector))
  (averager a b c)
  (set-value! a 10 'user)
  (set-value! c 15 'user)
  (check-equal? (get-value b) 20))

(test-case "a is computed from b and c"
  (define make-connector (solution "3.33" 'make-connector))
  (define set-value! (solution "3.33" 'set-value!))
  (define get-value (solution "3.33" 'get-value))
  (define averager (solution "3.33" 'averager))
  (define a (make-connector))
  (define b (make-connector))
  (define c (make-connector))
  (averager a b c)
  (set-value! b 7 'user)
  (set-value! c 4 'user)
  (check-equal? (get-value a) 1))

(test-case "forgetting a value retracts the dependent ones"
  (define make-connector (solution "3.33" 'make-connector))
  (define set-value! (solution "3.33" 'set-value!))
  (define get-value (solution "3.33" 'get-value))
  (define has-value? (solution "3.33" 'has-value?))
  (define forget-value! (solution "3.33" 'forget-value!))
  (define averager (solution "3.33" 'averager))
  (define a (make-connector))
  (define b (make-connector))
  (define c (make-connector))
  (averager a b c)
  (set-value! a 10 'user)
  (set-value! b 20 'user)
  (check-equal? (get-value c) 15)
  (forget-value! a 'user)
  (check-false (has-value? c))
  (set-value! a 30 'user)
  (check-equal? (get-value c) 25))

(test-case "works with values already present when the constraint is attached"
  (define make-connector (solution "3.33" 'make-connector))
  (define set-value! (solution "3.33" 'set-value!))
  (define get-value (solution "3.33" 'get-value))
  (define averager (solution "3.33" 'averager))
  (define a (make-connector))
  (define b (make-connector))
  (define c (make-connector))
  (set-value! a 2 'user)
  (set-value! b 4 'user)
  (averager a b c)
  (check-equal? (get-value c) 3))


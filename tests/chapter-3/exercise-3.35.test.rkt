#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.35.rkt must (#%provide make-connector set-value!
;;   get-value has-value? forget-value! squarer)
;; The constraint system of section 3.3.5 is NOT part of the exercise: copy the book's
;; code (connectors, adder, multiplier, constant, ...) into your file and add squarer.
;;   (make-connector) (set-value! connector n informant) (get-value c) (has-value? c)
;;   (forget-value! c retractor)       -> as in the book
;;   (squarer a b)                     -> primitive constraint: b is the square of a.
;;       Given b >= 0 it sets a to the (non-negative) square root; given b < 0 it signals
;;       an error; given a it sets b to a*a.

(test-case "b is the square of a"
  (define make-connector (solution "3.35" 'make-connector))
  (define set-value! (solution "3.35" 'set-value!))
  (define get-value (solution "3.35" 'get-value))
  (define squarer (solution "3.35" 'squarer))
  (define a (make-connector))
  (define b (make-connector))
  (squarer a b)
  (set-value! a 5 'user)
  (check-equal? (get-value b) 25))

(test-case "a is the square root of b"
  (define make-connector (solution "3.35" 'make-connector))
  (define set-value! (solution "3.35" 'set-value!))
  (define get-value (solution "3.35" 'get-value))
  (define squarer (solution "3.35" 'squarer))
  (define a (make-connector))
  (define b (make-connector))
  (squarer a b)
  (set-value! b 25 'user)
  (check-equal? (get-value a) 5))

(test-case "square root of a non-square"
  (define make-connector (solution "3.35" 'make-connector))
  (define set-value! (solution "3.35" 'set-value!))
  (define get-value (solution "3.35" 'get-value))
  (define squarer (solution "3.35" 'squarer))
  (define a (make-connector))
  (define b (make-connector))
  (squarer a b)
  (set-value! b 2 'user)
  (check-= (get-value a) 1.41421356 1e-6))

(test-case "a negative square is an error"
  (define make-connector (solution "3.35" 'make-connector))
  (define set-value! (solution "3.35" 'set-value!))
  (define squarer (solution "3.35" 'squarer))
  (define a (make-connector))
  (define b (make-connector))
  (squarer a b)
  (check-exn (lambda (e) #t) (lambda () (set-value! b -4 'user))))

(test-case "negative a gives a positive square"
  (define make-connector (solution "3.35" 'make-connector))
  (define set-value! (solution "3.35" 'set-value!))
  (define get-value (solution "3.35" 'get-value))
  (define squarer (solution "3.35" 'squarer))
  (define a (make-connector))
  (define b (make-connector))
  (squarer a b)
  (set-value! a -4 'user)
  (check-equal? (get-value b) 16))

(test-case "zero"
  (define make-connector (solution "3.35" 'make-connector))
  (define set-value! (solution "3.35" 'set-value!))
  (define get-value (solution "3.35" 'get-value))
  (define squarer (solution "3.35" 'squarer))
  (define a (make-connector))
  (define b (make-connector))
  (squarer a b)
  (set-value! b 0 'user)
  (check-equal? (get-value a) 0))

(test-case "forgetting a value retracts what was derived from it"
  (define make-connector (solution "3.35" 'make-connector))
  (define set-value! (solution "3.35" 'set-value!))
  (define get-value (solution "3.35" 'get-value))
  (define has-value? (solution "3.35" 'has-value?))
  (define forget-value! (solution "3.35" 'forget-value!))
  (define squarer (solution "3.35" 'squarer))
  (define a (make-connector))
  (define b (make-connector))
  (squarer a b)
  (set-value! a 3 'user)
  (check-equal? (get-value b) 9)
  (forget-value! a 'user)
  (check-false (has-value? b))
  (check-false (has-value? a))
  (set-value! b 16 'user)
  (check-equal? (get-value a) 4))

(test-case "squarers compose"
  (define make-connector (solution "3.35" 'make-connector))
  (define set-value! (solution "3.35" 'set-value!))
  (define get-value (solution "3.35" 'get-value))
  (define squarer (solution "3.35" 'squarer))
  (define a (make-connector))
  (define b (make-connector))
  (define c (make-connector))
  (squarer a b)
  (squarer b c)
  (set-value! a 2 'user)
  (check-equal? (get-value c) 16)
  (define a2 (make-connector))
  (define b2 (make-connector))
  (define c2 (make-connector))
  (squarer a2 b2)
  (squarer b2 c2)
  (set-value! c2 81 'user)
  (check-equal? (get-value a2) 3))

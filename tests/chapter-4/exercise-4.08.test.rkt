#lang sicp
;; Your exercises/chapter-4/exercise-4.08.rkt must (#%provide let->combination).
;; let->combination: (let->combination exp) expands ordinary let and named let; named let becomes a letrec with a lambda binding and initial call.
;; The named-let expansion relies on the evaluator supporting letrec (as derived in Exercise 4.20).
(#%require rackunit "../lib.rkt")

(test-case "named let binds a recursive procedure and invokes it with initial values"
  (define f (solution "4.08" 'let->combination))
  (check-equal? (f '(let loop ((n 5) (acc 1))
                      (if (= n 0) acc (loop (- n 1) (* acc n)))))
                '(letrec ((loop (lambda (n acc)
                                  (if (= n 0) acc (loop (- n 1) (* acc n))))))
                   (loop 5 1)))
  (check-equal? (f '(let ((x 3)) (+ x 2)))
                '((lambda (x) (+ x 2)) 3)))

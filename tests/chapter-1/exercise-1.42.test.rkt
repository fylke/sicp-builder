#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-1/exercise-1.42.rkt must (#%provide compose)
;;   (compose f g) -- the procedure x -> (f (g x))

(define (square x) (* x x))

(test-case "example from the exercise"
  (define compose (solution "1.42" 'compose))
  (check-equal? ((compose square inc) 6) 49))

(test-case "order of composition matters"
  (define compose (solution "1.42" 'compose))
  (check-equal? ((compose inc square) 6) 37)
  (check-equal? ((compose (lambda (x) (- x)) (lambda (x) (* 2 x))) 5) -10)
  (check-equal? ((compose car cdr) '(1 2 3)) 2)
  (check-equal? ((compose (lambda (x) (* x 10)) (compose inc inc)) 1) 30))

#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-1/exercise-1.43.rkt must (#%provide repeated)
;;   (repeated f n) -- the procedure that applies f n times, for a positive integer n
;; (define compose yourself if you use it)

(define (square x) (* x x))

(test-case "example from the exercise"
  (define repeated (solution "1.43" 'repeated))
  (check-equal? ((repeated square 2) 5) 625))

(test-case "various n"
  (define repeated (solution "1.43" 'repeated))
  (check-equal? ((repeated inc 1) 5) 6)
  (check-equal? ((repeated inc 10) 5) 15)
  (check-equal? ((repeated square 1) 5) 25)
  (check-equal? ((repeated square 3) 2) 256)
  (check-equal? ((repeated (lambda (x) (cons 'a x)) 3) '()) '(a a a)))

(test-case "applies f to the result of f (non-commutative)"
  (define repeated (solution "1.43" 'repeated))
  (check-equal? ((repeated (lambda (x) (- (* 2 x) 1)) 3) 5) 33)
  (check-equal? ((repeated (lambda (x) (/ 1 (+ 1 x))) 3) 1) 3/5))

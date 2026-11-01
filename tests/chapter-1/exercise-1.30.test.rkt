#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-1/exercise-1.30.rkt must (#%provide sum)
;;   (sum term a next b) -- sum of (term x) for x = a, (next a), ... while x <= b,
;;                          generating an ITERATIVE process

(define (cube x) (* x x x))

(test-case "sum of cubes"
  (define sum (solution "1.30" 'sum))
  (check-equal? (sum cube 1 inc 10) 3025))

(test-case "sum of integers"
  (define sum (solution "1.30" 'sum))
  (check-equal? (sum (lambda (x) x) 1 inc 100) 5050)
  (check-equal? (sum (lambda (x) x) 1 inc 100000) 5000050000))

(test-case "empty and single-term ranges"
  (define sum (solution "1.30" 'sum))
  (check-equal? (sum (lambda (x) x) 5 inc 4) 0)
  (check-equal? (sum (lambda (x) (* x 10)) 3 inc 3) 30))

(test-case "custom next"
  (define sum (solution "1.30" 'sum))
  (check-equal? (sum (lambda (x) x) 1 (lambda (x) (+ x 2)) 9) 25)
  (check-= (sum (lambda (x) x) 0 (lambda (x) (+ x 0.5)) 2) 5.0 1e-9))

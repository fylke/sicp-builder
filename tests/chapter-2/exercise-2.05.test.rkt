#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.05.rkt must (#%provide cons car cdr)
;;   (cons a b) -- the integer 2^a * 3^b (a, b nonnegative integers)
;;   (car z)    -- recovers a
;;   (cdr z)    -- recovers b
;; All three are your own definitions (shadowing the built-ins in your file).

(test-case "pair is represented as 2^a 3^b"
  (define my-cons (solution "2.05" 'cons))
  (check-equal? (my-cons 0 0) 1)
  (check-equal? (my-cons 1 0) 2)
  (check-equal? (my-cons 0 1) 3)
  (check-equal? (my-cons 3 4) 648))

(test-case "car recovers the first component"
  (define my-cons (solution "2.05" 'cons))
  (define my-car (solution "2.05" 'car))
  (check-equal? (my-car (my-cons 0 0)) 0)
  (check-equal? (my-car (my-cons 5 0)) 5)
  (check-equal? (my-car (my-cons 0 7)) 0)
  (check-equal? (my-car (my-cons 3 4)) 3)
  (check-equal? (my-car (my-cons 10 6)) 10))

(test-case "cdr recovers the second component"
  (define my-cons (solution "2.05" 'cons))
  (define my-cdr (solution "2.05" 'cdr))
  (check-equal? (my-cdr (my-cons 0 0)) 0)
  (check-equal? (my-cdr (my-cons 5 0)) 0)
  (check-equal? (my-cdr (my-cons 0 7)) 7)
  (check-equal? (my-cdr (my-cons 3 4)) 4)
  (check-equal? (my-cdr (my-cons 6 10)) 10))

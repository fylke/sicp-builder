#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.04.rkt must (#%provide cons car cdr)
;;   (cons x y) -- a pair built only from procedures (no real pairs!)
;;   (car z)    -- first component of z
;;   (cdr z)    -- second component of z
;; All three are your own definitions (shadowing the built-ins in your file).

(test-case "car of cons"
  (define my-cons (solution "2.04" 'cons))
  (define my-car (solution "2.04" 'car))
  (check-equal? (my-car (my-cons 1 2)) 1)
  (check-equal? (my-car (my-cons 'a 'b)) 'a)
  (check-equal? (my-car (my-cons '(1 2) 3)) '(1 2)))

(test-case "cdr of cons"
  (define my-cons (solution "2.04" 'cons))
  (define my-cdr (solution "2.04" 'cdr))
  (check-equal? (my-cdr (my-cons 1 2)) 2)
  (check-equal? (my-cdr (my-cons 'a 'b)) 'b)
  (check-equal? (my-cdr (my-cons 1 '(2 3))) '(2 3)))

(test-case "nested pairs"
  (define my-cons (solution "2.04" 'cons))
  (define my-car (solution "2.04" 'car))
  (define my-cdr (solution "2.04" 'cdr))
  (define z (my-cons (my-cons 1 2) (my-cons 3 4)))
  (check-equal? (my-car (my-car z)) 1)
  (check-equal? (my-cdr (my-car z)) 2)
  (check-equal? (my-car (my-cdr z)) 3)
  (check-equal? (my-cdr (my-cdr z)) 4))

(test-case "pairs are procedures"
  (define my-cons (solution "2.04" 'cons))
  (check-true (procedure? (my-cons 1 2))))

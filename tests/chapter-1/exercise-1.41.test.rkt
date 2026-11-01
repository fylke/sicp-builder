#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-1/exercise-1.41.rkt must (#%provide double)
;;   (double f) -- the procedure that applies the one-argument procedure f twice

(test-case "double applies a procedure twice"
  (define double (solution "1.41" 'double))
  (check-equal? ((double inc) 5) 7)
  (check-equal? ((double (lambda (x) (* x x))) 3) 81)
  (check-equal? ((double (lambda (x) (cons 'a x))) '()) '(a a)))

(test-case "(((double (double double)) inc) 5)"
  (define double (solution "1.41" 'double))
  (check-equal? (((double (double double)) inc) 5) 21)
  (check-equal? (((double double) inc) 0) 4)
  (check-equal? ((((double double) double) inc) 0) 16))

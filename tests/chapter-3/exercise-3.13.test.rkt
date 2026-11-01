#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.13.rkt must (#%provide make-cycle)
;;   (make-cycle x) -> destructively turns the non-empty list x into a cycle (the last
;;                     pair's cdr points back to x) and returns x
; Equality checks are wrapped in check-true so a wrong answer never prints a cyclic value.
;; (Define last-pair in your file too, as in Exercise 3.12; it need not be provided.)

(test-case "make-cycle returns the same list"
  (define make-cycle (solution "3.13" 'make-cycle))
  (define l (list 'a 'b 'c))
  (check-true (eq? (make-cycle l) l)))

(test-case "the last pair points back to the first"
  (define make-cycle (solution "3.13" 'make-cycle))
  (define z (make-cycle (list 'a 'b 'c)))
  (check-true (eq? (cdr (cdr (cdr z))) z))
  (check-eq? (car (cdr (cdr (cdr z)))) 'a))

(test-case "elements are unchanged and the cycle repeats them"
  (define make-cycle (solution "3.13" 'make-cycle))
  (define z (make-cycle (list 'a 'b 'c)))
  (check-equal? (list (car z) (cadr z) (caddr z) (car (cdddr z)) (cadr (cdddr z)))
                '(a b c a b)))

(test-case "a one-element list points to itself"
  (define make-cycle (solution "3.13" 'make-cycle))
  (define z (make-cycle (list 'x)))
  (check-true (eq? (cdr z) z)))

#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.57.rkt must (#%provide deriv)
;;   (deriv exp var) -- the book's differentiator, working on sums and products of any
;;                      number (two or more) of terms, e.g. (deriv '(* x y (+ x 3)) 'x)
;; You must define the whole differentiator yourself (variable?, same-variable?, sum?,
;; make-sum, addend, augend, product?, make-product, multiplier, multiplicand, deriv).
;; The tests evaluate the results numerically, so any correct form is accepted.

(define (lookup var env)
  (cdr (assq var env)))

(define (evaluate e env)
  (define (ev-all es op init)
    (if (null? es) init (op (evaluate (car es) env) (ev-all (cdr es) op init))))
  (cond ((number? e) e)
        ((symbol? e) (lookup e env))
        ((eq? (car e) '+) (ev-all (cdr e) + 0))
        ((eq? (car e) '*) (ev-all (cdr e) * 1))
        (else (error "bad expression" e))))

(define env '((x . 2) (y . 3)))

(test-case "book example (* x y (+ x 3))"
  (define deriv (solution "2.57" 'deriv))
  (check-= (evaluate (deriv '(* x y (+ x 3)) 'x) env) 21 1e-9)
  (check-= (evaluate (deriv '(* x y (+ x 3)) 'y) env) 10 1e-9))

(test-case "sums of three or more terms"
  (define deriv (solution "2.57" 'deriv))
  (check-= (evaluate (deriv '(+ x 3 y) 'x) env) 1 1e-9)
  (check-= (evaluate (deriv '(+ x (* x x) 5) 'x) env) 5 1e-9)
  (check-= (evaluate (deriv '(+ x y 3 (* 2 x) y) 'y) env) 2 1e-9)
  (check-= (evaluate (deriv '(+ 1 2 3 4) 'x) env) 0 1e-9))

(test-case "products of three or more terms"
  (define deriv (solution "2.57" 'deriv))
  (check-= (evaluate (deriv '(* x x x) 'x) '((x . 3))) 27 1e-9)
  (check-= (evaluate (deriv '(* 2 x 3) 'x) env) 6 1e-9)
  (check-= (evaluate (deriv '(* x y x y) 'x) env) 36 1e-9)
  (check-= (evaluate (deriv '(* 2 3 4) 'x) env) 0 1e-9))

(test-case "two-term expressions still work"
  (define deriv (solution "2.57" 'deriv))
  (check-equal? (deriv '(+ x 3) 'x) 1)
  (check-= (evaluate (deriv '(* x y) 'x) env) 3 1e-9)
  (check-= (evaluate (deriv '(* (* x y) (+ x 3)) 'x) env) 21 1e-9)
  (check-equal? (deriv 'y 'x) 0)
  (check-equal? (deriv 5 'x) 0))

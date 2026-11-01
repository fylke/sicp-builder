#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.56.rkt must (#%provide deriv exponentiation? base
;;                                                  exponent make-exponentiation)
;;   (deriv exp var)              -- the book's symbolic differentiator, extended with the rule
;;                                   for exponentiation (**)
;;   (exponentiation? e)          -- is e of the form (** u n)?
;;   (base e) (exponent e)        -- u and n of (** u n)
;;   (make-exponentiation u n)    -- the expression (** u n); n = 0 gives 1, n = 1 gives u
;; You must also define the rest of the book's differentiator yourself (variable?,
;; same-variable?, sum?, make-sum, product?, make-product, ... with the usual
;; simplifications for 0 and 1 and for numbers).

(define (lookup var env)
  (cdr (assq var env)))

(define (evaluate e env)
  (cond ((number? e) e)
        ((symbol? e) (lookup e env))
        ((eq? (car e) '+) (+ (evaluate (cadr e) env) (evaluate (caddr e) env)))
        ((eq? (car e) '*) (* (evaluate (cadr e) env) (evaluate (caddr e) env)))
        ((eq? (car e) '**) (expt (evaluate (cadr e) env) (evaluate (caddr e) env)))
        (else (error "bad expression" e))))

(define env '((x . 2) (y . 7)))

(test-case "exponentiation? / base / exponent"
  (define exponentiation? (solution "2.56" 'exponentiation?))
  (define base (solution "2.56" 'base))
  (define exponent (solution "2.56" 'exponent))
  (check-true (exponentiation? '(** x 2)))
  (check-false (exponentiation? '(* x 2)))
  (check-false (exponentiation? '(+ x 2)))
  (check-false (exponentiation? 'x))
  (check-false (exponentiation? 5))
  (check-equal? (base '(** x 2)) 'x)
  (check-equal? (exponent '(** x 2)) 2)
  (check-equal? (base '(** (+ x 1) 3)) '(+ x 1))
  (check-equal? (exponent '(** (+ x 1) 3)) 3))

(test-case "make-exponentiation"
  (define make-exponentiation (solution "2.56" 'make-exponentiation))
  (check-equal? (make-exponentiation 'x 2) '(** x 2))
  (check-equal? (make-exponentiation 'x 0) 1)
  (check-equal? (make-exponentiation 5 0) 1)
  (check-equal? (make-exponentiation 'x 1) 'x)
  (check-equal? (make-exponentiation '(+ x 1) 1) '(+ x 1))
  (check-equal? (make-exponentiation '(+ x 1) 3) '(** (+ x 1) 3)))

(test-case "deriv of powers (numeric check)"
  (define deriv (solution "2.56" 'deriv))
  (check-= (evaluate (deriv '(** x 3) 'x) env) 12 1e-9)
  (check-= (evaluate (deriv '(** x 2) 'x) env) 4 1e-9)
  (check-= (evaluate (deriv '(** x 5) 'x) '((x . 1))) 5 1e-9)
  (check-= (evaluate (deriv '(** y 3) 'x) env) 0 1e-9))

(test-case "deriv of powers: chain rule and combinations"
  (define deriv (solution "2.56" 'deriv))
  (check-= (evaluate (deriv '(** (+ x 1) 3) 'x) '((x . 1))) 12 1e-9)
  (check-= (evaluate (deriv '(** (* 2 x) 2) 'x) env) 16 1e-9)
  (check-= (evaluate (deriv '(* y (** x 2)) 'x) env) 28 1e-9)
  (check-= (evaluate (deriv '(+ (** x 3) (** x 2)) 'x) env) 16 1e-9))

(test-case "deriv of powers 0 and 1"
  (define deriv (solution "2.56" 'deriv))
  (check-= (evaluate (deriv '(** x 1) 'x) env) 1 1e-9)
  (check-= (evaluate (deriv '(** x 0) 'x) env) 0 1e-9))

(test-case "the old rules still work"
  (define deriv (solution "2.56" 'deriv))
  (check-equal? (deriv '(+ x 3) 'x) 1)
  (check-= (evaluate (deriv '(* x y) 'x) env) 7 1e-9)
  (check-= (evaluate (deriv '(* (* x y) (+ x 3)) 'x) env) 49 1e-9)
  (check-equal? (deriv 5 'x) 0)
  (check-equal? (deriv 'y 'x) 0)
  (check-equal? (deriv 'x 'x) 1))

(test-case "simplified forms (as with the book's make-sum and make-product)"
  (define deriv (solution "2.56" 'deriv))
  (check-equal? (deriv '(** x 3) 'x) '(* 3 (** x 2)))
  (check-equal? (deriv '(** x 2) 'x) '(* 2 x))
  (check-equal? (deriv '(** x 1) 'x) 1)
  (check-equal? (deriv '(** x 0) 'x) 0))

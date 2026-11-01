#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.73.rkt must (#%provide deriv)
;;   (deriv exp var) -- the derivative of the expression exp (numbers, variables, (+ a b),
;;                      (* a b), written in prefix form with two operands) with respect to var,
;;                      using the data-directed dispatch of the exercise
;; The language has no put/get, so define your own operation table (put and get) in your file,
;; plus variable?, same-variable?, make-sum, make-product, operator, operands, and install
;; the sum and product rules (part b) at module level of your file.
;; The tests evaluate the result numerically, so unsimplified results are accepted.

(define (lookup-var name env)
  (cond ((null? env) (error "unbound variable" name))
        ((eq? (car (car env)) name) (cdr (car env)))
        (else (lookup-var name (cdr env)))))

(define (evaluate exp env)
  (cond ((number? exp) exp)
        ((symbol? exp) (lookup-var exp env))
        ((eq? (car exp) '+) (apply + (map (lambda (e) (evaluate e env)) (cdr exp))))
        ((eq? (car exp) '*) (apply * (map (lambda (e) (evaluate e env)) (cdr exp))))
        (else (error "bad expression" exp))))

(define (check-deriv exp var env expected)
  (define deriv (solution "2.73" 'deriv))
  (check-equal? (evaluate (deriv exp var) env) expected))

(test-case "derivative of constants and variables"
  (define deriv (solution "2.73" 'deriv))
  (check-equal? (deriv 5 'x) 0)
  (check-equal? (deriv 'x 'x) 1)
  (check-equal? (deriv 'y 'x) 0))

(test-case "derivative of a sum"
  (check-deriv '(+ x 3) 'x '((x . 4)) 1)
  (check-deriv '(+ x x) 'x '((x . 4)) 2)
  (check-deriv '(+ y 3) 'x '((x . 4) (y . 5)) 0))

(test-case "derivative of a product"
  (check-deriv '(* x y) 'x '((x . 4) (y . 5)) 5)
  (check-deriv '(* x y) 'y '((x . 4) (y . 5)) 4)
  (check-deriv '(* x x) 'x '((x . 4)) 8)
  (check-deriv '(* 3 x) 'x '((x . 4)) 3))

(test-case "nested expressions"
  (check-deriv '(+ (* x x) (* 3 x)) 'x '((x . 4)) 11)
  (check-deriv '(* (* x y) (+ x 3)) 'x '((x . 2) (y . 7)) 49)
  (check-deriv '(* (* x y) (+ x 3)) 'y '((x . 2) (y . 7)) 10)
  (check-deriv '(+ (* (* x x) x) 1) 'x '((x . 3)) 27))

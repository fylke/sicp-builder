#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.58.rkt must (#%provide deriv deriv-b)
;;   (deriv exp var)   -- part (a): the differentiator for fully parenthesized infix
;;                        expressions with two-argument + and *, e.g. (x + (3 * (x + (y + 2))))
;;   (deriv-b exp var) -- part (b): the differentiator for standard infix notation with
;;                        dropped parentheses and * binding tighter than +,
;;                        e.g. (x + 3 * (x + y + 2))
;; You must define the supporting representation procedures yourself. Expressions use only
;; numbers, symbols, + and *. The tests evaluate the results numerically, so any correct form
;; is accepted.

(define (lookup var env)
  (cdr (assq var env)))

(define (before op items)
  (if (eq? (car items) op)
      '()
      (cons (car items) (before op (cdr items)))))
(define (after op items)
  (cdr (memq op items)))

;; Evaluates fully parenthesized or standard infix expressions
(define (evaluate e env)
  (cond ((number? e) e)
        ((symbol? e) (lookup e env))
        ((null? (cdr e)) (evaluate (car e) env))
        ((memq '+ e) (+ (evaluate (before '+ e) env) (evaluate (after '+ e) env)))
        ((memq '* e) (* (evaluate (before '* e) env) (evaluate (after '* e) env)))
        (else (error "bad expression" e))))

(define env '((x . 2) (y . 3)))

(test-case "(a) sums and products"
  (define deriv (solution "2.58" 'deriv))
  (check-equal? (deriv '(x + 3) 'x) 1)
  (check-= (evaluate (deriv '(x * y) 'x) env) 3 1e-9)
  (check-= (evaluate (deriv '(x * y) 'y) env) 2 1e-9)
  (check-equal? (deriv '(y + 3) 'x) 0)
  (check-equal? (deriv 5 'x) 0)
  (check-equal? (deriv 'x 'x) 1))

(test-case "(a) book example (x + (3 * (x + (y + 2))))"
  (define deriv (solution "2.58" 'deriv))
  (check-= (evaluate (deriv '(x + (3 * (x + (y + 2)))) 'x) env) 4 1e-9)
  (check-= (evaluate (deriv '(x + (3 * (x + (y + 2)))) 'y) env) 3 1e-9))

(test-case "(a) nested products"
  (define deriv (solution "2.58" 'deriv))
  (check-= (evaluate (deriv '((x * x) + (3 * x)) 'x) env) 7 1e-9)
  (check-= (evaluate (deriv '(x * (x * x)) 'x) env) 12 1e-9)
  (check-= (evaluate (deriv '((x * y) * (x + 3)) 'x) env) 21 1e-9))

(test-case "(b) sums and products without extra parentheses"
  (define deriv-b (solution "2.58" 'deriv-b))
  (check-equal? (deriv-b '(x + 3) 'x) 1)
  (check-= (evaluate (deriv-b '(x * y) 'x) env) 3 1e-9)
  (check-= (evaluate (deriv-b '(x + 3 + y) 'x) env) 1 1e-9)
  (check-= (evaluate (deriv-b '(x * y * 4) 'x) env) 12 1e-9)
  (check-= (evaluate (deriv-b '(3 + 4) 'x) env) 0 1e-9))

(test-case "(b) multiplication binds tighter than addition"
  (define deriv-b (solution "2.58" 'deriv-b))
  (check-= (evaluate (deriv-b '(x + 3 * (x + y + 2)) 'x) env) 4 1e-9)
  (check-= (evaluate (deriv-b '(x + x * x) 'x) env) 5 1e-9)
  (check-= (evaluate (deriv-b '(2 * x + 3 * x * x) 'x) env) 14 1e-9)
  (check-= (evaluate (deriv-b '(x * 2 + 1) 'x) env) 2 1e-9)
  (check-= (evaluate (deriv-b '(1 + x * y + 2) 'y) env) 2 1e-9))

(test-case "(b) products of sums and of several factors"
  (define deriv-b (solution "2.58" 'deriv-b))
  (check-= (evaluate (deriv-b '(x * y * (x + 3)) 'x) env) 21 1e-9)
  (check-= (evaluate (deriv-b '(x * x * x) 'x) env) 12 1e-9)
  (check-= (evaluate (deriv-b '((x + 1) * (x + 2)) 'x) env) 7 1e-9))

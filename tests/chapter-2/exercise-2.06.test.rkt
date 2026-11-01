#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.06.rkt must (#%provide zero add-1 one two plus)
;;   zero        -- the Church numeral 0 (given in the book)
;;   (add-1 n)   -- the Church numeral n+1 (given in the book)
;;   one, two    -- the Church numerals 1 and 2, defined directly (not via add-1)
;;   (plus a b)  -- the sum of Church numerals a and b, defined directly
;;                  (the exercise calls it +; it is named `plus` here so it
;;                  does not clash with the built-in +)

(define (church->int n)
  ((n (lambda (x) (+ x 1))) 0))

(test-case "zero and add-1"
  (define zero (solution "2.06" 'zero))
  (define add-1 (solution "2.06" 'add-1))
  (check-equal? (church->int zero) 0)
  (check-equal? (church->int (add-1 zero)) 1)
  (check-equal? (church->int (add-1 (add-1 (add-1 zero)))) 3))

(test-case "one and two"
  (define one (solution "2.06" 'one))
  (define two (solution "2.06" 'two))
  (check-equal? (church->int one) 1)
  (check-equal? (church->int two) 2)
  (check-equal? ((one (lambda (x) (cons 'f x))) 'x) '(f . x))
  (check-equal? ((two (lambda (x) (cons 'f x))) 'x) '(f f . x)))

(test-case "one and two behave like add-1 applied to zero"
  (define zero (solution "2.06" 'zero))
  (define add-1 (solution "2.06" 'add-1))
  (define one (solution "2.06" 'one))
  (define two (solution "2.06" 'two))
  (check-equal? (church->int (add-1 one)) 2)
  (check-equal? (church->int (add-1 two)) 3)
  (check-equal? (church->int (add-1 (add-1 zero))) (church->int two)))

(test-case "plus"
  (define zero (solution "2.06" 'zero))
  (define add-1 (solution "2.06" 'add-1))
  (define one (solution "2.06" 'one))
  (define two (solution "2.06" 'two))
  (define plus (solution "2.06" 'plus))
  (define three (add-1 two))
  (check-equal? (church->int (plus zero zero)) 0)
  (check-equal? (church->int (plus zero two)) 2)
  (check-equal? (church->int (plus two zero)) 2)
  (check-equal? (church->int (plus one two)) 3)
  (check-equal? (church->int (plus two three)) 5)
  (check-equal? (church->int (plus three three)) 6)
  (check-equal? (church->int (plus (plus one two) (plus two three))) 8))

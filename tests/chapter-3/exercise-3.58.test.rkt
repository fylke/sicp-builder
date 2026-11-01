#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.58.rkt must (#%provide expand)
;;   (expand num den radix) -> the book's stream of digits of num/den in the given radix:
;;       its first element is (quotient (* num radix) den) and the rest is
;;       (expand (remainder (* num radix) den) den radix)
;; (Type the procedure in as given, with cons-stream.)

(define (head s n)
  (if (or (= n 0) (null? s))
      '()
      (cons (car s) (head (force (cdr s)) (- n 1)))))

(test-case "(expand 1 7 10) is the decimal expansion of 1/7"
  (define expand (solution "3.58" 'expand))
  (check-equal? (head (expand 1 7 10) 12) '(1 4 2 8 5 7 1 4 2 8 5 7)))

(test-case "(expand 3 8 10) is 3/8 = .375 followed by zeros"
  (define expand (solution "3.58" 'expand))
  (check-equal? (head (expand 3 8 10) 8) '(3 7 5 0 0 0 0 0)))

(test-case "other radixes"
  (define expand (solution "3.58" 'expand))
  (check-equal? (head (expand 1 3 2) 6) '(0 1 0 1 0 1))
  (check-equal? (head (expand 1 2 2) 4) '(1 0 0 0))
  (check-equal? (head (expand 1 3 10) 4) '(3 3 3 3)))

(test-case "a fraction with a long period"
  (define expand (solution "3.58" 'expand))
  (check-equal? (head (expand 1 13 10) 12) '(0 7 6 9 2 3 0 7 6 9 2 3)))

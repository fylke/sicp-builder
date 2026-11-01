#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.25.rkt must (#%provide seven-a seven-b seven-c)
;;   (seven-a l) -- picks 7 out of a list shaped like (1 3 (5 7) 9)
;;   (seven-b l) -- picks 7 out of a list shaped like ((7))
;;   (seven-c l) -- picks 7 out of a list shaped like (1 (2 (3 (4 (5 (6 7))))))
;; Each is a procedure of one argument built only from car and cdr (combinations of them).

(test-case "(1 3 (5 7) 9)"
  (define seven-a (solution "2.25" 'seven-a))
  (check-equal? (seven-a '(1 3 (5 7) 9)) 7)
  (check-equal? (seven-a '(a b (c x) d)) 'x))

(test-case "((7))"
  (define seven-b (solution "2.25" 'seven-b))
  (check-equal? (seven-b '((7))) 7)
  (check-equal? (seven-b '((x))) 'x))

(test-case "(1 (2 (3 (4 (5 (6 7))))))"
  (define seven-c (solution "2.25" 'seven-c))
  (check-equal? (seven-c '(1 (2 (3 (4 (5 (6 7))))))) 7)
  (check-equal? (seven-c '(a (b (c (d (e (f x))))))) 'x))

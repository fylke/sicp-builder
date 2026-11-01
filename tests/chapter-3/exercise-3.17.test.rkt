#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.17.rkt must (#%provide count-pairs)
;;   (count-pairs x) -> the number of distinct pairs in the structure x
;;                      (must terminate on structures containing cycles)

(test-case "non-pairs have no pairs"
  (define count-pairs (solution "3.17" 'count-pairs))
  (check-equal? (count-pairs '()) 0)
  (check-equal? (count-pairs 'a) 0)
  (check-equal? (count-pairs 42) 0))

(test-case "an ordinary list"
  (define count-pairs (solution "3.17" 'count-pairs))
  (check-equal? (count-pairs (list 'a 'b 'c)) 3)
  (check-equal? (count-pairs (list 1 2 3 4 5 6 7)) 7))

(test-case "nested lists"
  (define count-pairs (solution "3.17" 'count-pairs))
  (check-equal? (count-pairs (list (list 1 2) (list 3 4))) 6))

(test-case "shared pairs are counted once (Ben would say 4)"
  (define count-pairs (solution "3.17" 'count-pairs))
  (define c (cons 'x '()))
  (define b (cons c '()))
  (check-equal? (count-pairs (cons b c)) 3))

(test-case "heavily shared structure (Ben would say 7)"
  (define count-pairs (solution "3.17" 'count-pairs))
  (define p3 (cons 'a 'b))
  (define p2 (cons p3 p3))
  (check-equal? (count-pairs (cons p2 p2)) 3))

(test-case "a cyclic list"
  (define count-pairs (solution "3.17" 'count-pairs))
  (define x (list 'a 'b 'c))
  (set-cdr! (cddr x) x)
  (check-equal? (count-pairs x) 3))

(test-case "a cycle that does not include the head"
  (define count-pairs (solution "3.17" 'count-pairs))
  (define x (list 'a 'b 'c 'd))
  (set-cdr! (cdddr x) (cdr x))
  (check-equal? (count-pairs x) 4))

(test-case "a cycle through a car"
  (define count-pairs (solution "3.17" 'count-pairs))
  (define x (list 'a 'b))
  (set-car! x x)
  (check-equal? (count-pairs x) 2))

(test-case "the same structure appearing twice in a list"
  (define count-pairs (solution "3.17" 'count-pairs))
  (define s (list 1 2))
  (check-equal? (count-pairs (list s s)) 4))

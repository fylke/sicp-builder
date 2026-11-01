#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.18.rkt must (#%provide cycle?)
;;   (cycle? x) -> #t if taking successive cdrs of x would never reach the end of the
;;                 list (x contains a cycle), #f otherwise

(define (long-list n)
  (define (build i acc) (if (= i 0) acc (build (- i 1) (cons i acc))))
  (build n '()))

(define (nth-pair l k)
  (if (= k 0) l (nth-pair (cdr l) (- k 1))))

(test-case "ordinary lists have no cycle"
  (define cycle? (solution "3.18" 'cycle?))
  (check-false (cycle? '()))
  (check-false (cycle? (list 'a)))
  (check-false (cycle? (list 'a 'b 'c))))

(test-case "a cycle through the whole list"
  (define cycle? (solution "3.18" 'cycle?))
  (define z (list 'a 'b 'c))
  (set-cdr! (cddr z) z)
  (check-true (cycle? z)))

(test-case "a one-pair cycle"
  (define cycle? (solution "3.18" 'cycle?))
  (define z (list 'a))
  (set-cdr! z z)
  (check-true (cycle? z)))

(test-case "a cycle that does not include the first pair"
  (define cycle? (solution "3.18" 'cycle?))
  (define z (list 1 2 3 4 5))
  (set-cdr! (nth-pair z 4) (nth-pair z 2))
  (check-true (cycle? z)))

(test-case "shared but acyclic structure is not a cycle"
  (define cycle? (solution "3.18" 'cycle?))
  (define shared (list 1 2))
  (check-false (cycle? (list shared shared)))
  (define tail (list 'x 'y))
  (check-false (cycle? (cons 'a tail)))
  (check-false (cycle? (list (cons 1 2) (cons 3 4)))))

(test-case "only cdr cycles count"
  (define cycle? (solution "3.18" 'cycle?))
  (define z (list 'a 'b))
  (set-car! z z)
  (check-false (cycle? z)))

(test-case "a longer acyclic list and a longer cyclic one"
  (define cycle? (solution "3.18" 'cycle?))
  (define l (long-list 3000))
  (check-false (cycle? l))
  (set-cdr! (nth-pair l 2999) (nth-pair l 2))
  (check-true (cycle? l)))

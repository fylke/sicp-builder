#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.19.rkt must (#%provide cycle?)
;;   (cycle? x) -> #t if taking successive cdrs of x would never reach the end of the
;;                 list (x contains a cycle), #f otherwise. Use constant extra space.
;; (The space bound cannot be checked here, but the lists below are large enough that a
;; quadratic seen-list approach will be slow.)

(define (long-list n)
  (define (build i acc) (if (= i 0) acc (build (- i 1) (cons i acc))))
  (build n '()))

(define (nth-pair l k)
  (if (= k 0) l (nth-pair (cdr l) (- k 1))))

(test-case "ordinary lists have no cycle"
  (define cycle? (solution "3.19" 'cycle?))
  (check-false (cycle? '()))
  (check-false (cycle? (list 'a)))
  (check-false (cycle? (list 'a 'b 'c)))
  (check-false (cycle? (list 'a 'b))))

(test-case "a cycle through the whole list"
  (define cycle? (solution "3.19" 'cycle?))
  (define z (list 'a 'b 'c))
  (set-cdr! (cddr z) z)
  (check-true (cycle? z)))

(test-case "cycles of length one and two"
  (define cycle? (solution "3.19" 'cycle?))
  (define z (list 'a))
  (set-cdr! z z)
  (check-true (cycle? z))
  (define y (list 'a 'b))
  (set-cdr! (cdr y) y)
  (check-true (cycle? y)))

(test-case "a cycle that does not include the first pair"
  (define cycle? (solution "3.19" 'cycle?))
  (define z (list 1 2 3 4 5))
  (set-cdr! (nth-pair z 4) (nth-pair z 2))
  (check-true (cycle? z)))

(test-case "shared but acyclic structure is not a cycle"
  (define cycle? (solution "3.19" 'cycle?))
  (define shared (list 1 2))
  (check-false (cycle? (list shared shared)))
  (check-false (cycle? (list (cons 1 2) (cons 3 4)))))

(test-case "only cdr cycles count"
  (define cycle? (solution "3.19" 'cycle?))
  (define z (list 'a 'b))
  (set-car! z z)
  (check-false (cycle? z)))

(test-case "large acyclic and cyclic lists"
  (define cycle? (solution "3.19" 'cycle?))
  (define l (long-list 20000))
  (check-false (cycle? l))
  (set-cdr! (nth-pair l 19999) (nth-pair l 7))
  (check-true (cycle? l)))

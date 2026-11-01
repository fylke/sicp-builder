#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.24.rkt must (#%provide make-table)
;;   (make-table same-key?) -> a two-dimensional table (as in section 3.3.3) whose keys are
;;       compared with (same-key? a b) instead of equal?. It is a dispatch procedure:
;;       ((table 'lookup-proc) key-1 key-2)        -> the value, or #f if there is none
;;       ((table 'insert-proc!) key-1 key-2 value) -> stores value (replacing a match)

(define (approx tolerance)
  (lambda (a b) (< (abs (- a b)) tolerance)))

(test-case "exact keys behave like an ordinary table"
  (define make-table (solution "3.24" 'make-table))
  (define t (make-table equal?))
  ((t 'insert-proc!) 'a 'b 1)
  ((t 'insert-proc!) 'a 'c 2)
  ((t 'insert-proc!) 'd 'b 3)
  (check-equal? ((t 'lookup-proc) 'a 'b) 1)
  (check-equal? ((t 'lookup-proc) 'a 'c) 2)
  (check-equal? ((t 'lookup-proc) 'd 'b) 3))

(test-case "missing keys give #f"
  (define make-table (solution "3.24" 'make-table))
  (define t (make-table equal?))
  (check-false ((t 'lookup-proc) 'a 'b))
  ((t 'insert-proc!) 'a 'b 1)
  (check-false ((t 'lookup-proc) 'a 'z))
  (check-false ((t 'lookup-proc) 'z 'b))
  (check-false ((t 'lookup-proc) 'b 'a)))

(test-case "same-key? decides which keys match on lookup"
  (define make-table (solution "3.24" 'make-table))
  (define t (make-table (approx 0.5)))
  ((t 'insert-proc!) 1.0 10.0 'x)
  (check-equal? ((t 'lookup-proc) 1.2 10.3) 'x)
  (check-equal? ((t 'lookup-proc) 0.8 9.8) 'x)
  (check-false ((t 'lookup-proc) 1.6 10.0))
  (check-false ((t 'lookup-proc) 1.0 11.0)))

(test-case "inserting under a matching key replaces the value"
  (define make-table (solution "3.24" 'make-table))
  (define t (make-table (approx 0.5)))
  ((t 'insert-proc!) 1.0 1.0 'old)
  ((t 'insert-proc!) 1.2 0.9 'new)
  (check-equal? ((t 'lookup-proc) 1.0 1.0) 'new)
  ((t 'insert-proc!) 5.0 5.0 'far)
  (check-equal? ((t 'lookup-proc) 1.0 1.0) 'new)
  (check-equal? ((t 'lookup-proc) 5.0 5.0) 'far))

(test-case "a same-key? comparing last digits"
  (define make-table (solution "3.24" 'make-table))
  (define t (make-table (lambda (a b) (= (remainder a 10) (remainder b 10)))))
  ((t 'insert-proc!) 12 34 'v)
  (check-equal? ((t 'lookup-proc) 22 4) 'v)
  (check-false ((t 'lookup-proc) 23 4)))

(test-case "tables are independent"
  (define make-table (solution "3.24" 'make-table))
  (define t1 (make-table equal?))
  (define t2 (make-table equal?))
  ((t1 'insert-proc!) 'a 'b 1)
  (check-false ((t2 'lookup-proc) 'a 'b)))

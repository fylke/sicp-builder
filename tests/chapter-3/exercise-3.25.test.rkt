#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.25.rkt must (#%provide make-table lookup insert!)
;;   (make-table)                   -> a new empty table
;;   (insert! keys value table)     -> stores value under the list of keys (any length >= 1)
;;   (lookup keys table)            -> the value stored under exactly that list of keys,
;;                                     or #f if there is none
;; Values stored under different numbers of keys must coexist, including a value under
;; (a) alongside values under (a b) and (a b c).

(test-case "one-key and two-key entries"
  (define make-table (solution "3.25" 'make-table))
  (define lookup (solution "3.25" 'lookup))
  (define insert! (solution "3.25" 'insert!))
  (define t (make-table))
  (insert! '(a) 1 t)
  (insert! '(b c) 2 t)
  (check-equal? (lookup '(a) t) 1)
  (check-equal? (lookup '(b c) t) 2))

(test-case "missing entries are #f"
  (define make-table (solution "3.25" 'make-table))
  (define lookup (solution "3.25" 'lookup))
  (define insert! (solution "3.25" 'insert!))
  (define t (make-table))
  (check-false (lookup '(a) t))
  (insert! '(a b) 1 t)
  (check-false (lookup '(a) t))
  (check-false (lookup '(b) t))
  (check-false (lookup '(a b c) t))
  (check-false (lookup '(a c) t)))

(test-case "different numbers of keys coexist under a common prefix"
  (define make-table (solution "3.25" 'make-table))
  (define lookup (solution "3.25" 'lookup))
  (define insert! (solution "3.25" 'insert!))
  (define t (make-table))
  (insert! '(a) 'one t)
  (insert! '(a b) 'two t)
  (insert! '(a b c) 'three t)
  (check-equal? (lookup '(a) t) 'one)
  (check-equal? (lookup '(a b) t) 'two)
  (check-equal? (lookup '(a b c) t) 'three))

(test-case "inserting again replaces the value"
  (define make-table (solution "3.25" 'make-table))
  (define lookup (solution "3.25" 'lookup))
  (define insert! (solution "3.25" 'insert!))
  (define t (make-table))
  (insert! '(x y) 1 t)
  (insert! '(x y) 2 t)
  (check-equal? (lookup '(x y) t) 2)
  (insert! '(x) 3 t)
  (check-equal? (lookup '(x y) t) 2)
  (check-equal? (lookup '(x) t) 3))

(test-case "deep keys and numeric keys"
  (define make-table (solution "3.25" 'make-table))
  (define lookup (solution "3.25" 'lookup))
  (define insert! (solution "3.25" 'insert!))
  (define t (make-table))
  (insert! '(1 2 3 4 5) 'deep t)
  (insert! '(1 2 3) 'shallow t)
  (check-equal? (lookup '(1 2 3 4 5) t) 'deep)
  (check-equal? (lookup '(1 2 3) t) 'shallow)
  (check-false (lookup '(1 2 3 4) t)))

(test-case "tables are independent"
  (define make-table (solution "3.25" 'make-table))
  (define lookup (solution "3.25" 'lookup))
  (define insert! (solution "3.25" 'insert!))
  (define t1 (make-table))
  (define t2 (make-table))
  (insert! '(a b) 1 t1)
  (check-false (lookup '(a b) t2)))

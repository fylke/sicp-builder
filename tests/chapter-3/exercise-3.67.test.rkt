#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.67.rkt must (#%provide pairs)
;;   (pairs s t) -> stream of ALL pairs (list (s_i) (t_j)), including those with i > j
;; Define interleave, stream-map etc. yourself in the file.

(define (head s n)
  (if (or (= n 0) (null? s))
      '()
      (cons (car s) (head (force (cdr s)) (- n 1)))))

(define (ints n) (cons-stream n (ints (+ n 1))))

(define (from-list l)
  (if (null? l)
      '()
      (cons-stream (car l) (from-list (cdr l)))))

(define (member? x l)
  (cond ((null? l) false)
        ((equal? x (car l)) true)
        (else (member? x (cdr l)))))

(define (no-duplicates? l)
  (cond ((null? l) true)
        ((member? (car l) (cdr l)) false)
        (else (no-duplicates? (cdr l)))))

(define (all-present? needed l)
  (cond ((null? needed) true)
        ((member? (car needed) l) (all-present? (cdr needed) l))
        (else false)))

(test-case "first pair"
  (define pairs (solution "3.67" 'pairs))
  (check-equal? (car (pairs (ints 1) (ints 1))) '(1 1)))

(test-case "pairs with i > j are included"
  (define pairs (solution "3.67" 'pairs))
  (let ((first (head (pairs (ints 1) (ints 1)) 30)))
    (check-true (member? '(2 1) first))
    (check-true (member? '(3 1) first))
    (check-true (member? '(3 2) first))))

(test-case "all pairs with small components appear, without duplicates"
  (define pairs (solution "3.67" 'pairs))
  (let ((first (head (pairs (ints 1) (ints 1)) 60)))
    (check-true (all-present? '((1 1) (1 2) (2 1) (2 2) (1 3) (3 1) (2 3) (3 2) (3 3)) first))
    (check-true (no-duplicates? first))))

(test-case "no pair appears that is not in s x t"
  (define pairs (solution "3.67" 'pairs))
  (let ((first (head (pairs (ints 1) (ints 1)) 40)))
    (check-true (all-present? '((1 4) (4 1)) (head (pairs (ints 1) (ints 1)) 60)))
    (check-true (let loop ((l first))
                  (cond ((null? l) true)
                        ((and (> (car (car l)) 0) (> (car (cdr (car l))) 0)) (loop (cdr l)))
                        (else false))))))

(test-case "works with other streams"
  (define pairs (solution "3.67" 'pairs))
  (let ((first (head (pairs (ints 10) (ints 20)) 20)))
    (check-equal? (car first) '(10 20))
    (check-true (member? '(10 21) first))
    (check-true (member? '(11 20) first))
    (check-true (member? '(11 21) first))
    (check-true (no-duplicates? first))))

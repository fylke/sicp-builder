#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.70.rkt must (#%provide merge-weighted weighted-pairs pairs-a pairs-b)
;;   (merge-weighted s1 s2 weight) -> merge of two streams ordered by (weight x), a procedure on elements
;;   (weighted-pairs s t weight)   -> pairs (i j) with i <= j, ordered by (weight (list i j))
;;   pairs-a -> all pairs of positive integers (i j), i <= j, ordered by i + j
;;   pairs-b -> pairs (i j), i <= j, of integers divisible by none of 2, 3, 5,
;;              ordered by 2i + 3j + 5ij
;; Define integers, stream-map, stream-filter etc. yourself in the file.

(define (head s n)
  (if (or (= n 0) (null? s))
      '()
      (cons (car s) (head (force (cdr s)) (- n 1)))))

(define (ints n) (cons-stream n (ints (+ n 1))))

(define (from-list l)
  (if (null? l)
      '()
      (cons-stream (car l) (from-list (cdr l)))))

(define (map-list f l)
  (if (null? l) '() (cons (f (car l)) (map-list f (cdr l)))))

(define (member? x l)
  (cond ((null? l) false)
        ((equal? x (car l)) true)
        (else (member? x (cdr l)))))

(define (weight-a p) (+ (car p) (cadr p)))
(define (weight-b p) (+ (* 2 (car p)) (* 3 (cadr p)) (* 5 (car p) (cadr p))))

(test-case "merge-weighted merges by weight"
  (define merge-weighted (solution "3.70" 'merge-weighted))
  (check-equal? (head (merge-weighted (from-list '(1 4 6 9)) (from-list '(2 3 7 8)) (lambda (x) x)) 10)
                '(1 2 3 4 6 7 8 9)))

(test-case "merge-weighted uses the weight function"
  (define merge-weighted (solution "3.70" 'merge-weighted))
  (check-equal? (head (merge-weighted (from-list '(10 5 1)) (from-list '(8 4 2)) (lambda (x) (- x))) 10)
                '(10 8 5 4 2 1)))

(test-case "merge-weighted with an empty stream"
  (define merge-weighted (solution "3.70" 'merge-weighted))
  (check-equal? (head (merge-weighted the-empty-stream (from-list '(1 2 3)) (lambda (x) x)) 5) '(1 2 3))
  (check-equal? (head (merge-weighted (from-list '(1 2 3)) the-empty-stream (lambda (x) x)) 5) '(1 2 3)))

(test-case "merge-weighted of infinite streams"
  (define merge-weighted (solution "3.70" 'merge-weighted))
  (check-equal? (head (merge-weighted (ints 1) (ints 1) (lambda (x) x)) 6) '(1 1 2 2 3 3)))

(test-case "weighted-pairs ordered by i + j"
  (define weighted-pairs (solution "3.70" 'weighted-pairs))
  (let ((first (head (weighted-pairs (ints 1) (ints 1) weight-a) 12)))
    (check-equal? (car first) '(1 1))
    (check-equal? (map-list weight-a first) '(2 3 4 4 5 5 6 6 6 7 7 7))
    (check-true (member? '(1 2) first))
    (check-true (member? '(2 2) first))
    (check-true (member? '(1 3) first))
    (check-true (member? '(3 3) first))))

(test-case "weighted-pairs ordered by a different weight"
  (define weighted-pairs (solution "3.70" 'weighted-pairs))
  (let ((first (head (weighted-pairs (ints 1) (ints 1) (lambda (p) (* (car p) (cadr p)))) 8)))
    (check-equal? (map-list (lambda (p) (* (car p) (cadr p))) first) '(1 2 3 4 4 5 6 6))))

(test-case "pairs-a: all pairs ordered by i + j"
  (define pairs-a (solution "3.70" 'pairs-a))
  (let ((first (head pairs-a 20)))
    (check-equal? (car first) '(1 1))
    (check-equal? (map-list weight-a first)
                  '(2 3 4 4 5 5 6 6 6 7 7 7 8 8 8 8 9 9 9 9))))

(test-case "pairs-b: integers not divisible by 2, 3 or 5, ordered by 2i + 3j + 5ij"
  (define pairs-b (solution "3.70" 'pairs-b))
  (let ((first (head pairs-b 10)))
    (check-equal? first '((1 1) (1 7) (1 11) (1 13) (1 17) (1 19) (1 23) (1 29) (1 31) (7 7)))
    (check-equal? (map-list weight-b first) '(10 58 90 106 138 154 186 234 250 280))))

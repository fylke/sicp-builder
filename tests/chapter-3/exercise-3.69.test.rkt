#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.69.rkt must (#%provide triples pythagorean-triples)
;;   (triples s t u)      -> stream of lists (list Si Tj Uk) with i <= j <= k
;;   pythagorean-triples  -> stream of (list i j k) with i <= j <= k and i^2 + j^2 = k^2,
;;                           built from (triples integers integers integers)
;; Define integers, pairs, interleave, stream-map, stream-filter yourself in the file.

(define (head s n)
  (if (or (= n 0) (null? s))
      '()
      (cons (car s) (head (force (cdr s)) (- n 1)))))

(define (ints n) (cons-stream n (ints (+ n 1))))

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

(define (all? pred l)
  (cond ((null? l) true)
        ((pred (car l)) (all? pred (cdr l)))
        (else false)))

(test-case "first triple"
  (define triples (solution "3.69" 'triples))
  (check-equal? (car (triples (ints 1) (ints 1) (ints 1))) '(1 1 1)))

(test-case "every triple has i <= j <= k and there are no duplicates"
  (define triples (solution "3.69" 'triples))
  (let ((first (head (triples (ints 1) (ints 1) (ints 1)) 100)))
    (check-equal? (length first) 100)
    (check-true (all? (lambda (t) (and (<= (car t) (cadr t)) (<= (cadr t) (caddr t)))) first))
    (check-true (no-duplicates? first))))

(test-case "small triples appear"
  (define triples (solution "3.69" 'triples))
  (let ((first (head (triples (ints 1) (ints 1) (ints 1)) 200)))
    (check-true (all-present? '((1 1 1) (1 1 2) (1 2 2) (2 2 2) (1 2 3) (1 1 3) (2 2 3) (1 3 3) (2 3 3) (3 3 3))
                              first))))

(test-case "works on other streams"
  (define triples (solution "3.69" 'triples))
  (let ((first (head (triples (ints 1) (ints 5) (ints 10)) 30)))
    (check-equal? (car first) '(1 5 10))
    (check-true (all? (lambda (t) (and (<= (car t) (cadr t)) (<= (cadr t) (caddr t)))) first))
    (check-true (no-duplicates? first))))

(test-case "the first Pythagorean triples"
  (define pythagorean-triples (solution "3.69" 'pythagorean-triples))
  (let ((first (head pythagorean-triples 4)))
    (check-equal? (car first) '(3 4 5))
    (check-true (all-present? '((3 4 5) (6 8 10) (5 12 13) (9 12 15)) first))
    (check-true (no-duplicates? first))))

(test-case "Pythagorean triples are valid"
  (define pythagorean-triples (solution "3.69" 'pythagorean-triples))
  (check-true (all? (lambda (t)
                      (and (<= (car t) (cadr t))
                           (= (+ (* (car t) (car t)) (* (cadr t) (cadr t)))
                              (* (caddr t) (caddr t)))))
                    (head pythagorean-triples 4))))

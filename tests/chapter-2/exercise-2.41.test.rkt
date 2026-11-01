#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.41.rkt must (#%provide triples-with-sum)
;;   (triples-with-sum n s) -- all sets of three distinct positive integers i, j, k <= n
;;                             with i + j + k = s, as a list of three-element lists
;;                             (each set once; the order inside a triple and the order of
;;                             the triples do not matter)
;; You must define the supporting procedures (flatmap, enumerate-interval, ...) yourself.

(define (insert x sorted)
  (cond ((null? sorted) (list x))
        ((<= x (car sorted)) (cons x sorted))
        (else (cons (car sorted) (insert x (cdr sorted))))))
(define (sort-numbers items)
  (if (null? items) '() (insert (car items) (sort-numbers (cdr items)))))
(define (same-triples? result expected)
  (let ((normalized (map sort-numbers result)))
    (and (= (length normalized) (length expected))
         (every-member? normalized expected)
         (every-member? expected normalized))))
(define (every-member? a b)
  (or (null? a)
      (and (member (car a) b) (every-member? (cdr a) b))))

(test-case "n = 6, s = 10"
  (define triples-with-sum (solution "2.41" 'triples-with-sum))
  (check-true (same-triples? (triples-with-sum 6 10) '((1 3 6) (1 4 5) (2 3 5)))))

(test-case "n = 5, s = 9"
  (define triples-with-sum (solution "2.41" 'triples-with-sum))
  (check-true (same-triples? (triples-with-sum 5 9) '((1 3 5) (2 3 4)))))

(test-case "the smallest possible triple"
  (define triples-with-sum (solution "2.41" 'triples-with-sum))
  (check-true (same-triples? (triples-with-sum 3 6) '((1 2 3))))
  (check-true (same-triples? (triples-with-sum 10 6) '((1 2 3)))))

(test-case "no triples"
  (define triples-with-sum (solution "2.41" 'triples-with-sum))
  (check-equal? (triples-with-sum 3 7) '())
  (check-equal? (triples-with-sum 10 5) '())
  (check-equal? (triples-with-sum 4 100) '()))

(test-case "elements must be distinct and at most n"
  (define triples-with-sum (solution "2.41" 'triples-with-sum))
  (check-true (same-triples? (triples-with-sum 4 9) '((2 3 4))))
  (check-true (same-triples? (triples-with-sum 8 12)
                             '((1 3 8) (1 4 7) (1 5 6) (2 3 7) (2 4 6) (3 4 5)))))

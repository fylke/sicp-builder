#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.40.rkt must (#%provide unique-pairs prime-sum-pairs)
;;   (unique-pairs n)     -- the sequence of pairs (i j) (as two-element lists) with
;;                           1 <= j < i <= n (any order)
;;   (prime-sum-pairs n)  -- the list of triples (i j (+ i j)) for those pairs (i j) from
;;                           unique-pairs whose sum is prime (any order)
;; You must define the supporting procedures (prime?, accumulate, flatmap,
;; enumerate-interval, ...) yourself; they are not tested here.

(define (same-elements? a b)
  (and (= (length a) (length b))
       (every-member? a b)
       (every-member? b a)))
(define (every-member? a b)
  (or (null? a)
      (and (member (car a) b) (every-member? (cdr a) b))))

(test-case "unique-pairs for small n"
  (define unique-pairs (solution "2.40" 'unique-pairs))
  (check-equal? (unique-pairs 1) '())
  (check-equal? (unique-pairs 2) '((2 1)))
  (check-true (same-elements? (unique-pairs 3) '((2 1) (3 1) (3 2)))))

(test-case "unique-pairs for n = 4"
  (define unique-pairs (solution "2.40" 'unique-pairs))
  (check-true (same-elements? (unique-pairs 4) '((2 1) (3 1) (3 2) (4 1) (4 2) (4 3)))))

(test-case "unique-pairs has n(n-1)/2 pairs"
  (define unique-pairs (solution "2.40" 'unique-pairs))
  (check-equal? (length (unique-pairs 10)) 45)
  (check-true (same-elements? (unique-pairs 10) (unique-pairs 10))))

(test-case "prime-sum-pairs"
  (define prime-sum-pairs (solution "2.40" 'prime-sum-pairs))
  (check-true (same-elements? (prime-sum-pairs 6)
                              '((2 1 3) (3 2 5) (4 1 5) (4 3 7) (5 2 7) (6 1 7) (6 5 11))))
  (check-equal? (prime-sum-pairs 1) '())
  (check-equal? (prime-sum-pairs 2) '((2 1 3))))

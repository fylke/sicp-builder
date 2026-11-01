#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-1/exercise-1.03.rkt must (#%provide sum-of-squares-of-larger)
;;   (sum-of-squares-of-larger a b c) -- sum of the squares of the two larger of the three numbers
;; (define any helpers, such as square, yourself)

(define (perms a b c)
  (list (list a b c) (list a c b) (list b a c) (list b c a) (list c a b) (list c b a)))

(define (check-all-orders f a b c expected)
  (for-each (lambda (p)
              (check-equal? (f (car p) (cadr p) (caddr p)) expected
                            (string-append "arguments: " (number->string (car p)) " "
                                           (number->string (cadr p)) " "
                                           (number->string (caddr p)))))
            (perms a b c)))

(test-case "distinct values, every argument order"
  (define f (solution "1.03" 'sum-of-squares-of-larger))
  (check-all-orders f 1 2 3 13)
  (check-all-orders f 5 2 4 41)
  (check-all-orders f 0 7 9 130))

(test-case "ties for the smallest"
  (define f (solution "1.03" 'sum-of-squares-of-larger))
  (check-all-orders f 1 1 3 10)
  (check-all-orders f 2 2 5 29)
  (check-all-orders f 0 0 0 0))

(test-case "ties for the largest"
  (define f (solution "1.03" 'sum-of-squares-of-larger))
  (check-all-orders f 1 3 3 18)
  (check-all-orders f 4 4 4 32))

(test-case "negative numbers"
  (define f (solution "1.03" 'sum-of-squares-of-larger))
  (check-all-orders f -1 -2 -3 5)
  (check-all-orders f -5 1 2 5)
  (check-all-orders f -10 -1 3 10))

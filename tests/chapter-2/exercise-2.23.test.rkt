#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.23.rkt must (#%provide for-each)
;;   (for-each proc items) -- apply proc to each element of items, left to right, for its effect
;;                            (any return value). Define it yourself, without using the built-in.

(define (enumerate-up n)
  (define (iter i acc) (if (= i 0) acc (iter (- i 1) (cons i acc))))
  (iter n '()))

(test-case "applies the procedure to every element, left to right"
  (define my-for-each (solution "2.23" 'for-each))
  (define seen '())
  (my-for-each (lambda (x) (set! seen (cons x seen))) (list 57 321 88))
  (check-equal? seen '(88 321 57)))

(test-case "empty list"
  (define my-for-each (solution "2.23" 'for-each))
  (define calls 0)
  (my-for-each (lambda (x) (set! calls (+ calls 1))) '())
  (check-equal? calls 0))

(test-case "each element is processed exactly once"
  (define my-for-each (solution "2.23" 'for-each))
  (define total 0)
  (define calls 0)
  (my-for-each (lambda (x) (set! calls (+ calls 1)) (set! total (+ total x))) (list 1 2 3 4 5))
  (check-equal? calls 5)
  (check-equal? total 15))

(test-case "return values of the procedure are ignored"
  (define my-for-each (solution "2.23" 'for-each))
  (define seen '())
  (my-for-each (lambda (x) (set! seen (cons x seen)) #f) (list 1 #f 3))
  (check-equal? seen '(3 #f 1)))

(test-case "works on a long list"
  (define my-for-each (solution "2.23" 'for-each))
  (define total 0)
  (my-for-each (lambda (x) (set! total (+ total x))) (enumerate-up 20000))
  (check-equal? total 200010000))


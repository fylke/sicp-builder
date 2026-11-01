#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.74.rkt must (#%provide sign-change-detector zero-crossings-of)
;;   (sign-change-detector current last) -> 1 if last was negative and current is not,
;;        -1 if last was not negative and current is, otherwise 0 (a 0 input counts as positive)
;;   (zero-crossings-of sense-data) -> the zero-crossing stream of the stream sense-data, built
;;        with the generalized stream-map and the stream (cons-stream 0 sense-data) as in
;;        (stream-map sign-change-detector sense-data <expression>)
;; Define stream-map (Exercise 3.50) yourself in the file.

(define (head s n)
  (if (or (= n 0) (null? s))
      '()
      (cons (car s) (head (force (cdr s)) (- n 1)))))

(define (from-list-then-fours l)
  (if (null? l)
      (cons-stream 4 (from-list-then-fours l))
      (cons-stream (car l) (from-list-then-fours (cdr l)))))

(define data '(1 2 1.5 1 0.5 -0.1 -2 -3 -2 -0.5 0.2 3 4))

(test-case "sign-change-detector: positive to negative"
  (define sign-change-detector (solution "3.74" 'sign-change-detector))
  (check-equal? (sign-change-detector -1 1) -1)
  (check-equal? (sign-change-detector -0.1 0.5) -1))

(test-case "sign-change-detector: negative to positive"
  (define sign-change-detector (solution "3.74" 'sign-change-detector))
  (check-equal? (sign-change-detector 1 -1) 1)
  (check-equal? (sign-change-detector 0.2 -0.5) 1))

(test-case "sign-change-detector: no change"
  (define sign-change-detector (solution "3.74" 'sign-change-detector))
  (check-equal? (sign-change-detector 1 2) 0)
  (check-equal? (sign-change-detector -1 -2) 0))

(test-case "sign-change-detector: zero counts as positive"
  (define sign-change-detector (solution "3.74" 'sign-change-detector))
  (check-equal? (sign-change-detector 0 1) 0)
  (check-equal? (sign-change-detector 0 -1) 1)
  (check-equal? (sign-change-detector -1 0) -1)
  (check-equal? (sign-change-detector 1 0) 0))

(test-case "zero crossings of the example signal"
  (define zero-crossings-of (solution "3.74" 'zero-crossings-of))
  (check-equal? (head (zero-crossings-of (from-list-then-fours data)) 13)
                '(0 0 0 0 0 -1 0 0 0 0 1 0 0)))

(test-case "a signal starting negative crosses at once"
  (define zero-crossings-of (solution "3.74" 'zero-crossings-of))
  (check-equal? (head (zero-crossings-of (from-list-then-fours '(-1 -1 2 2 -3))) 6)
                '(-1 0 1 0 -1 1)))

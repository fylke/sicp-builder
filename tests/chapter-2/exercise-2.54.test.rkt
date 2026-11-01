#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.54.rkt must (#%provide equal?)
;;   (equal? a b) -- true if a and b are the same symbol, or lists of equal? elements in the
;;                   same order. Define it yourself (it shadows the built-in in your file) using
;;                   only eq? on symbols plus car/cdr; numbers are not tested.

(test-case "book examples"
  (define my-equal? (solution "2.54" 'equal?))
  (check-true (my-equal? '(this is a list) '(this is a list)))
  (check-false (my-equal? '(this is a list) '(this (is a) list))))

(test-case "symbols"
  (define my-equal? (solution "2.54" 'equal?))
  (check-true (my-equal? 'a 'a))
  (check-false (my-equal? 'a 'b)))

(test-case "empty lists"
  (define my-equal? (solution "2.54" 'equal?))
  (check-true (my-equal? '() '()))
  (check-false (my-equal? '() '(a)))
  (check-false (my-equal? '(a) '())))

(test-case "lists of different lengths"
  (define my-equal? (solution "2.54" 'equal?))
  (check-false (my-equal? '(a b c) '(a b)))
  (check-false (my-equal? '(a b) '(a b c)))
  (check-false (my-equal? '(a b c) '(a b d))))

(test-case "a symbol is never equal to a list"
  (define my-equal? (solution "2.54" 'equal?))
  (check-false (my-equal? 'a '(a)))
  (check-false (my-equal? '(a) 'a))
  (check-false (my-equal? '() 'a))
  (check-false (my-equal? 'a '())))

(test-case "nested lists"
  (define my-equal? (solution "2.54" 'equal?))
  (check-true (my-equal? '(a (b (c d)) e) '(a (b (c d)) e)))
  (check-false (my-equal? '(a (b (c d)) e) '(a (b (c e)) e)))
  (check-false (my-equal? '((a b) c) '(a (b c))))
  (check-true (my-equal? '(() (())) '(() (()))))
  (check-false (my-equal? '(() (())) '((()) ()))))

(test-case "equal lists need not be the same object"
  (define my-equal? (solution "2.54" 'equal?))
  (check-true (my-equal? (list 'a (list 'b 'c)) (list 'a (list 'b 'c)))))

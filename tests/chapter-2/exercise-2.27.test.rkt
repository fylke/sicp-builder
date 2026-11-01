#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.27.rkt must (#%provide deep-reverse)
;;   (deep-reverse x) -- x reversed, with all sublists deep-reversed as well

(test-case "book example"
  (define deep-reverse (solution "2.27" 'deep-reverse))
  (define x (list (list 1 2) (list 3 4)))
  (check-equal? (deep-reverse x) '((4 3) (2 1))))

(test-case "flat lists and the empty list"
  (define deep-reverse (solution "2.27" 'deep-reverse))
  (check-equal? (deep-reverse '()) '())
  (check-equal? (deep-reverse '(1 2 3)) '(3 2 1)))

(test-case "deeper nesting"
  (define deep-reverse (solution "2.27" 'deep-reverse))
  (check-equal? (deep-reverse '(1 (2 (3 4)) 5)) '(5 ((4 3) 2) 1))
  (check-equal? (deep-reverse '(((1 2) 3) 4)) '(4 (3 (2 1)))))

(test-case "empty sublists are kept"
  (define deep-reverse (solution "2.27" 'deep-reverse))
  (check-equal? (deep-reverse '(1 () (2 ()))) '((() 2) () 1)))

(test-case "does not modify its argument"
  (define deep-reverse (solution "2.27" 'deep-reverse))
  (define x (list (list 1 2) (list 3 4)))
  (deep-reverse x)
  (check-equal? x '((1 2) (3 4))))

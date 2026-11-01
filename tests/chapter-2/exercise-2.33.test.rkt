#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.33.rkt must (#%provide map append length)
;;   (map p sequence)        -- list of (p x) for x in sequence
;;   (append seq1 seq2)      -- seq1 followed by seq2
;;   (length sequence)       -- number of elements
;; each defined with accumulate (shadowing the built-ins in your file). You must define
;; accumulate yourself; it is not tested here.

(test-case "map"
  (define my-map (solution "2.33" 'map))
  (check-equal? (my-map (lambda (x) (* x x)) (list 1 2 3 4)) '(1 4 9 16))
  (check-equal? (my-map (lambda (x) (* x x)) '()) '())
  (check-equal? (my-map list '(a b)) '((a) (b))))

(test-case "map preserves order"
  (define my-map (solution "2.33" 'map))
  (check-equal? (my-map (lambda (x) (+ x 1)) (list 3 1 2)) '(4 2 3)))

(test-case "append"
  (define my-append (solution "2.33" 'append))
  (check-equal? (my-append (list 1 2) (list 3 4 5)) '(1 2 3 4 5))
  (check-equal? (my-append '() (list 1 2)) '(1 2))
  (check-equal? (my-append (list 1 2) '()) '(1 2))
  (check-equal? (my-append '() '()) '())
  (check-equal? (my-append '((1) 2) '(3 (4))) '((1) 2 3 (4))))

(test-case "length"
  (define my-length (solution "2.33" 'length))
  (check-equal? (my-length '()) 0)
  (check-equal? (my-length (list 1)) 1)
  (check-equal? (my-length (list 1 2 3 4 5)) 5)
  (check-equal? (my-length '((1 2) (3 4) ())) 3))

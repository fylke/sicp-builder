#lang sicp
;; Your exercises/chapter-4/exercise-4.06.rkt must (#%provide let->combination).
;; let->combination: (let->combination exp) rewrites an ordinary let as a lambda application.
;; No additional definitions are required.
(#%require rackunit "../lib.rkt")

(test-case "let bindings become lambda parameters and operands"
  (define f (solution "4.06" 'let->combination))
  (check-equal? (f '(let ((x 3) (y (+ 2 4))) (* x y)))
                '((lambda (x y) (* x y)) 3 (+ 2 4)))
  (check-equal? (f '(let ((x 1)) (display x) (+ x 2)))
                '((lambda (x) (display x) (+ x 2)) 1))
  (check-equal? (f '(let () 42)) '((lambda () 42))))

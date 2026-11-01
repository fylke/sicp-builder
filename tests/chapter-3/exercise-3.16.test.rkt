#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.16.rkt must
;;   (#%provide struct-3 struct-4 struct-7 struct-cycle)
;; Each is a list structure made of exactly three pairs, for which Ben's count-pairs
;; (the book's version, defined in this test) returns:
;;   struct-3     -> 3
;;   struct-4     -> 4
;;   struct-7     -> 7
;;   struct-cycle -> never returns (the structure contains a cycle)

;; Ben's count-pairs, with a call budget so a cyclic structure returns 'diverges
;; instead of looping forever.
(define (ben-count-pairs x)
  (call-with-current-continuation
   (lambda (escape)
     (let ((calls 0))
       (define (count x)
         (set! calls (+ calls 1))
         (if (> calls 100000)
             (escape 'diverges)
             (if (not (pair? x))
                 0
                 (+ (count (car x)) (count (cdr x)) 1))))
       (count x)))))

(define (distinct-pairs x)
  (define (walk x seen)
    (if (or (not (pair? x)) (memq x seen))
        seen
        (walk (cdr x) (walk (car x) (cons x seen)))))
  (walk x '()))

(define (three-pairs? x) (= (length (distinct-pairs x)) 3))

(test-case "struct-3 has three pairs and Ben counts 3"
  (define s (solution "3.16" 'struct-3))
  (check-true (three-pairs? s))
  (check-equal? (ben-count-pairs s) 3))

(test-case "struct-4 has three pairs and Ben counts 4"
  (define s (solution "3.16" 'struct-4))
  (check-true (three-pairs? s))
  (check-equal? (ben-count-pairs s) 4))

(test-case "struct-7 has three pairs and Ben counts 7"
  (define s (solution "3.16" 'struct-7))
  (check-true (three-pairs? s))
  (check-equal? (ben-count-pairs s) 7))

(test-case "struct-cycle has three pairs and Ben never returns"
  (define s (solution "3.16" 'struct-cycle))
  (check-true (three-pairs? s))
  (check-equal? (ben-count-pairs s) 'diverges))

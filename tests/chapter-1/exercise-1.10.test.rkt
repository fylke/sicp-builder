#lang sicp
(#%require rackunit "../lib.rkt"
           (only racket/base thread sync/timeout kill-thread with-handlers exn:fail? raise))

;; Your exercises/chapter-1/exercise-1.10.rkt must (#%provide A f g h)
;;   (A x y) -- Ackermann's function as defined in the book
;;   (f n)   -- (A 0 n)
;;   (g n)   -- (A 1 n)
;;   (h n)   -- (A 2 n)
;; Hint: f, g, h should be defined by you (e.g. (define (f n) (A 0 n))).

(define (within secs thunk)
  (let ((result #f))
    (let ((t (thread (lambda ()
                       (set! result (with-handlers ((exn:fail? (lambda (e) (list 'error e))))
                                      (list 'ok (thunk))))))))
      (if (sync/timeout secs t)
          (if (eq? (car result) 'ok) (cadr result) (raise (cadr result)))
          (begin (kill-thread t) (error "did not finish in time (infinite loop?)"))))))

(test-case "A on the book's examples"
  (define A (solution "1.10" 'A))
  (check-equal? (within 10 (lambda () (A 1 10))) 1024)
  (check-equal? (within 10 (lambda () (A 2 4))) 65536)
  (check-equal? (within 10 (lambda () (A 3 3))) 65536))

(test-case "A base cases"
  (define A (solution "1.10" 'A))
  (check-equal? (within 10 (lambda () (A 0 5))) 10)
  (check-equal? (within 10 (lambda () (A 1 0))) 0)
  (check-equal? (within 10 (lambda () (A 2 0))) 0)
  (check-equal? (within 10 (lambda () (A 1 1))) 2)
  (check-equal? (within 10 (lambda () (A 2 1))) 2))

(test-case "f computes 2n"
  (define f (solution "1.10" 'f))
  (check-equal? (f 0) 0)
  (check-equal? (f 1) 2)
  (check-equal? (f 7) 14))

(test-case "g computes 2^n"
  (define g (solution "1.10" 'g))
  (check-equal? (g 0) 0)
  (check-equal? (g 1) 2)
  (check-equal? (g 5) 32)
  (check-equal? (g 10) 1024))

(test-case "h computes 2^2^...^2 (n twos)"
  (define h (solution "1.10" 'h))
  (check-equal? (h 0) 0)
  (check-equal? (h 1) 2)
  (check-equal? (h 2) 4)
  (check-equal? (h 3) 16)
  (check-equal? (h 4) 65536))

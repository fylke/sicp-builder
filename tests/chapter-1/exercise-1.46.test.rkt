#lang sicp
(#%require rackunit "../lib.rkt"
           (only racket/base thread sync/timeout kill-thread with-handlers exn:fail? raise))

;; Your exercises/chapter-1/exercise-1.46.rkt must (#%provide iterative-improve sqrt fixed-point)
;;   (iterative-improve good-enough? improve) -- returns a procedure of a guess that keeps
;;                                               improving it until (good-enough? guess)
;;   (sqrt x)                -- square root of x > 0, written with iterative-improve
;;   (fixed-point f guess)   -- fixed point of f starting at guess, written with iterative-improve
;;                              (stop when successive values differ by less than your tolerance)

(define (within secs thunk)
  (let ((result #f))
    (let ((t (thread (lambda ()
                       (set! result (with-handlers ((exn:fail? (lambda (e) (list 'error e))))
                                      (list 'ok (thunk))))))))
      (if (sync/timeout secs t)
          (if (eq? (car result) 'ok) (cadr result) (raise (cadr result)))
          (begin (kill-thread t) (error "did not finish in time (infinite loop?)"))))))

(test-case "iterative-improve"
  (define iterative-improve (solution "1.46" 'iterative-improve))
  (check-equal? (within 10 (lambda () ((iterative-improve (lambda (g) (> g 100)) (lambda (g) (* g 2))) 1)))
                128)
  (check-equal? (within 10 (lambda () ((iterative-improve (lambda (g) (> g 100)) (lambda (g) (* g 2))) 500)))
                500)
  (check-equal? (within 10 (lambda () ((iterative-improve (lambda (g) (= g 0)) (lambda (g) (- g 1))) 7)))
                0))

(test-case "sqrt"
  (define sqrt (solution "1.46" 'sqrt))
  (check-= (within 10 (lambda () (sqrt 4))) 2 1e-3)
  (check-= (within 10 (lambda () (sqrt 2))) 1.4142135623730951 1e-3)
  (check-= (within 10 (lambda () (sqrt 144))) 12 1e-3)
  (check-= (within 10 (lambda () (sqrt 10000))) 100 1e-3))

(test-case "fixed-point"
  (define fixed-point (solution "1.46" 'fixed-point))
  (check-= (within 10 (lambda () (fixed-point cos 1.0))) 0.7390851332151607 1e-3)
  (check-= (within 10 (lambda () (fixed-point (lambda (y) (+ (sin y) (cos y))) 1.0)))
           1.2587315962971173 1e-3)
  (check-= (within 10 (lambda () (fixed-point (lambda (x) (+ 1 (/ 1.0 x))) 1.0)))
           1.618033988749895 1e-3))

#lang sicp
(#%require rackunit "../lib.rkt"
           (only racket/base thread sync/timeout kill-thread with-handlers exn:fail? raise))

;; Your exercises/chapter-1/exercise-1.19.rkt must (#%provide fib)
;;   (fib n) -- the n-th Fibonacci number (fib 0 = 0, fib 1 = 1), computed in a
;;              logarithmic number of steps using the transformation T_pq
;; (define fib-iter yourself)

(define (within secs thunk)
  (let ((result #f))
    (let ((t (thread (lambda ()
                       (set! result (with-handlers ((exn:fail? (lambda (e) (list 'error e))))
                                      (list 'ok (thunk))))))))
      (if (sync/timeout secs t)
          (if (eq? (car result) 'ok) (cadr result) (raise (cadr result)))
          (begin (kill-thread t) (error "did not finish in time (infinite loop or too slow?)"))))))

(test-case "first Fibonacci numbers"
  (define fib (solution "1.19" 'fib))
  (check-equal? (fib 0) 0)
  (check-equal? (fib 1) 1)
  (check-equal? (fib 2) 1)
  (check-equal? (fib 3) 2)
  (check-equal? (fib 10) 55)
  (check-equal? (fib 20) 6765))

(test-case "every n up to 60 agrees with the definition"
  (define fib (solution "1.19" 'fib))
  (do ((n 0 (+ n 1))
       (a 0 b)
       (b 1 (+ a b)))
      ((> n 60))
    (check-equal? (fib n) a (string-append "n = " (number->string n)))))

(test-case "larger values"
  (define fib (solution "1.19" 'fib))
  (check-equal? (fib 90) 2880067194370816120))

(test-case "huge n finishes quickly (logarithmic steps)"
  (define fib (solution "1.19" 'fib))
  (check-equal? (within 20 (lambda () (remainder (fib 1000000) 1000007))) 930254))

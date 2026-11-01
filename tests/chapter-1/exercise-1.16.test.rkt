#lang sicp
(#%require rackunit "../lib.rkt"
           (only racket/base thread sync/timeout kill-thread with-handlers exn:fail? raise))

;; Your exercises/chapter-1/exercise-1.16.rkt must (#%provide fast-expt)
;;   (fast-expt b n) -- b^n for a non-negative integer n, iterative process,
;;                      using successive squaring (logarithmic number of steps)

(define (within secs thunk)
  (let ((result #f))
    (let ((t (thread (lambda ()
                       (set! result (with-handlers ((exn:fail? (lambda (e) (list 'error e))))
                                      (list 'ok (thunk))))))))
      (if (sync/timeout secs t)
          (if (eq? (car result) 'ok) (cadr result) (raise (cadr result)))
          (begin (kill-thread t) (error "did not finish in time (infinite loop or too slow?)"))))))

(test-case "small exponents"
  (define fast-expt (solution "1.16" 'fast-expt))
  (check-equal? (fast-expt 2 0) 1)
  (check-equal? (fast-expt 2 1) 2)
  (check-equal? (fast-expt 2 10) 1024)
  (check-equal? (fast-expt 3 5) 243)
  (check-equal? (fast-expt 7 2) 49)
  (check-equal? (fast-expt 0 3) 0)
  (check-equal? (fast-expt 5 0) 1))

(test-case "odd and even exponents"
  (define fast-expt (solution "1.16" 'fast-expt))
  (do ((n 0 (+ n 1)))
      ((> n 40))
    (check-equal? (fast-expt 3 n) (expt 3 n) (string-append "3^" (number->string n)))
    (check-equal? (fast-expt -2 n) (expt -2 n) (string-append "-2^" (number->string n)))))

(test-case "huge exponent finishes quickly (logarithmic steps)"
  (define fast-expt (solution "1.16" 'fast-expt))
  (check-equal? (within 10 (lambda () (fast-expt 1 100000000000))) 1)
  (check-equal? (within 10 (lambda () (fast-expt -1 100000000001))) -1)
  (check-equal? (within 10 (lambda () (fast-expt 2 3000))) (expt 2 3000)))

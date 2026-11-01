#lang sicp
(#%require rackunit "../lib.rkt"
           (only racket/base thread sync/timeout kill-thread with-handlers exn:fail? raise))

;; Your exercises/chapter-1/exercise-1.17.rkt must (#%provide fast-mul)
;;   (fast-mul a b) -- a * b for an integer a and a non-negative integer b, using only
;;                     addition, double and halve, in a logarithmic number of steps
;; (define double and halve yourself)

(define (within secs thunk)
  (let ((result #f))
    (let ((t (thread (lambda ()
                       (set! result (with-handlers ((exn:fail? (lambda (e) (list 'error e))))
                                      (list 'ok (thunk))))))))
      (if (sync/timeout secs t)
          (if (eq? (car result) 'ok) (cadr result) (raise (cadr result)))
          (begin (kill-thread t) (error "did not finish in time (infinite loop or too slow?)"))))))

(test-case "small products"
  (define fast-mul (solution "1.17" 'fast-mul))
  (check-equal? (fast-mul 0 0) 0)
  (check-equal? (fast-mul 5 0) 0)
  (check-equal? (fast-mul 0 5) 0)
  (check-equal? (fast-mul 1 1) 1)
  (check-equal? (fast-mul 6 7) 42)
  (check-equal? (fast-mul 7 6) 42))

(test-case "all small combinations"
  (define fast-mul (solution "1.17" 'fast-mul))
  (do ((a -6 (+ a 1)))
      ((> a 20))
    (do ((b 0 (+ b 1)))
        ((> b 20))
      (check-equal? (fast-mul a b) (* a b)
                    (string-append (number->string a) " * " (number->string b))))))

(test-case "huge multiplier finishes quickly (logarithmic steps)"
  (define fast-mul (solution "1.17" 'fast-mul))
  (check-equal? (within 10 (lambda () (fast-mul 3 1000000000000))) 3000000000000)
  (check-equal? (within 10 (lambda () (fast-mul -7 123456789012345))) (* -7 123456789012345)))

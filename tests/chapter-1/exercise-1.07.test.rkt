#lang sicp
(#%require rackunit "../lib.rkt"
           (only racket/base thread sync/timeout kill-thread with-handlers exn:fail? raise))

;; Your exercises/chapter-1/exercise-1.07.rkt must (#%provide sqrt)
;;   (sqrt x) -- square root of a positive number x, using Newton's method with your
;;               improved good-enough? test (must work for very small and very large x)
;; (define sqrt-iter, good-enough?, improve, etc. yourself)

(define (within secs thunk)
  (let ((result #f))
    (let ((t (thread (lambda ()
                       (set! result (with-handlers ((exn:fail? (lambda (e) (list 'error e))))
                                      (list 'ok (thunk))))))))
      (if (sync/timeout secs t)
          (if (eq? (car result) 'ok) (cadr result) (raise (cadr result)))
          (begin (kill-thread t) (error "did not finish in time (infinite loop?)"))))))

(define (check-rel actual expected)
  (check-= actual expected (* 1e-4 expected)))

(test-case "ordinary numbers"
  (define sqrt (solution "1.07" 'sqrt))
  (check-rel (within 10 (lambda () (sqrt 4))) 2)
  (check-rel (within 10 (lambda () (sqrt 2))) 1.4142135623730951)
  (check-rel (within 10 (lambda () (sqrt 144))) 12)
  (check-rel (within 10 (lambda () (sqrt 1))) 1))

(test-case "very small numbers"
  (define sqrt (solution "1.07" 'sqrt))
  (check-rel (within 10 (lambda () (sqrt 1e-4))) 1e-2)
  (check-rel (within 10 (lambda () (sqrt 1e-8))) 1e-4)
  (check-rel (within 10 (lambda () (sqrt 1e-12))) 1e-6)
  (check-rel (within 10 (lambda () (sqrt 4e-10))) 2e-5))

(test-case "very large numbers"
  (define sqrt (solution "1.07" 'sqrt))
  (check-rel (within 10 (lambda () (sqrt 1e12))) 1e6)
  (check-rel (within 10 (lambda () (sqrt 1e20))) 1e10)
  (check-rel (within 10 (lambda () (sqrt 1e40))) 1e20)
  (check-rel (within 10 (lambda () (sqrt 1e100))) 1e50))

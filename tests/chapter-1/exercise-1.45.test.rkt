#lang sicp
(#%require rackunit "../lib.rkt"
           (only racket/base thread sync/timeout kill-thread with-handlers exn:fail? raise))

;; Your exercises/chapter-1/exercise-1.45.rkt must (#%provide nth-root)
;;   (nth-root x n) -- the n-th root of the positive number x (n >= 2) found by a fixed-point
;;                     search with the right number of average damps, for any n
;; (define fixed-point, average-damp, repeated, ... yourself)

(define (within secs thunk)
  (let ((result #f))
    (let ((t (thread (lambda ()
                       (set! result (with-handlers ((exn:fail? (lambda (e) (list 'error e))))
                                      (list 'ok (thunk))))))))
      (if (sync/timeout secs t)
          (if (eq? (car result) 'ok) (cadr result) (raise (cadr result)))
          (begin (kill-thread t) (error "did not finish in time (does the fixed-point search converge?)"))))))

(define (check-root nth-root x n expected)
  (check-= (within 10 (lambda () (nth-root x n))) expected (* 1e-3 expected)))

(test-case "square and cube roots"
  (define nth-root (solution "1.45" 'nth-root))
  (check-root nth-root 9 2 3)
  (check-root nth-root 27 3 3)
  (check-root nth-root 2 2 1.4142135623730951))

(test-case "fourth and fifth roots"
  (define nth-root (solution "1.45" 'nth-root))
  (check-root nth-root 16 4 2)
  (check-root nth-root 81 4 3)
  (check-root nth-root 32 5 2))

(test-case "roots needing several damps"
  (define nth-root (solution "1.45" 'nth-root))
  (check-root nth-root 128 7 2)
  (check-root nth-root 256 8 2)
  (check-root nth-root 1024 10 2)
  (check-root nth-root 32768 15 2))

(test-case "large n"
  (define nth-root (solution "1.45" 'nth-root))
  (check-root nth-root 65536 16 2)
  (check-root nth-root 1073741824 30 2)
  (check-root nth-root 2 20 1.0352649238413776))

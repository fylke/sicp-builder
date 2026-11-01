#lang sicp
(#%require rackunit "../lib.rkt"
           (only racket/base thread sync/timeout kill-thread with-handlers exn:fail? raise))

;; Your exercises/chapter-1/exercise-1.08.rkt must (#%provide cube-root)
;;   (cube-root x) -- cube root of x (Newton's method), works for positive x
;; (define cube-root-iter, good-enough?, improve, etc. yourself)

(define (within secs thunk)
  (let ((result #f))
    (let ((t (thread (lambda ()
                       (set! result (with-handlers ((exn:fail? (lambda (e) (list 'error e))))
                                      (list 'ok (thunk))))))))
      (if (sync/timeout secs t)
          (if (eq? (car result) 'ok) (cadr result) (raise (cadr result)))
          (begin (kill-thread t) (error "did not finish in time (infinite loop?)"))))))

(define (check-rel actual expected)
  (check-= actual expected (* 1e-3 expected)))

(test-case "perfect cubes"
  (define cube-root (solution "1.08" 'cube-root))
  (check-rel (within 10 (lambda () (cube-root 8))) 2)
  (check-rel (within 10 (lambda () (cube-root 27))) 3)
  (check-rel (within 10 (lambda () (cube-root 1))) 1)
  (check-rel (within 10 (lambda () (cube-root 1000))) 10))

(test-case "non-cubes"
  (define cube-root (solution "1.08" 'cube-root))
  (check-rel (within 10 (lambda () (cube-root 2))) 1.2599210498948732)
  (check-rel (within 10 (lambda () (cube-root 0.5))) 0.7937005259840998))

(test-case "small and large numbers"
  (define cube-root (solution "1.08" 'cube-root))
  (check-rel (within 10 (lambda () (cube-root 1e-9))) 1e-3)
  (check-rel (within 10 (lambda () (cube-root 1e-18))) 1e-6)
  (check-rel (within 10 (lambda () (cube-root 1e18))) 1e6)
  (check-rel (within 10 (lambda () (cube-root 1e30))) 1e10))

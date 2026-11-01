#lang sicp
(#%require rackunit "../lib.rkt"
           (only racket/base thread sync/timeout kill-thread with-handlers exn:fail? raise))

;; Your exercises/chapter-1/exercise-1.11.rkt must (#%provide f-recursive f-iterative)
;;   (f-recursive n) -- f(n) = n if n < 3, else f(n-1) + 2 f(n-2) + 3 f(n-3), by a recursive process
;;   (f-iterative n) -- the same function, by an iterative process

(define (within secs thunk)
  (let ((result #f))
    (let ((t (thread (lambda ()
                       (set! result (with-handlers ((exn:fail? (lambda (e) (list 'error e))))
                                      (list 'ok (thunk))))))))
      (if (sync/timeout secs t)
          (if (eq? (car result) 'ok) (cadr result) (raise (cadr result)))
          (begin (kill-thread t) (error "did not finish in time (infinite loop or too slow?)"))))))

;; f(0) .. f(9)
(define small-values '(0 1 2 4 11 25 59 142 335 796))

(define (check-small f)
  (do ((n 0 (+ n 1))
       (vals small-values (cdr vals)))
      ((null? vals))
    (check-equal? (within 10 (lambda () (f n))) (car vals)
                  (string-append "n = " (number->string n)))))

(define (reference-f n)
  (let loop ((a 2) (b 1) (c 0) (i 0))
    (if (= i n)
        c
        (loop (+ a (* 2 b) (* 3 c)) a b (+ i 1)))))

(test-case "f-recursive small values"
  (define f-recursive (solution "1.11" 'f-recursive))
  (check-small f-recursive)
  (check-equal? (within 10 (lambda () (f-recursive 18))) (reference-f 18)))

(test-case "f-iterative small values"
  (define f-iterative (solution "1.11" 'f-iterative))
  (check-small f-iterative))

(test-case "f-iterative large n"
  (define f-iterative (solution "1.11" 'f-iterative))
  (check-equal? (within 10 (lambda () (f-iterative 1000))) (reference-f 1000)))

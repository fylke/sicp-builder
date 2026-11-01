#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.81.rkt must (#%provide rand-stream)
;;   (rand-stream requests) -> stream of random numbers, one for each 'generate request in the
;;   stream requests; a request (list 'reset n) sets the generator state to n and produces no output.
;;   The numbers produced depend only on the state (no assignment); after (reset n) the same
;;   numbers always follow. The requests are the symbol generate or lists (reset <number>).
;; Define rand-update and the stream helpers yourself in the file.

(define (head s n)
  (if (or (= n 0) (null? s))
      '()
      (cons (car s) (head (force (cdr s)) (- n 1)))))

(define (generates) (cons-stream 'generate (generates)))

;; the given requests followed by an endless supply of generate requests
(define (requests-then-generates l)
  (if (null? l)
      (generates)
      (cons-stream (car l) (requests-then-generates (cdr l)))))

(test-case "generates numbers"
  (define rand-stream (solution "3.81" 'rand-stream))
  (let ((out (head (rand-stream (generates)) 5)))
    (check-equal? (length out) 5)
    (check-true (let loop ((l out)) (or (null? l) (and (number? (car l)) (loop (cdr l))))))))

(test-case "successive numbers differ"
  (define rand-stream (solution "3.81" 'rand-stream))
  (let ((out (head (rand-stream (generates)) 4)))
    (check-false (= (car out) (cadr out)))
    (check-false (= (cadr out) (caddr out)))
    (check-false (= (caddr out) (cadddr out)))))

(test-case "the same requests give the same numbers"
  (define rand-stream (solution "3.81" 'rand-stream))
  (check-equal? (head (rand-stream (generates)) 5)
                (head (rand-stream (generates)) 5)))

(test-case "reset restarts the sequence"
  (define rand-stream (solution "3.81" 'rand-stream))
  ;; generate, reset 42, generate, generate, reset 42, generate, generate
  (let ((out (head (rand-stream
                    (requests-then-generates
                     '(generate (reset 42) generate generate (reset 42) generate generate)))
                   5)))
    (check-equal? (list-ref out 1) (list-ref out 3))
    (check-equal? (list-ref out 2) (list-ref out 4))
    (check-false (= (list-ref out 1) (list-ref out 2)))))

(test-case "reset produces no output and the last reset wins"
  (define rand-stream (solution "3.81" 'rand-stream))
  (check-equal? (head (rand-stream (requests-then-generates '((reset 7) generate generate))) 4)
                (head (rand-stream (requests-then-generates '((reset 9) (reset 7) generate generate))) 4)))

(test-case "different seeds give different numbers"
  (define rand-stream (solution "3.81" 'rand-stream))
  (check-false (equal? (head (rand-stream (requests-then-generates '((reset 1) generate generate))) 2)
                       (head (rand-stream (requests-then-generates '((reset 2) generate generate))) 2))))

(test-case "reset in the middle gives the same numbers as at the start"
  (define rand-stream (solution "3.81" 'rand-stream))
  (let ((a (head (rand-stream (requests-then-generates '((reset 5) generate generate generate))) 3))
        (b (head (rand-stream (requests-then-generates '(generate generate (reset 5) generate generate generate))) 5)))
    (check-equal? a (list-tail b 2))))

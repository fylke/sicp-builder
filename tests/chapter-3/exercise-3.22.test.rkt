#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.22.rkt must
;;   (#%provide make-queue empty-queue? front-queue insert-queue! delete-queue!)
;;   (make-queue)            -> a new empty queue, a procedure with local state
;;                              (front-ptr and rear-ptr inside, message passing)
;;   (empty-queue? q)        -> #t if q has no items
;;   (front-queue q)         -> the first item (signal an error if q is empty)
;;   (insert-queue! q item)  -> inserts item at the rear
;;   (delete-queue! q)       -> removes the front item (signal an error if q is empty)
;; The return values of insert-queue!/delete-queue! are not checked.

(test-case "a new queue is empty"
  (define make-queue (solution "3.22" 'make-queue))
  (define empty-queue? (solution "3.22" 'empty-queue?))
  (check-true (empty-queue? (make-queue))))

(test-case "insert and front"
  (define make-queue (solution "3.22" 'make-queue))
  (define empty-queue? (solution "3.22" 'empty-queue?))
  (define front-queue (solution "3.22" 'front-queue))
  (define insert-queue! (solution "3.22" 'insert-queue!))
  (define q (make-queue))
  (insert-queue! q 'a)
  (check-false (empty-queue? q))
  (check-equal? (front-queue q) 'a)
  (insert-queue! q 'b)
  (check-equal? (front-queue q) 'a))

(test-case "first in, first out"
  (define make-queue (solution "3.22" 'make-queue))
  (define empty-queue? (solution "3.22" 'empty-queue?))
  (define front-queue (solution "3.22" 'front-queue))
  (define insert-queue! (solution "3.22" 'insert-queue!))
  (define delete-queue! (solution "3.22" 'delete-queue!))
  (define q (make-queue))
  (insert-queue! q 1)
  (insert-queue! q 2)
  (insert-queue! q 3)
  (check-equal? (front-queue q) 1)
  (delete-queue! q)
  (check-equal? (front-queue q) 2)
  (delete-queue! q)
  (check-equal? (front-queue q) 3)
  (delete-queue! q)
  (check-true (empty-queue? q)))

(test-case "the queue is reusable after being emptied"
  (define make-queue (solution "3.22" 'make-queue))
  (define empty-queue? (solution "3.22" 'empty-queue?))
  (define front-queue (solution "3.22" 'front-queue))
  (define insert-queue! (solution "3.22" 'insert-queue!))
  (define delete-queue! (solution "3.22" 'delete-queue!))
  (define q (make-queue))
  (insert-queue! q 'a)
  (delete-queue! q)
  (check-true (empty-queue? q))
  (insert-queue! q 'b)
  (insert-queue! q 'c)
  (check-equal? (front-queue q) 'b)
  (delete-queue! q)
  (check-equal? (front-queue q) 'c))

(test-case "queues are independent"
  (define make-queue (solution "3.22" 'make-queue))
  (define empty-queue? (solution "3.22" 'empty-queue?))
  (define front-queue (solution "3.22" 'front-queue))
  (define insert-queue! (solution "3.22" 'insert-queue!))
  (define q1 (make-queue))
  (define q2 (make-queue))
  (insert-queue! q1 'x)
  (check-true (empty-queue? q2))
  (insert-queue! q2 'y)
  (check-equal? (front-queue q1) 'x)
  (check-equal? (front-queue q2) 'y))

(test-case "front and delete on an empty queue are errors"
  (define make-queue (solution "3.22" 'make-queue))
  (define front-queue (solution "3.22" 'front-queue))
  (define delete-queue! (solution "3.22" 'delete-queue!))
  (check-exn (lambda (e) #t) (lambda () (front-queue (make-queue))))
  (check-exn (lambda (e) #t) (lambda () (delete-queue! (make-queue)))))

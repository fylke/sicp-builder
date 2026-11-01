#lang sicp
;; Exercise 3.22
;;
;; Instead of representing a queue
;; as a pair of pointers, we can build a queue as a procedure with local state.
;; The local state will consist of pointers to the beginning and the end of an
;; ordinary list.  Thus, the `make-queue` procedure will have the form
;;
;; ```scheme
;; (define (make-queue)
;;   (let ((front-ptr … )
;;         (rear-ptr … ))
;;     ⟨definitions of internal procedures⟩
;;     (define (dispatch m) …)
;;     dispatch))
;; ```
;;
;; Complete the definition of `make-queue` and provide implementations of the
;; queue operations using this representation.

;; Test: raco test tests/chapter-3/exercise-3.22.test.rkt
;; Your exercises/chapter-3/exercise-3.22.rkt must
;;   (#%provide make-queue empty-queue? front-queue insert-queue! delete-queue!)
;;   (make-queue)            -> a new empty queue, a procedure with local state
;;                              (front-ptr and rear-ptr inside, message passing)
;;   (empty-queue? q)        -> #t if q has no items
;;   (front-queue q)         -> the first item (signal an error if q is empty)
;;   (insert-queue! q item)  -> inserts item at the rear
;;   (delete-queue! q)       -> removes the front item (signal an error if q is empty)
;; The return values of insert-queue!/delete-queue! are not checked.


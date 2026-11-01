#lang sicp
;; Exercise 3.23
;;
;; A *deque* (“double-ended
;;                                                                  queue”) is a sequence in which items can be inserted and deleted at either the
;; front or the rear.  Operations on deques are the constructor `make-deque`,
;; the predicate `empty-deque?`, selectors `front-deque` and
;; `rear-deque`, and mutators `front-insert-deque!`,
;; `rear-insert-deque!`, `front-delete-deque!`,
;; `rear-delete-deque!`.  Show how to represent deques using pairs, and give
;; implementations of the operations.[^1]
;; All operations should be accomplished in ${\Theta(1)}$ steps.
;;
;; [^1]: Be careful not to make the
;; interpreter try to print a structure that contains cycles.  (See [Exercise 3.13](../chapter-3/exercise-3.13.rkt).)

;; Test: raco test tests/chapter-3/exercise-3.23.test.rkt
;; Your exercises/chapter-3/exercise-3.23.rkt must (#%provide make-deque empty-deque?
;;   front-deque rear-deque front-insert-deque! rear-insert-deque!
;;   front-delete-deque! rear-delete-deque!)
;;   (make-deque)                 -> a new empty deque
;;   (empty-deque? d)             -> #t if d has no items
;;   (front-deque d) (rear-deque d) -> the first / last item (error if d is empty)
;;   (front-insert-deque! d item) (rear-insert-deque! d item) -> insert at that end
;;   (front-delete-deque! d) (rear-delete-deque! d) -> remove that end (error if empty)
;; Return values of the mutators are not checked.


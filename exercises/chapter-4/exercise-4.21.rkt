#lang sicp
;; Exercise 4.21
;;
;; Amazingly, Louis’s intuition in
;; [Exercise 4.20](../chapter-4/exercise-4.20.rkt) is correct.  It is indeed possible to specify recursive
;; procedures without using `letrec` (or even `define`), although the
;; method for accomplishing this is much more subtle than Louis imagined.  The
;; following expression computes 10 factorial by applying a recursive factorial
;; procedure:[^1]
;;
;; ```scheme
;; ((lambda (n)
;;    ((lambda (fact) (fact fact n))
;;     (lambda (ft k)
;;       (if (= k 1)
;;           1
;;           (* k (ft ft (- k 1)))))))
;;  10)
;; ```
;;
;; - (a) Check (by evaluating the expression) that this really does compute factorials.
;; Devise an analogous expression for computing Fibonacci numbers.
;;
;; - (b) Consider the following procedure, which includes mutually recursive internal
;; definitions:
;;
;;       ```scheme
;;       (define (f x)
;;         (define (even? n)
;;           (if (= n 0)
;;               true
;;               (odd? (- n 1))))
;;         (define (odd? n)
;;           (if (= n 0)
;;               false
;;               (even? (- n 1))))
;;         (even? x))
;;       ```
;;
;;       Fill in the missing expressions to complete an alternative definition of
;; `f`, which uses neither internal definitions nor `letrec`:
;;
;;       ```scheme
;;       (define (f x)
;;         ((lambda (even? odd?)
;;            (even? even? odd? x))
;;          (lambda (ev? od? n)
;;            (if (= n 0)
;;                true
;;                (od? ⟨??⟩ ⟨??⟩ ⟨??⟩)))
;;          (lambda (ev? od? n)
;;            (if (= n 0)
;;                false
;;                (ev? ⟨??⟩ ⟨??⟩ ⟨??⟩)))))
;;       ```
;;
;; [^1]: This example illustrates a programming trick for
;; formulating recursive procedures without using `define`.  The most general
;; trick of this sort is the $Y$ *operator*, which can be used to give a
;; “pure λ-calculus” implementation of recursion.  (See Stoy 1977 for
;; details on the λ-calculus, and Gabriel 1988 for an exposition of the
;; $Y$ operator in Scheme.)

;; No automatic test for this exercise.


#lang sicp
;; Exercise 3.9
;;
;; In 1.2.1 we used the
;; substitution model to analyze two procedures for computing factorials, a
;; recursive version
;;
;; ```scheme
;; (define (factorial n)
;;   (if (= n 1)
;;       1
;;       (* n (factorial (- n 1)))))
;; ```
;;
;; and an iterative version
;;
;; ```scheme
;; (define (factorial n)
;;   (fact-iter 1 1 n))
;;
;; (define (fact-iter product
;;                    counter
;;                    max-count)
;;   (if (> counter max-count)
;;       product
;;       (fact-iter (* counter product)
;;                  (+ counter 1)
;;                  max-count)))
;; ```
;;
;; Show the environment structures created by evaluating `(factorial 6)`
;; using each version of the `factorial` procedure.[^1]
;;
;; [^1]: The environment
;; model will not clarify our claim in 1.2.1 that the interpreter
;; can execute a procedure such as `fact-iter` in a constant amount of space
;; using tail recursion.  We will discuss tail recursion when we deal with the
;; control structure of the interpreter in 5.4.

;; No automatic test for this exercise.


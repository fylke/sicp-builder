#lang sicp
;; Exercise 5.46
;;
;; Carry out an analysis like the
;; one in [Exercise 5.45](../chapter-5/exercise-5.45.rkt) to determine the effectiveness of compiling the
;; tree-recursive Fibonacci procedure
;;
;; ```scheme
;; (define (fib n)
;;   (if (< n 2)
;;       n
;;       (+ (fib (- n 1)) (fib (- n 2)))))
;; ```
;;
;; compared to the effectiveness of using the special-purpose Fibonacci machine of
;; Figure 5.12.  (For measurement of the interpreted performance, see
;; [Exercise 5.29](../chapter-5/exercise-5.29.rkt).)  For Fibonacci, the time resource used is not linear in
;; ${n;}$ hence the ratios of stack operations will not approach a limiting value
;; that is independent of $n$.
;;
;; **Figure 5.12:** $\downarrow$ Controller for a machine to compute
;; Fibonacci numbers.
;;
;; ```scheme
;; (controller
;;    (assign continue (label fib-done))
;;  fib-loop
;;    (test (op <) (reg n) (const 2))
;;    (branch (label immediate-answer))
;;    ;; set up to compute Fib(n − 1)
;;    (save continue)
;;    (assign continue (label afterfib-n-1))
;;    (save n)           ; save old value of n
;;    (assign n
;;            (op -)
;;            (reg n)
;;            (const 1)) ; clobber n to n-1
;;    (goto
;;     (label fib-loop)) ; perform recursive call
;;  afterfib-n-1 ; upon return
;;    (restore n)
;;    (restore continue)
;;    ;; set up to compute Fib(n − 2)
;;    (assign n (op -) (reg n) (const 2))
;;    (save continue)
;;    (assign continue (label afterfib-n-2))
;;    (save val)         ; save Fib(n − 1)
;;    (goto (label fib-loop))
;;  afterfib-n-2 ; upon return
;;    (assign n
;;            (reg val)) ; n now contains Fib(n − 2)
;;    (restore val)      ; val now contains Fib(n − 1)
;;    (restore continue)
;;    (assign val        ; Fib(n − 1) + Fib(n − 2)
;;            (op +)
;;            (reg val)
;;            (reg n))
;;    (goto              ; return to caller
;;     (reg continue))   ; answer is in val
;;  immediate-answer
;;    (assign val
;;            (reg n))   ; base case: Fib(n) = n
;;    (goto (reg continue))
;;  fib-done)
;; ```

;; No automatic test for this exercise.


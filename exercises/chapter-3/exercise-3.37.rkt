#lang sicp
;; Exercise 3.37
;;
;; The
;; `celsius-fahrenheit-converter` procedure is cumbersome when compared with
;; a more expression-oriented style of definition, such as
;;
;; ```scheme
;; (define (celsius-fahrenheit-converter x)
;;   (c+ (c* (c/ (cv 9) (cv 5))
;;           x)
;;       (cv 32)))
;;
;; (define C (make-connector))
;; (define F (celsius-fahrenheit-converter C))
;; ```
;;
;; Here `c+`, `c*`, etc. are the “constraint” versions of the
;; arithmetic operations.  For example, `c+` takes two connectors as
;; arguments and returns a connector that is related to these by an adder
;; constraint:
;;
;; ```scheme
;; (define (c+ x y)
;;   (let ((z (make-connector)))
;;     (adder x y z)
;;     z))
;; ```
;;
;; Define analogous procedures `c-`, `c*`, `c/`, and `cv`
;; (constant value) that enable us to define compound constraints as in the
;; converter example above.[^1]
;;
;; [^1]: The expression-oriented format is convenient
;; because it avoids the need to name the intermediate expressions in a
;; computation.  Our original formulation of the constraint language is cumbersome
;; in the same way that many languages are cumbersome when dealing with operations
;; on compound data.  For example, if we wanted to compute the product
;; ${(a + b) \cdot (c + d)}$, where the variables represent vectors, we could work
;; in “imperative style,” using procedures that set the values of designated
;; vector arguments but do not themselves return vectors as values:
;;
;;     ```scheme
;;     (v-sum a b temp1)
;;     (v-sum c d temp2)
;;     (v-prod temp1 temp2 answer)
;;     ```
;;
;;     Alternatively, we could deal with expressions, using procedures that return
;; vectors as values, and thus avoid explicitly mentioning `temp1` and
;; `temp2`:
;;
;;     ```scheme
;;     (define answer
;;       (v-prod (v-sum a b) (v-sum c d)))
;;     ```
;;
;;     Since Lisp allows us to return compound objects as values of procedures, we can
;; transform our imperative-style constraint language into an expression-oriented
;; style as shown in this exercise.  In languages that are impoverished in
;; handling compound objects, such as Algol, Basic, and Pascal (unless one
;; explicitly uses Pascal pointer variables), one is usually stuck with the
;; imperative style when manipulating compound objects.  Given the advantage of
;; the expression-oriented format, one might ask if there is any reason to have
;; implemented the system in imperative style, as we did in this section.  One
;; reason is that the non-expression-oriented constraint language provides a
;; handle on constraint objects (e.g., the value of the `adder` procedure) as
;; well as on connector objects.  This is useful if we wish to extend the system
;; with new operations that communicate with constraints directly rather than only
;; indirectly via operations on connectors.  Although it is easy to implement the
;; expression-oriented style in terms of the imperative implementation, it is very
;; difficult to do the converse.

;; Test: raco test tests/chapter-3/exercise-3.37.test.rkt
;; Your exercises/chapter-3/exercise-3.37.rkt must (#%provide make-connector set-value!
;;   get-value has-value? forget-value! c+ c- c* c/ cv)
;; The constraint system of section 3.3.5 is NOT part of the exercise: copy the book's
;; code (connectors, adder, multiplier, constant, ...) into your file and add the
;; expression-oriented operators:
;;   (c+ x y) (c- x y) (c* x y) (c/ x y)  -> a new connector constrained to x+y, x-y, x*y, x/y
;;   (cv value)                           -> a new connector holding the constant value
;;   (make-connector) (set-value! connector n informant) (get-value c) (has-value? c)
;;   (forget-value! c retractor)          -> as in the book


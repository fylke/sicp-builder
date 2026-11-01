#lang sicp
;; Exercise 4.8
;;
;; “Named `let`” is a variant
;; of `let` that has the form
;;
;; ```scheme
;; (let ⟨var⟩ ⟨bindings⟩ ⟨body⟩)
;; ```
;;
;; The `⟨`*bindings*`⟩` and `⟨`*body*`⟩` are just as in ordinary `let`,
;; except that `⟨`*var*`⟩` is bound within `⟨`*body*`⟩` to a procedure whose body
;; is `⟨`*body*`⟩` and whose parameters are the variables in the `⟨`*bindings*`⟩`.
;; Thus, one can repeatedly execute the `⟨`*body*`⟩` by invoking the procedure
;; named `⟨`*var*`⟩`.  For example, the iterative Fibonacci procedure
;; (1.2.2) can be rewritten using named `let` as follows:
;;
;; ```scheme
;; (define (fib n)
;;   (let fib-iter ((a 1) (b 0) (count n))
;;     (if (= count 0)
;;         b
;;         (fib-iter (+ a b)
;;                   a
;;                   (- count 1)))))
;; ```
;;
;; Modify `let->combination` of [Exercise 4.6](../chapter-4/exercise-4.06.rkt) to also support named
;; `let`.

;; Test: raco test tests/chapter-4/exercise-4.08.test.rkt
;; let->combination: (let->combination exp) expands ordinary let and named let; named let becomes a letrec with a lambda binding and initial call.
;; The named-let expansion relies on the evaluator supporting letrec (as derived in Exercise 4.20).


#lang sicp
;; Exercise 3.54
;;
;; Define a procedure
;; `mul-streams`, analogous to `add-streams`, that produces the
;; elementwise product of its two input streams.  Use this together with the
;; stream of `integers` to complete the following definition of the stream
;; whose $n^{\text{th}}$ element (counting from 0) is ${n + 1}$ factorial:
;;
;; ```scheme
;; (define factorials
;;   (cons-stream 1 (mul-streams ⟨??⟩ ⟨??⟩)))
;; ```

;; Test: raco test tests/chapter-3/exercise-3.54.test.rkt
;; Your exercises/chapter-3/exercise-3.54.rkt must (#%provide mul-streams factorials)
;;   (mul-streams s1 s2)  -> the stream of elementwise products
;;   factorials           -> the stream 1, 2, 6, 24, 120, ... (element n, from 0, is (n+1)!)
;; Define add-streams, integers, stream-car/stream-cdr, etc. yourself in the file.


#lang sicp
;; Exercise 3.50
;;
;; Complete the following
;; definition, which generalizes `stream-map` to allow procedures that take
;; multiple arguments, analogous to `map` in 2.2.1,
;; Footnote 78.
;;
;; ```scheme
;; (define (stream-map proc . argstreams)
;;   (if (⟨??⟩ (car argstreams))
;;       the-empty-stream
;;       (⟨??⟩
;;        (apply proc (map ⟨??⟩ argstreams))
;;        (apply stream-map
;;               (cons proc
;;                     (map ⟨??⟩
;;                          argstreams))))))
;; ```

;; Test: raco test tests/chapter-3/exercise-3.50.test.rkt
;; Your exercises/chapter-3/exercise-3.50.rkt must (#%provide stream-map)
;;   (stream-map proc s1 s2 ...) -> the stream of (proc x1 x2 ...) over the elements of the
;;       argument streams, stopping when the first stream runs out; with one stream it is
;;       the ordinary stream-map. It must be lazy (use cons-stream).
;; Define stream-car / stream-cdr yourself in the file (this language does not have them);
;; streams here are pairs whose cdr is a promise: (car s) and (force (cdr s)).


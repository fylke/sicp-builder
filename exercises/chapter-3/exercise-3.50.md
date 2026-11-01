# Exercise 3.50

Complete the following
definition, which generalizes `stream-map` to allow procedures that take
multiple arguments, analogous to `map` in 2.2.1, 
Footnote 78.

```scheme
(define (stream-map proc . argstreams)
  (if (⟨??⟩ (car argstreams))
      the-empty-stream
      (⟨??⟩
       (apply proc (map ⟨??⟩ argstreams))
       (apply stream-map
              (cons proc 
                    (map ⟨??⟩ 
                         argstreams))))))
```

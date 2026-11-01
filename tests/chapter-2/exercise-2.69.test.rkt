#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.69.rkt must (#%provide generate-huffman-tree encode decode)
;;   (generate-huffman-tree pairs) -- the Huffman tree for a list of (symbol frequency) pairs
;;   (encode message tree)         -- list of bits encoding a list of symbols with tree
;;   (decode bits tree)            -- list of symbols decoded from a list of bits with tree
;; Define successive-merge and make-leaf-set as well as encode, decode (and encode-symbol)
;; from the previous exercises and the Huffman tree representation of section 2.3.4 in your file.
;; The tests only check round trips and the optimal total length, so tie-breaking is up to you.

(define (repeat-symbol s n)
  (if (= n 0) '() (cons s (repeat-symbol s (- n 1)))))

(define (message-for pairs)
  (if (null? pairs)
      '()
      (append (repeat-symbol (car (car pairs)) (cadr (car pairs)))
              (message-for (cdr pairs)))))

(define (check-round-trip pairs)
  (let* ((gen (solution "2.69" 'generate-huffman-tree))
         (enc (solution "2.69" 'encode))
         (dec (solution "2.69" 'decode))
         (tree (gen pairs))
         (message (message-for pairs)))
    (check-equal? (dec (enc message tree) tree) message)
    (let loop ((ps pairs))
      (if (not (null? ps))
          (begin
            (check-equal? (dec (enc (list (car (car ps))) tree) tree)
                          (list (car (car ps))))
            (loop (cdr ps)))))))

(define (total-bits pairs)
  (define generate-huffman-tree (solution "2.69" 'generate-huffman-tree))
  (define encode (solution "2.69" 'encode))
  (length (encode (message-for pairs) (generate-huffman-tree pairs))))

(test-case "four symbols round trip"
  (check-round-trip '((A 4) (B 2) (C 1) (D 1))))

(test-case "the alphabet of Figure 2.18 round trips"
  (check-round-trip '((A 8) (B 3) (C 1) (D 1) (E 1) (F 1) (G 1) (H 1))))

(test-case "two symbols"
  (check-round-trip '((X 3) (Y 5)))
  (check-equal? (total-bits '((X 3) (Y 5))) 8))

(test-case "unsorted input is handled"
  (check-round-trip '((D 1) (A 4) (C 1) (B 2))))

(test-case "frequent symbols get shorter codes (optimal length)"
  (check-equal? (total-bits '((A 4) (B 2) (C 1) (D 1))) 14)
  (check-equal? (total-bits '((A 8) (B 3) (C 1) (D 1) (E 1) (F 1) (G 1) (H 1))) 41)
  (check-equal? (total-bits '((A 1) (B 1) (C 1) (D 1) (E 1) (F 1) (G 1) (H 1))) 24))

(test-case "the most frequent symbol has a one-bit code"
  (define generate-huffman-tree (solution "2.69" 'generate-huffman-tree))
  (define encode (solution "2.69" 'encode))
  (define tree (generate-huffman-tree '((A 8) (B 3) (C 1) (D 1) (E 1) (F 1) (G 1) (H 1))))
  (check-equal? (length (encode '(A) tree)) 1))

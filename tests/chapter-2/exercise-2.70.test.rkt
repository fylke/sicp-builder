#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.70.rkt must (#%provide generate-huffman-tree encode decode)
;;   (generate-huffman-tree pairs) -- the Huffman tree for a list of (symbol frequency) pairs
;;   (encode message tree)         -- list of bits encoding a list of symbols with tree
;;   (decode bits tree)            -- list of symbols decoded from a list of bits with tree
;; Define these (with the Huffman tree representation and the code of Exercises 2.67-2.69)
;; in your file. The tests build the rock-song tree from the alphabet of the exercise,
;; encode the song, and check the number of bits (84) and that decoding gives the song back.

(define rock-pairs
  '((A 2) (NA 16) (BOOM 1) (SHA 3) (GET 2) (YIP 9) (JOB 2) (WAH 1)))

(define song
  '(GET A JOB
    SHA NA NA NA NA NA NA NA NA
    GET A JOB
    SHA NA NA NA NA NA NA NA NA
    WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP
    SHA BOOM))

(test-case "the song has 36 symbols and the tree covers the alphabet"
  (define generate-huffman-tree (solution "2.70" 'generate-huffman-tree))
  (define encode (solution "2.70" 'encode))
  (check-equal? (length song) 36)
  (check-equal? (length (encode '(NA) (generate-huffman-tree rock-pairs))) 1))

(test-case "the encoded song takes 84 bits"
  (define generate-huffman-tree (solution "2.70" 'generate-huffman-tree))
  (define encode (solution "2.70" 'encode))
  (define tree (generate-huffman-tree rock-pairs))
  (check-equal? (length (encode song tree)) 84))

(test-case "decoding the encoded song gives the song back"
  (define generate-huffman-tree (solution "2.70" 'generate-huffman-tree))
  (define encode (solution "2.70" 'encode))
  (define decode (solution "2.70" 'decode))
  (define tree (generate-huffman-tree rock-pairs))
  (check-equal? (decode (encode song tree) tree) song))

(test-case "bits are only 0 and 1 and the frequent NA is short"
  (define generate-huffman-tree (solution "2.70" 'generate-huffman-tree))
  (define encode (solution "2.70" 'encode))
  (define tree (generate-huffman-tree rock-pairs))
  (check-equal? (length (encode '(NA) tree)) 1)
  (check-equal? (length (encode '(YIP) tree)) 2)
  (check-true (let loop ((bs (encode song tree)))
                (or (null? bs)
                    (and (or (= (car bs) 0) (= (car bs) 1)) (loop (cdr bs)))))))

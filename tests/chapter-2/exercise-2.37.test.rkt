#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.37.rkt must (#%provide dot-product matrix-*-vector
;;                                                  transpose matrix-*-matrix)
;;   (dot-product v w)       -- sum of v_i * w_i
;;   (matrix-*-vector m v)   -- the vector t with t_i = sum_j m_ij v_j
;;   (transpose m)           -- the matrix n with n_ij = m_ji
;;   (matrix-*-matrix m n)   -- the matrix product
;; Matrices are lists of rows (lists). You must define accumulate and accumulate-n yourself;
;; they are not tested here.

(define m '((1 2 3 4) (4 5 6 6) (6 7 8 9)))

(test-case "dot-product"
  (define dot-product (solution "2.37" 'dot-product))
  (check-equal? (dot-product '(1 2 3) '(4 5 6)) 32)
  (check-equal? (dot-product '() '()) 0)
  (check-equal? (dot-product '(1 0 0) '(0 1 0)) 0))

(test-case "matrix-*-vector"
  (define matrix-*-vector (solution "2.37" 'matrix-*-vector))
  (check-equal? (matrix-*-vector m '(1 0 2 1)) '(11 22 31))
  (check-equal? (matrix-*-vector '((1 0) (0 1)) '(7 8)) '(7 8))
  (check-equal? (matrix-*-vector '((2 3)) '(4 5)) '(23)))

(test-case "transpose"
  (define transpose (solution "2.37" 'transpose))
  (check-equal? (transpose m) '((1 4 6) (2 5 7) (3 6 8) (4 6 9)))
  (check-equal? (transpose '((1 2) (3 4))) '((1 3) (2 4)))
  (check-equal? (transpose '((1 2 3))) '((1) (2) (3))))

(test-case "matrix-*-matrix, square"
  (define matrix-*-matrix (solution "2.37" 'matrix-*-matrix))
  (check-equal? (matrix-*-matrix '((1 2) (3 4)) '((5 6) (7 8))) '((19 22) (43 50)))
  (check-equal? (matrix-*-matrix '((1 2) (3 4)) '((1 0) (0 1))) '((1 2) (3 4))))

(test-case "matrix-*-matrix, rectangular"
  (define matrix-*-matrix (solution "2.37" 'matrix-*-matrix))
  (check-equal? (matrix-*-matrix '((1 2 3) (4 5 6)) '((7 8) (9 10) (11 12)))
                '((58 64) (139 154)))
  (check-equal? (matrix-*-matrix '((1 2 3 4) (4 5 6 6) (6 7 8 9)) '((1) (0) (2) (1)))
                '((11) (22) (31))))

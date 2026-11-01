#lang sicp
(#%provide make-interval lower-bound upper-bound mul-interval)

(define (make-interval a b) (cons a b))
(define (lower-bound i) (car i))
(define (upper-bound i) (cdr i))

(define (mul-interval x y)
  (let ((xl (lower-bound x)) (xu (upper-bound x))
        (yl (lower-bound y)) (yu (upper-bound y)))
    (cond ((>= xl 0)
           (cond ((>= yl 0) (make-interval (* xl yl) (* xu yu)))
                 ((<= yu 0) (make-interval (* xu yl) (* xl yu)))
                 (else (make-interval (* xu yl) (* xu yu)))))
          ((<= xu 0)
           (cond ((>= yl 0) (make-interval (* xl yu) (* xu yl)))
                 ((<= yu 0) (make-interval (* xu yu) (* xl yl)))
                 (else (make-interval (* xl yu) (* xl yl)))))
          (else
           (cond ((>= yl 0) (make-interval (* xl yu) (* xu yu)))
                 ((<= yu 0) (make-interval (* xu yl) (* xl yl)))
                 (else (make-interval (min (* xl yu) (* xu yl))
                                      (max (* xl yl) (* xu yu)))))))))

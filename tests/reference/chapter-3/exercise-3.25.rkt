#lang sicp
(#%provide make-table lookup insert!)

;; A node is (key record child ...), where record is a pair (has-value? . value).
;; The table itself is the root node.
(define (new-node key) (list key (cons #f #f)))
(define (node-record n) (cadr n))
(define (node-children n) (cddr n))

(define (make-table) (new-node '*table*))

(define (find-child key children)
  (cond ((null? children) #f)
        ((equal? key (car (car children))) (car children))
        (else (find-child key (cdr children)))))

(define (lookup keys table)
  (define (walk keys node)
    (if (null? keys)
        (if (car (node-record node)) (cdr (node-record node)) #f)
        (let ((child (find-child (car keys) (node-children node))))
          (if child (walk (cdr keys) child) #f))))
  (walk keys table))

(define (insert! keys value table)
  (define (walk keys node)
    (if (null? keys)
        (begin (set-car! (node-record node) #t)
               (set-cdr! (node-record node) value))
        (let ((child (find-child (car keys) (node-children node))))
          (if child
              (walk (cdr keys) child)
              (let ((new (new-node (car keys))))
                (set-cdr! (cdr node) (cons new (node-children node)))
                (walk (cdr keys) new))))))
  (walk keys table)
  'ok)

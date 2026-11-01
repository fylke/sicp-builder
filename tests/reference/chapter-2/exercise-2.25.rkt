#lang sicp
(#%provide seven-a seven-b seven-c)

(define (seven-a l) (car (cdr (car (cdr (cdr l))))))
(define (seven-b l) (car (car l)))
(define (seven-c l) (cadr (cadr (cadr (cadr (cadr (cadr l)))))))

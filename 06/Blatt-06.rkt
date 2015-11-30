#lang racket

(require racket/trace)

(define (insertion-sort list)
  (cond [(> (length list) 2) (insertion-sort_h (cons (car list) '() ) (rest list))]
        [else list])
  )

(define (insertion-sort_h sorted tail)
  (cond
    [(null? tail) sorted]
    [(null? sorted) (insertion-sort_h (cons (car tail) '()) (rest tail))]
    [(<= (last sorted)(car tail) )
          (insertion-sort_h
           (reverse (cons (car tail) (reverse sorted)))
           (cdr tail)
           )]
    [else (insertion-sort_h
           (reverse (cdr (reverse sorted)))
           (cons (car tail) (cons (last sorted) (rest tail)))
           )]))

(trace insertion-sort_h)

(define (sort-icons list)
  (sort-icons_h
   (map car list)
   list))

(define (sort-icons_h liste-zahlen liste-tupel)
 (map
  (lambda  (sortedElement) (last (assoc sortedElement liste-tupel) ))
  (insertion-sort liste-zahlen))
  )
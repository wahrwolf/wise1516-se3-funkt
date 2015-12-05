#lang racket

; wrapper für Berechnung des Intervals,
; erechnet die Schrittgroesse die statt n weitergegeben wird.
; Auskommentierte Zeile startet nicht-endrekursive berreechnung
; bzw berechnung mittels Funktionen hoeherer Ordnung
(define (range interval n)
  (if (null? interval)
      '()
      (let ([schrittgroesse (/ (- (cdr interval) (car interval)) n) ])
       ;(rangeend_help interval schrittgroesse '())
      ;(interval_help interval schrittgroesse)
       (build-list n (lambda (x) (* schrittgroesse x)))
        )))

#| Tests höherer Ordnung
> (range (cons 0 11) 5)
'(0 2 1/5 4 2/5 6 3/5 8 4/5)
> (range (cons 0 1) 5)
'(0 1/5 2/5 3/5 4/5)
|#

;einfach-rekursive Berechnung vom Interval
(define (interval_help range schritt)
  (if (equal? (cdr range) (car range))
      '()
      (cons (car range) (interval_help (cons (+ (car range) schritt) (cdr range))  schritt))))
#| Tests:
> (range (cons 0 10) 5)
'(0 2 4 6 8)
> (range (cons 0 11) 5)
'(0 2 1/5 4 2/5 6 3/5 8 4/5)
|#

;endrekursive Berechnung von interval
(define (rangeend_help interval schritt akk)
  (if (equal? (cdr interval) (car interval))
       (reverse  akk)
      (let ([new_interval (cons (+ (car interval) schritt) (cdr interval))]
            [new_akk (cons (car interval) akk)])
        (rangeend_help new_interval schritt new_akk))))
#| Tests:
> (range (cons 0 2) 5)
'(0 2/5 4/5 1 1/5 1 3/5)
> (range (cons 0 1) 10)
'(0 1/10 1/5 3/10 2/5 1/2 3/5 7/10 4/5 9/10)
|#


;########Aufgabe 2#########
;2.1 
(define (function->points func interval n)
  (map (lambda (x)(cons x (func x))) (range interval n)))
#|Tests
> (function->points sqr (cons 0 10) 5)
'((0 . 0) (2 . 4) (4 . 16) (6 . 36) (8 . 64))
|#

; 2.2
(define (rescale1d range new_scale)
  (map (lambda (x) (+ (* (/ (- x (car range))
                            (-  (last range) (car range)))
                         (-  (cdr new_scale)  (car new_scale)))
                      (car new_scale))) range))
#|Tests
> (rescale1d '(1 1 3 4) (cons 1 10))
'(1 1 7 10)
> (rescale1d '(1 1) (cons 0 10))
. . /: division by zero
> (rescale1d '(1 2 7) (cons 0 10))
'(0 1 2/3 10)
> (rescale1d '(0 1 1 3 4 10) (cons 0 10))
'(0 1 1 3 4 10)
|#
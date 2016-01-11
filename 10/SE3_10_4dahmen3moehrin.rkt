#lang racket

;--------------------------------
;----------- SODOKU -------------
;--------------------------------

(define spiel1 #(0 0 0 0 0 9 0 7 0
                 0 0 0 0 8 2 0 5 0
                 3 2 7 0 0 0 0 4 0
                 0 1 6 0 4 0 0 0 0
                 0 5 0 0 0 0 3 0 0
                 0 0 0 0 9 0 7 0 0
                 0 0 0 6 0 0 0 0 5
                 8 0 2 0 0 0 0 0 0
                 0 0 4 2 0 0 0 0 8))

;;;Aufgabe 1.1
(define (xy->index x y)
  ( + x ( * y 9)))


;;;Aufgabe 1.2

; Die erste Zeile elementeweise addiert mit offset
(define (zeile->indizes zeile)
  (map (lambda (z) (+ (* zeile 9 ) z)) '(0 1 2 3 4 5 6 7 8)))

; Die erste Spalte elementeweise addiert mit offset
(define (spalte->indizes spalte)
  (map (curry + spalte) '(0 9 18 27 36 45 54 63 72)))

;Erster Quadrant wird mit offset addiert
;offset berechnet sich durch 3* (index im 1. Quadrant an der Stelle wo der gesuchte Quadrant im gesamtpuzzle auftaucht.)
;Daher kann man die indizes in list dopperlt benutzen
(define (quadrant->indizes quadrant)
  (let ([list '(0 1 2 9 10 11 18 19 20)])
    (map (curry + (* 3 (list-ref list quadrant))) list)))


;;;Aufgabe 1.3
;holt sich jeweils fr jeden Index den Wert aus dem Vektor
(define (spiel->eintraege spiel indizes)
  (map (lambda (x) (vector-ref spiel x)) indizes))


;--------------------------------
;--------Aufgabe 2 --------------
;--------------------------------

;;;1.1

;a) -1
;b) -geqoutet wird nicht ausgewertet,
;c) 'Alle
;d) '(auf (dem See))
;e) '(Listen sind einfach)
;f) '(Paare . auch)
;g) #t
;h) #f ---> warum ? eq?, auswertung
;i) '(1 8 27) ---->gibt immer listen
;j) '(1 3 5)
;k) 2
;l) #t

;;;1.2
;a) 10
;b) contract violation - symbole und zahlen können nicht addiert werden
;c) 20
;d) #f
;e) fehler
;f) fehler klammer um merke zu wenig
;g) 5
;h) 16

;;;1.3
;a)
(+ (* 3 4) (* 5 6))
;b)
;(sqrt (- 1 (sqr (sin x))))

;;;1.4
;a)
(define (c a b)
  (if (and (real? a)(real? b))
  (sqrt (+ (sqr a)(sqr b)))
  (display "either a or b are not real")))

;b)
(define (mytan alpha)
  (if (and (< alpha (/ pi -2))( < alpha (/ pi 2)) )
(/ (sin alpha)(sqrt (- 1 (sqr alpha))))
  (display "your alpha is out of bounds")))

;;;1.5
;a)
(- ( + 1 (/ 4 2)) 1)
;b)
(/ (- 2 (/ (+ 1 3) (+ 3 (* 2 3)))) (sqrt 3))

;;;1.6
;(1 + 2 + 3)*(2 - 3 - (2 - 1))

;;;1.7
#|
a)
bei innerer Reduktion werden Ausdrücke gemäß iherer Verschachtelung von
innen nach außen ausgewertet. Bei äußerer Auswertung werden die Audrücke
 ungeachtet ihrer verschachtelung von links nach rechts ausgewertet.

b)
Wenn ein gemäß der Verschachtelung genutzer Ausdruck erst weiter hinten in der
Ausführungsreihenfolge steht so kann es sein das innere und äußer Reduktion nicht
zum gleichen Ergebnis kommen.

-----> recherchieren sprachelemente
|#

;;;1.8
;misst die Länge von Unterlisten rekursiv
(define (laengen xss)
  (if (null? xss) '()
      (cons (length (car xss))(laengen (cdr xss)))))

;Wrapper für endrekursive Berechnung der Unterlisten
(define (laengen2 xss )
  (if (null? xss) '()
      (reverse (laengen_er '() xss))))

(define (laengen_er akkum xss)
  (if (null? xss) akkum
      (laengen_er (cons (length (car xss)) akkum) (cdr xss)))) 

  
;;;1.9
;a)
(define (make-length value unit)
  (list value unit))
;b)

(define (value-of-length len)
  (car len))

(define (unit-of-length len)
  (cadr len))

;c)
(define (scale-length len fac)
  (make-length (* fac (value-of-length len))(unit-of-length len)))

(value-of-length (scale-length (make-length 3 'cm) 2))

;d)
(define *conversiontable* 
'( ; (unit . factor)
(m . 1)
(cm . 0.01)
(mm . 0.001)
(km . 1000)
(inch . 0.0254)
(feet . 0.3048)
(yard . 0.9144)))

(define (factor unit)
  (
   cdr (assoc unit *conversiontable*)
   ))

(define (length->meter len )
  (make-length ( * (value-of-length len)(factor (unit-of-length len))) 'm)
  )

(define (length< len1 len2)
  (let ([x (length->meter len1)]
        [y (length->meter len2)])
    (< (value-of-length x)(value-of-length y))
    ))
(define (length= len1 len2)
  (let ([x (length->meter len1)]
        [y (length->meter len2)])
    (= (value-of-length x)(value-of-length y))
    ))

(define (length+ len1 len2)
  (let ([x (length->meter len1)]
        [y (length->meter len2)])
    (make-length (+ (value-of-length x)(value-of-length y)) 'm)
    ))

(define (length- len1 len2)
  (let ([x (length->meter len1)]
        [y (length->meter len2)])
    (make-length (- (value-of-length x)(value-of-length y)) 'm)
    ))

(define laengenangaben '((6 km) (2 feet) (1 cm) (3 inch)))

; Abbildung der Liste auf eine Liste in Metern
(map length->meter laengenangaben)

;Liste aller Laengen die kürzer als 1m sind
(filter (curryr length< '(1 m)) laengenangaben)

; Summe der Laengenangaben in metern
(length->meter (foldl length+ '(0 m) laengenangaben))

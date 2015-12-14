#lang racket

; Aufgabe 1.1
; Alle Funktionen die eine Funktion als Parameter oder Ausgabe haben, sind Funktionen höherer Ordnung


; Aufgabe 1.2
;  Aufgabe| höhere Ordnung 	| Begründug
;-----------------------------------------------------------------------------------------
; 	a | Ja 			| Erstes Argument is vom Typ #procedure also eine Funktion
;-----------------------------------------------------------------------------------------
; 	b | Ja 			| Rückgabe von car oder cdr, welches beide Funktionen sind
;-----------------------------------------------------------------------------------------
; 	c | Ja 			| Im Aufruf von lambda wird der Parameter f als Funktion unifiziert,
;        			    | also nimmt pepper eine Funktion als Parameter,
; 				| also ist pepper eine Funktion höherer Ordnung
;-----------------------------------------------------------------------------------------
; 	d | Nein 		| Die lezte Funktion (/) gibt eine Zahl zurück.
;-----------------------------------------------------------------------------------------


; Aufgabe 1.3:

; Zunächst wird f an max gebunden
; Anschließend wird arg1 wird an 5 gebunden.
; Nun wird eine anonyme Funktion im Kontext von pepper instanziert.
; Diese kennt alle globalen Bindungen, sowie die lokalen Bindungen f und arg1.
; Damit ist die Rückgabe der Funktion eine closure welche die anonyme Funktion
; und die Bindungen der Variablen f und arg1 enthält


; Aufgabe 1.4:
;-----------------------------------------------------------------------------------------
; Ausdruck| Rückgabewert 	| Begründug
;======================================================================================== 
; 	1 | (/ 2 3) = (2/3)	|  foldl rechnet quasi ((2/x)/y) wobei x der Akkumulator ist
;           			|  initialisiert mit 1. y ist das jeweils erste Listenelementg
; 				| > (/ 2 1 1) 
; 				| 2
; 				| > (/ 2 2 1)
; 				| 1
; 				| > (/ 2 1 2)
; 				| 1
; 				| > (/ 2 1 3)
; 				| 2/3
;-----------------------------------------------------------------------------------------
; 	2 | '((1 . 1) (2 . 2) (3 . 3) (4 . 4))
;                               | wendet cons auf alle Listenelemente mit jeweils gleichen
;                               | Index an, dementsprechend werden hier die Tupel gebildet.
;                               | Das Ergebnis von map ist immer ein Liste wo das Element
;                               | mit index i dem entspricht was bei Anwendung der Funktion
;                               | (hier cons) bei den i-ten Elementen heraus kommt.
;-----------------------------------------------------------------------------------------
; 	3 | '((a b) (()))	| filter durchsucht die Liste nach Elementen die ein Pair sind
;                               | Ergebnis sind also alle Elemente der Liste auf die pair?
; 	 	 		| true auswertet in einer Liste. 
;-----------------------------------------------------------------------------------------
; 	4 | '(9941.0 212.0 32 33.8 1832.0 -459.66999999999996)
;                               |wendet auf jedes Listenelement x die Hintereinanderausführung
;                               | ((x * 1.8) +32) an
;-----------------------------------------------------------------------------------------

; Aufgabe 1.5
; die Funktion konvertiert Celsius zu Farenheit,
; Umwandlung zurück:
(define (farenheit->celcius list)
  (map (lambda (x)
         (/(- x 32)1.8))
       list))


; Aufgabe 2
; 1: führe die funktion sqr für alle elemente der Liste xs aus
(define (list->sqr xs)
  (map sqr xs))

; 2: filtere alle Zahlen die nicht durch 3 teilbar sind heraus
(define (list->3teilbar xs)
  (filter (lambda (x) (= (modulo x 3) 0)) xs))

; 3: Bilde die summe über die gefilterete Liste,
(define (list->sum10 xs)
  (foldl + 0 (filter (lambda (x) (and
                                  (> x 10) ;die größer als 10
                                (odd? x))) ;und ungerade sind
                     xs)))
; Aufgabe 3:
(require racket/set)

; 3.1
; Eine einzelne Spielkarte wird als Liste ihrer Eigenschaften mit einer festen Reihenfolge
; im Format '(number pattern mode color) dargestellt.
; Um eine Karte darzustellen benutzen wir folgede Hilfsfunktion:

; Hilfsfunktion um eine Karte als Bild darzustellen
(define (list->card xs)
  (show-set-card (first xs) (second xs) (third xs) (fourth xs)))


; So lassen sich die Karten schnell und einfach verarbeiten und vergleichen
; Zum erstellen der Karten kann man auf einfache Funktionen wie cartesian-product
; zugreifen.
; Da die Eigenschaften jeweils als einzelne Symbole (wie sie auch von show-set-card
; benötigt werden) vorliegen, lassen sich mithilfe von sets einfach auf Gleichheit testen.


; 3.2
;
(require "setkarten-module.rkt")

;Definiere die Listen mit den Eigenschaften der Karten
(define the-pattern '(waves oval rectangle))
(define the-mode '(outline solid hatched))
(define the-color '(red green blue))
(define the-n '(1 2 3))


; die gesamte anzahl an möglichen Karten ist das car. Produkt der Eigenschaften
(define the-set (cartesian-product the-n the-pattern the-mode the-color))

; und ist natürlich auch als Liste von Bildern verfügbar
(define the-set-img (map list->card the-set))

; 3.3
(define (is-a-set? xs ys zs)
  ; Ein trippel ist dann ein set wenn für jede Eigenschaft
  ; die "set-Regel" erfüllt wurde
	(foldl (lambda (a b) (and a b)) #t ;vernküpft das ergebnis er überprüfung mit und
		(map (lambda (x y  z) 
		(let ([tripel (set x y z)])
		 (or
			(= (set-count tripel) 1) ;entweder alle einträge sind gleich
			(= (set-count tripel) 3) ;oder alle sind verschieden
		 )))
		xs ys zs)
	)
)

; 3.4 (Bonus)
;mische alle Karten und ziehe 12 Stück
(define (draw-cards card-set)
	(take (shuffle card-set) 12))

(define (get-sets handcards)
    (filter (lambda (xs)
               (let ([x (first xs)] [y (second xs)] [z (third xs)])
                 (and ;ein set ist gefunden worden wenn
                    (= 3 (set-count (set x y z))) ; die drei vergleichenden karten unterschiedlich sind
                    (is-a-set? x y z)) ; und sie ein set sind
                   ))
             (cartesian-product handcards handcards handcards) ; berechne sämtliche kombinationsmöglichkeiten
      ))

(define (clean-sets sets)
  ;entfernt doppelte elemente
  ; zwei tripel sind identisch wenn das eine eine permutation des anderen istS
  (remove-duplicates
   (map (lambda (xs) (map list->card xs)) sets)
                     (lambda (x y) 
                       (member y (permutations x)))))

(define play-sets
  (clean-sets (get-sets (draw-cards the-set))))
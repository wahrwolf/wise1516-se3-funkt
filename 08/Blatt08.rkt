#lang racket

; Aufgabe 1
; Alle Funktionen die eine Funktion als Parameter oder Ausgabe haben, sind Funktionen höherer Ordnung


; Aufgabe 2
;  Aufgabe| höhere Ordnung 	| Begründug
;-----------------------------------------------------------------------------------------
; 	a | Ja 			| Erstes Argument is vom Typ #procedure also eine Funktion
;-----------------------------------------------------------------------------------------
; 	b | Ja 			| Rückgabe von car oder cdr, welches beide Funktionen sind
;-----------------------------------------------------------------------------------------
; 	c | Ja 			| Im Aufruf von lambda wird der Parameter f als Funktion unifiziert,; 				    | also nimmt pepper eine Funktion als Parameter,
; 				| also ist pepper eine Funktion höherer Ordnung
;-----------------------------------------------------------------------------------------
; 	d | Nein 		| Die lezte Funktion (/) gibt eine Zahl zurück.
;-----------------------------------------------------------------------------------------


; Aufgabe 3:

; Zunächst wird f an max gebunden
; Anschließend wird arg1 wird an 5 gebunden.
; Nun wird eine anonyme Funktion im Kontext von pepper instanziert.
; Diese kennt alle globalen Bindungen, sowie die lokalen Bindungen f und arg1.


; Aufgabe 4:
;-----------------------------------------------------------------------------------------
; Ausdruck| Rückgabewert 	| Begründug
;======================================================================================== 
; 	1 | (/ 2 3) 		|  
; 				| > (/ 2 1 1) 
; 				| 2
; 				| > (/ 2 2 1)
; 				| 1
; 				| > (/ 2 1 2)
; 				| 1
; 				| > (/ 2 1 3)
; 				| 2/3
;-----------------------------------------------------------------------------------------
; 	2 |  			| Rückgabe von car oder cdr, welches beide Funktionen sind
;-----------------------------------------------------------------------------------------
; 	3 |  			|
;-----------------------------------------------------------------------------------------
; 	4 | 	 		| 
;-----------------------------------------------------------------------------------------

; Aufbae 2
; 1-> map
; 2-> drop (siehe list funktionen)
; foldl + drop + drop

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

(define (play-set cardbase)
	(list->set ; filtere doppelte heraus
    (map (lambda (xs)
               (let ([x (first xs)] [y (second xs)] [z (third xs)])
                (if (and ;ein set ist gefunden worden wenn
                    (= 3 (set-count (set x y z))) ; die drei vergleichenden karten unterschiedlich sind
                    (is-a-set? x y z)) ; und sie ein set sind
                   (map list->card (list x y z)) ;wandle die Karten in Bilder um
                   null)))
             (let ([handcards (draw-cards cardbase)]) ; ziehe 12 Karten
             (cartesian-product handcards handcards handcards))))) ; berechne sämtliche kombinationsmöglichkeiten
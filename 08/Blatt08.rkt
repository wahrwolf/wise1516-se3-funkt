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
; 

; 3.2
;
(require "setkarten-module.rkt")
 
(define the-pattern '(waves oval rectangle))
(define the-mode '(outline solid hatched))
(define the-color '(red green blue))
(define the-n '(1 2 3))

(define (list->card xs)
  (show-set-card (first xs) (second xs) (third xs) (fourth xs)))

(define the-set (cartesian-product the-n the-pattern the-mode the-color))

; 3.3
(define (is-a-set? xs ys zs)
	(foldl (lambda (a b) (and a b)) #t
		(map (lambda (x y  z) 
		(let ([tripel (set x y z)])
		 (or
			(= (set-count tripel) 1)
			(= (set-count tripel) 3)
		 )))
		xs ys zs)
	)
)

; 3.4 (Bonus)
(define (draw-cards card-set)
	(take (shuffle card-set) 12))

(define (play-set cardbase)
	(list->set
    (map (lambda (xs)
               (let ([x (first xs)] [y (second xs)] [z (third xs)])
                (if (and
                    (= 3 (set-count (set x y z)))
                    (is-a-set? x y z))
                   (map list->card (list x y z))
                   null)))
             (let ([handcards (draw-cards cardbase)])
             (cartesian-product handcards handcards handcards)))))
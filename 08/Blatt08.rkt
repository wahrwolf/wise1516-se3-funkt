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
; sortierte Liste irgendwie siehe absprachet :

; 3.3
(define (is-a-set? xs ys zs)
	(foldl and 
		(map (lambda (x y  z) 
		(let (head (set x y z))
		 (or
			(= (set-count head) 1)
			(= (set-count head) 3)
		 )))
		xs ys zs)
	)
)


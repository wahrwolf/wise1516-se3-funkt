#lang racket
;; Aufgabe 1.0
; 1) -> 0
; 2) -> '0
; 3) -> 'wieder
; 4) -> '()
; 5) -> 'Weichnachtsfest
; 6) -> '(Listen ganz einfach und)
; 7) -> '(Paare . auch)
; 8) -> #t
; 9) -> #f



;; Aufgabe 2.0


;;; Aufgabe 2.1

;;; <Notmeldung>		::= <Ueberschrift> <Standort> <Notfallbeschreibung> <Peilzeichen> <Unterschrift> "OVER"
;;; <Ueberschrift>		::= <'MAYDAY> <'Hier_Ist> <'Schiffsname> <Rufzeichen> <Notzeichen>
;;; <Unterschrift>		::= <Schiffsname> <Rufzeichen>
;;; <Notzeichen>		::= "MAYDAY" <Schiffsname> <'Schiffsname> <Rufzeichen>
;;; <Standort>			::= <Zone> <Ostwert> <Nordwert>
;;; <Rufzeichen>		::= <Nato-Wort>
;;; <'Schiffsname> 		::= <Nato-Wort>
;;; <'MAYDAY>			::= "MAYDAY" "MAYDAY" "MAYDAY"
;;; <'Hier_ist>			::= "HIER IST" | "DE" | "DELTA" "ECHO"
;;; <Notfallbeschreibung>	::= <Wort>
;;; <erweiterte_Beschreibung>	::= <Wort>
;;; <Schiffsname>		::= <Wort>
;;; <Nato-Wort>			::= <Nato-Char> | <Nato-Char> <Nato-Wort>
;;; <Wort>			::= <Char> | <Char> <Wort>
;;; <Char>
;;; <Nato-Char>
;;; <Zone>
;;; <Ostwert>
;;; <Nordwert>

;;; Aufgabe 2.2
(require "../03/Funkhelfer.rkt")

(define (Schiffsname Rufzeichen Position advDes)
  (string-append 
	(Ueberschrift Schiffsname Rufzeichen) 
   Position 
   advDes 
	(Peilzeichen) 
	(Unterschrift Schiffsname Rufzeichen) 
   "OVER")
) 

(define (Ueberschrift Schiffsname Rufzeichen)
  (string-append 
	(string-repeat "MAYDAY" 3)
	(symbol->string (string->funkseq "DE"))
	(symbol->string (string->funkseq Schiffsname))
	(symbol->string (string->funkseq Rufzeichen))
	(Notzeichen Schiffsname Rufzeichen)
))

(define (Notzeichen Schiffsname Rufzeichen)
 (string-append
   "MAYDAY"
   Schiffsname
	(symbol->string (string->funkseq Schiffsname))
	(symbol->string (string->funkseq Rufzeichen))
))

(define (Peilzeichen)
	"ICH SENDE DEN TRAEGER --"
)


;; Utils
;;; found at rosettacode.org/Repeat_a_string		 
(define (string-repeat n str)
  (string-append (make-list n str)))

;;; Aufgabe 3

;;; Bei der äußeren Reduktion werden zunächst die äußeren Funktionen nach Definion aufgelöst:
; (hoch3 (* 3 (+ 1 (hoch3 2))) -> (* (* 3 (+ 1 (hoch3 2)))(* 3 (+ 1 (hoch3 2)))(* 3 (+ 1 (hoch3 2)))
; (* (* 3 (+ 1 (* 2 2 2))) (* 3 (+ 1 (* 2 2 2))) (* 3 (+ 1 (* 2 2 2))))
; ...
; Bei der inneren Reduktion passiert es genau andersherum
; (hoch3 (* 3 (+ 1 (hoch3 2))) -> (hoch3 (* 3 (+ 1 (* 2 2 2))) -> (hoch3 (* 3 (+ 1 8)) -> (hoch3 (* 3 9)) ->
; (hoch3 27) -> (* 27 27 27)

; + Racket benutzt die innere Reduktion für die Auswertung von Funktionen
;   und die aplikative Reduktion für die Auswertung von special form expressions


;+ Wenn das Programm ausgeführt wird kommt es unweigerlich zu einem "Buffer-Overflow", das Program
;  benötigt also zu viel Speicher.
;  Dies hängt damit zusammen, dass die innere Reduktion die auswertung der Bedingung verhindert.
;  Statt wie erwartet prüft Racket mit "new-if" nämlich nicht zuerst die Bedingung sondern substituiert
;  den Funktionsaufruf mit dem Funktionskörper. Da es sich hierbei um einen rekursiven Aufruf handelt,
;  passiert dies endlich oft.
;  Genau dieses Phänomen wird durch die applikative Reduktion verhindert, da eine Auswertung von rechts nach
;  links erzwungen wird.

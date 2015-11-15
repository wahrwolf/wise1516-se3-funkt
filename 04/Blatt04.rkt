#lang racket
;; Aufgabe 1.0



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



;;; found at rosettacode.org/Repeat_a_string		 
(define (string-repeat n str)
  (string-append (make-list n str)))

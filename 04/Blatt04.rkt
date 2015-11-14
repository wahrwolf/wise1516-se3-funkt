;; Aufgabe 1.0



;; Aufgabe 2.0


;;; Aufgabe 2.1

;;; <Notmeldung>		::= <Überschrift> <Standort> <Notfallbeschreibung> <Peilzeichen> <Unterschrift> "OVER"
;;; <Überschrift>		::= <'MAYDAY> <'Hier_Ist> <'Schiffsname> <Rufzeichen> <Notzeichen>
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

(define (Schiffsname Rufzeichen Position advDes)
  (string-append (Ueberschrift Schiffsname Rufzeichen) Position advDes (Peilzeichen) (Unterschrift Schiffsname Rufzeichen) "OVER")
) 

(define (Ueberschrift Schiffsname Rufzeichen)
  (string-append 



;;; found at rosettacode.org/Repeat_a_string		 
(define (string-repeat n str)
  (string-append (make-list n str)))

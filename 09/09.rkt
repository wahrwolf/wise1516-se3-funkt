#lang swindle
(require swindle/setf swindle/misc)

;Aufgabenblatt 9
;
;
;Aufgabe 1

; 1.1

(defclass Veroeffentlichung ()
  (schluessel
   :reader get-schluessel
   :writer set-schluessel
   :initarg ab)   
  ;(name)
  ;(erscheinungsdatum)
  ;(titel)
  :printer #t
  )
(defclass Buch (Veroeffentlichung)
  (verlag)
  (verlagsort)
  (reihe)
  (seriennummer))

(defclass Sammelband (Buch)
  (name)
  (seitenangabe))

(defclass Zeitschriftenartikel (Veroeffentlichung)
  (zeitschriftname)
  (bandnummer)
  (heftnummer)
  (erscheinungsmonat))

(make Veroeffentlichung "h" "name" "1998" "titel")

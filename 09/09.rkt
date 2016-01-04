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
   :initarg :schluessel)   
  (autorname
  :reader get-autorname
   :writer set-autorname
   :initarg :autname)   
  (erscheinungsdatum
   :reader get-date
   :writer set-date
   :initarg :erscheinung
    )   
  (titel
   :reader get-titel
   :writer set-titel
   :initarg :titel)   
  :printer #t
  )
(define (create-Veroeffentlicung schluessel name erscheinungsdatum titel)
  (make Veroeffentlichung
        :schluessel schluessel
        :autname name
        :erscheinung erscheinungsdatum
        :titel titel)
  )
(defclass Buch (Veroeffentlichung)
  (verlag
   :reader get-verlag
   :initarg :verlag)
  (verlagsort
   :reader get-verlagsort
   :initarg :verlagsort)
  (reihe
   :reader get-reihe
   :initarg :reihe)
  (seriennummer
   :reader get-seriennummer
   :initarg :seriennummer))

(define (create-Buch schluessel name erscheinungsdatum titel verlag verlagsort reihe seriennummer)
  (make Buch
        :schluessel schluessel
        :autname name
        :erscheinung erscheinungsdatum
        :titel titel
        :verlag verlag
        :verlagsort verlagsort
        :reihe reihe
        :seriennummer seriennummer)
  )

(defclass Sammelband (Buch)
  (name
   :reader get-name
   :initarg :name)
  (seitenangabe
   :reader get-seitenangabe
   :initarg :seitenanagabe)
  )
(define (create-Sammelband schluessel autorname erscheinungsdatum titel verlag verlagsort seriennummer name seiten)
  (make Sammelband
        :schluessel schluessel
        :autname name
        :erscheinung erscheinungsdatum
        :titel titel
        :verlag verlag
        :verlagsort verlagsort
        :seriennummer seriennummer
        :name name
        :seitenangabe seiten )
  )

(defclass Zeitschriftenartikel (Veroeffentlichung)
  (zeitschriftname
   :reader get-zeitname
   :initarg :zeitname)
  (bandnummer
   :reader get-band
   :initarg :band)
  (heftnummer
   :reader get-heft
   :initarg :heft)
  (erscheinungsmonat
   :reader get-monat
   :initarg :monat))

(define (create-Zeitschriftenartikel schluessel name erscheinungsdatum titel zeitname band heft monat)
    (make Zeitschriftenartikel
        :schluessel schluessel
        :autname name
        :erscheinung erscheinungsdatum
        :titel titel
        :zeitname zeitname
        :band band
        :heft heft
        :monat monat))

;so könnte man auch Objekte initialisieren, gegen Redundanz könnte man so Konstruktoren von Superklassen aufrufen
(define (testMethods)
  (let
      ( (veroeff (make Veroeffentlichung))
        )
    (set-autorname veroeff "hallo")
    veroeff))
    
(define nessi (create-Buch
               'Nessi1790
               'Nessi
               1790
               "Mein Leben im Loch Ness: Verfolgt als Ungeheuer"
               "Minority-Verlag"
               "Iverness"
               "Die Besondere Biographie"
               2))
(define prefect (create-Sammelband
                 'Prefect
                 "Prefect, F."
                 1979
                 "Mostly harmless - some observations concerning the third planet of the solar system"
                 "Galactic Press"
                 "Vega System, 3rd planet 1337"
                 5
                 "travel in Sytle"
                 420)
  )
(define wells (create-Zeitschriftenartikel
               'Wells
               "Wells, H.G."
               "don't care"
               "Zeitmaschinen leicht gemacht"
               "Heimwerkerpraxis für Anfänger"
               3200
               550
               3))
; 1.2

(defmethod cite ((v Veroeffentlichung))
  (list (get-autorname v) "(" (get-date v) "). " (get-titel v)))

(defmethod cite ((b Buch))
  (list (get-autorname b) "(" (get-date b) "). " (get-titel b) ", Band " (get-seriennummer b) " der Reihe: "
        (get-reihe b) ". " (get-verlag b) ", " (get-verlagsort b )))

(defmethod cite ((b Sammelband))
  (list (get-autorname b) "(" (get-date b) "). " (get-titel b) ", Band " (get-seriennummer b) " der Reihe: "
        (get-reihe b) ". " (get-verlag b) ", " (get-verlagsort b )"; p. " (get-seitenangabe b) ". ")
        )
(defmethod cite ((z Zeitschriftenartikel))
  (list (get-autorname z) " (" (get-band z) (get-titel z)  ". " (get-zeitname z) ", " (get-heft z)
        "(" (get-monat z) ")."))

(cite nessi)
(cite prefect)
(cite wells)

#lang racket
;1.1
;infix -> Operatoren verbinden Argumente [z.b. 4+5]
;praefix -> Funktionen werden mit Argumenten aufgerufen [z.b. (+ 4 5)]

;---
;Praefix
;	vorteile:
;	- syntaktische Analyse moeglich
;	- uebersichtlich
;	- mathematisch korrekt

;	Nachteile:
;	- nicht intuitiv

;Infix
;	Vorteile:
;	- bekannt
;	- intuitiv

;	Nachteile:
;	- unbersichtich
;	- interpretierte Reihenfolge nicht offensichtlich

;---

;In Racket wird die Praefixnotation benutzt



;2.1
;Manuelle (imperative Loesung)
(*
	3000
	0.02
)
;Definition einer Funktion
(define (zinsen(start satz dauer)


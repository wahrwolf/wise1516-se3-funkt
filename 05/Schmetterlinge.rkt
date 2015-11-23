#lang racket
(require "./Kinder.rkt")
(require "./Genom.rkt")
(require "./butterfly-module.rkt")

; In diesem Modul geht es nur umd die Darstellung und Spezifkation der Schmetterlinge
; Hierzu werden zunächst die Tabellen mit den entsprechenden Dominanzen definiert:

(define muster
  '(muster dots stripes plain))

(define farbe
  '(farbe red green blue yellow))

(define flügel
  '(flügel rhomb hexagonal ellipse))

(define fühler
  '(fühler straight shaped curly))

(define Erbinformation
  (list muster farbe flügel fühler))

; Hier werden die Zeichnfunktionen definiert
; Die Informationen werden aus dem Phenom herausgezogen
; und via show-butterfly aus der SE3-Bib visualiziert

(define (zeichne-schmetterling phenotyp)
  (show-butterfly
   (second (zeige-eigenschaften phenotyp 'farbe))
   (second (zeige-eigenschaften phenotyp 'muster))
   (second (zeige-eigenschaften phenotyp 'fühler))
   (second (zeige-eigenschaften phenotyp 'flügel))
   ))

(define (zeichne-schmetterling-geno geno)
  (zeichne-schmetterling (geno->pheno geno Erbinformation)))

(define (zeichne-schmetterlinge liste)
  (map zeichne-schmetterling liste))

(define (zeichne-schmetterlinge-geno liste)
  (map zeichne-schmetterling-geno liste))

(provide zeichne-schmetterlinge)
(provide zeichne-schmetterling)
(provide zeichne-schmetterling-geno)
(provide zeichne-schmetterlinge-geno)
(provide Erbinformation)
#lang racket

(require "./Utils.rkt")

; Ein Genom ist eine Liste von Listen
; Jede dieser Listen steht für ein Merkmal
; Dabei enthalten die Sublisten als erstes Element
; das Symbol für das sie stehen.
; Danach kommen die beiden Eigenschaften welche
; jeweils von Vater + Mutter vererbt wurden

; Neben den eigentlichem Erbgut ist ebenfalls der
; Aufbau von allgemeinen Erbinformationen wie des
; Dominanzverhaltens der einzelnen Eigenschaften wichtig.
; Um das ganze möglichst übersichtlich zu halten,
; ist der Aufbau fast mit dem des Genoms identisch.
;
; Statt einer Liste von 3 Elementen enthalten die Sublisten
; allerdings 1 + n Elemente wobei n die Anzahl
; aller möglichen Eigenschaften ist.
; Die Dominanz-Reihenfolge entspricht der Reihenfolge innerhalb
; der Sublisten. Das Head-Element hat dementsprechend die höchste Dominanz.

; Dieser Aufbau der allgemeinen Erbinformationen ermöglicht es z.B.
; (zeige-eigenschaften) genauso zu verwenden.


; Eine Begründung ist in ./Blatt05.rkt nachzulesen

(define  (zeige-eigenschaften genom eigenschaft)
; liefert die Liste der Eigenschaft wieder
  (if (equal? (car (car genom)) eigenschaft)
      (car genom)
      (zeige-eigenschaften (cdr genom) eigenschaft)
	))

(define (gib-dominant tabelle eigenschaften)
; prüft welche der beiden eigenschaften (liste!) dominanter ist

  ;gibt car zurück sobald eine Eigenschaft gefunden wurde
  (cond
    [(equal? (car tabelle) (first eigenschaften)) (car tabelle)]
	 [(equal? (car tabelle) (second eigenschaften)) (car tabelle)]
    [ else (gib-dominant (cdr tabelle) eigenschaften)]
  ))

; Bestimmt den Pheno-Typ aus dem Geno-Typ
(define (geno->pheno genom dominanzen)
  (g->p_h genom dominanzen '()))

(define (g->p_h geno domins pheno)
  (if (null? geno)
      pheno
      (g->p_h (cdr geno) domins
       (cons
        ;hänge die letze gefundene eigenschaft
        ;an die anderen dran
       (list
        ; erstelle eine liste aus der eigenschaft
        ; und dem dominanten wert
         (car (car geno))
         (gib-dominant
           (zeige-eigenschaften domins (car (car geno)))
           ; Gib den dominanten Wert aus der Tabelle
           ; die mittels zeige-eigenschaften aus einem
           ; Dictionarie geladen wird
           (cdr (car geno))))
       pheno))
      ))

; Rät einen möglichen Geno-Typ aus einem Pheno-Typ
(define (pheno->geno pheno dominanzen)
  (p->g_h pheno dominanzen '() ))

(define (p->g_h pheno domins geno)
  (if (null? pheno)
      geno
      (p->g_h (cdr pheno) domins
      (cons
       ; hänge die gefunden eigenschaften an den genomstrang dran
       (list
        ; erstelle eine liste aus
        ; eigenschaft, phenotyp und einer geratenen eigenschaft
         (car (car pheno))
         (car (cdr (car pheno)))
         (pick-random
          ; wähle eine eigenschaft aus der subliste zufällig aus
           (trim-until
            (zeige-eigenschaften domins (car (car pheno)))
            ; entferne alle elemente aus der Dominanzliste
            ; die dominanter als der gegebene Phenotyp sind
            (car (cdr (car pheno)))
           )))
       geno))
      ))



(define (sortiere-genom source target)
; Sortiert target so, dass die Reihenfolge der Eigenschaften wie in source ist
  (sort-help source target '()))


; Ordnet die Eigenschaften von B so an wie die von A
; Hierfür wird eine neue Liste erstellt
; und mithilfe von zeige-eigenschaft jeweils das passende
; Element aus B ausgewählt und in Out drangehängt
(define (sort-help A B Out)
  (if (null? A)
    (reverse Out)
    (sort-help 
     (cdr A) 
     B 
     (cons 
       (zeige-eigenschaften B (car(car A))) 
	   Out))
     ))


(provide sortiere-genom)
(provide zeige-eigenschaften)
(provide gib-dominant)
(provide geno->pheno)
(provide pheno->geno)

; Testdaten
(define A (list '(farbe gelb blau) '(form krum schweif) '(muster punkte sterne)))

(define D (list '(farbe rot gruen blau gelb) '(muster punkte streifen sterne) '(form gerade krum schweif)))

#lang racket

; Genom Zeugs
(define  (zeige-eigenschaften genom eigenschaft)
  (if (equal? (car (car genom)) eigenschaft)
      (car genom)
      (zeige-eigenschaften (cdr genom) eigenschaft)
	))

(define (gib-dominant tabelle eigenschaften)
  (if 
    (or (equal? (car tabelle) (first eigenschaften))
	(equal? (car tabelle) (second eigenschaften)))
  (car tabelle)
  (gib-dominant (cdr tabelle) eigenschaften)
  ))

(define (geno->pheno genom dominanzen)
  (g->p_h genom dominanzen '()))

(define (g->p_h geno domins pheno)
  (if (null? geno)
      pheno
      (g->p_h (cdr geno) domins
       (cons
       (list
         (car (car geno))
         (gib-dominant
           (zeige-eigenschaften domins (car (car geno)))
           (cdr (car geno))))
       pheno))
      ))

(define (pheno->geno pheno dominanzen)
  (p->g_h pheno dominanzen '() ))

(define (p->g_h pheno domins geno)
  (if (null? pheno)
      geno
      (p->g_h (cdr pheno) domins
      (cons
       (list
         (car (car pheno))
         (car (cdr (car pheno)))
         (pick-random
           (dropf (zeige-eigenschaften domins (car (car pheno)))
                 (lambda (arg) (equal?(car (car pheno)) arg))
           )))
       geno))
      ))

; Kinder-Erzugen
(define (erzeuge-kinder vater mutter anzahl)
	(erz-kinder-help vater mutter anzahl '())
)

(define (erz-kinder-help vater mutter anzahl kinder)
  (if (< 0 anzahl)
    (erz-kinder-help vater mutter (- anzahl 1) (cons (erzeuge-kind vater mutter) kinder)   )
    kinder))

(define (erzeuge-kind vater mutter)
  (erz-kind-help vater (sortiere-genom vater mutter) '() ))

(define (erz-kind-help vater mutter kind)
  (if (or (null? vater) (null? mutter))
    kind
    (erz-kind-help (cdr vater) (cdr mutter)
      (cons
       (list 
	     (car (car vater))
         (pick-random (cdr (car vater)))
         (pick-random (cdr (car mutter))))
       kind))
    ))

; Utils

(define (pick-random tupel)
; Gibt zufällig ein Element der Liste zurück
 (cond
   [(empty? tupel) null]
   [(> 2 (length tupel)) (car tupel)]
   [(even? (random 100)) (car tupel)]
   [else (pick-random (cdr tupel))]
         ))
                         
   
(define (sortiere-genom source target)
; Sortiert target so, dass die Reihenfolge der Eigenschaften wie in source ist
  (sort-help source target '()))

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


; Testdaten
(define A (list '(farbe gelb blau) '(form krum schweif) '(muster punkte sterne)))

(define D (list '(farbe rot gruen blau gelb) '(muster punkte streifen sterne) '(form gerade krum schweif)))

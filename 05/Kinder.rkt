#lang racket
(require "./Genom.rkt")
(require "./Utils.rkt")

; In diesem Modul werden Kinder erzeugt.

; In einem rekursiven Aufruf wird ein neuer Genom-Strang erzeugt:
; Hierzu wird zufällig eines der Eigenschaften der Mutter und des Vaters übernommen
; Das funktioniert im rekursiven Aufruf nur wenn die Reihenfolge bei Vater und Mutter gleich sind
; Deshalb wird vor dem Aufruf der Hilfsfunktion (sortiere-genom) benutzt.


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


; Im Prinzip ist erzeuge-kinder nur ein Wrapper für erzeuge-kind
(define (erzeuge-kinder vater mutter anzahl)
	(erz-kinder-help vater mutter anzahl '())
)

(define (erz-kinder-help vater mutter anzahl kinder)
; In einer Endrekursion wird für jedes jedes Mal ein Kind erzeugt
  (if (< 0 anzahl)
    (erz-kinder-help
       vater mutter (- anzahl 1)
      (cons (erzeuge-kind vater mutter) kinder))
    kinder))

(provide erzeuge-kind)
(provide erzeuge-kinder)
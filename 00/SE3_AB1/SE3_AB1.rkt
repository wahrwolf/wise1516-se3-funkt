#lang racket
;Aufgaben zu Aufgabenblatt 01 - SE3 funktionale Prog.

;;Aufgabe 1.1 Bogenmass und Grad
(define (degrees->radians degrees) (* degrees (/ (* 2 pi) 360)))
(define (radians->degrees radians) (* radians (/ 360 (* 2 pi))))

;;Aufgabe 1.2 Umkehrfunktion acos
(define (cos->sin cos) (sqrt (- 1 (* cos cos))))
;;;Abfangen von cos==0
(define (my-acos cos) (if(equal? cos 0) (/ pi 2) 
                         ;;;bei cos>0: acos per Formel berechnen
                         (if (> cos 0) (atan (/ (cos->sin cos) cos))
                             ;;;bei cos<0: acos per Formel berechnen 
                             ;;;und anschließend von Pi(180Grad) abziehen,
                             ;;;weil für cos<0 negative Werte berechnet werden
                             (+ pi (atan (/ (cos->sin cos) cos))))))

;;Aufgabe 1.3 Kilometer und Seemeilen
(define (nm->km nautischemeilen) (* nautischemeilen 1.852))

;;Aufgabe 2.1 Grosskreisentfernung
;;;Hilfsfunktion zur Zwischenrechnung (gegebene Formel)
(define (grosskreisentfernung geobreiteA geolaengeA geobreiteB geolaengeB)
  (my-acos
   (+
    (*
     (sin (degrees->radians geobreiteA))
     (sin (degrees->radians geobreiteB)))
    (*
     (cos (degrees->radians geobreiteA))
     (cos (degrees->radians geobreiteB))
     (cos (degrees->radians (- geolaengeB geolaengeA)))))))

;;;Eingabe von W- und S-Graden als negative Werte
(define (distanzAB geobreiteA geolaengeA geobreiteB geolaengeB)
  (nm->km (*
           (radians->degrees (grosskreisentfernung geobreiteA geolaengeA geobreiteB geolaengeB))
           60)))
;;;Oslo->Hongkong: 8589.41km, Kurswinkel: 67.44Grad
;;;San Francisco->Honolulu: 3844.69km Kurswinkel: 251.78Grad
;;;Osterinsel->Lima: 3757.62km Kurswinkel: 70.07Grad

;;Aufgabe 2.2 Anfangskurs
(define (anfangskurs geobreiteA geolaengeA geobreiteB geolaengeB)
  ;;;Ermitteln des Kurswinkels per gegebener Formel
  (define kurswinkel
    (radians->degrees
     (my-acos
      (/
       (-
        (sin (degrees->radians geobreiteB))
        (*
         (cos (grosskreisentfernung geobreiteA geolaengeA geobreiteB geolaengeB))
         (sin (degrees->radians geobreiteA))))
       (*
        (cos (degrees->radians geobreiteA))
        (sin (grosskreisentfernung geobreiteA geolaengeA geobreiteB geolaengeB)))))))
  ;;;Anpassen des Kurswinkels auf oestlichen/westlichen Kurs
  (if (< geolaengeB geolaengeA) (- 360 kurswinkel) (+ kurswinkel)))

;;Aufgabe 2.3 Himmelsrichtungen
;;2.3.1
;;;Liste der Himmelsrichtungen, auf die per Index zugegriffen werden kann
(define Himmelsrichtungen (list 'N 'NNE 'NE 'ENE 'E 'ESE 'SE 'SSE 'S 'SSW 'SW 'WSW 'W 'WNW 'NW 'NNW))

;;;Umwandeln einer Gradzahl in die entsprechende Himmelsrichtung, indem die Grad in einen Index umgewandelt werden
(define (Grad->Himmelsrichtung grad)
  (list-ref Himmelsrichtungen (if(< grad 348.75) (inexact->exact(round (/ grad 22.5))) (+ 0))))

;;2.3.2
;;;Index eines Listenelements ermitteln
(define (getIndex mylist listitem)
  (if (equal? listitem (first mylist))
      (+ 0)
      (+ 1 (getIndex (rest mylist) listitem))))

;;;Per Index die Himmelsrichtung in Grad umwandeln
(define (Himmelsrichtung->Grad himmelsrichtung)
  (* (getIndex Himmelsrichtungen himmelsrichtung) 22.5))

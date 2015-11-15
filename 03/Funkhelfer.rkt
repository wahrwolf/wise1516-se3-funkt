#lang racket
(require "./Buchstabiertafel-Funk.rkt")
(require "./Zeichentabellenhelfer.rkt")

;; Teilaufgabe 3.1.2
;;; Benutzt die Hilfsfunktion char->symbol mit der Buchstabiertafel

(define (char->funk char)
   ;; Gibt den Funkerschlüssel des Chars wieder
  (char->symbol char Buchstabiertafel)
  )


;; Teilaufgabe 3.1.3

;;; Wir konvertieren den char in uppercase und rufen dann wieder char->funk auf
;;; Da wir genau eine Unterscheidung machen ist if übersichtlicher als cond 
{define (nocase-char->funk char)
  [if
    (char-lower-case? char)
    (char->funk (char-upcase char))
    (char->funk char)
    ]
  }

;; Teilaufgabe 3.1.4

;;; Mit der Hilfsfunktion wird der String über die Tabelle Buchstabiertafel abgearbeitet
;;; (Für die Implementierung siehe Zeichentabellenhelfer.rkt)
{define (string->funkseq String)
  (string->symbolseq String Buchstabiertafel)
  }


(provide nocase-char->funk)
(provide char->funk)
(provide string->funkseq)

(define (string->funkstring String)
  (string-append (map symbol->string (string->funkseq String))))
#lang racket
(require se3-bib/flaggen-module)
(require "./Buchstabiertafel-Flaggen.rkt")
(require "./Zeichentabellenhelfer.rkt")

;; Teilaufgabe 3.2.2
;;; Benutzt die Hilfsfunktion char->symbol mit der Buchstabiertafel

(define (char->flagge char)
  ;; Gibt den Chars als Flagge wieder
  ;; Hierzu wird die Hilfsfunktion benutzt
  ;; Anschließend müssen die Flaggen nur noch via se3-bib dargestellt werden
  (eval (char->symbol char Buchstabiertafel) )
  )


;; Teilaufgabe 3.2.3

;;; Wir konvertieren den char in uppercase und rufen dann wieder char->funk auf
;;; Da wir genau eine Unterscheidung machen ist if übersichtlicher als cond 
{define (nocase-char->flagge char)
  [if
    (char-upper-case? char)
    (char->flagge (char-downcase char))
    (char->flagge char)
    ]
  }

;; Teilaufgabe 3.2.4

;;; Mit der Hilfsfunktion wird der String über die Tabelle Buchstabiertafel abgearbeitet
;;; Anschließend müssen die Flaggen nur noch via se3-bib dargestellt werden
;;; (Für die Implementierung siehe Zeichentabellenhelfer.rkt)
{define (string->flaggenseq String)
  (map eval (string->symbolseq String Buchstabiertafel))
  }


(provide nocase-char->flagge)
(provide char->flagge)
(provide string->flaggenseq)

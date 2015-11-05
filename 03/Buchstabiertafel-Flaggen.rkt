#lang racket

;; Teilaufgabe 3.1.1

;;; Als Datenstruktur nehmen wir eine Liste von Paaren
;;; deren erstes Element die Symbol-Repräsentatin des Buchstabens ist
;;; und deren zweites Element der Schlüssel als Symbol ist.

;;; Folgende Gründe sprechen für die Repräsentation als Liste von Paaren:

;;;; - Es können leicht weitere Paare auch nachträglich hinzugfügt werden
;;;; - mit einer Liste können doppelte Einträge leicht raussortiert werden
;;;; - die Liste ist eine leicht zu benutzende Datenstruktur

;;; Folgede Gründe sprechen für die Repräsentation der Paare im Format Symbol.Symbol:

;;;; - sowohl die Keys als auch die Werte werden abstrahiert dargestellt
;;;; (z.B. verschieden Rechtschreibung der schlüssel egal ... (Alfa, Alpha, alpha, alfa...) )
;;;; - vielfältige Möglichkeiten mit assoc die Werte in verschiedene Formate zu "exportieren"
;;;; ( so kann z.B. eine export Methode to_String(Key) existieren die eine String-Repräsentation liefert)
;;;; - gleiches gilt für die Eingabe (z.B. kann ohne weiteres Groß- und Kleinschreibung beachtet oder ignoriert werden)
;;;; - Für Inplace - Algorithmen kann eine Unterscheidung zwischen Char und Symbol benutzt werden um Ausgabe von Eingabe zu trennen

;;; Für die Umsetzung benutzen wir einzelne Listen, so lassen sich übersichtich einzelne "Module" pflegen
;;; Die in der Aufgabe geforderte Buchstabiertafel enthält z.B. Sonderzeichen, GroßBuchstaben und Zahlen ...



{define Zahlen
   ;; Anmerkung: Da es mehere mögliche Darstellunge von Zahlen als Symbole gibt
    ;; haben wir auf string->symbol zurückgegriffen
    ;; Diese Darstellung kann von jedem hergeleitet werden und erfordert keine weitere Spezifikation
  [list
    (cons (string->symbol "0") 'Z0)
    (cons (string->symbol "1") 'Z1)
    (cons (string->symbol "2") 'Z2)
    (cons (string->symbol "3") 'Z3)
    (cons (string->symbol "4") 'Z4)
    (cons (string->symbol "5") 'Z5)
    (cons (string->symbol "6") 'Z6)
    (cons (string->symbol "7") 'Z7)
    (cons (string->symbol "8") 'Z8)
    (cons (string->symbol "9") 'Z9)
    ]
  }

{define KleinBuchstaben
  [list
    (cons 'a 'A)
    (cons 'b 'B)
    (cons 'c 'C)
    (cons 'd 'D)
    (cons 'e 'E)
    (cons 'f 'F)
    (cons 'g 'G)
    (cons 'h 'H)
    (cons 'i 'I)
    (cons 'j 'J)
    (cons 'k 'K)
    (cons 'l 'L)
    (cons 'm 'M)
    (cons 'n 'N)
    (cons 'o 'O)
    (cons 'p 'P)
    (cons 'q 'Q)
    (cons 'r 'R)
    (cons 's 'S)
    (cons 't 'T)
    (cons 'u 'U)
    (cons 'v 'V)
    (cons 'w 'W)
    (cons 'x 'X)
    (cons 'y 'Y)
    (cons 'z 'Z)
    ]
  }


{define Buchstabiertafel
  ;;; Liefert eine Zuordnung von Symbolen auf Symbole
  ;;; Jede Liste enthält die Zuordnung für einen Bereich
  [append
    KleinBuchstaben
    Zahlen
   ]
}

(provide Buchstabiertafel)

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

{define Sonderzeichen
   ;; Anmerkung: Da es mehere mögliche Darstellunge von Sonderzeichen als Symbole gibt,
   ;; haben wir auf string->symbol zurückgegriffen
   ;; Diese Darstellung kann von jedem hergeleitet werden und erfordert keine weitere Spezifikation
  [list
   (cons (string->symbol ",") 'Decimal)
   (cons (string->symbol ".") 'Stop)
  ]
}


{define Zahlen
   ;; Anmerkung: Da es mehere mögliche Darstellunge von Zahlen als Symbole gibt
    ;; haben wir auf string->symbol zurückgegriffen
    ;; Diese Darstellung kann von jedem hergeleitet werden und erfordert keine weitere Spezifikation
  [list
    (cons (string->symbol "0") 'Nadazero)
    (cons (string->symbol "1") 'Unaone)
    (cons (string->symbol "2") 'Bissotwo)
    (cons (string->symbol "3") 'Terratwo)
    (cons (string->symbol "4") 'Kartefour)
    (cons (string->symbol "5") 'Pantafive)
    (cons (string->symbol "6") 'Soxisix)
    (cons (string->symbol "7") 'Setteseven)
    (cons (string->symbol "8") 'Otkoeight)
    (cons (string->symbol "9") 'Novenine)
    ]
  }

{define GroßBuchstaben
  [list
   (cons 'A 'Alfa)
    (cons 'B 'Bravo)
    (cons 'C 'Charlie)
    (cons 'D 'Delta)
    (cons 'E 'Echo)
    (cons 'F 'Foxtrott)
    (cons 'G 'Golf)
    (cons 'H 'Hotel)
    (cons 'I 'India)
    (cons 'J 'Juliett)
    (cons 'K 'Kilo)
    (cons 'L 'Lima)
    (cons 'M 'Mike)
    (cons 'N 'November)
    (cons 'O 'Oscar)
    (cons 'P 'Papa)
    (cons 'Q 'Quebec)
    (cons 'R 'Romeo)
    (cons 'S 'Sierra)
    (cons 'T 'Tango)
    (cons 'U 'Uniform)
    (cons 'V 'Viktor)
    (cons 'W 'Whiskey)
    (cons 'X 'X-Ray)
    (cons 'Y 'Yankee)
    (cons 'Z 'Zulu)
    ]
  }


{define Buchstabiertafel
  ;;; Liefert eine Zuordnung von Symbolen auf Symbole
  ;;; Jede Liste enthält die Zuordnung für einen Bereich
  [append
    GroßBuchstaben
    Zahlen
    Sonderzeichen
  ]
}

(provide Buchstabiertafel)
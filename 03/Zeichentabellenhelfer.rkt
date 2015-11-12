#lang racket
;; Hilfsfunktion zur Arbeit mit Zeichentabellen

;;; Da unsere Datenstruktur als Liste von Paaren vorliegt können wir einfach mit assoc arbeiten
;;; Zunächst müssen wir allerdings den Char in einen String mit Länge 1 umwandeln
;;; um ihn anschließend in ein Symbol zu überführen
;;;; Anmerkung: Auch wenn es an dieser Stelle "komplizierter" erscheint den char erst in string zu konvertieren
;;;; so bleibt unser Datensatz lesbarer und einfach erweiterbar ...

{define (char->symbol char Tabelle)
  ;; Löst Char in Tabelle auf
  ;; gibt 'NOT_DEFINED für nicht definierte Chars wieder
   (symbol->symbol (string->symbol (string char) ) Tabelle)
}

{define (symbol->symbol Key Tabelle)
  (cond
    [
     ;; Prüfe ob Schlüssel vorhanden und gib ihn zurück
     (assoc Key Tabelle)
     (cdr (assoc Key Tabelle))
    ]
    ;; Wenn nicht vorhanden gibt 'NOT_DEFINED zurück
    [ else 'NOT_DEFINED]
    )
  }


{define (charlist->symbolseq Charlist Tabelle)
  ;; Konvertiert eine Liste von Chars zu einer Sequenz von Symbolen
  ;; Löst dabei jeden einzelnen Char rekursiv mit der Tabelle auf
  (charlist->symbolseq_helper Charlist '() Tabelle)
}

{define (charlist->symbolseq_helper Charlist Symbolseq Tabelle)
  [if
   (not (null? Charlist))
   { charlist->symbolseq_helper
     (cdr Charlist)
     (cons Symbolseq  (char->symbol (car Charlist) Tabelle) ) 
     Tabelle
    }
   (reverse Symbolseq)
   ]
}


;; Verschiedene Interfaces für die Ein- und Ausgabe
{define (string->symbolseq String Tabelle)
  (charlist->symbolseq (string->list String) Tabelle)
}

(provide symbol->symbol)
(provide char->symbol)

(provide charlist->symbolseq)
(provide string->symbolseq)

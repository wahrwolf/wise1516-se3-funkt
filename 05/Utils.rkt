#lang racket

; Dieses Modul enthält verschiede Hilfsfunktionen

(define (pick-random tupel)
; Gibt zufällig ein Element der Liste zurück
; wenn die Liste leer ist wird null zurückgegeben
 (cond
   [(empty? tupel) null]
   [(> 2 (length tupel)) (car tupel)]
   [(even? (random 100)) (car tupel)]
   [else (pick-random (cdr tupel))]
         ))
                         
   

(define (trim-until list key)
; Gibt die Liste nach dem ersten Vorkommen von Key wieder
 ; Wenn die Liste leer ist, oder Key nicht vorkommt wird '() zurückgegeben
  (if (or (equal? (car list) key) (null? list))
      list
      (trim-until (cdr list) key)))

(provide pick-random)
(provide trim-until)
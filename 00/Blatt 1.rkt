#lang racket

;Aufgabe 1.1
(define (degtorad degree)
  (* degree (/ 180 pi)))

(define (radtodeg radiant)
  (/ (* pi radiant) 180))

;Aufgabe 1.2
(define (my-acos cosinus)
  (atan (/ (findesin cosinus) cosinus)))

(define (findesin cosinus)
  (sqrt (- 1 (* cosinus cosinus))))

;Aufgabe 1.3
(define (nmtokm nmeilen)
  (* nmeilen 1.851))

;Aufgabe 2.1
(define (distanzAB breite1 ns1 laenge1 ow1 breite2 ns2 laenge2 ow2)
  (nmtokm 
           (* 60
              (radtodeg (my-acos (+
                                  (*(sin (* breite1 (testneg ns1)))(sin (* breite2 (testneg ns2))))
                                  (*(cos (* breite1 (testneg ns1)))(cos (* breite2(testneg ns2)))
                                    (cos(abs(-(* (testneg ow1)laenge1)(* (testneg ow2)laenge2)))))))))))

#! testet nach Süd oder Ost um mit -1 zu multiplizieren
(define (testneg nsORow)
  (if (equal? "S" nsORow) -1 
                            (if (equal? "O" nsORow) -1 1)))

#! > (distanzAB 59.93 "N" 10.75 "E" 22.20 "N" 114.10 "E" )
#! -1.0678561997949814   -> offensichtlich funktioniert es nicht :(

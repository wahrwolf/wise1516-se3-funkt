#lang racket
(require "./Kinder.rkt")
(require "./Schmetterlinge.rkt")


(define Alice
  (list
   '(farbe red blue)
   '(muster dots dots)
   '(flügel ellipse rhomb)
   '(fühler curly curly)
   ))

(define Bob
  (list
   '(farbe green yellow)
   '(muster plain stripes)
   '(flügel hexagon rhomb)
   '(fühler straight curly)
   ))

(define Charlie
  (list
   '(farbe yellow)
   '(flügel rhomb)
   '(muster stripes)
   '(fühler curved)
  ))

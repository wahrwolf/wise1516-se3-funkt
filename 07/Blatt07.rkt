#lang racket
(require racket/trace)
(require 2htdp/image)

(define (range-rec intervall n)
	(if 
	 (= n 0)
	 '()
	 (cons (car intervall) (range-rec
				 (cons (+ (car intervall)
				     (/ (- (cdr intervall) (car intervall))
					 n))
				  (cdr intervall))
				 (- n 1))
	)))


(define (range-endrec intervall n)
	(r-end_h intervall '() n))

(define (r-end_h intervall result n)
	(if (= n 0)
	(reverse result)
	(r-end_h (cons (+ (car intervall)
			   (/ 	(- (cdr intervall)
				(car intervall))
			    n))
			(cdr intervall) )
		 (cons (car intervall) result)
		 (- n 1))))

(define (range-high intervall n)
	(build-list
		n
		(lambda (x) 
			(+ (car intervall)
			   (* (/ (- (cdr intervall)
				(car intervall))
                             n)
			   x)))))

;#######################################
;############## Aufgabe 2 ##############
;#######################################

; ############### 2.1 ##################
(define (function->points func interval n)
  (map (lambda (x) (cons x (func x))) (range-high interval n)))

; ##############  2.2  #################
; scaliert Vektor
; Vektor muss monoton steigend sein
(define (rescale1d range new_scale)
  (map (lambda (x) (+ (* (/ (- x (car range))
                            (-  (last range) (car range)))
                         (-  (cdr new_scale)  (car new_scale)))
                      (car new_scale))) range))
#|Tests
> (rescale1d '(1 1 3 4) (cons 1 10))
'(1 1 7 10)
> (rescale1d '(1 1) (cons 0 10))
. . /: division by zero
> (rescale1d '(1 2 7) (cons 0 10))
'(0 1 2/3 10)
> (rescale1d '(0 1 1 3 4 10) (cons 0 10))
'(0 1 1 3 4 10)
|#

; skaliert 2d Wertebereiche. Geht aber davon aus,
; dass 'Punkte' der Fkt monoton steigend sind
(define (rescale2d 2drange new_scale1 new_scale2)
  (let* ([2range (unzip 2drange)]
         [scaled1 (rescale1d (car 2range) new_scale1)]
         [scaled2 (rescale1d (cdr 2range) new_scale2)])
    (zip scaled1 scaled2)
    ))
#|Tests
> (rescale2d (function->points sqr (cons 0 10) 5)
             (cons 10 50)
             (cons 5 25))
'((10 . 5) (20 . 6 1/4) (30 . 10) (40 . 16 1/4) (50 . 25))
|#
; Hilfsfunktionen für Listenrepräsentation
(define (unzip 2dlist)
  (cons (coll1 2dlist) (coll2 2dlist)))

(define (coll1 2dlist)
  (if (null? 2dlist)
      '()
      (cons (car (car 2dlist)) (coll1 (cdr 2dlist)))))
(define (coll2 2dlist)
  (if (null? 2dlist)
      '()
      (cons (cdr (car 2dlist)) (coll2 (cdr 2dlist)))))
(define (zip l1 l2)
  (if (null? l1)
      '()
      (cons (cons (car l1) (car l2)) (zip (cdr l1) (cdr l2)))))
#| Tests Hilfsfunktionen
> (coll2 (list (cons 1 2) (cons 3 4) (cons 5 6)))
'(2 4 6)
> (coll1(list (cons 1 2) (cons 3 4) (cons 5 6)))
'(1 3 5)
> (unzip (list (cons 1 2) (cons 3 4) (cons 5 6)))
'((1 3 5) 2 4 6)
> (cdr (unzip (list (cons 1 2) (cons 3 4) (cons 5 6))))
> (zip (car (unzip (list (cons 1 2) (cons 3 4) (cons 5 6)))) (cdr (unzip (list (cons 1 2) (cons 3 4) (cons 5 6)))))
'((1 . 2) (3 . 4) (5 . 6))
|#

; ##############  2.3  #################
;scaliert die Punkte so dass die genau in den 800x600 Block passen und ruft helper auf
(define (draw-points pointlist)
  (draw-points_h (rescale2d pointlist (cons 1 799)(cons 1 599))))

; mal Punkt für Punkt auf scharzes Rechteck
(define (draw-points_h pointlist)
  (if (null? pointlist)
      (rectangle 800 600 "solid" "black")
      (place-image (ellipse 10 10 "solid" "blue")
                   (car (car pointlist))
                   (cdr (car pointlist))
                   (draw-points_h (cdr pointlist)))))
  

; ##############  2.4  #################


(define (plot-function func interval n)
  (draw-points (function->points sqr interval n)))

#| Tests
(plot-function sqr (cons 0 100) 5)

|#

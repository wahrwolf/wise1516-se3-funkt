#lang racket
(require racket/trace)

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


;; Aufgabe 2
(define (function->points func interval n)
  (map (lambda (x) (cons x (func x))) (range-high interval n)))

(define (rescale1d xs interval)
  (range-high interval (length xs)))

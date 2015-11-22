#lang racket

;; Aufgabe 1.1


; Wir haben uns folgende Struktur überlegt:
; -Wir erstellen eine Liste von allen Möglichen Kindern der beiden Eltern
; -Dann prüfen wir ob das Kind mindestens einem Eintrag aus der Liste gleicht
;
; Hierzu müssen wir zunächst eine Funktion finden um Kinder zu erzeugen:
; 	for i=0 to desired_children 
; 		for j=o to dna.len
; 			child.dna[j][0] = father.dna[j][random()%2]
; 			child.dna[j][1] = mother.dna[j][random()%2]
; 		next
; 	next
;
; Anschließend brauchen wir noch die Möglichkeit das Aussehen mit dem Genom zu verlgeichen.
;
; Mit der richtigen Datenstruktur können wir den Phenotyp schnell rekursiv mit dem Genotyp vergleichen:
; 	for i=0 to dna.len
; 		if is_more_dominant(pheno[i]) 
; 			if geno[i][0] != pheno[i] || geno[i][1] != pheno[i] return false 
; 		else
; 			if pheno[i]!=geno[i][0] return false
; 	next
;
; (Jede for-Schleife kann auch als Endrekursion geschrieben werden!)
;
; Da wir aber nur den Pheno-Typ der Eltern kennen können wir keinen vollständigen Geno-Typ der Kinder generieren ...
; Also muss unsere Gendatenstruktur die Möglichkeit haben ein unbekanntes rezesives Gen zu verarbeiten.
; Wenn wir voher definieren dass: 'unknown = type-of(*rezessiv) gilt...
;
;
; Unser fertiges Programm sieht also wie folgt aus:
;
; for child in get-children(phen->gen(father) phen->gen(mother))
; 	if phen-from-gen?(target child) return true
; next
; 
; Dafür brauchen wir lediglich folgende Bestandteile:
; 	- eine Endrekursion
; 	- get-children/2
; 	- phen->gen/1 (füllt pheno mit unknown auf)
; 	- phen-from-gen?/2 (prüft ob der phenotpy aus dem genotyp stammen kann)
;

;; Aufgabe 1.2

; Wir können das Erbgut eines Schmetterlings einfach als Liste von Listen darstellen:
; 
; Die Idee dahinter ist das jedes Merkmal 2 Eigenschaften enhält.
; Da wir nicht auf die Reihenfolge angwiesen sein wollen fügen wir einen weiteren Platz für einen Namen ein.
; Die Notation mit listen hat außerdem den Vorteil dass man schnell auch rekursiv drauf zu greifen kann.
; 
; Das Dominanz Verhalten unter Eigenschaften speicher wir auch als Liste.
; Dabei hat das erste Element der Liste die höchste Dominanz.
; Durch diesen Aufbau können wir bei zwei Eigenschaften schnell prüfen, welche Eigenschaft dominanter ist.
; Außerdem lassen sich einfach neue Eigenschaften einfügen oder die Reihenfolge ändern.


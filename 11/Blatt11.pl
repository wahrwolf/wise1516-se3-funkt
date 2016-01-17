% Aufgabe 1.1:
% a) ?Marke=MacBook, ?Farbe=schwarz
% b) false
% c) =Rang=Gold
% d) 	?andere= (Petra ...)
	?andere= (Lena ...)
% e) ?farbe=Pik, ?wert=As
% f) ?farbe=Pik, ?wert=As, ?wert2=As

% Aufgabe 1.2:
vorbestellung('P_201',_).

leser('Linux', 'Leo', X, _).

vorbestellung('P_30', Nr),
	leser(X,Y,Nr,_).

leser(X,Y,Nr,Year),
	2016-Year > 60,
	ausleihe(_,Nr).

ausleihe(X, Nr),
	ausleihe(Y,Nr),
	X is not Y,
	leser(Name, Vname, Nr, _).


% Aufgabe 2 
% folgt nach Freitag

% Aufgabe 3
% folgt nach Freitag


10 COLOR15,4,1: SCREEN 3
15 ' Tracer un point avec PSET
20 X=127: Y=95: C=6: PSET(X,Y),7
30 IF NOT STRIG(0) THEN 30
35 ' Tracer un point avec VPOKE
40 X=X\4: Y=Y\4: ' Calcul de la coordonnee reel
50 AD=(Y\8)*256+((X\2)*8)+(Y MOD 8) ' Convertir la coordonnee en adresse
60 IF X MOD 2=0 THEN VPOKE AD,C*16+(VPEEK(AD)AND15)
70 IF X MOD 2=1 THEN VPOKE AD,(VPEEK(AD)AND&HF0)+C
80 GOTO 80

5 ' Initialise les registres sonores du PSG
10 FOR R=0 TO 13
20 IF R=7 THEN SOUND R,&B10111111 ELSE SOUND R,0
30 NEXT
40 ' Joue la note Do sur la voix 1 avec un volume à 12
50 SOUND 0,&hAC ' 8 bits de poids faible dans registre 0
60 SOUND 1,1 ' 4 bits de poids fort dans registre 1
70 SOUND 8,&b1100 ' Réglage du volume de la voix 1 à 12
80 SOUND 7,&b10111110 ' Active le générateur sonore sur la voix 1
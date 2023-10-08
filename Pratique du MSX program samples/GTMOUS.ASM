; Routine pour lire la souris par accès direct au PSG 
;
; Entrée :
;
; Mettre D à 10010011b et E à 00010000b (DE=9310h) si la souris est dans le port 1
; Mettre D à 11101100b et E à 00100000b (DE=EC20h) si la souris est dans le port 2
;
; Sortie :
;
; H = abscisse relative (-127~+128), L = ordonnée relative (-127~+128)
; H et L = 255 si la souris n'est pas trouvée
;
GTMOUS:
	LD	B,30	; Long délai d'attente pour la première lecture
	CALL	GTOFS2	; Lecture des 4 bits de poids fort de l'abscisse relative
	AND	0FH
	RLCA
	RLCA
	RLCA
	RLCA
	LD	C,A	; Garde les bits de poids fort dans C
	CALL	GTOFST	; Lecture des 4 bits de poids faible de l'abscisse relative
	AND	0FH
	OR	C	; Place les bits de poids fort
	LD	H,A	; Recombine l'abscisse relative dans H

	CALL	GTOFST	; Lecture des 4 bits de poids fort de l'ordonnée relative
	AND	0FH
	RLCA
	RLCA
	RLCA
	RLCA
	LD	C,A	; Garde les bits de poids fort dans C
	CALL	GTOFST	; Lecture des 4 bits de poids faible de l'ordonnée relative
	AND	0FH
	OR	C	; Place les bits de poids fort
	LD	L,A	; Recombine l'ordonnée relative dans L
	RET
 
GTOFST:
	LD    B,10	; Court délai d'attente
GTOFS2:
	LD	A,15
	OUT	(0A0H),A	; Registre 15
	IN	A,(0A1H)
	AND	80h	; Garde le bit de l'état de la LED Code/Kana
	OR	D
	OUT	(0A1H),A
	XOR	E	; Inverse le bit de la broche 8
	LD	D,A
 
WAIT:	DJNZ	WAIT	; Délai d'attente pour lire la valeur au bon timing.
 
	LD	A,14
	OUT	(0A0H),A	; Registre 14
	IN	A,(0A2H)
	RET
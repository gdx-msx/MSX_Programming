	ORG	0C000H
DEBUT:
	LD	A,(7)	; C = Numéro du port E/S correspondant
	LD	C,A	; au port 0 d'écriture du VDP.
	INC	C	; Port E/S du port 1 d'écriture.
;
	LD	A,0	; 3 bits de poids fort
	DI		; Interruptions interdites
	OUT	(C),A
	LD	A,80H+14	; 3 bits de poids fort
	OUT	(C),A	; dans le registre 14
;
	LD	A,01FH	; 8 bits de
	OUT	(C),A	; poids faible = 31
;
	LD	A,040H	; Bits 6~7 mis à 01 pour une
	OUT	(C),A	; écriture + autres bits de l'adresse
	EI		; Interruptions autorisées
;
	EX	(SP),HL	; Temps d'attente
	EX	(SP),HL	; pour VDP MSX1
;
	DEC	C	; Numéro du port E/S du port 0 dans C
	LD	HL,DATA	; Position des données
	LD	B,9	; Neuf lettres
ENVOI:
	OUTI		; Transfert des données sur le port 0
	DJNZ	ENVOIS	; (Peut-être remplacé par OTIR sur MSX2~)
	RET
DATA:	DB	'CA MARCHE'
END:
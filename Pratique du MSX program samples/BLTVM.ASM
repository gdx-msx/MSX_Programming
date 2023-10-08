EXTROM	EQU	0015FH
BLTVM	EQU	00195H
DPTR	EQU	0F562H	; adresse en mémoire centrale
DX	EQU	DPTR+4	; abscisse pixel de destination
DY	EQU	DX+2	; ordonnée pixel de destination
ARG	EQU	DY+7
LOGOP	EQU	ARG+1	; opérateur logique

	ORG	0C000H
DEBUT:
	LD	HL,0D000H
	LD	(DPTR),HL
	LD	HL,10H
	LD	(DX),HL
	LD	HL,20H
	LD	(DY),HL
	XOR	A	; ARG doit toujours être
	LD	(ARG),A	; mis à zéro !!!
	LD	A,2
	LD	(LOGOP),A	; au même format que LOGOPR
;
; ne pas oublier ceci
;
	LD	HL,DPTR
	LD	IX,BLTVM
	CALL	EXTROM
	RET 
;
	ORG	0D000H
P_HORZ:	DW	030H	; nombre de pixels horizontaux
P_VERT:	DW	00BH	; nombre de pixels verticaux
NBOCT:	DS	210H	; nombre d'octets nécessaires
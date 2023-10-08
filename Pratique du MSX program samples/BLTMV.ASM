EXTROM	EQU	0015FH
BLTMV	EQU	00199H
SX	EQU	0F562H	; abscisse du pixel de départ
SY	EQU	SX+2	; ordonnée du pixel de départ
DPTR	EQU	SY+2	; adresse en mémoire centrale
NX	EQU	SY+6	; abscisse du pixel de destination
NY	EQU	NX+2	; ordonnée du pixel de destination
ARG	EQU	NY+3		
LOGOP	EQU	ARG+1	; opérateur logique

	ORG	0C000H
DEBUT:
	LD	HL,0D000H
	LD	(DPTR),HL
	LD	HL,10H
	LD	(SX),HL
	LD	HL,20H
	LD	(SY),HL
	LD	HL,60H-10H+1	; calcul de la largeur
	LD	(NX),HL
	LD	HL,40H-20H+1	; calcul de la hauteur
	LD	(NY),HL
	XOR	A	; ARG doit toujours être
	LD	(ARG),A	; mis à zéro !!!
	LD	A,2
	LD	(LOGOP),A	; au même format que LOGOPR
;
; ne pas oublier ceci
;
	LD	HL,SX
	LD	IX,BLTMV
	CALL	EXTROM
	RET
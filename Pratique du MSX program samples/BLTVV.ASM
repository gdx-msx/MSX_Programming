EXTROM	EQU	0015FH
BLTVV	EQU	00191H
SX	EQU	0F562H	; abscisse pixel de départ
SY	EQU	SX+2	; ordonnée pixel de départ
DX	EQU	SY+2	; abscisse pixel de destination
DY	EQU	DX+2	; ordonnée pixel de destination
NX	EQU	DY+2	; largeur du bloc à copier
NY	EQU	NX+2	; hauteur du bloc à copier
ARG	EQU	NY+3
LOGOP	EQU	ARG+1	; opérateur logique

	ORG	0C000H
DEBUT:
	LD	HL,20H
	LD	(SX),HL
	LD	HL,10H
	LD	(SY),HL
	LD	HL,0C0H
	LD	(DX),HL
	LD	HL,80H
	LD	(DY),HL
	LD	HL,80H-20H+1	; calcul de la largeur
	LD	(NX),HL
	LD	HL,60H-10H+1	; calcul de la hauteur
	LD	(NY),HL
	XOR	A	; ARG doit toujours être
	LD	(ARG),A	; mis à zéro !
	LD	A,3
	LD	(LOGOP),A	; au même format que LOGOPR
;
; ne pas oublier ceci
;
	LD	HL,SX
	LD	IX,BLTVV
	CALL	EXTROM
	RET
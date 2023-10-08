EXTROM	EQU	0015FH
BLTDV	EQU	001A1H
SX	EQU	0F562H	; abscisse du pixel de départ
SY	EQU	SX+2	; ordonnée du pixel de départ
FNPTR	EQU	SY+2	; pointeur sur le nom de fichier
NX	EQU	SY+6	; abscisse du pixel de destination
NY	EQU	NX+2	; ordonnée du pixel de destination
ARG	EQU	NY+3		

	DB	0FEH	; Entête pour les
	DW	DEBUT,END,DEBUT	; fichiers binaires
	
	ORG	0C000H
DEBUT:
	LD	HL,NOM
	LD	(FNPTR),HL
	LD	HL,10H
	LD	(SX),HL
	LD	HL,20H
	LD	(SY),HL
	LD	HL,60H-10H+1	; calcul de la largeur
	LD	(NX),HL
	LD	HL,80H-20H+1	; calcul de la hauteur
	LD	(NY),HL
	XOR	A	; ARG doit toujours être
	LD	(ARG), A	; mis à zéro !!!
;
; ne pas oublier ceci
;
	LD	HL, SX
	LD	IX, BLTDV
	CALL	EXTROM
	RET 

NOM:	DB	022H,'A:ESSAI.SC7',022H,000H
END:
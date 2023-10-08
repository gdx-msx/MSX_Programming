EXTROM	EQU	0015FH
REDCLK	EQU	001F5H
	
	ORG	0C000H
DEBUT:
	LD	C,02CH		; mode 2 - adresse 12
	LD	IX,REDCLK
	CALL	EXTROM
	RET			; lors du retour A contient 4
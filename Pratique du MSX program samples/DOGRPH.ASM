EXTROM	EQU	0015FH
DOGRPH	EQU	00085H
GXPOS	EQU	0FCB3H
GYPOS	EQU	0FCB5H
ATRBYT	EQU	0F3F2H
LOGOPR	EQU	0FB02H

	ORG	0C000H			
DEBUT:
	LD	BC,10H
	LD	DE,50H
	LD	HL,90H
	LD	(GXPOS),HL
	LD	(GYPOS),HL
	LD	A,7
	LD	(ATRBYT),A
	XOR	A
	LD	(LOGOPR),A
	LD	IX,DOGRPH
	CALL	EXTROM
	RET
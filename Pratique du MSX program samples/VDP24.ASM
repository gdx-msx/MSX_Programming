EXTROM	EQU	0015FH
CHGMOD	EQU	000D1H
CHGCLR	EQU	00062H
CLS	EQU	000C3H
NVBXLN	EQU	000C9H
BREAKX	EQU	000B7H
TOTEXT	EQU	000D2H
;
FORCLR	EQU	0F3E9H
BAKCLR	EQU	0F3EAH
BDRCLR	EQU	0F3EBH
GXPOS	EQU	0FCB3H
GYPOS	EQU	0FCB5H
ATRBYT	EQU	0F3F2H
LOGOPR	EQU	0FB02H
	ORG	0C000H
DEBUT:
	LD	A,8
	LD	IX,CHGMOD
	CALL	EXTROM	; Initialisation (Ecran, Couleurs, Etc)
;
	LD	A,00AH
	LD	(FORCLR),A
	LD	A,0
	LD	(BAKCLR),A
	LD	(BDRCLR),A
	CALL	CLS	; efface l'écran
;
	LD	BC,060H
	LD	DE,060H
	LD	HL,090H
	LD	(GXPOS),HL
	LD	(GYPOS),HL
	LD	A,0FCH
	LD	(ATRBYT),A
	LD	(LOGOPR),A
	LD	IX,NVBXLN
	CALL	EXTROM	; Trace un rectangle 
;
	LD	A,(7)	; C = Numéro du port E/S correspondant
	LD	C,A	; au port 0 d'écriture du VDP.
	INC	C	; Port E/S du port 1 d'écriture
;
; Boucle Principale
;
LOOP:	CALL	UP
	CALL	BREAKX	; Test du CTRL+STOP
	JR	C,OUT
	CALL	DOWN
	CALL	BREAKX	; Test du CTRL+STOP
	JR	C,OUT	; Sortie du programme si CTRL+STOP
	JP	LOOP
;
OUT:	CALL	TOTEXT	; Retour au mode texte
	RET
;
UP:	LD	B,032H
LOOP1:	LD	A,032H
	SUB	B
	CALL	VDP
	CALL	WAIT
	DJNZ	LOOP1	; saut à LOOP1: tant que B n'est pas à 0
	RET 
;
DOWN:	LD	B,032H
LOOP2:	LD	A,B
	CALL	VDP
	CALL	WAIT
	DJNZ	LOOP2	; saut à LOOP2: tant que B n'est pas à 0
	RET 
;
VDP:	DI		; Désactive les interruptions
	OUT	(C),A
	LD	A,080H+23
	OUT	(C),A
	EI		; Active les interruptions
	RET 
;
WAIT:	LD	HL,002FFH
HEP:	DEC	HL
	LD	A,H
	OR	L
	JR	NZ,HEP	; saut à HEP: tant que HL n'est pas à 0
	RET
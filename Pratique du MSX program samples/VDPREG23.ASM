EXTROM	equ	0015Fh
CHGMOD	equ	000D1h
CHGCLR	equ	00062h
CLS	equ	000C3h
NVBXLN	equ	000C9h
BREAKX	equ	000B7h
TOTEXT	equ	000D2h
;
FORCLR	equ	0F3E9h
BAKCLR	equ	0F3EAh
BDRCLR	equ	0F3EBh
GXPOS	equ	0FCB3h
GYPOS	equ	0FCB5h
ATRBYT	equ	0F3F2h
LOGOPR	equ	0FB02h
	org	0c000h
DEBUT:
	ld	a,8
	ld	ix,CHGMOD
	call	EXTROM	; SCREEN 8
;
	ld	a,0ah
	ld	(FORCLR),a
	ld	a,0
	ld	(BAKCLR),a
	ld	(BDRCLR),a
	call	CLS	; Efface l'�cran
;
	ld	bc,060h
	ld	de,060h
	ld	hl,090h
	ld	(GXPOS),hl
	ld	(GYPOS),hl
	ld	a,0fch
	ld	(ATRBYT),a
	ld	(LOGOPR),a
	ld	ix,NVBXLN
	call	EXTROM	; Trace un rectangle 
;
	ld	a,(7)	; C = Num�ro du port E/S correspondant
	ld	c,a	; au port 1 d'�criture du VDP.
	inc	c	; Port E/S du port 1 d'�criture
;
; Boucle Principale
;
LOOP:	call	UP
	call	BREAKX	; Test du CTRL+STOP
	jr	c,EXIT
	call	DOWN
	call	BREAKX	; Test du CTRL+STOP
	jr	c,EXIT	; Sortie du programme si CTRL+STOP
	jp	LOOP
;
EXIT:	call	TOTEXT	; Retour au mode texte
	ret
;
UP:	ld	b,032h
LOOP1:	ld	a,032h
	sub	b
	call	VDP
	call	WAIT
	djnz	LOOP1	; saut � LOOP1: tant que B n'est pas � 0
	ret 
;
DOWN:	ld	b,032h
LOOP2:	ld	a,b
	call	VDP
	call	WAIT
	djnz	LOOP2	; saut � LOOP2: tant que B n'est pas � 0
	ret 
;
VDP:	di		; D�sactive les interruptions
	out	(c),a
	ld	a,080H+23
	out	(c),a
	ei		; Active les interruptions
	ret 
;
WAIT:	ld	hl,002FFh
HEP:	dec	hl
	ld	a,h
	or	l
	jr	nz,HEP	; saut � HEP: tant que HL n'est pas � 0
	ret
	org	0c000h
;
ENASLT	equ	00024h
FIND:	ld	b,0fh
	ld	hl,04000h		; Plage 1
LOOP:	ld	a,b
	or	080h
	push	bc
	push	af
	push	hl
	call	ENASLT		; Sélection de Slot
	pop	hl
	pop	af
	ld	(hl),a
	ld	b,(hl)
	cp	b
	pop	bc
	jr	z,RAM
	djnz	LOOP		; Saute à LOOP si pas de RAM
;
RIEN:	jr	RETOUR 
;
RAM:	ld	ix,04000h
	ld	(ix+0),041h		; Code "A"
	ld	(ix+1),042h		; Code "B"
	ld	(ix+2),000h		; Adresse de
	ld	(ix+3),0c1h		; départ
	jr	RETOUR 
;
MNROM	equ	0fcc1h
;
RETOUR:	ld	a,(MNROM)
	ld	hl,04000h	; Replace la Main-ROM
	call	ENASLT		; en plage 1.
	ret 
;
;
	org	0c100h
;
BREAKX	equ	000b7h
INITXT	equ	0006ch
;
	call	INITXT		; SCREEN 0, 40 colonne
	ld	hl,MESS
	call	ECRIRE
WAIT:	call	BREAKX		; Teste CTRL+STOP
	ret c
	jr	WAIT
ECRIRE:	ld	a,(hl)
	cp	0
	ret	z
	call	0a2h
	inc	hl
	jr	ECRIRE
MESS:	db	01bh,'Y*&'
	db	'LE RESET NE REND'
	db	' PAS LA MAIN !',0
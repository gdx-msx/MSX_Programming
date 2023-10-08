ENASLT:	equ	00024h
FILVRM:	equ	00056h
MNROM:	equ	0fcc1h

	org	0c000h
FIND:
	ld	b,0fh
	ld	hl,04000h
LOOP:	ld	a,b
	or	080h
	push	bc
	push	af
	push	hl
	call	ENASLT
	pop	hl
	pop	af
	ld	(hl),a
	ld	b,(hl)
	cp	b
	pop	bc
	jr	z,RAM
	djnz	LOOP
RIEN:
	jr	RETOUR 
RAM:
	ld	ix,04000h
	ld	(ix+0),041h
	ld	(ix+1),042h
	ld	(ix+2),000h
	ld	(ix+3),000h
	ld	(ix+4),000h
	ld	(ix+5),0c1h
	jp	0c100h
RETOUR:
	ld	a,(MNROM)
	ld	hl,04000h
	jp	ENASLT
	ds	0c100h-$
LC100:
	push	hl
	ld	hl,WORD
	ld	de,0fd89h
LOOP2:
	ld	a,(DE)
	ld	b,(HL)
	cp	b
	jr	nz,SYNTXERR
	cp	0
	inc	hl
	inc	de
	jr	z,OUT
	jr	LOOP2
SYNTXERR:
	pop	hl
	xor	a
	ccf
	ret
OUT:
	pop	hl
	push	hl
	ld	a,(hl)
	cp	028h
	jr	nz,SYNTXERR
	inc	hl
	ld	a,(hl)
	cp	022h
	jr	nz,SYNTXERR
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	a,(hl)
	cp	022h
	jr	nz,SYNTXERR
	inc	hl
	ld	a,(hl)
	cp	029h
	jr	nz,SYNTXERR
LOOP3:
	inc	hl
	ld	a,(hl)
	cp	020h
	jr	z,LOOP3
	cp	0
	jr	Z,SUITE
	cp	03Ah
	jr	nz,SYNTXERR
SUITE:
	push	hl
	ld	hl,0
	ld	a,b
	ld	bc,00800h
	call	FILVRM
	pop	hl
	pop	bc
	xor	a
	ret
WORD:
	db	'FILLSCREEN',0
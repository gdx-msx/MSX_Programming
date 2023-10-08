EXTROM	equ	0015fh
NEWPAD	equ	001Adh
GTTRIG	equ	000d8h
NWRVRM	equ	00177h

	org	0c000h
Souris:
	ld	a,0ch
	ld	ix,NEWPAD
	call	EXTROM
	ld	a,0dh
	ld	ix,NEWPAD
	call	EXTROM
	ld	b,a
	ld	a,(X)
	add	a,b
	ld	(X),a
;
	ld	a,0ch
	ld	ix,NEWPAD
	call	EXTROM
	ld	a,0eh
	ld	ix,NEWPAD
	call	EXTROM
	ld	b,a
	ld	a,(Y)
	add	a,b
	ld	(Y),a
;
	call	Sprite
	ld	a,1
	call	GTTRIG
	cp	0ffh
	ret	z
	jr	Souris
;
Sprite:	ld	a,(X)
	ld	hl,0fa01h
	call	NWRVRM
	ret
X:	db	00h
Y:	db	00h
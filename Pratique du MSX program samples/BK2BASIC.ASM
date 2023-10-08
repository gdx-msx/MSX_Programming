MNROM	equ	0fcc1h
ENASLT	equ	00024h
RETURN	equ	0409bh
;
BACK2BASIC:
	ld	a,(MNROM)
	ld	hl,0		; Bios en page 0
	call	ENASLT
	ld	hl,04000h	; Basic en page 1
	call	ENASLT
	jp	RETURN
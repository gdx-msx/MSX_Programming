HOKVLD	equ	0fb20h	;Extended BIOS flag
EXTBIO	equ	0ffcah	;Extended BIOS hook
;
	ld	a,(HOKVLD)
	rra
	jr	nc,NO_MJE
	ld	hl,MJETBL
	call	GETSLT	;Get slot address of MJETBL into [B]
	ld	de,16*256+0
	push	hl
	call	EXTBIO
	pop	de
	or	a
	sbc	hl,de
	jr	z,NO_MJE
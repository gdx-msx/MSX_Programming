RSLREG	equ	00138h	; Lecture du registre des Slot primaires
EXPTBL	equ	0FCC1h

SEEK_RAMAD3:
	call	RSLREG
	and	0c0h	; Garde les bits 7 et 6 correspondant � la plage 3
	rlca
	rlca		; D�calage des bits 7 et 6 vers les bits 1 et 0
	ld	e,a	; Garde la valeur du Slot primaire dans le reg. E
	ld	a,(0ffffh)	; Lecture du registre des Slot secondaire du
	cpl		; slot primaire s�lectionn� puis inversion des bits
	and	0c0h	; Garde les bits 7 et 6 correspondant � la plage 3
	rrca
	rrca
	rrca
	rrca		; D�calage des bits 7 et 6 vers les bits 3 et 2
	or	e	; R�cup�re la valeur du Slot primaire 
	ld	hl,EXPTBL+3
	ld	d,0
	add	hl,de
	or	(hl)	;  Bit7=1 si le slot est �tendu
	ret
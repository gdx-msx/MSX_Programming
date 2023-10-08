VALTYP	equ	0f663h

	org	0c000h
DEBUT:
	cp	2	; Avons-nous bien affaire à un entier ?
	ret	nz	; Retour au Basic si ce n'est pas le cas
;
	inc	hl
	inc	hl	; HL = position de l'entier
	xor	a	; carry à 0
	rl	(hl)	; décalage 8 bits de poids faible(*2)
	inc	hl
	rl	(hl)	; décalage 8 bits de poids faible(*2)
	ret	nc	; Retour si il n'y a pas de dépassement
;
ERROR:	ld	hl,DATA	; HL = Adresse message
	call	ECRIRE	; à l'écran
	ret

NONENT:	ld	hl,DATA	; HL = Adresse message
	call	ECRIRE	; à l'écran
	ret
DATA:	db	'Overflow',0	
;
;
ECRIRE:	call	00A2h
	inc	hl
	ld	a,(hl)
	cp	0
	ret	z
	jr	ECRIRE
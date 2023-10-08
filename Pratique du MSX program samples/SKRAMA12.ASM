; Routine de recherche de la RAM sur la plage mémoire 0 ou 1
; Sortie: A=Numéro de slot et Carry = 0, Carry = 1 si Ram non trouvée

EXPTBL	equ	0fcc1h	; Indicateurs des Slot secondaires
RDSLT:	equ	0000ch
WRSLT:	equ	00014h
RAMSLT:	equ	0c000h	; Slot de la RAM trouvée
KBUF:	equ	0c001h	; Longueur 4 octets (0C001h~0C004h)

	org	04010h	; Adresse qui peut être 0000h~0BEFFh selon
			; la plage sur laquelle la ROM se trouve
	call	Ram_srch
	ld	(RAMSLT),a
	ret

Ram_srch:
	ld	b,4	; Slot primaire
Ram_srch_loop:
	ld	a,b
	dec	a
	xor	3
	ld	(RAMSLT),a	; Muméro du Slot secondaire en cours
	ld	e,a
	
	ld	hl,EXPTBL
	ld	d,0
	add	hl,de
	ld	a,(hl)
	ld	(KBUF),a	; Stocke l'indicateur de slot secondaire
	exx

	ld	a,(KBUF)	; Restitue l'indicateur de slot secondaire
	rlca
	ld	b,1
	ld	a,(RAMSLT)
	jr	nc,PrimSLT

	ld	b,4	;Slot secondaire
Ram_srch_loop2:	
	ld	a,b
	dec	a
	xor	3
	rlca
	rlca
	ld	c,a
	ld	a,(RAMSLT)
	or	c
	or	080h	; Met le bit 7 à 1
PrimSLT:
	ld	(KBUF+1),a
	ld	hl,0000h	; Plage 0 (mettre 4000h chercher la plage 1)
	push	bc
	call	RDSLT
	ld	(KBUF+2),a
	pop	bc
	cp	041h
	jr	nz,no_header	; Saute si le premier octet = "A" (Rom?)

	inc	hl
	ld	a,(KBUF+1)
	push	bc
	call	RDSLT
	pop	bc
	dec	hl
	cp	042h
	jr	z,no_ram	; Saute si le second octet <> "B"
no_header:
	ld	a,(KBUF+1)
	push	bc
	call	RDSLT	; Lit le premier octet
	pop	bc
	ld	e,041h
	ld	a,(KBUF+1)
	push	bc
	call	WRSLT	; Ecrit "A" au premier octet
	pop	bc
	ld	a,(KBUF+1)
	push	bc
	call	RDSLT	; Lit le premier octet
	pop	bc
	cp	041h
	jr	z,Ram_found	; Saute si le premier octet = "A"
	
no_ram:	
	djnz	Ram_srch_loop2	; Vers le Slot suivant si pas de RAM
	exx
	djnz	Ram_srch_loop	; Vers le Slot suivant si pas de RAM
	scf		; Met Carry à 1
	ret

Ram_found:
	ld	a,(KBUF+2)
	ld	e,a
	ld	a,(KBUF+1)
	push	af
	or	080h
	call	WRSLT	; Restitue le premier octet de la RAM
	pop	af	; A=Slot de la Ram trouvée (sans le bit 7)
	or	a	; Met Carry à 0
	ret
	org	0c000h
DEBUT:
	ld	a,(7)	; C = Numéro du port E/S correspondant
	ld	c,a	; au port 0 d'écriture du VDP.
	inc	c	; Port E/S du port 1 d'écriture.

	ld	a,80h+9	; Registre 9 sans auto-incrémentation...
	di		; Interruptions interdites
	out	(c),a
	ld	a,80h+17	; ...dans registre 17 (+80h)
	out	(c),a
	ei		; Interruptions autorisées

	inc	c	; Port E/S du port 2 dans C
	inc	c	; Port E/S du port 3 dans C
	ld	a,(0ffe8h)	; Contenu de RG09SAV dans A
	and	0fdh	; Mettre le bit 2 à 0 (mode 60 Hz)
	out	(c),a	; Envoi sur le port 3
	ld	(0ffe8h),a	; Actualise RG09SAV

	call	ATTEND	; Appel le sous-programme d'attente

	or	2	; Met le bit 2 à 1 (mode 50 Hz)
	ld	(0ffe8h),a	; Actualise RG09SAV
	out	(c),a	; Envoi sur le port 3
	ret
ATTEND:
	ld	b,a	; Préserve A
	push	bc	; et C
	ld	bc,0	; Boucle d'attente
BCL:
	dec	bc	; Décremente BC
	nop		; Petit temps mort 
	ld	a,b
	or	c
	cp	0
	jr	nz,BCL	; Saute si BC > 0
	pop	bc	; Restitue C
	ld	a,b	; et A
	ret
DAC	equ	0f7f6h
DRVINV	equ	0fb21h
DSKIO	equ	04010h
ENASLT 	equ	00024h
EXPTBL	equ	0fcc1h
VALTYP	equ	0f663h

; --> Entête du fichier
	db	0feh	; Code pour fichier binaire
	dw	START	; Adresse de destination du programme
	dw	END	; Adresse de fin du programme
	dw	START	; Adresse d'execution du programme
; <--
	org	0c000h
	
START:	ld	a,2	; Lecteur C:
	ld	hl,DRVINV	; Table des interfaces de disque
RPT:	sub	(hl)
	jr	c,CONT
	inc	hl
	inc	hl
	jr	 RPT
CONT:	add	a,(hl)
	push	af
	inc	hl
	ld	a,(hl)
	ld	h,040h
	call	ENASLT	; Selectionne la Disk-ROM du disque C:
	ei
	pop	af
READ:	ld	b,7
	ld	c,0fbh	; 
	ld	de,5
	ld	hl,0c100h
	or	a	; Met carry à 0 (pour lecture)
	call	DSKIO
	ld	hl,255
	jr	nc,RD_OK
	ld	l,a
RD_OK:	ld	(DAC+2),hl	; Code d'erreur -> variable du Basic
	ld	a,2
	ld	(VALTYP),a
	ld	a,(EXPTBL)
	ld	h,040h
	call	ENASLT	; Sélectionne la Main-Rom
	ei
	ret		; Retour au Basic
END:
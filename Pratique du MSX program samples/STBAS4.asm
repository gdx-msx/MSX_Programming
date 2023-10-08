; Ne fonctione pas

CALSLT	equ	001Ch
DTA	equ	0080h
STBAS	equ	04022h
REBOOT	equ	0F340h
TXTTAB	equ	0F676h
DRVINF	equ	0FB21h

	org	0100h
	ld	a,1	; 1 pour ignorer un
	ld	(REBOOT),a	; éventuel AUTOEXEC.BAS

	ld	a,0
	ld	(DTA),a	; pas de nom

	ld	hl,(TXTTAB)
	dec	hl
	ld	(hl),0
	ex	de,hl
	ld	hl,PRGBAS
	ld	bc,END-PRGBAS	
	ldir		; Place de programme BASIC

	ld	ix,STBAS
	ld	iy,(DRVINF)	; Slot de la Disk ROM maitre
	jp	CALSLT
PRGBAS:
	.phase 8000h	; Décale l’adresse des Labels
	db	0
LINE10:
	dw	LINE20	; Adresse de la ligne suivante
	dw	10	; Numéro de ligne
	db	91h	; Code pour PRINT
	db	22h,"Hello",22h
	db	0	; Fin de ligne
LINE20:
	dw	BASEND	; Adresse de la ligne suivante
	dw	20	; Numéro de ligne
	db	91h	; Code pour PRINT
	db	22h,"World!",22h
BASEND:
	db	0,0,0	; Fin du programme
	dw	END-PRGBAS-1	; Longueur du programme
	.dephase	; Retour à l’adresse en cours
END:
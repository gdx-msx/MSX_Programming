CALSLT	equ	001Ch
STBAS	equ	04022h
REBOOT	equ	0F340h
TEMPST	equ	0F67Ah
DRVINF	equ	0FB21h

	org	0100h

	ld	a,0	; 0 pour exécuter le
	ld	(REBOOT),a	; fichier AUTOEXEC.BAS

	ld	ix,(TEMPST)	; Efface 3 octets
	ld	(ix),0	; de la
	ld	(ix+1),0	; zone réservée
	ld	(ix+2),0	; au programme BASIC

	ld	ix,STBAS
	ld	iy,(DRVINF)	; Slot de la Disk ROM maitre
	jp	CALSLT
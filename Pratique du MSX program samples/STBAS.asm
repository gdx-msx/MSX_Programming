CALSLT	equ	001Ch
DTA	equ	0080h
STBAS	equ	04022h
REBOOT	equ	0F340h
DRVINF	equ	0FB21h

	org	0100h


	ld	a,1	; 1 pour ignorer un
	ld	(REBOOT),a	; éventuel AUTOEXEC.BAS

	ld	hl,NAME
	ld	de,DTA
	ld	bc,END-NAME
	ldir		; Copie le nom du fichier

	ld	ix,STBAS
	ld	iy,(DRVINF)	; Slot de la Disk ROM maitre
	jp	CALSLT
NAME:
	db	9	; Longueur du nom de fichier
	db	"name.bas",0
END:
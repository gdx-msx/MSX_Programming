; Faite l'équivalent de COPY "A:ESSAI.SC7" to (16,32)

EXTROM	equ	0015fh
BLTVD	equ	0019dh
FNPTR	equ	0f562h	; Nom du fichier dans BUF
DX	equ	FNPTR+4	; Abscisse de destination
DY	equ	DX+2	; Ordonnée de destination
ARG	equ	DY+7		
LOGOP	equ	ARG+1	; Opérateur logique

	db	0feh	; Entête pour les
	dw	DEBUT,END,DEBUT	; fichiers binaires
		
	org	0c000h
DEBUT:
	ld	hl,NOM
	ld	(FNPTR),hl
	ld	hl,10h
	ld	(DX),hl
	ld	hl,20h
	ld	(DY),hl
	xor	a	; Mise à zéro !
	ld	(ARG),a
	ld	(LOGOP),a	; Au même format que LOGOPR
;
; Ne pas oublier ce qui suit.
;
	ld	hl,FNPTR
	ld	ix,BLTVD
	call	EXTROM
	ret
NOM:
	db	022h,'A:ESSAI.SC7',022h,0
END:
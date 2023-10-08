SUBROM	equ	015ch

EXPL:	push	ix	
		ld	ix,<adresse>	; routine de la Sub-ROM
		jp SUBROM
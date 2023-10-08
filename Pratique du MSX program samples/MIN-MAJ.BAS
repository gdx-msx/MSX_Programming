	org	0c000h

	cp	3
	ret	nz	; Retour au Basic si ce n'est pas une chaine
;
	ld	a,(de)	; Longueur de la chaine
	or	a
	ret	z	; Retour au Basic si longueur = 0

	ld	b,a	; Nombre de caractères dans B pour DJNZ
CONVC:	inc	de
	ld	a,(de)	; Prend un caractère dans la chaine
	cp	041h
	jr	c,NOCHAR	; Si A < 041H, ce n'est pas une majuscule
	cp	05ah
	jr	nc,NOCHAR	; Si A > 064H, ce n'est pas une majuscule
	or	020h	; Convertie la majuscule en minuscule
	ld	(de),a	; Place le caractère dans la chaine
NOCHAR:	djnz	CONVC
	ret		; retour au Basic
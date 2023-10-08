	org	0c000h
DEBUT:
	ld	a,(7)	; C = Numéro du port E/S correspondant
	ld	c,a	; au port 0 d'écriture du VDP.
	inc	c	; Port E/S du port 1 d'écriture.
;
	ld	a,1	; A=1
	di		; Interruptions interdites.
	out	(c),a	; Envoie de la donnée 1.
	ld	a,80h+16	; A=16 (avec le bit 7 à 1)
	out	(c),a	; Ecriture de la donnée 1 dans le registre 16.
	ei		; Interruptions autorisées
;
	inc	c	; Port E/S du port 2 d'écriture
	ld	a,42h	; rouge=4 bleu =2
	out	(c),a	; Envoie de la donnée 42h.
	ld	a,5	; vert=5
	out	(c),a	; Envoie de la donnée 5.
	ret
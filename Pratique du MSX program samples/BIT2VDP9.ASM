	org	0c000h
DEBUT:
	ld	a,(7)	; C = Num�ro du port E/S correspondant
	ld	c,a	; au port 0 d'�criture du VDP.
	inc	c	; Port E/S du port 1 d'�criture.
;
	ld	a,1	; A=1
	di		; Interruptions interdites.
	out	(c),a	; Envoie de la donn�e 1.
	ld	a,80h+16	; A=16 (avec le bit 7 � 1)
	out	(c),a	; Ecriture de la donn�e 1 dans le registre 16.
	ei		; Interruptions autoris�es
;
	inc	c	; Port E/S du port 2 d'�criture
	ld	a,42h	; rouge=4 bleu =2
	out	(c),a	; Envoie de la donn�e 42h.
	ld	a,5	; vert=5
	out	(c),a	; Envoie de la donn�e 5.
	ret
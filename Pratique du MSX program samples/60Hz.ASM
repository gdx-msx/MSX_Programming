	ORG	0C000H
;
; Le programme suivant active le mode d'affichage
; à 60 Hertz. Sur un téléviseur ou un moniteur
; en 50 Hz, l'image “sautera”. Il faut remettre
; le bit 2 à 0 dans le registre neuf afin de
; rétablir une image normale.
;
DEBUT:	LD	A,(7)	; C = Numéro du port E/S correspondant
	LD	C,A	; au port 0 d'écriture du VDP.
	INC	C	; Port E/S du port 1 d'écriture.
;
	LD	A,(0FFE8h)	; Met le contenu de RG09SAV dans A
	AND	0FDH	; Met le bit 2 à 0
	DI		; Interruptions interdites
	OUT	(C),A	; Envoi sur le port 1
	LD	(0FFE8h),A	; Actualise RG09SAV
	LD	A,80H+9	; Numéro de registre avec bit 7 à 1
	OUT	(C),A	; Envoi sur le port 1
	EI		; Interruptions autorisées
	RET
;
; NOTE: Ce programme lit le contenu de RG09SAV afin de préserver
;       l'état des autres bits du registre
;
END:
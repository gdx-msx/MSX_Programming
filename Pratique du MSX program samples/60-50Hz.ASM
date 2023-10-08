	ORG	0C000H
DEBUT:
	LD	A,(7)	; C = Numéro du port E/S correspondant
	LD	C,A	; au port 0 d'écriture du VDP.
	INC	C	; Port E/S du port 1 d'écriture.

	LD	A,80H+9	; Registre 9 sans auto-incrémentation...
	DI		; Interruptions interdites
	OUT	(C),A
	LD	A,80H+17	; ...dans registre 17 (+80h)
	OUT	(C),A
	EI		; Interruptions autorisées

	INC	C	; Port E/S du port 2 dans C
	INC	C	; Port E/S du port 3 dans C
	LD	A,(0FFE8h)	; Contenu de RG09SAV dans A
	AND	0FDH	; Mettre le bit 2 à 0 (mode 60 Hz)
	OUT	(C),A	; Envoi sur le port 3
	LD	(0FFE8h),A	; Actualise RG09SAV

	CALL	ATTEND	; Appel le sous-programme d'attente

	OR	2	; Met le bit 2 à 1 (mode 50 Hz)
	LD	(0FFE8h),A	; Actualise RG09SAV
	OUT	(C),A	; Envoi sur le port 3
	RET
;
ATTEND:	LD	B,A	; Préserve A
	PUSH	BC	; et C
	LD	BC,0	; Boucle d'attente
BCL:	DEC	BC	; Décremente BC
	NOP		; Petit temps mort 
	LD	A,B
	OR	C
	CP	0
	JR	NZ,BCL	; Saute si BC > 0
	POP	BC	; Restitue C
	LD	A,B	; et A
	RET
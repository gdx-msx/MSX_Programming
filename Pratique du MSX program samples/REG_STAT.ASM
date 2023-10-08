	ORG	0C000H
DEBUT:
	LD	A,(7)	; C = Numéro du port E/S correspondant
	LD	C,A	; au port 0 d'écriture du VDP.
	INC	C	; Port E/S du port 1 d'écriture.
	LD	B,C	; Préserve le Numéro de port dans B

	LD	A,0 
	DI		; Interruptions interdites
	OUT	(C),A	; Numéro du registre de statut...
	LD	A,80H+15	;
	OUT	(C),A	; ...dans le registre 15
		
	LD	A,(6)	; C = Numéro du port E/S correspondant
	LD	C,A	; au port 0 de lecture du VDP
	INC	C		; Port E/S du port 1 d'écriture
	IN	(C),A	; Lecture du registre

	LD	B,C	; Restitue le Numéro de port 1
	LD	A,0
	OUT	(C),A	; Registre de statut 0
	LD	A,80H+15	;
	OUT	(C),A	; dans le registre 15
	EI		; Interruptions autorisées
	RET
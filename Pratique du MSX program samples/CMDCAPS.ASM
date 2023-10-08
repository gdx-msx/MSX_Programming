;
; Instruction CMD CAPS routine
;
CHGCAP	EQU	0132H	; LED CAPS ON/OFF
CAPST	EQU	0FCABH	; Statut de CAPS
HCMD	EQU	0FE0DH	; CMD Hook

	ORG	0D000H-7	; Adresse de la routine - Taille Header
;
; Header
;
	db	0feh
	dw	Debut
	dw	Fin
	dw	Debut
;
; Détournement du Hook CMD
;
Debut:	LD	BC,5	; place les données du nouveau Hook
	LD	DE,HCMD
	LD	HL,HDAT
	LDIR
	RET
;
; Donnée de la routine de détournement (5 octets)
;
HDAT:	JP	CAPKEY
	NOP
	NOP
;
; Routine exécutée par l'instruction CMD
;
CAPKEY:
	CP	043H	; Teste si le premier caractère est "C"
	RET	NZ
	RST	10	; INC HL possible
	LD	A,(HL)
	CP	041H	; Teste si le second caractère est "A"
	RET	NZ
	RST	10	; INC HL possible
	LD	A,(HL)
	CP	050H	; Teste si le second caractère est "P"
	RET	NZ
	RST	10	; INC HL possible
	LD	A,(HL)
	CP	053H	; Teste si le second caractère est "S"
	RET	NZ

	LD	A,(CAPST)
	CPL
	LD	(CAPST),A
	AND	1
	CALL	CHGCAP
RETBASIC:
	POP	AF	; Pour ne pas avoir d'erreur
	RST	10	; Pointeur à la fin de l'instruction
	RET
fin:
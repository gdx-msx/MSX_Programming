;
; Utilisation : CMD Z80 ou CMD R800 sous MSX-Basic
;
CHGCPU	EQU	0180h	; Change le CPU Z80/R800
HCMD	EQU	0fe0dh	; CMD Hook

	ORG	0d000h-7	; Adresse de la routine - 7
;
; Header (taille = 7 octets)
;
	DB	0feh
	DW	Debut
	DW	Fin
	DW	Debut
;
; Détournement de l'instruction CMD via le Hook
;
Debut:	LD	BC,5
	LD	DE,HCMD
	LD	HL,HDAT
	LDIR		; place les données du nouveau Hook
	RET
;
; Nouvelles données du HOOK (5 octets)
;
HDAT:	JP	R800ROM
	NOP
	NOP
;
; CMD Z80 ou CMD R800? (Routine exécutée par CMD)
;
R800ROM:	CP	5AH	; Teste si le premier caractère
	JR	Z,Z80MODE	; du paramètre est "Z"
	CP	052H	; Teste si c'est "R"
	RET	NZ
	RST	10	; INC HL possible
	LD	A,(HL)
	CP	038H	; Teste si le second caractère est "8"
	RET	NZ
	RST	10	; INC HL possible
	LD	A,(HL)
	CP	030H	; Teste si le troisième est "0"
	RST	10
	RST	10	; INC HL possible
	LD	A,(HL)
	CP	030H	; Teste si le quatrième est "0"
	RET	NZ
	LD	A,081H	; R800 mode ROM
	JR	RETBASIC
Z80MODE:
	RST	10	; INC HL possible
	LD	A,(HL)
	CP	038H	; Teste si le second caractère est "8"
	RET	NZ
	RST	10	; INC HL possible
	LD	A,(HL)
	CP	030H	; Teste si le troisième est "0"
	RET	NZ
	LD	A,080H	; Z80
RETBASIC:
	CALL	CHGCPU	; Change le CPU
	POP	AF	; Pour ne pas avoir d'erreur
	RST	10	; Pointeur à la fin de l'instruction
	RET
Fin:
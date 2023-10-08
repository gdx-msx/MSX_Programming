		ORG 0C000H
	;
	ENASLT	EQU 00024H
	FIND:		LD B,0FH
			LD HL,04000H		; Plage 1
	LOOP:		LD A,B
			OR 080H
			PUSH BC
			PUSH AF
			PUSH HL
			CALL ENASLT		; Sélection de Slot
			POP HL
			POP AF
			LD (HL),A
			LD B,(HL)
			CP B
			POP BC
			JR Z,RAM
			DJNZ LOOP			; Cherche la RAM
	;
	RIEN:		JR RETOUR 
	;
	RAM:		LD IX,04000H
			LD (IX+0),041H		; Code “A”
			LD (IX+1),042H		; Code “B”
			LD (IX+2),000H		; Adresse de
			LD (IX+3),0C1H		; départ
			JR RETOUR 
	;
	MNROM		EQU 0FCC1H
	RETOUR:	LD A,(MNROM)
			LD HL,04000H		; Replace la Main-ROM
			CALL ENASLT		; en plage 1.
			RET 
	;
	;
	;
			ORG 0C100H
	;
	BREAKX	EQU 000B7H
	INITXT	EQU 0006CH
	;
			CALL INITXT		; SCREEN 0, 40 colonne
			LD HL,MESS
			CALL ECRIRE
	WAIT:		CALL BREAKX		; Teste CTRL+STOP
			RET C
			JR WAIT
	ECRIRE :	LD A,(HL)
			CP 0
			RET Z
			CALL 0A2H
			INC HL
			JR ECRIRE
	MESS:		DB 01BH,'Y*&'
			DB 'LE RESET NE REND'
			DB ' PAS LA MAIN !',0
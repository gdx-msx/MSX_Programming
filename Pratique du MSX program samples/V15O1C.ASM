WRTPSG	equ	00093h

; --- Entête du fichier
	db	0feh	; Fichier binaire code
	dw	START	; Adresse de destination du programme
	dw	END	; Adresse de fin du programme
	dw	START	; Adresse d'exécution du programme
; ---
	org	0c000h
START:	
	ld	b,13
PSGini:	ld	a,b	; 
	ld	e,0	; 8 bits de poids faible
	cp	7
	jr	nz,NoR7	; Saut si registre différent de 7 
	ld	e,10111111b	; Le bit 7 à 1 et le bit 6 à 0
NoR7:	call	WRTPSG
	djnz	PSGini	; boucle pour initialiser les registres 

	ld	a,0	; Registre 0
	ld	e,0ach	; 8 bits de poids faible
	call	WRTPSG
	ld	a,1	; Registre 1
	ld	e,1	; 4 bits de poids fort
	call	WRTPSG
	ld	a,8	; Registre 8
	ld	e,1100b	; Volume de la voix 1 à 12
	call	WRTPSG
	ld	a,7	; Registre 7
	ld	e,10111110b	; Active la voix 1 
	call	WRTPSG
	ret
END:
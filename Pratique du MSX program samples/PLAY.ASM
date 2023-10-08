PLAY	equ	073e5h

	DB	0feh	; Entête pour les
	DW	START,END,START	; fichiers binaires

	org	0c000h
START:
	ld	hl,DATA
	call	PLAY
	ret 
;
DATA:	db	22h,'O5L6DABDACF',22h
	db	22h,'O3L4DEDE',22h
	db	22h,'O7L8ADEFGED',22h,0
END:
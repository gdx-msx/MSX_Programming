; Appeler une routine du Bios en Main-ROM sous MSX-DOS
; Attention, cette routine ne peut pas appeler de routine en SUB-ROM

CALSLT	equ 001ch		; Routine d'appel inter-Slot
EXPTBL	equ 0fcc1h		; Octet indiquant le Slot de la Main-ROM
BEEP	equ 000c0h		; Routine d'émission d'un bip sonore

DEBUT:	ld iy,(EXPTBL-1)	; Emplacement de la Main-ROM dans IY
	ld ix,BEEP		; Adresse de la routine BEEP dans IX
	call CALSLT	; Appel la routine BEEP
END:
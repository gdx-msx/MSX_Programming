PHYDIO	EQU	0114H

	ORG	0D000H
RDSECT:
	LD	A,0	; Lecteur “A:”
	LD	B,1	; nombre de secteur à lire = 1
	LD	C,0F9H	; Disquette double face 3.5”
	LD	DE,0	; premier secteur
 	LD	HL,(0F351h)	; vers Buffer de secteur du Disk-Basic
	OR	A	; Lecture (mettre SCF pour écriture)
	CALL	PHYDIO	; Lecture du secteur 0
10 SCREEN 0: WIDTH80
20 COLOR 10,0,0: FOR I=&H800+239: VPOKE I,0: NEXT
30 VDP(13)=&H10:VDP(14)=&H44 ' registre 12 = 010H et reg. 13 = 044H
40 PRINT"Ce petit programme permet de faire clignoter automatiquement un texte !": PRINT: PRINT: VPOKE &H804,&H1F: VPOKE &H805,&HF0
10 SCREEN 1: WIDTH 32: COLOR 10,1: Sprite$(1)="I"+CHR$(127)+"I"+CHR$(8)+ "I"+CHR$(127)+"I"+CHR$(8): PRINT: PRINT: FOR I=1 TO 4:PRINT"- RALLY -";: NEXT: LOCATE 5,12: INPUT"NIVEAU (1 ou 2)";NN: NN=NN+1:IF NN=3 THEN N=4: DD=4 ELSE N=8: DD=2
20 FOR I=0 TO 7: VPOKE&H208+I,128: NEXT: FOR I=0 TO 7:VPOKE&H210+I,1: NEXT: T=3:X=40:Y=88: PUT Sprite 1,(X,Y),9:COLOR 10,2: FOR I=0 TO 23: PRINT TAB(T-1);"B"+STRING$(N+1,"O")+"A": NEXT: VPOKE&H2004,&HC2: VPOKE&H2009,17: VPOKE&H2006,&HF2: COLOR=(2,1,1,2)
30 LOCATE 20,5:PRINT"Attention": FOR J=3 TO 1 STEP -1:LOCATE 23,7: PRINT J : PLAY"L8D": FOR I=1 TO 800: NEXT I,J: LOCATE 20,5: PRINT SPACE$(9):LOCATE 24,7:PRINT" ": LOCATE 0,24:PLAY"L2O6A"
40 SC=SC+1: PUT Sprite 1,(X,Y),8:I=&H1960+X/8: IF VPEEK(I)<>79 OR VPEEK (I+1)<>79 THEN 100 ELSE D=INT(RND(14)*3):D=-D*(T>2 AND T+N<29)-2*(T<=2)-(T+N>=29): ON D GOTO 60,70
50 PRINT TAB (T-1);"B"+STRING$(N+1,"O")+"A":GOTO 80
60 T=T-1:PRINT TAB (T);"/"+STRING$(N,"O")+"/"):GOTO 80
70 T=T+1:PRINT TAB (T-1);"\"+STRING$(N,"O")+"\":GOTO 80
80 I=STICK(0): IF I=3 THEN X=X+DD else IF I=7 THEN X=X-DD
90 GOTO 40
100 VPOKE&H2007,&HF2: VPOKE&H200A,&H72: VPOKE&H200C,&H72: VPOKE&H200D,&H72: VPOKE&H200E,&H72: LOCATE 1,23: PRINT"Score =";SC*10;: FOR I=1 TO 100000!: NEXT
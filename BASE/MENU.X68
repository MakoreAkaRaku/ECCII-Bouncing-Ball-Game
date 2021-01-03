MENPLOT     
            MOVEM.L D0-D4/A0-A1,-(A7)
            MOVE.B  #80,D0
            MOVE.L  #MENPCOL,D1             ;SETTING RECTANGLE'S BORDER COLOR
            TRAP    #15
            MOVE.B  #81,D0
            MOVE.L  #MENFCOL,D1             ;SETTING RECTANGLE'S FILL COLOR
            TRAP    #15
            MOVE.B  #87,D0
            MOVE.W  #SCRWIDTH/2,D1          ;
            MOVE.W  #SCRHEIGH/2,D2          ;
            MOVE.W  D1,D3                   ;
            MOVE.W  D2,D4                   ;
            SUB.W   #MENWIDTH/2,D1          ; FIXING WHERE TO PRINT THE RECTANGLE,
            ADD.W   #MENWIDTH/2,D3          ; RIGHT BELOW THE MIDDLE OF THE 
            ADD.W   #MENHEIGH,D4            ; SCREEN
            TRAP    #15
            MOVE.W  #$3A00,D1
            ADD.W   #128/4+4,D1
            LEA     .STAGAME,A0
.PRINOPT    MOVE.L  A0,A1
            MOVE.B  #11,D0
            TRAP    #15
            ADD.B   #4,D1
            MOVE.B  #13,D0
            TRAP    #15
            ADD.L   #12,A0
            CMP     #.EXTGAME,A1
            BMI     .PRINOPT
            MOVEM.L (A7)+,D0-D4/A0-A1
            RTS
            
.STAGAME    DC.B    'START GAME ',0
.HTPGAME    DC.B    'HOW TO PLAY',0
            DC.B    '  SCORE    ',0
.EXTGAME    DC.B    '   EXIT    ',0
            DS.W    0

*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~

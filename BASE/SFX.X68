; =============================================================================
; TITLE    : SFX SOUND MANAGEMENT
; AUTHOR   : MARC ROMAN COLOM
; HISTORY  :
; =============================================================================

SFXINIT     
            MOVEM.L D0-D1/A1,-(A7)
            LEA     SFXMAIN,A1              ;PLACING FILENAME REFERENCE TO A1
            MOVE.B  #0,D1                   ;PREPARING D1 FOR REFEER TO SOUND FILE
            MOVE.B  #71,D0                  ;PREPARING D0 TO LOAD SOUND FILE
            TRAP    #15
            MOVEM.L (A7)+,D0-D1/A1
            RTS
SFXPMAIN    
            MOVEM.L D0-D2,-(A7)
            MOVE.B  #0,D1
            MOVE.L  #1,D2
            MOVE.B  #76,D0
            TRAP    #15
            MOVEM.L (A7)+,D0-D2
            RTS
SFXSTOP     
            MOVEM.L D0-D2,-(A7)
            MOVE.B  #0,D1
            MOVE.L  #1,D2
            MOVE.B  #77,D0
            TRAP    #15
            MOVEM.L (A7)+,D0-D2
            RTS
*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~

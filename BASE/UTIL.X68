*-----------------------------------------------------------
* TITLE     : UTILITES MANAGEMENT
* AUTHOR    : MARC ROMAN COLOM
* HISTORY   : FILE USED TO MAKE EASIER TO UNDERSTAND AND
* PROGRAM THIS MASTERPIECE (USED ONLY TO STORE USEFUL SBR)
*-----------------------------------------------------------

*-----------------------------------------------------------
SWAPPL
; SWAPS PLAYER'S CONTENT STORED IN MEMORY FROM BUFFER ONE.
; INPUT:
;           A1.L    -> MEMORY ADDRESS OF PLAYER2.
; OUTPUT:   NONE
; MODIFIES: CONTENT OF MEMORY ADDRESS OF SRC AND DST.
*-----------------------------------------------------------
            MOVEM.L  A0-A1,-(A7)
            LEA     PLNAME,A0
            MOVE.L  (A0)+,.AUX2             ;
            MOVE.L  (A1),-(A0)              ; SWAPPING PLAYER
            MOVE.L  .AUX2,(A1)+             ; NAMES
            LEA     SCORE,A0
            MOVE.L  (A0)+,.AUX1             ;
            MOVE.L  (A1)+,-(A0)             ; SWAPPING SCORES
            MOVE.L  .AUX1,-(A1)             ;
            MOVEM.L (A7)+,A0-A1
            RTS
.AUX2       DS.L    1
.AUX1       DS.L    1



*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~

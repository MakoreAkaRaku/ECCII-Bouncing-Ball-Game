; -----------------------------------------------------------------------------
ARINIT
; INITIALIZE THE ARROW FROM MAIN MENU.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  #$3700,ARPOS
            ADD.W   #128/4+4,ARPOS
            RTS
ARWUPD     
            BTST.B  #KBDBITUP,(KBDVAL)              ;UP KEY PRESSED?
            BNE     .MOVEU
            BTST.B  #KBDBITDN,(KBDVAL)              ;DOWN KEY PRESSED?
            BNE     .MOVED
.RTN        RTS
.MOVEU      CMP     #$3724,ARPOS
            BEQ     .TOBOT
            SUB.W   #4,ARPOS
            BRA     .RTN
.MOVED      CMP     #$3730,ARPOS
            BEQ     .TOTOP
            ADD.W   #4,ARPOS
            BRA     .RTN
.TOBOT      MOVE.W  #$3730,ARPOS
            BRA     .RTN
.TOTOP      MOVE.W  #$3724,ARPOS
            BRA     .RTN
ARWPLOT
            MOVEM.L D0-D1/A1,-(A7)
            LEA     .ARROW,A1
            MOVE.B  #11,D0
            MOVE.W  ARPOS,D1
            TRAP    #15
            MOVE.B  #13,D0
            TRAP    #15
            MOVEM.L (A7)+,D0-D1/A1
            RTS
.ARROW      DC.B    '=>',0



*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~

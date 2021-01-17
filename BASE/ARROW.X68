; -----------------------------------------------------------------------------
ARINIT
; INITIALIZE THE ARROW FROM MAIN MENU.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  #ARINIPOS,ARPOS
            RTS
; -----------------------------------------------------------------------------
ARWUPD
; UPDATES THE ARROW FROM MAIN MENU.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------     
            MOVE.L  D1,-(A7)
            MOVE.B  #2,D1
            BTST.B  #KBDBITUP,(KBDEDGE)     ;UP KEY PRESSED?
            BNE     .MOVEU
            BTST.B  #KBDBITDN,(KBDEDGE)     ;DOWN KEY PRESSED?
            BNE     .MOVED
.RTN        MOVE.L  (A7)+,D1
            RTS
.MOVEU      JSR     SFXPLAY                 ;PLAY ENTER SOUND
            CMP     #ARINIPOS,ARPOS
            BEQ     .TOBOT
            SUB.W   #4,ARPOS                ; MOVING TO AN UPPER POSITION
            BRA     .RTN
.MOVED      JSR     SFXPLAY
            CMP     #ARFINPOS,ARPOS
            BEQ     .TOTOP
            ADD.W   #4,ARPOS                ; MOVING TO A BOTTOM POSITION
            BRA     .RTN
.TOBOT      MOVE.W  #ARFINPOS,ARPOS
            BRA     .RTN
.TOTOP      MOVE.W  #ARINIPOS,ARPOS
            BRA     .RTN
; -----------------------------------------------------------------------------
ARWPLOT
; PAINTS THE ARROW FROM MAIN MENU.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------  
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
            DS.W    0






*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~

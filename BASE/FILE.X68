; =============================================================================
; TITLE    : FILE MANAGEMENT
; AUTHOR   : ANTONI BURGUERA
; HISTORY  : XX-XXX-201X - CREATION
;            11-OCT-2020 - MINOR CHANGES
; =============================================================================
; -----------------------------------------------------------------------------
FILEOPN
; OPENS AN EXISTING FILE
; INPUT    - A1.L-->FILE NAME
; OUTPUT   - D1.L-->FILE DESCRIPTOR
; MODIFIES - NONE
; -----------------------------------------------------------------------------
	MOVE.L  D0,-(A7)
            MOVE.W  #51,D0
	TRAP	#15
	MOVE.L  (A7)+,D0
	RTS	
; -----------------------------------------------------------------------------
FILECLS
; CLOSE THE FILE FROM FILE DESCRIPTOR
; INPUT    - D1.L-->FILE DESCRIPTOR
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
	MOVE.L  D0,-(A7)
            MOVE.W	#56,D0
	TRAP 	#15
	MOVE.L  (A7)+,D0
	RTS
; -----------------------------------------------------------------------------
FILEWRD
; WRITE INTO THE CURRENT FILE FROM FILE DESCRIPTOR WITH THE CONTENT OF BUFFER
; CAUTION: THE ACTUAL CONTENT HAS TO BE 5 PLAYER'S DATA.
; INPUT    - D1.L-->ADDRES OF CURRENT FILE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------	
            MOVEM.L D0/D2/A1,-(A7)
            LEA     BUFFER,A1
	MOVE.L  #40,D2                  ; SIZE OF THE WHOLE PLAYER DATA
            MOVE.W	#54,D0
	TRAP    #15                     ; WRITE THE WHOLE PLAYER'S DATA
            MOVEM.L (A7)+,D0/D2/A1	
	RTS
; -----------------------------------------------------------------------------
FILERD
; READS THE WHOLE FILE FROM FILE DESCRIPTOR AND EXTRACTS IT'S CONTENT AND PUT IT
; ON THE TEMPORAL BUFFER. 
; INPUT    - D1.L-->FILE DESCRIPTOR
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------	
            MOVEM.L D0/D2/A1,-(A7)
            LEA     BUFFER,A1
            MOVE.L  #1,D2                   ; ONE BYTE SIZE FOR READING
            CLR     D0
.LP         MOVE.W  #53,D0
            TRAP    #15
            ADD.L   #1,A1
            CMP     #1,D0                   ; IF WE DID NOT READ EOF, KEEP READING.
            BNE     .LP
            MOVE.B  #NULL,-(A1)
            MOVEM.L (A7)+,D0/D2/A1
            RTS
; -----------------------------------------------------------------------------
FILERDPL
; READS ONE PLAYER DATA FROM FILE DESCRIPTOR AND SAVES IT'S CONTENT INTO PLAYER
; PNAME BUFFER AND SCORE BUFFER. THE PLAYER'S DATA HAS 4 BYTES FIELD FOR PLAYER_NAME
; AND 4 BYTES FIELD FOR SCORE. A PLAYER'S DATA WHEIGHTS 8 BYTES IN TOTAL.
; INPUT     - D1.L  --> FILE DESCRIPTOR
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0/D2/A1,-(A7)
            LEA     PLNAME,A1
            MOVE.L  #4,D2
            MOVE.B  #53,D0
            TRAP    #15                     ;READ PLAYER_NAME DATA
            LEA     SCORE,A1
            MOVE.L  #4,D2            
            MOVE.B  #53,D0
            TRAP    #15                     ;READ SCORE DATA
            MOVEM.L (A7)+,D0/D2/A1
            RTS






*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~

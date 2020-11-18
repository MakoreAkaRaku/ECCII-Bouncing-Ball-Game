; =============================================================================
; TITLE    : PAD MANAGEMENT
; AUTHOR   : FAUSTI RODRIGUEZ
; COMMENTS :
; HISTORY  : 
; =============================================================================

; -----------------------------------------------------------------------------
PADINIT
; INITIALIZE THE PAD
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  #SCRWIDTH/2,(PADX)
            MOVE.W  #SCRHEIGH/2,(PADY)
            RTS
; -----------------------------------------------------------------------------
PADUPDKB
; UPDATE THE PAD WITH KEYBOARD
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            BTST.B  #KBDBITLF,(KBDVAL)      ; LEFT KEY PRESSED?
            BNE     .MOVEL                  ; YES: MOVE LEFT
            BTST.B  #KBDBITRT,(KBDVAL)      ; RIGHT KEY PRESSED?
            BNE     .MOVER                  ; YES: MOVE LEFT
            BTST.B	#KBDBITUP,(KBDVAL)	; UP KEY PRESSED?
            BNE	.MOVEU	; YES: MOVE UP
            BTST.B	#KBDBITDN, (KBDVAL)	; DOWN KEY PRESSED?
            BNE	.MOVED	; YES: MOVE DOWN 
            RTS		
            
.MOVEL      CMP.W   #PADWIDTH/2,(PADX)      ; BELOW LEFT BOUNDARY?
            BGT     .DOL                    ; NO: MOVE
            RTS                             ; YES: END
.DOL        SUB.W   #PADSPEED,(PADX)        ; MOVE LEFT
            RTS
.MOVER      CMP.W   #SCRWIDTH-1-PADWIDTH/2,(PADX) ; HIGHER THAN RIGHT BOUNDARY?
            BLT     .DOR                    ; NO: MOVE
            RTS                             ; YES: END
.DOR        ADD.W   #PADSPEED,(PADX)        ; MOVE RIGHT
            RTS
.MOVEU	CMP.W	#PADHEIGH/2,(PADY)	; BELOW UP BOUNDARY?
	BGT	.DOU	; NO: MOVE
	RTS		; YES: END
.DOU	SUB.W	#PADSPEED,(PADY)	; MOVE UP
	RTS		
.MOVED      CMP.W	#SCRHEIGH-1-PADHEIGH/2,(PADY) ; HIGHER THAN DOWN BOUNDARY?                      
	BLT	.DOD	; NO: MOVE
	RTS		; YES: END
.DOD	ADD.W	#PADSPEED,(PADY)	; MOVE DOWN
	RTS	
; -----------------------------------------------------------------------------
PADUPDMS
; UPDATE THE PAD WITH MOUSE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
	MOVEM.L	D0-D2,-(A7)
	CLR.B	D1
	MOVE.W	#61,D0
	TRAP	#15
	MOVE.W	D1,(PADX)
	LSR.L	#8,D1
	LSR.L	#8,D1
	MOVE.W	D1,(PADY)	
.END	
	MOVEM.L (A7)+,D0-D2
	RTS
; -----------------------------------------------------------------------------
PADPLOT
; PLOT THE PAD
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)             ; STACK REGISTER
            MOVE.B  #80,D0                  ; SET PEN COLOR TASK
            MOVE.L  #PADPCOL,D1             ; PEN COLOR
            TRAP    #15                     ; SET PEN COLOR
            ADDQ.B  #1,D0                   ; SET FILL COLOR TASK
            MOVE.L  #PADFCOL,D1             ; FILL COLOR
            TRAP    #15                     ; SET FILL COLOR
            
            MOVE.W  (PADX),D1               ; D1:=XCENTER
            MOVE.W  (PADY),D2                ; D2:=YCENTER
            MOVE.W  D1,D3                   ; D3:=XCENTER
            MOVE.W  D2,D4                   ; D4:=YCENTER
            SUB.W   #PADWIDTH/2,D1          ; D1:=XLEFT
            SUB.W   #PADHEIGH/2,D2          ; D2:=YTOP
            ADD.W   #PADWIDTH/2,D3          ; D3:=XRIGHT
            ADD.W   #PADHEIGH/2,D4          ; D4:=YBOTTOM
            MOVE.B  #88,D0
            TRAP    #15                     ; DRAW RECTANGLE
            MOVEM.L (A7)+,D0-D4             ; RESTORE REGISTERS
            RTS



*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~

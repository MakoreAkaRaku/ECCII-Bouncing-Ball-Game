; =============================================================================
; TITLE    : BALL MANAGEMENT (AGENT)
; AUTHOR   : ANTONI BURGUERA
; COMMENTS : BALL AGENT LOCAL VARIABLES:
;            (A0) : XCENTER - WORD
;           2(A0) : YCENTER - WORD
;           4(A0) : ZCENTER - WORD
;           6(A0) : XSPEED  - WORD
;           8(A0) : YSPEED  - WORD
;           A(A0) : ZSPEED  - WORD
; HISTORY  : 12-10-2020 - CREATION
; =============================================================================

; -----------------------------------------------------------------------------
BALINIT
; INITIALIZE A BALL
; INPUT    - D1.W = XCENTER'S BALL POSITION
;          - D2.W = YCENTER'S BALL POSITION
; OUTPUT   - NONE 
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D1-D2/A1,-(A7)          ; STACK REGISTERS
            MOVE.L  D7,-(A7)
            MOVE.W  D1,(A0)                 ; XBALL=D1
            MOVE.W  D2,2(A0)                ; YBALL=D2
            LEA     .SPEEDS,A1
            CLR     D7
            ADD.W   D3,D7
            ADD.W   D6,D7
            BTST    #0,D7
            BEQ     .DOWN
            MOVE.L  4(A1),6(A0)
            BRA     .END
.DOWN       MOVE.L  (A1),6(A0)              ; INIT SPEEDS
.END        MOVE.L  (A7)+,D7
            MOVEM.L (A7)+,D1-D2/A1
            RTS
.SPEEDS     DC.W    -BALSPEED,BALSPEED
            DC.W    BALSPEED,-BALSPEED
            DC.W    0,0
; -----------------------------------------------------------------------------
BALUPD
; UPDATE A BALL
; INPUT    - NONE
; OUTPUT   - NONE 
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  D0,-(A7)                ; STACK REGISTERS
            MOVE.W  (A0),D0                 ;
            ADD.W   6(A0),D0                ;
            MOVE.W  D0,(A0)                 ; X:=X+VX
            MOVE.W  2(A0),D0                
            ADD.W   8(A0),D0
            MOVE.W  D0,2(A0)                ; Y:=Y+VY
            
            CMP.W   #0,(A0)                 ;IF BALL EXITS SCREEN ON THE LEFT
            BMI     .TPRIGHT                ;SIDE, TELEPORT BALL TO RIGHT SIDE.
            CMP.W   #SCRWIDTH,(A0)          ;IF BALL EXITS SCREEN ON THE RIGHT
            BGT     .TPLEFT                 ;SIDE, TELEPORT BALL TO LEFT SIDE.
.ENDR       CMP.W   #SCRHEIGH,2(A0)         ;IF BALL EXITS SCREEN ON THE
            BGT     .TPTOP                  ;BOT SIDE, TELEPORT BALL TO TOP SIDE.
            CMP.W   #0,2(A0)                ;IF BALL EXITS SCREEN ON THE BOTTOM
            BMI     .TPBOT                  ;SIDE, TELEPORT BALL TO BOT SIDE.
.ENDT       MOVE.W  (A7)+,D0
	RTS
	
.TPTOP      MOVE.W  #0,2(A0)
            BRA     .ENDT
.TPBOT      MOVE.   #SCRHEIGH,2(A0)
            BRA     .ENDT
.TPRIGHT    MOVE.W  #SCRWIDTH,(A0)
            BRA     .ENDR
.TPLEFT     MOVE.W  #0,(A0)
            BRA     .ENDR
; -----------------------------------------------------------------------------
BALPLOT
; PLOT A BALL
; INPUT    - NONE
; OUTPUT   - NONE 
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)             ; STACK REGISTERS
            MOVE.B  #80,D0                  ; SET PEN COLOR TASK
            MOVE.L  #BASPCOL,D1             ; PEN SHADOW COLOR
            TRAP    #15                     ; SET PEN COLOR
            ADDQ.B  #1,D0                   ; SET FILL COLOR TASK
            MOVE.L  #BASFCOL,D1             ; FILL SHADOW COLOR
            TRAP    #15                     ; SET FILL COLOR
            
            MOVE.W  (A0),D1                 ; D1:=XCENTER
            MOVE.W  2(A0),D2                ; D2:=YCENTER
            MOVE.W  D1,D3                   ; D3:=XCENTER
            MOVE.W  D2,D4                   ; D4:=YCENTER
            
            SUB.W   #BALRAD,D1              ; D1:=XLEFT
            SUB.W   #BALRAD,D2              ; D2:=YTOP
            ADD.W   #BALRAD,D3              ; D3:=XRIGTH
            ADD.W   #BALRAD,D4              ; D4:=YBOTTOM
            MOVE.B  #88,D0                  ; DRAW ELLIPSE/CIRCLE TASK
            TRAP    #15                     ; DO IT
            
            MOVE.L  #BALMCOL,D1             ;SET BALL'S MAIN COLOR
            MOVE.B  #80,D0
            TRAP    #15
            MOVE.B  #81,D0
            TRAP    #15

            MOVE.W  (A0),D1                 ; D1:=XCENTER            
            SUB.W   #BALRAD-1,D1            ; D1:=XLEFT
            SUB.W   #1,D2                   ; D2:=YTOP
            SUB.W   #1,D3                   ; D3:=XRIGTH
            SUB.W   #6,D4                   ; D4:=YBOTTOM
            MOVE.B  #88,D0                  ; DRAW ELLIPSE/CIRCLE TASK
            TRAP    #15                     ; DO IT
            
            MOVE.L  #BALBCOL,D1             ;SET BALL'S BRIGHT COLOR
            MOVE.B  #80,D0
            TRAP    #15
            MOVE.B  #81,D0
            TRAP    #15
            
            MOVE.W  (A0),D1                 ; D1:=XCENTER            
            SUB.W   #BALRAD-5,D1            ; D1:=XLEFT
            ADD.W   #2,D2                   ; D2:=YTOP
            SUB.W   #5,D3                   ; D3:=XRIGTH
            SUB.W   #17,D4                   ; D4:=YBOTTOM
            MOVE.B  #88,D0                  ; DRAW ELLIPSE/CIRCLE TASK
            TRAP    #15                     ; DO IT


            MOVEM.L (A7)+,D0-D4
            RTS
            


          
            












*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~

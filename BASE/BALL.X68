; =============================================================================
; TITLE    : BALL MANAGEMENT (AGENT)
; AUTHOR   : ANTONI BURGUERA
; COMMENTS : BALL AGENT LOCAL VARIABLES:
;             (A0) : XCENTER - WORD
;            2(A0) : YCENTER - WORD
;            4(A0) : XSPEED  - WORD
;            6(A0) : YSPEED  - WORD
; HISTORY  : 12-10-2020 - CREATION
; =============================================================================

; -----------------------------------------------------------------------------
BALINIT
; INITIALIZE A BALL
; INPUT    - NONE
; OUTPUT   - NONE 
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0/A1,-(A7)             ; STACK REGISTERS
            ;JSR     RNDGET                  ; D0.L=RND(0,255)
            MOVE.W   #SCRWIDTH/2,D0      ; D0.W=RND(XC-127,XC+128)
            MOVE.W  D0,(A0)                 ; XBALL=D0
            ;JSR     RNDGET                  ; D0.L=RND(0,255)
            MOVE.W   #SCRHEIGH/2,D0      ; D0.W=RND(YC-127,YC+128)
            MOVE.W  D0,2(A0)                ; YBALL=D0
            
            ;JSR     RNDGET                  ; DO.L=RND(0,255)
            ;AND.L   #%00001100,D0           ; MASK D0
            ;LEA     .SPEEDS,A1              ; GET VECTOR ADDRESS
            ;MOVE.L  (A1,D0),4(A0)           ; INIT SPEEDS
            MOVEM.L (A7)+,D0/A1
            RTS
            
*.SPEEDS     DC.W    BALSPEED,BALSPEED
*            DC.W    BALSPEED,-BALSPEED
*            DC.W    -BALSPEED,BALSPEED
*            DC.W    -BALSPEED,-BALSPEED
; -----------------------------------------------------------------------------
BALUPD
; UPDATE A BALL
; INPUT    - NONE
; OUTPUT   - NONE 
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  D0,-(A7)                ; STACK REGISTERS
            
            MOVE.W  (A0),D0
            ADD.W   4(A0),D0
            ADD.W	#1,D0
            MOVE.W  D0,(A0)                 ; X:=X+VX
            MOVE.W  2(A0),D0
            ADD.W   6(A0),D0
            ADD.W	#1,D0
            MOVE.W  D0,2(A0)                ; Y:=Y+VY
            
            MOVE.W  (A7)+,D0
            
	RTS
; -----------------------------------------------------------------------------
BALPLOT
; PLOT A BALL
; INPUT    - NONE
; OUTPUT   - NONE 
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)             ; STACK REGISTERS
            MOVE.B  #80,D0                  ; SET PEN COLOR TASK
            MOVE.L  #BALPCOL,D1             ; PEN COLOR
            TRAP    #15                     ; SET PEN COLOR
            ADDQ.B  #1,D0                   ; SET FILL COLOR TASK
            MOVE.L  #BALFCOL,D1             ; FILL COLOR
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
            MOVEM.L (A7)+,D0-D4
            RTS
            


          
            

*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~

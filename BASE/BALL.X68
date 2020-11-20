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
            
            MOVE.W   #SCRWIDTH/2,D0      
            MOVE.W  D0,(A0)                 ; XBALL=D0

            MOVE.W   #SCRHEIGH/2,D0      
            MOVE.W  D0,2(A0)                ; YBALL=D0
            
            MOVE.W   #0,D0      
            MOVE.W  D0,4(A0)                ; SPEEDX=D0
                              
            MOVE.W   #0,D0     
            MOVE.W  D0,6(A0) 	; SPEEDY=D0
            
            MOVE.W	 #80,D0	
	MOVE.W	D0,8(A0)	; BALRAD=D0	
	
	MOVE.W   #0,D0       	
            MOVE.W  D0,10(A0)               ; SPEEDZ=D0  

	MOVE.W	#-1,D0
	MOVE.W	D0,12(A0)	; DACCELERATEZ=D0
	
	MOVE.W #0,D0
	MOVE.W D0,14(A0)	; Timer
	
            MOVEM.L (A7)+,D0/A1
            RTS
; -----------------------------------------------------------------------------
BALUPD
; UPDATE A BALL
; INPUT    - NONE
; OUTPUT   - NONE 
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.W  D0/D1 ,-(A7)                ; STACK REGISTERS
            
            MOVE.W 14(A0),D0
            
            CMP #1,D0
            BNE .NOTIME	;DONT UPDATE
            
	MOVE.W #0,D0
	MOVE.W D0,14(A0) 
            BRA .TIME
.NOTIME	
	ADDQ.W #1,D0
	MOVE.W D0,14(A0)
	BRA .ENDU   
.TIME         
            ;MOVE.W  (A0),D0
            ;ADD.W   4(A0),D0	;XSPEED	
            ;ADD.W	#1,D0
            ;MOVE.W  D0,(A0)                 ; X:=X+VX
            
            ;MOVE.W  2(A0),D0
            ;ADD.W   6(A0),D0	;YSPEED
            ;ADD.W	#1,D0	
            ;MOVE.W  D0,2(A0)                ; Y:=Y+VY
            
            CMP #20,8(A0)	;Crear constante de minima dimension de la bola
            BGE .NREBOUND	; YES? REBOUND IF:
            ;--- REBOUND?---------
            MOVE.W (A0),D0
            ;SUB.W 8(A0),D0 	;INTRO X LEFT?
            MOVE.W (PADX),D1
            SUB.W #PADWIDTH/2,D1
            CMP D1,D0
            BLT .ILEGAL
            
            MOVE.W (A0),D0
            ;ADD.W 8(A0),D0 	;INTRO X RIGTH?
            MOVE.W (PADX),D1
            ADD.W #PADWIDTH/2,D1
            CMP D1,D0
            BGT .ILEGAL
            
            MOVE.W 2(A0),D0
            ;SUB.W 8(A0),D0 	;INTRO Y UP?
            MOVE.W (PADY),D1
            SUB.W #PADHEIGH/2,D1
            CMP D1,D0
            BLT .ILEGAL
            
            MOVE.W 2(A0),D0
            ;ADD.W 8(A0),D0 	;INTRO X DOWN?
            MOVE.W (PADY),D1
            ADD.W #PADHEIGH/2,D1
            CMP D1,D0
            BGT .ILEGAL
            
            ;--------------------
	MOVE.W 10(A0),D0	
          	NOT D0
          	ADDQ.W #2,D0
	MOVE.W D0,10(A0) 
	 
.NREBOUND	  
            MOVE.W	10(A0),D0
            ADD.W	12(A0),D0
            MOVE.W	D0,10(A0)
	
	MOVE.W 8(A0),D0
	ADD.W 10(A0),D0
	MOVE.W D0,8(A0)
.ENDU	
            MOVEM.W  (A7)+,D0/D1
            
	RTS
.ILEGAL
	
		
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
            
            SUB.W   8(A0),D1              ; D1:=XLEFT
            SUB.W   8(A0),D2              ; D2:=YTOP
            ADD.W   8(A0),D3              ; D3:=XRIGTH
            ADD.W   8(A0),D4              ; D4:=YBOTTOM
            MOVE.B  #88,D0                  ; DRAW ELLIPSE/CIRCLE TASK
            TRAP    #15                     ; DO IT
            MOVEM.L (A7)+,D0-D4
            RTS
            


          
            




*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~

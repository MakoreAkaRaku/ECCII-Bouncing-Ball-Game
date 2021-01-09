; =============================================================================
; TITLE    : BALL MANAGEMENT (AGENT)
; AUTHOR   : ANTONI BURGUERA
; COMMENTS : BALL AGENT LOCAL VARIABLES:
;             (A0) : XCENTER - WORD
;            2(A0) : YCENTER - WORD
;            4(A0) : XSPEED  - WORD
;            6(A0) : YSPEED  - WORD
;	 8(A0) : BALRAD  - WORD
;	 10(A0): ZSPEED  - WORD
;	 12(A0): DACCELZ - WORD
;	 14(A0): TIMER   - WORD
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
	MOVE.W	D0,8(A0)	; BALRAD=D0	var
	
	MOVE.W   #0,D0       	
            MOVE.W  D0,10(A0)               ; SPEEDZ=D0  

	MOVE.W	#-1,D0
	MOVE.W	D0,12(A0)	; DACCELERATEZ=D0 constant
	
            MOVEM.L (A7)+,D0/A1
            RTS
            
; -----------------------------------------------------------------------------
BALUPD
; UPDATE A BALL
; INPUT    - NONE
; OUTPUT   - NONE 
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.W  D0/D1/D2/D3/D4/D5/D6/A1/A2 ,-(A7)                ; STACK REGISTERS
            
            BTST.B  #0,(SCRCYCCT)
	BEQ	.ENDU      
            
            CMP #20,8(A0)	; Crear constante de minima dimension de la bola
            BGE .NREBOUND	; YES? REBOUND IF:
            JSR BALRBND 	; REBOUND 
.NREBOUND		
  	MOVE.W (A0),D0
  	ADD.W 4(A0),D0
  	MOVE.W D0,(A0)
  	
  	MOVE.W 2(A0),D0
  	ADD.W 6(A0),D0
  	MOVE.W D0,2(A0)
  	
            MOVE.W	10(A0),D0
            ADD.W	12(A0),D0
            MOVE.W	D0,10(A0)
	
	MOVE.W 8(A0),D0
	ADD.W 10(A0),D0
	MOVE.W D0,8(A0)
.ENDU	
            MOVEM.W  (A7)+,D0/D1/D2/D3/D4/D5/D6/A1/A2
            
	RTS

; -----------------------------------------------------------------------------	
BALRBND	
; REBOUND A BALL
; INPUT    - NONE
; OUTPUT   - NONE 
; MODIFIES - NONE
; -----------------------------------------------------------------------------
	LEA .WIDV,A1	; V_WIDTH	
	LEA .HEIV,A2	; V_HEIGHT
	MOVE.W #6,D5 	; HEIGHT
	MOVE.W #2,D3	; VARIABLE BUCLE LOOP1
.LOOPRBN1	  	
	MOVE.W #2,D2	; VARIABLE BUCLE LOOP2
	SUBQ.W #2,D5	
	MOVE.W #6,D4	; WIDTH 
.LOOPRBN2  	         
	ADDQ.W #2,D5
	
            MOVE.W (A0),D0	
            MOVE.W (PADX),D1
            ADD.W (A2,D4),D1
            CMP D0,D1	;INTRO X LEFT?
            ;BGT .NEXT4
            BLT .NEXT4
            
            SUBQ.W #2,D4	;OPOS. SITE WIDTH
            
            MOVE.W (A0),D0	
            MOVE.W (PADX),D1
            ADD.W (A2,D4),D1
            CMP D0,D1	;INTRO X RIGTH?
            ;BLT .NEXT32
            BGT .NEXT32
            
            MOVE.W 2(A0),D0	
            MOVE.W (PADY),D1
            ADD.W (A1,D5),D1
            CMP D0,D1	;INTRO Y UP?
            ;BGT .NEXT32
            BLT .NEXT32
            
            SUBQ.W #2,D5	;OPOS. SITE HEIGTH
            
            MOVE.W 2(A0),D0	
            MOVE.W (PADY),D1
            ADD.W (A1,D5),D1
            CMP D0,D1	;INTRO X DOWN?
            ;BLT .NEXT1
            BGT .NEXT1
            
            BRA .NNEXT
.NEXT4  
	SUBQ.W #2,D4          
.NEXT32       
	SUBQ.W #2,D5     	            
.NEXT1            
            DBRA D2,.LOOPRBN2
            DBRA D3,.LOOPRBN1
            BRA .ILEGAL      
            ;--------------------
.NNEXT        
	MOVE.W #1,D6
	CMP D3,D6
	BNE .NOTMID	
	CMP D2,D6
	BNE .NOTMID
	
	;OTRO METODO SACA A1 Y A2 Y D3
	MOVEM.W D0/D1,-(A7)
	JSR RNDGET 	;D0.L =RND(0,255) TO GET RANDOM Y & X
	LEA .VELMXR,A1
	LEA .VELMYR,A2
	MOVE.W #-1,D1
	MOVE.W #7,D3
.LOOPRNXY	
	ADD.W #32,D1
	CMP D1,D0
	BLS .FINALRXY
	DBRA D3,.LOOPRNXY
.FINALRXY	
	MULU.W #2,D3
	MOVEM.W (A7)+,D0/D1
	;FIN DEL NUEVO METODO SACA A1 Y A2 Y D3
	BRA .ISMID
.NOTMID								 
	LEA .VELX,A1
	LEA .VELY,A2 	
	MULU.W #3,D3
	ADD.W D2,D3
	MULU.W #2,D3	  	
    	;MOVE.W (A1,D3),4(A0)
    	;MOVE.W (A2,D3),6(A0)
.ISMID 
    	MOVE.W (A1,D3),D0
    	ADD.W D0,4(A0)
    	
    	MOVE.W (A2,D3),D0
    	ADD.W D0,6(A0)
    	
	MOVE.W 10(A0),D0	
          	NOT D0
          	ADDQ.W #2,D0
	MOVE.W D0,10(A0)
	
	ADDQ.W	#1,BALRBNDS
	MOVE.W	(BALRBNDS),D0
	
.LOOPR	SUB.W	#$0003,D0
	CMP.W	#0,D0
	BMI.W	.NOADDRB			
	BEQ.W	.ONEMORBL	
	BRA	.LOOPR
.ONEMORBL	
	MOVE.W	#BALID,D0
	LEA	BALINIT,A1
	LEA	BALUPD,A2
	LEA	BALPLOT,A3
	JSR	AGLADD	
	
	ADDQ.W	#1,BALNUM
.NOADDRB	
	BRA .END 
.ILEGAL
	SUBQ.W	#1,BALNUM
	JSR AGLKILL	
.END	
	RTS

.VELX	DC.W	-2,0,2	;VELOCITAT X
	DC.W	-3,0,3
	DC.W	-2,0,2
.VELY	DC.W	-2,-3,-2	;VELOCITAT Y
	DC.W	0,0,0
	DC.W	2,3,2
.VELMXR	DC.W	-1,0,1	;VELOCITAT X MIDDLE RANDOM
	DC.W	-2,2
	DC.W	-1,0,1
.VELMYR	DC.W	-1,-2,-1	;VELOCITAT Y MIDDLE RANDOM
	DC.W	0,0
	DC.W	1,2,1	
.HEIV: 	DC.W	-PADHEIGH/2,-PADHEIGH/6
	DC.W	PADHEIGH/6,PADHEIGH/2
.WIDV:	DC.W	-PADWIDTH/2,-PADWIDTH/6
	DC.W	PADWIDTH/6,PADWIDTH/2	
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

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
; HISTORY  : 12-10-2020 - CREATION
; =============================================================================

; -----------------------------------------------------------------------------
BALINIT
; INITIALIZE A BALL BY LOOKING CURRENT STATE.
; INPUT    - D1.W = XCENTER'S BALL POSITION
;          - D2.W = YCENTER'S BALL POSITION
;          - D3.B = BIT 0: 0 PARITY, 1 IMPARITY
; OUTPUT   - NONE 
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D1-D3/A1,-(A7)          ; STACK REGISTERS
            LEA     .SPEEDS,A1              ; LOAD MEM.ADDRS OF SPEED INTO A1         
            MOVE.W  D1,(A0)                 ; XBALL=D1
            MOVE.W  D2,2(A0)                ; YBALL=D2
            CMP     #STAMAIN,(STACUR)       ; IF CURRENT STATE == MAIN MENU
            BEQ     .INIMEN                 ; INIT BALL FROM MENU, ELSE INIT BALL FROM GAME
            MOVE.L  8(A1),4(A0)             ; SPEEDX = 0, SPEEDY = 0
	MOVE.W  #BALRAD,8(A0)           ; BALRAD=CONSTANT INIT	     	
            MOVE.W  #0,10(A0)               ; SPEEDZ=0  
	MOVE.W	#-1,12(A0)              ; DACCELERATEZ=-1
.RTN	
            MOVEM.L (A7)+,D1-D3/A1
            RTS
.INIMEN     BTST    #0,D3                   ; BIT TESTING PARITY
            BEQ     .DOWN
            MOVE.L  4(A1),4(A0)             ; DIAGONALLY UPPER CASE
            BRA     .RTN
.DOWN       MOVE.L  (A1),4(A0)              ; DIAGONALLY BOTTOM CASE
            BRA     .RTN
.SPEEDS     DC.W    -BALSPEED,BALSPEED      ; CASE FOR BALL FROM MENU
            DC.W    BALSPEED,-BALSPEED      ; CASE FOR BALL FROM MENU
            DC.W    0,0                     ; CASE FOR BALL FROM GAME
; -----------------------------------------------------------------------------
BALUPD
; UPDATES A BALL COORDINATES: IF CURRENT STATE IS MAIN MENU, MAIN MENU'S LOGIC
; WILL BE USED, ELSE IF CURRENT STATE IS MAIN GAME, GAME'S LOGIC WILL BE USED
; AND IF NEXT STATE'S GOING TO BE ATTRACT MODE, IT DELETES THE BALL.
; INPUT    - NONE
; OUTPUT   - NONE 
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            CMP     #STAMAIN,(STACUR)       ; IF CURRENT STATE == MAIN MENU
            BEQ     BALMUPD                 ; UPDATE FROM MAIN MENU
            CMP     #STAGAME,(STACUR)      ; IF NEXT STATE IS GAME, CONTINUE
            BEQ     .CONT
            CMP     #STAATMOD,(STANEXT)     ; IF NEXT STATE IS NOT ATTRACT MODE
            BNE     AGLKILL                 ; KILL BALL
.CONT
            MOVEM.W D0-D6/A1-A2 ,-(A7)                ; STACK REGISTERS
            
            BTST.B  #0,(SCRCYCCT+1)
	BEQ	.ENDU      
            
            CMP     #20,8(A0)	; Crear constante de minima dimension de la bola
            BGE     .NREBOUND	; YES? REBOUND IF:
            JSR     BALRBND 	; REBOUND 
.NREBOUND		
  	MOVE.W  (A0),D0
  	ADD.W   4(A0),D0
  	MOVE.W  D0,(A0)
  	
  	MOVE.W  2(A0),D0
  	ADD.W   6(A0),D0
  	MOVE.W  D0,2(A0)
  	
            MOVE.W	10(A0),D0
            ADD.W	12(A0),D0
            MOVE.W  D0,10(A0)
	
	MOVE.W  8(A0),D0
	ADD.W   10(A0),D0
	MOVE.W  D0,8(A0)
.ENDU	
            MOVEM.W (A7)+,D0-D6/A1-A2
            
	RTS

; -----------------------------------------------------------------------------	
BALRBND	
; REBOUND A BALL
; INPUT    - NONE
; OUTPUT   - NONE 
; MODIFIES - NONE
; -----------------------------------------------------------------------------
	LEA     .WIDV,A1	; V_WIDTH	
	LEA     .HEIV,A2	; V_HEIGHT
	MOVE.W  #6,D5 	; HEIGHT
	MOVE.W  #2,D3	; VARIABLE BUCLE LOOP1
.LOOPRBN1	  	
	MOVE.W  #2,D2	; VARIABLE BUCLE LOOP2
	SUBQ.W  #2,D5	
	MOVE.W  #6,D4	; WIDTH 
.LOOPRBN2  	         
	ADDQ.W  #2,D5
	
            MOVE.W  (A0),D0	
            MOVE.W  (PADX),D1
            ADD.W   (A2,D4),D1
            CMP     D0,D1	;INTRO X LEFT?
            BLT     .NEXT4
            
            SUBQ.W  #2,D4	;OPOS. SITE WIDTH
            
            MOVE.W  (A0),D0	
            MOVE.W  (PADX),D1
            ADD.W   (A2,D4),D1
            CMP     D0,D1	;INTRO X RIGTH?
            BGT     .NEXT32
            
            MOVE.W  2(A0),D0	
            MOVE.W  (PADY),D1
            ADD.W   (A1,D5),D1
            CMP     D0,D1	;INTRO Y UP?
            BLT     .NEXT32
            
            SUBQ.W  #2,D5	;OPOS. SITE HEIGTH
            
            MOVE.W  2(A0),D0	
            MOVE.W  (PADY),D1
            ADD.W   (A1,D5),D1
            CMP     D0,D1	;INTRO X DOWN?
            BGT     .NEXT1
            
            BRA     .NNEXT
.NEXT4  
	SUBQ.W  #2,D4          
.NEXT32       
	SUBQ.W  #2,D5     	            
.NEXT1            
            DBRA    D2,.LOOPRBN2
            DBRA    D3,.LOOPRBN1
            BRA     .ILEGAL      
            ;--------------------
.NNEXT        
	MOVE.W  #1,D6
	CMP     D3,D6
	BNE     .NOTMID	
	CMP     D2,D6
	BNE     .NOTMID
	
	;OTRO METODO SACA A1 Y A2 Y D3
	MOVEM.W D0/D1,-(A7)
	JSR     RNDGET 	;D0.L =RND(0,255) TO GET RANDOM Y & X
	LEA     .VELMXR,A1
	LEA     .VELMYR,A2
	MOVE.W  #-1,D1
	MOVE.W  #7,D3
.LOOPRNXY	
	ADD.W   #32,D1
	CMP     D1,D0
	BLS     .FINALRXY
	DBRA    D3,.LOOPRNXY
.FINALRXY	
	MULU.W  #2,D3
	MOVEM.W (A7)+,D0/D1
	;FIN DEL NUEVO METODO SACA A1 Y A2 Y D3
	BRA     .ISMID
.NOTMID								 
	LEA     .VELX,A1
	LEA     .VELY,A2 	
	MULU.W  #3,D3
	ADD.W   D2,D3
	MULU.W  #2,D3
.ISMID      MOVE.B  #4,D1
            JSR     SFXPLAY                 ;PLAY BOUNCE SFX
    	MOVE.W  (A1,D3),D0
    	ADD.W   D0,4(A0)
    	
    	MOVE.W  (A2,D3),D0
    	ADD.W   D0,6(A0)
    	
	MOVE.W  10(A0),D0	
          	NOT     D0
          	ADDQ.W  #2,D0
	MOVE.W  D0,10(A0)
	
	ADDQ.W	#1,BALRBNDS
	MOVE.W	(BALRBNDS),D0
	
.LOOPR	SUB.W	#BALBNC,D0              ; EVERY 10 BOUNCES
	CMP.W	#0,D0                   ; WILL SPAWN A NEW BALL
	BMI.W	.NOADDRB			
	BEQ.W	.ONEMORBL	
	BRA	.LOOPR
.ONEMORBL	
	JSR	BALNEW
.NOADDRB	
	BRA     .END 
.ILEGAL
	SUBQ.W	#1,BALNUM
	JSR     AGLKILL	
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
; PLOT A BALL: IF CURRENT STAT IS MAIN MENU, THEN PAINTS A BALL FROM IT
;              ELSE, PAINTS A BALL FROM GAME STATE.
; INPUT    - NONE
; OUTPUT   - NONE 
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            CMP     #STAMAIN,(STACUR)       ; IF CURRENT STATE == MAIN MENU
            BEQ     BALMPLOT
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
            
            SUB.W   8(A0),D1              ; D1:=XLEFT
            SUB.W   8(A0),D2              ; D2:=YTOP
            ADD.W   8(A0),D3              ; D3:=XRIGTH
            ADD.W   8(A0),D4              ; D4:=YBOTTOM
            MOVE.B  #88,D0                  ; DRAW ELLIPSE/CIRCLE TASK
            TRAP    #15                     ; DO IT
            
            MOVE.L  #BALMCOL,D1             ;SET BALL'S MAIN COLOR
            MOVE.B  #80,D0
            TRAP    #15
            MOVE.B  #81,D0
            TRAP    #15

            MOVE.W  (A0),D1                 ; D1:=XCENTER
            SUB.W   8(A0),D1
            ADD.W   #1,D1
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
            SUB.W   8(A0),D1
            ADD.W   #15,D1                  ; D1:=XLEFT
            ADD.W   #3,D2                   ; D2:=YTOP
            SUB.W   #7,D3                   ; D3:=XRIGTH
            SUB.W   #20,D4                  ; D4:=YBOTTOM
            MOVE.B  #88,D0                  ; DRAW ELLIPSE/CIRCLE TASK
            TRAP    #15                     ; DO IT

            MOVEM.L (A7)+,D0-D4
            RTS
; -----------------------------------------------------------------------------
BALNEW
; CREATE A NEW BALL
; INPUT    - NONE
; OUTPUT   - NONE 
; MODIFIES - NONE
; -----------------------------------------------------------------------------             
	MOVE.W	#BALID,D0	;ID BALL
	LEA	BALINIT,A1	;INITBALL
	LEA	BALUPD,A2	;UPDATEBALL
	LEA	BALPLOT,A3	;PLOTBALL
	MOVE.W  #SCRWIDTH/2,D1
            MOVE.W  #SCRHEIGH/2,D2
	JSR	AGLADD	;ADD NEW BALL TO AGENTLIST	
	
	ADDQ.W	#1,BALNUM	;
	
	RTS
; -----------------------------------------------------------------------------
BALMUPD
; UPDATE A BALL FROM MAIN
; INPUT    - NONE
; OUTPUT   - NONE 
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            CMP     #STAMAIN,(STANEXT)
            BNE     AGLKILL
            MOVE.W  D0,-(A7)                ; STACK REGISTERS
            MOVE.W  (A0),D0                 ; D0 = X
            ADD.W   4(A0),D0                ; D0 = X+VX
            MOVE.W  D0,(A0)                 ; X := X+VX
            MOVE.W  2(A0),D0                ; D0 = Y
            ADD.W   6(A0),D0                ; D0 = Y+VY
            MOVE.W  D0,2(A0)                ; Y := Y+VY
            
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
BALMPLOT
; PAINTS A BALL FROM MAIN MENU
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
            
            SUB.W   #BALMRAD,D1              ; D1:=XLEFT
            SUB.W   #BALMRAD,D2              ; D2:=YTOP
            ADD.W   #BALMRAD,D3              ; D3:=XRIGTH
            ADD.W   #BALMRAD,D4              ; D4:=YBOTTOM
            MOVE.B  #88,D0                  ; DRAW ELLIPSE/CIRCLE TASK
            TRAP    #15                     ; DO IT
            
            MOVE.L  #BALMCOL,D1             ;SET BALL'S MAIN COLOR
            MOVE.B  #80,D0
            TRAP    #15
            MOVE.B  #81,D0
            TRAP    #15

            MOVE.W  (A0),D1                 ; D1:=XCENTER            
            SUB.W   #BALMRAD-1,D1            ; D1:=XLEFT
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
            SUB.W   #BALMRAD-13,D1          ; D1:=XLEFT
            ADD.W   #3,D2                   ; D2:=YTOP
            SUB.W   #5,D3                   ; D3:=XRIGTH
            SUB.W   #15,D4                  ; D4:=YBOTTOM
            MOVE.B  #88,D0                  ; DRAW ELLIPSE/CIRCLE TASK
            TRAP    #15                     ; DO IT
            MOVEM.L (A7)+,D0-D4
            RTS






























*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~

*-----------------------------------------------------------
* Title      : PAD MANAGEMENT
* Written by : FAUSTI RODRIGUEZ RODRIGUEZ
* Date       :
* Description:
*-----------------------------------------------------------
 
;-----------------------------------------------------------
PADINIT
; INITIALIZE THE PAD. 
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
;-----------------------------------------------------------
            MOVE.W  #SCRWIDTH/2,(PADX)              ;CENTRE PANTALLA
            MOVE.W  #SCRHEIGH/2,(PADY)
            RTS



;-----------------------------------------------------------
PADUPD
; INITIALIZE THE PAD.SI PITJEN DRETA, MOU DRETA, SI PITJEN
; ESQUERRE ESQUERRA....
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
;-----------------------------------------------------------
            BTST.B  #KBDBITLF,(KBDVAL)      ; LEFT KEY PRESSED?
            BNE     .MOVELEF                ; YES: MOVE LEFT
            BTST.B  #KBDBITRT,(KBDVAL)      ; RIGHT KEY PRESSED?
            BNE     .MOVERIG                ; YES: MOVE LEFT
            BTST.B  #KBDBITUP,(KBDVAL)      ; UP KEY PRESSED?
            BNE     .MOVEUP                 ; YES: MOVE UP
            BTST.B  #KBDBITDN,(KBDVAL)      ; DOWN KEY PRESSED?
            BNE     .MOVEDO
            RTS
            
.MOVELEF    CMP.W   #PADWIDTH/2,(PADX)      ; BELOW LEFT BOUNDARY?
            BGT     .DOL                    ; NO: MOVE
            RTS                             ; YES: END
.DOL        SUB.W   #PADSPEED,(PADX)        ; MOVE LEFT
            RTS
            
.MOVERIG    CMP.W   #SCRWIDTH-1-PADWIDTH/2,(PADX) ; HIGHER THAN RIGHT BOUNDARY?
            BLT     .DOR                    ; NO: MOVE
            RTS                             ; YES: END
.DOR        ADD.W   #PADSPEED,(PADX)        ; MOVE RIGHT
            RTS
       
.MOVEUP     CMP.W   #SCRHEIGH+5-SCRHEIGH,(PADY)   ; HIGHER THAN UP BOUNDARY?
            BGT     .DOU
            RTS
.DOU        SUB.W   #PADSPEED,(PADY)        ; MOVE UP
            RTS
            
.MOVEDO     CMP.W   #SCRHEIGH,(PADY)
            BLT     .DDN
            RTS
.DDN        ADD.W   #PADSPEED,(PADY)        ;MOVE DOWN
            RTS
            
;-----------------------------------------------------------
PADMOU
; PAD MOUSE. CONTROL PAD WITH THE MOUSE. TRAP #15, TASK 61
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
;-----------------------------------------------------------
           MOVEM.L  D0-D2,-(A7)
           CLR.B    D1
           MOVE.W   #61,D0
           TRAP     #15
           MOVE.W   D1, (PADX)
           LSR.L    #8,D1
           LSR.L    #8,D1                   
           MOVE.W   D1,(PADY)
           MOVEM.L  (A7)+,D0-D2
           RTS


;-----------------------------------------------------------
PADPLOT
; INITIALIZE THE PAD. DRAW PAD.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
;-----------------------------------------------------------
            MOVEM.L D0-D4,-(A7)
            
            ;DRAW RECTANGLE 5 //ELIPSE
            MOVE.B  #80,D0                   ;SET COLOR TASK
            MOVE.L  #PAD4PCO,D1              ;PEN COLOR
            TRAP    #15                        ;SET PEN COLOR
            ADDQ.B  #1,D0                    ;SET FILL COLOR TASK
            MOVE.L  #PAD4FCO,D1              ;FILL COLOR
            TRAP    #15                        ;SET FILL COLOR
            
            MOVE.W  (PADX),D1                ;D1:=XCENTER
            MOVE.W  (PADY),D2                ;D2:=YCENTER
            MOVE.W  D1,D3                    ;D3:=XCENTER
            MOVE.W  D2,D4                    ;D4:=YCENTER
            SUB.W   #PADWIDTH/2-28+5-3,D1      ;D1:=XLEFT
            SUB.W   #PADHEIGH/2-5,D2         ;D2:=YTOP
            ADD.W   #PADWIDTH/2-28-3,D3        ;D3:=XRIGHT
            ADD.W   #PADHEIGH/2+50+10,D4     ;D4:=YBOTTOM
            MOVE.B  #88,D0
            TRAP    #15                        ;DRAW RECTANGLE
            
            ;DRAW RECTANGLE 5 //ELIPSE
            MOVE.B  #80,D0                   ;SET COLOR TASK
            MOVE.L  #PAD4PCO,D1              ;PEN COLOR
            TRAP    #15                        ;SET PEN COLOR
            ADDQ.B  #1,D0                    ;SET FILL COLOR TASK
            MOVE.L  #PAD4FCO,D1              ;FILL COLOR
            TRAP    #15                        ;SET FILL COLOR
            
            MOVE.W  (PADX),D1                ;D1:=XCENTER
            MOVE.W  (PADY),D2                ;D2:=YCENTER
            MOVE.W  D1,D3                    ;D3:=XCENTER
            MOVE.W  D2,D4                    ;D4:=YCENTER
            SUB.W   #PADWIDTH/2-28-3,D1        ;D1:=XLEFT
            SUB.W   #PADHEIGH/2-5,D2         ;D2:=YTOP
            ADD.W   #PADWIDTH/2-28+5-3,D3      ;D3:=XRIGHT
            ADD.W   #PADHEIGH/2+50+10,D4     ;D4:=YBOTTOM
            MOVE.B  #88,D0
            TRAP    #15                        ;DRAW RECTANGLE
                        
            ;DRAW RECTANGLE 3
            MOVE.B  #80,D0                   ;SET COLOR TASK
            MOVE.L  #PAD3PCO,D1              ;PEN COLOR
            TRAP    #15                        ;SET PEN COLOR
            ADDQ.B  #1,D0                    ;SET FILL COLOR TASK
            MOVE.L  #PAD3FCO,D1              ;FILL COLOR
            TRAP    #15                        ;SET FILL COLOR
            
            MOVE.W  (PADX),D1                ;D1:=XCENTER
            MOVE.W  (PADY),D2                ;D2:=YCENTER
            MOVE.W  D1,D3                    ;D3:=XCENTER
            MOVE.W  D2,D4                    ;D4:=YCENTER
            SUB.W   #PADWIDTH/2-28-5,D1        ;D1:=XLEFT
            SUB.W   #PADHEIGH/2-5,D2           ;D2:=YTOP
            ADD.W   #PADWIDTH/2-28-5,D3        ;D3:=XRIGHT
            ADD.W   #PADHEIGH/2+50+10,D4        ;D4:=YBOTTOM
            MOVE.B  #87,D0
            TRAP    #15                        ;DRAW RECTANGLE
            
            ;DRAW RECTANGLE 4 //ELIPSE
            MOVE.B  #80,D0                   ;SET COLOR TASK
            MOVE.L  #PAD4PCO,D1              ;PEN COLOR
            TRAP    #15                        ;SET PEN COLOR
            ADDQ.B  #1,D0                    ;SET FILL COLOR TASK
            MOVE.L  #PAD4FCO,D1              ;FILL COLOR
            TRAP    #15                        ;SET FILL COLOR
            
            MOVE.W  (PADX),D1                ;D1:=XCENTER
            MOVE.W  (PADY),D2                ;D2:=YCENTER
            MOVE.W  D1,D3                    ;D3:=XCENTER
            MOVE.W  D2,D4                    ;D4:=YCENTER
            SUB.W   #PADWIDTH/2-28-4,D1        ;D1:=XLEFT
            SUB.W   #PADHEIGH/2-5,D2           ;D2:=YTOP
            ADD.W   #PADWIDTH/2-28-4,D3        ;D3:=XRIGHT
            ADD.W   #PADHEIGH/2+50-7,D4        ;D4:=YBOTTOM
            MOVE.B  #88,D0
            TRAP    #15                        ;DRAW RECTANGLE
            
            ;DRAW RECTANGLE 5 //ELIPSE
            MOVE.B  #80,D0                   ;SET COLOR TASK
            MOVE.L  #PAD5PCO,D1              ;PEN COLOR
            TRAP    #15                        ;SET PEN COLOR
            ADDQ.B  #1,D0                    ;SET FILL COLOR TASK
            MOVE.L  #PAD5FCO,D1              ;FILL COLOR
            TRAP    #15                        ;SET FILL COLOR
            
            MOVE.W  (PADX),D1                ;D1:=XCENTER
            MOVE.W  (PADY),D2                ;D2:=YCENTER
            MOVE.W  D1,D3                    ;D3:=XCENTER
            MOVE.W  D2,D4                    ;D4:=YCENTER
            SUB.W   #PADWIDTH/2-28-6,D1        ;D1:=XLEFT
            SUB.W   #PADHEIGH/2-5,D2           ;D2:=YTOP
            ADD.W   #PADWIDTH/2-28-6,D3        ;D3:=XRIGHT
            ADD.W   #PADHEIGH/2+50-10,D4        ;D4:=YBOTTOM
            MOVE.B  #88,D0
            TRAP    #15                        ;DRAW RECTANGLE

            ;DRAW ELIPSE 2  
            MOVE.B  #80,D0                   ;SET COLOR TASK
            MOVE.L  #PAD2PCO,D1              ;PEN COLOR
            TRAP    #15                      ;SET PEN COLOR
            
            ADDQ.B  #1,D0                    ;SET FILL TASK
            MOVE.L  #PAD2FCO,D1              ;FILL COLOR
            TRAP    #15                      ;SET FILL COLOR
           
            
            MOVE.W  (PADX),D1                ;D1:=XCENTER
            MOVE.W  (PADY),D2                ;D2:=YCENTER
            MOVE.W  D1,D3                    ;D3:=XCENTER
            MOVE.W  D2,D4                    ;D4:=YCENTER
            SUB.W   #PADWIDTH/2+4,D1          ;D1:=XLEFT
            SUB.W   #PADHEIGH/2+5,D2          ;D2:=YTOP
            ADD.W   #PADWIDTH/2,D3          ;D3:=XRIGHT
            ADD.W   #PADHEIGH/2,D4        ;D4:=YBOTTOM
            MOVE.B  #88,D0
            TRAP    #15

 
            ;DRAW   ELIPSE 1
            MOVE.B  #80,D0                   ;SET COLOR TASK
            MOVE.L  #PADPCOL,D1              ;PEN COLOR  
            TRAP    #15                      ;SET PEN COLOR
            
            ADDQ.B  #1,D0                    ;SET FILL TASK
            MOVE.L  #PADFCOL,D1              ;FILL COLOR
            TRAP    #15                      ;SET FILL COLOR
            
     
            MOVE.W  (PADX),D1                ;D1:=XCENTER
            MOVE.W  (PADY),D2                ;D2:=YCENTER

            MOVE.W  D1,D3                    ;D3:=XCENTER
            MOVE.W  D2,D4                    ;D4:=YCENTER
            SUB.W   #PADWIDTH/2,D1           ;D1:=XLEFT
            SUB.W   #PADHEIGH/2+5,D2           ;D2:=YTOP
            ADD.W   #PADWIDTH/2,D3           ;D3:=XRIGHT
            ADD.W   #PADHEIGH/2,D4           ;D4:=YBOTTOM
            MOVE.B  #88,D0
            TRAP    #15
            MOVEM.L (A7)+, D0-D4
            RTS
;-----------------------------------------------------------
PADCOR
; MOVE THE PAD TO THE INDICATED COORDENATE.
; INPUT    - D0-->BALLX
;          - D1-->BALLY
; OUTPUT   - NONE
; MODIFIES - NONE
;-----------------------------------------------------------
	CMP	#0,D0	; NO GLITCH IN LEFT WALL
	BMI	.END	
	CMP	#0,D1	; NO GLITCH IN UP WALL
	BMI	.END
	CMP	#SCRWIDTH,D0	; NO GLITCH IN RIGTH WALL
	BPL	.END
	CMP	#SCRHEIGH,D1	; NO GLITCH IN DOWN WALL
	BPL	.END
.NEXTX	
	CMP	#0,PADX	; NO SURT DE LA PANTALLA PER L'EIX X   
	BMI	.XO
	CMP	#SCRWIDTH,PADX
	BPL	.XSCR
	
	MOVE.W	PADX,D2	;--1
	SUB.W	D0,D2	; D2-D0=D2
	BMI	.CNVPX	; CONVERT INTO POSITIVE NUM
	BRA	.NCNVPX
.CNVPX	
	NOT	D2
.NCNVPX	
	SUB.W	#PADSPEED,D2
	BMI	.EQX	;--2
		
	CMP	PADX,D0	 
	BEQ	.NEXTY
	BPL	.XMAYOR
	BMI	.XMENOR	
	
	BRA	.NEXTY
.XMAYOR			; IF D0-PADX=+ THEN:
	ADD.W	#PADSPEED,(PADX)	; ADD PADSPEED TO PADX
	BRA	.NEXTY
.XMENOR	
	SUB.W	#PADSPEED,(PADX)
	
.NEXTY	CMP	#0,PADY	; NO SURT DE LA PANTALLA PER L'EIX Y
	BMI	.YO	
	CMP	#SCRHEIGH,PADY
	BPL	.YSCR
	
	MOVE.W	PADY,D2	;--1
	SUB.W	D1,D2	; D2-D1=D2
	BMI	.CNVPY	; CONVERT INTO POSITIVE NUM
	BRA	.NCNVPY
.CNVPY	
	NOT	D2
.NCNVPY	
	SUB.W	#PADSPEED,D2
	BMI	.EQY	;--2
	
	CMP	PADY,D1	
	BEQ	.END
	BPL	.YMAYOR
	BMI	.YMENOR	
	
	BRA	.END	; END
.YMAYOR			; IF D0-PADY=+ THEN:
	ADD.W	#PADSPEED,(PADY)	; ADD PADSPEED TO PADY
	BRA	.END	; END
.YMENOR	
	SUB.W	#PADSPEED,(PADY)
	BRA	.END	; END
	
.XO
	MOVE.W	#1,(PADX)
	BRA	.NEXTY
.XSCR
	MOVE.W	#SCRWIDTH-1,(PADX)
	BRA	.NEXTY
.YO			
	MOVE.W	#1,(PADY)
	BRA	.END
.YSCR
	MOVE.W	#SCRHEIGH-1,(PADY)
	BRA	.END
	
.END        RTS
.EQX	MOVE.W	D0,(PADX)
	BRA	.NEXTY
.EQY	MOVE.W	D1,(PADY)
	BRA	.END

*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~

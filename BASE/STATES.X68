; =============================================================================
; TITLE    : GAME STATE MANAGEMENT
; AUTHOR   : ANTONI BURGUERA
; HISTORY  : XX-XXX-201X - CREATION
;            11-OCT-2020 - MINOR CHANGES
; =============================================================================

; -----------------------------------------------------------------------------
STAINIT
; INITALIZES THE STATE MANAGER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  #-1,(STACUR)            ; INVALID STATE, JUST TO FORCE INIT
            MOVE.W  #0,(STANEXT)            ; INITIAL STATE
            RTS

; -----------------------------------------------------------------------------
STAUPD
; PERFORMS STATE UPDATE AND INIT IF NECESSARY
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0/A0,-(A7)
            CLR.L   D0
            MOVE.W  (STANEXT),D0
            CMP.W   (STACUR),D0
            BEQ     .DOUPD
            MOVE.W  D0,(STACUR)             ; IF STATE CHANGED, DO INIT
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .INITBL(A0),A0
            JSR     (A0)
.DOUPD      CLR.L   D0                      ; IN ANY CASE, DO UPDATE
            MOVE.W  (STACUR),D0
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .UPDTBL(A0),A0
            JSR     (A0)
            MOVEM.L (A7)+,D0/A0
            RTS
.INITBL     DC.L    STAINTRI,STAMAINI,STAGAMEI,STAGOVRI,STASCORI,STAHTPI
.UPDTBL     DC.L    STAINTRU,STAMAINU,STAGAMEU,STAGOVRU,STASCORU,STAHTPU

; -----------------------------------------------------------------------------
STAPLOT
; PERFORMS STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0/A0,-(A7)
            CLR.L   D0
            MOVE.W  (STACUR),D0
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .PLTTBL(A0),A0
            JSR     (A0)
            MOVEM.L (A7)+,D0/A0
            RTS
.PLTTBL     DC.L    STAINTRP,STAMAINP,STAGAMEP,STAGOVRP,STASCORP,STAHTPP

; -----------------------------------------------------------------------------
STAEMPTY
; EMPTY SUBROUTINE FOR CASES WITH NOTHING TO DO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - JUST A PLACEHOLDER. NOTHING TO DO.
; -----------------------------------------------------------------------------
            RTS
; --- INTRODUCTION STATES ----------------------------------------------- FIRST            
; -----------------------------------------------------------------------------
STAINTRI	EQU 	STAEMPTY
; INITALIZES THE INTRO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------  
; -----------------------------------------------------------------------------
STAINTRU
; UPDATE THE INTRO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; ----------------------------------------------------------------------------- 
	BTST.B	#KBDBITF1,(KBDEDGE)
	BEQ	.END
	MOVE.W	#STAMAIN,(STANEXT)   
.END	RTS 
; -----------------------------------------------------------------------------
STAINTRP
; PLOT THE INTRO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; ----------------------------------------------------------------------------- 
	MOVE.W	#((80-10)/2)<<8|10,D1	;FIRST TEXT COORDINATES
	MOVE.B	#11,D0
	TRAP 	#15	;LOCATE TEXT CURSOR
	LEA 	.STR0,A1	;STRING POINTER
	MOVE.B	#13,D0	;PRINT STRING TASK
	TRAP 	#15
	
	BTST.B  #3,(SCRCYCCT)
	BEQ	.END
	
	MOVE.W	#((80-14)/2)<<8|25,D1	;FIRST TEXT COORDINATES
	MOVE.B	#11,D0
	TRAP 	#15	;LOCATE TEXT CURSOR
	LEA 	.STR1,A1	;STRING POINTER
	MOVE.B	#13,D0	;PRINT STRING TASK
	TRAP 	#15
.END	
	RTS   
.STR0	DC.B	'PING--BALL',0
.STR1	DC.B	'PUSH SPACE KEY',0   
	DS.W	0
; --- MAIN STATES ------------------------------------------------------ SECOND            
; -----------------------------------------------------------------------------
STAMAINI
; INITALIZES THE MAIN
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------  
	RTS
; -----------------------------------------------------------------------------
STAMAINU
; UPDATE THE MAIN
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
	BTST.B	#KBDBITF3,(KBDEDGE)
	BEQ	.NEXT1	;SHIFT=EXIT
	SIMHALT
.NEXT1 
	BTST.B	#KBDBITUP,(KBDEDGE)
	BEQ	.NEXT2
	MOVE.W	#STAHTP,(STANEXT) 	;UP=HOW TO PLAY
	BRA	.END
.NEXT2 
	BTST.B	#KBDBITDN,(KBDEDGE)
	BEQ	.NEXT3
	MOVE.W	#STASCORE,(STANEXT) 	;DOWN=SCORE
	BRA	.END
.NEXT3	     
	BTST.B	#KBDBITF1,(KBDEDGE)
	BEQ	.END
	MOVE.W	#STAGAME,(STANEXT) 	;SPACE=GAME 
.END	RTS 
	 
; -----------------------------------------------------------------------------
STAMAINP
; PLOT THE INTRO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; ----------------------------------------------------------------------------- 
	MOVE.W	#((80-4)/2)<<8|10,D1	;FIRST TEXT COORDINATES
	MOVE.B	#11,D0
	TRAP 	#15	;LOCATE TEXT CURSOR
	LEA 	.STR0,A1	;STRING POINTER
	MOVE.B	#13,D0	;PRINT STRING TASK
	TRAP 	#15
	
*	BTST.B  #5,(SCRCYCCT)
*	BEQ	.END
	
	MOVE.W	#((80-22)/2)<<8|25,D1	;FIRST TEXT COORDINATES
	MOVE.B	#11,D0
	TRAP 	#15	;LOCATE TEXT CURSOR
	LEA 	.STR1,A1	;STRING POINTER
	MOVE.B	#13,D0	;PRINT STRING TASK
	TRAP 	#15
	
	MOVE.W	#((80-22)/2)<<8|23,D1	;FIRST TEXT COORDINATES
	MOVE.B	#11,D0
	TRAP 	#15	;LOCATE TEXT CURSOR
	LEA 	.STR2,A1	;STRING POINTER
	MOVE.B	#13,D0	;PRINT STRING TASK
	TRAP 	#15
	
	MOVE.W	#((80-22)/2)<<8|21,D1	;FIRST TEXT COORDINATES
	MOVE.B	#11,D0
	TRAP 	#15	;LOCATE TEXT CURSOR
	LEA 	.STR3,A1	;STRING POINTER
	MOVE.B	#13,D0	;PRINT STRING TASK
	TRAP 	#15
	
	MOVE.W	#((80-22)/2)<<8|19,D1	;FIRST TEXT COORDINATES
	MOVE.B	#11,D0
	TRAP 	#15	;LOCATE TEXT CURSOR
	LEA 	.STR4,A1	;STRING POINTER
	MOVE.B	#13,D0	;PRINT STRING TASK
	TRAP 	#15
.END	
	RTS   
.STR0	DC.B	'MAIN',0
.STR1	DC.B	'PUSH SPACE KEY  TO PLAY',0 
.STR2	DC.B	'PUSH SHIFT KEY  TO EXIT',0 
.STR3	DC.B	'PUSH UP KEY TO HOW PLAY',0 
.STR4	DC.B	'PUSH DOWN KEY  TO SCORE',0   
	DS.W	0	
	RTS   
; --- GAME STATES ------------------------------------------------------- THIRD            
; -----------------------------------------------------------------------------
STAGAMEI
; INITALIZES THE INTRO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------  
	JSR     PADINIT
	
	CLR.W	BALRBNDS
	CLR.W	BALNUM 
	
	ADDQ.W	#1,BALNUM
            
	MOVE.W	#BALID,D0
	LEA	BALINIT,A1
	LEA	BALUPD,A2
	LEA	BALPLOT,A3
	JSR	AGLADD
	
	RTS
; -----------------------------------------------------------------------------
STAGAMEU
; UPDATE THE INTRO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------   
	MOVEM.L	D1,-(A7) 
	JSR	PADMOU
            
            ; ___Update_Ball___ 
            BTST.B	#KBDBITPS,(KBDVAL)      ; "P" PAUSE KEY PRESSED?    
            BNE	.ANOTHER	           ; 1=PAUSE, 0=NOPAUSE 	  	
            BTST.B	#0,(PAUSE)
            BEQ	.YESUPD
            BRA	.END	
.ANOTHER		
            MOVE.B #0,(PAUSE)	  			 	
.YESUPD		 
            JSR	AGLUPD
            ; ___Finish_Update_Ball___
.END            
	MOVEM.L (A7)+,D1
	RTS 
; -----------------------------------------------------------------------------
STAGAMEP
; PLOT THE INTRO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; ----------------------------------------------------------------------------- 
            JSR     PADPLOT
	JSR	AGLPLOT	
	RTS   
; --- GAME OVER STATES ------------------------------------------------- FOURTH            
; -----------------------------------------------------------------------------
STAGOVRI
; INITALIZES THE INTRO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------  
	RTS
; -----------------------------------------------------------------------------
STAGOVRU
; UPDATE THE INTRO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------    
	BTST.B	#KBDBITF1,(KBDEDGE)
	BEQ	.END
	MOVE.W	#STAMAIN,(STANEXT) 	;SPACE=GAME  
.END	RTS 
; -----------------------------------------------------------------------------
STAGOVRP
; PLOT THE INTRO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; ----------------------------------------------------------------------------- 
            MOVE.W	#((80-10)/2)<<8|10,D1	;FIRST TEXT COORDINATES
	MOVE.B	#11,D0
	TRAP 	#15	;LOCATE TEXT CURSOR
	LEA 	.STR0,A1	;STRING POINTER
	MOVE.B	#13,D0	;PRINT STRING TASK
	TRAP 	#15
	
	BTST.B  #4,(SCRCYCCT)
	BEQ	.END
	
	MOVE.W	#((80-14)/2)<<8|25,D1	;FIRST TEXT COORDINATES
	MOVE.B	#11,D0
	TRAP 	#15	;LOCATE TEXT CURSOR
	LEA 	.STR1,A1	;STRING POINTER
	MOVE.B	#13,D0	;PRINT STRING TASK
	TRAP 	#15
.END	
	RTS   
.STR0	DC.B	'GAME  OVER',0
.STR1	DC.B	'PUSH SPACE HEY',0   
	DS.W	0
; --- SCORE STATES ------------------------------------------------------ FIFTH            
; -----------------------------------------------------------------------------
STASCORI
; INITALIZES THE INTRO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------  
	RTS
; -----------------------------------------------------------------------------
STASCORU
; UPDATE THE INTRO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------    
	BTST.B	#KBDBITF3,(KBDEDGE)
	BEQ	.END	;SHIFT=EXIT
	MOVE.W	#STAMAIN,(STANEXT) 	 
.END	RTS 
; -----------------------------------------------------------------------------
STASCORP
; PLOT THE INTRO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; ----------------------------------------------------------------------------- 
	MOVE.W	#((80-6)/2)<<8|10,D1	;FIRST TEXT COORDINATES
	MOVE.B	#11,D0
	TRAP 	#15	;LOCATE TEXT CURSOR
	LEA 	.STR0,A1	;STRING POINTER
	MOVE.B	#13,D0	;PRINT STRING TASK
	TRAP 	#15
	
	BTST.B  #4,(SCRCYCCT)
	BEQ	.END
	
	MOVE.W	#((80-14)/2)<<8|25,D1	;FIRST TEXT COORDINATES
	MOVE.B	#11,D0
	TRAP 	#15	;LOCATE TEXT CURSOR
	LEA 	.STR1,A1	;STRING POINTER
	MOVE.B	#13,D0	;PRINT STRING TASK
	TRAP 	#15
.END	
	RTS   
.STR0	DC.B	'SCORE ',0
.STR1	DC.B	'PUSH SHIFT KEY',0   
	DS.W	0
	RTS 
; --- HOW TO PLAY STATES ------------------------------------------------ SIXTH            
; -----------------------------------------------------------------------------
STAHTPI
; INITALIZES THE INTRO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------  
	RTS
; -----------------------------------------------------------------------------
STAHTPU
; UPDATE THE INTRO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------    
	BTST.B	#KBDBITF3,(KBDEDGE)
	BEQ	.END	;SHIFT=EXIT
	MOVE.W	#STAMAIN,(STANEXT) 	 
.END	RTS 
; -----------------------------------------------------------------------------
STAHTPP
; PLOT THE INTRO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; ----------------------------------------------------------------------------- 
	MOVE.W	#((80-12)/2)<<8|10,D1	;FIRST TEXT COORDINATES
	MOVE.B	#11,D0
	TRAP 	#15	;LOCATE TEXT CURSOR
	LEA 	.STR0,A1	;STRING POINTER
	MOVE.B	#13,D0	;PRINT STRING TASK
	TRAP 	#15
	
	BTST.B  #4,(SCRCYCCT)
	BEQ	.END
	
	MOVE.W	#((80-14)/2)<<8|25,D1	;FIRST TEXT COORDINATES
	MOVE.B	#11,D0
	TRAP 	#15	;LOCATE TEXT CURSOR
	LEA 	.STR1,A1	;STRING POINTER
	MOVE.B	#13,D0	;PRINT STRING TASK
	TRAP 	#15
.END	
	RTS   
.STR0	DC.B	'HOW TO  PLAY',0
.STR1	DC.B	'PUSH SHIFT KEY',0   
	DS.W	0
	RTS   	








*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~

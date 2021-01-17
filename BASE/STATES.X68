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
.INITBL     DC.L    STAINTRI,STAMAINI,STAGAMEI,STAGOVRI,STASCORI,STAHTPI,STAATMDI
.UPDTBL     DC.L    STAINTRU,STAMAINU,STAGAMEU,STAGOVRU,STASCORU,STAHTPU,STAATMDU

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
.PLTTBL     DC.L    STAINTRP,STAMAINP,STAGAMEP,STAGOVRP,STASCORP,STAHTPP,STAATMDP

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
STAINTRI	
; INITALIZES THE INTRO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            JSR     ARINIT                  ;INITIALIZE ARROW POSITION
            JSR     SFXINIT
            CLR.B   D1
            JSR     SFXPLAY

            MOVE.W  #SCRWIDTH/2,(IBALXCO)              ;CENTRE PANTALLA
            MOVE.W  #SCRHEIGH/2,(IBALYCO)
            MOVE.W  #200,(IBALRAD)
            MOVE.W  #-3,(IBALSPE)
            MOVE.W  #1,(IBALACC)
	RTS
; -----------------------------------------------------------------------------
STAINTRU
; UPDATE THE INTRO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            BTST.B  #7,(SCRCYCCT+1)
	BNE     .STP
            BTST.B	#KBDBITF2,(KBDEDGE)
	BEQ	.END
.STP	CLR.B   D1
	JSR     SFXSTOP
	MOVE.W	#STAMAIN,(STANEXT)   
.END	CMP     #BALMINRAD,IBALRAD
            BGT     .SUBS
            NEG     IBALSPE
            CMP     #2,IBALSPE
            BMI     .CHBLSP
.SUBS       MOVE.W  IBALSPE,D6
            ADD.W   D6,IBALRAD
            SUB.W   IBALACC,D6
            CMP     #0,IBALSPE
	BMI     .STOP
            MOVE.W  D6,IBALSPE
.STOP       RTS
.CHBLSP     MOVE    #0,IBALSPE
            RTS
; -----------------------------------------------------------------------------
STAINTRP
; PLOT THE INTRO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; ----------------------------------------------------------------------------- 
	BTST.B  #4,(SCRCYCCT+1)         ;POSITIONING TO LOW BYTE AND BIT TESTING
            BNE     .END
            
            MOVE.B  #81,D0
            MOVE.L  #MENFCOL,D1             ;SETTING RECTANGLE'S FILL COLOR
            TRAP    #15

            MOVE.W  #((255)/5)<<8|90,D1     ;FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ;LOCATE TEXT CURSOR
            LEA     .STR0,A1                ;STRING POINTER
            MOVE.B  #13,D0                  ;PRINT STRING TASK
            TRAP    #15
.END        

            MOVE.B  #80,D0                  ; SET PEN COLOR TASK
            MOVE.L  #INIF1COL,D1             ; PEN SHADOW COLOR
            TRAP    #15                     ; SET PEN COLOR
            ADDQ.B  #1,D0                   ; SET FILL COLOR TASK
            MOVE.L  #INIF1COL,D1             ; FILL SHADOW COLOR
            TRAP    #15                     ; SET FILL COLOR
            
            MOVE.W  #SCRWIDTH/2,D1
            MOVE.W  #SCRHEIGH/2,D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            SUB.W   #60,D2
            ADD.W   #60,D4
            SUB.W   #130,D1
            ADD.W   #130,D3
            MOVE.B  #88,D0                  ; DRAW ELLIPSE/CIRCLE TASK
            TRAP    #15                     ; DO IT
                        
            MOVE.B  #80,D0                  ; SET PEN COLOR TASK
            MOVE.L  #INIF2COL,D1             ; PEN SHADOW COLOR
            TRAP    #15                     ; SET PEN COLOR
            ADDQ.B  #1,D0                   ; SET FILL COLOR TASK
            MOVE.L  #INIF2COL,D1             ; FILL SHADOW COLOR
            TRAP    #15                     ; SET FILL COLOR

            MOVE.W  #SCRWIDTH/2,D1
            MOVE.W  #SCRHEIGH/2,D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            SUB.W   #50,D2
            ADD.W   #50,D4
            SUB.W   #100,D1
            ADD.W   #100,D3
            MOVE.B  #88,D0                  ; DRAW ELLIPSE/CIRCLE TASK
            TRAP    #15                     ; DO IT

            MOVE.B  #80,D0                  ; SET PEN COLOR TASK
            MOVE.L  #INIF3COL,D1             ; PEN SHADOW COLOR
            TRAP    #15                     ; SET PEN COLOR
            ADDQ.B  #1,D0                   ; SET FILL COLOR TASK
            MOVE.L  #INIF3COL,D1             ; FILL SHADOW COLOR
            TRAP    #15                     ; SET FILL COLOR
            
            MOVE.W  #SCRWIDTH/2,D1
            MOVE.W  #SCRHEIGH/2,D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            SUB.W   #30,D2
            ADD.W   #30,D4
            SUB.W   #70,D1
            ADD.W   #70,D3
            MOVE.B  #88,D0                  ; DRAW ELLIPSE/CIRCLE TASK
            TRAP    #15                     ; DO IT
            ;PRINTINIBALRAD
            
            MOVE.B  #80,D0                  ; SET PEN COLOR TASK
            MOVE.L  #BASPCOL,D1             ; PEN SHADOW COLOR
            TRAP    #15                     ; SET PEN COLOR
            ADDQ.B  #1,D0                   ; SET FILL COLOR TASK
            MOVE.L  #BASFCOL,D1             ; FILL SHADOW COLOR
            TRAP    #15                     ; SET FILL COLOR
            
            MOVE.W  IBALXCO,D1                 ; D1:=XCENTER
            MOVE.W  IBALYCO,D2                ; D2:=YCENTER
            MOVE.W  D1,D3                   ; D3:=XCENTER
            MOVE.W  D2,D4                   ; D4:=YCENTER
            
            SUB.W   IBALRAD,D1              ; D1:=XLEFT
            SUB.W   IBALRAD,D2              ; D2:=YTOP
            ADD.W   IBALRAD,D3              ; D3:=XRIGTH
            ADD.W   IBALRAD,D4              ; D4:=YBOTTOM
            MOVE.B  #88,D0                  ; DRAW ELLIPSE/CIRCLE TASK
            TRAP    #15                     ; DO IT
            
            MOVE.L  #BALMCOL,D1             ;SET BALL'S MAIN COLOR
            MOVE.B  #80,D0
            TRAP    #15
            MOVE.B  #81,D0
            TRAP    #15

            MOVE.W  IBALXCO,D1              ; D1:=XCENTER
            SUB.W   IBALRAD,D1
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
            
            MOVE.W  IBALXCO,D1              ; D1:=XCENTER  
            SUB.W   IBALRAD,D1
            ADD.W   #15,D1                  ; D1:=XLEFT
            ADD.W   #3,D2                   ; D2:=YTOP
            SUB.W   #7,D3                   ; D3:=XRIGTH
            SUB.W   #20,D4                  ; D4:=YBOTTOM
            MOVE.B  #88,D0                  ; DRAW ELLIPSE/CIRCLE TASK
            TRAP    #15                     ; DO IT
            RTS
.STR0	DC.B    'PRESS ENTER KEY TO SKIP',0   
	DS.W	0
; --- MAIN STATES ------------------------------------------------------ SECOND            
; -----------------------------------------------------------------------------
STAMAINI
; INITALIZES THE MAIN
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------  
	CLR.W   (SCRCYCCT)              ; RESET CYCLE COUNTER
	JSR     SFXPMAIN                ; PLAY MAIN SONG
            MOVE.W  #SCRWIDTH/6,D4
            MOVE.W  #SCRHEIGH/6,D5
	MOVE.W  #5,D6                   ; NUM+1 OF COLUMNS
            MOVE.W	#BALID,D0
	LEA	BALINIT,A1
	LEA	BALUPD,A2
	LEA	BALPLOT,A3
	CLR     D1
	MOVE.L  #1,D3
.CRTBALSY	MOVE.W  #5,D7                   ; NUM+1 OF BALLS PER COLUMNS
            CLR     D2
            BCHG    #0,D3
.CRTBALSX   JSR     AGLADD
            BCHG    #0,D3
            ADD.W   D5,D2
            DBRA    D7,.CRTBALSX
            ADD.W   D4,D1
            DBRA    D6,.CRTBALSY
	RTS
; -----------------------------------------------------------------------------
STAMAINU
; UPDATE THE MAIN
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
	BTST.B	#KBDBITF2,(KBDEDGE)
	BNE     .CHSTAT
            CMP.B   #0,(KBDEDGE)            ;IF ANY KEY HAS BEEN PRESSED
            BNE     .CLRCLK
	BTST.B  #0,(SCRCYCCT)           ;POSITIONING TO HIGH BYTE AND BIT TESTING
	BEQ	.END
	MOVE.W	#STAATMOD,(STANEXT)
.END
            JSR     AGLUPD
            JSR     ARWUPD
            RTS
            
.CHSTAT     MOVE.B  #3,D1
            JSR     SFXPLAY                 ;PLAY SELECT SOUND
            LEA     STANEXT,A2
            MOVE.W  ARPOS,A1
            SUB.W   #ARINIPOS,A1
            JMP     .NS(A1)
.NS         MOVEQ   #STAGAME,D1
            BRA.B   .END1
            MOVEQ   #STAHTP,D1
            BRA.B   .END1
            MOVEQ   #STASCORE,D1
            BRA.B   .END1
            JSR     SFXSMAIN                ;CASE WHERE USER PRESSES ENTER
            MOVE.B  #9,D0
            TRAP    #15                     ;EXIT OR SIMHALT :)
.END1       MOVE.B  D1,(STANEXT+1)          ;MOVING STATE TO LOW BYTE OF ADDRESS 'STANEXT'
            BRA     .END
.CLRCLK     CLR.W   SCRCYCCT                ;CLEAR CLOCK IN CASE ANY KEYWORD HAS BEEN PRESSED
            BRA     .END
; -----------------------------------------------------------------------------
STAMAINP
; PLOT THE INTRO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; ----------------------------------------------------------------------------- 
	JSR     AGLPLOT
	JSR     TITPLOT
	JSR     MENPLOT
	JSR     ARWPLOT
            RTS	   
; --- GAME STATES ------------------------------------------------------- THIRD            
; -----------------------------------------------------------------------------
STAGAMEI
; INITALIZES THE GAME
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------  
	JSR     SFXSMAIN                ;STOPPING MAIN SONG FROM MENU
            JSR     PADINIT
	
	CLR.W	BALRBNDS
	CLR.W	BALNUM 
	CLR.L 	SCORE
	
	ADDQ.W	#1,BALNUM
	MOVE.B	#BALID,D0
            MOVE.W  #SCRWIDTH/2,D1
            MOVE.W  #SCRHEIGH/2,D2
	LEA	BALINIT,A1
	LEA	BALUPD,A2
	LEA	BALPLOT,A3
	JSR	AGLADD
	MOVE.B  #1,D1
	JSR     SFXPLAY                 ; PLAYING FANFARE'S READY
	RTS
; -----------------------------------------------------------------------------
STAGAMEU
; UPDATE THE GAME
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
	JSR	PADMOU
            ; ___Update_Ball___ 
            BTST.B	#KBDBITPS,(KBDVAL)  	; "P" PAUSE KEY PRESSED?    
            BNE	.ANOTHER	; 1=PAUSE, 0=NOPAUSE 	  	
            BTST.B	#0,(PAUSE)	; Is not posible pause the game during it
            BEQ	.YESUPD
            BRA	.END	
.ANOTHER		
            MOVE.B  #0,(PAUSE)
            MOVE.B  #1,D1
            JSR     SFXSTOP	  			 	
.YESUPD		 
            JSR	AGLUPD
            ; ___Finish_Update_Ball___	
            
	CMP 	#0,(BALNUM)	; IF BALNUM==0 THEN: GAME OVER 
	BNE	.END	
	
	MOVE.B	#1,(PAUSE)
	
	MOVE.W	#STAGOVER,(STANEXT) 	
.END	
	RTS 

; -----------------------------------------------------------------------------
STAGAMEP
; PLOT THE GAME
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; ----------------------------------------------------------------------------- 
            JSR     PLOTBKG
	JSR     PADPLOT
	JSR	AGLPLOT
	MOVE.B  #81,D0                  ; SET COLOR TASK
            MOVE.L  #BKGCLR,D1              ; FILL COLOR
            TRAP    #15                     ; SET PEN COLOR
            CLR.L   D1
	BTST.B	#0,PAUSE
	BEQ	.PLAYING
	BTST.B  #4,(SCRCYCCT+1)         ;POSITIONING TO LOW BYTE AND BIT TESTING
	BEQ	.PLAYING
            MOVE.W  #((255)/5+3)<<8|26,D1   ;FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ;LOCATE TEXT CURSOR
            LEA     .STR0,A1                ;STRING POINTER
            MOVE.B  #13,D0                  ;PRINT STRING TASK
            TRAP    #15
.PLAYING
            MOVE.W  #(255/2-16)<<8|1,D1     ;FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ;LOCATE TEXT CURSOR
            LEA     .STR1,A1                ;STRING POINTER
            MOVE.W  (BALRBNDS),D1
            MOVE.W  #100-1,D2
            CLR.L   D3
.MULT100    ADD.L   D1,D3
            DBRA    D2,.MULT100
            MOVE.L  D3,D1
            MOVE.L  D1,SCORE
            MOVE.B  #17,D0
            TRAP    #15
            RTS
.STR0       DC.B    'PRESS P TO START',0
.STR1       DC.B    'SCORE:',0
            DS.W    0	
; --- GAME OVER STATES ------------------------------------------------- FOURTH            
; -----------------------------------------------------------------------------
STAGOVRI
; INITALIZES THE GAME OVER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
	MOVE.B  #5,D1
	JSR     SFXPLAY
	LEA     PLNAME,A0
            MOVE.L  #3,D3
.LP         MOVE.B  #'?',(A0)+
            DBRA    D3,.LP
            LEA     PLNAME,A6
            MOVE.B  #5,COUNT                 ;COUNTER FOR WRITING NAME.
	RTS
; -----------------------------------------------------------------------------
STAGOVRU
; UPDATE THE GAME OVER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            CLR.L   D6                      ;CLEARING D6 CONTENT
            MOVE.B  COUNT,D6
            CMP.B   #0,D6
            BEQ     .CONT
            SUB.B   #1,D6
            MOVE.B  D6,COUNT
            MOVE.B  #5,D0
            TRAP    #15
            CMP     #4,D6                   ; FIRST TIME; WE IGNORE THE READEN CHAR
            BEQ     .END
            MOVE.B  D1,(A6)+
            BRA     .END
.CONT       BTST.B	#KBDBITF2,(KBDEDGE)     ;IF PRESS INTRO, RETURN TO MENU
	BEQ	.END                    ;IF NOT, CONTINUE INTO STATE
	LEA     .FN,A1
	JSR     FILEOPN
	JSR     FILERD
	JSR     FILECLS
	LEA     BUFFER,A1
	MOVE.B  #4,D6
.LP	ADD.L   #4,A1
            MOVE.L  (A1)+,D1                ;BUFFER NUM ACTUAL CONTENT
            SUB.L   #8,A1                   ;POSITIONING BACK
            CMP.L   SCORE,D1
            BMI	.SWAP
.CONT1	ADD.L   #8,A1                   ;NEXT PLAYER DATA
            DBRA    D6,.LP
            LEA     .FN,A1
            JSR     FILEOPN
	JSR     FILEWRD                 ;WRITES THE ENTIRE BUFFER.
	JSR     FILECLS
	MOVE.W	#STAMAIN,(STANEXT)
            MOVE.B  #5,D1
            JSR     SFXSTOP
            MOVE.B  #3,D1
            JSR     SFXPLAY
.END	RTS

.SWAP       JSR     SWAPPL
            BRA     .CONT1
.FN         DC.B    'SCORE.txt',0
            DS.W    0
; -----------------------------------------------------------------------------
STAGOVRP
; PLOT THE GAME OVER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; ----------------------------------------------------------------------------- 
            JSR     PLOTBKG
	MOVE.B  #81,D0                  ;SET COLOR TASK
            MOVE.L  #BKGCLR,D1              ;FILL COLOR  
            TRAP    #15                     ;SET PEN COLOR
	
            MOVE.W  #((255)/5+3)<<8|20,D1	;FIRST TEXT COORDINATES
	MOVE.B	#11,D0
	TRAP 	#15	;LOCATE TEXT CURSOR
	LEA 	.GO,A1	;STRING POINTER
	MOVE.B	#13,D0	;PRINT STRING TASK
	TRAP 	#15
	
	MOVE.W  #((255)/7-2)<<8|27,D1	;FIRST TEXT COORDINATES
	MOVE.B	#11,D0
	TRAP 	#15	;LOCATE TEXT CURSOR
	LEA 	.WYN,A1	;STRING POINTER
	MOVE.B	#13,D0	;PRINT STRING TASK
	TRAP 	#15

            MOVE.W  #((255)/7+15)<<8|27,D1	;FIRST TEXT COORDINATES
	MOVE.B	#11,D0
	TRAP 	#15	;LOCATE TEXT CURSOR
	LEA 	PLNAME,A1	;STRING POINTER
	MOVE.B	#13,D0	;PRINT STRING TASK
	TRAP 	#15

	MOVE.W  #((255)/4+3)<<8|27,D1	;FIRST TEXT COORDINATES
	MOVE.B	#11,D0
	TRAP 	#15	;LOCATE TEXT CURSOR
	LEA 	.SCP,A1	;STRING POINTER
	MOVE.B	#13,D0	;PRINT STRING TASK
	TRAP 	#15
	
            MOVE.W  #((255)/4+19)<<8|27,D1	;FIRST TEXT COORDINATES
	MOVE.B	#11,D0
	TRAP 	#15
	MOVE.L  SCORE,D1
	MOVE.B  #3,D0                   ;PRINT SCORE
	TRAP    #15
	
	BTST.B  #4,(SCRCYCCT+1)         ;POSITIONING TO LOW BYTE AND BIT TESTING
	BEQ	.END
	
	MOVE.W	#((255)/5-10)<<8|50,D1	;FIRST TEXT COORDINATES
	MOVE.B	#11,D0
	TRAP 	#15	;LOCATE TEXT CURSOR
	LEA 	.SBM,A1	;STRING POINTER
	MOVE.B	#13,D0	;PRINT STRING TASK
	TRAP 	#15
.END	
	RTS   
.GO	DC.B	'GAME  OVER',0
.SCP        DC.B    'YOUR SCORE WAS:',0
.WYN        DC.B    'WRITE YOUR NAME:',0
.SBM	DC.B	'PRESS ENTER TO SUBMIT SCORE AND RETURN',0   
	DS.W	0
; --- SCORE STATES ------------------------------------------------------ FIFTH            
; -----------------------------------------------------------------------------
STASCORI
; INITALIZES THE SCORE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            LEA     .FN,A1
            LEA     BUFFER,A0
            JSR     FILEOPN
            MOVE.L  #4,D5                   ; DO IT 5 TIMES CAUSE OF TOP 5 PLAYERS
.LP         LEA     PLNAME,A2
            JSR     FILERDPL
            MOVE.L  (A2)+,(A0)+             ;MOVE PLAYERNAME INTO BUFFER
            MOVE.L  SCORE,(A0)+
            DBRA    D5,.LP
            JSR     FILECLS
	RTS
.FN         DC.B    'SCORE.txt',0           
            DS.W    0 
; -----------------------------------------------------------------------------
STASCORU
; UPDATE THE SCORE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------    
	BTST.B	#KBDBITF2,(KBDEDGE)
	BEQ	.END	;ENTER=EXIT
	MOVE.B  #3,D1
	JSR     SFXPLAY
	MOVE.W	#STAMAIN,(STANEXT) 	 
.END	RTS 
; -----------------------------------------------------------------------------
STASCORP
; PLOT THE SCORE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  #(255/4+12)<<8|22,D3    ; SCORE NAME TEXT
	MOVE.W  #(255/7+2)<<8|22,D4     ; PLAYER TEXT COORDS
	MOVE.L  #4,D5                   ; DO 5 TIMES A PRINTING
	MOVE.W	#15,D1	;FIRST TEXT COORDINATES
	MOVE.B	#11,D0
	TRAP 	#15	;LOCATE TEXT CURSOR

            LEA     .TOPS,A1
	MOVE.B  #13,D0
	TRAP    #15                     ; PRINTING TOP SIDE OF SCORE
	
	MOVE.W	#36,D1	;FIRST TEXT COORDINATES
	MOVE.B	#11,D0
	TRAP 	#15	;LOCATE TEXT CURSOR

            LEA     .BOTS,A1
            MOVE.B  #13,D0
	TRAP    #15                     ; PRINTING BOT SIDE OF SCORE
	MOVE.W  #4,D2

	LEA     BUFFER,A1
.LP         MOVE.W  D4,D1
            ADD.W   #3,D4                   ;PREPARE NEXT ROW FOR PLAYER
	MOVE.B  #11,D0
	TRAP    #15                     ;POSITIONING PLAYERNAME TEXT
	MOVE.B  #14,D0
	TRAP    #15                     ;PRINT PLAYER NAME
	ADD.L   #4,A1                   ;MOVE TO SCORE
	MOVE.W  D3,D1                   
	ADD.W   #3,D3                   ;PREPARE NEXT ROW FOR SCORE
            MOVE.B	#11,D0
	TRAP 	#15                     ;POSITIONING SCORE TEXT
	MOVE.L  (A1),D1
	ADD.L   #4,A1
	MOVE.B  #3,D0
	TRAP    #15                     ;PRINT SIGNED NUMBER SCORE
	DBRA    D5,.LP                  ;DO IT 5 TIMES
	
            BTST.B  #4,(SCRCYCCT+1)         ;POSITIONING TO LOW BYTE AND BIT TESTING
	BEQ	.END
	MOVE.W	#(255/5)<<8|50,D1	;FIRST TEXT COORDINATES
	MOVE.B	#11,D0
	TRAP 	#15	;LOCATE TEXT CURSOR
	LEA 	.STR0,A1	;STRING POINTER
	MOVE.B	#13,D0	;PRINT STRING TASK
	TRAP 	#15
.END	
	RTS
.STR0	DC.B	'PRESS ENTER TO RETURN',0   
	DS.W	0
.TOPS       DC.B    TAB,TAB,TAB,TAB,TAB,TAB,'  _________________TOP 5 HIGHSCORES OF ALL TIMES_______________',CR,LF
            DC.B    TAB,TAB,TAB,TAB,TAB,TAB,'  /\  /\  /\  /\  /\  /\  /\  /\  /\  /\  /\  /\  /\  /\  /\  /\',CR,LF
            DC.B    TAB,TAB,TAB,TAB,TAB,TAB,' //\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\',CR,LF
            DC.B    TAB,TAB,TAB,TAB,TAB,TAB,'|    PLAYER_NAME                             SCORE               |',CR,LF
            DC.B    TAB,TAB,TAB,TAB,TAB,TAB,' \\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//',CR,LF
            DC.B    TAB,TAB,TAB,TAB,TAB,TAB,'  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/',NULL
            DS.W    0
.BOTS       DC.B    TAB,TAB,TAB,TAB,TAB,TAB,' /\  /\  /\  /\  /\  /\  /\  /\  /\  /\  /\  /\  /\  /\  /\  /\',CR,LF
            DC.B    TAB,TAB,TAB,TAB,TAB,TAB,'//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\',CR,LF
            DC.B    TAB,TAB,TAB,TAB,TAB,TAB,'\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//',CR,LF
            DC.B    TAB,TAB,TAB,TAB,TAB,TAB,' \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/  \/',NULL
            DS.W    0
; --- HOW TO PLAY STATES ------------------------------------------------ SIXTH            
; -----------------------------------------------------------------------------
STAHTPI
; INITALIZES THE 'HOW TO PLAY'
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            LEA     .FN,A1
            JSR     FILEOPN
            JSR     FILERD
            JSR     FILECLS
	RTS
.FN	DC.B    'HOWTOPLAY.txt',0
	DS.W    0
; -----------------------------------------------------------------------------
STAHTPU
; UPDATE THE 'HOW TO PLAY'
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
	BTST.B	#KBDBITF2,(KBDEDGE)
	BEQ	.END	;ENTER=EXIT
	MOVE.B  #3,D1
	JSR     SFXPLAY
	MOVE.W	#STAMAIN,(STANEXT) 	 
.END	RTS 
; -----------------------------------------------------------------------------
STAHTPP
; PLOT THE 'HOW TO PLAY'
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; ----------------------------------------------------------------------------- 
	LEA	BUFFER,A1
	MOVE.W	#13,D0
	TRAP	#15
	
	BTST.B  #4,(SCRCYCCT+1)         ; POSITIONING TO LOW BYTE AND BIT TESTING
	BEQ	.END
	MOVE.W	#(255/5)<<8|(50),D1	;
	MOVE.B	#11,D0                  ; POSITIONING TEXT INTO SCREEN
	TRAP 	#15	;
	LEA 	.STR1,A1	; STRING POINTER
	MOVE.B	#13,D0	; PRINT STRING TASK
	TRAP 	#15                     
.END	
	RTS   
.STR1	DC.B	'PRESS ENTER TO RETURN',0
	DS.W	0
	RTS   
; --- ATTRACT MODE STATES ---------------------------------------------- SEVENTH           
; -----------------------------------------------------------------------------
STAATMDI
; INITALIZES THE ATTRACT MODE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------  
	JSR     PADINIT
	
	CLR.W	BALRBNDS
	CLR.W	BALNUM 
	CLR.L 	SCORE
	
	ADDQ.W	#1,BALNUM
            
	MOVE.B	#BALID,D0
            MOVE.W  #SCRWIDTH/2,D1
            MOVE.W  #SCRHEIGH/2,D2
	LEA	BALINIT,A1
	LEA	BALUPD,A2
	LEA	BALPLOT,A3
	JSR	AGLADD
	
	RTS
; -----------------------------------------------------------------------------
STAATMDU
; UPDATE THE ATTRACT MODE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W	(BALNUM),D2
	BEQ     .EATM                   ; IF BALNUM == 0, END ATTRACT MODE
	MOVE.B  #BALID,D0               ; 
            JSR     DMMFRSTO                ; TAKES THE FIRST BALL IN AGLIST.
	SUB.W	#1,D2                   ; SUB 1 TO BALNUM'S VAL BECAUSE OF DBRA
	MOVE.W	#BALMAXRAD,D3	; PREPARING D3 TO CMP BALRADS
.LOOP
	CMP.W	16(A0),D3               ; IF BALRADIUS IS NOT LOWER THAN ACTUAL
	BMI	.NEXT                   ; LOOK FOR NEXT BAL
	MOVE.W	16(A0),D3               ; ELSE, KEEP ADDRESS MEMORY STORED
	MOVEA.L	A0,A1	;
.NEXT
            JSR	DMMNEXTO	
	DBRA	D2,.LOOP
	MOVEA.L	A1,A0
	MOVE.W	8(A0),D0                ; MOVE X COORD OF BALL
	MOVE.W	10(A0),D1               ; MOVE Y COORD OF BALL
	JSR	PADCOR		 
	BRA 	.CONT	
.EATM	MOVE.W	#STAMAIN,(STANEXT)
.CONT	CMP.B	#0,(KBDEDGE)
	BEQ	.END	; SPACE=MAIN
	MOVE.W	#STAMAIN,(STANEXT)
.END	JSR	AGLUPD
	RTS          
; -----------------------------------------------------------------------------
STAATMDP
; PLOT THE ATTRACT MODE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; ----------------------------------------------------------------------------- º
            JSR     PLOTBKG
            MOVE.B  #81,D0                  ; SET COLOR TASK
            MOVE.L  #BKGCLR,D1              ; FILL COLOR
            TRAP    #15 
            CLR.L   D1
            MOVE.W  #(255/2-16)<<8|1,D1     ;FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR1,A1                ; STRING POINTER

            MOVE.W  (BALRBNDS),D1

            MOVE.W  #100-1,D2
            CLR.W   D3
.MULT100    ADD.W   D1,D3
            DBRA    D2,.MULT100
            MOVE.W  D3,D1

            MOVE.W  D1,SCORE

            MOVE.B  #17,D0
            TRAP    #15

            BTST.B  #5,(SCRCYCCT+1)         ; POSITIONING TO LOW BYTE AND BIT TESTING
            BNE     .NEXT


            MOVE.W  #((255/5)+2)<<8|50,D1  ; FIRST TEXT COORDINATES
            MOVE.B  #11,D0
            TRAP    #15                     ; LOCATE TEXT CURSOR
            LEA     .STR0,A1                ; STRING POINTER
            MOVE.B  #13,D0                  ; PRINT STRING TASK
            TRAP    #15 
.NEXT
            JSR     PADPLOT
            JSR     AGLPLOT
            RTS
.STR0       DC.B    'PRESS ANY KEY',0
.STR1       DC.B    'SCORE:',0
            DS.W    0





*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~

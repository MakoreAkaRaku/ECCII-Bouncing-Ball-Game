; =============================================================================
; TITLE    : EXAMPLE GAME (MAIN PROGRAM)
; AUTHOR   : ANTONI BURGUERA
; HISTORY  : 10-OCT-2020 - CREATION
;            11-OCT-2020 - MINOR CHANGES
; =============================================================================

            ORG     $1000

; --- CODE INCLUDES -----------------------------------------------------------

            INCLUDE "SYSCONST.X68"          ; SYSTEM CONSTANTS
            INCLUDE "SYSTEM.X68"            ; SYSTEM CODE
            INCLUDE "CONST.X68"             ; GAME CONSTANTS
            INCLUDE "PAD.X68"               ; PAD CODE
            INCLUDE "AGENTLST.X68"	; AGENT LIST MANAGEMENT
            INCLUDE "BALL.X68"	; BALL MANAGEMENT
            INCLUDE "FONS.X68"	; BACKGROUND 
            
; --- INITIALIZE --------------------------------------------------------------

START       JSR     SYSINIT                 ; INITIALIZE SYSTEM-RELATED STUFF

            ; TO DO : ADD YOUR GAME INITIALIZATION HERE
            
            ;JSR	FONSPLOT
            
            JSR     PADINIT
            
	MOVE.W	#BALID,D0
	LEA	BALINIT,A1
	LEA	BALUPD,A2
	LEA	BALPLOT,A3
	JSR	AGLADD

; --- UPDATE ------------------------------------------------------------------

.LOOP       TRAP    #KBDTRAP                ; READ KEYBOARD

            ; TO DO : ADD YOUR GAME UPDATE HERE
            
            ;JSR     PADUPDKB
            JSR	PADMOU
            
            ; ___Update_Ball___ 
            BTST.B	#KBDBITPS,(KBDVAL)      ; "P" PAUSE KEY PRESSED?    
            BNE	.ANOTHER	           ; 1=PAUSE, 0=NOPAUSE 	  	
            BTST.B	#0,(PAUSE)
            BEQ	.YESUPD
            BRA	.WINT	
.ANOTHER		
            MOVE.B #0,(PAUSE)	  			 	
.YESUPD		 
            JSR	AGLUPD      
            ; ___Finish_Update_Ball___
            
            ; --- WAIT SYNCH --------------------------------------------------------------

.WINT       TST.B   (SCRINTCT)              ; WAIT FOR INTERRUPT
            BEQ     .WINT
            CLR.B   (SCRINTCT)

; --- PLOT --------------------------------------------------------------------

            ; TO DO : ADD YOUR GAME PLOT HERE
            ;JSR	FONSPLOT
            JSR     PADPLOT
	JSR	AGLPLOT
	
            TRAP    #SCRTRAP                ; SHOW GRAPHICS
            BRA     .LOOP                   ; MAIN LOOP
            SIMHALT

; --- VARIABLES ---------------------------------------------------------------

            INCLUDE "SYSVAR.X68"
            INCLUDE "VAR.X68"
            END    START


















*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~

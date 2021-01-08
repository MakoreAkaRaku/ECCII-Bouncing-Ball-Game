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
            INCLUDE "SFX.X68"               ; SFX MANAGEMENT
            INCLUDE "TITLE.X68"
            INCLUDE "MENU.X68"
            INCLUDE "ARROW.X68"     
; --- INITIALIZE --------------------------------------------------------------
*------
START       JSR     SYSINIT                 ; INITIALIZE SYSTEM-RELATED STUFF
            JSR     SFXINIT
            JSR     ARINIT
            ; TO DO : ADD YOUR GAME INITIALIZATION HERE
            MOVE.W  #SCRWIDTH/6,D4
            MOVE.W  #SCRHEIGH/6,D5
	MOVE.W  #5,D6
            MOVE.W	#BALID,D0
	LEA	BALINIT,A1
	LEA	BALUPD,A2
	LEA	BALPLOT,A3
	CLR     D1
.CRTBALSY	MOVE.W  #5,D3
            CLR     D2
.CRTBALSX   JSR     AGLADD
            ADD.W   D5,D2
            DBRA    D3,.CRTBALSX
            ADD.W   D4,D1
            DBRA    D6,.CRTBALSY
            JSR     SFXPMAIN
; --- UPDATE ------------------------------------------------------------------

.LOOP       TRAP    #KBDTRAP                ; READ KEYBOARD

            ; TO DO : ADD YOUR GAME UPDATE HERE
            JSR     AGLUPD
            JSR     ARWUPD
            ; --- WAIT SYNCH --------------------------------------------------------------

.WINT       TST.B   (SCRINTCT)              ; WAIT FOR INTERRUPT
            BEQ     .WINT
            CLR.B   (SCRINTCT)

; --- PLOT --------------------------------------------------------------------

            ; TO DO : ADD YOUR GAME PLOT HERE
	JSR	AGLPLOT
	JSR     TITPLOT
	JSR     MENPLOT
	JSR     ARWPLOT
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

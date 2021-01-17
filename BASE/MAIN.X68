; =============================================================================
; TITLE    : EXAMPLE GAME (MAIN PROGRAM)
; AUTHOR   : ANTONI BURGUERA
; HISTORY  : 10-OCT-2020 - CREATION
;            11-OCT-2020 - MINOR CHANGES
; =============================================================================

            ORG     $1000

; --- CODE INCLUDES -----------------------------------------------------------
            INCLUDE "UTIL.X68"
            INCLUDE "CONST.X68"             ; GAME CONSTANTS
            INCLUDE "SYSCONST.X68"          ; SYSTEM CONSTANTS
            INCLUDE "SYSTEM.X68"            ; SYSTEM CODE
            INCLUDE "PAD.X68"               ; PAD CODE
            INCLUDE "AGENTLST.X68"	; AGENT LIST MANAGEMENT
            INCLUDE "BALL.X68"	; BALL MANAGEMENT
            INCLUDE "BKG.X68"	; BACKGROUND PAINTING MANAGEMENT 
            INCLUDE "RANDOM.X68"	; RANDOM NUMBER GENERATOR
            INCLUDE "STATES.X68"	; STATE MANAGEMENT
            INCLUDE "FILE.X68"	; FILE MANAGEMENT
            INCLUDE "SFX.X68"               ; SFX MANAGEMENT
            INCLUDE "TITLE.X68"             ; TITLE PAINTING MANAGEMENT
            INCLUDE "MENU.X68"              ; MENU MANAGEMENT
            INCLUDE "ARROW.X68"             ; ARROW MANAGEMENT
            
; --- INITIALIZE --------------------------------------------------------------

START       JSR     SYSINIT                 ; INITIALIZE SYSTEM-RELATED STUFF

            ; TO DO : ADD YOUR GAME INITIALIZATION HERE
            
            JSR	STAINIT

; --- UPDATE ------------------------------------------------------------------

.LOOP       TRAP    #KBDTRAP                ; READ KEYBOARD

            ; TO DO : ADD YOUR GAME UPDATE HERE
            JSR	STAUPD            
; --- WAIT SYNCH --------------------------------------------------------------

.WINT       TST.B   (SCRINTCT)              ; WAIT FOR INTERRUPT
            BEQ     .WINT
            CLR.B   (SCRINTCT)

; --- PLOT --------------------------------------------------------------------

            ; TO DO : ADD YOUR GAME PLOT HERE
            JSR	STAPLOT
	
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

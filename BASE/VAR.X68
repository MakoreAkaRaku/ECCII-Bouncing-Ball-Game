; =============================================================================
; TITLE    : GAME VARIABLES
; AUTHOR   : ANTONI BURGUERA
; HISTORY  : 12-OCTOBER-2020 - CREATION
; =============================================================================
; --- INIBALL RELATED VARIABLES -----------------------------------------------
IBALXCO     DS.W    1
IBALYCO     DS.W    1
IBALRAD     DS.W    1
IBALSPE     DS.W    1
IBALACC     DS.W    1
;------------------------------------------------------------------------------
; --- PAD RELATED VARIABLES ---------------------------------------------------

PADX        DS.W    1                       ; PAD X COORDINATE (XCENTER)
PADY        DS.W    1                       ; PAD Y COORDINATE (YCENTER)

; --- GAME RELATED VARIABLES --------------------------------------------------

PAUSE	DS.B	1	; X0/X1 PAUSE GAME
BALRBNDS	DS.W	1	; NUMBER OF REBOUNDS
	DS.W	0
; --- RANDOM NUMBER GENERATOR VARIABLES ---------------------------------------

RNDINDEX 	DS.B 	1	; RANDOM INDEX
	DS.W	0
; --- STATE MANAGEMENT VARIABLES ----------------------------------------------

STACUR      DS.W    1                       ; CURRENT STATE
STANEXT     DS.W    1                       ; NEXT STATE

; --- BALL RELATED VARIABLES --------------------------------------------------

BALNUM	DS.W	1
	DS.W	0
; --- ARROW RELATED VARIABLES -------------------------------------------------

ARPOS       DS.W    1                       ; HIGH BYTE INDICATES ROW, LOW BYTE INDICATES COLUMN
; --- FILE RELATED VARIABLES --------------------------------------------------
BUFFER      DS.L    11
PLNAME      DS.L    1                       ;STORES PLAYER NAME.
            DC.B    NULL                        
SCORE       DS.L    1                       ;STORES THE BINARY NUMBER OF THE PLAYER.
COUNT       DS.B    1
            DS.W    0



*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~

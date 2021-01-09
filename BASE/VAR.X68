; =============================================================================
; TITLE    : GAME VARIABLES
; AUTHOR   : ANTONI BURGUERA
; HISTORY  : 12-OCTOBER-2020 - CREATION
; =============================================================================

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


*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~

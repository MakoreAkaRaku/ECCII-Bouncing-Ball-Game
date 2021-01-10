; =============================================================================
; TITLE    : PAD MANAGEMENT
; AUTHOR   : FAUSTI RODRIGUEZ
; COMMENTS :
; HISTORY  :
; =============================================================================

; --- PAD RELATED CONSTANTS ---------------------------------------------------

PADWIDTH    EQU     64                      ; PAD WIDTH
PADHEIGH    EQU     48                      ; PAD HEIGHT
PADPCOL     EQU     $00FF0000               ; PEN COLOR
PADFCOL     EQU     $00770000               ; FILL COLOR
PADSPEED    EQU     8                       ; PAD SPEED

; --- BALL RELATED CONSTANTS --------------------------------------------------

BALID	EQU	1	; BALL IDENTIFIER
BALRAD	EQU	15	; BALL RADIUS
BASPCOL	EQU	$00000000 	; PEN SHADOW COLOR
BASFCOL	EQU	$00050C66	; FILL SHADOW COLOR
BALMCOL     EQU     $000000FF               ; MAIN BALL COLOR
BALBCOL     EQU     $00B9B6FA               ; FILL & PEN BRIGHT COLOR
BALSPEED	EQU	2	; BALL REFERENCE SPEED
; --- SFX RELATED CONSTANTS ---------------------------------------------------
SFXMAIN     DC.B    'main.wav',0
            DS.W    0
; --- MENU RELATED CONSTANTS --------------------------------------------------
MENWIDTH    EQU     280
MENHEIGH    EQU     280
MENPCOL	EQU	$00FFFFFF 	; PEN COLOR
MENFCOL	EQU	$00000000	; FILL COLOR
; --- TITLE RELATED CONSTANTS -------------------------------------------------
TITFCOL	EQU	$00263466	; FILL COLOR
; --- ARROW RELATED CONSTANTS -------------------------------------------------
ARINIPOS    EQU     $3724                   ; ARROW INITIAL POSITION
ARFINPOS    EQU     $3730                   ; ARROW FINAL POSITION








*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~

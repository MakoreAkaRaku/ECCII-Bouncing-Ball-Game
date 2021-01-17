; =============================================================================
; TITLE    : PAD MANAGEMENT
; AUTHOR   : FAUSTI RODRIGUEZ
; COMMENTS :
; HISTORY  :
; =============================================================================

; --- PAD RELATED CONSTANTS ---------------------------------------------------


PADWIDTH    EQU     75   ;75                   ;PAD WIDTH
PADHEIGH    EQU     80 ;80                      ;PAD HEIGHT

PADPCOL     EQU     $000000FF               ;PEN COLOR
PADFCOL     EQU     $000000FF               ;FILL COLOR
PAD2PCO     EQU     $00000000               ;PEN COLOR MAROON
PAD2FCO     EQU     $003785D3               ;FILL COLOR MAROON
                      ;F7B472

PAD3PCO     EQU     $003785D3               ;PEN COLOR MAROON
PAD3FCO     EQU     $003888D7               ;FILL COLOR MAROON 
                      ;D38537
                      ;D78838

PAD4PCO     EQU     $003A8CDE               ;PEN COLOR MAROON
PAD4FCO     EQU     $003C90E3               ;FILL COLOR MAROON
                      ;DE8C3A
                      ;E3903C

PAD5PCO     EQU     $00000000               ;PEN COLOR MAROON 3D93E7
PAD5FCO     EQU     $00000000              ;FILL COLOR MAROON 3F97ED
                       ;E7933D 
                       ;ED973F



                                             ;PADY        EQU     SCRHEIGH-PADHEIGH-PADHEIGH/2 ;PAD Y CORDINATE

PADSPEED    EQU     8                       ;PAD SPEED MOVEMENT
; --- INIT RELATED CONSTANTS ---------------------------------------------
INIF1COL    EQU     $000D6A93               ;F4FA
INIF2COL    EQU     $0061D7F8
INIF3COL    EQU     $00C8FBFD
; -----------------------------------------------------------------------------
; --- BALL RELATED CONSTANTS --------------------------------------------------

BALID	EQU	1	; BALL IDENTIFIER
BALMRAD     EQU     15                      ; BALL RADIUS
BALRAD      EQU     80
BALMINRAD   EQU     20                      ; BALL MINIMUM RADIUS
BALMAXRAD   EQU     80                      ; BALL MAXIMUM RADIUS
BALPCOL	EQU	$00FFFFFF	; PEN COLOR
BALFCOL	EQU	$0000A5FF	; FILL COLOR
BASPCOL	EQU	$00000000 	; PEN SHADOW COLOR
BASFCOL	EQU	$00050C66	; FILL SHADOW COLOR
BALMCOL     EQU     $000000FF               ; MAIN BALL COLOR
BALBCOL     EQU     $00B9B6FA               ; FILL & PEN BRIGHT COLOR
BALSPEED    EQU     2                       ; BALL REFERENCE SPEED
BALBNC      EQU     $5                      ; BALL MAX BOUNCE UNTIL A NEW BALL
; --- STATE RELATED VARIABLES -------------------------------------------------

STAINTRO 	EQU     0
STAMAIN 	EQU     1
STAGAME	EQU     2
STAGOVER	EQU     3
STASCORE	EQU     4
STAHTP	EQU     5
STAATMOD    EQU     6
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

; --- GENERIC CONSTANTS -------------------------------------------------------
BLKCOLOR    EQU     $00000000
HTPSIZE     EQU     $000003AD

; --- BKG RELATED CONSTANTS ---------------------------------------------------
SQUARESH    EQU     7                       ; NUMBER OF BITS TO SHIFT
SQUARESZ    EQU     1<<SQUARESH             ; SQUARE SIZE

BKGCLRFT    EQU     $0F344A                 ;RGB: 4A340F
BKGCLRCL    EQU     $657785                 ;RGB: 857765
                                            ;657785

CLRTABLE    EQU  $127DBB                   ;RGB: BB7D12
BKGCLRT     EQU  $1075B0                   ;RGB: B07510  
CLRTALEG    EQU  $7A9FB5                   ;RGB: B59F7A
;CLRFTABL    EQU  $0F344A                   ;RGB: 4A340F

BKGCLR      EQU  $78B4F0
;--------------------------------------------------------------------------------
;---------- FILE RELATED CONSTANTS ----------------------------------------------
NULL        EQU     $00                     ; NULL CHAR
TAB         EQU     $09                     ; HORIZONTAL TAB
CR          EQU     $0D                     ; ENTER
LF          EQU     $0A                     ; ENTER 2.0
SPACE       EQU     ' '                     ; SPACE
;--------------------------------------------------------------------------------





















*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~

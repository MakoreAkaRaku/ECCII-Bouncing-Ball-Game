SQUARESH    EQU     6                       ; NUMBER OF BITS TO SHIFT
SQUARESZ    EQU     1<<SQUARESH             ; SQUARE SIZE

; -----------------------------------------------------------------------------
FONSPLOT
; Initializes the graphic output to windowed and SCRWIDTHxSCRHEIGH and installs
; TRAP #0. Then, it draws a grid, each square being SQUARESZxSQUARESZ pixels
; by drawing squares using DRSQUARE.
; -----------------------------------------------------------------------------
	MOVEM.L D0-D2/A0/A1/A2,-(A7)
            MOVE.L  #1,D1
            MOVE.B  #33,D0
            TRAP    #15                     ; ENSURE WINDOWED MODE
            MOVE.L  #SCRWIDTH<<16|SCRHEIGH,D1
            TRAP    #15                     ; SET RESOLUTION TO 640X480
            MOVE.L  #DRSQUARE,($80)         ; INSTALL TRAP #0

            CLR.W   D0                      ; INITIAL COORDINATES
            MOVE.W  #SCRHEIGH/SQUARESZ-1,D2 ; ROW COUNTER
.LOOP       MOVE.W  #SCRWIDTH/SQUARESZ-1,D1 ; COLUMN COUNTER
            TRAP    #0
            ADDQ.W  #1,D0                   ; NEXT X
            DBRA.W  D1,.LOOP
            AND.W   #$FF00,D0               ; RESET X
            ADD.W   #$0100,D0               ; NEXT Y
            DBRA.W  D2,.LOOP
            MOVEM.L (A7)+,A2/A1/A0/D0-D2
	RTS

; -----------------------------------------------------------------------------
DRSQUARE
; Draws a square of SQUARESZxSQUARESZ pixels, top-left coordinates being
; X*SQUARESZ,Y*SQUARESZ
; Input    - D0.W: 8-MSB X, 8-LSB Y (top-left coordinate is X*SQUARESZ,
;            Y*SQUARESZ)
; Output   - None
; Modifies - Nothing
; -----------------------------------------------------------------------------
            MOVEM.L D0-D5,-(A7)             ; STORE REGISTERS
            MOVE.W  D0,D5                   ; COPY D0
            MOVE.B  #80,D0                  ; TRAP CODE TO DEFINE PEN COLOR
            MOVE.L  #$00FFFFFF,D1           ; COLOR=WHITE
            TRAP    #15                     ; SET PEN COLOR
            MOVE.W  D5,D1
            AND.W   #$00FF,D1               ; ISOLATE XINI (JUST MASK IT)
            LSL.W   #SQUARESH,D1            ; TIMES 32
            MOVE.W  D5,D2
            LSR.W   #8,D2                   ; PREPARA YINI (SHIFT RIGHT)
            LSL.W   #SQUARESH,D2            ; TIMES 32
            MOVE.W  D1,D3                   ; COPY XINI TO XEND
            MOVE.W  D2,D4                   ; COPY YINI TO YEND
            ADD.W   #SQUARESZ,D3            ; ADD SQUARESZ TO BUILD XEND
            ADD.W   #SQUARESZ,D4            ; ADD SQUARESZ TO BUILD YEND
            MOVE.B  #87,D0                  ; TRAP CODE TO DRAW RECTANGLE
            TRAP    #15                     ; DRAW IT
            MOVEM.L (A7)+,D0-D5             ; RESTORE REGISTERS
            RTE

*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~

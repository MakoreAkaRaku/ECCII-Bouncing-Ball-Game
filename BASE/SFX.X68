; =============================================================================
; TITLE    : SFX SOUND MANAGEMENT
; AUTHOR   : MARC ROMAN COLOM
; HISTORY  :
; =============================================================================

;------------------------------------------------------------------------------
SFXINIT
; LOAD ALL SOUND EFFECTS AND MUSIC INTO BUFFER SOUND.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
;------------------------------------------------------------------------------
            MOVEM.L D0-D1/A1,-(A7)
            LEA     .INTRSFX,A1             ;PLACING FILENAME REFERENCE TO A1
            CLR     D1                      ;PREPARING D1 FOR REFEER TO SOUND FILE
.LOAD       MOVE.B  #74,D0                  ;PREPARING D0 TO LOAD SOUND FILE
            TRAP    #15
            ADD.L   #10,A1
            ADDQ.B  #1,D1
            CMP     #.GMOSFX,A1
            BLE     .LOAD
            LEA     .MAIN,A1
            MOVE.B  #71,D0                  ;LOAD MAIN SONG TO BUFFER OF
            TRAP    #15                     ; STANDARD MEDIA PLAYER
            MOVEM.L (A7)+,D0-D1/A1
            RTS
.INTRSFX    DC.B    'sfx/0.wav',0
.RDYSFX     DC.B    'sfx/1.wav',0
.SELSFX     DC.B    'sfx/2.wav',0
.CRSFX      DC.B    'sfx/3.wav',0
.BNCSFX     DC.B    'sfx/4.wav',0
.GMOSFX     DC.B    'sfx/5.wav',0
.MAIN       DC.B    'sfx/song.wav',0
            DS.W    0
;------------------------------------------------------------------------------
SFXPLAY
; PLAY A SOUND EFFECT LOADED IN DIRECTX'S SOUND MEMORY
; INPUT    - D1.B := num assignated to sound effect /music.
; OUTPUT   - NONE
; MODIFIES - NONE
;------------------------------------------------------------------------------
            MOVEM.L D0/D2,-(A7)
            MOVE.L  #0,D2
            MOVE.B  #77,D0
            TRAP    #15
            MOVEM.L (A7)+,D0/D2
            RTS
;------------------------------------------------------------------------------
SFXSTOP
; STOPS A SOUND EFFECT LOADED IN DIRECTX'S SOUND MEMORY
; INPUT    - D1.B := num assignated to sound effect /music.
; OUTPUT   - NONE
; MODIFIES - NONE
;------------------------------------------------------------------------------
            MOVEM.L D0/D2,-(A7)
            MOVE.L  #2,D2
            MOVE.B  #77,D0
            TRAP    #15
            MOVEM.L (A7)+,D0/D2
            RTS
;-------------------------------------------------------------------------------
SFXPMAIN
; PLAY MENU MUSIC USING STANDARD PLAYER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
;-------------------------------------------------------------------------------
            MOVEM.L D0-D2/A1,-(A7)
            MOVE.B  #6,D1
            MOVE.L  #0,D2
            MOVE.B  #76,D0
            TRAP    #15
            MOVEM.L (A7)+,D0-D2/A1
            RTS
;-------------------------------------------------------------------------------
SFXSMAIN
; STOPS MENU MUSIC USING STANDARD PLAYER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
;-------------------------------------------------------------------------------
            MOVEM.L D0-D2/A1,-(A7)
            MOVE.B  #6,D1
            MOVE.L  #2,D2
            MOVE.B  #76,D0
            TRAP    #15
            MOVEM.L (A7)+,D0-D2/A1
            RTS
;-------------------------------------------------------------------------------


*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~

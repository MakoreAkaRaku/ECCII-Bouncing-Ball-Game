; =============================================================================
; TITLE    : TITLE MANAGEMENT
; AUTHOR   : MARC ROMAN COLOM
; HISTORY  :
; =============================================================================
TITPLOT
            MOVEM.L D0-D2/A0-A1,-(A7)
            MOVE.W  #$1508,D1
            LEA     .STR0,A0
.LOOP
            MOVE.B  #11,D0
            TRAP    #15                     ;SET ROWS TO PRINT STRING
            MOVE.L  A0,A1                   ;POINTS TO STRING
            MOVE.B  #13,D0
            TRAP    #15
            ADD.L   #80,A0                  ;TAKING CARE OF LENGTH PER LINE
            ADD.W   #1,D1
            CMP.L   #.STRND,A0
            BLE     .LOOP
            MOVEM.L (A7)+,D0-D2/A0-A1
            RTS
.STR0       DC.B    '  ____    _   _   ____    _____   ____      __  __   _____    ____      _      ',0
            DC.B    ' / ___|  | | | | |  _ \  | ____| |  _ \    |  \/  | | ____|  / ___|    / \     ',0
            DC.B    ' \___ \  | | | | | |_) | |  _|   | |_) |   | |\/| | |  _|   | |  _    / _ \    ',0
            DC.B    '  ___) | | |_| | |  __/  | |___  |  _ <    | |  | | | |___  | |_| |  / ___ \   ',0
            DC.B    ' |____/   \___/  |_|     |_____| |_| \_\   |_|  |_| |_____|  \____| /_/   \_\  ',0
            DC.B    '                                                                               ',0
            DC.B    '                  _____      _       ____    ____    ___    _____              ',0
            DC.B    '                 |  ___|    / \     / ___|  / ___|  / _ \  |_   _|             ',0
            DC.B    '                 | |_      / _ \   | |  _  | |  _  | | | |   | |               ',0
            DC.B    '                 |  _|    / ___ \  | |_| | | |_| | | |_| |   | |               ',0
            DC.B    '                 |_|     /_/   \_\  \____|  \____|  \___/    |_|               ',0
            DC.B    '                                                                               ',0
            DC.B    '                                    ___   ___                                  ',0
            DC.B    '                                   |_ _| |_ _|                                 ',0
            DC.B    '                                    | |   | |                                  ',0
            DC.B    '                                    | |   | |                                  ',0
            DC.B    '                                   |___| |___|                                 ',0
.STRND      DC.B    '                                                                               ',0
            ;79 length per line Font: Standard


*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~

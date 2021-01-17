*-----------------------------------------------------------
* Title      :BKG PAINTING MANAGEMENT
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------

; -----------------------------------------------------------------------------
PLOTBKG    
; Initializes the graphic output to windowed and SCRWIDTHxSCRHEIGH and installs
; TRAP #0. Then, it draws a grid, each square being SQUARESZxSQUARESZ pixels
; by drawing squares using DRSQUARE.
; -----------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)        
            CLR.W   D0                                       ; INITIAL COORDINATES
            MOVE.W  #SCRHEIGH/SQUARESZ,D2                    ; ROW COUNTER
.LOOP2      MOVE.W  #SCRWIDTH/SQUARESZ,D1                    ; COLUMN COUNTER
.LOOP       JSR     DRSQUARE
            ADDQ.W  #1,D0                                    ; NEXT X
            DBRA.W  D1,.LOOP
            AND.W   #$FF00,D0                                ; RESET X
            ADD.W   #$0100,D0                                ; NEXT Y
            DBRA.W  D2,.LOOP2       
            
            ;------FOOT
            ;FIRST FINGER
            MOVE.B  #80,D0                                   ;SET COLOR TASK
            MOVE.L  #BKGCLRFT,D1                             ;PEN COLOR
            TRAP    #15                                      ;SET PEN COLOR
            ADDQ.B  #1,D0                                    ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRFT,D1                             ;FILL COLOR
            TRAP    #15                                      ;SET FILL COLOR 
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-16,D1               ;D1:=XCENTER
            MOVE.W  #SCRHEIGH-20-15,D2                       ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+16,D3               ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+20+15,D4                       ;D4:=YCENTER
            MOVE.B  #88,D0
            TRAP    #15                                      ;DRAW RECTANGLE
            ;------UNGLA
            MOVE.B  #80,D0                                   ;SET COLOR TASK
            MOVE.L  #BKGCLRCL,D1                             ;PEN COLOR
            TRAP    #15                                      ;SET PEN COLOR
            ADDQ.B  #1,D0                                    ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRCL,D1                             ;FILL COLOR
            TRAP    #15                                      ;SET FILL COLOR
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-10,D1               ;D1:=XCENTER
            MOVE.W  #SCRHEIGH-10-15-6,D2                     ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+10,D3               ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+40+15,D4                       ;D4:=YCENTER            
            MOVE.B  #88,D0
            TRAP    #15                                      ;DRAW RECTANGLE
            ;-----FIN UNGLA
            ;-----DIBUIXAM RECTANGLE(COLOR DIT) DEMUNT UNGLA PER TAPAR LA RESTA DE LA CIRCONFERENCIA.
            MOVE.B  #80,D0                                   ;SET COLOR TASK
            MOVE.L  #BKGCLRFT,D1                             ;PEN COLOR
            TRAP    #15                                      ;SET PEN COLOR
            ADDQ.B  #1,D0                                    ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRFT,D1                             ;FILL COLOR
            TRAP    #15                                      ;SET FILL COLOR 
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-9,D1                ;D1:=XCENTER
            MOVE.W  #SCRHEIGH-10,D2                          ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+9,D3                ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+40+15+20,D4                    ;D4:=YCENTER 
            MOVE.B  #87,D0
            TRAP    #15                                       ;DRAW RECTANGLE
            ;-----FIN RECTANGLE
            ;SECOND FINGER
            MOVE.B  #80,D0                                    ;SET COLOR TASK
            MOVE.L  #BKGCLRFT,D1                              ;PEN COLOR
            TRAP    #15                                       ;SET PEN COLOR
            ADDQ.B  #1,D0                                     ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRFT,D1                              ;FILL COLOR
            TRAP    #15                                       ;SET FILL COLOR 
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-15+25,D1             ;D1:=XCENTER
            MOVE.W  #SCRHEIGH-20-10,D2                        ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+15+25,D3             ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+20+15,D4                        ;D4:=YCENTER
            MOVE.B  #88,D0
            TRAP    #15                                       ;DRAW RECTANGLE
            ;------UNGLA
            MOVE.B  #80,D0                                    ;SET COLOR TASK
            MOVE.L  #BKGCLRCL,D1                              ;PEN COLOR
            TRAP    #15                                       ;SET PEN COLOR
            ADDQ.B  #1,D0                                     ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRCL,D1                              ;FILL COLOR
            TRAP    #15                                       ;SET FILL COLOR
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-10+25,D1             ;D1:=XCENTER
            MOVE.W  #SCRHEIGH-10-15-3,D2                      ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+10+25,D3             ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+40+15,D4                        ;D4:=YCENTER            
            MOVE.B  #88,D0
            TRAP    #15                                       ;DRAW RECTANGLE
            ;-----FIN UNGLA
            ;-----DIBUIXAM RECTANGLE(COLOR DIT) DEMUNT UNGLA PER TAPAR LA RESTA DE LA CIRCONFERENCIA.
            MOVE.B  #80,D0                                      ;SET COLOR TASK
            MOVE.L  #BKGCLRFT,D1                              ;PEN COLOR
            TRAP    #15                                           ;SET PEN COLOR
            ADDQ.B  #1,D0                                       ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRFT,D1                              ;FILL COLOR
            TRAP    #15                                           ;SET FILL COLOR 
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-9+25,D1                ;D1:=XCENTER
            MOVE.W  #SCRHEIGH-10,D2                             ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+9+25,D3                ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+40+15,D4                          ;D4:=YCENTER 
            MOVE.B  #87,D0
            TRAP    #15                                           ;DRAW RECTANGLE
            ;-----FIN RECTANGLE
            ;THIRD FINGER
            MOVE.B  #80,D0                                      ;SET COLOR TASK
            MOVE.L  #BKGCLRFT,D1                              ;PEN COLOR
            TRAP    #15                                           ;SET PEN COLOR
            ADDQ.B  #1,D0                                       ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRFT,D1                              ;FILL COLOR
            TRAP    #15                                           ;SET FILL COLOR 
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-15+50,D1               ;D1:=XCENTER
            MOVE.W  #SCRHEIGH-20-5,D2                           ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+15+50,D3               ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+20+15+20,D4                       ;D4:=YCENTER
            MOVE.B  #88,D0
            TRAP    #15                                           ;DRAW RECTANGLE
            ;------UNGLA
            MOVE.B  #80,D0                                      ;SET COLOR TASK
            MOVE.L  #BKGCLRCL,D1                              ;PEN COLOR
            TRAP    #15                                           ;SET PEN COLOR
            ADDQ.B  #1,D0                                       ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRCL,D1                              ;FILL COLOR
            TRAP    #15                                           ;SET FILL COLOR
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-10+50,D1               ;D1:=XCENTER--AIXI LA DRETA
            MOVE.W  #SCRHEIGH-10-15+4,D2                        ;D2:=YCENTER--NO TOCAR
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+10+50,D3               ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+40+15,D4                          ;D4:=YCENTER            
            MOVE.B  #88,D0
            TRAP    #15                                           ;DRAW RECTANGLE
            ;-----FIN UNGLA
            ;-----DIBUIXAM RECTANGLE(COLOR DIT) DEMUNT UNGLA PER TAPAR LA RESTA DE LA CIRCONFERENCIA.
            MOVE.B  #80,D0                                      ;SET COLOR TASK
            MOVE.L  #BKGCLRFT,D1                              ;PEN COLOR
            TRAP    #15                                           ;SET PEN COLOR
            ADDQ.B  #1,D0                                       ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRFT,D1                              ;FILL COLOR
            TRAP    #15                                           ;SET FILL COLOR 
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-9+50,D1                ;D1:=XCENTER--AIXI LA DRETA
            MOVE.W  #SCRHEIGH-10+1,D2                           ;D2:=YCENTER--NO TOCAR
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+9+50,D3                ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+40+15+20,D4                       ;D4:=YCENTER 
            MOVE.B  #87,D0
            TRAP    #15                                           ;DRAW RECTANGLE
            ;-----FIN RECTANGLE
            ;FOUR FINGER
            MOVE.B #80,D0                                    ;SET COLOR TASK
            MOVE.L  #BKGCLRFT,D1                               ;PEN COLOR
            TRAP    #15                                           ;SET PEN COLOR
            ADDQ.B  #1,D0                                       ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRFT,D1                              ;FILL COLOR
            TRAP    #15                                           ;SET FILL COLOR 
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-15+75,D1               ;D1:=XCENTER
            MOVE.W  #SCRHEIGH-20,D2                             ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+15+75,D3               ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+20+15+20,D4                       ;D4:=YCENTER
            MOVE.B  #88,D0
            TRAP    #15                                           ;DRAW RECTANGLE
            ;------UNGLA
            MOVE.B  #80,D0                                      ;SET COLOR TASK
            MOVE.L  #BKGCLRCL,D1                              ;PEN COLOR
            TRAP    #15                                           ;SET PEN COLOR
            ADDQ.B  #1,D0                                       ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRCL,D1                              ;FILL COLOR
            TRAP    #15                                           ;SET FILL COLOR
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-10+75,D1               ;D1:=XCENTERA
            MOVE.W  #SCRHEIGH-10-15+6,D2                        ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+10+75,D3               ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+40+15,D4                          ;D4:=YCENTER            
            MOVE.B  #88,D0
            TRAP    #15                                            ;DRAW RECTANGLE
            ;-----FIN UNGLA
            ;-----DIBUIXAM RECTANGLE(COLOR DIT) DEMUNT UNGLA PER TAPAR LA RESTA DE LA CIRCONFERENCIA.
            MOVE.B  #80,D0                                       ;SET COLOR TASK
            MOVE.L  #BKGCLRFT,D1                               ;PEN COLOR
            TRAP    #15                                            ;SET PEN COLOR
            ADDQ.B  #1,D0                                        ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRFT,D1                               ;FILL COLOR
            TRAP    #15                                            ;SET FILL COLOR 
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-9+75,D1                 ;D1:=XCENTER-
            MOVE.W  #SCRHEIGH-10+1,D2                            ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+9+75,D3                 ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+40+15+20,D4                        ;D4:=YCENTER 
            MOVE.B  #87,D0
            TRAP    #15                                            ;DRAW RECTANGLE
            ;-----FIN RECTANGLE
            ;------ END FOOT
            
            
            ;----- SECOND FOOT
            ;------FOOT
            ;FIRST FINGER
            MOVE.B  #80,D0                                       ;SET COLOR TASK
            MOVE.L  #BKGCLRFT,D1                               ;PEN COLOR
            TRAP    #15                                            ;SET PEN COLOR
            ADDQ.B  #1,D0                                        ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRFT,D1                               ;FILL COLOR
            TRAP    #15                                            ;SET FILL COLOR 
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+16-50,D1                ;D1:=XCENTER
            MOVE.W  #SCRHEIGH+20+15,D2                           ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-16-50,D3                ;D3:=XCENTER
            MOVE.W  #SCRHEIGH-20-15,D4                           ;D4:=YCENTER
            MOVE.B  #88,D0
            TRAP    #15                                            ;DRAW RECTANGLE
            ;------UNGLA
            MOVE.B  #80,D0                                       ;SET COLOR TASK
            MOVE.L  #BKGCLRCL,D1                                ;PEN COLOR
            TRAP    #15                                            ;SET PEN COLOR
            ADDQ.B  #1,D0                                        ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRCL,D1                                ;FILL COLOR
            TRAP    #15                                            ;SET FILL COLOR
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-10-50,D1                ;D1:=XCENTER
            MOVE.W  #SCRHEIGH-10-15-6,D2                         ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+10-50,D3                ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+40+15,D4                           ;D4:=YCENTER            
            MOVE.B  #88,D0
            TRAP    #15                                            ;DRAW RECTANGLE
            ;-----FIN UNGLA
            ;-----DIBUIXAM RECTANGLE(COLOR DIT) DEMUNT UNGLA PER TAPAR LA RESTA DE LA CIRCONFERENCIA.
            MOVE.B  #80,D0                                       ;SET COLOR TASK
            MOVE.L  #BKGCLRFT,D1                                ;PEN COLOR
            TRAP    #15                                            ;SET PEN COLOR
            ADDQ.B  #1,D0                                        ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRFT,D1                                ;FILL COLOR
            TRAP    #15                                            ;SET FILL COLOR 
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-9-50,D1                 ;D1:=XCENTER
            MOVE.W  #SCRHEIGH-10,D2                              ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+9-50,D3                 ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+40+15+20,D4                        ;D4:=YCENTER 
            MOVE.B  #87,D0
            TRAP    #15                                            ;DRAW RECTANGLE
            ;-----FIN RECTANGLE
            ;SECOND FINGER
            MOVE.B  #80,D0                                       ;SET COLOR TASK
            MOVE.L  #BKGCLRFT,D1                                ;PEN COLOR
            TRAP    #15                                            ;SET PEN COLOR
            ADDQ.B  #1,D0                                        ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRFT,D1                                ;FILL COLOR
            TRAP    #15                                            ;SET FILL COLOR 
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-15-75,D1                ;D1:=XCENTER
            MOVE.W  #SCRHEIGH-20-10,D2                           ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+15-75,D3                ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+20+15,D4                           ;D4:=YCENTER
            MOVE.B  #88,D0
            TRAP    #15                                            ;DRAW RECTANGLE
            ;------UNGLA
            MOVE.B  #80,D0                                       ;SET COLOR TASK
            MOVE.L  #BKGCLRCL,D1                                ;PEN COLOR
            TRAP    #15                                            ;SET PEN COLOR
            ADDQ.B  #1,D0                                        ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRCL,D1                                ;FILL COLOR
            TRAP    #15                                            ;SET FILL COLOR
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-10-75,D1                ;D1:=XCENTER
            MOVE.W  #SCRHEIGH-10-15-3,D2                         ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+10-75,D3                ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+40+15,D4                           ;D4:=YCENTER            
            MOVE.B  #88,D0
            TRAP    #15                                            ;DRAW RECTANGLE
            ;-----FIN UNGLA
            ;-----DIBUIXAM RECTANGLE(COLOR DIT) DEMUNT UNGLA PER TAPAR LA RESTA DE LA CIRCONFERENCIA.
            MOVE.B  #80,D0                                       ;SET COLOR TASK
            MOVE.L  #BKGCLRFT,D1                                ;PEN COLOR
            TRAP    #15                                            ;SET PEN COLOR
            ADDQ.B  #1,D0                                        ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRFT,D1                                ;FILL COLOR
            TRAP    #15                                            ;SET FILL COLOR 
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-9-75,D1                 ;D1:=XCENTER
            MOVE.W  #SCRHEIGH-10,D2                              ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+9-75,D3                 ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+40+15,D4                           ;D4:=YCENTER 
            MOVE.B  #87,D0
            TRAP    #15                                            ;DRAW RECTANGLE
            ;-----FIN RECTANGLE
            ;THIRD FINGER
            MOVE.B  #80,D0                                       ;SET COLOR TASK
            MOVE.L  #BKGCLRFT,D1                                ;PEN COLOR
            TRAP    #15                                            ;SET PEN COLOR
            ADDQ.B  #1,D0                                        ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRFT,D1                                ;FILL COLOR
            TRAP    #15                                            ;SET FILL COLOR 
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-15-100,D1               ;D1:=XCENTER
            MOVE.W  #SCRHEIGH-20-5,D2                            ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+15-100,D3               ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+20+15+20,D4                        ;D4:=YCENTER
            MOVE.B  #88,D0
            TRAP    #15                                            ;DRAW RECTANGLE
            ;------UNGLA
            MOVE.B  #80,D0                                       ;SET COLOR TASK
            MOVE.L  #BKGCLRCL,D1                                ;PEN COLOR
            TRAP    #15                                            ;SET PEN COLOR
            ADDQ.B  #1,D0                                        ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRCL,D1                                ;FILL COLOR
            TRAP    #15                                            ;SET FILL COLOR
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-10-100,D1               ;D1:=XCENTER
            MOVE.W  #SCRHEIGH-10-15+4,D2                         ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+10-100,D3               ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+40+15,D4                           ;D4:=YCENTER            
            MOVE.B  #88,D0
            TRAP    #15                                            ;DRAW RECTANGLE
            ;-----FIN UNGLA
            ;-----DIBUIXAM RECTANGLE(COLOR DIT) DEMUNT UNGLA PER TAPAR LA RESTA DE LA CIRCONFERENCIA.
            MOVE.B  #80,D0                                       ;SET COLOR TASK
            MOVE.L  #BKGCLRFT,D1                                ;PEN COLOR
            TRAP    #15                                            ;SET PEN COLOR
            ADDQ.B  #1,D0                                        ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRFT,D1                                ;FILL COLOR
            TRAP    #15                                            ;SET FILL COLOR 
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-9-100,D1                ;D1:=XCENTER
            MOVE.W  #SCRHEIGH-10+1,D2                            ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+9-100,D3                ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+40+15+20,D4                        ;D4:=YCENTER 
            MOVE.B  #87,D0
            TRAP    #15                                            ;DRAW RECTANGLE
            ;-----FIN RECTANGLE
            ;FOUR FINGER
            MOVE.B  #80,D0                                      ;SET COLOR TASK
            MOVE.L  #BKGCLRFT,D1                                ;PEN COLOR
            TRAP    #15                                            ;SET PEN COLOR
            ADDQ.B  #1,D0                                        ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRFT,D1                                ;FILL COLOR
            TRAP    #15                                            ;SET FILL COLOR 
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-15-125,D1               ;D1:=XCENTER
            MOVE.W  #SCRHEIGH-20,D2                              ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+15-125,D3               ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+20+15+20,D4                        ;D4:=YCENTER
            MOVE.B  #88,D0
            TRAP    #15                                            ;DRAW RECTANGLE
            ;------UNGLA
            MOVE.B  #80,D0                                       ;SET COLOR TASK
            MOVE.L  #BKGCLRCL,D1                                ;PEN COLOR
            TRAP    #15                                            ;SET PEN COLOR
            ADDQ.B  #1,D0                                        ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRCL,D1                                ;FILL COLOR
            TRAP    #15                                            ;SET FILL COLOR
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-10-125,D1               ;D1:=XCENTER
            MOVE.W  #SCRHEIGH-10-15+6,D2                         ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+10-125,D3               ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+40+15,D4                           ;D4:=YCENTER            
            MOVE.B  #88,D0
            TRAP    #15                                            ;DRAW RECTANGLE
            ;-----FIN UNGLA
            ;-----DIBUIXAM RECTANGLE(COLOR DIT) DEMUNT UNGLA PER TAPAR LA RESTA DE LA CIRCONFERENCIA.
            MOVE.B  #80,D0                                       ;SET COLOR TASK
            MOVE.L  #BKGCLRFT,D1                                ;PEN COLOR
            TRAP    #15                                            ;SET PEN COLOR
            ADDQ.B  #1,D0                                        ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRFT,D1                                ;FILL COLOR
            TRAP    #15                                            ;SET FILL COLOR 
            MOVE.W  #SCRWIDTH-SCRWIDTH/2-9-125,D1                ;D1:=XCENTER
            MOVE.W  #SCRHEIGH-10+1,D2                            ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+9-125,D3                ;D3:=XCENTER
            MOVE.W  #SCRHEIGH+40+15+20,D4                        ;D4:=YCENTER 
            MOVE.B  #87,D0
            TRAP    #15                                            ;DRAW RECTANGLE
            ;-----FIN RECTANGLE
            ;------ END FOOT

            ;----- END SECOND FOOT
            
            ;----PORTATIL
            MOVE.B  #80,D0                                       ;SET COLOR TASK
            MOVE.L  #$00FFFFFF,D1                                ;PEN COLOR
            TRAP    #15                                            ;SET PEN COLOR
            ADDQ.B  #1,D0                                        ;SET FILL COLOR TASK
            MOVE.L  #$00FFFFFF,D1                                ;FILL COLOR
            TRAP    #15                                            ;SET FILL COLOR 
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+300,D1                  ;D1:=XCENTER 
            MOVE.W  #SCRHEIGH-SCRHEIGH/2+40,D2                   ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-5,D3                               ;D3:=XCENTER
            MOVE.W  #SCRHEIGH-SCRHEIGH/2-40,D4                   ;D4:=YCENTER 
            MOVE.B  #87,D0
            TRAP    #15                                            ;DRAW RECTANGLE
            
            ;---APPEL
            MOVE.B  #80,D0                                       ;SET COLOR TASK
            MOVE.L  #$00000000,D1                                ;PEN COLOR
            TRAP    #15                                            ;SET PEN COLOR
            ADDQ.B  #1,D0                                        ;SET FILL COLOR TASK
            MOVE.L  #$00000000,D1                                ;FILL COLOR
            TRAP    #15                                            ;SET FILL COLOR 
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+300+80,D1               ;D1:=XCENTER  
            MOVE.W  #SCRHEIGH-SCRHEIGH/2+40-30,D2                ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-5-80,D3                            ;D3:=XCENTER 
            MOVE.W  #SCRHEIGH-SCRHEIGH/2-40+30,D4                ;D4:=YCENTER 
            MOVE.B  #88,D0
            TRAP    #15                             
            ;---MORDIDA POMA
            MOVE.B  #80,D0                                       ;SET COLOR TASK
            MOVE.L  #$00FFFFFF,D1                                ;PEN COLOR
            TRAP    #15                                            ;SET PEN COLOR
            ADDQ.B  #1,D0                                        ;SET FILL COLOR TASK
            MOVE.L  #$00FFFFFF,D1                                ;FILL COLOR
            TRAP    #15                                            ;SET FILL COLOR 
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+300+80+21,D1            ;D1:=XCENTER 
            MOVE.W  #SCRHEIGH-SCRHEIGH/2+40-30-10,D2             ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-5-80,D3                            ;D3:=XCENTER 
            MOVE.W  #SCRHEIGH-SCRHEIGH/2-40+30,D4                ;D4:=YCENTER 
            MOVE.B  #88,D0
            TRAP    #15    
            ;---FIN MORDIDA POMA       
            ;---HOJA
            MOVE.B  #80,D0                                       ;SET COLOR TASK
            MOVE.L  #$00000000,D1                                ;PEN COLOR
            TRAP    #15                                            ;SET PEN COLOR
            ADDQ.B  #1,D0                                        ;SET FILL COLOR TASK
            MOVE.L  #$00000000,D1                                ;FILL COLOR
            TRAP    #15                                            ;SET FILL COLOR 
            MOVE.W  #SCRWIDTH-SCRWIDTH/2+300+80+10-5-5+8,D1      ;D1:=XCENTER  
            MOVE.W  #SCRHEIGH-SCRHEIGH/2+40-30-40-5+7,D2         ;D2:=YCENTER
            MOVE.W  #SCRWIDTH-5-80-10+10-8,D3                    ;D3:=XCENTER 
            MOVE.W  #SCRHEIGH-SCRHEIGH/2-40+30-5-7+2+5,D4        ;D4:=YCENTER 
            MOVE.B  #88,D0
            TRAP    #15    
            ;---FIN HOJA                
            ;---END APPEL
            
            ;---TAULA
            ;---PATA TAULA
            MOVE.B  #80,D0                                       ;SET COLOR TASK
            MOVE.L  #CLRTALEG,D1                                ;PEN COLOR
            TRAP    #15                                            ;SET PEN COLOR
            ADDQ.B  #1,D0                                        ;SET FILL COLOR TASK
            MOVE.L  #CLRTALEG,D1                                ;FILL COLOR
            TRAP    #15                                            ;SET FILL COLOR 
            MOVE.W  #200-60,D1                                   ;D1:=XCENTER
            MOVE.W  #200,D2                                      ;D2:=YCENTER
            MOVE.W  #250-80,D3                                   ;D3:=XCENTER
            MOVE.W  #250,D4                                      ;D4:=YCENTER 
            MOVE.B  #87,D0
            TRAP    #15         
            ;---FIN PATA TAULA
            ;---BORDE TAULA
            MOVE.B  #80,D0                                      ;SET COLOR TASK
            MOVE.L  #BKGCLRT,D1                          ;PEN COLOR
            TRAP    #15                                           ;SET PEN COLOR
            ADDQ.B  #1,D0                                       ;SET FILL COLOR TASK
            MOVE.L  #BKGCLRT,D1                          ;FILL COLOR
            TRAP    #15                                           ;SET FILL COLOR 
            MOVE.W  #0,D1                                       ;D1:=XCENTER
            MOVE.W  #0,D2                                       ;D2:=YCENTER
            MOVE.W  #200+10,D3                                  ;D3:=XCENTER
            MOVE.W  #200+10,D4                                  ;D4:=YCENTER 
            MOVE.B  #87,D0
            TRAP    #15
            ;---FIN BORDE TAULA               
            ;---TAULA REC
            MOVE.B  #80,D0                                     ;SET COLOR TASK
            MOVE.L  #CLRTABLE,D1                             ;PEN COLOR
            TRAP    #15                                          ;SET PEN COLOR
            ADDQ.B  #1,D0                                      ;SET FILL COLOR TASK
            MOVE.L  #CLRTABLE,D1                             ;FILL COLOR
            TRAP    #15                                          ;SET FILL COLOR 
            MOVE.W  #0,D1                                      ;D1:=XCENTER
            MOVE.W  #0,D2                                      ;D2:=YCENTER
            MOVE.W  #200,D3                                    ;D3:=XCENTER
            MOVE.W  #200,D4                                    ;D4:=YCENTER 
            MOVE.B  #87,D0
            TRAP    #15     
            ;---FIN TAULA REC          
            
            ;---FIN TAULA
            ;----END PORTATIL
            
            
            MOVEM.L (A7)+,D0-D4
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
            MOVE.B  #81,D0                  ; TRAP CODE TO DEFINE PEN COLOR
            MOVE.L  #BKGCLR,D1
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
            RTS

















*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~

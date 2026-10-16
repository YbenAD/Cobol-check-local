       IDENTIFICATION DIVISION.
       PROGRAM-ID. Airesperi.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-LONGUEUR         PIC 9(2).
       01  WS-LARGEUR          PIC 9(2).
       01  WS-PERIMETRE        PIC 9(4).
       01  WS-SURFACE          PIC 9(4).

       PROCEDURE DIVISION.
       MAIN-PROGRAM.
           PERFORM INITIALISATION
           PERFORM CALCULS
           PERFORM AFFICHAGE
           STOP RUN.

       INITIALISATION.
           MOVE 10 TO WS-LONGUEUR
           MOVE 5 TO WS-LARGEUR
           .

       CALCULS.
           COMPUTE WS-PERIMETRE = 2 * (WS-LONGUEUR + WS-LARGEUR)
           COMPUTE WS-SURFACE = WS-LONGUEUR * WS-LARGEUR
           .

       AFFICHAGE.
           DISPLAY "Le perimetre est : " WS-PERIMETRE
           DISPLAY "La surface est : " WS-SURFACE
           .
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Airesperi2.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-LONGUEUR         PIC 9(2).
       01  WS-LARGEUR          PIC 9(2).
       01  WS-PERIMETRE        PIC 9(4).
       01  WS-SURFACE          PIC 9(4).

       PROCEDURE DIVISION.
       MAIN-PROGRAM.
           PERFORM TRAITEMENT
           PERFORM AFFICHAGE
           STOP RUN.

      * Saisie des dimensions puis calcul
       TRAITEMENT.
           PERFORM SAISIE
           PERFORM CALCULS
           .

      * Demande la longueur et la largeur a l'utilisateur
       SAISIE.
           DISPLAY "Longueur (0 a 99) : " WITH NO ADVANCING
           ACCEPT WS-LONGUEUR
           DISPLAY "Largeur  (0 a 99) : " WITH NO ADVANCING
           ACCEPT WS-LARGEUR
           .

       CALCULS.
           COMPUTE WS-PERIMETRE = 2 * (WS-LONGUEUR + WS-LARGEUR)
           COMPUTE WS-SURFACE = WS-LONGUEUR * WS-LARGEUR
           .

       AFFICHAGE.
           DISPLAY "Le perimetre est : " WS-PERIMETRE
           DISPLAY "La surface est : " WS-SURFACE
           .

           
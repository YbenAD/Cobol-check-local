       IDENTIFICATION DIVISION.
       PROGRAM-ID. Airescsv.
      *----------------------------------------------------------------
      * Lit figures.csv (longueur,largeur) et affiche pour chaque
      * figure ses dimensions, son perimetre et sa surface.
      * La premiere ligne du fichier (en-tete) est ignoree.
      *----------------------------------------------------------------

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FIGURES ASSIGN TO "figures.csv"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS.

       DATA DIVISION.
       FILE SECTION.
       FD  FIGURES.
       01  FIG-ENREG               PIC X(80).

       WORKING-STORAGE SECTION.
       01  WS-FS                   PIC X(2).
       01  WS-FIN-FICHIER          PIC X VALUE "N".
           88 WS-FIN                     VALUE "O".
           88 WS-PAS-FIN                 VALUE "N".

       01  WS-LIGNE                PIC X(80).
       01  WS-CHAMP-1              PIC X(10).
       01  WS-CHAMP-2              PIC X(10).

       01  WS-LONGUEUR             PIC 9(2).
       01  WS-LARGEUR              PIC 9(2).
       01  WS-PERIMETRE            PIC 9(4).
       01  WS-SURFACE              PIC 9(4).

       01  WS-NB-FIGURES           PIC 9(3) VALUE 0.
       01  WS-TOTAL-SURFACE        PIC 9(6) VALUE 0.

       PROCEDURE DIVISION.
       MAIN-PROGRAM.
           PERFORM OUVRIR-FICHIER
           PERFORM TRAITER-FICHIER
           PERFORM FERMER-FICHIER
           PERFORM AFFICHER-BILAN
           STOP RUN.

      * Ouverture du fichier et lecture de la ligne d'en-tete
       OUVRIR-FICHIER.
           OPEN INPUT FIGURES
           IF WS-FS NOT = "00"
               DISPLAY "Impossible d'ouvrir figures.csv, statut "
                       WS-FS
               STOP RUN
           END-IF
           PERFORM LIRE-LIGNE
           .

      * Boucle principale : une figure par ligne
       TRAITER-FICHIER.
           PERFORM LIRE-LIGNE
           PERFORM UNTIL WS-FIN
               PERFORM DECOUPER-LIGNE
               PERFORM CALCULS
               PERFORM AFFICHER-FIGURE
               PERFORM LIRE-LIGNE
           END-PERFORM
           .

       LIRE-LIGNE.
           READ FIGURES INTO WS-LIGNE
               AT END SET WS-FIN TO TRUE
           END-READ
           .

      * Decoupe "longueur,largeur" (separateur , ou ;)
       DECOUPER-LIGNE.
      *    Supprime le retour chariot d'un CSV cree sous Windows
           INSPECT WS-LIGNE REPLACING ALL X"0D" BY SPACE
           MOVE SPACES TO WS-CHAMP-1 WS-CHAMP-2
           UNSTRING WS-LIGNE DELIMITED BY "," OR ";"
               INTO WS-CHAMP-1 WS-CHAMP-2
           END-UNSTRING
           COMPUTE WS-LONGUEUR = FUNCTION NUMVAL(WS-CHAMP-1)
           COMPUTE WS-LARGEUR  = FUNCTION NUMVAL(WS-CHAMP-2)
           ADD 1 TO WS-NB-FIGURES
           .

       CALCULS.
           COMPUTE WS-PERIMETRE = 2 * (WS-LONGUEUR + WS-LARGEUR)
           COMPUTE WS-SURFACE = WS-LONGUEUR * WS-LARGEUR
           ADD WS-SURFACE TO WS-TOTAL-SURFACE
           .

       AFFICHER-FIGURE.
           DISPLAY "Figure " WS-NB-FIGURES
                   " : longueur " WS-LONGUEUR
                   "  largeur " WS-LARGEUR
                   "  perimetre " WS-PERIMETRE
                   "  surface " WS-SURFACE
           .

       FERMER-FICHIER.
           CLOSE FIGURES
           .

       AFFICHER-BILAN.
           DISPLAY "--------------------------------------------"
           DISPLAY "Nombre de figures : " WS-NB-FIGURES
           DISPLAY "Surface totale    : " WS-TOTAL-SURFACE
           .

           
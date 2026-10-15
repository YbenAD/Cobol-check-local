IDENTIFICATION DIVISION.
       PROGRAM-ID. SQUENT.

ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
            SELECT FICH-SEQ ASSIGN TO "fichier-sequentiel.txt"
            ORGANIZATION IS LINE SEQUENTIAL
            ACCESS MODE IS SEQUENTIAL
            FILE STATUS IS WS-FICHIER-STATUS.

DATA DIVISION.
       FILE SECTION.
       FD FICH-SEQ.
       01 FICHIER-SEQ-REC PIC X(80).
                    
       WORKING-STORAGE SECTION.
        01 WS-DATE.
            05 WS-ANNEE PIC 9(4).
            05 WS-MOIS PIC 9(2).
            05 WS-JOUR PIC 9(2).
        01 WS-FICHIER-STATUS PIC 9(2).
        01 WS-ENTREE PIC X(80) VALUE "OUI".
       
     
PROCEDURE DIVISION.
       MOVE FUNCTION CURRENT-DATE (1:8) TO WS-DATE.
       DISPLAY "AUJOURD HUI NOUS SOMMES LE  " WS-JOUR "/" WS-MOIS "/" WS-ANNEE.
       PERFORM MAIN-PROGRAM.
       PERFORM READ-RECORDS.
       STOP RUN.

    MAIN-PROGRAM.
        DISPLAY "---------*--------*--------*--------*--------*--------*--------*--------*"
        DISPLAY "OUVERTURE DANS LE FICHIER SEQUENTIEL".
        OPEN EXTEND FICH-SEQ.
            PERFORM UNTIL WS-ENTREE = "FIN"
                DISPLAY "ENTREZ UNE CHAINE DE CARACTERES (FIN POUR ARRETER) : "
                ACCEPT WS-ENTREE
                IF WS-ENTREE NOT = "FIN"
                    MOVE WS-ENTREE TO FICHIER-SEQ-REC
                    WRITE FICHIER-SEQ-REC
                END-IF 
            END-PERFORM
            DISPLAY "FERMETURE DU FICHIER SEQUENTIEL"
        CLOSE FICH-SEQ.

    READ-RECORDS.
        DISPLAY "---------*--------*--------*--------*--------*--------*--------*--------*"
        DISPLAY "LECTURE DANS LE FICHIER SEQUENTIEL".
        OPEN INPUT FICH-SEQ.
        PERFORM UNTIL FICHIER-SEQ-REC = HIGH-VALUES
            READ FICH-SEQ
                AT END
                    MOVE HIGH-VALUES TO FICHIER-SEQ-REC
                    DISPLAY "FIN DE LA LECTURE DANS LE FICHIER SEQUENTIEL"
                NOT AT END
                    DISPLAY "LIGNE: " FICHIER-SEQ-REC
            END-READ
        END-PERFORM.
        CLOSE FICH-SEQ.
       
       
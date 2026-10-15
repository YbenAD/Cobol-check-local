IDENTIFICATION DIVISION.
       PROGRAM-ID. Salve.
DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-PRENOM PIC X(20) value "alex".
       01 Ws-AGE PIC 9(3) value 28.
       01 Ws-fonction pic X(20) value "sans emploi".
PROCEDURE DIVISION.
       display "quel est ta fonction ? ".
       accept Ws-fonction.
       move "Romi bene" to WS-PRENOM.
       move 40 to Ws-AGE.
       DISPLAY "Bonjour, je m appelle " WS-PRENOM " et j ai " Ws-AGE " et je suis un "Ws-fonction.
       STOP RUN.


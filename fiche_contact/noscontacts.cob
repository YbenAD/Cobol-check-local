       IDENTIFICATION DIVISION.
       PROGRAM-ID. Con_tacts.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           CRT STATUS IS KEY-STATUS.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PHONEBOOK ASSIGN TO "PHONEBOOK.dat"
               ORGANIZATION IS SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  PHONEBOOK
           RECORDING MODE IS F.
       01  PH-REC.
           05 PH-ID            PIC 9(5) COMP-3.
           05 PH-NAME          PIC X(20).
           05 PH-SURNAME       PIC X(20).
           05 PH-PHONE         PIC 9(15).
           05 PH-EMAIL         PIC X(50).
           05 PH-COMPANY       PIC X(50).
           05 PH-ADDRESS       PIC X(50).

       WORKING-STORAGE SECTION.
       77  KEY-STATUS          PIC 9(4) VALUE ZERO.
           88 ENTER-PUSHED              VALUE 13.
           88 EXIT-PUSHED               VALUE 27.
           88 MESSAGE-RECEIVED          VALUE 95.
           88 EVENT-OCCURRED            VALUE 96.
           88 SCREEN-NO-INPUT-FIELD     VALUE 97.

      * Variables du programme
       77  WS-OPTION           PIC X(1)     VALUE SPACE.
       77  WS-MSG              PIC X(80)    VALUE SPACES.
       77  WS-NOM              PIC X(20)    VALUE SPACES.
       77  WS-AGE              PIC 9(3)     VALUE ZERO.
       77  WS-MEMBRE-VIP       PIC X(3).
       77  WS-COTISATION       PIC 9(5)V99  VALUE 100.00.
       77  WS-SOLDE            PIC 9(5)V99  VALUE 0.00.

       PROCEDURE DIVISION.
           DISPLAY "quel est ton nom ? "
           ACCEPT WS-NOM
           DISPLAY "quel est ton age ? "
           ACCEPT WS-AGE
           DISPLAY "est tu membre vip (oui/non) ? "
           ACCEPT WS-MEMBRE-VIP

           IF WS-MEMBRE-VIP = "oui"
               COMPUTE WS-COTISATION = WS-COTISATION * 0.8
           ELSE
               COMPUTE WS-COTISATION = WS-COTISATION * 1.1
           END-IF

           MOVE 1000 TO WS-SOLDE

           DISPLAY "Bonjour " WS-NOM
                   " vous etes age de " WS-AGE " ans,"
           DISPLAY "votre solde est " WS-SOLDE " $"
           DISPLAY "membre vip : " WS-MEMBRE-VIP
                   ", votre cotisation est de " WS-COTISATION
           STOP RUN.
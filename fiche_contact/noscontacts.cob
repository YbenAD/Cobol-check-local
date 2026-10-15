IDENTIFICATION DIVISION.
       PROGRAM-ID. Con_tacts.
DATA DIVISION.
    FILE SECTION.
        FD PHONEBOOK.
            RECORDING MODE IS F.
            BLOCK CONTAINS 80 CHARACTERS.
            LABEL RECORDS ARE STANDARD.
            DATA RECORD IS PH-REC.
    
         01 PH-REC.
            05 PH-ID        PIC 9(5) COMP-3 VALUE ZERO.
            05 PH-NAME      PIC X(20).
            05 PH-SURNAME   PIC X(20).
            05 PH-PHONE     PIC 9(15).
            05 PH-EMAIL     PIC X(50).
            05 PH-COMPANY   PIC X(50).
            05 PH-ADDRESS   PIC X(50).
    
    WORKING-STORAGE SECTION.
    77 KEY-STATUS IS SPECIAL-NAMES CRT STATUS PIC 9(5) VALUE ZERO.
        88 ENTER-PUSHED VALUE 13.
        88 EXIT-PUSHED VALUE 27.
        88 MESSAGE-RECEIVED VALUE 95.
        88 EVENT-OCCURRED VALUE 96.
        88 SCREEN-NO-INPUT-FIELD VALUE 97.

* PRPERTIES & USER DEFINED WORKING-STORAGE VARIABLES
       77 WS-OPTION PIC X(1) VALUE SPACE.
       77 WS-MSG PIC X(80) VALUE SPACES.
       77 WS-MEMBRE-VIP PIC X(3).
       77 WS-COTISATION PIC 9(5)V99 VALUE 100.00.
       77 WS-SOLDE PIC 9(5)V99 VALUE 0.00.
     
PROCEDURE DIVISION.
       display "quel est ton nom ? ".
       accept WS-NOM.
       display "quel est ton age ? ".
       accept Ws-AGE.
       display "est tu membre vip (oui/non) ? ".
       accept ws-membre-vip.
       if ws-membre-vip = "oui"
          compute ws-cotisation = ws-cotisation * 0.8
       else
          compute ws-cotisation = ws-cotisation * 1.1
       end-if.
       move 1000 to ws-solde.
       DISPLAY "Bonjour " WS-NOM " vous etes age de " Ws-AGE " ans, et votre solde est " ws-solde " $ et vous etes un membre-vip: " ws-membre-vip " , votre cotisation est de " ws-cotisation.
       STOP RUN.


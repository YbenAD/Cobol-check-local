IDENTIFICATION DIVISION.
       PROGRAM-ID. Fiche.
DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-NOM PIC X(25) value "inconnu".
       01 Ws-AGE PIC 9(3) value 18.
       01 ws-cotisation pic 9(3)V99 value 49.99.
       01 ws-solde pic S9(5)V99 value 0.
       01 ws-membre-vip pic X(3) value "non".
     
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


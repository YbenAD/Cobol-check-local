identification division.
       program-id. table.
data division.
       working-storage section.
       01 ws-chiffre pic 9(2).
       01 ws-i pic 9(2).
       01 ws-resultat pic 9(3).
procedure division.
       display "numero: ".
       accept ws-chiffre.
       perform varying ws-i from 1 by 1 until ws-i > 10
           compute ws-resultat = ws-chiffre * ws-i
           display ws-chiffre " * " ws-i " = " ws-resultat
       end-perform.

stop run.



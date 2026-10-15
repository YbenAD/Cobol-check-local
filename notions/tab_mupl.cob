identification division.
       program-id. table2.
data division.
       working-storage section.
       01 ws-chiffre pic 9(2).
       01 ws-i pic 9(2).
       01 ws-tableau.
           05 ws-element pic 9(3) occurs 10 times.
procedure division.
       display "numero: ".
       accept ws-chiffre.
       perform varying ws-i from 1 by 1 until ws-i > 10
           compute ws-element(ws-i) = ws-chiffre * ws-i
           display ws-chiffre " * " ws-i " = " ws-element(ws-i)
       end-perform.

stop run.



identification division.
       program-id. boucles.
data division.
       working-storage section.
       01 ws-compteur pic 9(2) value 0.
       01 ws-i pic 9(2).
procedure division.
       perform 5 times
           display "merci"
       end-perform.

       perform until ws-compteur > 4
           display ws-compteur
           add 1 to ws-compteur
       end-perform.

       perform varying ws-i from 1 by 1 until ws-i > 4
           display ws-i
       end-perform.
stop run.


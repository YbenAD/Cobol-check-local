identification division.
       program-id. moyen.
data division.
       working-storage section.
       01 ws-tableau.
           05 ws-element pic 9(3) occurs 5 times.
       01 ws-i pic 9(2).
       01 ws-reslt pic 9(2)V99 value 0.
       01 ws-moyen pic 9(2)V99.
procedure division.
       perform varying ws-i from 1 by 1 until ws-i > 5
           display "quel est la note n° " ws-i
           accept ws-element(ws-i)
           compute ws-reslt = ws-reslt + ws-element(ws-i)
       end-perform.
       compute ws-moyen = ws-reslt / 5. 
       display "ta moyenne est de : " ws-moyen.

stop run.


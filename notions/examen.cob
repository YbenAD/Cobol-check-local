Identification division.
       Program-id. Bulletin.
Data Division.
       Working-storage section.
       01 ws-note pic 9(3).
Procedure division.
       Display "quel est votre note ? ".
       Accept ws-note .
       If ws-note > 100
           display "note invalide"
           stop run
       End-if.
       Evaluate true
           When ws-note >= 90 and ws-note <= 100
           Display "excellent"
           When ws-note >= 75 and ws-note < 90
           Display "très bien"
           When ws-note >= 60 and ws-note < 75
           Display "bien"
           When ws-note >= 50 and ws-note < 60
           Display "passable"
           When  ws-note < 50
           Display "échec"
       End-Evaluate.
   stop run.


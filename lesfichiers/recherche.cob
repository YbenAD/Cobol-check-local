identification division.
       program-id. mysearch.
data division.
       working-storage section.
       01 ws-tableau.
           05 ws-element pic X(10) occurs 5 times indexed by idx.
       01 ws-i pic 9(2).
       01 ws-nom pic X(10) value "alex".
procedure division.
       perform varying ws-i from 1 by 1 until ws-i > 5
           display "entrez un prenom " ws-i
           accept ws-element(ws-i)
       end-perform.
       set idx to 1
           search ws-element
               at end
                   display "element non trouve"
               when ws-element(idx) = ws-nom
                   display "element trouve " idx
           end-search.

stop run.




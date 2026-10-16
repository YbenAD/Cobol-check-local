       identification division.
       program-id. Eva_luate.

       environment division.

       data division.
       working-storage section.
       01 ws-valeur          pic 9(2).
       01 ws-bool            pic x(4).
           88 ws-true        value "cont".
           88 ws-false       value "stop".
       01 ws-cpt             pic 9(2) value 0.
       01 ws-message         pic x(30).

       procedure division.
       S1 section.
           perform alimentation
           perform traitement-principal
           perform traitement until ws-false
           perform fin
           stop run.

       alimentation.
           move 1 to ws-valeur
           set ws-true to true
           .

       traitement-principal.
           evaluate ws-valeur
               when 1
                   move "valeur = 1" to ws-message
               when 2
                   move "valeur = 2" to ws-message
               when 3
                   move "valeur = 3" to ws-message
               when 4
                   move "valeur = 4" to ws-message
               when 5
                   move "valeur = 5" to ws-message
               when other
                   move "valeur autre que 1,2,3,4,5" to ws-message
           end-evaluate
           display ws-message
           .

       traitement.
           display "compteur = " ws-cpt
           add 1 to ws-cpt
           if ws-cpt = 5
               set ws-false to true
           end-if
           .

       fin.
           display "fin du programme"
           .
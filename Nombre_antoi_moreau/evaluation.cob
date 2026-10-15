identification division.
    program-id. Eva_luate.

environment division.

Data division.
    working-storage section.
        01 ws-valeur pic 9(2).
        01 ws-bool pic x(4).
            88 ws-true value "cont".
            88 ws-false value "stop".
        01 ws-cpt pic 9(2) value 0.
    

procedure division.
    S1 section.
        perform alimentation
        perform traitement-principal
        perform traitement until ws-false
        perform fin.

stop run.

alimentation.
    move 5 to ws-valeur
    set ws-true to true
.

traitement-principal.
    evaluate ws-valeur
        when 1
            display "valeur = 1"
        when 2
            display "valeur = 2"
        when 3
            display "valeur = 3"
        when 4
            display "valeur = 4"
        when 5
            display "valeur = 5"
        when other
            display "valeur autre que 1,2,3,4,5"
    end-evaluate
.

traitement.
    display "compteur = " ws-cpt
    add 1 to ws-cpt
    if ws-cpt = 5 
        set ws-false to true
    end-if.

fin.

display "fin du programme".




identification division.
    program-id. Con_ditio.

environment division.

Data division.
    working-storage section.
        01 ws-solde pic 9(15).
    

procedure division.
    S1 section.
        perform alimentation.
        perform traitement-principal.
        perform fin.

stop run.

alimentation.
    display "initialisation programme"  
    display "quel est votre solde ?  "
    accept ws-solde 
.

traitement-principal.
    display "debut du traitement"
    if ws-solde > 500 and ws-solde < 2000 then
        display "je dois economiser"
    else 
        if ws-solde > 3000 then
        display "je peux depenser"
        else
        display "vivement le salaire"
        end-if
    end-if
.

fin.

display "fin du programme".




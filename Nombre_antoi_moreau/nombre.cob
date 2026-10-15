identification division.
    program-id. Nom_bre.

environment division.

Data division.
    working-storage section.
        01 valeur1 pic X(5).
    

procedure division.
    S1 section.
        perform initialisation.
        perform traitement-principal.
        perform fin.

stop run.

initialisation.
    move low-values to valeur1.
    display "initialisation:  " valeur1
.

traitement-principal.
    move "tata" to valeur1.
    display "resultat1:  " valeur1
    move low-values to valeur1

    move "abcdef" to valeur1.
    display "resultat2:  " valeur1
    move low-values to valeur1

    move "a12345a" to valeur1.
    display "resultat3:  " valeur1
    move low-values to valeur1

    move "230039922" to valeur1.
    display "resultat:  " valeur1
    move low-values to valeur1
.

fin.

display "fin du programme".


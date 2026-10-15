Identification division.
       Program-id. Fiche2.
Data Division.
       Working-storage section.
       01 ws-nom pic X(10).
       01 ws-fonction pic X(10) value "chômeur".
       01 ws-salaire pic 9(4).
       01 ws-age pic 9(3).
Procedure division.
       Move 450 to ws-salaire.
       Display  "quel est votre nom: ".
       Accept  ws-nom.
       Display "quel est votre âge: ".
       Accept  ws-age.
       Evaluate true
           When ws-age < 18
           Display "je me nomme " ws-nom " et je suis mineur "
           When ws-age >= 18 and ws-age <= 65
           Display "je me nomme " ws-nom " et je suis adulte"
           When ws-age > 65
           Display "je me nomme " ws-nom " et je suis senior "
       End-Evaluate.




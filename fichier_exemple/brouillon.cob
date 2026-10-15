       identification division.
           program-id. brouillon.
       environment division.
           input-output section.
           file-control.
               select feuille-liste assign to "brouillon.txt"
               organization is line sequential.
               
       data division.
           file section.
               fd feuille-liste.
               01 feuille-line.
                   05 fl-noms pic X(10).
                   05 fl-math pic 9(3)V99.
                   05 fl-angl pic 9(3)V99.
                   05 fl-solde pic S9(6)V99.
           working-storage section.
               
               01 ws-nom pic X(10).
               01 ws-math pic 9(3)V99.
               01 ws-angl pic 9(3)V99.
               01 ws-solde pic S9(6)V99.
               01 ws-i pic 9(2).

               01 ws-math-joli  pic ZZ9.99.
               01 ws-angl-joli  pic ZZ9.99.
               01 ws-solde-joli pic +$ZZZ,ZZ9.99.
       procedure division.
           open output feuille-liste.
               move "alex" to fl-noms
               move 18 to fl-math
               move 16.5 to fl-angl
               move 105000.20 to fl-solde
               write feuille-line
           close feuille-liste.

           open extend feuille-liste.
               perform  varying  ws-i from 1 by 1 until ws-i > 1
                   display "quel est ton nom:"
                   accept ws-nom
                   move ws-nom to fl-noms
                   display "quel est ta note de math:"
                   accept ws-math
                   move ws-math to fl-math
                   display "quel est ta note d anglais:"
                   accept ws-angl
                   move ws-angl to fl-angl
                   display "quel est ton solde:"
                   accept ws-solde
                   move ws-solde to fl-solde
                   write feuille-line
               end-perform
           close feuille-liste.
       
       display "--- Contenu du fichier (affichage formate) ---".
       open input feuille-liste.
           perform until ws-i = 99
               read feuille-liste
                   at end
                       move 99 to ws-i
                   not at end
                       move fl-math to ws-math-joli
                       move fl-angl to ws-angl-joli
                       move fl-solde to ws-solde-joli
                       display fl-noms
                           " | Math: " ws-math-joli
                           " | Anglais: " ws-angl-joli
                           " | Solde: " ws-solde-joli
               end-read
           end-perform
       close feuille-liste.

       stop run.


       





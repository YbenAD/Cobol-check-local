       identification division.
           program-id. resultats.
       environment division.
           input-output section.
               file-control.
               select fichier-clients assign to "clients_Bar.txt"
               organization is line sequential.
       data division.
           file section.
           fd fichier-clients.
           01 fichier-line.
               05 fc-nom pic X(15).
               05 fc-age pic 9(3).
           working-storage section.
               01 ws-compteur pic 9(3) value 0.
               01 ws-somme-age pic 9(5) value 0.
               01 ws-moyenne-age pic 9(3)V99.
               01 ws-plus-de-30 pic 9(3) value 0.
               01 ws-fin-fichier pic X(2).
               01 ws-i pic 9(2).
               
       procedure division.
           open input fichier-clients
               perform until ws-fin-fichier = "0"
                   read fichier-clients
                   at end 
                       move "0" to ws-fin-fichier
                   not at end 
                       add 1 to ws-compteur
                       compute ws-somme-age = ws-somme-age + fc-age
                       if fc-age > 30
                           compute ws-plus-de-30 = ws-plus-de-30 + 1
                       end-if
                   end-read
                end-perform.
           close fichier-clients.

           display " le nombre total de clients : " ws-compteur.
           compute ws-moyenne-age = ws-somme-age / ws-compteur.
           display "la moyenne d age des clients : " ws-moyenne-age.
           display " le nombre de clients de plus de 30 ans : " ws-plus-de-30.

      stop run.



                       
                   
                   
               
              
       

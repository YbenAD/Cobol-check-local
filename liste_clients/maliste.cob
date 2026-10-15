identification division.
       program-id. listes.
environment division.
       input-output section.
       file-control.
           select fichier-clients assign to "clients_Bar.txt"
               organization is line sequential.
data division.
       file section.
           fd fichier-clients.
           01 ligne-client.
               05 fc-nom pic X(15).
               05 fc-age pic 9(3).
       working-storage section.
           01 ws-nom pic X(15) value "alex".
           01 ws-age pic 9(3) value 42.
           01 ws-fin-fichier pic X(2).
           01 ws-i pic 9(2).
procedure division.

       open extend fichier-clients.
           perform varying ws-i from 1 by 1 until ws-i > 5
               display "quel est votre nom: "
               accept ws-nom
               move ws-nom to fc-nom
               display "quel est votre age: "
               accept ws-age
               move ws-age to fc-age
               write ligne-client
           end-perform.
       close fichier-clients.

       open input fichier-clients.
           perform until ws-fin-fichier = "O"
               read fichier-clients
               at end
                   move "O" to ws-fin-fichier
               not at end
                   display fc-nom " a " fc-age " ans."
               end-read
           end-perform.
       close fichier-clients.

stop run.


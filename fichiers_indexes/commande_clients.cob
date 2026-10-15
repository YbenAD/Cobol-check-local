       identification division.
           program-id. commande_clt.

       environment division.
           input-output section.
               file-control.
                   select bon_d_commande assign to "bon_commande_idx.dat"
                   organization is indexed
                   access mode is dynamic
                   record key is fd-id.
       
       data division.
           file section.
               fd bon_d_commande.
               01 ligne-commande.
                   05 fd-id pic 9(4).
                   05 fd-nom pic X(8).
                   05 fd-pdt pic X(8).
                   05 fd-cmd pic 9(10).
           working-storage section.
               01 ws-id pic 9(4) value 011.
               01 ws-nom pic X(8) value "alex".
               01 ws-pdt pic X(8) value "portable".
               01 ws-cmd pic 9(10) value 1000.  
               01 ws-i pic 9(3) value 1.
               01 ws-id-joli pic ZZ9.
               01 ws-cmd-joli pic ZZZZZZZZ9.
       
       procedure division.
           open output bon_d_commande.
               move ws-id to fd-id
               move ws-nom to fd-nom
               move ws-pdt to fd-pdt
               move ws-cmd to fd-cmd
               write ligne-commande
           close bon_d_commande.

           open i-o bon_d_commande.
               perform varying ws-i from 1 by 1 until ws-i > 3
                   compute ws-id = ws-id + 3
                   move ws-id to fd-id
                   display " quel est le nom ?"
                   accept ws-nom
                   move ws-nom to fd-nom
                   display " quel est le produit ?"
                   accept ws-pdt
                   move ws-pdt to fd-pdt
                   display " quel est le montant ?"
                   accept ws-cmd
                   move ws-cmd to fd-cmd
                   write ligne-commande
               end-perform
           close bon_d_commande.

           open input bon_d_commande.
               perform until ws-i = 99
                   read bon_d_commande
                       at end
                           move 99 to ws-i 
                       not at end
                           move fd-id to ws-id-joli
                           move fd-cmd to ws-cmd-joli
                           display ws-id-joli " | noms: " fd-nom 
                                         " | produits: " fd-pdt
                                         " | commandes: " ws-cmd-joli
                   end-read
                end-perform
           close bon_d_commande.       
                   
       stop run.






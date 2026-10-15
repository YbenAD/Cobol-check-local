       identification division.
           program-id. recherche_clt.

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
               01 ws-search pic 9(4).
               01 ws-i pic 9(3).
               01 ws-rslt pic 9(2) value 0.

       procedure division.
           display "entre un identifiant: "
           accept ws-search

           open input bon_d_commande.
               perform until ws-i = 99
                   read bon_d_commande
                       at end 
                           move 99 to ws-i
                       not at end 
                           if ws-search = fd-id
                               move 1 to ws-rslt
                           end-if
                    end-read
               end-perform        
           close bon_d_commande.

           if ws-rslt = 1
               display "trouvé"
           else
               display "non trouvé"
           end-if.
       
       stop run.



        
identification division.
       program-id. recherche_rapide.

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
           05 fd-id  pic 9(4).
           05 fd-nom pic X(8).
           05 fd-pdt pic X(8).
           05 fd-cmd pic 9(10).

       working-storage section.
       01 ws-search pic 9(4).

       procedure division.
           display "entre un identifiant: ".
           accept ws-search.

           open input bon_d_commande.

           move ws-search to fd-id
           read bon_d_commande
               key is fd-id
               invalid key
                   display "non trouve"
               not invalid key
                   display "trouve : " fd-nom " - " fd-pdt
               end-read

           close bon_d_commande.
           stop run.


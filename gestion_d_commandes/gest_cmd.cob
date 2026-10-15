       identification division.
           program-id. gestcomd.

       environment division.
           input-output section.
               file-control.
                   select fichier-commande assign to "commandes.dat"
                   organization is indexed
                   access mode is dynamic
                   record key is fd-id
                   file status is ws-fich-exit.

       data division.
           file section.
               fd fichier-commande.
               01 liggne-commande.
                   05 fd-id  PIC 9(4).
                   05 fd-client PIC X(15).
                   05 fd-produit PIC X(15).
                   05 fd-quantite PIC 9(3).
                   05 fd-prix-unit PIC 9(5)V99.
           working-storage section.
               01 ws-id PIC 9(4).
               01 ws-id-text pic X(4).
               01 ws-client PIC X(15).
               01 ws-produit PIC X(15).
               01 ws-produit-text pic X(15).
               01 ws-quantite PIC 9(3).
               01 ws-quantite-text pic X(3).
               01 ws-prix-unit PIC 9(5)V99.
               01 ws-prix-unit-text pic X(7).
               01 ws-choix pic 9(1).
               01 ws-continuer pic X(3) value "oui".
               01 ws-cherch-id pic 9(4).
               01 ws-fich-exit pic X(2).
               01 ws-nbretotal pic 9(10) value 0.
               01 ws-montfacture pic 9(15) value 0.
               01 ws-total pic 9(15).
               01 ws-i pic 9(10) value 1.
               01 ws-nbretotal-joli pic ZZZ9.
               01 ws-montfacture-joli pic ZZZZZ,ZZ9.99.
               01 ws-validate pic X(3) value "non".

       procedure division.
           open i-o fichier-commande
               if ws-fich-exit = "35"
                   open output fichier-commande
                   close fichier-commande
                   open i-o fichier-commande
               end-if
           close fichier-commande
               
           perform until ws-continuer = "non"
               display "bienvenue dans le gstionnaire de commades:"
               display "   1. Ajouter une commande"
               display "   2. Rechercher une commande "
               display "   3. Afficher toutes les commandes + statistiques" 
               display "   4. quitter"
               display "choississez entre 1 et 4 : "
               accept ws-choix
               evaluate ws-choix
                    when 1
                       perform until ws-validate = "oui"
                           display "quel est identifiant:"
                           accept ws-id-text
                           if ws-id-text is numeric
                               move ws-id-text to ws-id
                               move "oui" to ws-validate
                           else
                               display "id non valide"
                           end-if
                       end-perform
                       move "non" to ws-validate
                       display "quel est le client:"
                       accept ws-client
                       perform until ws-validate = "oui"
                           display "quel est le produit:"
                           accept ws-produit-text
                           if ws-produit-text is alphabetic
                               move ws-produit-text to ws-produit
                               move "oui" to ws-validate
                           else
                               display "produit non valive"
                           end-if
                       end-perform
                       move "non" to ws-validate
                       perform until ws-validate = "oui"
                           display "quel est la quantite:"
                           accept ws-quantite-text
                           if ws-quantite-text is numeric
                               move ws-quantite-text to ws-quantite
                               move "oui" to ws-validate
                           else
                               display "quantite non valide"
                           end-if
                       end-perform
                       move "non" to ws-validate
                       perform until ws-validate = "oui"
                           display "quel est le prix unitaire:"
                           accept ws-prix-unit-text
                           if ws-prix-unit-text is numeric
                               move ws-prix-unit-text to ws-prix-unit
                               move "oui" to ws-validate
                           else
                               display "prix non valide"
                           end-if
                       end-perform
                       move "non" to ws-validate
                       open i-o fichier-commande
                           move ws-id to fd-id
                           move ws-client to fd-client
                           move ws-produit to fd-produit
                           move ws-quantite to fd-quantite
                           move ws-prix-unit to fd-prix-unit
                           write liggne-commande
                               invalid key 
                                   display "id existant" 
                               not invalid key 
                                   display "commande ajoutee"
                           end-write
                       close fichier-commande
                    when 2
                       display "insert l id a rechercher:"
                       accept ws-cherch-id
                       open input fichier-commande
                           move ws-cherch-id to fd-id
                           read fichier-commande
                               key is fd-id
                                   invalid key 
                                       display "identifiant non trouvé"
                                   not invalid key 
                                       display fd-id " - nom: " fd-client
                            end-read
                       close fichier-commande
                    when 3
                       move 0 to ws-nbretotal
                       move 0 to ws-montfacture
                       move 1 to ws-i
                       open input fichier-commande
                           perform until ws-i = 100
                               read fichier-commande
                                   at end
                                       move 100 to ws-i 
                                   not at end
                                       add 1 to ws-nbretotal
                                       compute ws-total = fd-quantite * fd-prix-unit
                                       compute ws-montfacture = ws-montfacture + ws-total
                                end-read
                           end-perform
                       close fichier-commande
                       move ws-nbretotal to ws-nbretotal-joli   
                       move ws-montfacture to ws-montfacture-joli
                       display "nbre toal de clients: " ws-nbretotal-joli
                       display "montant de la facture total: " ws-montfacture-joli
                       display "fini les stats"
                    when 4
                       move "non" to ws-continuer
                    when other
                       display "choix invalide"
               end-evaluate
           end-perform.

           stop run.




       
           

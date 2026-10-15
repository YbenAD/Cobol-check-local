identification division.
    program-id. bou_cle.

environment division.

Data division.
    working-storage section.
        01 ws-tot pic 9(3) value zero.
        01 ws-c pic 9(1) value 1.
        01 ws-i pic 9(1) value 1.

procedure division.
    S1 section.
        perform 2 times
            compute ws-tot = ws-tot + ws-c
            display "compteur = " ws-c " total = " ws-tot
        end-perform.

        perform until ws-tot > 3
            compute ws-tot = ws-tot + ws-c
            display " total = " ws-tot
        end-perform.

        perform varying ws-i from 1 by 2 until ws-tot > 10
            compute ws-tot = ws-tot + ws-c
            display " total = " ws-tot
        end-perform.

stop run.



display "fin du programme".




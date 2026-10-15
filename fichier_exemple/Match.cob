IDENTIFICATION DIVISION.
    PROGRAM-ID. match.

ENVIRONMENT DIVISION.
    INPUT-OUTPUT SECTION.
    FILE-CONTROL.
        SELECT IFILE01 ASSIGN TO "CHANNELS.txt"
        ORGANIZATION IS LINE SEQUENTIAL
        FILE STATUS IS ST-I01.

        SELECT IFILE02 ASSIGN TO "SUBS.txt"
        ORGANIZATION IS LINE SEQUENTIAL
        FILE STATUS IS ST-I02.

        SELECT IFILE03 ASSIGN TO "FINAL.txt"
        ORGANIZATION IS LINE SEQUENTIAL
        FILE STATUS IS ST-I03.

DATA DIVISION.
    FILE SECTION.
        FD IFILE01.
        01 REC-I01.
            05 K-I01  PIC X(5).
            05 FILLER PIC X(95).
        FD IFILE02.
        01 REC-I02.
            05 K-I02  PIC X(5).
            05 FILLER PIC X(95).
        FD IFILE03.
        01 REC-I03 PIC X(100).

    WORKING-STORAGE SECTION.
        77 ST-I01 PIC XX.
        77 ST-I02 PIC XX.
        77 ST-I03 PIC XX.

        01 WS-EOF1 PIC X VALUE "N".
            88 EOF1 VALUE "Y".
            88 NOT-EOF1 VALUE "N".
        01 WS-EOF2 PIC X VALUE "N".
            88 EOF2 VALUE "Y".
            88 NOT-EOF2 VALUE "N".
        
       
     
PROCEDURE DIVISION.
    MAIN SECTION.
        DISPLAY "....APRO GLI ARCHIVI....".
        OPEN INPUT IFILE01, IFILE02
        OPEN OUTPUT IFILE03

        if ST-I01 NOT = "00"
            DISPLAY "ERRORE APERTURA IFILE01: " ST-I01
            STOP RUN
        END-IF
        if ST-I02 NOT = "00"
            DISPLAY "ERRORE APERTURA IFILE02: " ST-I02
            STOP RUN
        END-IF
        if ST-I03 NOT = "00"
            DISPLAY "ERRORE APERTURA IFILE03: " ST-I03
            STOP RUN
        END-IF

        PERFORM LEGGI-IFILE01
        PERFORM LEGGI-IFILE02

        PERFORM UNTIL EOF1 OR EOF2
            EVALUATE TRUE
            WHEN K-I01 < K-I02
                PERFORM LEGGI-IFILE01
            WHEN K-I01 = K-I02
                PERFORM CORRISPONDENZA
                PERFORM LEGGI-IFILE01
                PERFORM LEGGI-IFILE02
            WHEN K-I01 > K-I02
                PERFORM LEGGI-IFILE02
            END-EVALUATE
            
        END-PERFORM
        CLOSE IFILE01, IFILE02, IFILE03.
                STOP RUN.

    LEGGI-IFILE01.
        READ IFILE01
            AT END
                SET EOF1 TO TRUE
            NOT AT END
                DISPLAY "LETTURA IFILE01: " K-I01
        END-READ.

    LEGGI-IFILE02.
        READ IFILE02
            AT END
                SET EOF2 TO TRUE
            NOT AT END
                DISPLAY "LETTURA IFILE02: " K-I02
        END-READ.

    CORRISPONDENZA.
        DISPLAY "CORRISPONDENZA TROVATA : " REC-I01.
        MOVE REC-I01 TO REC-I03.
        WRITE REC-I03.

        if ST-I03 NOT = "00"
            DISPLAY "ERRORE APERTURA IFILE03: " ST-I03
            STOP RUN
        END-IF.
        
        


           
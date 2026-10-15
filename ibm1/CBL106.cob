       IDENTIFICATION DIVISION.
        PROGRAM-ID. CBL0106.
        AUTHOR.  YBEN ALEX.

       ENVIRONMENT DIVISION.
        INPUT-OUTPUT SECTION.
         FILE-CONTROL.
           SELECT PRINT-LINE ASSIGN TO PRTLINE
                    FILE STATUS IS WS-PRTLINE-STATUS.
           SELECT ACCT-REC ASSIGN TO ACCTREC
                    FILE STATUS IS WS-ACCTREC-STATUS.

       DATA DIVISION.
        FILE SECTION.
         FD PRINT-LINE.
          01 PRINT-REC.
           05  ACCT-NO-O      PIC X(8).
           05  FILLER         PIC X(02) VALUE SPACES.
           05  LAST-NAME-O    PIC X(20).
           05  FILLER         PIC X(02) VALUE SPACES.
           05  ACCT-LIMIT-O   PIC $$,$$$,$$9.99.
           05  FILLER         PIC X(02) VALUE SPACES.
           05  ACCT-BALANCE-O PIC $$,$$$,$$9.99.
           05  FILLER         PIC X(47) VALUE SPACES.

         FD ACCT-REC.
          01 ACCT-FIELDS.
           05  ACCT-NO            PIC X(8).
           05  ACCT-LIMIT         PIC S9(7)V99 COMP-3.
           05  ACCT-BALANCE       PIC S9(7)V99 COMP-3.
           05  LAST-NAME          PIC X(20).
           05  FIRST-NAME         PIC X(15).
           05  CLIENT-ADDR.
               10  STREET-ADDR    PIC X(25).
               10  CITY-COUNTY    PIC X(20).
               10  USA-STATE      PIC X(15).
           05  RESERVED           PIC X(7).
           05  COMMENTS           PIC X(50).

        WORKING-STORAGE SECTION.
          01 WS-FILE-STATUS.
           05 WS-PRTLINE-STATUS   PIC XX VALUE '00'.
           05 WS-ACCTREC-STATUS   PIC XX VALUE '00'.

          01 FILLER.
           05 LASTREC             PIC X   VALUE 'N'.
           05 CLIENTS-IND         PIC 99  VALUE ZERO.
           05 OL-ACCT             PIC 999  VALUE ZERO.
           05 WS-IDX              PIC 999  VALUE ZERO.

          01 CLIENTS-PER-STATE.
           05 FILLER              PIC X(25) VALUE 'VIRGINIA CLIENTS ='.
           05 FILLER              PIC X(02) VALUE SPACES.
           05 NUMB-CLIENTS        PIC 99.
           05 FILLER              PIC X(40) VALUE SPACES.

          01 IS-OVER-LIMIT.
           05 FILLER              PIC X(25) VALUE 'OVER LMIT CLIENTS ='.
           05 FILLER              PIC X(02) VALUE SPACES.
           05 NUMB-CLIENTS-OL     PIC 999.
           05 FILLER              PIC X(39) VALUE SPACES.

          01 WS-NO-OVER-LIMIT.
           05 FILLER              PIC X(25)
             VALUE 'NO OVER LMIT CLIENTS'.
           05 FILLER              PIC X(75) VALUE SPACES.

          01 TBL-OL-CLIENTS.
           05 TBL-OL-CLIENTS-REC OCCURS 1 TO 999 TIMES
                                DEPENDING ON OL-ACCT .
             10 TBL-OL-ACCT-NO     PIC X(8).
             10 TBL-OL-LAST-NAME   PIC X(20).
             10 TBL-OL-ACCT-LIMIT  PIC S9(7)V99.
             10 TBL-OL-ACCT-BALANCE PIC S9(7)V99.

          01  HEADER-1.
           05  FILLER         PIC X(20) VALUE 'Financial Report = '.
           05  FILLER         PIC X(60) VALUE SPACES.


          01  HEADER-2.
           05  FILLER         PIC X(05) VALUE 'Year '.
           05  HDR-YR         PIC 9(04).
           05  FILLER         PIC X(02) VALUE SPACES.
           05  FILLER         PIC X(06) VALUE 'Month '.
           05  HDR-MO         PIC X(02).
           05  FILLER         PIC X(02) VALUE SPACES.
           05  FILLER         PIC X(04) VALUE 'Day '.
           05  HDR-DAY        PIC X(02).
           05  FILLER         PIC X(56) VALUE SPACES.


          01  HEADER-3.
           05  FILLER         PIC X(08) VALUE 'Account '.
           05  FILLER         PIC X(02) VALUE SPACES.
           05  FILLER         PIC X(10) VALUE 'Last Name '.
           05  FILLER         PIC X(15) VALUE SPACES.
           05  FILLER         PIC X(06) VALUE 'Limit '.
           05  FILLER         PIC X(06) VALUE SPACES.
           05  FILLER         PIC X(08) VALUE 'Balance '.
           05  FILLER         PIC X(40) VALUE SPACES.


          01  HEADER-4.
           05  FILLER         PIC X(08) VALUE '--------'.
           05  FILLER         PIC X(02) VALUE SPACES.
           05  FILLER         PIC X(10) VALUE '----------'.
           05  FILLER         PIC X(15) VALUE SPACES.
           05  FILLER         PIC X(10) VALUE '----------'.
           05  FILLER         PIC X(02) VALUE SPACES.
           05  FILLER         PIC X(13) VALUE '-----------'.
           05  FILLER         PIC X(40) VALUE SPACES.


          01 WS-CURRENT-DATE-DATA.
           05  WS-CURRENT-DATE.
              10  WS-CURRENT-YEAR         PIC 9(04).
              10  WS-CURRENT-MONTH        PIC 9(02).
              10  WS-CURRENT-DAY          PIC 9(02).
           05  WS-CURRENT-TIME.
              10  WS-CURRENT-HOURS        PIC 9(02).
              10  WS-CURRENT-MINUTE       PIC 9(02).
              10  WS-CURRENT-SECOND       PIC 9(02).
              10  WS-CURRENT-MILLISECONDS PIC 9(02).

       PROCEDURE DIVISION.
       MAIN-PROGRAM.
           PERFORM OPEN-FILES.
           PERFORM WRITE-HEADERS.
           PERFORM READ-NEXT-RECORD.
           PERFORM WRITE-REPORT-LINES.
           PERFORM WRITE-OVER-LIMIT-CLIENTS.
           PERFORM CLOSE-FILES.
              STOP RUN.

       OPEN-FILES.
           OPEN INPUT ACCT-REC.
           IF WS-ACCTREC-STATUS NOT = '00'
              DISPLAY 'ERREUR OUVERTURE ACCTREC : '
                       WS-ACCTREC-STATUS
              STOP RUN
           END-IF.
           OPEN OUTPUT PRINT-LINE.
           IF WS-PRTLINE-STATUS NOT = '00'
              DISPLAY 'ERREUR OUVERTURE PRTLINE : '
                       WS-PRTLINE-STATUS
              STOP RUN
           END-IF.

       WRITE-HEADERS.
           WRITE PRINT-REC FROM HEADER-1.
           MOVE FUNCTION CURRENT-DATE TO WS-CURRENT-DATE-DATA.
           MOVE WS-CURRENT-YEAR TO HDR-YR.
           MOVE WS-CURRENT-MONTH TO HDR-MO.
           MOVE WS-CURRENT-DAY TO HDR-DAY.
           WRITE PRINT-REC FROM HEADER-2.
           MOVE SPACES TO PRINT-REC.
           WRITE PRINT-REC AFTER ADVANCING 1 LINES.
           WRITE PRINT-REC FROM HEADER-3.
           WRITE PRINT-REC FROM HEADER-4.
           MOVE SPACES TO PRINT-REC.
           WRITE PRINT-REC AFTER ADVANCING 1 LINES.

       READ-NEXT-RECORD.
           PERFORM READ-RECORD.
           PERFORM UNTIL LASTREC = 'Y'
              PERFORM WRITE-RECORD
              PERFORM IS-STATE
              PERFORM OVER-LIMIT
              PERFORM READ-RECORD
           END-PERFORM.

       WRITE-REPORT-LINES.
           MOVE SPACES TO PRINT-REC.
           WRITE PRINT-REC AFTER ADVANCING 1 LINES.
           MOVE CLIENTS-IND TO NUMB-CLIENTS.
           WRITE PRINT-REC FROM CLIENTS-PER-STATE
                             AFTER ADVANCING 1 LINES.
           MOVE OL-ACCT TO NUMB-CLIENTS-OL.
           WRITE PRINT-REC FROM IS-OVER-LIMIT AFTER ADVANCING 1 LINES.

       WRITE-OVER-LIMIT-CLIENTS.
           MOVE SPACES TO PRINT-REC.
           WRITE PRINT-REC AFTER ADVANCING 1 LINES.
           IF NUMB-CLIENTS-OL = 0
            WRITE PRINT-REC FROM WS-NO-OVER-LIMIT AFTER ADVANCING 1 LINES
           ELSE
            WRITE PRINT-REC FROM HEADER-3
            WRITE PRINT-REC FROM HEADER-4
            PERFORM VARYING WS-IDX  FROM 1 BY 1
                             UNTIL WS-IDX  > NUMB-CLIENTS-OL
                 MOVE TBL-OL-ACCT-NO (WS-IDX ) TO ACCT-NO-O
                 MOVE TBL-OL-LAST-NAME (WS-IDX ) TO LAST-NAME-O
                 MOVE TBL-OL-ACCT-LIMIT (WS-IDX ) TO ACCT-LIMIT-O
                 MOVE TBL-OL-ACCT-BALANCE (WS-IDX ) TO ACCT-BALANCE-O
                 WRITE PRINT-REC AFTER ADVANCING 1 LINES
            END-PERFORM
           END-IF.

       CLOSE-FILES.
           CLOSE ACCT-REC.
           CLOSE PRINT-LINE.

       READ-RECORD.
           READ ACCT-REC
              AT END MOVE 'Y' TO LASTREC
           END-READ.
           IF LASTREC = 'N' AND WS-ACCTREC-STATUS NOT = '00'
              DISPLAY 'ERREUR LECTURE ACCTREC : '
                       WS-ACCTREC-STATUS
              MOVE 'Y' TO LASTREC
           END-IF.

       WRITE-RECORD.
           IF LASTREC = 'N'
              MOVE ACCT-NO TO ACCT-NO-O
              MOVE LAST-NAME TO LAST-NAME-O
              MOVE ACCT-LIMIT TO ACCT-LIMIT-O
              MOVE ACCT-BALANCE TO ACCT-BALANCE-O
              WRITE PRINT-REC
           END-IF.

       IS-STATE.
           IF USA-STATE = 'Virginia'
              ADD 1 TO CLIENTS-IND
           END-IF.

       OVER-LIMIT.
           IF ACCT-BALANCE > ACCT-LIMIT
              ADD 1 TO OL-ACCT
              MOVE ACCT-NO TO TBL-OL-ACCT-NO (OL-ACCT)
              MOVE LAST-NAME TO TBL-OL-LAST-NAME (OL-ACCT)
              MOVE ACCT-LIMIT TO TBL-OL-ACCT-LIMIT (OL-ACCT)
              MOVE ACCT-BALANCE TO TBL-OL-ACCT-BALANCE (OL-ACCT)
           END-IF.




































































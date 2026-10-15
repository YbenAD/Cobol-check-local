      *-----------------------
      * Copyright Contributors to the COBOL Programming Course
      * SPDX-License-Identifier: CC-BY-4.0
      *-----------------------
       IDENTIFICATION DIVISION.
      *-----------------------
       PROGRAM-ID.    CBL0033.
       AUTHOR.        Otto B Fun.
      *--------------------
       ENVIRONMENT DIVISION.
      *--------------------
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PRINT-LINE ASSIGN TO PRTLINE.
           SELECT ACCT-REC   ASSIGN TO ACCTREC
               FILE STATUS IS WS-ACCT-STATUS.
      *-------------
       DATA DIVISION.
      *-------------
       FILE SECTION.
       FD  PRINT-LINE RECORDING MODE F.
       01  PRINT-REC.
           05  ACCT-NO-O      PIC X(8).
           05  ACCT-LIMIT-O   PIC $$,$$$,$$9.99.
           05  ACCT-BALANCE-O PIC $$,$$$,$$9.99.
           05  LAST-NAME-O    PIC X(20).
           05  FIRST-NAME-O   PIC X(15).
           05  COMMENTS-O     PIC X(50).
      *
       FD  ACCT-REC RECORDING MODE F.
       01  ACCT-FIELDS.
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
      *
       WORKING-STORAGE SECTION.
       01 FLAGS.
         05 LASTREC           PIC X VALUE SPACE.
       01 WS-ACCT-STATUS      PIC XX VALUE '00'.
      *WS-ACCT-STATUS holds the file status code for ACCT-REC.
       01 COUNTER             PIC 9(2) VALUE 0.
      *COUNTER is used for the PERFORM VARYING statement
      *------------------
       PROCEDURE DIVISION.
      *------------------
      *All processing is driven explicitly from 0000-MAIN-PROCESSING
      *below via PERFORM statements. No paragraph relies on
      *fall-through anymore: each one does its job and returns
      *control to whoever called it, like a normal function call.
      *This removes the need for the old "-END" delimiter
      *paragraphs and for PERFORM ... THRU tricks.
      *
       0000-MAIN-PROCESSING.
           PERFORM 1000-OPEN-FILES.
           PERFORM 2000-READ-FIRST-RECORD.
           PERFORM 2100-READ-TEN-RECORDS.
           PERFORM 2200-READ-ANOTHER-RECORD.
           PERFORM 2300-READ-NEXT-RECORDS.
           PERFORM 2400-CALLING-SUBPROGRAM.
           PERFORM 3000-CLOSE-STOP.
           GOBACK.
      *This is the only GOBACK in the program: the single, explicit
      *exit point. Reading this paragraph alone tells you the whole
      *story of what the program does, in order.
      *
       1000-OPEN-FILES.
           OPEN INPUT  ACCT-REC.
           OPEN OUTPUT PRINT-LINE.
      *
       2000-READ-FIRST-RECORD.
           PERFORM 4000-READ-RECORD.
           PERFORM 5000-WRITE-RECORD.
           DISPLAY ' THIS IS THE FIRST RECORD '.
      *
       2100-READ-TEN-RECORDS.
           PERFORM 10 TIMES
               PERFORM 4000-READ-RECORD
               PERFORM 5000-WRITE-RECORD
           END-PERFORM.
      *TIMES repeats a perform statement, it's number can be
      *either set or given by a variable
      *
       2200-READ-ANOTHER-RECORD.
           PERFORM 4000-READ-RECORD.
           PERFORM 5000-WRITE-RECORD.
      *
       2300-READ-NEXT-RECORDS.
           PERFORM VARYING COUNTER FROM 1 BY 1 UNTIL COUNTER EQUAL 34
               PERFORM 4000-READ-RECORD
               PERFORM 5000-WRITE-RECORD
           END-PERFORM.
      *Loop printing the remaining 34 records by varying the
      *variable COUNTER after each iteration.
      *The sentence PERFORM VARYING is continued on the next
      *line by starting on the B Area (column 12)
      *
       2400-CALLING-SUBPROGRAM.
           CALL 'HELLO'.
      *The program HELLO from the first Lab is called as a
      *subprogram from CBL0003. The JCL that compiles CBL0003
      *also compiles HELLO and links them together.
      *
       3000-CLOSE-STOP.
           CLOSE ACCT-REC.
           CLOSE PRINT-LINE.
      *
       4000-READ-RECORD.
           IF LASTREC NOT = 'Y'
               READ ACCT-REC
                   AT END MOVE 'Y' TO LASTREC
               END-READ
           END-IF.
      *Guard: once end-of-file has been reached (LASTREC = 'Y'),
      *no further READ is attempted, whatever paragraph calls this.
      *This avoids file status 46 (read past end of file).
      *
       5000-WRITE-RECORD.
           IF LASTREC NOT = 'Y'
               MOVE ACCT-NO      TO  ACCT-NO-O
               MOVE ACCT-LIMIT   TO  ACCT-LIMIT-O
               MOVE ACCT-BALANCE TO  ACCT-BALANCE-O
               MOVE LAST-NAME    TO  LAST-NAME-O
               MOVE FIRST-NAME   TO  FIRST-NAME-O
               MOVE COMMENTS     TO  COMMENTS-O
               WRITE PRINT-REC
           END-IF.
      *Guard: skips the WRITE once end-of-file has been reached,
      *so the last (stale) record isn't printed multiple times.
      *


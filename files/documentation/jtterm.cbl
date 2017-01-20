IDENTIFICATION DIVISION.

PROGRAM-ID.

	JTTERM.

AUTHOR.

	DIGITAL EQUIPMENT CORPORATION.

	COPYRIGHT (C) DIGITAL EQUIPMENT CORPORATION 1983, 1986.
	ALL RIGHTS RESERVED.
	
	THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY  BE  USED  AND
	COPIED ONLY IN ACCORDANCE WITH THE TERMS OF SUCH LICENSE AND WITH
	THE INCLUSION OF THE ABOVE COPYRIGHT NOTICE.   THIS  SOFTWARE  OR
	ANY  OTHER  COPIES  THEREOF MAY NOT BE PROVIDED OR OTHERWISE MADE
	AVAILABLE TO ANY OTHER PERSON.  NO TITLE TO AND OWNERSHIP OF  THE
	SOFTWARE IS HEREBY TRANSFERRED.
	
	THE INFORMATION IN THIS SOFTWARE IS  SUBJECT  TO  CHANGE  WITHOUT
	NOTICE  AND  SHOULD  NOT  BE CONSTRUED AS A COMMITMENT BY DIGITAL
	EQUIPMENT CORPORATION.
	
	DIGITAL ASSUMES NO RESPONSIBILITY FOR THE USE OR  RELIABILITY  OF
	ITS SOFTWARE ON EQUIPMENT THAT IS NOT SUPPLIED BY DIGITAL.


	This  program  is  a  portion  of  the  DIL  Load  Test   test
	application.  It  is the  remote terminal  interface, used  to
	collect data  from the  20  for the  "Job Ticket"  system.   A
	similar remote program will be written  to run on a VAX.   The
	program JTSERV will be the  server program which will live  on
	the 20.

INSTALLATION.

	DEC-MARLBOROUGH.

DATE-WRITTEN.

	JUNE 17, 1982.


* Facility: DIL-SAMPLE
* 
* Edit History:
* 
* new_version (1, 0)
* 
* Edit (%O'1', '29-Oct-82', 'Sandy Clemens')
* %(  Clean up DIL sample application and place in library.
*     Files: JTSERV.CBL (NEW), JTTERM.CBL (NEW), IDXINI.CBL (NEW),
*     JTTERM.VAX-COB (NEW), JTVRPT.CBL (NEW), PROCES.MAC (NEW) )%
*
* Edit (%O'2', '06-DEC-82', 'Sandy Clemens')
* %(  Put correct status code handling into all sample application
*     programs.  Add the use of VMS system service calls to vax
*     program.  General clean up.
*     Files: JTSERV.CBL (NEW), JTTERM.CBL (NEW), JTTERM.VAX-COB (NEW),
*     JTVRPT.CBL (NEW) )%
* 
* Edit (%O'3', '04-Jan-83', 'Sandy Clemens')
* %(  Add SYS: to the interface files COPY statement for the 10/20
*     programs. Add SYS$LIBRARY for the VAX program.
*     Files: JTSERV.CBL, JTTERM.CBL, JTTERM.VAX-COB,
*     JTVRPT.CBL )%
*
* Edit (%O'6', '20-Jan-83', 'Sandy Clemens')
* %(  Add copyright notice for 1983. Files: DSHST.TXT, IDXINI.CBL,
*     JTSERV.CBL, JTTERM.CBL, JTTERM.VAX-COB, JTVRPT.CBL, PROCES.MAC )%
* 
* Edit (%O'7', '24-Jan-83', 'Sandy Clemens')
* %(  Add liability waiver to copyright notice. Files: DSHST.TXT,
*     IDXINI.CBL, JTSERV.CBL, JTTERM.CBL, JTTERM.VAX-COB, JTVRPT.CBL,
*     PROCES.MAC )%
* 
* Edit (%O'10', '25-Jan-83', 'Sandy Clemens')
* %(  Standardize "Author" entry.  Files: DSHST.TXT, IDXINI.CBL,
*     JTSERV.CBL, JTTERM.CBL, JTTERM.VAX-COB, JTVRPT.CBL )%
*
* new_version (2, 0)
*
* Edit (%O'12', '17-Apr-84', 'Sandy Clemens')
* %(  Add V2 files to DS2:.  )%
* 
* new_version (2, 1)
* 
* Edit (%O'13', '3-Jul-86', 'Sandy Clemens')
* %( Add V2.1 files to DS21:. )%
ENVIRONMENT DIVISION.

CONFIGURATION SECTION.

SOURCE-COMPUTER.

	DECSYSTEM-20.

OBJECT-COMPUTER.

	DECSYSTEM-20.

INPUT-OUTPUT SECTION.

DATA DIVISION.

WORKING-STORAGE SECTION.

***** badge-or-close-request records ******************************************

01  BADGE-REC.
    05  REQTYP1 PIC S9(10) COMP.
    05  BADGE-NUM PIC 9(7).

***** data-or-stop-update records *********************************************

01  DATA-RECORD.
    05  REQTYP2 PIC S9(10) COMP.
    05  JOB-TICKET.
        10  NAME PIC X(30).
        10  COST-CENTER PIC X(4).
        10  WK-END-DATE PIC 9(6).
        10  TOTAL-HRS COMP-1.
	10  KOUNT PIC S9(10) COMP.
	10  DETAIL-LINES OCCURS 10.
	    15  ACTIV-CD PIC X(4).
	    15  PL-NUM PIC X(4).
	    15  DIS-NUM PIC 9(5) COMP.
	    15  MFG-NUM PIC 9(5) COMP.
	    15  HOURS COMP-1.
	    15  OP-CD PIC X(4).

***** message records *********************************************************

01  MESSAGE-REC pic x(6).
01  MESSAGE-STUFF REDEFINES MESSAGE-REC.
    05  MESSAGE-DATA PIC S9(10) COMP.

***** date edit fields ********************************************************

01  WEEK-ENDING.
    05  MON PIC 99.
    05  FILLER PIC X VALUE "/".
    05  DY PIC 99.
    05  FILLER PIC X VALUE "/".
    05  YR PIC 99.

01  WS-DATE-HOLD.
    05  DH-MO PIC 99.
    05  DH-DY PIC 99.
    05  DH-YR PIC 99.

***** table of message values sent between server and remote ******************

01 MESSAGE-DATA-VALUES. 
*	This table lists the  possible values that  can be moved  into
*	the message-data field which is used to send messages  between
*	the server and the remote  programs.  All of the programs  use
*	these values as their message codes or status returns.
    05  B-EXIST PIC S9(10) COMP VALUE 0.
*	badge number presently exits in ISAM file
    05  B-NOTEXIST PIC S9(10) COMP VALUE 1.
*	badge number presently does no exist in ISAM file.
    05  REQ-ERROR PIC S9(10) COMP VALUE 2.
*	error in request type, not recognized by server
    05  UPDA-OK PIC S9(10) COMP VALUE 3.
*	update finished allright.
    05  UPDA-ERR PIC S9(10) COMP VALUE 4.
*	error in update, update aborted
    05  UPDA-ABORT PIC S9(10) COMP VALUE 5.
*	the update was aborted (as requested, hopefully!)

***** dil interface files *****************************************************

01  COPY-INTER-FILES.
    COPY DIL OF "SYS:DIL.LIB".
    COPY DIT OF "SYS:DIL.LIB".
    COPY DIX OF "SYS:DIL.LIB".

***** dil call return code parameters *****************************************

01  DILINI-PARAMETERS.
    05  DIL-INIT-STATUS PIC S9(10) COMP.
    05  DIL-STATUS PIC S9(10) COMP.
    05  DIL-SEVERITY PIC S9(10) COMP.
    05  DIL-MESSAGE PIC S9(10) COMP.

***** dit call parameters *****************************************************

01  NETNODE PIC X(6) VALUE "KL2137" USAGE IS DISPLAY-7.
01  OBJID PIC X(16) VALUE "135" USAGE IS DISPLAY-7.
01  DESCR PIC X(16) VALUE SPACES USAGE IS DISPLAY-7.
01  TASKNAME PIC X(16) VALUE SPACES USAGE IS DISPLAY-7.
01  USRID PIC X(39) VALUE SPACES USAGE IS DISPLAY-7.
01  PSWD PIC X(39) VALUE SPACES USAGE IS DISPLAY-7.
01  ACCT PIC X(39) VALUE SPACES USAGE IS DISPLAY-7.
01  OPCHAR PIC X(16) VALUE SPACES USAGE IS DISPLAY-7.

01  MSG-BYTSIZ PIC S9(10) COMP.
01  MSGLEN PIC S9(10) COMP.
01  SYNCH-DISCONN PIC S9(10) COMP VALUE 0.

***** etc *********************************************************************

77  WS-COMMAND PIC X(10).
77  NETLN PIC S9(10) COMP.
77  ANS PIC XXX.

*******************************************************************************

PROCEDURE DIVISION.

*******************************************************************************

THE-TOP SECTION.

    PERFORM SET-UP.

    PERFORM INIT-LINK.

    PERFORM PROMPT THRU PROMPT-EXIT.

    PERFORM FINISH-UP.

    STOP RUN.

*******************************************************************************

SET-UP SECTION.

*******************************************************************************

GIVE-MESSAGE.

    DISPLAY " ".
    DISPLAY "Welcome to Job Tickets.".
    DISPLAY " ".


CALL-DILINI.

    ENTER MACRO DILINI USING DIL-INIT-STATUS,
			     DIL-STATUS,
			     DIL-MESSAGE,
			     DIL-SEVERITY.

    IF DIL-INIT-STATUS NOT = 1
         DISPLAY "Call to DILINI not successful, program aborted."
	 STOP RUN.

*******************************************************************************

INIT-LINK SECTION.

*******************************************************************************

OPEN-BINARY-ACTIVE-LINK.

* establish binary active link to server on dec-20

    ENTER MACRO NFOPB USING NETLN, NETNODE, OBJID, DESCR,
	 TASKNAME, USRID, PSWD, ACCT, OPCHAR, DIT-WAIT-YES. 

    IF DIL-SEVERITY = STS-K-SUCCESS
	 DISPLAY " "
	 DISPLAY " Binary link open OK!"

    ELSE
	 DISPLAY " "
	 DISPLAY "%NFOPB Fatal Error. Cannot open link. Process halted."
	 PERFORM DIL-STATUS-ABEND.


SEND-ID-TO-SERVER.

*	tell the server program  that we are  a DEC-20, and  therefore
*	DEC-20 data will be passed over this link


    MOVE DIX-SYS-10-20 TO MESSAGE-DATA.

    MOVE 36 TO MSG-BYTSIZ.
    MOVE 1 TO MSGLEN.
    ENTER MACRO NFSND USING NETLN,
			    MSG-BYTSIZ,
			    MSGLEN,
			    MESSAGE-REC,
			    DIT-MSG-MSG.

    IF DIL-SEVERITY = STS-K-SUCCESS
	 DISPLAY " "
	 DISPLAY "ID record sent to server ok"

    ELSE
	 DISPLAY " "
	 DISPLAY "%NFSND Fatal Error in initialization. Process Halted."
	 PERFORM DIL-STATUS-ABEND.

    MOVE LOW-VALUES TO MESSAGE-REC.

*******************************************************************************

PROMPT SECTION.

*******************************************************************************

DISPLAY-PROMPT.

    DISPLAY "JTTERM>" WITH NO ADVANCING ACCEPT WS-COMMAND.

GET-COMMAND.

    IF WS-COMMAND = "HELP"
	OR WS-COMMAND = "HEL"
	OR WS-COMMAND = "HE"
	OR WS-COMMAND = "H"
	OR WS-COMMAND = "?"
       PERFORM COMMAND-HELP THRU CHELP-EXIT

    ELSE
	 IF WS-COMMAND = "UPDATE"
	     OR WS-COMMAND = "UPDAT"
	     OR WS-COMMAND = "UPDA"
	     OR WS-COMMAND = "UPD"
	     OR WS-COMMAND = "UP"
	     OR WS-COMMAND = "U"
	   PERFORM UPDATE-TICKET THRU UPDATE-EXIT

	 ELSE
	      IF WS-COMMAND = "EXIT"
		  OR WS-COMMAND = "EXI"
		  OR WS-COMMAND = "EX"
		  OR WS-COMMAND = "E"
		 GO TO PROMPT-EXIT

	      ELSE DISPLAY "?Command error: does not match keyword.".

    GO TO DISPLAY-PROMPT.

PROMPT-EXIT.

*******************************************************************************

FINISH-UP SECTION.

*******************************************************************************

    MOVE 1 TO REQTYP1.
    PERFORM SEND-REQ1-TO-SERV THRU 1EXIT.

    IF DIL-SEVERITY = STS-K-SUCCESS
	DISPLAY "Disconnect request sent to server ok."
    ELSE
	DISPLAY "%NFSND Fatal Error while requesting disconnect."
	DISPLAY "   Process halted!"
	PERFORM DIL-STATUS-ABEND.

    ENTER MACRO NFGND USING NETLN, DIT-WAIT-YES.

    IF DIL-MESSAGE NOT = DIT-C-ABREJEVENT
       AND DIL-MESSAGE NOT = DIT-C-DISCONNECTEVENT

	DISPLAY "NFGND%ERR Expected disconnectevent - status return incorrect."
	DISPLAY "Dil-Message was: " DIL-MESSAGE
	DISPLAY "Dil-Severity was: " DIL-SEVERITY

    ELSE

	DISPLAY "NFGND$OK Disconnect OK".

*******************************************************************************

UPDATE-TICKET SECTION.

*******************************************************************************

ENTER-BADGE-NUM.

*	first get the badge number and send it to the server

    DISPLAY "Please enter your badge number: "
	WITH NO ADVANCING ACCEPT BADGE-NUM.
    DISPLAY " ".


SEND-BADGE-TO-SERVER.

    MOVE 0 TO REQTYP1.
    PERFORM SEND-REQ1-TO-SERV THRU 1EXIT.

    IF DIL-SEVERITY = STS-K-SUCCESS
	 DISPLAY " Badge sent to server OK!"

    ELSE
	 DISPLAY "%NFSND Fatal Error while sending badge. Process halted."
	 PERFORM DIL-STATUS-ABEND.


RECEIVE-BADGE-MESSAGE.

    PERFORM GET-MESSAGE-FROM-SERVER THRU 2EXIT.


ANALYZE-BADGE-RETURN.

*	analyze message from server, display message to user

    IF MESSAGE-DATA = B-EXIST
       DISPLAY " "
       DISPLAY "Badge number, " BADGE-NUM ", presently exists in the file."
       DISPLAY " "

    ELSE
	 DISPLAY " "
	 IF MESSAGE-DATA = B-NOTEXIST
	 DISPLAY "Badge number, " BADGE-NUM ", does not exist in the file."
	 DISPLAY " "

	 ELSE
	      DISPLAY "%Error in return code from server. Process aborted."
	      PERFORM DIL-STATUS-ABEND.

DECIDE-IF-TO-CONTINUE.

*	now that you know the status of the badge-num, do you want  to
*	keep going?

    DISPLAY "Do you want to continue the update?  (enter Y or N): "
	WITH NO ADVANCING ACCEPT ANS.

REACC.
    IF ANS = "Y"
	PERFORM ACCEPT-OTHER-DATA THRU ACC-DAT-EXIT
	MOVE 0 TO REQTYP2

    ELSE
	IF ANS = "N" MOVE 1 TO REQTYP2
	ELSE DISPLAY "(Y OR N): " WITH NO ADVANCING ACCEPT ANS
	     GO TO REACC.


SEND-DATA-TO-SERVER.

*	request transfer of remaining (update) data to dec-20  server.
*	(this will send the data-record, containing the data collected
*	from the terminal, (or  a discontinue-the-update request),  to
*	the server program).

    MOVE 36 TO MSG-BYTSIZ.
    MOVE 61 TO MSGLEN.

    ENTER MACRO NFSND USING NETLN,
			    MSG-BYTSIZ,
			    MSGLEN,
			    DATA-RECORD,
			    DIT-MSG-MSG.

    IF DIL-SEVERITY = STS-K-SUCCESS
	 DISPLAY " "
	 DISPLAY " Data record sent to server ok."
	 DISPLAY " "
    ELSE
	 DISPLAY "%NFSND Fatal Error. Process Halted."
	 PERFORM DIL-STATUS-ABEND.


RECEIVE-DATA-MESSAGE.

    PERFORM GET-MESSAGE-FROM-SERVER THRU 2EXIT.

CHECK-MSG.

*	Check the message from the server.  If reqtyp2 = 1 didn't want
*	to continue with update.  If reqtyp2 = 0 did want to  continue
*	with update.

    IF REQTYP2 NOT = 0
	 NEXT SENTENCE

    ELSE
	 IF MESSAGE-DATA = UPDA-OK DISPLAY "Update finished successfully."
	    GO TO UPDATE-EXIT

	 ELSE
	      IF MESSAGE-DATA = UPDA-ERR
		 DISPLAY "?Server update error -- update not completed" 
		 GO TO UPDATE-EXIT

	      ELSE
		   DISPLAY "?Invalid return code from server while updating."
		   DISPLAY "?Update may not be complete."
		   GO TO UPDATE-EXIT.

    IF REQTYP2 = 1 AND MESSAGE-DATA = UPDA-ABORT
	DISPLAY "OK.  Update discontinued."
    ELSE
	DISPLAY "?Invalid return code from server while aborting update".

UPDATE-EXIT.

*******************************************************************************

PERFORM-CALLS SECTION.

*******************************************************************************

SEND-REQ1-TO-SERV.

*	request transfer of badge-number data to dec-20 server.  (this
*	will send the badge-rec to the server program).

    MOVE 36 TO MSG-BYTSIZ.
    MOVE 3 TO MSGLEN.

    ENTER MACRO NFSND USING NETLN,
			    MSG-BYTSIZ,
			    MSGLEN,
			    BADGE-REC,
			    DIT-MSG-MSG.

1EXIT.





GET-MESSAGE-FROM-SERVER.

*	receive message back from server, either b-exist,  b-notexist,
*	or req-error.

    MOVE 36 TO MSG-BYTSIZ.
    MOVE 1 TO MSGLEN.

    ENTER MACRO NFRCV USING NETLN,
			    MSG-BYTSIZ,
			    MSGLEN,
			    MESSAGE-REC,
			    DIT-MSG-MSG,
			    DIT-WAIT-YES.

    IF DIL-SEVERITY = STS-K-SUCCESS
	DISPLAY " message returned from server OK!"
    ELSE
	 DISPLAY "%NFRCV Fatal Error. Process halted."
	 PERFORM DIL-STATUS-ABEND.

2EXIT.

P-C-EXIT.

*******************************************************************************

COMMAND-HELP SECTION.

*******************************************************************************

COMMAND-HELP-TXT.

    DISPLAY "The options are:  UPDATE  HELP  EXIT ".
    DISPLAY " ".
    DISPLAY "UPDATE is for adding weekly project information for an employee.".
    DISPLAY "HELP gives you this list of options. ".
    DISPLAY "EXIT is for exiting. ".
    DISPLAY " ".

CHELP-EXIT.

*******************************************************************************

ACCEPT-OTHER-DATA SECTION.

*******************************************************************************

*	Accept remaining data from terminal

    MOVE 0 TO TOTAL-HRS. 

    DISPLAY " ".
    DISPLAY "Please enter your full name, as it appears on your check: "
	WITH NO ADVANCING ACCEPT NAME.

    DISPLAY " ".
    DISPLAY "Please enter your cost center number: "
	WITH NO ADVANCING ACCEPT COST-CENTER.

    DISPLAY " ".
    DISPLAY "Please enter the 'week ending' date, that is, the date on".
    DISPLAY "Saturday.  Enter it in the form MM/DD/YY: "
	WITH NO ADVANCING ACCEPT WEEK-ENDING.

    MOVE DY TO DH-DY.
    MOVE MON TO DH-MO.
    MOVE YR TO DH-YR.
    MOVE WS-DATE-HOLD TO WK-END-DATE.

    DISPLAY " ".
    DISPLAY "Now enter the detail lines for each project you are working on: ".
    DISPLAY " ".

    MOVE 0 TO KOUNT.

ACCEPT-DETAIL-LINES.

    ADD +1 TO KOUNT.

    DISPLAY "Enter the activity code for this project: "
	WITH NO ADVANCING ACCEPT ACTIV-CD(KOUNT).

    DISPLAY " ".
    DISPLAY "Enter the product line code for this project: "
	WITH NO ADVANCING ACCEPT PL-NUM(KOUNT).

    DISPLAY " ".
    DISPLAY "Enter the discrete number for this project: "
	WITH NO ADVANCING ACCEPT DIS-NUM(KOUNT).

    DISPLAY " ".
    DISPLAY "Enter the manufacturing job number for this project: "
	WITH NO ADVANCING ACCEPT MFG-NUM(KOUNT).

    DISPLAY " ".
    DISPLAY "Enter the hours you worked on this project this week,".
    DISPLAY "in the form 999.99 : "
	WITH NO ADVANCING ACCEPT HOURS(KOUNT).

    DISPLAY " ".
    DISPLAY "Enter the operation code for this project: "
	WITH NO ADVANCING ACCEPT OP-CD(KOUNT).

    DISPLAY " ".

    COMPUTE TOTAL-HRS = TOTAL-HRS + HOURS(KOUNT).

    IF KOUNT < 10
	DISPLAY "Do you want to add more project detail lines? (Y or N): "
	WITH NO ADVANCING ACCEPT ANS
    ELSE GO TO ACC-DAT-EXIT.

REACC.
    IF ANS = "Y"
	GO TO ACCEPT-DETAIL-LINES
    ELSE
	IF ANS = "N" NEXT SENTENCE
	ELSE DISPLAY "(Y OR N): " WITH NO ADVANCING ACCEPT ANS
	     GO TO REACC.

ACC-DAT-EXIT.

DIL-STATUS-ABEND.

    IF DIL-MESSAGE = DIT-C-INVARG
	DISPLAY "%Dit$_Invarg -- Invalid arguement."

    ELSE
    IF DIL-MESSAGE = DIT-C-HORRIBLE
	DISPLAY "%Dit$_Horrible -- Internal or system error."

    ELSE
    IF DIL-MESSAGE = DIT-C-TOOMANY
	DISPLAY "%Dit$_Toomany -- Attempt to open too many files or links."

    ELSE
    IF DIL-MESSAGE = DIT-C-OVERRUN
	DISPLAY "%Dit$_Overrun -- Data overrun."

    ELSE
    IF DIL-MESSAGE = DIT-C-INTERRUPT
	DISPLAY "%Dit$_Interrupt -- Interrupt."

    ELSE
    IF DIL-MESSAGE = DIT-C-NOTENOUGH
	DISPLAY "%Dit$_Notenough -- Not enough data available."

    ELSE
    IF DIL-MESSAGE = DIT-C-ABORTREJECT
	DISPLAY "%Dit$_Abortreject -- Abort/reject."

    ELSE DISPLAY "%DIT SERIOUS ERROR -- Invalid return code.".

    STOP RUN.

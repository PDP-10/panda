IDENTIFICATION DIVISION. 

PROGRAM-ID.

	JTVRPT.

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
	application.  It is a program  that "lives" on the DEC-20  and
	writes a remote  sequential ASCII  file on the  VAX.  It  will
	open a link and use DAP routines to handle remote file access.

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
* Edit (%O'5', '06-Jan-83', 'Sandy Clemens')
* %(  Make JTVRPT prompt for password neater.  File: JTVRPT.CBL )%
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

FILE-CONTROL.

    SELECT JT-FIL ASSIGN TO DSK
           ORGANIZATION IS RMS INDEXED
           ACCESS MODE IS SEQUENTIAL
	   RECORD KEY IS BADGE-NUM.

DATA DIVISION.

FILE SECTION.

FD  JT-FIL LABEL RECORDS ARE STANDARD
	VALUE OF IDENTIFICATION IS "JOBTICRMS".

01  JT-REC.
    05  NAME PIC X(30).
    05  BADGE-NUM PIC 9(7).
    05  COST-CENTER PIC X(4).
    05  WK-END-DATE PIC 9(6).
    05  TOTAL-HRS COMP-1.
    05  DETAIL-LINE OCCURS 10.
	15  ACTIV-CODE PIC X(4).
	15  PROD-LINE PIC X(4).
	15  DISCR-NUM PIC 9(5) COMP.
	15  MFG-NUM PIC 9(5) COMP.
	15  HOURS COMP-1.
	15  OPER-CODE PIC X(4).

WORKING-STORAGE SECTION.

01  DILINI-PARAMETERS.
    05  DIL-INIT-STATUS PIC S9(10) COMP.
    05  DIL-STATUS PIC S9(10) COMP.
    05  DIL-SEVERITY PIC S9(10) COMP.
    05  DIL-MESSAGE PIC S9(10) COMP.

01  VAX-FILNO PIC S9(10) COMP.
01  VAX-FILNAM PIC X(39) VALUE "SPAGS::JTSUM.RPT" USAGE DISPLAY-7.
01  VAX-USER PIC X(39) VALUE "SCLEMENS" USAGE DISPLAY-7.
01  VAX-PSWD PIC X(39) USAGE DISPLAY-7.
01  VAX-ACCNT PIC X(39) USAGE DISPLAY-7.

01  REC-FOR-CONVERSION.
    05  CONV-NAME PIC X(30).
    05  FILLER PIC X VALUE SPACES.
    05  CONV-BADGE-NUM PIC X(7).
    05  FILLER PIC X VALUE SPACES.
    05  CONV-COST-CENTER PIC X(5).
    05  FILLER PIC XX VALUE SPACES.
    05  CONV-DATE PIC X(6).

01  VAX-TRANS-REC PIC X(52) USAGE DISPLAY-7.

01  EOF-FLAG PIC X.
    88 NOT-END-OF-FILE VALUE "N".
    88 END-OF-FILE VALUE "Y".

01  COPY-DIL-INTERFILS.
    COPY DIX OF "SYS:DIL.LIB".
    COPY DIT OF "SYS:DIL.LIB".
    COPY DIL OF "SYS:DIL.LIB".

77  ANS PIC X.
77  KNT PIC 99 COMP VALUE 0.
77  WS-COMMAND PIC X(10).
77  RET-CODE PIC S9(10) COMP.

*******************************************************************************

PROCEDURE DIVISION.

*******************************************************************************

THE-TOP SECTION.

    PERFORM START-UP.

*    PERFORM OPEN-REMOTE-FILE.
    perform main.
*    PERFORM WRITE-REPORT-HEADER.

    PERFORM PROCESS-RECORD THRU PROCESS-EXIT UNTIL END-OF-FILE.

    PERFORM FINISH-UP.

    STOP RUN.

*******************************************************************************

START-UP SECTION.

*******************************************************************************

INITIALIZE-DIL.

    CALL DILINI USING   DIL-INIT-STATUS,
			DIL-STATUS,
			DIL-MESSAGE,
			DIL-SEVERITY.


    IF DIL-INIT-STATUS NOT = 1
	DISPLAY "%Fatal error: Unsuccessful return from DILINI routine."
	DISPLAY "%Process halted."
	STOP RUN.


INITIALIZE-DATA-FILE.

    MOVE "N" TO EOF-FLAG.
    OPEN INPUT JT-FIL.

*******************************************************************************

MAIN SECTION.

*******************************************************************************

GET-VAX-PSWD.

    DISPLAY "Enter the password for account: " VAX-USER.
    ACCEPT VAX-PSWD.

OPEN-REMOTE-FILE.

    CALL ROPEN USING	VAX-FILNO, VAX-FILNAM, VAX-USER, VAX-PSWD, 
			VAX-ACCNT, DIT-MODE-WRITE, DIT-TYPE-ASCII,
			DIT-RFM-FIXED, DIT-RAT-ENVELOPE, 52, 7.

    IF DIL-SEVERITY = STS-K-SUCCESS
	 DISPLAY "ROP$OK Open successful."

    ELSE
	 PERFORM ANALYZE-DIL-STATUS
	 STOP RUN.



WRITE-REPORT-HEADER.

    MOVE  "NAME"    TO  CONV-NAME.
    MOVE  "BDG-NUM" TO  CONV-BADGE-NUM.
    MOVE  "C-C"     TO  CONV-COST-CENTER.
    MOVE  "DATE"    TO  CONV-DATE.

    PERFORM CONVERT-LOCAL-DATA THRU PROCESS-EXIT.

*******************************************************************************

FINISH-UP SECTION.

*******************************************************************************

CLOSE-LOCAL-DATA-FILE.

    CLOSE JT-FIL.



CLOSE-REMOTE-REPORT-FILE.

    CALL RCLOSE USING	VAX-FILNO,
			DIT-OPT-NOTHING.


    IF DIL-SEVERITY = STS-K-SUCCESS
	 DISPLAY "RCL$OK Close successful."

    ELSE
	 PERFORM ANALYZE-DIL-STATUS
	 STOP RUN.

*******************************************************************************

PROCESS-RECORD SECTION.

*******************************************************************************

READ-LOCAL-DATA-RECORD.

    READ JT-FIL NEXT

	AT END  MOVE "Y" TO EOF-FLAG
		GO TO PROCESS-EXIT.


DISPLAY-NAME.

    DISPLAY "Name is : " NAME.


MOVE-LOCAL-DATA.

    MOVE  NAME         TO  CONV-NAME.
    MOVE  BADGE-NUM    TO  CONV-BADGE-NUM.
    MOVE  COST-CENTER  TO  CONV-COST-CENTER.
    MOVE  WK-END-DATE  TO  CONV-DATE.


CONVERT-LOCAL-DATA.

    CALL CVGEN USING

	REC-FOR-CONVERSION, DIX-SYS-10-20, 6, 0, 0, DIX-DT-SIXBIT,  52, 0,
	     VAX-TRANS-REC, DIX-SYS-10-20, 7, 0, 0, DIX-DT-ASCII-7, 52, 0.


CHECK-CONVERSION-STATUS.

    IF DIL-SEVERITY = STS-K-SUCCESS
	 NEXT SENTENCE

    ELSE
	 IF DIL-MESSAGE = DIX-C-ROUNDED DISPLAY "STS$K_INFO Result is rounded."

	 ELSE
	      IF DIL-MESSAGE = DIX-C-TRUNC
		 DISPLAY "STS$K_INFO Destination too long--truncated."

	      ELSE
		   IF DIL-SEVERITY NOT = STS-K-INFO
		      PERFORM ANALYZE-DIX-ERROR
		      STOP RUN.

WRITE-REMOTE-RECORD.

    CALL RWRITE USING	VAX-FILNO,
			7,
			52,
			VAX-TRANS-REC.


    IF DIL-SEVERITY = STS-K-SUCCESS
	 DISPLAY "Record " BADGE-NUM " written successfully. "

    ELSE
	 PERFORM ANALYZE-DIL-STATUS
	 STOP RUN.

PROCESS-EXIT.

*******************************************************************************

ANALYZE-DIL-STATUS SECTION.

*******************************************************************************

ANALYZE-STAT.

    IF DIL-MESSAGE = DIT-C-TOOMANY
	DISPLAY "%Error: too many files open, can't open another"

    ELSE
    IF DIL-MESSAGE = DIT-C-INVARG
	DISPLAY "%Error: argument type or invalid arguement "

    ELSE
    IF DIL-MESSAGE = DIT-C-NETOPRFAIL
	DISPLAY "?Network operation could not be done "

    ELSE
    IF DIL-MESSAGE = DIT-C-CHECKSUM
	DISPLAY "?Checksum error "

    ELSE
    IF DIL-MESSAGE = DIT-C-UNSFILETYPE
	DISPLAY "%Error: cannot write specified file type"

    ELSE
    IF DIL-MESSAGE = DIT-C-FILEINUSE
	DISPLAY "%Error: file activity precludes this operation"

    ELSE
    IF DIL-MESSAGE = DIT-C-NOFILE
	DISPLAY "?File does not exist or is not available"

    ELSE
    IF DIL-MESSAGE = DIT-C-HORRIBLE
	DISPLAY "%Internal or system error."

    else display "?Error not recognized... "
	 display "Dil-Status was " DIL-STATUS
	 display "Dil-Severity was " DIL-SEVERITY
	 display "Dil-Message was " DIL-MESSAGE

    DISPLAY " ".

    DISPLAY "%Process halted.".

*******************************************************************************

ANALYZE-DIX-ERROR SECTION.

*******************************************************************************

ANALYZE-STAT.

    IF DIL-MESSAGE = DIX-C-TOOBIG
	DISPLAY "STS$K_SEVERE Converted source field too large for destination"

    ELSE
    IF DIL-MESSAGE = DIX-C-INVDATTYP 
	DISPLAY "STS$K_SEVERE Invalid data type."

    ELSE
    IF DIL-MESSAGE = DIX-C-UNKARGTYP
	DISPLAY "STS$K_SEVERE Argument passed by descriptor is unknown type."

    ELSE
    IF DIL-MESSAGE = DIX-C-UNKSYS
	DISPLAY "STS$K_SEVERE Unknown system of origin specified."

    ELSE
    IF DIL-MESSAGE = DIX-C-INVLNG
	DISPLAY "STS$K_SEVERE Scale factor invalid or unspecified."

    ELSE
    IF DIL-MESSAGE = DIX-C-INVSCAL
	DISPLAY "STS$K_SEVERE Scale factor invalid or unspecified."

    ELSE
    IF DIL-MESSAGE = DIX-C-GRAPHIC
	DISPLAY "STS$K_WARNING Graphic charater changed in conversion"

    ELSE
    IF DIL-MESSAGE = DIX-C-FMTLOST
	DISPLAY "STS$K_WARNING Format effector gained or lost in conversion."

    ELSE
    IF DIL-MESSAGE = DIX-C-NONPRINT
	DISPLAY "STS$K_WARNING Non-printing char gained or lost in conversion."

    ELSE
    IF DIL-MESSAGE = DIX-C-UNIMP
	DISPLAY "STS$K_SEVERE Unimplemented conversion."

    ELSE
    IF DIL-MESSAGE = DIX-C-INVALCHAR
	DISPLAY "STS$K_ERROR Invalid char in source field or conversion table."

    ELSE
    IF DIL-MESSAGE = DIX-C-ALIGN
	DISPLAY "STS$K_SEVERE Invalid alignment for data type."

    ELSE
    IF DIL-MESSAGE = DIX-C-UNNORM
	DISPLAY "STS$K_SEVERE Floating point number improperly normalized."

    ELSE
    IF DIL-MESSAGE = DIX-C-IMPOSSIBLE
	DISPLAY "STS$K_SEVERE Total internal fuckup."

    ELSE
    IF DIL-MESSAGE = DIX-C-UNSIGNED
	DISPLAY "STS$K_ERROR Negative value moved to unsigned field."

    ELSE
    IF DIL-MESSAGE = DIX-C-INVBYTSIZ
	DISPLAY "STS$K_SEVERE Invalid byte size specified."

    ELSE
	DISPLAY "STS$K_SEVERE Unrecognized message code returned."
	DISPLAY "Dil-Message was: " DIL-MESSAGE
	DISPLAY "Dil-Severity was: " DIL-SEVERITY.

    DISPLAY "%Process halted due to severity of error return.".

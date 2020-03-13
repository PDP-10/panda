IDENTIFICATION DIVISION. 

PROGRAM-ID.
	JTSERV.

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


	This  program  is  a  portion  of  the  DIL  Load  Test sample
	application.  It is the server program, which is accessed from
	the remote programs:  JTTERM.CBL on the  20 and JTTERM.COB  on
	the VAX.

INSTALLATION.
	DEC-MARLBOROUGH.

DATE-WRITTEN.
	JUNE 24, 1982.


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
* Edit (%O'4', '06-Jan-83', 'Sandy Clemens')
* %(  Fix code bug in server that caused update information to
*     disappear.  File: JTSERV.CBL )%
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

    SELECT DUMMY ASSIGN TO DSK
           ORGANIZATION IS RMS INDEXED
           ACCESS MODE IS SEQUENTIAL
	   RECORD KEY IS DUMMY-REC.

    SELECT JT-FIL ASSIGN TO DSK
	   ORGANIZATION IS RMS INDEXED
	   ACCESS MODE IS DYNAMIC
	   RECORD KEY IS JT-BADGE-NUM.

DATA DIVISION.

FILE SECTION.

FD  DUMMY LABEL RECORDS ARE STANDARD
	VALUE OF IDENTIFICATION IS "DUMMY FIL".
01  DUMMY-REC PIC X.

FD  JT-FIL LABEL RECORDS ARE STANDARD
	VALUE OF IDENTIFICATION IS "JOBTICRMS".

01  JT-REC.
    05  JT-NAME PIC X(30).
    05  JT-BADGE-NUM PIC 9(7).
    05  JT-COST-CENTER PIC X(4).
    05  JT-WK-END-DATE PIC 9(6).
    05  JT-TOTAL-HRS COMP-1.
    05  JT-DETAIL-LINES OCCURS 10.
        10  JT-ACTIV-CD PIC X(4).
        10  JT-PL-NUM PIC X(4).
        10  JT-DIS-NUM PIC 9(5) COMP.
        10  JT-MFG-NUM PIC 9(5) COMP.
        10  JT-HOURS COMP-1.
        10  JT-OP-CD PIC X(4).

WORKING-STORAGE SECTION.

***** message records *********************************************************

*01  MESSAGE-REC PIC X(6).
*01  MESSAGE-STUFF REDEFINES MESSAGE-REC.

01  MESSAGE-STUFF.
    05  MESSAGE-DATA PIC S9(10) COMP.


***** badge-or-close-request records ******************************************

***** from the vax
01  BDGORCLS-REC.
    05  BDGORCLS-WORD PIC S9(10) COMP OCCURS 3.
***** from the 20
01  BADGE-REC.
    05  REQTYP1 PIC S9(10) COMP.
    05  BADGE-NUM PIC S9(7).
    05  FILLER PIC X(5).



***** data-or-stop-update records ********************************************

***** from the vax
01  REMOTE-DATA-REC.
    05  REMOTE-DATA-WORD PIC S9(10) COMP OCCURS 65.

***** from the 20
01  DATA-RECORD.
    05  REQTYP2 PIC S9(10) COMP.
    05  WS-JOB-TICKET.
        10  WS-NAME PIC X(30).
        10  WS-COST-CENTER PIC X(4).
        10  WS-WK-END-DATE PIC 9(6).
        10  WS-TOTAL-HRS COMP-1.
	10  WS-COUNT PIC S9(10) COMP.
	10  WS-DETAIL-LINES OCCURS 10.
	    15  WS-ACTIV-CD PIC X(4).
	    15  WS-PL-NUM PIC X(4).
	    15  WS-DIS-NUM PIC 9(5) COMP.
	    15  WS-MFG-NUM PIC 9(5) COMP.
	    15  WS-HOURS COMP-1.
	    15  WS-OP-CD PIC X(4).

***** table of link status names **********************************************
01  NETWORK-LINK-STATUS-TABLE.
    05  NETLN-ENTRY OCCURS 4 TO 6 DEPENDING ON SUB2 INDEXED BY NETIDX.
	10  LINK-SYS-ORIG PIC S9(10) COMP.
*	system or origin of remote program, 1=DEC10/DEC20, 2=Vax
	10  NETLN PIC S9(10) COMP.
*	network logical name assigned by dit routine NFOPP.
	10  LINK-STATE PIC S9(10) COMP.
*	link state (see net-link-status below)  used to keep track  of
*	what each link  is doing, so  that more than  one link can  be
*	serviced at a time.
	10  LINK-BADGE-NUM PIC S9(7).
*	keep track of which badge number this link is interested in




***** table of link information ***********************************************
01  NET-LINK-STATUS.
*	link-state (above  contains the  relative state  of a  network
*	link at any given  time.  A list of  possible link states  and
*	their names is given below in the net-link-status table.
    05  UNOP PIC S9(10) COMP VALUE 0.
*	link is unopened, code is 0
    05  O-PASS PIC S9(10) COMP VALUE 1.
*	link is passive open, code is 1
    05  A-BDGORCLS PIC S9(10) COMP VALUE 2.
*	link is active open and  awaiting either a disconnect  request
*	or another badge number, code is 2
    05  A-ABORDAT PIC S9(10) COMP VALUE 3.
*	link is active open and awaiting either the remaining data  or
*	a request to quit and not update the record, code is 3
    05  A-WAIT PIC S9(10) COMP VALUE 4.
*	link is active open  and waiting for data  to be processed  by
*	the server, code is 4
    05  A-UNKN PIC S9(10) COMP VALUE 5.
*	link is active open and an unknown event has occured!, code is 5
    05  P-UNKN PIC S9(10) COMP VALUE 6.
*	link is passive open and an unknown event has occured!, code is 6
    05  A-ID PIC S9(10) COMP VALUE 7.
*	link is active open and waiting to be sent the id record

***** table of message values sent between server and remote ******************
01  MESSAGE-DATA-VALUES.
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



***** dil call return code parameters *****************************************

01  DILINI-PARAMETERS.
    05  DIL-INIT-STATUS PIC S9(9) COMP.
    05  DIL-STATUS PIC S9(9) COMP.
    05  DIL-SEVERITY PIC S9(9) COMP.
    05  DIL-MESSAGE PIC S9(9) COMP.

01  RET-NETLN PIC S9(10) COMP.

***** dil interface files *****************************************************

01  COPY-INTER-FILES.
    COPY DIL OF "SYS:DIL.LIB".
    COPY DIT OF "SYS:DIL.LIB".
    COPY DIX OF "SYS:DIL.LIB".

***** DCR call parameters*****************************************************

01  FFDS.
    05  RQ1-SRC-DSCR PIC S9(10) COMP OCCURS 3.
    05  RQ1-DST-DSCR PIC S9(10) COMP OCCURS 3.
    05  RQ2-SRC-DSCR PIC S9(10) COMP OCCURS 3.
    05  RQ2-DST-DSCR PIC S9(10) COMP OCCURS 3.
    05  BDG-SRC-DSCR PIC S9(10) COMP OCCURS 3.
    05  BDG-DST-DSCR PIC S9(10) COMP OCCURS 3.
    05  NAM-SRC-DSCR PIC S9(10) COMP OCCURS 3.
    05  NAM-DST-DSCR PIC S9(10) COMP OCCURS 3.
    05  CC-SRC-DSCR PIC S9(10) COMP OCCURS 3.
    05  CC-DST-DSCR PIC S9(10) COMP OCCURS 3.
    05  WK-SRC-DSCR PIC S9(10) COMP OCCURS 3.
    05  WK-DST-DSCR PIC S9(10) COMP OCCURS 3.
    05  TOT-SRC-DSCR PIC S9(10) COMP OCCURS 3.
    05  TOT-DST-DSCR PIC S9(10) COMP OCCURS 3.
    05  CNT-SRC-DSCR PIC S9(10) COMP OCCURS 3.
    05  CNT-DST-DSCR PIC S9(10) COMP OCCURS 3.
    05  DETAIL-LINE-FLD-FFDS OCCURS 10.
	10  ACT-SRC-DSCR PIC S9(10) COMP OCCURS 3.
	10  ACT-DST-DSCR PIC S9(10) COMP OCCURS 3.
	10  PLN-SRC-DSCR PIC S9(10) COMP OCCURS 3.
	10  PLN-DST-DSCR PIC S9(10) COMP OCCURS 3.
	10  DIS-SRC-DSCR PIC S9(10) COMP OCCURS 3.
	10  DIS-DST-DSCR PIC S9(10) COMP OCCURS 3.
	10  MNF-SRC-DSCR PIC S9(10) COMP OCCURS 3.
	10  MNF-DST-DSCR PIC S9(10) COMP OCCURS 3.
	10  HRS-SRC-DSCR PIC S9(10) COMP OCCURS 3.
	10  HRS-DST-DSCR PIC S9(10) COMP OCCURS 3.
	10  OPC-SRC-DSCR PIC S9(10) COMP OCCURS 3.
	10  OPC-DST-DSCR PIC S9(10) COMP OCCURS 3.

01  BYTE-SIZES.
    05  BYTSZ6 PIC S9(10) COMP VALUE 6.
    05  BYTSZ8 PIC S9(10) COMP VALUE 8.
    05  BYTSZ36 PIC S9(10) COMP VALUE 36.
01  SRC-BYO PIC S9(10) COMP.
01  DST-BYO PIC S9(10) COMP.
01  SRC-BIO PIC S9(10) COMP VALUE 0.
01  DST-BIO PIC S9(10) COMP VALUE 0.

***** dit call parameters *****************************************************

01  OBJID PIC X(16) VALUE "135" USAGE IS DISPLAY-7.
01  DESCR PIC X(16) VALUE SPACES USAGE IS DISPLAY-7.
01  TASKNAME PIC X(16) VALUE SPACES USAGE IS DISPLAY-7.
01  NUMOPCHAR PIC S9(10) COMP VALUE 0.
01  OPCHAR PIC X(16) VALUE SPACES USAGE IS DISPLAY-7.
01  MSG-BYTSIZ PIC S9(10) COMP.
01  MSGLEN PIC S9(10) COMP.
01  SYNCH-DISCONN PIC S9(10) COMP VALUE 0.
01  USER-ABORT-DISCONN PIC S9(10) COMP VALUE 9.
01  DISCONN-TYPE PIC S9(10) COMP.
01  WHEEL-CHK PIC S9(10) COMP.


***** flags, subscripts, ******************************************************

01  BDG-FLAG PIC S9(10) COMP.
01  BIT-REMAINDER PIC S9(10) COMP.

77  SUB PIC S9(5) COMP.
77  SUB2 PIC S9(5) COMP.
77  DL-SUB PIC S9(5) COMP.

*******************************************************************************

PROCEDURE DIVISION.

*******************************************************************************

THE-TOP SECTION.

SET-STUFF-UP.    

*	open a dummy file to fool RMS into working!

    OPEN OUTPUT DUMMY.
    CLOSE DUMMY.

    PERFORM SET-UP.

MAIN-STUFF.

    PERFORM KEEP-LINKS-OPEN.
    PERFORM WAIT-FOR-NETWORK-EVENT.
    PERFORM WHAT-HAPPENED.
*	done with event, go back and wait for the next event to occur
    GO TO MAIN-STUFF.

*******************************************************************************

SET-UP SECTION.

*******************************************************************************

CHECK-FOR-WHEEL.

*	if the process does not have wheel enabled then it can not
*	open more than 4 network links...  so check to see if wheel is
*	enabled and then set sub2 which is the number of links to open
*	(four for non-wheel and six for wheel).


    ENTER MACRO PROCES USING WHEEL-CHK.

    IF WHEEL-CHK = 1 SET SUB2 TO 6

    ELSE IF WHEEL-CHK = 0 SET SUB2 TO 4

	 ELSE DISPLAY "%Invalid return from wheel check subroutine. "
	      DISPLAY " Process halted"
	      STOP RUN.

SET-UP-DILINI.

*	set up dilini in order to have it intercept the status returns
*	for each of the various calls to dil routines

    ENTER MACRO DILINI USING DIL-INIT-STATUS, DIL-STATUS,
			     DIL-MESSAGE, DIL-SEVERITY.

    IF DIL-INIT-STATUS NOT = 1
	DISPLAY "%Invalid return from DILINI call. Process halted."
	STOP RUN.

SET-UP-FFDS.

*	if data comes  from a  vax, it will  have to  be converted  to
*	Tops-20 format...  make  the field  descriptors to  facilitate
*	the conversions

    PERFORM MAKE-FFDS THRU MFFDS-EXIT.

*******************************************************************************

MAIN SECTION.

*******************************************************************************

KEEP-LINKS-OPEN.

*	keep links open for connections from remote users

    PERFORM CHECK-ON-LINKS THRU CHECK-EXIT
	VARYING NETIDX FROM 1 BY 1 UNTIL NETIDX > SUB2.



CHECK-ON-LINKS.

*	this paragraph is called from the Main Section and is used  to
*	keep checking on the  state of all the  links.  if any of  the
*	links is unopened, then reopen it

    IF LINK-STATE(NETIDX) = UNOP PERFORM OPEN-ONE-PASSIVE-LINK THRU OPEN-EXIT.

CHECK-EXIT.


OPEN-ONE-PASSIVE-LINK.

*	this paragraph is called from the Check-On-Links paragraph  of
*	the Main Section.  if it is  discovered that a link is  closed
*	at any time  then come to  this paragraph and  open that  link
*	back up.

    ENTER MACRO NFOPP USING NETLN(NETIDX), OBJID, DESCR, TASKNAME, DIT-WAIT-NO.

CHECK-NFOPP-STATUS.

    IF DIL-SEVERITY = STS-K-SUCCESS
	DISPLAY " =>  Link " NETIDX " is open."
	MOVE O-PASS TO LINK-STATE(NETIDX)

    ELSE 
	PERFORM DIT-STAT-CHECK.

OPEN-EXIT.

WAIT-FOR-NETWORK-EVENT.

*	use dit  routine  nfgnd  to get  information  on  asynchronous
*	network events, wait for any network event to occur

    MOVE -1 TO RET-NETLN.
    ENTER MACRO NFGND USING RET-NETLN, DIT-WAIT-YES.



WHAT-HAPPENED.

*	when a network  event occurs, analyze  the status return  code
*	from nfgnd  to  find  out  what  happened,  then  perform  the
*	appropriate function

    IF DIL-MESSAGE = DIT-C-DATAEVENT 
	PERFORM WHICH-LINK THRU WHICH-EXIT VARYING SUB FROM 1 BY 1
					   UNTIL SUB > SUB2
	PERFORM PROCESS-DATA-EVENT THRU PD-EXIT

    ELSE
    IF DIL-MESSAGE = DIT-C-CONNECTEVENT
	PERFORM WHICH-LINK THRU WHICH-EXIT VARYING SUB FROM 1 BY 1
					   UNTIL SUB > SUB2
	PERFORM PROCESS-CONNECT THRU PC-EXIT

    ELSE
    IF DIL-MESSAGE = DIT-C-ABREJEVENT
	PERFORM WHICH-LINK THRU WHICH-EXIT VARYING SUB FROM 1 BY 1
					   UNTIL SUB > SUB2
	DISPLAY "?DIT$_ABREJEVENT:NFGND Link " NETIDX " aborted/rejected."
	DISPLAY "Link " NETIDX " will be closed..."
	MOVE USER-ABORT-DISCONN TO DISCONN-TYPE
	PERFORM CLOSE-LINK THRU CL-EXIT

    ELSE
    IF DIL-SEVERITY = STS-K-SUCCESS
*	this should not occur since we are 'waiting' in the call to nfgnd
	DISPLAY "STS-K-SUCCESS:NFGND No event occured.  Wait... "

    ELSE
	PERFORM DIT-STAT-CHECK.

*******************************************************************************

PROCESS-CONNECT SECTION.

*******************************************************************************

*	when a connect event has  occured the Main Section calls  this
*	section to process the  connect (accept a  link from a  remote
*	task)

    ENTER MACRO NFACC USING NETLN(NETIDX), DIT-LTYPE-BINARY, NUMOPCHAR, OPCHAR.

    IF DIL-SEVERITY = STS-K-SUCCESS
	display "  Link " netidx " is active."
	MOVE A-ID TO LINK-STATE(NETIDX)

    ELSE
	PERFORM DIT-STAT-CHECK.

PC-EXIT.

*******************************************************************************

PROCESS-DATA-EVENT SECTION.

*******************************************************************************

*	When a  data event  has occured  the Main  Section calls  this
*	section to process that  event.  Since there  are a number  of
*	different possible  data events,  first decide  which type  of
*	data event has  occured.  The Link-State  field holds a  value
*	which indicates the type of event  that is to be expected  for
*	the specified  link  at any  given  time.  Therefore  use  the
*	Link-State value to check which type of data event to  process
*	now.

    IF LINK-STATE(NETIDX) = A-ID
	PERFORM RECEIVE-ID-REC THRU R-ID-EXIT

    ELSE
	IF LINK-STATE(NETIDX) = A-BDGORCLS
	     PERFORM PROCESS-BDGORCLS THRU BDGORCLS-EXIT

	ELSE IF LINK-STATE(NETIDX) = A-ABORDAT
		   PERFORM PROCESS-ABORDAT THRU ABORDAT-EXIT.

PD-EXIT.

*******************************************************************************

RECEIVE-ID-REC SECTION.

*******************************************************************************

RECEIVE-ID.

*	receive a record  (in DEC-20 format)  from the remote  program
*	which will identify the remote system of origin as either  VAX
*	or 10/20.

    MOVE 36 TO MSG-BYTSIZ.
    MOVE 1 TO MSGLEN.
    ENTER MACRO NFRCV USING NETLN(NETIDX), MSG-BYTSIZ, MSGLEN, MESSAGE-DATA,
		     DIT-MSG-MSG, DIT-WAIT-YES.

    IF DIL-SEVERITY = STS-K-SUCCESS
	DISPLAY " NFRCV:INFO data receive was ok!"

    ELSE
	PERFORM DIT-STAT-CHECK.

*	determine whether the remote system is  a vax (code = 2) or  a
*	10/20 (code = 1)

CHECK-SYSTEM-OF-ORIGIN.

    IF MESSAGE-DATA = DIX-SYS-10-20 OR
       MESSAGE-DATA = DIX-SYS-VAX
	 MOVE MESSAGE-DATA TO LINK-SYS-ORIG(NETIDX)
	 MOVE A-BDGORCLS TO LINK-STATE(NETIDX)
    ELSE
	 DISPLAY " "
	 DISPLAY "%ERROR IN REMOTE SYSTEM CODE. PROCESS HALTED"
	     STOP RUN.

R-ID-EXIT.

*******************************************************************************

PROCESS-BDGORCLS SECTION.

*******************************************************************************

RECEIVE-BADGE-REC.

*	receive a record  in the remote  system's native format  which
*	contains either a badge number to be processed or a request to
*	disconnect the link because the remote task is through


    IF LINK-SYS-ORIG(NETIDX) = DIX-SYS-10-20
	PERFORM RECEIVE-10-20-BDG
    ELSE
	PERFORM RECEIVE-VAX-BDG.

CHECK-REQUEST-TYPE.

*	If reqtyp1 = 0 then process badge number.  If reqtyp1 = 1 then
*	the remote program is requesting a disconnect.  If  processing
*	of badge-num  is requested,  then save  the badge-num  in  the
*	Network-Link-Status-Table for further  use.  If disconnect  is
*	requested then close the link.

    IF REQTYP1 = 0 MOVE BADGE-NUM TO LINK-BADGE-NUM(NETIDX)

    ELSE IF REQTYP1 = 1 MOVE 0 TO LINK-BADGE-NUM(NETIDX)
			MOVE SYNCH-DISCONN TO DISCONN-TYPE
			PERFORM CLOSE-LINK THRU CL-EXIT
			GO TO BDGORCLS-EXIT

	 ELSE DISPLAY " "
	      DISPLAY "%Error in request from remote process. Process halted."
	      STOP RUN.

CHECK-BADGE-NUMBER.

*	search jt-fil for the record that corresponds to badge-num

    OPEN INPUT-OUTPUT JT-FIL.

    MOVE BADGE-NUM TO JT-BADGE-NUM.

    READ JT-FIL KEY IS JT-BADGE-NUM

*	if key was valid:

	INVALID KEY MOVE B-NOTEXIST TO MESSAGE-DATA
		    DISPLAY "INFO-JTSERV:B-NOTEXIST Badge number " badge-num " does not exist in file."
		    CLOSE JT-FIL
		    GO TO SEND-MESSAGE.


*	if key was valid:

    MOVE B-EXIST TO MESSAGE-DATA.
    DISPLAY "INFO-JTSERV:B-EXIST Badge number " badge-num " exists in file.".

    CLOSE JT-FIL.



SEND-MESSAGE.

*	Send the remote  task a message  indicating whether the  badge
*	number presently exists in the ISAM file or not.

*	The possibile values for the message are:
*		0 = badge # exists
*		1 = badge number does not exits

    MOVE 36 TO MSG-BYTSIZ.
    MOVE 1 TO MSGLEN.
    ENTER MACRO NFSND USING NETLN(NETIDX), MSG-BYTSIZ, MSGLEN,
			    MESSAGE-DATA, DIT-MSG-MSG.

    IF DIL-SEVERITY = STS-K-SUCCESS
	DISPLAY "INFO-NFSND: Message send successful on link " NETIDX

    ELSE
	PERFORM DIT-STAT-CHECK.

    MOVE A-ABORDAT TO LINK-STATE(NETIDX).

BDGORCLS-EXIT.

RECEIVE-10-20-BDG.

*	if the remote  system is  also a 10/20,  move the  information
*	directly into the badge-rec

    MOVE 36 TO MSG-BYTSIZ.
    MOVE 3 TO MSGLEN.
    ENTER MACRO NFRCV USING NETLN(NETIDX), MSG-BYTSIZ, MSGLEN,
			 BADGE-REC, DIT-MSG-MSG, DIT-WAIT-YES.

    IF DIL-SEVERITY = STS-K-SUCCESS
	DISPLAY " NFRCV:INFO data receive was ok!"

    ELSE
	PERFORM DIT-STAT-CHECK.

RECEIVE-VAX-BDG.

*	if the remote system is a VAX, then move the information  into
*	a hold area and  do data conversion, THEN  move the data  into
*	the badge-rec

    MOVE 8 TO MSG-BYTSIZ.
    MOVE 11 TO MSGLEN.
    ENTER MACRO NFRCV USING NETLN(NETIDX), MSG-BYTSIZ, MSGLEN,
			    BDGORCLS-REC, DIT-MSG-MSG, DIT-WAIT-YES.

    IF DIL-SEVERITY = STS-K-SUCCESS
	DISPLAY " NFRCV:INFO data receive was ok!"

    ELSE
	PERFORM DIT-STAT-CHECK.

    ENTER MACRO XCGEN USING RQ1-SRC-DSCR(1), RQ1-DST-DSCR(1).

    IF DIL-SEVERITY NOT = STS-K-SUCCESS
		PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.
	DISPLAY " Conversion of reqtyp1 is : " REQTYP1.

    ENTER MACRO XCGEN USING BDG-SRC-DSCR(1), BDG-DST-DSCR(1).

    IF DIL-SEVERITY NOT = STS-K-SUCCESS
		PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.
	DISPLAY " Conversion of badge-num is : " BADGE-NUM.


*******************************************************************************

PROCESS-ABORDAT SECTION.

*******************************************************************************

*	Receive a record  in the remote  system's native format  which
*	contains either job ticket data  to be processed or a  request
*	to discontinue the record  update process for this  particular
*	badge number (but NOT to close the link).
	
RECEIVE-DATA.

    IF LINK-SYS-ORIG(NETIDX) = DIX-SYS-10-20
	PERFORM RECEIVE-10-20-DATA
    ELSE
	PERFORM RECEIVE-VAX-DATA.

CHECK-REQUEST-TYPE.

*	NOTE: if reqtyp2 = 1 didn't want to continue with update
*       if reqtyp2 = 0 wanted to continue with update

    IF REQTYP2 = 1
	MOVE UPDA-ABORT TO MESSAGE-DATA
	GO TO SEND-STATUS-TO-REMOTE

    ELSE
	IF REQTYP2 = 0
		NEXT SENTENCE

	ELSE DISPLAY " "
	     DISPLAY "%ERROR IN REMOTE SYSTEM CODE. PROCESS HALTED"
		STOP RUN.



CONVERT-DATA-IF-NECESS.

*	if the data is from a vax, then convert it to DEC20 format

    IF LINK-SYS-ORIG(NETIDX) = DIX-SYS-VAX
	PERFORM CONVERT-VAX-DATA THRU CVD-EXIT.


UPDATE-DATA-FILE.

    MOVE SPACES TO JT-REC.

*	an update of the data file was requested by the remote program

*	now open the file to the correct record

    MOVE 0 TO BDG-FLAG.

    OPEN INPUT-OUTPUT JT-FIL.

    MOVE LINK-BADGE-NUM(NETIDX) TO JT-BADGE-NUM.

    READ JT-FIL KEY IS JT-BADGE-NUM
	INVALID KEY DISPLAY "INFO-JTSERV: Badge number not exist in file."
		    MOVE B-NOTEXIST TO BDG-FLAG.

*	first move the data from the ws-rec into the jt-rec

    MOVE WS-NAME TO JT-NAME.
    MOVE WS-COST-CENTER TO JT-COST-CENTER.
    MOVE WS-WK-END-DATE TO JT-WK-END-DATE.
    MOVE WS-TOTAL-HRS TO JT-TOTAL-HRS.
    PERFORM MOVE-DETAIL-LINES THRU MOVE-DL-EXIT
	VARYING DL-SUB FROM 1 BY 1 UNTIL DL-SUB > WS-COUNT.

*	now write or rewrite the record

    IF BDG-FLAG = B-EXIST 

	REWRITE JT-REC INVALID KEY DISPLAY "INVALID KEY ON REWRITE."
				   MOVE UPDA-ERR TO MESSAGE-DATA
				   GO TO CLOSE-FILE
    ELSE IF BDG-FLAG = B-NOTEXIST

	WRITE JT-REC INVALID KEY DISPLAY "INVALID KEY ON WRITE."
				 MOVE UPDA-ERR TO MESSAGE-DATA
				 GO TO CLOSE-FILE.

*	if update ok, move upda-ok value to message-data to be sent to
*	remote

    MOVE UPDA-OK TO MESSAGE-DATA.
    DISPLAY " Record written to RMS indexed file ok!! ".

CLOSE-FILE.

    CLOSE JT-FIL.

SEND-STATUS-TO-REMOTE.

*	send the  remote  program the  status  of the  update:  either
*	upda-abort, upda-ok, or upda-err

    MOVE 36 TO MSG-BYTSIZ.
    MOVE 1 TO MSGLEN.
    ENTER MACRO NFSND USING NETLN(NETIDX), MSG-BYTSIZ, MSGLEN,
			    MESSAGE-DATA, DIT-MSG-MSG.

    IF DIL-SEVERITY = STS-K-SUCCESS
	DISPLAY "INFO-NFSND: Message send successful on link " NETIDX

    ELSE
	PERFORM DIT-STAT-CHECK.

    MOVE A-BDGORCLS TO LINK-STATE(NETIDX).

ABORDAT-EXIT.

RECEIVE-10-20-DATA.

*	If the remote  system is  also a 10/20,  move the  information
*	directly into the data-rec.

    MOVE 36 TO MSG-BYTSIZ.
    MOVE 61 TO MSGLEN.
    ENTER MACRO NFRCV USING NETLN(NETIDX), MSG-BYTSIZ, MSGLEN,
			    DATA-RECORD, DIT-MSG-MSG, DIT-WAIT-YES.

    IF DIL-SEVERITY = STS-K-SUCCESS
	DISPLAY " NFRCV:INFO data receive was ok!"

    ELSE
	PERFORM DIT-STAT-CHECK.

RECEIVE-VAX-DATA.
	
*	If the remots system is a VAX, then move the information  into
*	a hold area and  do data conversion, THEN  move the data  into
*	the data-rec.

    MOVE 32 TO MSG-BYTSIZ.
    MOVE 73 TO MSGLEN.

    ENTER MACRO NFRCV USING NETLN(NETIDX), MSG-BYTSIZ, MSGLEN, REMOTE-DATA-REC,
		      DIT-MSG-MSG, DIT-WAIT-YES.

    IF DIL-SEVERITY = STS-K-SUCCESS
	DISPLAY " NFRCV:INFO data receive was ok!"

    ELSE
	PERFORM DIT-STAT-CHECK.

    ENTER MACRO XCGEN USING RQ2-SRC-DSCR(1), RQ2-DST-DSCR(1).

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.
	DISPLAY " Conversion of reqtyp2 is : " REQTYP2.



MOVE-DETAIL-LINES.

    MOVE WS-ACTIV-CD(DL-SUB) TO JT-ACTIV-CD(DL-SUB).
    MOVE WS-PL-NUM(DL-SUB) TO JT-PL-NUM(DL-SUB).
    MOVE WS-DIS-NUM(DL-SUB) TO JT-DIS-NUM(DL-SUB).
    MOVE WS-MFG-NUM(DL-SUB) TO JT-MFG-NUM(DL-SUB).
    MOVE WS-HOURS(DL-SUB) TO JT-HOURS(DL-SUB).
    MOVE WS-OP-CD(DL-SUB) TO JT-OP-CD(DL-SUB).

MOVE-DL-EXIT.

*******************************************************************************

CLOSE-LINK SECTION.

*******************************************************************************

*	This section is used to close  a link either when there is  an
*	abort/reject event or when a disconnect event is requested.

    ENTER MACRO NFCLS USING NETLN(NETIDX), DISCONN-TYPE, NUMOPCHAR, OPCHAR.

    IF DIL-SEVERITY = STS-K-SUCCESS
	DISPLAY "NFCLS:SUCCESS close successful."
	MOVE UNOP TO LINK-STATE(NETIDX)

    ELSE
    IF DIL-MESSAGE = DIT-C-ABORTREJECT
	DISPLAY "NFCLS:INFO ABRORTREJECT Link aborted before close done."

    ELSE
	PERFORM DIT-STAT-CHECK.

CL-EXIT.

*******************************************************************************

WHICH-LINK SECTION.

*******************************************************************************

*	this section is called from  various parts of the program  and
*	is  used   to   determine   which   link   of   the   in   the
*	network-link-status-table has had an event occur

    IF RET-NETLN = NETLN(SUB)
	SET NETIDX TO SUB
	MOVE 7 TO SUB.

WHICH-EXIT.

*******************************************************************************

CONVERT-VAX-DATA SECTION.

*******************************************************************************

CONVERT-NAME-FIELD.
*	convert name field

    ENTER MACRO XCGEN USING NAM-SRC-DSCR(1), NAM-DST-DSCR(1).

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.
	DISPLAY " Conversion of name is : " WS-NAME.

CONVERT-COST-CENTER-FLD.
*	convert cost center field

    ENTER MACRO XCGEN USING CC-SRC-DSCR(1), CC-DST-DSCR(1).

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.
	DISPLAY " Conversion of cost-center is : " WS-COST-CENTER.

CONVERT-WK-END-DT-FLD.
*	convert week ending date field

    ENTER MACRO XCGEN USING WK-SRC-DSCR(1), WK-DST-DSCR(1).

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.
	DISPLAY " Conversion of wk-end-date is : " WS-WK-END-DATE.

CONVERT-TOT-HRS-FLD.
*	convert total hours field

    ENTER MACRO XCGEN USING TOT-SRC-DSCR(1), TOT-DST-DSCR(1).

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.
	DISPLAY " Conversion of total-hrs is : " WS-TOTAL-HRS.

CONVERT-WS-COUNT.
*	convert count of projects field, ws-count = number of project
*	lines in record

    ENTER MACRO XCGEN USING CNT-SRC-DSCR(1), CNT-DST-DSCR(1).

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.
	DISPLAY " Conversion of ws-count is : " WS-COUNT.

    PERFORM CONVERT-DETAIL-LINES THROUGH CONV-EXIT
			VARYING DL-SUB FROM 1 BY 1 UNTIL DL-SUB > WS-COUNT.

CVD-EXIT.

CONVERT-DETAIL-LINES.

CONVERT-ACTIV-CD-FLD.
*	convert acitvity code field

    ENTER MACRO XCGEN USING ACT-SRC-DSCR(DL-SUB,1), ACT-DST-DSCR(DL-SUB,1).

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.
	DISPLAY " Conversion of activ-cd is : " WS-ACTIV-CD(DL-SUB).

CONVERT-PL-NUM-FLD.
*	convert product line number field

    ENTER MACRO XCGEN USING PLN-SRC-DSCR(DL-SUB,1), PLN-DST-DSCR(DL-SUB,1).

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.
	DISPLAY " Conversion of pl-num is : " WS-PL-NUM(DL-SUB).

CONVERT-DIS-NUM-FLD.
*	convert discrete number field

    ENTER MACRO XCGEN USING DIS-SRC-DSCR(DL-SUB,1), DIS-DST-DSCR(DL-SUB,1).

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.
	DISPLAY " Conversion of dis-num is : " WS-DIS-NUM(DL-SUB).

CONVERT-MANUF-NUM-FLD.
*	convert manufacturing number field

    ENTER MACRO XCGEN USING MNF-SRC-DSCR(DL-SUB,1), MNF-DST-DSCR(DL-SUB,1).

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.
	DISPLAY " Conversion of mfg-num is : " ws-mfg-num(dl-sub).

CONVERT-PROJ-HRS-FLD.
*	convert project hours field

    ENTER MACRO XCGEN USING HRS-SRC-DSCR(DL-SUB,1), HRS-DST-DSCR(DL-SUB,1).

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.
	DISPLAY " Conversion of hours is : " WS-HOURS(DL-SUB).

CONVERT-OP-CD-FLD.
*	convert operations code field

    ENTER MACRO XCGEN USING OPC-SRC-DSCR(DL-SUB,1), OPC-DST-DSCR(DL-SUB,1).

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.
	DISPLAY " Conversion of op-cd is : " WS-OP-CD(DL-SUB).

CONV-EXIT.

*******************************************************************************

MAKE-FFDS SECTION.

*******************************************************************************

*	make reqtyp1 field ffds

    ENTER MACRO XDESCR USING RQ1-SRC-DSCR(1), BDGORCLS-REC, DIX-SYS-VAX,
			BYTSZ8, 0, 0, DIX-DT-SBF32, 0, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

    ENTER MACRO XDESCR USING RQ1-DST-DSCR(1), REQTYP1, DIX-SYS-10-20,
			BYTSZ36, 0, 0, DIX-DT-SBF36, 0, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

*	make badge number field ffds

    ENTER MACRO XDESCR USING BDG-SRC-DSCR(1), BDGORCLS-REC, DIX-SYS-VAX,
			BYTSZ8, 4, 0, DIX-DT-ASCII-8, 7, 0,

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

    ENTER MACRO XDESCR USING BDG-DST-DSCR(1), BADGE-NUM, DIX-SYS-10-20,
			BYTSZ6, 0, 0, DIX-DT-SIXBIT, 7, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

*	make name field ffds

    ENTER MACRO XDESCR USING NAM-SRC-DSCR(1), REMOTE-DATA-REC, DIX-SYS-VAX,
			BYTSZ8, 4, 0, DIX-DT-ASCII-8, 30, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

    ENTER MACRO XDESCR USING NAM-DST-DSCR(1), DATA-RECORD, DIX-SYS-10-20,
			BYTSZ6, 6, 0, DIX-DT-SIXBIT, 30, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

*	make reqtyp2 field ffds

    ENTER MACRO XDESCR USING RQ2-SRC-DSCR(1), REMOTE-DATA-REC, DIX-SYS-VAX,
			BYTSZ8, 0, 0, DIX-DT-SBF32, 0, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

    ENTER MACRO XDESCR USING RQ2-DST-DSCR(1), REQTYP2, DIX-SYS-10-20,
			BYTSZ36, 0, 0, DIX-DT-SBF36, 0, 0

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

*	make cost center field ffds

    ENTER MACRO XDESCR USING CC-SRC-DSCR(1), REMOTE-DATA-REC, DIX-SYS-VAX,
			BYTSZ8, 34, 0, DIX-DT-ASCII-8, 4, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

    ENTER MACRO XDESCR USING CC-DST-DSCR(1), DATA-RECORD, DIX-SYS-10-20,
			BYTSZ6, 36, 0, DIX-DT-SIXBIT, 4, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

*	make week ending date field ffds

    ENTER MACRO XDESCR USING WK-SRC-DSCR(1), REMOTE-DATA-REC, DIX-SYS-VAX,
			BYTSZ8, 38, 0, DIX-DT-ASCII-8, 6, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

    ENTER MACRO XDESCR USING WK-DST-DSCR(1), DATA-RECORD, DIX-SYS-10-20,
			BYTSZ6, 40, 0, DIX-DT-SIXBIT, 6, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

*	make total hours field ffds

    ENTER MACRO XDESCR USING TOT-SRC-DSCR(1), REMOTE-DATA-REC, DIX-SYS-VAX,
			BYTSZ8, 44, 0, DIX-DT-F-FLOAT, 0, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

    ENTER MACRO XDESCR USING TOT-DST-DSCR(1), DATA-RECORD, DIX-SYS-10-20,
			BYTSZ36, 8, 0, DIX-DT-FLOAT-36, 0, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

*	make count (of projects) field ffds

    ENTER MACRO XDESCR USING CNT-SRC-DSCR(1), REMOTE-DATA-REC, DIX-SYS-VAX,
			BYTSZ8, 48, 0, DIX-DT-SBF32, 0, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

    ENTER MACRO XDESCR USING CNT-DST-DSCR(1), DATA-RECORD, DIX-SYS-10-20,
			BYTSZ36, 9, 0, DIX-DT-SBF36, 0, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

    MOVE 48 TO SRC-BYO.
    MOVE 56 TO DST-BYO.
    PERFORM MAKE-DETAIL-LINES-FFDS THRU MDLFFDS-EXIT
		VARYING DL-SUB FROM 1 BY 1 UNTIL DL-SUB > 10.

MFFDS-EXIT.

MAKE-DETAIL-LINES-FFDS.

*	make activity code field ffds

    ADD +4 TO SRC-BYO.
    ENTER MACRO XDESCR USING ACT-SRC-DSCR(DL-SUB,1), REMOTE-DATA-REC,
			DIX-SYS-VAX, BYTSZ8, SRC-BYO, 0, DIX-DT-ASCII-8, 4, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

    ADD +4 TO DST-BYO.
    ENTER MACRO XDESCR USING ACT-DST-DSCR(DL-SUB,1), DATA-RECORD,
			DIX-SYS-10-20, BYTSZ6, DST-BYO, 0, DIX-DT-SIXBIT, 4, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

*	make product line number field ffds

    ADD +4 TO SRC-BYO.
    ENTER MACRO XDESCR USING PLN-SRC-DSCR(DL-SUB,1), REMOTE-DATA-REC,
			DIX-SYS-VAX, BYTSZ8, SRC-BYO, 0, DIX-DT-ASCII-8, 4, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

    ADD +4 TO DST-BYO.
    ENTER MACRO XDESCR USING PLN-DST-DSCR(DL-SUB,1), DATA-RECORD,
			DIX-SYS-10-20, BYTSZ6, DST-BYO, 0, DIX-DT-SIXBIT, 4, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

*	make discrete number field ffds

    ADD +4 TO SRC-BYO.
    ENTER MACRO XDESCR USING DIS-SRC-DSCR(DL-SUB,1), REMOTE-DATA-REC,
			DIX-SYS-VAX, BYTSZ8, SRC-BYO, 0, DIX-DT-SBF32, 0, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

    ADD +4 TO DST-BYO.
    DIVIDE DST-BYO BY 6 GIVING DST-BYO REMAINDER BIT-REMAINDER.
    IF BIT-REMAINDER > 0 ADD +1 TO DST-BYO.
    ENTER MACRO XDESCR USING DIS-DST-DSCR(DL-SUB,1), DATA-RECORD,
			DIX-SYS-10-20, BYTSZ36, DST-BYO, 0, DIX-DT-SBF36, 0, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

*	make manufacturing number field ffds

    ADD +4 TO SRC-BYO.
    ENTER MACRO XDESCR USING MNF-SRC-DSCR(DL-SUB,1), REMOTE-DATA-REC,
			DIX-SYS-VAX, BYTSZ8, SRC-BYO, 0, DIX-DT-SBF32, 0, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

    ADD +1 TO DST-BYO.
    ENTER MACRO XDESCR USING MNF-DST-DSCR(DL-SUB,1), DATA-RECORD,
			DIX-SYS-10-20, BYTSZ36, DST-BYO, 0, DIX-DT-SBF36, 0, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

*	make project hours field ffds

    ADD +4 TO SRC-BYO.
    ENTER MACRO XDESCR USING HRS-SRC-DSCR(DL-SUB,1), REMOTE-DATA-REC,
			DIX-SYS-VAX, BYTSZ8, SRC-BYO, 0, DIX-DT-F-FLOAT, 0, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

    ADD +1 TO DST-BYO.
    ENTER MACRO XDESCR USING HRS-DST-DSCR(DL-SUB,1), DATA-RECORD,
			DIX-SYS-10-20, BYTSZ36, DST-BYO, 0, DIX-DT-FLOAT-36, 0, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

*	make operations code field ffds

    ADD +4 TO SRC-BYO.
    ENTER MACRO XDESCR USING OPC-SRC-DSCR(DL-SUB,1), REMOTE-DATA-REC,
			DIX-SYS-VAX, BYTSZ8, SRC-BYO, 0, DIX-DT-ASCII-8, 4, 0.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

    ADD +1 TO DST-BYO.
    MULTIPLY DST-BYO BY 6 GIVING DST-BYO.
    ENTER MACRO XDESCR USING OPC-DST-DSCR(DL-SUB,1), DATA-RECORD,
			DIX-SYS-10-20, BYTSZ6, DST-BYO, 0, DIX-DT-SIXBIT, 4, 0.
    ADD +2 TO DST-BYO.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE
    ELSE PERFORM DCR-STATUS-CHECK THRU DCR-STATUS-EXIT.

MDLFFDS-EXIT.

*******************************************************************************

DCR-STATUS-CHECK SECTION.

*******************************************************************************

*	This section is performed  whenever a call  is made to  XDESCR
*	and XCGEN  (the  data conversion  routines).   It is  used  to
*	determine the status returned from the attempted conversion.

    IF DIL-SEVERITY = STS-K-SUCCESS NEXT SENTENCE

    ELSE
	 IF DIL-SEVERITY = STS-K-INFO
		PERFORM DCR-INFO-RET-CHECK THRU CI-EXIT

	 ELSE PERFORM DCR-ERROR-RET-CHECK THRU CE-EXIT.

DCR-STATUS-EXIT.



DCR-INFO-RET-CHECK.

    IF DIL-MESSAGE = DIX-C-ROUNDED
		DISPLAY "DCR:STS$K_INFO Result is rounded."

    ELSE
	 IF DIL-MESSAGE = DIX-C-TRUNC
	      DISPLAY "DCR:STS$K_INFO String too long for destination--truncated.".

CI-EXIT.

DCR-ERROR-RET-CHECK.

    IF DIL-MESSAGE = DIX-C-TOOBIG
	DISPLAY "DCR:STS$K_SEVERE Converted source field too large for destination field"

    ELSE
    IF DIL-MESSAGE = DIX-C-INVDATTYP 
	DISPLAY "DCR:STS$K_SEVERE Invalid data type."

    ELSE
    IF DIL-MESSAGE = DIX-C-UNKARGTYP
	DISPLAY "DCR:STS$K_SEVERE Argument passed by descriptor is unknown type."

    ELSE
    IF DIL-MESSAGE = DIX-C-UNKSYS
	DISPLAY "DCR:STS$K_SEVERE Unknown system of origin specified."

    ELSE
    IF DIL-MESSAGE = DIX-C-INVLNG
	DISPLAY "DCR:STS$K_SEVERE Scale factor invalid or unspecified."

    ELSE
    IF DIL-MESSAGE = DIX-C-INVSCAL
	DISPLAY "DCR:STS$K_SEVERE Scale factor invalid or unspecified."

    ELSE
    IF DIL-MESSAGE = DIX-C-GRAPHIC
	DISPLAY "DCR:STS$K_WARNING Graphic charater changed in conversion"

    ELSE
    IF DIL-MESSAGE = DIX-C-FMTLOST
	DISPLAY "DCR:STS$K_WARNING Format effector gained or lost in conversion."

    ELSE
    IF DIL-MESSAGE = DIX-C-NONPRINT
	DISPLAY "DCR:STS$K_WARNING Non-printing character gained or lost in conversion."

    ELSE
    IF DIL-MESSAGE = DIX-C-UNIMP
	DISPLAY "DCR:STS$K_SEVERE Unimplemented conversion."

    ELSE
    IF DIL-MESSAGE = DIX-C-INVALCHAR
	DISPLAY "DCR:STS$K_ERROR Invalid character in source field or conversion table."

    ELSE
    IF DIL-MESSAGE = DIX-C-ALIGN
	DISPLAY "DCR:STS$K_SEVERE Invalid alignment for data type."

    ELSE
    IF DIL-MESSAGE = DIX-C-UNNORM
	DISPLAY "DCR:STS$K_SEVERE Floating point number improperly normalized."

    ELSE
    IF DIL-MESSAGE = DIX-C-IMPOSSIBLE
	DISPLAY "DCR:STS$K_SEVERE Total internal fuckup."

    ELSE
    IF DIL-MESSAGE = DIX-C-UNSIGNED
	DISPLAY "DCR:STS$K_ERROR Negative value moved to unsigned field."

    ELSE
    IF DIL-MESSAGE = DIX-C-INVBYTSIZ
	DISPLAY "DCR:STS$K_SEVERE Invalid byte size specified."

    ELSE DISPLAY "DCR:STS$K_SEVERE Unrecognized message code returned.".

    DISPLAY "%Process halted due to severity of error return".

    DISPLAY "  Dil-Status was: " DIL-STATUS.
    DISPLAY "  Dil-Message was: " DIL-MESSAGE.
    DISPLAY "  Dil-Severity was: " DIL-SEVERITY.
    STOP RUN.

CE-EXIT.
	     
*******************************************************************************

DIT-STAT-CHECK SECTION.

*******************************************************************************

*	This section is performed  whenever a call is  made to one  of
*	the DIT routines  and an erroneous  status code was  returned.
*	It is used to determine the error returned from the routine.

    IF DIL-MESSAGE = DIT-C-OVERRUN
	DISPLAY "?DIT$_OVERRUN: Data overrun."

    ELSE
    IF DIL-MESSAGE = DIT-C-INVARG
	DISPLAY "%DIT$_INVARG: Invalid arguement.  Process halted."
	STOP RUN

    ELSE
    IF DIL-MESSAGE = DIT-C-HORRIBLE
	DISPLAY "%DIT$_HORRIBLE: Jsys Error.  Process halted."
	STOP RUN

    ELSE
    IF DIL-MESSAGE = DIT-C-ABORTREJECT
	DISPLAY "%DIT$_ABORTREJECT: Link abort/reject.  Process halted."
	STOP RUN

    ELSE
    IF DIL-MESSAGE = DIT-C-INTERRUPT
	DISPLAY "%DIT$_INTERRUPT: Not supported and should not occur"
	DISPLAY "  Process Halted."
	STOP RUN

    ELSE
    IF DIL-MESSAGE = DIT-C-NOTENOUGH
	DISPLAY "%DIT$_NOTENOUGH: Required amt of data not available."
	DISPLAY "  Process Halted."
	STOP RUN

    ELSE
    IF DIL-MESSAGE = DIT-C-TOOMANY
	DISPLAY "%DIT$_TOOMANY: Too many link/no more interrupt channels"
	STOP RUN

    ELSE
    IF DIL-MESSAGE = DIT-C-INTDATAEVENT
	DISPLAY "%DIT$_INTDATAEVENT: Not supported and should not occur."
	DISPLAY "   Process Halted."
	STOP RUN

    ELSE
	DISPLAY "%DIT: Invalid or unexpected status return code. "
	DISPLAY "%Process Halted."
	STOP RUN.
 
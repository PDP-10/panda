@Make(tekrpt)

@string(reportdate="May 8 1986")
@string(number="12")

@define(list=itemize,spread 0.6)
@modify(hd2, font titlefont2, facecode b, pagebreak before, below 0.4 inch)
@modify(hd2a, font titlefont2, facecode b, pagebreak before, below 0.4 inch)
@modify(hd3, font titlefont1, facecode b)
@modify(hd4, font titlefont1, facecode b)
@specialfont(f1="tmfixd")
@begin(titlepage)
@mast1()
@ReportTitle(@Majorheading(Wesleyan Mail Service Programs))
@Begin(Credit)
@>@P(Report No.:  )@\@Value(number)
@>@P(Author:      )@\Joseph G. Deck
@>@p(Date:        )@\@value(reportdate)
@End(Credit)
@copyrite()
@mast2()
@end(titlepage)

@section(Overview)

	The motivation behind writing a mail system for the VAX began
with a need at Wesleyan to provide a mail service between DECSYSTEM
2060s which are Etherneted to a VAX and the Bitnet network which is also
connected to the VAX.  	In essence we needed a gateway between the Bitnet 
network which uses RSCS protocol and our local area network which 
uses TCP/IP protocol.  

	We wanted a means to transfer mail messages back and
forth between the Bitnet network, local users on the VAX and the other
hosts on the local area network.  The primary goal was to design a mail
system that would be simple to develop and operate. 

	In light of this the mail system was broken down into 
four independent programs.  The programs include: SMTPFORK, BSMTPFORK,
MM, and MAISER.  

	SMTPFORK operates as an SMTP server to the local area network.
The server is activated by the network process TCPACP.  SMTPFORK accepts
mail messages sent from another host on the LAN and writes the mail
message to a file in a directory pointed to by the logical name
SYS$MAILQ:.

	BSMTPFORK operates as a detached process.  The process wakes
itself from hibernation on a regular basis and scans for incoming bitnet 
files for the local bitnet host/gateway.  On finding any files it will 
transfer them to the directory pointed to by SYS$MAILQ:.

	MM is the user interface for the local host.  Mail messages for
a local user are written to the users login directory to a file called 
MAIL.TXT.  Messages sent from a local user are written to the directory 
pointed to by SYS$MAILQ:.

	MAISER is run by SMTPFORK, BSMTPFORK, or MM
after they have written a message to SYS$MAILQ:.  Maiser can also be run
as either a detached process or in batch.  When run it scans for files 
in the directory pointed to by SYS$MAILQ:.  On finding any files it 
determines if they are for a local user, a remote network (Bitnet, 
Arpanet, Csnet, etc) user, or a user on the LAN.  It then formats and 
transfers the message to the appropriate destination.

@section(Message Servers smtp/bsmtp)

	The two server programs SMTPFORK and BSMTPFORK share many common 
routines, since BSMTP protocol (Alan Crosswell) is a superset of SMTP protocol 
(RFC821).  The primary difference is that BSMTP was developed to process
batch mail files while SMTP was developed to process interactive mail 
messages.  BSMTP, therefore has two extra commands and a few extra 
routines to handle error replies.  

	Since SMTPFORK and BSMTPFORK are similar they 
were written to share two common libraries: MAIL and SMTP_BSMTP.
The use of these two libraries has also made it simple to add new
SMTP_BSMTP servers for other network protocols (Decnet for example).

@subsection(Smtpfork)

	SMTPFORK was written following the RFC821 standard.  It supports
the commands:	HELP, HELO, MAIL, SEND, NOOP, SOML, SAML, RCPT, DATA, QUIT.
The routines that execute these commands as well as the command parser
routine are in the library SMTP_BSMTP.  

	The routines that are in the module SMTPFORK are the Tektronix 
specific TCP/IP routines.  These routines include: START, RMAIN, OPNP,
INFO, SND, GETCMD, READ, and CLOSE.  

@paragraph(Start)

	The start routine opens a file which logs the SMTP dialogue, maps
the DOMAINS.TXT file into memory and calls the main loop of the program (RMAIN).
Upon returning from the main loop start closes and deletes the log file and
exits.  (The DOMAINS.TXT file will be discussed later.)

@paragraph(Rmain)

	RMAIN is the main loop of the program.  RMAIN clears flags, then calls
OPNP, INFO, and SETUP.  It then loops calling GETCMD followed by PARSE.  
This loop is exited by receiving the QUIT command.  (The PARSE and SETUP
routines are in the library SMTP_BSMTP.)

@paragraph(Opnp)

	OPNP opens a passive TCP/IP connection to a remote host on the LAN.

@paragraph(Info)

	INFO gets information on who opened the active side of the connection.

@paragraph(Snd)

	The SND routine sends data to the TCP/IP connection.  It 
also writes data sent to a log file.

@paragraph(Getcmd)

	GETCMD repeatedly calls the read routine filling a buffer until 
it reaches the maximum size of the buffer or a carriage return is received.

@paragraph(Read)

	READ gets data from the TCP/IP connection and removes any parity.
It then writes the data to a log file.

@paragraph(Close)

	CLOSE closes the TCP/IP connection.  This is currently broken.  If
anyone knows how to do this in assembly language, please let me know!

@subsection(Bsmtpfork)

	BSMTPFORK is more complex than SMTPFORK for two reasons.  First,
while the standard for bitnet mail messages is BSMTP and RFC822 most Bitnet
hosts are currently supporting only RFC822 headers.  Therefore, BSMTPFORK was
written to handle (BSMTP and RFC822) and (RFC822 without BSMTP).  The second 
reason that BSMTPFORK is complex is that a good algorithm to deliver mail 
using only RFC822 headers does not exist.

	No standard exists which specifies how to use RFC822 mail haeders
to process mail.  There are six RFC822 mail recpient haeders: To, Cc, Bcc, 
Resent-to, Resent-cc, and Resent-bcc.  All of these headers can appear in a 
mail message and all each header can contain multiple addresses.  Should each
host that receives a mail message with multiple addresses pass the message
on to all the destinations, only local addresses, or only known addresses?
This problem is resolved by SMTP/BSMTP formats, in that all recpients
in the dialogue should receive a copy of the message.  The RFC822 standard,
however, does not have this requirment.


	The routines that are in the module BSMTPFORK are the equivalent
routines found in the SMTPFORK module plus routines to parse RFC822 headers.  
These routines include: START, RMAIN, OPNP, INFO, READ, GETCMD, SND, CLOSE,
RVERB, RTICK, CHKERR, RFC822, CHKRFC, POSTMAN, GETRCPT, GETSNDR, and GETHDR.

	The routines START, RMAIN, OPNP, INFO, READ, GETCMD, SND, and CLOSE
perform the same functions that are described for these routines in the
SMTPFORK module.  They differ in that instead of opening a TCP/IP connection
they read from files.  The input files are in EBCDIC and are
translated to ASCII.  

	Additionally, the routine start checks the RSCS message id for the
name MAILER (registered mail name).  If the message id is not MAILER the
file is not processed for BSMTP but for RFC822 headers.  
Just prior to exiting the routine CHKERR is called to deal errors that occurred
during the BSMTP dialogue.

@paragraph(Rverb)

	RVERB is a BSMTP routine which sets the error messages to be 
either verbose or nonverbose.

@paragraph(Rtick)

	RTICK is a BSMTP routine which accepts and returns a unique identifier 
for the message being handled.

@paragraph(Chkerr)

	The CHKERR routine checks to see if any errors were generated 
during the BSMTP dialogue.  If so, the log of
of the transaction along with any additional error messages is written
to a mail file in SYS$MAILQ:.  The address of the recipient is the sender
of the original mail message which contained the errors.

@paragraph(Rfc822)

	RFC822 is the routine that is called when the mail message being
processed has been determined that it is not a BSMTP format message.
	The routine first converts the message from EBCDIC to ASCII.  Next it
calls GETHDR and CHKRFC which scans the message for a valid RFC822 
recipient header.  These headers include: To, Cc, Bcc, Resent-to, 
Resent-cc, and Resent-bcc.  If one of these headers can not be found the
message is sent to the local address POSTMASTER by the routine POSTMAN.

	When a valid RFC822 recipient header is found the first address in
the line is parsed and validitated.  If the address is not valid
then GETHDR and CHKRFC are called to scan for the next header.

@paragraph(Chkrfc)

	This routine parses a buffer for a valid RFC822 header.

@paragraph(Postman)

	This routine sends the current mail message (including error messages)
to the local address POSTMASTER.  The routine is functional but not complete.

@paragraph(Getrcpt)

	This routine is called by POSTMAN and parses an address passed
to it.
	
@paragraph(Getsndr)

	GETSNDR gets the local postmasters address and is called by POSTMAN.

@paragraph(Gethdr)

	GETHDR reads a line from the file being processed and returns 
it to its caller.  This routine should unfold RFC822 headers, but does not 
currently do this.

@section(Message Delivery)

	The message servers (SMTPFORK and BSMTPFORK) and user interface (MM)
write their mail messages to the directory pointed to by SYS$MAILQ:.  
MAISER is the sole program which reads mail files in SYS$MAILQ: directory.

	MAISER is run by SMTPFORK, BSMTPFORK, or MM
after they have written a message to SYS$MAILQ:.  Maiser can also be run
as either a detached process or in batch.  

@subsection (Maiser)

	After finding a file in SYS$MAILQ:, MAISER determines where to 
deliver the file (to a local user, user on the LAN, or a user on 
another network).  If a message can not be delivered for some reason, 
the file is either renamed in the directory to indicate that it can 
not be delivered, the mail message is returned to the sender explaining
the problem or the message is left unchanged to be delivered at a later
time.

	Routines in MAISER include: START, CHKWHR, SNDBIT, RETOLD, WRTBIT,
WRTLCL, SNDLCL, NOTUSR, DELFIL, RETMAIL, CHKRPLY, SNDTCP, SQUIT, SDATA,
SRCPT, SMAIL, GETBAN, SHELO, PARFIL, OPNA, SND, READ, STOP, CLOSE, BADFILE,
W1RETMSG, W1COPY, W1TIME, and VALADD.

@paragraph(Start)

	The routine start is the main loop of MAISER.  Start first gets
the local host and domain name.  It then creates a log file.  

	Then it picks up the files in SYS$MAILQ: one at a time and 
attempts to deliver them to their proper destination.  It does this by
calling the routines: PARFIL, RETOLD, and CHKWHR.

@paragraph(Chkwhr)

	The CHKWHR routine begins by isolating the recpients' host and
domain name.  Next it compares this against the local names.  If 
it matches it jumps to the SNDLCL routine.

	If the domain name matched but not the host name then it is for the
local area network and control is passed to the SNDTCP routine.

	If the recipients domain name did not match the local domain then
the recipients domain name is compared against the bitnet domain name.  If
they match the control is passed to the SNDBIT routine.  

	If one of the above three conditions did not occur then the mail 
can not be delivered and the file is renamed to be BAD_MAIL.TXT in SYS$MAILQ:.

@paragraph(Sndbit)

	The SNDBIT routine calls mapfil to map the DOMAINS.TXT file 
into memory.  Next it attempts to validate the bitnet address.  If
successful it calls WRTBIT to send the message.  If not it returns the
mail to the sender by calling RETMAIL.  

	If WRTBIT is called and is successful the mail message is deleted
from the SYS$MAILQ: directory.

@paragraph(Retold)

	RETOLD is not currently implemented.

@paragraph(Wrtbit)

	WRTBIT writes the current mail message to a temporary file, builds
a RSCS command to send the file to the appropriate destination and executes
the command.

@paragraph(Wrtlcl)

	WRTLCL writes the current mail message to a temporary file, and
computes the size of the mail message.  It then opens the users' MAIL.TXT
file and counts the number of messages in the file.  Next it appends
a fixed length control record to the file.

	The control record is 250 bytes in length with the following
format.  The first byte of the record is a control L character.
The next word is the number of the message in the MAIL.TXT file.  The next
long word is the length of the message.  The next six bytes are flags.  The
5 bytes following the flags are reserved.  Starting at byte 19 are the
keywords provided by the user to describe the message.  This storage
ends at byte 226.  Starting at byte 226 is the date/time the message was
delivered to the user.  Byte 250 contains a control L character.

	The actual message now in the temporary file is appended to the
MAIL.TXT file following the control record.  The temporary file is then 
deleted.  

	NOTE:  A message can not be delivered to a local user while that 
user has the MAIL.TXT file open.

	NOTE:  This is the only routine that would need to be replaced
should someone want to interface with the "standard" VMS mail system.

@paragraph(Sndlcl)

	Sndlcl validates the user is local by calling vallcl (MAIL library).
If the user is local getdir is called to point to his/her MAIL.TXT file
in his/her login directory.  WRTLCL is called to actual deliver the message.
If WRTLCL is successful NOTUSR is called and the file in SYS$MAILQ: 
is deleted.  

@paragraph(Notusr)

	NOTUSR sends a message to the local users terminal indicating a 
mail message has been delivered.

@paragraph(Delfil)

	DELFIL deletes the current file being processed in SYS$MAILQ:.

@paragraph(Retmail)

	RETMAIL creates a mail message for the original sender of a mail
message that can not be delivered.  The mail message contains the error
and the original message.  RETMAIL calls WHDR.

@paragraph(Chkrply)

	CHKRPLY checks the response from a foreign TCP/IP SMTP server.

@paragraph(Sndtcp)

	SNDTCP initiates an SMTP dialogue with a foreign host on the LAN.
SNDTCP calls: OPNA, GETBAN, SHELO, SMAIL, SRCPT, SDATA, SQUIT, and CLOSE.
RETMAIL is called if an error occurs in the dialogue and DELFIL is called
if no error occurs.

@paragraph(Squit)

	Sends a SMTP quit command.

@paragraph(Sdata)

	Sends a SMTP data command, data (the message), and a data
terminating sequence.

@paragraph(Srcpt)

	Sends the recipients of the mail message in SMTP format.

@paragraph(Smail)

	Sends the SMTP mail command.

@paragraph(Getban)

	GETBAN gets the welcome banner from the foreign host.

@paragraph(Shelo)

	SHELO sends the SMTP helo command.

@paragraph(Parfil)

	PARFIL reads the local mail headers written by WHDR.
They are Delivery option, notify date-time, dequeue-time, 
and Recipient.  The dequeue-time code is incomplete at this time.  This
code will return a mail message to the sender if it can not be delivered
for three days.

@paragraph(Opna)

	OPNA opens an active TCP/IP connection.

@paragraph(Snd)

	SND sends a buffer to a TCP/IP connection.

@paragraph(Read)

	READ reads from a specified TCP/IP host.  It removes any
parity from the data and terminates on receiving a carriage return.

@paragraph(Stop)

	STOP sends an SMTP quit command and closes the TCP/IP connection.

@paragraph(Close)

	CLOSE closes the TCP/IP connection.  Not really.

@paragraph(Badfile)

	BADFILE renames the current mail file in SYS$MAILQ: to be
SYS$MAILQ:BAD_FILE.TXT.

@paragraph(W1retmsg, W1copy, W1time, Valadd)

	These routines are used in logging MAISER activity.

@paragraph(Valadd)

	The VALADD routines performs a similar function to the VALADD
routine in the MAIL library.  The difference is that the routine in the MAIL
library attempts to parse and validate the address for the last host.domain while
this routine expects only one host.domain in the address.
	These differences should be resolved and this routine should be 
removed.

@section(Libraries)

	The three object libraries currently used in the mail system,
are MAIL, SMTP_BSMTP, and parse.  MAIL is a library that is used by all
programs in the mail service.  SMTP_BSMTP is used by SMTP/BSMTP servers.  
Finally, the library PARSE is used by the user interface program MM.

@subsection(Mail Library)

	The library module MAIL is used by all programs in the mail system.
This module contains the routines to validate the address of local users,
known hosts (message relay), and known gateways (message relay).  This module
also contains the routines to write to the directory SYS$MAILQ: and the
routines to determine the required format of a known host or relay.

	This module contains the routines: RPATH, CHKADD, VALLCL, VALADD,
ADDLCL, ADDREM, TMOG, GETADD, SLEEP, UCASE, MAPFIL, GETLCL, GETDIR,
P.KWN, P.RLY, P.LCL, WFILE, CHKFMT, SPFMT, WHDR, WDAT, FLDHDR, TSTMP,
and CHKRFC.

@paragraph(rpath)

	This routine builds a return path with the address passed to it.

@paragraph(chkadd)

	The CHKADD routine take a forward path passed to it and attempts
to validate the address and saves the address if it is valid.  There are
three types of addresses possible.

	If there is only one host.domain in the address it
is checked to see if it is the local host.domain.  If it is,
vallcl is called to check the username.  If the host.domain 
is not local the host must be either a known host or the domain must be
a known domain.  To check this valadd is called.

	If the address contains multiple hosts then the message is being
sent to a relay. In this case the address can be in one of two forms.  

	The first is what RFC821 specifies, 
@@myhost.mydomain,@@relay-address:mailbox.  The second is what everyone uses, 
mailbox%relay-address@@myhost.mydomain.

	Both addresses can be handled by this routine.  The addresses are 
parsed and validated by calling the routines GETADD and VALADD.

	All valid addresses regardless of the above form are added to one of
three linked lists.  There is one linked list for mail being sent locally,
one for mail being sent to a known host, and one for mail being sent to a
known domain.  The routine ADDREM is called to do this.

@paragraph(vallcl)

	The routine VALLCL opens the file SYS$SYSTEM:SYSUAF.DAT and searches
for the username passed to it and return a success or error code.	

@paragraph(valadd)

	VALADD attempts to validate the address passed to it.  After
isolating the host.domain in the address passed it searches the DOMAIN.TXT
file for a known host.  The format for this is HOST HOST_NAME.DOMAIN_NAME.
If a known host is not found it searches the domain.txt file for a gateway.
The format for this is DOMAIN DOMAIN_NAME.

	If the search for either a host or gateway was successful a 
success code is returned.  A flag is set indicating whether a host 
or domain was found.

	NOTE:  See the appendix for a sample hosts.txt file and a sample
domains.txt file.

@paragraph(addlcl)

	This routine add a username to the linked list of mail to
be locally delivered.

@paragraph(addrem)

	This routine first determines if the address passed to it
is for a known host or for a known gateway (relay).  If the address
is for a known host the address is added to a linked list for known
hosts.  If the address is for a gateway the address is added to a linked 
list for gateways.  The format for these  lists are: a master_list 
containing only one copy of each host or gateway.  Each host or
gateway in this list is the start of a listed list of addresses for that
host or gateway.

@paragraph(tmog)

	This routine transmogrifies an address.  It exchanges the last
% in an address for a @@.

@paragraph(getadd)

	This routine pulls the last address off of a complex address 
passed to it.

@paragraph(sleep)

	This routine sets a wake up time and then has the process hibernate.

@paragraph(ucase)

	This routine uppercases the buffer passed to it.

@paragraph(mapfil)

	This routine creates and maps the file DOMAINS.TXT into memory.  
If the file is already mapped into memory, it just provides access to it.

@paragraph(getlcl)

	This routine retrieves the local host and domain name from the
HOST.TXT file.  NOTE: The field used normally for node_name (a description
of the host) is used as a domain name field.  This was done because Wesleyan,
being a gateway, MUST have a domain name to route messages properly.

@paragraph(getdir)

	This builds a pointer to a users login directory from the 
information gathered in the buffer passed to it.  This is used to point
to login_structure:<login_directory>MAIL.TXT.1 .

@paragraph(wfile)

	This routine creates the file in the directory SYS$MAILQ:.
WFILE calls the routines TSTMP, RPATH, P.LCL, P.KWN, and P.RLY.

@paragraph(p.kwn)

	The P.KWN scans the linked list of known hosts and calls the
routines to create mail files in the directory SYS$MAILQ: for each
address.  Routines called include: CHKFMT, WHDR, SPFMT, WDAT.

@paragraph(p.rly)

	The P.RLY scans the linked list of known gateways and calls the
routines to create mail files in the directory SYS$MAILQ: for each
address.  Routines called include: CHKFMT, WHDR, SPFMT, WDAT.

@paragraph(p.lcl)

	The P.LCL scans the linked list of local users and calls the
routines to create mail files in the directory SYS$MAILQ: for each
user.  It calls the routines WFAT and WHDR.

@paragraph(chkfmt)

	This routine checks to see if the non local address passed to
it requires a special format.  This information is in the file DOMAINS.TXT.
Currently BSMTP is the only special output format supported.  

	It first checks for known hosts and then known gateways.  If found
if gets the name of the remote mail system and the identity of its name
on the network that it is sending the message.

@paragraph(spfmt)

	The SPFMT routine creates a mail message in BSMTP format to
be sent to a host that requires it.

@paragraph(whdr)

	This routine writes the local header information to the file
being created in the SYS$MAILQ: directory.  There are currently four
fields to the header information, Delivery option, notify date-time,
dequeue-time, and Recipient.  The headers end with a blank line.

@paragraph(wdat)

	This routine creates a time stamp.  It outputs the timestamp
and then the data in the data buffer to the file being created in the
SYS$MAILQ: directory.  RFC822 headers are folded if necessary.

@paragraph(fldhdr)

	This routine folds RFC822 mail headers.  It parses the line on
a comma.  If it can't find a comma it does a nasty fold at 70 characters.
During the next editing pass the routine will attempt to break on a space
before a nasty break.

@paragraph(tstmp)

	This routine builds a timestamp.

@paragraph(chkrfc)

	This routine ensures that only legitimate RFC822 headers are in the
header fields of the message being created.

@subsection(Smtp_Bsmtp Library)

	The module SMTP_BSMTP is a library used by both SMTPFORK and 
BSMTPFORK.  This module contains the routines: PARSE, SETUP, RHELP,
RHELO, RRCPT, RDATA, RNOOP, UNSUP, RMAIL, RSEND, RSOML, RSAML, RRSET,
RQUIT, SMTPERR.  This library would therefore be used as a basis
to write a new SMTP server.  

@paragraph(Parse)

	The routine parse parses the input buffer for a valid SMTP/BSMTP
command.  If no command or an invalid command is found it returns a
SMTP/BSMTP error message.  Following each command in the SMTP/BSMTP
command table is the routine address for that command.  A jump is made
to that routine.  Upon completion of that routine the RSB sets the PC
to the main loop (RMAIN) in the SMTPFORK/BSMTPFORK module.

@paragraph(Setup)

	The routine setup takes information from the info routine.  It
uses that information to build and send a greeting message.

@paragraph(Rhelp)

	RHELP provides SMTP/BSMTP help messages.

@paragraph(Rhelo)

	RHELO executes the SMTP helo command.  Any parameter passed to
this routine is accepted.  If the parameter passed does not match the
expected host name (from the info routine) then the parameter is used
as a nickname.

@paragraph(Rrcpt)

RRCPT executes the SMTP rcpt command.  This routine isolates the addressed
passed to it and calls the chkadd (in MAIL library) routine.

@paragraph(Rdata)

RDATA executes the SMTP data command.  This routine accepts input from the
SMTP/BSMTP connection until a termination sequence is received.  After
receiving a termination sequence it calls wfile to write the file to
the SYS$MAILQ: directory.

@paragraph(Rnoop)

RNOOP executes the SMTP noop command.  This command sends a noop complete
message.

@paragraph(Unsup)

	This routine sends the message "Command not supported" for the
unsupported SMTP/BSMTP commands: EXPN, VRFY, TURN.

@paragraph(Rmail/Rsend/Rsoml/Rsaml)

RMAIL, RSEND, RSOML, and RSAML are variations for the MAIL command.  These
commands take a reverse path as an argument and saves it.
Additionally, since this is the first command in a transaction, buffers and
flags are cleared.

@paragraph(Rrset)

RRSET executes the SMTP rset command.  This stops any ongoing transaction
and clears buffers and flags.

@paragraph(Rquit)

RQUIT executes the SMTP quit command, which ends the communication.

@paragraph(Smtperr)

	This routine sends a message about an error to the process calling
the SMTP/BSMTP server.

@subsection(Parse Library)

	The parse library module was written to provide a more flexible
command parser for the mail systems' user interface MM.  The module contains
three routines: PARCMD, PARARG, GETNUM.

@paragraph(Parcmd)

	The routine parcmd is used to parse a command issued by the user.
The calling routine passes allowable commands and the addresses of their
routines.  Partial command matches are allowed provides as long as the
partial match is unique.
On exiting a successful parse, the address of the routine
is returned and a pointer to any existing arguments is returned.

@paragraph(Pararg)

	PARARG parses arguments issued by the user.  PARARG parses allowable
keyword arguments and number sequences.  Number sequences can include: a
single number, a sequence of numbers separated by commas, and a range of
numbers separated by a colon.  PARARG calls GETNUM.

@paragraph(Getnum)

	GETNUM takes the argument passed and converts it from ascii to
binary if it is a legimate number.

@section(User Interface)

	The user interface to the mail system is the program MM.  MM
currently supports commands at three levels (top, read, and send).

	When a user runs MM, the users MAIL.TXT file is opened and MM.INIT 
file is read and MM is taylored to the users environment.  

@subsection(MM)

At the top level of MM, a user can delete, forward, reply to, and flag
messages. Also, the mail file can be expunged of deleted messages,
messages can be sent or read, and BBoards can be accessed.
Finally, a user can get a directory of all or specified messages.

	At the read level, a user can delete, forward, or answer the 
current message being read.

	At the send level, a user can add recpients to the Carbon Copy and
Blind Carbon Copy list, enter the editor, and display the message.  The
MM.INIT file can be taylored so that default CC and BCC lists are used.

Most of the commands in MM accept keywords and number sequences 
as arguments.  

	The arguments include: new, deleted, answered, and flagged.
A number sequence can be either a single number, two numbers seperated
by a colon, or a series of numbers (ascending) seperated by commas.

	For example, the read command which types a mail message on the
users terminal screen takes any of the above keywords or a number sequence.
The command line READ DELETED types all of the deleted (but not expunged)
mail messages, while the command line READ FLAG types all the mail messages
that the user previously flagged.  The read command argument defaults to 
NEW.  Additionally, the read command allows users to delete, undelete, 
flag, unflag, reply to, and forward, the current message.

@paragraph(Note)

	The MM program was the last program developed in the mail systems
series of programs.  As this program is still in its early evolutionary
cycle, the routines will not be described in detail as in the other modules.

@section(Installation)

	The installation of the mail system is relatively straight forward.
To install the system three directories are required and one account are needed.
There are two command files provided.  One is used to compile and link the
programs and create the necessary libraries.  The other is used to start up
the software during system rebooting.

@subsection(Directories)

The directories are the directories pointed to by SYS$MAIL:, SYS$MAILQ:, 
and SYS$BBOARD.
At Wesleyan SYS$MAIL: points to the directory ps:<mail>, SYS$MAILQ: points
to ps:<mail.queue>, and SYS$BBOARD points to the directory ps:<mail.bboard>.  
The directories should be protected against world 
access and should be owned by the account MAILER.  Additionally, SYS$MAILQ:
should not have a file version limit.  This is described explicitly in the
BUILD.COM command file.

	The files: DOMAINS.TXT, EDTINI.EDT, MM.HLB, RMM.HLB, SMM.HLB, and
MAILING_LISTS.TXT must reside in the directory SYS$MAIL:.  The 
exectuable programs may also be in this directory if desired.

The file DOMAINS.TXT was described eariler.  The file EDTINI.EDT
is a standard EDT INI file.  It is used when a user wishs to use an editor
to send a mail message.  MM.HLB, RMM.HLB, and  SMM.HLB are help files 
required by
the MM program.  MM.HLB provides top level help, RMM.HLB provides help
at the read level of MM and SMM.HLB provides help at the send level of MM.


	The directory SYS$MAILQ: is the repoisitory of mail messages to
be delivered.  MM, SMTPFORK, and BSMTPFORK write mail messages to the
file SYS$MAILQ:QUEUED_MAIL.TXT.  MAISER scans for these files and processes
them one at a time.  A log of maiser activity called MAISER.LOG is kept
in this directory. Additionally, temporary files are created and deleted
from this directory as these processes operate. Queued mail files that 
have invalid addresses and are not sent to POSTMASTER are renamed from 
SYS$MAILQ:QUEUED_MAIL.TXT to SYS$MAILQ:BAD_MAIL.TXT.

@subsection(Accounts)

	Two accounts should be added to the system.  They are POSTMASTER
and MAILER.  The account POSTMASTER is required by RFC822 and is used to
route undeliverable mail to a human who can determine what action 
(if any) to take to correct the matter.  

	The account MAILER is the account that for bitnet
purposes is the registered mail system's name.  It is also used to start the
mail system software.  It therefore needs privileges to run detached jobs,
define system logical names, and create global sections (for DOMAINS.TXT).  
MM must also be installed with privleges to write to SYS$MAILQ:  
and create global sections.  A modification of the file in the appendices
called MAILSYSTEM.COM should be made for the specific location.

The MAILING_LISTS.TXT will is used to forward a local users 
mail to other account(s), allow mail to be sent to files other than MAIL.TXT,
and allow the use of public bulletin boards.  

@section(Appendix)

	The following appendicies provide examples of the HOSTS.TXT file
required for the TCP/IP network protocol and the DOMAINS.TXT file required
to address validation and mail message formating.  Also two command proceedures
are provided.  The first one, MAILSYSTEM.COM is used to start up the mail
system when the system is started.  The second one, BUILD.COM is used to build
the mail system.  An example of MAILING_LISTS.TXT is also presented.

@subsection(Hosts.txt)

	The following is the HOSTS.TXT file at Wesleyan.

@begin(programexample)
VAX:1:10003:1:02070100:2DD2:0:WESLYN:
KLA:1:10001:1:AA000303:0047:0:WESLYN:
KLB:1:10002:1:AA000303:0012:0:WESLYN:
@end(programexample)


@subsection(Domains.txt)

	The following is a partial list of the DOMAINS.TXT file at Wesleyan.

@begin(programexample)
;  THIS FILE CONTAINS TEXT LINES OF THE FORMAT:
;DOMAIN <DOMAIN>,<RELAY> <NAME OF MAIL SERVICE,
;TYPE OF MAIL SERVICE>

;HOST <HOST.><DOMAIN> <NAME OF MAIL SERVICE,
;TYPE OF MAIL SERVICE>
;	AND
;IDENT DOMAIN HOST.DOMAIN:
;
; WHERE:
;
; <RELAY>	    ::= RELAY HOST
; <HOST>	    ::= KNOWN HOST ON ANOTHER NETWORK
; <IDENT>	    ::= THE NAME I GO BY ON THAT DOMAIN
;		    IDENT IS A REQUIRED FIELD FOR EACH 
;		    DIFFERENT HOST FIELD
;
DOMAIN ARPA,WISCVM.BITNET SMTPUSER,BSMTP
DOMAIN GOV,WISCVM.BITNET SMTPUSER,BSMTP
DOMAIN EDU,WISCVM.BITNET SMTPUSER,BSMTP
DOMAIN COM,WISCVM.BITNET SMTPUSER,BSMTP
DOMAIN MIL,WISCVM.BITNET SMTPUSER,BSMTP
DOMAIN ORG,WISCVM.BITNET SMTPUSER,BSMTP
DOMAIN CSNET,WISCVM.BITNET SMTPUSER,BSMTP
;
DOMAIN UNIV,WISCVM.BITNET SMTPUSER,BSMTP
;
IDENT BITNET WESLEYAN.BITNET:
IDENT WESLYN VAX.WESLYN:
;
HOST KLA.WESLYN
HOST KLB.WESLYN
HOST ACC.BITNET
HOST ACMVM.BITNET
HOST AEARN.BITNET MAILER,BSMTP
....
HOST WESLEYAN.BITNET MAILER,BSMTP
....
HOST YALEVM.BITNET  MAILER,BSMTP
....
HOST ZAPHOD.BITNET
HOST ZURLVM1.BITNET
@end(programexample)

@subsection(Mailsystem.com)

	The following file MAILSYSTEM.COM should be taken on system startup.

@begin(programexample)

$ define /system sys$mailq ps:<mail.queue>
$ define /system sys$mail ps:<mail>
$ define /system sys$bboard ps:<mail.bboard>
$ run/process=bsmtpfork/uic=[1,6] sys$mail:bsmtpfork
$ run sys$system:install
sys$mail:mm /priv=(prmgbl,sysprv,sysgbl) /open /header /share
$ exit

@end(programexample)

@subsection(Build.com)

	The following file BUILD.COM can be used to build the mail system.

@begin(programexample)

$!	Compile the necessary programs.
$!
$!	Smtpfork runs under Tektronix tcpacp for Incoming TCP/IP Mail
$!
$macro smtpfork/cross/list
$!
$!	Bsmtpfork runs detached for Incoming Bitnet Mail
$!
$macro bsmtpfork/cross/list
$!
$!	Maiser runs either detached or is run by MM, Smtpfork, Bsmtpfork
$!	for outgoing mail
$!
$macro maiser/cross/list
$!
$!	MM is the user interface to the mail system
$!
$macro mm/cross/list
$!
$!	Mail is the General Library
$!
$macro mail/cross/list
$!
$!	Parse is the Command/Argument Parser Library
$!
$macro parse/cross/list
$!
$!	Smtp_bsmtp is the Smtp and Bsmtp General Library
$!
$macro smtp_bsmtp/cross/list
$!
$!
$!	Create the necessary Libraries
$!
$library/create/object mail mail
$library/create/object parse parse
$library/create/object smtp_bsmtp smtp_bsmtp
$library/create/help mm mm
$library/create/help rmm rmm
$library/create/help smm smm
$!
$!
$!	Link the necessary programs.
$!
$link smtpfork,mail/lib,smtp_bsmtp/lib
$link bsmtpfork,mail/lib,smtp_bsmtp/lib
$link/notrace mm,mail/lib,parse/lib
$link maiser,mail/lib
$!
$!
$!	Create the following directories or equivalents.
$!
$!	Directory DUA0:<SYS0.MAIL.DIR>
$!	Owner:    [SYSTEM,MAILER]
$!	File attributes:    No version limit
$!	File protection:    System:RWED, Owner:RWED, Group:RWD, World:R
$!	
$!	Directory PS:<MAIL.BBOARD.DIR>
$!	Owner:    [SYSTEM,MAILER]
$!	File attributes:    No version limit
$!	File protection:    System:RWED, Owner:RWED, Group:R, World:R
$!	
$!	Directory PS:<MAIL.QUEUE.DIR>
$!	Owner:    [SYSTEM,MAILER]
$!	File attributes:    No version limit
$!	File protection:    System:RWED, Owner:RWED, Group:RWD, World:W
$!
$crea/dir ps:<mail>/prot=(s:rewd,o:rewd,g:rwd,w:r)-
/own=[system,mailer]/ver=0
$crea/dir ps:<mail.queue>/prot=(s:rewd,o:rewd,g:r,w:r)-
/own=[system,mailer]/ver=0
$crea/dir ps:<mail.bboard>/prot=(s:rewd,o:rewd,g:rwd,w:w)-
/own=[system,mailer]/ver=0
$!
$!	Define the directories
$!
$ define /system sys$mail ps:<mail>
$ define /system sys$mailq ps:<mail.queue>
$ define /system sys$bboard ps:<mail.bboard>
$!
$!	Copy the programs to the appropiate directories.
$!
$!	The help files, edtini file, domains.txt and mailing_lists.txt
$!	must be in sys$mail:  The exe(s) can be anywhere you wish.
$!
$copy *.hlb sys$mail:
$copy edtini.edt sys$mail:
$copy domains.txt sys$mail:
$copy mailing_lists.txt sys$mail:
$copy *.exe sys$mail:
$!
$!
$!	***********	DO THE REST OF THIS BY HAND!	***********
$!
$!	Build the account mailer with the following parameters.  If you do
$!	disk quota checking, make sure mailer does not get hit!
$!
$!	Username: MAILER  Owner:  MAILER  UIC:  [1,6] ([SYSTEM,MAILER])
$!	Default:  DUA0:<SYS0.MAIL>  Authorized Privileges:   SETPRV
$!
$!	Modify domains.txt and mailing_lists.txt to reflect your site.
$!
$!	Install MM as a known image.  Use the command line(s):
$!	run sys$system:install
$!	sys$mail:mm /priv=(prmgbl,sysprv,sysgbl) /open /header /share
$!
$!	Later you will want to modify the system dcltables.  For now
$!	modify the process dcltables use the command line:
$!	set command mm.cld
$!	
$!	Submit the maiserout batch job.  This must be done from 
$!	the account MAILER.  Or whatever you use for your registered 
$!	bitnet mail system name.
$!
$!	Run bsmtpfork as a detached process.  The command line is:
$!	run/uic=[1,6]/proc=bsmtpfork sys$mail:bsmtpfork
$!
$!	Copy smtpfork.exe so that the local networking software knows 
$!	where to find it.

@end(programexample)

@subsection(Mailing_lists.txt)

	The following file MAILING_LISTS.TXT is used to reroute mail, send mail
to lists, and send mail to files.  This file should be edited for each 
individual site.

@begin(programexample)


!	Format of this file is:
!	Lines beginning with an ! are comments,
!	Lines beginning with text will be in the 
!	form "ID = DESCRIPTOR"
!	where "ID" is the name to be translated
!	and "DESCRIPTOR" is either an "ADDRESS" or 
!	"FILESPEC"
!	filespec's start with an "*"
!	
!	Temporary Restrictions: no white space allowed, 
!	no line continuation 
!	
!
!	Local postmatser
POSTMASTER=DECK
!
!	Bboards
!	Note bboards must reside in sys$bboard and 
!	have a ".txt" file type
GENERAL=*SYS$BBOARD:GENERAL.TXT
WCC-STAFF-VAX=*SYS$BBOARD:WCC-STAFF.TXT
!
!	Personal Mail forwardings
JGD=DECK
DHB=BIGELOW
!
!	Groups
SST=DECK,BIGELOW,SST.J-DECK@@KLA.WESLYN,TEST
!
!	KLA special forwardings
VAX-L=VAX-L@@kla.weslyn
PCIP-L=PCIP-L@@kla.weslyn
SCRIBE-L=SCRIBE-L@@kla.weslyn
TCP-L=TCP-L@@KLA.WESLYN

@@end(programexample)
    
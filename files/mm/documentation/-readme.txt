     Congratulations on procuring (in the MM developer's humble
opinion) one of the finest electronic mailsystems available.  If
you have an earlier version of MM, much of the notes in this
letter will be old hat to you; if not you may find yourself
somewhat overwhelmed.  If you fall in the latter category, stick
with it; I'm sure you'll find that your persistance will be
rewarded.  I'd like to apologize in advance for the disorganized
nature of these notes...

     You should be able to load the <MM> directory from tape and
submit the BUILD-MM.CTL file.  If you have any locally-defined
terminal types in your monitor, you'll probably want to edit the
BLANKT.MAC file as appropriate for your site (look at
<MM.DOCUMENTATION>BLANKT.PANDA to see the version of BLANKT we
use internally).

     In 5.1 and earlier monitors, your MONSYM may not have the
TCP/IP symbols which various components of the mailsystem need to
assemble (note, however, that you do NOT need TCP/IP on your
system in order to use MM).  What is worse, 5.1 MACSYM has a
serious bug which prevents the mailsystem from properly
assembling.  If you are not yet running release 6.1 (which fixes
this bug) you may want to install the MM-supplied 6.1 MACSYM.UNV
file on your SYS:.

     The mailsystem does not use the standard DEC IPCF mail
delivery system (MAIL/MAILER).  This is because with the IPCF
mailer most of the more powerful features of MM are lost.
Instead, MM uses its own mail delivery process, MMAILR.  None of
the mailsystem components require any special assembly to
establish the system configuration.  At startup, all components
determine what networks (if any) are available, and configure
themselves appropriately.

     There are three programs which are run as OPERATOR tasks on
all systems.  MMAILR should be run as a separate subjob (either
under PTYCON or SYSJOB directly).  SNDSRV and MAILST can be run
as subforks under SYSJOB.  If you are an Internet (ARPANET) site,
you should also run the SMTJFN program, which listens for
incoming SMTP connections and fires up MAISER (SMTP server)
processes to receive incoming mail.  SMTJFN must be run as a
separate subjob and not a subfork of SYSJOB.

     DECnet is supported using the Internet SMTP protocol.
SMTDCN is a program which should be run by an OPERATOR job at
each site which wishes to receive DECnet mail.  This program is a
DECnet listener which runs the SMTP server, MAISER, in an
inferior process the same way the SMTJFN program does for
Internet.  In order to run SMTDCN under TOPS-20 releases prior to
release 6.1 you will need to fix a bug in the monitor.  At
location SRCNAM+13, patch SKIPG T1 to SKIPGE T1.  Release 6.1
does not have this bug.

     As of this writing all versions of the TOPS-20 monitor have
a bug which prevents the Katakana (old style Japanese VT100)
support from working correctly.  If you need to use Katakana
support or any other terminal system that requires the use of
Shift-Out (CTRL/N) and Shift-In (CTRL/O) codes in text, you
should patch location CTBL+1 in the monitor from 206002,,443504
to 206002,,442104.  At the source level, this changes the entry
for CTRL/O in CTBL from CC1(RTYP) to CC1(PUN).  For some reason
DEC thought it would be a good idea to make CTRL/O act like
CTRL/R if it appeared in the input stream; this patch removes
that bad idea and makes CTRL/O respect the break mask.

     Several of you have expressed interest in mailing to VAX/VMS
systems via DECnet.  This is quite possible; what is needed is an
implementation of the "SMTP" mail transport protocol.  SMTP is
the protocol used to transact electronic mail on Internet (which
includes ARPANET), and has the advantage of being operating
system independent (unlike the present messy state with DEC's
mailing software).

     Included on this tape is an <MM.VAX> saveset containing the
MM-like mailsystem for VAX/VMS used at Wesleyan University.  This
software may be of use to you.

     If you would like to undertake writing a VAX/VMS
implementation yourself, the necessary documents are RFC821.TXT
(describing SMTP) and RFC822.TXT (describing what the format of
an electronic mail message is).  You should also read the DCNSND
code in MMAILR and look at the MAISER module.  If you pass your
VAX/VMS software back to me, I can include it on the tape to
supply to other sites!

     If for whatever reason you can't modify your VAX/VMS system
to use SMTP, then you're stuck with MAIL-11 (the VAX/VMS mail
protocol).  MAIL-11 is a terrible mail transport protocol.  Like
many other DEC ideas, it started out with the right idea, but
then DEC made some major screwups.  I will not bore you with the
details.

     Leaving that aside, there is a version of VMAIL included
which will receive MAIL-11 mail from a VAX/VMS system and queue
it for MMAILR.  There are several restrictions, the most serious
being that mailboxes other than user names aren't supported and
that only one process can send MAIL-11 mail to the DEC-20 at a
time.

     MMAILR has code to deliver to a DECnet system using MAIL-11.
SMTP is always attempted first, so if you are communicating with
a DECnet node that has both superior winning SMTP and inferior
losing MAIL-11, SMTP will be the protocol used.  Some address
transmogrification for VMS foreign protocol exists; this means
that if you're clever, you can send PSI mail through a VAX/VMS
system.

     It's important to understand that MAIL-11 is *not*
supported, since the protocol itself is hostile to several of the
more powerful functionalities of MM.  It is known that a number
of MM features do not work well (or at all) with the MAIL-11
protocol.  On the other hand, if you can tolerate the primitive
features of VAX/VMS mail you probably can tolerate using MAIL-11
from MM to the VAX/VMS.

     Another useful feature is the "special network" capability
which allows you to add your own mail delivery registries and
delivery agents to the mailsystem without making any
modifications to the mailsystem itself.  The file
<MM.DOCUMENTATION>SPECIAL-NETWORK.TXT describes this in detail.
You may also want to look at the Cafard program, which is an
implementation of "TTY net" mailing using the special network
facility.  We use this internally to send and receive mail on the
PANDA 2020 from around the world!

     The special network facility is really a general "mail to a
program" capability.  Clever people have used it to extend the
mailsystem beyond its nominal capabilities.  For example, the
MLIST program supports alternate spooling and return-path
generation.  Other applications include automatic digest
generation, etc.

     TCP/IP "domains" are fully supported, including MX
records(!).  You will need to install Chives, the MIT domain
resolver, on your system, using the instructions on the
<CHIVES.*> directories.

     The <MM.DOCUMENTATION> directory contains documentation of
varying quality.  There is, I regret, no such thing as an
authoritative and up-to-date MM manual.  Several attempts have
been made at one, but documenting MM is like shooting at a moving
target.  The file <MM.DOCUMENTATION>INSTALLATION.GUIDE is a very
inadequate installation guide, but it may end up saving you a lot
of time.

     As a brief overview of the mailsystem, there are several
basic components which all interact.  MM and SEND are "user"
programs which are used to compose messages to go in a user's
mail file or to deliver directly to the user's terminal (a good
example of the latter would be "Hi, are you free for lunch?").
MMAILBOX is the mailing lists and mailbox alias database,
containing a registry for all pseudo-users.  SNDSRV delivers
sends to local terminals, and MMAILR is the center of the mail
delivery universe.  MMAILR runs as a system daemon, and should
run in its own job under PTYCON or SYSJOB.

     Another component in the package is the MSTAT program.
MAILST is its server, and should be run as a SYSJOB process.
MSTAT allows a user to find out what messages he has queued but
which have not yet been delivered.  This is primarily of interest
to sites on Internet or other large networks, but can also be of
use in other environments.

     I've also given you the PANDA version of FINGER.  FINGER
is a "human-oriented" varient of SYSTAT, that says who is on by
personal name and where they are by location.  I don't know if
you can figure out how to bring this up on your system or not.
Also on the tape is a <UTILITIES> directory with a grab bag of
lots of goodies and lots of total junk.  I put two copies of all
the save sets and at the very end you'll find MIDAS.EXE and
FAIL.EXE which will help you in assembling the .MID and .FAI
files.
   
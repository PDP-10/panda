@Comment{<FTP>FTP.MSS.14,  3-May-85 19:48:54, Edit by LOUGHEED}
@Comment{Change description of SET ALTERNATE-SOCKETS}


@Make(Article)
@PageHeading(Left "FTP User Guide",
             Center "- @Value(Page) -",
             Right "@Value(Date)")

@Begin(TitlePage)
@Begin(TitleBox)
@BlankSpace(1.0in)
@MajorHeading(TOPS-20 FTP User Guide)
@End(TitleBox)

@SubHeading[David Eppstein]

@SubHeading[with minor changes for Rutgers University by]
@SubHeading[Charles Hedrick]
@Value(Date)

@CopyrightNotice(Stanford University)
@End(TitlePage)

@Section(Introduction)
This document describes FTP, a multi-protocol File
Transfer Program.  Currently FTP can transfer files using the TCP
protocol developed by the Department of Defense for the
ARPAnet@Foot[@i[File Transfer Protocol], J. Postel, ISI, available on
the ARPAnet as @t{[SRI-NIC]<RFC>RFC765.TXT}], and
the Pup protocol developed at the Xerox Palo Alto Research
Center@Foot[@i(A File Tranfer Protocol Using the BSP), John Schoch,
Xerox, available at Stanford as @t{[Lassen]<Pup>FTPSPEC.PRESS}].  FTP
was developed from the PUPFTP program written by Ed Taft at Xerox PARC
for the TENEX operating system.

The purpose of FTP is to perform various manipulations of files on
host systems across the network.  Using FTP you can retrieve files
from another system (hereafter referred to as ``remote files'' when it
would not otherwise be clear whether they are local or remote), copy
local files (files in the filesystem of the computer on which you are
running FTP) into remote files, rename files, delete files, and list
information about files onto the terminal or into a file.

Many of the commands in FTP implement these operations.  Other
commands tell FTP to which computer (also referred to as a ``host'')
to open an network connection, what your username on that computer
is, and other such things.  Still other commands control the operation
of the FTP program and do nothing directly with the network or
with the remote filesystem.  The available commands are described below.

@Section(Basic Use of FTP)
To use FTP, type @t[FTP <hostname>] to the EXEC.  FTP will type a
message with its name and version number, the name and version number
of the FTP server at the other end, and then the FTP prompt
(``@t[FTP>]''):

@Begin(Example)

@@@r[FTP SU-SIERRA]
Stanford TOPS-20 FTP 3.0, type HELP if you need it.
< SU-SIERRA FTP Server Process 5T(14)-7 at Sat 10-Mar-84 14:39-PST
Setting default transfer type to paged.
FTP>
@End(Example)

Once you are in FTP, you need to tell it 
what your username is on the other system.  You do this using the
@t[LOGIN] command.  The computer at the other end will reply with a
message confirming that you are properly logged in.

@Begin(Example)

FTP>@r[LOGIN (user) KRONJ]
Password:
< User KRONJ logged in at Sat 10-Mar-84 14:40-PST, job 16.
FTP>
@End(Example)

Now you can send and retrieve files.  These operations are done with
the @t[SEND] and @t[GET] commands.  For either command, type the name
of the source file, that is, the file you are sending or getting.
Follow this by the name of the destination file, that is, where you
want to put the file.  FTP will type the names of the files again,
just like the EXEC @t[COPY] and @t[RENAME] commands.

@Begin(Example)

FTP>@r[SEND (local file) FINGER.PLAN (to remote file) FOO.BAR]
 FINGER.PLAN.1 => <KRONJ>FOO.BAR.3 !! [OK]
FTP>@r[GET (remote file) BAR.BAZ (to local file) BAR.SIERRA]
 <KRONJ>BAR.BAZ.4 => BAR.SIERRA.1 !!! [OK]
FTP>
@End(Example)

When you have finished transferring files, leave FTP and return to
the EXEC with the @t[EXIT] command.  This will automatically close
your network connection, so if you @t[CONTINUE] the FTP program
you will have to re-open a new connection.

@Begin(Example)

FTP>@r[EXIT (to EXEC)]
@@
@End(Example)

FTP will sometimes give you a prompt other than its normal one.
This means that it needs confirmation for some action it is about to
take, or that it needs some more information to complete an action.
If you don't want to supply this information, or if you don't want the
action to be confirmed, type Control-G.  Control-G will also abort
multiple-file transfers, but it is not likely to stop the transfer of an
individual file.

@Section(RHOSTS: how to automate logging in)

If you use a particular computer a lot, you may want to create a file
RHOSTS giving your user name on that system.  The first time you issue a
command that requires you to login, FTP will automatically generate a
@t[LOGIN] command.  For example, suppose that your user name on the
hosts RUTGERS, RU-GREEN, and RU-BLUE is HEDRICK.  You would create a
file called @t[RHOSTS].  In order for the example below to work, you
must have this file in your top-level directory ON ALL THREE SYSTEMS.
It would contain

@begin(example)
RUTGERS HEDRICK SYSPROG
RU-GREEN HEDRICK GREEN-SYSTEMS
RU-BLUE HEDRICK
@end(example)

SYSPROG and GREEN-SYSTEMS are the accounts to use on RUTGERS and
RU-GREEN.  (On RU-BLUE, no account is specified.  This will work
only if you have a default account set on that host.)
Here is what the dialog would look like in that case.

@begin(example)

@@ftp green
< RU-GREEN FTP Server Process 5T(7013)-7 at Sat 27-Oct-84 19:52-EDT
Setting default transfer type to paged.
FTP>dir login.cmd
< Please log in first, with USER, PASS and ACCT.
[Automatic login to hedrick]
< User HEDRICK logged in at Sat 27-Oct-84 19:52-EDT, job 7. 
LOGIN.CMD.2

@end(example)

The reason you have to have the file on all of the systems is
very simple:  RHOSTS is used twice for any given connection: once by FTP
on this end and once by the FTP server on the other end.  On this end it
is used to generate a LOGIN command.  In the example above, FTP notices
that you have connected to GREEN, and generates a command "LOGIN HEDRICK
GREEN-SYSTEMS".  The FTP server on RU-GREEN uses the copy of RHOSTS on
your directory there to make sure that you are allowed to access that
directory without typing a password.  If the RHOSTS file is missing on
this end, you will have to type a LOGIN command.  If the RHOSTS file is
missing on the other end, you will have to type a password.

It is possible to separate those two functions.  If you put a switch /I
or /O at the end of a line in RHOSTS, that line will apply only to
incoming or outgoing connections.  That is, if you have /O at the end of
a line, FTP will still generate login commands automatically when you
connect to that host ("outgoing").  However if are on that host running
FTP to this one, you will have to type your password.  If you have /I at
the end of a line, then if you are on the other host connecting to this
one ("incoming"), you will not have to type your password, but FTP will
not generate an automatic login command when you connect to the host.

We recommend that you use /O for hosts when you do not trust their
security.  For example, suppose your RHOSTS file contains an entry
"MIT-MC HEDRICK".  If someone claiming to be HEDRICK connects to us from
the host MIT-MC, he will be able to access all of your files.  Our
server verifies the identify of the user by asking an authentication
server on the other end.  However if the other system does not have good
security, it is possible that an unauthorized user could create his own
version of the authentication server.  He could then pretend to be you.
So you should only list hosts that you trust.  A line with /O is not
a problem, since this only causes an automatic login command to be
generated when you connect to that site.  It does not affect attempts
by users at that site to access your files here.


@Section(Commands)
@SubSection(The BYE command)
The @t[BYE] command closes your current network connection.  To do any
more remote file operations you will have to open a new connection.

@Begin(Example)

FTP>@r[STATUS (of) CONNECTION]
Connected to TCP host SU-NAVAJO.ARPA
No transfer in progress
FTP>@r[BYE (break connection with remote host)]
FTP>@r[STATUS (of) CONNECTION]
No connection is open
FTP>
@End(Example)

@SubSection(The CONNECT command)
The @t[CONNECT] command tells the remote host that you want full
access to a given directory in its file system, and to assume that any
filenames without specified directories must be in that directory.
FTP may prompt for a password on a separate line; if you don't
think you need a password to access that directory, just press RETURN.
If you want to set a default directory for filenames but you do not
need full access to a directory, use the @t[SET] @t[DIRECTORY] command.

@Begin(Example)

FTP>@r[DIRECTORY (of remote files) EMACS.INIT]

   PS:<KRONJ>
EMACS.INIT.1
FTP>@r[CONNECT (to directory) <EMACS162>]
FTP>@r[DIRECTORY (of remote files) EMACS.INIT]

   PS:<EMACS162>
EMACS.INIT.43
FTP>
@End(Example)

The @t[CONNECT] command does @i[not] open connections to network
hosts.  Use the @t[OPEN] command to perform that operation.

@SubSection(The DELETE command)
The @t[DELETE] command asks the remote host to remove a file from its
filesystem.  There is no FTP command to expunge a directory, nor is
there one to undelete a deleted file.  If the command @t[SET]
@t[CONFIRMATION] @t[(required] @t[for)] @t[DELETE] was given
previously (see section @Ref[Conf]), FTP will prompt again for each individual
file specified by the filename you specified.  Press RETURN to delete
the file; type any non-blank line or Control-G to abort the deletion
of that particular file.

@Begin(Example)

FTP>@r[DELETE (remote file) FTP.*]
Deleting <KRONJ>FTP.DOC [Confirm]
< File <KRONJ>FTP.DOC deleted
Deleting <KRONJ>FTP.INIT [Confirm] @r[^G]
Not confirmed, delete aborted
Deleting <KRONJ>FTP.MSS [Confirm] @r[NO]
Not confirmed, delete aborted
FTP>
@End(Example)

@SubSection(The DIRECTORY command)
The @t[DIRECTORY] command tells FTP to find out the names of all files
matching a given specification and type them to the terminal.

@Begin(Example)

FTP>@r[DIRECTORY (of remote files) M*.*]

   PS:<KRONJ>
MAIL.TXT.1
MM.INIT.2
FTP>
@End(Example)

If you follow the remote file specification with a comma, you can
specify options to the @t[DIRECTORY] command on another line.
Subcommands are:

@Begin(Display)
@TabClear
@TabDivide(5)
@t[AUTHOR]@\types the username of each file's last writer.
@t[CREATION]@\types the creation date of each file.
@t[EVERYTHING]@\includes all optional fields.
@t[HELP]@\lists available subcommands.
@t[NO]@\negates any option (except @t[QUIT] or @t[HELP]).
@t[ORIG-AUTHOR]@\types the username of each file's creator.
@t[OUTPUT]@\sends the directory to a file rather than the terminal.
@t[PROTECTION]@\types each file's access protection bits.
@t[QUIT]@\aborts the @t[DIRECTORY] command (like Control-G).
@t[READ]@\types the date when each file was last examined.
@t[SIZE]@\types the number of bytes in each file.
@t[TIMES]@\types times along with read, write, or creation dates.
@t[TYPE]@\types each file's type (binary or text) and bytesize.
@t[VERBOSE]@\includes @t[AUTHOR], @t[READ], @t[WRITE], @t[TYPE], and @t[SIZE].
@t[WRITE]@\types the date each file was last changed.
@End(Display)

The prompt for these options is ``@t[FTP>>]''.  Finish typing options
by pressing RETURN to leave a blank line, or abort the @t[DIRECTORY]
command with @t[QUIT] or Control-G.  If any options are selected,
FTP will type a header line at the start of the listing to tell you
which column corresponds to which option.  If this listing is
redirected to a file (with the @t[OUTPUT] option), the file will
include another header line saying what files it is a directory of.

@Begin(Example)

FTP>@r[DIRECTORY (of remote files) FOO.*,]
FTP>>@r[VERBOSE]
FTP>>
                      Type   Size   Prot  Write     Read     Author
   PS:<KRONJ>
FOO.FAH.1             B(36)   160 775202 25-Aug-82    ---    KRONJ
FOO.FOO.1             Text   2204 777752 12-Jun-82    ---    KRONJ
FTP>
@End(Example)

@SubSection(The EXIT command)
The @t[EXIT] command returns from FTP to the EXEC.  @t[EXIT] closes
any open network connection; to return to the EXEC without closing
your connection use @t[QUIT].

@Begin(Example)

FTP>@r[EXIT (and close connection)]
@@
@End(Example)

@SubSection(The GET command)
The @t[GET] command is used to retrieve files from the remote
filesystem.  Type the name of the remote file, followed by the name of
the local file you wish to copy it into.  If you leave the local file
blank, FTP will prompt on a separate line for it.  To abort the
transfer of that file, type ^G to this prompt.

@Begin(Example)

FTP>@r[GET (remote file) BAR.BAZ (to local file) BAR.SIERRA]
 <KRONJ>BAR.BAZ.4 => BAR.SIERRA.1 !!! [OK]
FTP>@r[GET (remote file) FTP.*]
<KRONJ>FTP.EXE.357 (to local file) @r[^G]
Ok, ignoring that file.
<KRONJ>FTP.INIT.3 (to local file) @r[FTP.INIT.1]
 <KRONJ>FTP.INIT.3 => FTP.INIT.1 !! [OK]
FTP>
@End(Example)

When transferring files, FTP will type an exclamation mark (``!'')  once
every ten file pages; see @t[SET] @t[HASH-MARK] for details.  See the
@t[UPDATE] command for a way to retrieve only those files which are
more recent than their local versions.  See @t[SET] @t[STATISTICS] for a
way to get more information about the length and speed of your file
transfers.

@SubSection(The HELP command)
The @t[HELP] command allows you to find out information about FTP
from within FTP itself.  Type just @t[HELP] for
examples of basic use of FTP.  For help on an individual command,
type @t[HELP] followed by that command name.  The various subcommands
of the @t[SET] command all have individual help available; type
@t[HELP] @t[SET] followed by a subcommand name to find out about that
subcommand.

@Begin(Example)

FTP>@r[HELP (on FTP command) BYE]
The BYE command breaks the connection to the other computer.
A new connection will have to be specified by typing the foreign
host name or with the OPEN command before any more files can
be transferred.

FTP>@r[HELP (on FTP command) SET (subcommand) STATISTICS]
SET STATISTICS tells FTP to remember information about how long
each file transfer took.  After the transfer, the time (CPU and real),
file size, and baud rates of the transfer will be typed.

FTP>
@End(Example)

@SubSection(The INSTALL command)
The @t[INSTALL] command is identical to the @t[SEND] command (q.v.)
except only files written more recently than their remote
counterparts will be transferred.  If no such file exists, FTP
will always transfer the file.  If for some reason FTP can not find out
whether the remote file exists or what its write date is, it will ask
for confirmation before transferring the file.

@SubSection(The LOGIN command)
@Label(Login)
Use the @t[LOGIN] command to tell FTP your username and password on
the remote host.  Follow @t[LOGIN] with your username and press
RETURN; FTP will prompt you on a separate line for your password.
The password will not be echoed when you type it.  Unlike the EXEC's
@t[LOGIN] command, FTP cannot accept a password on the same line as
your username.

@Begin(Example)

FTP>@r[LOGIN (user) KRONJ]
Password:
< User KRONJ logged in at Sat 10-Mar-84 14:40-PST, job 16.
FTP>
@End(Example)

Note that for Pup connections your username and password are not
checked when you type them in, but only when you attempt a file
transaction.  If at that point FTP discovers that your username or
password is invalid, it asks again.  For TCP connections your login
will be checked immediately.  For either type of connection FTP may
prompt you to log in if you have not done so and the remote host
requires a user name to perform some operation.

@Begin(Example)

FTP>@r[DIRECTORY (of remote files) FINGER.PLAN]
< Invalid Password
LOGIN (user) @r[KRONJ]
Password:

   PS:<KRONJ>
FINGER.PLAN.3
FTP>
@End(Example)

Many systems have an @t[ANONYMOUS] account to facilitate file copying.
Typically any password will be successful for logging in as
@t[ANONYMOUS], but you will be restricted to examining
publicly-readable files.

Some systems require account strings for logins.  Normally you would
have a default account string, and so you would not need to
specify it.  If you do need to specify an account, type it on the
same line as the @t[LOGIN] command, after your username.

@Begin(Example)

FTP>@r[LOGIN (user) KRONJ (account) SYS]
Password:
< User KRONJ logged in at Sat 10-Mar-84 14:40-PST, job 16.
< Account OK.
FTP>
@End(Example)

If you login to a computer, disconnect from it, and open a connection
to a new computer, FTP will remember your old username and password.
If the new computer is not the same as the old one, FTP will ask for
confirmation to keep the old username.  If not confirmed, FTP will
forget any username it knew.  See the @t[SET] @t[OLD-LOGIN] command to
find out how to control this behavior.  There is also a way to
automatically log in to a predetermined username whenever you open a
connection to a given host; see the @t[SET] @t[USER] command for more
details.  Both of these options can be overridden by logging in before
you open your connection.

@SubSection(The MULTIPLE command)
There are two ways of retrieving files over TCP connections:
you can do a @t[MULTIPLE] @t[GET], in which case FTP first asks the remote
host for a list of files to retrieve and then asks to retrieve each of
the file names returned; or you can do a non-@t[MULTIPLE] @t[GET] in which
FTP merely asks the server for the filename you specify.  In the
latter case the file name must refer to only one file.

FTP has various options for which style of @t[GET] to use:
@Begin(Display)
@TabClear
@TabDivide(5)

@t[ALWAYS]@\(the default) always tries to use @t[MULTIPLE] @t[GET].
@t[NEVER]@\always uses non-@t[MULTIPLE] @t[GET].
@t[HEURISTIC]@\uses @t[MULTIPLE] if there are wildcards in the name.
@End(Display)

You can set which of these options to use with the @t[SET
MULTIPLE-GET] command, and you can temporarily override them with the
@t[MULTIPLE] command.  If FTP thinks the remote host can not do
@t[MULTIPLE] @t[GET]s it will stop using them until a new connection is
made; either of the above commands forces it to try again.  If the
@t[SMART-DIRECTORY] option is enabled (see section @Ref[SmartDir]) then that
will always be used instead of @t[MULTIPLE] @t[GET]s.

@SubSection(The OPEN command)
The @t[OPEN] command makes an network connection to a given host;
type the host name after @t[OPEN].  It will also work to type the
host name to the ``@t[FTP>]'' prompt, but then you will have to be
careful that the name you type is not also a FTP command.  FTP will
choose which protocol to use to reach the host with the given name;
currently Pup is preferred over TCP because file transfers tend to run
faster using Pup.  You can force a particular protocol by suffixing
the host name with a domain name; for instance ``@t[Sierra]'' lets FTP
choose between Pup and TCP, ``@t[Sierra.ARPA]'' forces it to use TCP, and
``@t[Sierra.#Pup]'' forces it to use Pup.  You can also type host
numbers if the name of the host you want is not listed; e.g. ``@t[50#325#]''
on the Stanford Pup network connects to Sierra, as does ``@t([36.40.0.213])''
on the ARPAnet.

If at any point you attempt a file transaction without first opening a
connection, FTP will ask you for a host to which to open a
connection.  Type the host name, or abort with Control-G if you
decide that you don't want to specify a computer in this way.

@Begin(Example)

FTP>@r[DIRECTORY (of remote files) FINGER.PLAN]
No connection has been opened yet
OPEN (connection to) @r[SIERRA]
< SU-SIERRA FTP Server Process 5T(14)-7 at Sat 10-Mar-84 14:39-PST
Logged in as KRONJ [Confirm]
< User KRONJ logged in at Sat 10-Mar-84 14:40-PST, job 16.

   PS:<KRONJ>
FINGER.PLAN.3
FTP>
@End(Example)

If you open a connection to a TOPS-20 host, @t[OPEN] will
automatically set your default transfer type to @i[paged] if it was
not already specified.  Otherwise if the transfer type was @i[paged],
@t[OPEN] will set it back to @i[unspecified].  See section
@Ref(TypeSec) for more details.

In some circumstances FTP will ask you to supply a password for an
automatic login or to confirm that you want to keep your old username
and password when you @t[OPEN] a new connection.  See the @t[LOGIN]
command (section @Ref[Login]) for more details.

You can supply a socket number or name after the host name.  The
default socket to use is FTP, but see the @t[SET]
@t[ALTERNATE-SOCKETS] command for a way to change that default.

@SubSection(The PRINT command)
The @t[PRINT] command sends a file to the lineprinter of the remote
host.  This is done by sending the file to remote filename ``LPT:''.
Most TOPS-20 and Tenex computers recognize this filename as referring
to the lineprinter.  Computers running other operating systems don't
obey this convention; for these computers the @t[PRINT] command will
ask for special confirmation, since it is not likely to work.

@Begin(Example)

FTP>@r[PRINT (local file) FINGER.PLAN]
 FINGER.PLAN.3 => LPT:FINGER !! [OK]
FTP>
@End(Example)

It is better to use the @t[PRINT] command than to send the file to the
LPT: device with the @t[SEND] command because, if you are connected to
a TOPS-20 host, @t[SEND] will normally try to use paged mode
transfers, which will not work to the lineprinter.  The @t[PRINT]
command, on the other hand, makes sure you are using a text mode
transfer.

@SubSection(The PUSH command)
The @t[PUSH] command creates an EXEC inferior to FTP and runs it.
Return to FTP by giving the @t[POP] command to this EXEC.  @t[PUSH]
is useful when you want to run some other program but need to make
sure you don't accidentally reset your FTP.

@Begin(Example)

FTP>@r[PUSH (to EXEC)]

 TOPS-20 Command processor 5(712)-4
@@@r[POP (command level)]
FTP>
@End(Example)

@SubSection(The QUIT command)
The @t[QUIT] command returns to the EXEC without closing any open
connection.  If you have finished using FTP you should leave with
the @t[EXIT] command; that closes the connection cleanly.  Use
@t[QUIT] if you want to use some EXEC commands for a while but do not
wish to lose your current connection.  Return to FTP after leaving
with @t[QUIT] by using the EXEC's @t[CONTINUE] command.

@Begin(Example)

FTP>@r[QUIT (to EXEC)]
@@@r[CONTINUE (fork) FTP]
FTP>
@End(Example)

@SubSection(The RENAME command)
The @t[RENAME] command lets you give a remote filename a different
name.  Type the current name of the file, followed by the new name.
If you leave the second name blank, FTP will prompt you for a new
name.

@Begin(Example)

FTP>@r[RENAME (remote file) FOO.BAR (to be) FOO.BAZ]
< Rename to <KRONJ>FOO.BAZ.1 successful
FTP>@r[RENAME (remote file) FOO.BAZ]
FOO.BAZ (to be) @r[FOO.BAR]
< Rename to <KRONJ>FOO.BAR.1 successful
FTP>
@End(Example)

@SubSection(The SEND command)
The @t[SEND] command copies a local file into a file on the remote
host's filesystem.  Type the name of the file you are sending,
followed by the name of the remote file you want to copy it to.  If
you leave the remote file blank, FTP will prompt you as necessary for
the remote filename(s).
As with the @t[GET] command, FTP will type one exclamation mark
for every ten file pages transferred.

@Begin(Example)

FTP>@r[SEND (local file) FINGER.PLAN (to remote file) FINGER.NEW]
 FINGER.PLAN.3 => <KRONJ>FINGER.NEW.1 !! [OK]
FTP>@r[SEND (local file) M*.*]
MAIL.TXT.1 (to remote file) @r[^G]
Ok, ignoring that file.
MM.INIT.2 (to remote file) MM.INIT
 MM.INIT.2 => <KRONJ>MM.INIT.23 !! [OK]
FTP>
@End(Example)

@SubSection(The SET command)
The @t[SET] command sets various parameters for the FTP program.
Some of these parameters affect file transfers, and others affect
FTP operation.  To find out which parameters are set, use the
@t[SHOW] command.  If a parameter is not set and it is needed for a
file transfer, FTP may prompt you for it (as shown below).  If you
don't want to set that parameter, or you think that a different
parameter should be changed instead, type Control-G to abort the
prompt and the transfer that caused it.

@Begin(Example)

FTP>@r[GET (remote file) AYEWBF.BIN]
< Type specification needed to retrieve <KRONJ>AYEWBF.BIN.143
SET TYPE (of transfer) @r[PAGED]
<KRONJ>AYEWBF.BIN.143 (to local file)
@End(Example)

If a @t[SET] subcommand name does not conflict with the name of a
top-level FTP command, you can type it to the ``@t[FTP>]'' prompt as
if it were a top-level command.  It will not show up in the list of
available commands you get by typing ``@t[?]'', however.

@Paragraph(SET ALTERNATE-SOCKETS)
Normally when talking to a TCP host FTP uses the same socket number
for all of its data and TELNET connections.  When combined with the
default @t[MULTIPLE] @t[GET] behavior or when transferring several files
in succession in transfer types other than @i[paged], this can lead to
rapid opening and closing of connections on the same local and remote
socket combination.

Some hosts do not treat this situation very well, and work much better
with a different socket number for each data connection.  For this
reason, FTP's default behavior is to get a new socket number each time,
rather than to guess which hosts need such treatment.  Use the command
@t[SET] @t[NO] @t[ALTERNATE-SOCKETS] to turn off this behavior.

@Paragraph(SET CHECKSUMS)
@t[SET] @t[CHECKSUMS] makes FTP use the checksumming facility of
the Pup network.  This will involve some extra monitor overhead and
therefore may slow down file transfers, but it will make it much less
likely that a file will be corrupted in transit.  You can turn
checksumming off with @t[SET] @t[NO] @t[CHECKSUMS].  Checksumming is
normally turned on.

@Paragraph(SET CONFIRMATION)
@Label(Conf)
@t[SET] @t[CONFIRMATION] makes FTP ask you to confirm possibly
dangerous actions.  For instance, if confirmation is not required for
the file transfer commands, then instead of prompting you for an
unspecified filename, FTP will automatically default the filename to
something it thinks is reasonable.  Confirmation is initially required
for all commands.  To turn off confirmation for a command use @t[SET]
@t[NO] @t[CONFIRMATION].  Available arguments are:

@Begin(Display)
@TabClear
@TabDivide(7)

@t[ALL]@\sets or clears confirmation for all of the below options.
@t[DELETE]@\makes FTP ask twice before deleting a remote file.
@t[GET]@\asks for local files in @t[GET] rather than auto-defaulting.
@t[SEND]@\asks for remote files in @t[SEND] rather than auto-defaulting.
@t[UPDATE]@\asks for extra confirmation in @t[INSTALL] and @t[UPDATE].
@End(Display)

@Paragraph(SET DIRECTORY)
@t[SET] @t[DIRECTORY] sets a default directory to use for file transfers,
rather than using your login directory or connected directory.  Files
specified with no directory will be assumed to be in this directory.
To clear a default set with @t[SET] @t[DIRECTORY], use @t[SET] @t[NO]
@t[DIRECTORY].  Directory defaults are automatically cleared if you close
your connection and open one to a different host.

@Paragraph(SET END-OF-LINE)
@t[SET] @t[END-OF-LINE] tells FTP to translate the end-of-line
delimiters of the other host's text files in different ways.  See the
section on transfer types for more detailed information on the
end-of-line conventions available.

@t[SET] @t[END-OF-LINE] only has an effect when text-mode transfers
are being done, and is only currently useful for Pup connections.  See
the section on transfer types for information about the the different
file transfer modes.

@Paragraph(SET FANCY-QUIT)
@t[SET] @t[FANCY-QUIT] changes FTP's behavior in the @t[QUIT]
command.  Normally, @t[QUIT] will simply exit to the EXEC without
changing any of FTP's state.  However, if you want to keep a FTP
fork lying around for a long time, the server you are connected to is
likely to time out your connection and close it.  This command makes
FTP close your connection when you @t[QUIT], and re-open it when
you continue FTP again.

@Paragraph(SET HASH-MARK)
Normally FTP will print an exclamation mark for every ten disk pages sent
or received to show that the connection is still active.  The @t[SET]
@t[HASH-MARK] command lets you set the number of pages between these
``hash marks'' to be some other number; by setting it to zero or by
using @t[SET] @t[NO] @t[HASH-MARK] you can disable their typeout altogether.

If the verbosity level (see @t[SET] @t[VERBOSITY]) is set to @t[DEBUGGING]
then this count will be ignored and one hash mark will always be typed
per page; otherwise the count is used and an extra hash mark is
printed before and after the file transfer.  For instance, if a
12-page file is transferred you will see three hash marks: one at the
start of the transfer, one when the 10-page mark is reached, and one
at the end of the transfer.

@Paragraph(SET INCLUDE-VERSIONS)
The TOPS-20 command completion support automatically includes a file
generation when completing a file name.  Some operating systems will
interpret this generation number as merely another part of the file
name, leaving incautious users with the string ``.-1'' at the end of
their file names.  Other operating systems will not understand the
``.-1'' at all and complain about malformed filenames.  FTP goes to
great lengths to make this unwanted completion not happen, but in
cases where the filename is longer than 6 characters or the extension
longer than 3, there is no way to avoid it.  Because of this, if
escape completion includes a generation in a filespec then FTP will
automatically edit it out.

If you really want ``.-1'' or some other such generation at the end of
a filename, you can type it out without using escape completion, or
you can enclose the whole filename in doublequotes.  To make this
editing never happen, use @t[SET] @t[INCLUDE-VERSIONS].  In the
following example, the user typed an escape immediately after each
``@t[(to remote file)]''.

@Begin(Example)

FTP>@r[SEND FINGER.PLAN (to remote file) FINGER.PLAN.-1]
 FINGER.PLAN => /csd/kronj/FINGER.PLAN !! [OK]
FTP>@r[SET INCLUDE-VERSIONS]
FTP>@r[SEND FINGER.PLAN (to remote file) FINGER.PLAN.-1]
 FINGER.PLAN => /csd/kronj/FINGER.PLAN.-1 !! [OK]
FTP>
@End(Example)

@Paragraph(SET KEEP)
@t[SET] @t[KEEP] tells FTP to keep certain properties of files in a
given type of file transfer.  Not all FTP servers will keep these
properties when you SEND a file, and some properties require WHEEL
capabilities to keep on file retrieval.  Type the name of the property
you want to keep, followed by the command to keep it in:

@Begin(Example)

FTP>@r[SET KEEP (attribute) READ-DATE (in command) SEND]
FTP>
@End(Example)

The commands that can keep properties are @t[SEND], @t[GET], and
@t[RENAME].  You can also type @t[ALL] to mean all three of the above.
@t[INSTALL] uses the kept properties list for @t[SEND], and similarly
@t[UPDATE] uses the list for @t[GET].  The properties that can be kept
are:

@Begin(Display)
@TabDivide(5)

@t[ALL]@\keeps all of the below properties.
@t[CREATION-DATE]@\keeps the date the file was first written.
@t[DATES]@\keeps @t[CREATION-DATE], @t[READ-DATE], @t[WRITE-DATE].
@t[PROTECTION]@\keeps the file's access protection bits.
@t[READ-DATE]@\keeps the date the file was last referenced.
@t[USERNAMES]@\keeps the names of the file's author and last writer.
@t[VERSION]@\keeps the file's generation number.
@t[WRITE-DATE]@\keeps the date the file was last written.
@End(Display)

You can also use the @t[SET] @t[PRESERVATION] command to set kept
properties.  @t[SET] @t[PRESERVATION] is exactly equivalent to
@t[SET] @t[KEEP] @t[(attribute)] @t[VERSION] @t[(in command)] @t[ALL].
FTP initially keeps all file properties except VERSION.

@Paragraph(SET LOWERCASE)
@t[SET] @t[LOWERCASE] makes FTP send remote file names filled in by
wildcards in the SEND command with lowercase letters instead of the
normal uppercase letters.  This is useful for sending files to
computers such as those running the UNIX operating system, where
case matters and lowercase filenames are the standard.

@Begin(Example)

FTP>@r[SEND (local file) FOO.BAR (to remote file) *.*]
 FOO.BAR.3 => /csd/kronj/FOO.BAR !!! [OK]
FTP>@r[SET LOWERCASE (file names for UNIX sites)]
FTP>@r[SEND (local file) FOO.BAR (to remote file) *.*]
 FOO.BAR.3 => /csd/kronj/foo.bar !!! [OK]
FTP>
@End(Example)

The @t[SET] @t[LOWERCASE] actually makes FTP send lowercase filenames
to all computers except those running TOPS-20, not just those running
the UNIX operating system.  On many computers, such as those
running TOPS-20, such filenames are automatically re-capitalized by
the operating system.  On others, case is remembered but
filenames will be looked up independantly of case.

@Paragraph(SET MODE)
@t[SET] @t[MODE] tells FTP in what format to send bits across a data
connection.  Possible transfer modes are:

@Begin(Description)
@t[STREAM]@\This mode merely sends the bits and bytes of a file as they are.
This has the advantage of simplicity, but the disadvantage that it
requires the data connection to be opened and closed for each file
transfer.  This is the only mode FTP servers are required to implement
and so most FTP servers support only this mode.

@t[BLOCK]@\This mode is a more structured format which allows one data
connection to remain open throughout a file transfer session.  The
extra overhead of using @t[BLOCK] mode over @t[STREAM] mode is very little.

@t[COMPRESSED]@\This mode is like stream mode except that if there are
repetitions of some byte in a file, it will send only one copy of the
byte along with a repetition count.  This mode sacrifices some gains
in speed for quite a bit more computation, but could be useful for
sending files across a very slow data link.

@t[AUTO-BLOCK]@\This is not a transfer mode in itself; rather it is an
abstraction in FTP whereby @t[BLOCK] mode is tried first, but if that
is unimplemented by the remote server FTP reverts to @t[STREAM] mode
without bothering to ask the user what to do about the mode.  This is
the default setting for the transfer mode.
@End(Description)

@Paragraph(SET NO)
@t[SET] @t[NO] turns off some parameter that had been turned on by
default or with the @t[SET] command.  See the paragraph on the
appropriate parameter for a description of what @t[SET] @t[NO] does
with it.  Parameters that can be turned off with @t[SET] @t[NO] are
@t[ALTERNATE-SOCKETS], @t[CHECKSUMS], @t[CONFIRMATION],
@t[DIRECTORY], @t[FANCY-QUIT], @t[HASH-MARK], @t[INCLUDE-VERSIONS],
@t[KEEP], @t[LOWERCASE], @t[SMART-DIRECTORIES], @t[STATISTICS], and @t[USER].

@Paragraph(SET OLD-LOGIN)
@t[SET] @t[OLD-LOGIN] tells FTP what to do when you open a connection
to another computer after having logged in to one computer.  The
default, @t[CONFIRM], makes FTP ask for confirmation before logging in as
the same user.  If the confirmation is not given FTP will look for a
default user name for that host or not log you in.  @t[ALWAYS] makes
FTP log in as the same user without ever asking for confirmation, and
@t[NEVER] makes FTP ignore the previous login and merely go on to look
for a default login.

If you log in while you are not connected to any remote host, FTP will
act as if the setting were @t[ALWAYS], that is, keep that login
information without requiring any confirmation.

@Paragraph(SET SMART-DIRECTORIES)
@Label(SmartDir)
@t[SET] @t[SMART-DIRECTORIES] makes FTP try to get a formatted
directory listing in the @t[DIRECTORY] command when using a TCP
connection.  There is no general way in the TCP protocol do this but
for most TOPS-20 and Tenex hosts the output from certain listing
commands is regular enough that it can be parsed by FTP and used to
create a formatted listing.

It may be useful for debugging purposes, or in cases where a host is
not responding according to FTP's expectations, to turn this behavior
off.  This can be done with @t[SET] @t[NO] @t[SMART-DIRECTORIES].
Note that then @t[INSTALL] and @t[UPDATE] can no longer work, and that
@t[GET]s will have to use @t[MULTIPLE] @t[GET] rather than getting the
same information through the smart directory lister.  Smart
directories are always enabled for Pup connections.

@Paragraph(SET STATISTICS)
@t[SET] @t[STATISTICS] makes FTP tell you more information about each
file transfer than you can get just from the exclamation marks it
always prints.  Currently @t[SET] @t[STATISTICS] types the length of the
transfer, the total time taken, and the transfer rate in bits per
second.  @t[SET] @t[NO] @t[STATISTICS] turns this option off.
For non-disk files @t[SET] @t[STATISTICS] can not find the size of the
file transferred, and so in that case it prints out only the amount of
real and CPU time the transfer took.

@Paragraph(SET TYPE)
@t[SET] @t[TYPE] tells FTP in which of various formats to transfer
files across the network.  The normal format between TOPS-20 systems
is for @t[PAGED] transfers.  If FTP is not talking
to a TOPS-20 computer, it sets the default to @t[UNSPECIFIED], which
means that it picks which transfer type to use on a file-by-file
basis.  The other available transfer types are @t[TEXT],
@t[BINARY], @t[IMAGE], and @t[EBCDIC]; see section @Ref(TypeSec)
for more information.

For the @t[TEXT] and @t[EBCDIC] types, FTP will then ask for a format
to use.  This controls the actions of the remote host (for TCP
connections) if it prints a file.  Similarly, the @t[BINARY] and
@t[IMAGE] transfer types will ask for a byte size (which can also be
set using @t[SET] @t[BYTE-SIZE]).  The default byte size is zero,
which tells FTP to use the byte size of the file being transferred.
If a file has no byte size and the default is zero then FTP will ask
for an explicit byte size before it transfers that file.  If a file
has a different byte size than specified, then FTP will ask for
confirmation before sending the file off with the set byte size.  If
this confirmation is not given FTP will prompt for a new type and byte
size specification.

Various other options can be given at the end of the @t[SET] @t[TYPE]
command to tell FTP when and how to use the new setting.  The first
is which end of the data connection to set these options for.  Normally
this is set to @t[BOTH], but for special effects you might want to set
different types for the @t[LOCAL] and @t[REMOTE] connection ends.
The second option is which transfer this option is to take effect for.
Normally @t[ALL] transfers will be affected, but you can make the
command affect only the @t[CURRENT] transfer, or affect the
@t[DEFAULT] for all future transfers but not the current one.

@Paragraph(SET USER)
@t[SET] @t[USER] tells FTP that when you open a connection to a given
host, it should automatically log you in as the specified user.  Type
the host name after @t[SET] @t[USER], followed by your username on
that host.  @t[SET] @t[NO] @t[USER] followed by a host name removes
any default for that host.  @t[SET] @t[USER] is not particularly
useful as a command typed directly to FTP, but it is extremely useful
for including in FTP.INIT files; see section @Ref(CmdFileSec) for more details.

@Begin(Example)

FTP>@r[SET USER (default for login at) SUMEX (to) EPPSTEIN]
FTP>@r[SUMEX]
< SUMEX-AIM FTP Server Process 5T(14)-7 at Sat 10-Mar-84 14:39-PST
Default login as EPPSTEIN
Password:
< User EPPSTEIN logged in at Sat 10-Mar-84 14:40-PST, job 16.
FTP>
@End(Example)

@Paragraph(SET VERBOSITY)
@t[SET] @t[VERBOSITY] tells FTP how much of various information to
type out on the terminal at various points in its execution.  There
are several possible settings of this parameter:

@Begin(Description)
@t[SUPER-TERSE]@\With this verbosity FTP will type almost nothing on
your terminal. This option is intended for use mostly by programs that
run FTP automatically.

@t[TERSE]@\Very little will be typed on the terminal.  Most error
messages will still be typed, but (for instance) the names of files
transferred and the hash marks showing the transfer will not be.

@t[NORMAL]@\This is the default verbosity.  Everything you should
normally need to see will be typed, but not much more will.

@t[VERBOSE]@\More text will be typed, especially most positive server
replies that would normally not be displayed.

@t[EXTRA-VERBOSE]@\Like @t[VERBOSE], except that the
machine-readable numbers returned by the FTP server are printed along
with the human-readable text replies.

@t[DEBUGGING]@\All interactions with the FTP server will be displayed.
Caution: if you log in over a TCP connection, or attempt any Pup file
transaction, while this is in effect, your remote password will be
displayed on the terminal.
You can also type @t[SET] @t[DEBUG] as an abbreviation for @t[SET]
@t[VERBOSITY] @t[DEBUGGING].
@End(Description)

@SubSection(The STATUS command)
The @t[STATUS] command types out information about the state of the
FTP program, including your logged-in username, the name of the host
you have an open connection to, and the various parameters changeable
with the @t[SET] command.  There are various subcommands to list only
part of the status information available; the default is to display it all.

@Paragraph[STATUS (of) CONNECTION]
This option displays the name and protocol of the host you are
connected to, and some connection-dependant information.  For
instance, for TCP connections it asks the FTP server for the status of
the connection.

@Begin(Example)

FTP>@r[STATUS (of) CONNECTION]
Connected to TCP host SU-SIERRA.ARPA
The current data transfer parameters are:
    MODE S
    STRU F
    TYPE A N
A connection is open to host SU-SIERRA
The data connection is CLOSED.
FTP>
@End(Example)

@Paragraph[STATUS (of) LOGIN]
This command displays any user name, account, and connected directory
that you are currently using, as well as any login defaults set with
the @t[SET] @t[USER] command.

@Begin(Example)

FTP>@r[STATUS (of) LOGIN]
Remote username is Kronj
Login defaults to Kronj on Sierra, Navajo, MIT-MC
Login defaults to DE on SAIL
FTP>
@End(Example)

@Paragraph[STATUS (of) PROGRAM]
This command lists the version of FTP that you are using, when it was
compiled, and the file commands are being read from (if it is not the
terminal).

@Begin(Example)

FTP>@r[STATUS (of) PROGRAM]
Stanford TOPS-20 FTP user process
Version 3.0, compiled  6-Mar-84 21:07:39 by KRONJ at SU-SIERRA.ARPA
FTP>
@End(Example)

@Paragraph[STATUS (of) SETTINGS]
This lists all the parameter settings that have been changed using the
@t[SET] command.  If a parameter is at its default setting, it will
not be displayed.

@Begin(Example)

FTP>@r[STATUS (of) SETTINGS]
Keeping all properties for GET, RENAME, SEND
Transfer type is paged, byte size 36
Confirmation required for no commands
Generation numbers of remote file specs are included
Statistics of transfer rates are collected
Wildcard filenames are translated to lower case
FTP>
@End(Example)

@SubSection(The TAKE command)
The @t[TAKE] command tells FTP to read commands from a file containing
FTP commands.  For more details about the @t[TAKE] command and command
files in general see section @Ref(CmdFileSec).

@SubSection(The TYPE command)
The @t[TYPE] command retrieves a remote file to your terminal.  It is
identical to using @t[GET] to local file @t[TTY:] except that it
will always use a transfer type of @i[text] (see the section on
transfer types for more details) and that it will not type the
names of the remote file and local file or the exclamation marks that
show how far your transfer has progressed.

@SubSection(The UPDATE command)
The @t[UPDATE] command is identical to the @t[GET] command except
that, for each file it would transfer, it makes sure that no local
version exists.  If there is already a local file with the name that
@t[GET] would transfer the file to, @t[UPDATE] compares the write
dates of the local file and of the remote file.  If the local file was
more recently written than the remote file, FTP will not make the
transfer.

This command is useful for merging directories of source files from
two computers, or for making sure you have the latest version of a file.

@Section(Transfer Types)
@Label(TypeSec)
There are several different formats in which FTP can transfer files:
@i[text], @i[binary], @i[image], @i[EBCDIC], and @i[paged].  You can
tell FTP which transfer type to use with the @t[SET] @t[TYPE] command;
normally you won't need to do this, since FTP will automatically set
the transfer type to whichever type it thinks is appropriate.

@i[Text] mode transfers treat a file as a stream of eight bit bytes,
and send it as such over the network.  On TOPS-20, text files normally
use seven bit bytes, so FTP will add an extra bit when sending files
and will lose the eighth bit when retrieving them.  If you want to
keep the eighth bit of a text file stored on a computer which uses all
eight bits, use @i[binary] mode instead.  Transfers made with the
@t[PRINT] command are always done in @i[text] mode.

With Pup @i[text] transfers, end-of-line characters are translated
within the transfer.  Thus if the remote host uses a different
convention for end-of-line in its text files than TOPS-20 does, the
file will still be readable.  The normal TOPS-20 end-of-line delimiter
is a carriage return followed by a linefeed, commonly called a CRLF.
Acceptable values for the name of the convention to use are @t[CR],
@t[CRLF], and @t[TRANSPARENT].  @t[CR] removes the linefeed of a CRLF
in outgoing files, and puts it back in in incoming files.  @t[CRLF]
and @t[TRANSPARENT] both leave files alone; they differ in that with
@t[CRLF] the remote host is required to make sure its ends of lines
are sent as a CRLF, whereas with @t[TRANSPARENT] ends of lines are
sent in whatever format they are stored at the remote file.  The only
convention other hosts are required to support is @t[CR], so this is
the default for FTP.  The loss in efficiency caused by using @t[CR]
instead of @t[CRLF] is not usually significant because @i[text]
transfers are uncommon between TOPS-20 computers.

TCP @i[text] and @i[EBCDIC] transfers don't use an end-of-line convention, but
they do have a similar parameter: the print format for the file.  This
controls the actions of the remote host (for TCP connections) if it
prints a file.  The possible options (as described in RFC765) are:

@Begin(Description)
@t[CARRIAGE-CONTROL]@\The file contains ASA (FORTRAN) vertical format
control characters.  In a line formatted according to the ASA
standard, the first character is not to be printed.  Instead it should
be used to determine the vertical movement of the paper which should
take place before the rest of the line is printed.

@t[NON-PRINT]@\The file need contain no vertical format information.
If it is passed to a printer process, this process may assume standard
values for spacing and margins.

@t[TELNET]@\The file contains ASCII/EBCDIC format controls (i.e.,
@t[<CR>], @t[<LF>], @t[<NL>], @t[<VT>], @t[<FF>]) which the printer
process will interpret appropriately.  @t[<CRLF>], in exactly this
sequence, also denotes end-of-line.
@End(Description)

@i[EBCDIC] transfers convert text to the EBCDIC code used on IBM
machines before sending it, and convert back from EBCDIC to text when
receiving files.  This is not available on Pup connections.
The print formats listed above also apply to EBCDIC transfers.

@i[Binary] transfers send files as a stream of bits.  This
will usually result in the destination file having exactly the same bits as
were in the source file.  The byte size of the transfer and of the
destination file is normally that of the source file, but it can be
changed with the @t[SET] @t[BYTE-SIZE] command.  If the byte sizes of
the transfer and file are not the same, there is no guaranteed that all
the bits of the source file will be transferred.

@i[Image] transfers are very similar to @i[binary] transfers, but for
TCP connections the remote server is not told how many bits there are
to a byte but rather must pack the bits into words without respect for
byte boundaries.  On Pup connections @i[image] transfers are identical
to @i[binary] transfers.

@i[Paged] mode transfers send files a page (512 36-bit words) at a
time.  This is extremely efficient, but can only be used for
disk-to-disk transfers between TOPS-20 and TENEX computers.  If you
connect to a TOPS-20 host, @t[OPEN] will automatically set your
default transfer type to @i[paged] if the transfer type was not
already specified.  If you connect to a host that cannot understand
paged transfers but the transfer type has been set to @t[paged],
@t[OPEN] will set it back to @i[unspecified].  In any case, FTP will
tell you when it is setting the default transfer type for you.

@Begin(Example)

FTP>@r[OPEN (connection to) KESTREL]
< KESTREL FTP Server Process 5T(3)-7 at Sat 10-Mar-84 19:29-PST
Setting default transfer type to paged.
FTP>
@End(Example)

There are two different @i[paged] transfer types for Pup connections:
@i[Tenex-paged] and @i[MEIS-paged].  They differ only in how 36-bit
words are packed into 8-bit bytes; @i[Tenex-paged] transfers use a
somewhat complex scheme to pack 4 words into 20 bytes, whereas
@i[MEIS-paged] transfers pack 2 words into 9 bytes.  @i[MEIS-paged]
transfers are more efficient, but they can only be used on TOPS-20
machines with MEIS network interfaces.  @i[Tenex-paged] transfers must
be used for Tenex computers and for some TOPS-20 computers.  For both
Tenex and TOPS-20 connections FTP will initially set the transfer
type to @i[MEIS-Paged], but if the server ever complains about an
unrecognized transfer type or if the local monitor does not support
MEIS data modes, the transfer type will automatically be changed to
@i[Tenex-paged].  For TCP connections there is only one kind of @i[paged]
connection, with yet another format from the two available for Pup connections.

@i[Unspecified], the default for non-TOPS-20 computers, is not really
a transfer type in itself.  Rather, if the transfer type is
@i[unspecified], FTP will choose between @i[text] and @i[binary]
transfers for each transfer, basing its decision on the properties of
the individual files.

There is also another pseudo-transfer-type that FTP uses: @i[directory].
It is impossible to retrieve any files using this transfer type, but
it is used in the @t[DIRECTORY] command to distinguish files that are
directories.

@Section(Command Files and Command Lines)
@Label(CmdFileSec)
You can create a file of FTP commands before running FTP, and
then use the @t[TAKE] command to make FTP read and execute these
commands.  To make FTP read commands from a given file, type
@t[TAKE] followed by the name of the file.  Do @i[not] include any
passwords in these files; FTP will always ask for them from the
terminal, even if it is reading commands from a command file.

You can use the @t[TAKE] command from within another command file;
when the second file is finished execution will resume in the first
one.  If an error occurs during execution of a command file, FTP
will abort all command file input and start reading from the terminal
again.  There is a limit on how deeply command files may be nested, so
you will eventually get an error if a command file tries to @t[TAKE]
itself.  FTP will also abort any command files in progress when you
type Control-G.

When it starts up, FTP will automatically look for a file in your
home directory called FTP.INIT, and if it finds it, read commands
from it.  This is useful for setting parameters such as
@t[CONFIRMATION] or @t[STATISTICS], and for telling FTP your
username at the various sites with the @t[SET] @t[USER] command.

You can give FTP a command to run on the same line that you tell
the EXEC to run FTP.  If the command did not perform any action but
rather set some parameter (like the @t[SET] command), FTP will
start taking commands immediately, but if it was some file transfer or
some other action, FTP will exit to the EXEC after the command is
completed.  The most common use of this feature is to tell FTP
which host you want to connect to.

@Begin(Example)

@@@r[FTP MC]
< MIT-MC ITS 1367,  FTP server 280 on 10 MAR 1984 2233 EST
< Bugs/gripes to BUG-FTP @ MIT-MC
FTP>
@End(Example)

If FTP reads a command file or processes any JCL, it will not type
its normal banner when it starts reading input from the terminal.
This is because it assumes you know what you are doing, and don't need
to be told that you are running FTP.

If you use the EXEC @t[REENTER] command to return to FTP from the
EXEC, it will stop whatever command it might have been doing, read any
JCL, and then return to top level and wait for new commands.  Thus if
you use the EXEC command @t[SET] @t[PROGRAM] @t[FTP] @t[KEEP] @t[REENTER]
you will be able to type JCL commands and not have to wait every time
for the overhead of a full start-up:

@Begin(Example)

@@@r[SET PROGRAM FTP KEEP (and) REENTER (when invoked as a command)]
@@@r[FTP]
[Keeping FTP]
Stanford TOPS-20 FTP 3.0, type HELP if you need it.
FTP>@r[QUIT (to EXEC)]
@@@r[FTP SRI-NIC]
[Reentering]
< SRI-NIC FTP Server Process 5T(14)-7 at Sat 10-Mar-84 19:35-PST
Setting default transfer type to paged.
FTP>
@End(Example)

@Section(Operating System Dependencies)
The FTP program tries to be as operating-system independent as it can,
but in some cases FTP will exhibit special behavior when you connect
to a TOPS-20 computer.  The most blatant example is page mode file
transfers; these will work only when you are connected to a TOPS-20 or
TENEX computer, and are in fact the default transfer type for those
computers.

Another example is filename defaulting.  When you are connected to a
TOPS-20 site you do the following, for instance:

@Begin(Example)

FTP>@r[SEND (local file) FTP.EXE (to remote file) SYS:]
 FTP.EXE.4 => PS:<SUBSYS>FTP.EXE.7 !!!!!!! [OK]
FTP>
@End(Example)

FTP knows you need a filename after the @t[SYS:], so it automatically
fills it in from the local filename.  When FTP is connected to a host
with a different operating system, however, it can't do that.  This is
because on some operating systems the directory name comes after the
filename instead of before it.  If FTP always filled out filenames
consisting of directories with no following text, it could make the
remote filename unsyntactic when it was perfectly valid the way it
was typed in.

The above example also illustrates a feature of the TOPS-20 Pup FTP
server: you can include system-wide logical names in your filenames
and they will be expanded for you.  If you use a logical name which
you have defined on the local computer, it will @i[not] be expanded
before the filename is sent to the remote host.

Yet another operating system dependency is in the @t[PRINT] command.
As described earlier, @t[PRINT] simply sends the given file to the
special remote filename LPT:.  Actually, this will only work for
computers running TOPS-20 and TENEX; most other operating systems
will not recognize this filename.

@Section(Debugging the FTP Program)

@Subsection(Alternate sockets)
You may want to run a new version of the FTP server and user on a
different socket to make sure it does not confuse the regular user or
server programs.  The way to do this is to specify the socket number
after the host name in the @t[OPEN] command.  For instance, with Pup
the usual socket for FTP debugging is 333, so you would set up a
server listening on that socket, and then type ``@t[333]'' after the
name of the host on which you have set up this server.
Remember that Pup socket numbers are octal but TCP socket numbers are decimal.

@SubSection(Debugging typeout)
The @t[SET] @t[DEBUG] command (short for @t[SET] @t[VERBOSITY]
@t[DEBUGGING]) will make FTP type out detailed
information on every transaction it makes.  FTP will type out your
password if @t[SET] @t[DEBUG] is set, so make sure not to use this option
if you want your password to remain secure.

The format of the debugging typeout for an individual FTP command on a
Pup connection is @w[``@b(Who: [Mark] <Num> Text)''], where @b[Who] is
either ``U'' (for ``User'') to show that this command is something FTP is
sending, or ``S'' to show that it is being sent by the remote FTP
server.  @b[Mark] is the name of the mark byte that was sent; this
specifies which FTP command this is.  @b[Num] is an optional numeric
argument to the command, and @b[Text] is a human-readable comment sent
along with the command.  Sometimes this text would be typed out by FTP
in the format @w[``@b[ < Text]''] if debugging typeouts weren't enabled;
this text will not printed in this way if debugging is enabled, since
that would be printing it twice.

@Begin(Example)

FTP>@r[SET DEBUG (printouts enabled)]
FTP>@r[OPEN (connection to) SAIL]
U: [Version] <1> Stanford TOPS-20 FTP 3.0 7-Mar-84
U: [End-of-command]
S: [Version] <1> SU-AI FTP Server 0.4P
S: [End-of-command] 
FTP>
@End(Example)

For TCP connections, the debugging typeout is similar but all
communication along the control channel is with strings so they are
what is typed out.  Control signals (``IACs'') used to maintain TELNET
protocol are also printed out:

@Begin(Example)

FTP>@r[BYE (break connection with remote host)]
U: QUIT
S: 212 QUIT command received. Goodbye.
S: [IAC] [Do] [Timing-Mark]
U: [IAC] [Won't] [Timing-Mark]
S: [IAC] [Do] [Timing-Mark]
U: [IAC] [Won't] [Timing-Mark]
FTP>
@End(Example)

@SubSection(Entering DDT)
There is a @t[DDT] command within FTP to help in stepping through
buggy routines and commands.  There are several different possible
ways to return to FTP top level; the recommended ones are R$G and
RET$X.  Don't type $G alone unless you don't mind resetting any
connection you may have open.  An alternate way of entering DDT is to
use the @t[QUIT] command to exit to the EXEC and then to use the
EXEC's @t[DDT] command.  As with the FTP @t[DDT] command, the
recommended ways of returning to top level are R$G and RET$X.

@Begin(Example)

FTP>@r[DDT (self)]
DDT
@r[RET$X]
FTP>
@End(Example)

@Section(Nonstandard Pup Protocol Used)

FTP currently does not use any nonstandard mark bytes.  It is
possible that bytes corresponding to the EXEC @t[UNDELETE] and
@t[EXPUNGE] commands will be added eventually.

FTP will always use the @b[New-Store] protocol instead of @b[Store]
to send files to those hosts that can handle it.  This is so that
remote filenames may be echoed as they will appear on the remote
filesystem, rather than as the user typed them in.  If a host signals
that it cannot handle @b[New-Store] by sending back a @b[No] data byte
of 1 (``Command undefined or unimplemented'') then FTP will revert to
using the @b[Store] protocol.

There are two new file transfer types: @i[directory] and @i[MEIS-paged].
See the section on transfer types for more details.

There have been several new file properties added to support the
@t[SET] @t[KEEP] and @t[INSTALL] commands.  @t[SET] @t[KEEP] operates
by including the kept properties in the property list sent to the
server for the @t[SEND] command.  It is expected that a server will
try to preserve those properties in the filesystem.  Some FTP servers
and programs can not handle unrecognized properties; when using FTP
to talk to these servers, you must give the @t[SET] @t[NO] @t[KEEP]
command to prevent FTP from sending nonstandard properties.  The new
properties are:

@Begin(Description)
@b[Group-Access]@\The contents of this property are a sequence of letters
describing the access to the given file allowed to a member of a user
group corresponding to the directory group of the directory in which
the file resides (the 007700 bits in TOPS-20 file protections).
Letters understood by FTP are:  @b[R] (read),  @b[W] (write), @b[X]
(execute), @b[L] (list), and @b[A] (append).  Any other letters will
be ignored.

@b[Original-Author]@\This is the username of the file's creator, as
opposed to the @b[Author] property which is the user who last modified
the file.

@b[Owner-Access]@\This property describes the access allowed to the file's
owner; on TOPS-20 the owner of a file is the user in whose directory
the file resides.  The contents of the property are the same as those
for @b[Group-Access].

@b[Previous-Write-Date]@\The TOPS-20 FTP server includes this property
in this list generated by @b[New-Store], so that the INSTALL command
may compare it against the local write date and decide which file is
more recent.  If no @b[Previous-Write-Date] field is generated, then
FTP will always assume the local version is the most recent.

@b[Public-Access]@\This property describes the access allowed to the file
for a user with no special owner or group access.  The contents are
the same as those for @b[Group-Access] and @b[Public-Access].
@End(Description)

!* -*-TECO-*-
This file has enough of Babyl to generate a library that can be autoloaded
to send mail (e.g. via C-X M) quickly (and not take up much library space).
Note that BABYL proper (the mail reader) must be generated from BABYL > and
BABYLM > -- it is NOT true that BABYL > has enough to read but not send
mail, since they both share some utility routines and those are in here.

Modification history:

08/08/85  164   KRONJ   Set all bits in Parser Ctl Flags for MMAILR
06/30/85  163	KRONJ	Fix missing escape in edit 162
			Clear FS D VERS to avoid problems bringing up ZBabyl
06/06/85  162	GUMBY	Change the name of the ITS init file from BABYL VARS
			to XUNAME BVARS
04/05/85  161	FHSU	(mail queued) message around WAKEMM program.
12/12/84  160	ECC	*** Fixing rubout-around-more-than-host bug ***
 4/19/84  159	ECC	Special case %MIT-OZ@MIT-MC etc. for stripping.
11/18/83  158	ECC	Add to Process Babyl Init or Vars File the processing
			(always) of EMACS:BABYL.VARS for site-dependent specs,
			especially of what recips to remove from replies.
11/16/83  156	KMP	Re-fixed & ITS Mail Buffer to also use the ";nnn."
			format not only for USER-HEADER things, but also for
			like SUBJECT which could run onto multiple lines.
			Uses this format iff field really goes to multiple 
			lines.
11/14/83  154	KMP	Fixed & ITS Mail Buffer to use USER-HEADER;nnn. 
			instead of USER-HEADER: in COMSAT request file
			so that continuation lines will be assured of 
			sticking together. Gets around a bug in current
			COMSAT that reverses USER-HEADER fields, but is a
			generally good idea anyway.
11/03/83  153	ECC	Fix up the 822 special code.  Do not use Babyl ..D,
			since that fouls up periods etc. in the uname part.
			Just do some searching etc. within personal name
			field, and only do this quoting on outgoing mail.
			On incoming mail should do UNquoting when can.
10/25/83  150	ECC	If & Process Recipient Field finds 822 specials ;:.[]
			in personal name field, unquoted, it will quote them
			or the whole field.  In particular peiod is common
			case, as in "Eugene C. Ciccarelli" <ECC at MIT-OZ>.
10/22/83  149	ECC	FOO@BAR@GAGGLE bug fixed -- was giving FO%AR at GAGGLE.
10/13/83  148	KRONJ	Add escape after second FZ in & MMAILR ...
			so that (mail queued) message doesn't get lost.
			Make Message-ID more like <KRONJ.12345678.BABYL@SIERRA>
09/30/83  147   GZ	Fixed & MMAILR Queueing Function to use octal date
			in queue file name, as per MMAILR specs.
09/21/83  146	ECC	Add check code in & Default Babyl Queuing Function to
			set Babyl Queuing Function by checking for the file
			EMACS:BABYL.USE-MMAILR.
07/24/83  145	SHSU	Fix REMAIL to not use Orig-To:, etc.
06/26/83  143	SHSU	Generate TNX Message-ID: field if not there already.
06/14/83  142	ECC	Fixed & TNX Mail Buffer bug (FCC was smashing the
			default hostname q2).  & ITS Mail Buffer quoting with
			USER-HEADER extended to quote their continuation lines.
05/26/83  141	ECC	& ITS Mail Buffer ensures ending CRLF.  & TNX Mail
			Buffer writes to fcc files before calling parser, thus
			avoiding rubouts in header.  & Append to TNX Mail File
			checks that file is not a Babyl file.
05/18/83  140	KRONJ	Wake up MMAILR by running WAKEMM.EXE (does IPCF wakeup)
04/10/83  139	ECC	Babyl calls setup hook.  Edit and Mail Buffer unmods
			at beginning, so immediate abort doesnt cause later
			query.
03/01/83  136	ECC	Fix date to not have hyphen before zone, since RFC822
			only allows Space there.  Give parser (& Process
			Recipient Field) ability to put rubouts around
			host names, for XMAILR.  Have parser driven by one
			variable with bit flags.  Prepare for splitting off
			the TNX-mailer-dependent code.  That will probably be
			moved into a separate file, BABYLT, later.  Get rid of
			the novel Spaces around @ in outgoing headers, as no
			one seems to like them (or with reformation, see
			them), and some say RFC822 discourages the use.
			Remove the OZ Sender hacks.   Added KRONJs MMAILR code.
			Temporary(?):  parser control bit to say just 1 recip
			per line, for XMAILR.  Fixed date in outgoing mail to
			conform to RFC822 -- 3-letter day and months.  Dont
			let FAKE-TO be quoted with USER-HEADER on ITS.
02/12/83  126	SHSU	M confirms if last message aborted. Random functions
			not used but so can be distributed (BBN). Cosmetic
			changes to In-reply-to: field. Support for DECnet
			mailers. File indirection in & TNX Mail Buffer fixed.
12/20/82  125	ECC	Get ready for RFC822:
			Add variable Babyl @ Flag, which signals & Process
			Recipient Field to use @, not AT.  It is bound in &
			TNX Mail Buffer.  Also, & Complete TNX Header doesnt
			have to worry about @/AT/hosts, since now & TNX Mail
			Buffer calls the parser on From and Sender fields.  If
			there are multiple @s, all but last turn into %s.
12/15/82  121	ECC	Blank lines in TNX headers removed.  ITS header fields
			checkd to see whether COMSAT processes them, and put a
			USER-HEADER before those that it doesn't.
12/01/82  120	ECC	Moved insertion of in-reply-to out of & Setup Reply
			Template and into its own subr, called AFTER editing
			the mail, so user never sees it.  # Babyl R now sets
			the current template name to Standard Reply, as a
			signal.
11/29/82  118	GZ	Changed doc for Babyl Day Of Week Flag, Babyl Personal
			Name and Babyl User Name to mention that these are for
			TNX only.
11/18/82  117	LNZ	Changed & Append to TNX Mail File to use a numeric
			argument, if provided, as the date to write into
			the TNX header.
 8/22/82  113-5	ECC	Move & Complete TNX Header back to before parsing, i.e
			back to old way, makes more sense, cleans up
			field-at-top problems.  Fixed & Complete TNX Header
			bug re Babyl Day of Week Flag, which caused colon
			after field name to end up later in the line.  Date
			now ensured on top line, above Sender, From, again.
			OZ host renaming kludge changed to use MC, since AI is
			unreliable (has been for a while using a patch file).
			Extra single-quote in code in Babyl Default Edit Mail
			Hook removed, so now the & Setup.. shouldnt foul up if
			loaded twice.  (Was benign before, but slow.)
 8/16/82  112	KRONJ	Fix Bcc removal and Fcc processing -- & Complete Header
			wasnt being called early enough so no crlf could be
			guaranteed before the Bcc or Fcc.  Also look for
			IMMEDIATE-MAIL.EXE instead of SEND-MAIL.EXE for IMail.
 7/18/82  111	ECC	Removing @<otherITS> is dangerous after all, so back
			to old code:  just remove the @localITS when reform.
 7/15/82  105-0	ECC	Finishing touches:  dont put in Sender if user put one
			in already.  Put KDO's code in to handle IPCF
			immediate mailing, for non-net sites.  They will also
			need to load or generate-in the IMAIL library.  Add
			M-X Get Mail Template.
 7/14/82  100-4	ECC	Improve documentation for a few functions.  Improve
			templates somewhat:  they remember point, handle null
			string args better.  See also BABYL.  Added Process
			Babyl Init or Vars File, called from & Setup..  Once
			new AUX is fully in normal EMACS, can simplify.  Added
			Insert Mail Template Into VARS/Init File, setting a
			template calls it upon a visited init/vars file.
 7/12/82  99	ECC	Fix bugs in new TNX header preparation: & TNX Mail
			Buffer, & Complete TNX Header.  Change & Process
			Recipient Field to strip at-AI on OZ iff that uname
			has a directory there.  So pure-ai people show as
			such.
 7/08/82  98	ECC	Add Babyl Reply-To Field variable, Babyl Default Edit
			Mail Hook.
 7/08/82  94-7	ECC	Special hack for OZ, so mail to non-chaosnet hosts
			will have a From that can be replied to.  For mail
			from OZ, all OZ-recipients and From field have User at
			MIT-AI form.  Changed & Complete TNX Header
			and & Process Recipient Field.  The latter also will
			trim this AI-form on OZ, so OZ users wont see it.  The
			idea is to hope that Chaosnet-local (especially
			OZ-to-OZ) mail wont be replied to via AI.
 7/04/82   93	ECC	TNX robustness in writing -- open to [TECO] OUTPUT:
			& TNX Mail Buffer, & Append to TNX Mail File.
 7/03/82   92	ECC	& Push To Edit Mail: 0 fsError so no O1B error.
 6/27/82 89-91	ECC	& Process Recipient Field fixed re reforming: was
			reforming FOO at LOCAL at OTHER to be FOO at OTHER,
			clearly wrong.  See comment in code re issues.  People
			may want it more featureful re recognition of local
			host, but I dont see how just now.  Better safe.
 6/14/82   88	ECC	Fix & ITS Mail Buffer to use last @ on line, e.g. so
			@FILE specs will work.  Maybe FOO@BAR@GAGGLE too?
 4/29/82   84	KRONJ	Dont need to include site name in Babyl User Name.
 3/07/82   83	KRONJ	Add Bcc: header field for TNX
 3/01/82   82	KRONJ	Fixed From: field handling in & Complete TNX Header.
			Babyl User Name with different capitalization from
			fsXUName wasn't being used, and Sender: wasn't being
			inserted if From: was already in buffer.
 2/28/82   81	KDO	Added code in & TNX Mail Buffer to set generation-
			count of unsent-mail file to 0 so that next mailing
			doesn't overwrite it.  Changed erset to a catch in Edit
			and Mail Buffer so that ? gives backtrace after error.
 1/16/82   80	ECC	Adding Babyl FCC To variable for TNX.
11/10/81   79	ECC	Removed & Expand Mailing Lists, since MMcM claims that
			XMAILR now performs mailing list expansion.
11/02/81   78	ECC	Fixed & Expand Mailing Lists infinite loop bug.  Was
			looping for non-mailing-list entries.
 6/11/81   76	EAK	Removed DM hack because PDL claims COMSYS will handle
			COMSAT input files now.  Deleted the following line:
			fsMachine-(f6DM)"e etAI:'
 4/20/81   74   Moon	Mailing lists for Tenex (see & Expand Mailing Lists)
 3/25/81   73	ECC	F, V, R, and & Setup Reply Template moved into BABYL
			proper since are either only for mail-reading (F and
			R) or is a dispatch (V) command.  Make BABYLM smaller.
 2/16/81   72	ECC	F and R only use 1 line of subject, since ITS mailer
			cannot handle (I think).
12/20/80   69	ECC	Changed yanker in accordance with Babyl changes to set
			bounds just around message.
11/07/80   64	ECC	Work on F: fixed so done hook goes off in *Babyl*, not
			*Mail*.  Added variable and argument options to
			control reading To/Subject, whether into .
			Mail edit level binds C-M-\ to filler.
11/07/80   61	EAK,ECC	Made F use @:F to optimize redisplay by
			scrolling the message down to where the yanked
			message will be, and back up when done.
 ??? -- what JP work in here? -- ???
 9/17/80   52	ECC	Changed Edit and Mail Buffer to print only header and
			current line if printing terminal.  Used to print
			whole buffer, bad for C, 3R, 4R, F.
 8/27/80   50	ECC	Added pruning of BBOARD@ to INFO- and * pruning.  Also
			made Babyl Dont Reply To search bounded over <CRLF>
			<mailbox> <CRLF> so username can be fully delimited.
 8/24/80   48	ECC	Added 2-window control to M, C, F, and V (new template
			command).  Renamed # Babyl ^F to # Babyl F.  Should do
			the opposite in BABYL for the finder function.
 8/24/80   45	ECC	Split up the R/M/C/F shared code in # Babyl R and
			distributed it among R, M, C, and F for clarity and
			better modularity.  New routine & Push to Edit Mail
			which they call.  Renamed # Edit Mail to Edit and Mail
			Buffer, since it can conceivably now be user callable
			on any buffer, and since it now sends the mail.  #
			Babyl ^F keeps same subject or makes one, and calls
			the parser.  Deleted the obsolete idea-file RMCF >.
 8/24/80   40	ECC	Added mail template hacking to # Babyl R and added
			Mail With Template (# Babyl V) and Set Mail Template.
			Changed some variable names and declared all of them
			so user can use Edit Options etc.  Names changed to
			include "Babyl" in their names to allow giving "Babyl"
			as filter to Edit Options.  Changes (<...> is added):
			<Babyl> Dont Reply To
			<Babyl> CC To
			<Babyl> Require Subjects
			Babyl Reply Hook -> Babyl Edit Mail Hook
			<Babyl> Day of Week Flag
			<Babyl> User Name
			<Babyl> Personal Name

 8/23/80   38	ECC	& Process Recipient Field modified, primarily to leave
			recipient buffer with pairs of lines, not only mailbox
			names, but full recipients as well for more general
			use as a parser.  # Babyl R uses it to remove
			duplicate and unwanted recipients.  Semantics of Dont
			Reply To changed a little, and INFO-xxx and *xxx
			always removed.  Added option Babyl Trim Recipient List
			to control whether any of this is done.
 7/17/80   20	ECC	& TNX Mail Buffer ensures that there is a final CRLF.
			Was necessary for XMAILR, though XMAILR claims now to
			be fixed so it could possibly be removed.  Changed
			recipient pruning to (1) use just the mailbox part of
			TO (not host, not rfc733 personal name), and (2)
			delete the entire recipient, not just a stupid FKD.
			Also it will remove a lone Cc: line with no recipients.
 Pre-history...!

!~FILENAME~:! !Mail-sending part of the Babyl mail subsystem.!
BABYLM

!# Babyl C:! !C# Continue editing the last message sent or aborted.
Describe Edit and Mail Buffer for details about message editing,
    and general hooks.
If you give a numeric argument of 2 we will use 2 windows, with the
    current message in the top and the message being sent in the
    bottom one.
Runs any Teco program in the variable Babyl C Hook after the message
    template has been set up.!
 !* 1, numeric argument inhibits our setting abort message.!

 m(m.m& Declare Load-Time Defaults)
    Babyl C Hook, 0 or a Teco program to run after C sets up its template: 0

 [1
 ff&2"e :i*To continue editing this message use the C command.(
    )[Abort Resumption Message'	!* For Abort Recursive Edit.!

 -2"'e,0m(m.m& Push To Edit Mail)	!* Use 2 windows if NUMARG=2 but dont!
					!* reset buffer.!

 qBabyl C Hookf"nu1 m1'w		!* Run M hook if any.!

 :m(m.mEdit and Mail Buffer)		!* Let user edit the mail and then!
					!* mail it off.!


!& Mail Message:! !S Edit and then send a message.
To continue editing a message aborted earlier, provide a numeric
    argument.!

 :i*To resume, invoke the Send Mail command again with a numeric argument[Abort Resumption Message
					!* C-] wont ask for a confirmation.!
 ff&1"n 1,:m(m.m# Babyl C)'	!* Continue editing mail and send.!
 1,:m(m.m# Babyl M)			!* Edit new mail and send.!

!Process Babyl Init or Vars File:! !C Find init or vars file and process it.
Babyl init and vars files are similar to EMACS ones, though these
    should only be for customizing Babyl.  If you only use Babyl from
    WITHIN EMACS, you can customize it with your EMACS init or vars
    file.  You would then need no Babyl init or vars file.  But if you
    want to use Babyl outside EMACS, i.e. :BABYL on ITS or BABYL.EXE
    on TNX, then you should put Babyl customizing in a Babyl init or
    vars file.
Babyl checks your home directory for a Babyl init file, which should
    be Teco code: BABYL INIT (ITS) or BABYL.INIT (TNX).
If no init file is found, it looks for a vars file:  BABYL VARS (ITS)
    or BABYL.VARS (TNX).  This file should be in the same format as an
    EMACS vars file.
This processing is only done the first time Babyl is loaded, for
    reading or sending mail.  If you edit your Babyl init or vars file
    after this first entry to Babyl, you can give the M-X Process
    Babyl Init or Vars File command manually so that Babyl takes
    notice of the changes.
qSubDoc"n i
A 1, numarg means called from Babyl, so only process once.'!

 !* TNX name will be (in home directory) BABYL.VARS.  ITS name will be (in!
 !* home directory) BABYL VARS.  Unfortunately doesnt seem possible to use an!
 !* ITS name like one for EMACS vars and also have parallel for init file --!
 !* cannot have USER BABYL, since the Babyl file already uses that.  So for!
 !* ITS have BABYL VARS and BABYL INIT.!

 ff&2"n 0fo..qBabyl Init/Vars Processed"n ''	!* If called from!
					!* Babyl, and if done already, exit.!
 [1[2[3[4 f[DFile
 f[BBind				!* Temp buffer.!
 e[fne]				!* Push input channels if need.!

 !* First the possibly site-specific EMACS:BABYL.VARS: !
 fsOSTecof"ew etDSK:EMACS;BABYL VARS'	!* ITS.!
 "#-1"ew       etEMACS:BABYL.VARS'	!* Tops-20.!
 "#w	       etDSK:<EMACS>BABYL.VARS'' !* Tenex.  ???? EMACS:???  !
 e?"e					!* If the file exists, process it.!
    fsDFile m(m.m& Babyl Process Init Vars)' !* ...!

 etDSK: fsHSNamefsDSNamew		!* Default to home directory.!
 0fsdvers				!* No version defaulting!
 etBABYL INIT				!* Init filename.!
 0u1					!* 1: 0 until find a file.!
 fsOSTeco-2"e				!* Tenex -- avoid use of E?...!
    1:<er ec 1u1>w'			!* 1: Check for Tenex init file.!
 "# fsOSTeco"e
    et foo babini fs xuname fs dfn1' !* Set ITS name to look for !
    e?"e 1u1''				!* 1: Check for ITS/Twenex init file.!
 q1"n er @y m(hx*) 			!* Process init file.!
      1m.vBabyl Init/Vars Processedw '	!* Say we have done it, exit.!

 etBABYL VARS				!* Vars filename.!
 0u1					!* 1: 0 until find a file.!
 fsOSTeco-2"e				!* Tenex -- avoid use of E?...!
    1:<er ec 1u1>w'			!* 1: Check for Tenex vars file.!
 "# fsOSTeco"e                         !* if ITS use special name !
    et foo bvars fs xuname fs dfn1'
    e?"e 1u1''				!* 1: Check for ITS/Twenex vars file.!
 q1"e 1m.vBabyl Init/Vars Processedw	!* Say that we have checked already.!
      '				!* No init file, no vars file.  Exit.!

 !* Process the BABYL VARS file:  When EMACS proper has the latest AUX init!
 !* (not just in the AUX library), we can remove our copy of it and change!
 !* which we call here.  (Here we call it & Babyl Process Init Vars instead of!
 !* the standard & Process Init Vars.)  And we can just do a simple m(m.m&!
 !* Process Init Vars), passing it the filename.  But the current EMACS!
 !* MM-variable version of this is buggy.!

 fsDFile m(m.m& Babyl Process Init Vars)
 1m.vBabyl Init/Vars Processedw	!* Say that we have done it now.!
 

!& Babyl Process Init Vars:! !S Read the user's EVARS file of var settings!
!* A filename string may be given as a numeric argument, to specify a!
!* non-standard vars file. ...THIS IS A COPY OF THE ONE IN AUX.EMACS.49.  It!
!* can go away when that version of AUX is part of the standard EMACS,!
!* especially the (impure) MM-variable -- the current one is buggy.!

F[DFILE
FF&1"NFSDFILE'
"#FSOSTECO"E
ETFOO EVARS
FSXUNAMEFSDFN1'
"#ETEMACS.VARS'
FSHSNAMEFSDSNAM'
[1[3[4
Q..O[5F[BBINDQ..O[6
[..O
128*5,32:i*[2
*5:f2 /
"*5:f2 |!'!
1:<ER@Y>"L'
<.-Z;
@:F  "EL!<!>'
1AF 	:"L@L!<!>'
.,(CS:.-2,.+1F=::"EC'
).-1X3
.u1@f	 l
1a-34"eq2[..d
.+1,(@fll).-1x4
]..d
@:i4"4"!''!'
"#.(:\u4)-."eq1-1j'
@f 	l
:@f  "n
q1j:X4''
Q5U..O
FQ3-2:G3F:"'L+(
0:G3-:"'E)"L
M4U3'
"#F=3*"EM4'
"#Q4M.V3''
Q6U..O@L>
:@i*|[1fsqpptr[2
m(m.mKill Variable)MM & Process Init Varsw
:g(m.aAUX& Process Init Vars)u1
q2fsqpunwin
f:m(q1(]1))
|m.vMM & Process Init Vars

!# Babyl M:! !C# Edit and then send a message.
Describe Edit and Mail Buffer for details about message editing and
    general hooks.
If you give a numeric argument of 2 we will try to use 2 windows, the
    mail in the bottom window, the current message in the top one.
To continue editing a message aborted earlier, use the C command.
You may set the variable Babyl M Hook to a Teco program to run after
    the header is initialized.!
!* Pre-comma numeric argument means caller has already bound the abort!
!* message.!

 m(m.m& Declare Load-Time Defaults)
    Current Babyl Template Name, 0 or name of template in use: 0
    Babyl CC To, * Automatic CC field in mail if non-0: 0
    Babyl Fcc To, * Automatic Fcc field in Tenex or Tops-20 mail if non-0: 0
    Babyl Reply-To Field, * Automatic Reply-To field in mail if non-0: 0
    Babyl Header/Text Separator,
	* 1 line that separates header and text in recursive mail edit:
	|--Text follows this line--|
    Babyl M Hook, 0 or a Teco program to run after M sets up its template: 0


 fsQPPtr[0 [1[2			!* 0: Unwind point in case we turn!
					!* into a C command.!
 ff&2"e :i*To continue editing this message use the C command.(
    )[Abort Resumption Message'	!* For Abort Recursive Edit.!

 -2"'e,1m(m.m& Push To Edit Mail)	!* Use 2 windows if NUMARG=2 and reset!
					!* buffer mode and filenames.!

 !* Now set up the message template for editing.  If we were called by Mail!
 !* With Template the variable Current Babyl Template Name will be non0 with!
 !* the name.!

 0f[VB 0f[VZ				!* Widen bounds since in own buffer.!

 fsModified"n				!* Aborting leaves *Mail* modified .!
    ft
Last message being composed seems to have been aborted.
      Continue editing aborted message? 
    m(m.m& Yes or No)"n q0fsQPUnwindw	!* Yes, so pop buffer etc. and become!
			 f@:m(m.m# Babyl C)''	!* a C command.!

 qCurrent Babyl Template Nameu1	!* 1: 0 or template name.!
 q1"n 0@fo..qBabyl Template 1u1'	!* 1: 0 or template object.!
 0fsWindoww				!* Dont use any previous one.!
 q1"n hk g1				!* Just use the template if we have!
					!* one.!
      j zu2 0,1a-["e d		!* Template has a point specified.!
	8+2f[IBase \u2 f]IBase	!* Read point in base 10.!
	0,1a-]"e 0k d'' q2:jw'	!* Set point.!
 "#					!* Use standard M template.!
    hk iTo: 
   .-2(				!* Empty TO field.!
	qBabyl CC Tof"nu1 icc:  g1 i
	  'w				!* Insert automatic-CC if one.!
	fsOSTeco"n qBabyl Fcc Tof"nu1 iFcc:  g1 i
         ''w				!* Insert auto-FCC if one and on TNX.!
	qBabyl Reply-To Fieldf"nu1 iReply-to:  g1 i
	  'w				!* Insert reply-to field if one.!

	gBabyl Header/Text Separator i

	)j'				!* Leave point after To: .!


 qBabyl M Hookf"nu1 m1'w		!* Run M hook if any.!
 :m(m.mEdit and Mail Buffer)		!* Let user edit the mail and then!
					!* mail it off.!

!Mail With Template:! !C Edit and send mail, with template initialization.
Describe Edit and Mail Buffer for details about message editing and
    the general hooks available.
The message is initialized from a template, which may specify any
    header or text components.  The template is a variable, containing
    a copy of what the mail editing buffer should be initialized to.
    It can optionally start with a value for point, within brackets,
    e.g. it might start:  [35]To:
String argument is a template name.  The template variable name is
    formed from this name -- e.g. for a template named "Foo", the
    variable is named Babyl Template Foo.  If you are using the Babyl
    V command the template name is read with completion.
If you give a numeric argument of 2, we will try to use 2 windows,
    current message in top one, message being sent in bottom one.
See the M-X Set Mail Template command for aid in creating templates.
Runs the Teco program in the variable Babyl M Hook if one.  This
    program can check the variable Current Babyl Template Name, 0 for
    normal mailing, if it wants to further process the template.!

 m(m.m& Declare Load-Time Defaults)
    Current Babyl Template Name, 0 or name of template in use: 0
    CRL Prefix,:0
    CRL List,:0


 [Current Babyl Template Name
 fsQPPtr(				!* Cant leave completer arguments!
					!* pushed since theyd interfere with!
					!* other commands.!
    :i*Babyl Template [CRL Prefix	!* Completer arguments.!
    q..q[CRL List			!* ...!
    8+2,fTemplate: uCurrent Babyl Template Name	!* Read template name.!
    fqCurrent Babyl Template Name"e	!* Null string arg.   Force read.!
      @:m(m.mMail With Template)'	!* ...!
    )fsQPUnwindw			!* Pop completer arguments.!
 f:m(m.m# Babyl M)			!* Compose and mail.  It will use the!
					!* current template name if non-0.!

!Get Mail Template:! !C Template replaces current contents of *Mail* buffer.
String argument is template name.  If none, it will ask you for one,
    with completion. 
This command is like M-X Mail With Template, except it is for use
    after you are already in the recursive mail edit.
The M-X Undo command will get the original *Mail* contents back
    again.!

 m(m.m& Declare Load-Time Defaults)
    CRL Prefix,: 0
    CRL List,: 0


 [1[2
 "e hm(m.m& Save for Undo)Get Mail Template'
 :i*Babyl Template [CRL Prefix	!* Completer arguments.!
 q..q[CRL List			!* ...!
 8+2,fTemplate: u1			!* 1: Read/get template name.!
 fq1"e					!* Null string arg.   Force read.!
    1,@:m(m.mGet Mail Template)''	!* ...!

 qBabyl Template 1u1		!* 1: template object.!
 hk g1					!* Insert the template contents.!
 j zu2 0,1a-["e d			!* Template has a point specified.!
    8+2f[IBase \u2 f]IBase		!* 2: Read point in base 10.!
    0,1a-]"e 0k d''			!* ...!
 q2:jw					!* Set point.!
 

!Set Mail Template:! !C Create or reset a mail template from buffer contents.
See the M-X Mail With Template or # Babyl V command for using
    templates.
String argument is a template name.  If null, will read it in echo
    area.
The template is taken to be the entire contents of the buffer.  The
    current point will be remembered in the template.  This command is
    generally given while in a recursive mail edit level.!

 m(m.m& Declare Load-Time Defaults)
    CRL Prefix,:0
    CRL List,:0
    CRL Non-match Method,:2


 [0[1[2
 :i*Babyl Template [CRL Prefix	!* Completer arguments.!
 q..q[CRL List			!* ...!
 4[CRL Non-match Method		!* Enable Return/Linefeed distinction.!
 16+8+2,fTemplate: u0		!* 0: Template name.  Read with!
					!* completion, allowing new ones.!
 fq0"e f@:m(m.mSet Mail Template)'	!* If null string arg, force read.!
 .u1 hx2				!* 1, 2: Point, buffer contents.!
 fsQPPtr( f[BBind g2 j i[ 8+2[..e q1\ i]	!* Insert the [point] part.!
    hx*m.vBabyl Template 0w		!* Set the template.!
    )fsQPUnwindw			!* Back to proper buffer.!

 !* Expeimental -- see about recursively letting user visit init or vars file,!
 !* now, and inserting the new template into the init/vars file: otherwise,!
 !* user will have to do it later.  And then either (1) BABYL(M) probably wont!
 !* be loaded, an inconvenience or confusion, or (2) the user will exit BABYL!
 !* job and the template will disappear.  Thus most logical to do it now,!
 !* expecially for naive users.!

 ftDo you want to make the 0 template permanent,
 by putting it into an EMACS or Babyl init or vars file now? 
 m(m.m& Yes or No)"e 0u..h 0'	!* No!

 f[DFile etDSK: fsHSNamefsDSNamew	!* Default to home directory.!
 e?BABYL INIT"n			!* Default to Babyl init, or!
   e?BABYL VARS"n			!* Babyl vars, or!
    fsOSTeco"e fsXUName:f6u1 et1 EVARS'"# etEMACS.VARS'	!* ...!
    e?"n				!* EMACS vars, or!
      fsOSTeco"e et1 EMACS'"# etEMACS.INIT'	!* ...!
      e?"n				!* EMACS init, or!
	etBABYL VARS''''		!* default to (new) Babyl vars file.!
 ftPlease specify which init or vars file to use:

 [Previous Buffer			!* Keep one the user knows.!
 qBuffer Nameu1 @fn|m(m.mSelect Buffer)1|	!* Come back here after.!
 @m(m.mFind File)	!* Get the file.!
 0u..h					!* Dont keep that typeout.!
 z"n					!* If any code, let user put point.!
    fsOSTeco"e :i1C-M-C'"# :i1C-M-Z'	!* 1: C-M-C/Z.!
    :i*Please set point for template, then exit with 1[..j	!* ...!
     ]..j'				!* Point now where should insert.!
 m(m.m& Set Mode Line)			!* So shows proper buffer, filenames.!
 m(m.mInsert Mail Template Into VARS/Init File)0	!* Insert it, and!
 @m(m.m^R Save File)w			!* save it.!
 0

!Insert Mail Template Into VARS/Init File:! !C Insert template setup code.
String argument is template name.
After using Set Mail Template, you can visit your init- or vars-file
    and use this command to insert something that will save this
    template for permanent use.
Asks which kind of code it should insert, VARS- or init-file.!

 m(m.m& Declare Load-Time Defaults)
    CRL Prefix,:0
    CRL List,:0


 [0[1[2[3
 :i*Babyl Template [CRL Prefix	!* Completer arguments.!
 q..q[CRL List			!* ...!
 8+2,fTemplate: u0			!* 0: Template name.!
 fq0"e f@:m(m.mInsert Mail Template Into VARS/Init File)'
					!* If null string arg, force read.!
 fsQPPtr( f[BBind			!* Temp buffer for quoting.!
    0fo..qBabyl Template 0f"ew :i*No template 0fsErr'u1
    g1					!* 1: Template, inserted.!
    0s j <:s; r i c>		!* Quote C-]s with another.!
    0u2 0u3				!* 2,3: Will count "s and 's.!
    0s"!'! j <:s; r i c %2w>	!* 2: Quote and count quotes.!
    !"!0s' j <:s; %3w>		!* 3: Count apostrophes.!
    hx1					!* 1: Quoted template.!
    )fsQPUnwindw			!* Back to init/vars buffer.!

 @ft
Is this a VARS file (as opposed to an init file)
 1m(m.m& Yes or No)"n			!* Yes.!
    0l .,( i	Create mail template 0:
Babyl Template 0: "!'! g1 i"!'! i
	  ).f 0'			!* Insert for VARS file.!


 !* For init file: !

 0l .,( i !* Create mail template 0: !
 
	q2+1-q3"l			!* Will need more double-quotes.  +1!
					!* includes the first outside one.!
	  i! q3-q2-1,"i!'! i! '	!* ...!
	i:@i*" g1 i" m.vBabyl Template 0w!'! !'!
	!* Just so Teco-mode quote-balancers work, and in case this is all!
	!* inside a conditional, make sure the number of "s='s.!
	q2+1-q3"g			!* Need more single-quotes.  The final!
					!* double-quote has already got a!
					!* single-quote.!
	  r !"!q2+1-q3,'i c'		!* ...!
	i
	).f 0			!* Insert for init file.!

!Edit and Mail Buffer:! !S Edit some mail to send in recursive edit level.
All the Babyl mail-sending commands (C, F, M, R, V) invoke this one.
To send the mail, exit the recursive edit level with ^R Exit.
To abort, use Abort Recursive Edit.  If you abort, you can
    continue editing the message later with the C command from Babyl
    or by giving Send Mail an argument.
The ^R Babyl Yank command will insert a copy of the current Babyl
    message if there is one.  (E.g. the one being replied to.)
Paragraph Delimiter is temporarily set so lines starting with "-"
    won't be considered part of a paragraph.  Thus the --Text...  line
    won't get in the way of a ^R Fill Paragraph.
If the variable Babyl Require Subjects is non-0, you will be asked to
    supply a subject line if you forgot to include it while editing.
The variable Babyl Edit Mail Hook may be set to a Teco program to run
    just before entering the recursive edit level.  If this variable
    is 0, we will connect C-M-Y to ^R Babyl Yank, C-M-\ to ^R Fill
    Indented Mail Region, and set the Paragraph Delimiter variable.
    This default action may be called by your hook, by:
	mBabyl Default Edit Mail Hook!

 !* Note:  This function cannot be named & Edit Mail, since the "&" will cause!
 !* HELP-R not to consider it for describing.  It used to be called # Edit!
 !* Mail for that reason before it became a user-callable (if ever desired)!
 !* command.!

 !* Note that each line in Babyl Default Edit Mail Hook should begin with!
 !* exactly two Tabs, and the whole should start with a CRLF.  And dont put!
 !* any comments in there -- for then the comment compressor would remove the!
 !* Tabs.  All this is so the INFO listing (auto-produced) will look nice: !
 m(m.m& Declare Load-Time Defaults)
    Babyl Default Edit Mail Hook,
      Describe Edit and Mail Buffer for details: |
		m.m^R Babyl Yank[...Y
		1,m.m^R Fill Indented Mail Region[...\
		qParagraph Delimiteru2
		fq2"g :i22-'"# :i2-'
		q2[Paragraph Delimiter|
    Babyl Edit Mail Hook,
	0 or a Teco program to run before recursive edit on mail to send: 0
    Babyl Require Subjects,
	* If non-0 Babyl will require you to have a subject in outgoing mail: 0


 [2

 qBabyl Edit Mail Hookf"nu2 m2'	!* Run user hook before into edit.!
 "#w mBabyl Default Edit Mail Hook'	!* Normal.  Have this hook, rather!
					!* than in-line code here, so users!
					!* can easily call it.!

 !Re-edit!
 0u..h					!* Get rid of any typeout on screen.!
 fsRGetty"e ft
					!* Printing terminal.!
    qBabyl Header/Text Separatoru2	!* 2: Will print just header and line.!
    .(	j s
2
	-l )u2				!* 2: Original point.  Point now at!
					!* end of header.!
    q2-."l b,q2t ft..a q2,.t'	!* Original point in header.  Type!
					!* header with point indicated.!
    "# b,.t'				!* Original point after header.  Type!
					!* whole header.!
    q2j f+'				!* Now back to original point and!
					!* redisplay that line.!
 
 0fsModifiedw 0fsXModifiedw		!* If user aborts before typing!
					!* anything, the next mail should not!
					!* ask whether to continue this.!
 					!* let user do his part!

 qBabyl Require Subjects"n		!* Some people want to be reminded!
					!* if the message has no subject.!
   j 0sSubjectReS 0u2	!* 2: 0 until find subject.!
   <:s; 12.,(fk)a-12."n !<!>' r @f	 l 0,1a-:"e 1u2 1;'>	!* 2: 1 if!
								!* found.!
   q2"e 1,m(m.m& Read Line)Subject: u2
	fq2"g j iSubject: 2
'''					!* If user gave a subject, use it.!
					!* (Typing Rubout or just Return means!
					!* include no subject field.)!

 z"e 0fsModifiedw 0fsXModifiedw '	!* Nothing to mail, just quit.!

 1@:< fsOSTeco"e m(m.m& ITS Mail Buffer)'
     "# m(m.m& TNX Mail Buffer)' >"n 	!* If any trouble!
         1fs mode change oRe-edit'	!* sending the mail, e.g. parsing, let!
					!* user re-edit the message and try!
					!* again.!

 0fsModifiedw 0fsXModifiedw		!* Leave *Mail* unmodified if mail!
					!* sent ok.!
 

!& Maybe Insert In-Reply-To:! !S For both ITS and TNX, maybe adds field to header.
Caller has bounds set to just header.!
 m(m.m& Declare Load-Time Defaults)
    From:,,:0
    Current Babyl Template Name, 0 or name of template in use: 0
    
 qCurrent Babyl Template Name[1	!* 1: 0 or template name.!
 fq1:"g ' f~1Standard Reply"n '	!* If not a reply, no in-reply-to.!
 qFrom:u1 fq1"g			!* Replying to mail from someone, insert in-reply-to!
   j i
  fnj2d				!* Boundary condition for search.!
   :s
In-reply-to:"l j '			!* User already put in an in-reply-to.!
   zj iIn-reply-to: Msg of 
   f[vb f[vz .,.fsBound		!* Get space in which to reformat date!
      gDate: -2d			!* Abbreviate date!
      bj< :s,;w -d >			!* By removing commas and days of the week!
      bj :sMondayTuesdayWednesdayThursdayFridaySaturdaySunday "N fkd '
      bj :sJanuaryFebruaryMarchAprilJuneJulyAugustSeptemberOctoberNovemberDecember "N
	fk+3d '				!* Shortening months to 3 letters!
      bj :s "N r0k' zj -:s"N ck '	!* And removing leading and trailing spaces!
      f]vz f]vb i from 1 -2 f=
"n i
''					!* Ensure in-reply-to ends with a CRLF.!
 

!^R Babyl Yank:! !^R Yank message being replied to and grow reply window.
Message is indented 4 spaces, and MARK is left before, point after,
    message.
Numeric argument of 4 ():  Message is not indented.
The original header is discarded; only the reformed one is yanked.
Numeric argument of 16 (): Original header is used instead.!
!* Giving "1," means dont go into 1 window.!

 m(m.m& Declare Load-Time Defaults)
    Pre-*Mail* Buffer,: 0
    Babyl Header/Text Separator,
	* 1 line that separates header and text in recursive mail edit:
	|--Text follows this line--|


 [0[1[2[3
 -1"n					!* Unless given 1,...!
  fsTopLine"g				!* If in bottom window,!
    f~Window 1 Buffer*Babyl*"e	!* and top window is Babyl buffer,!
       1:<4@m(m.m^R One Window)>w'''	!* Dont need to show old message in!
					!* other window now.  The NUMARG!
					!* means the bottom window is the one!
					!* that fills the whole screen.!
 fsQPPtr(  qPre-*Mail* Buffer[..o	!* Select Babyl buffer.!
	    0f[VB 0f[VZ		!* Wide bounds to find message.!
	    .u0 fnq0j			!* Leave point alone.!
	    :s"l r'"# zj' .u2	!* 2: end of text.!
	    m(m.m& Bounds Of Header)u1j	!* .,1: header.!
	    q1,q2x2			!* 2: Message text.!
	    -16"n .,q1x1'		!* 1: Reformed.!
	    "# m(m.m& Bounds Of Original Header)x1'	!* 1: Original.!
	    )fsQPUnwindw		!* Restore buffer.!

 !* Now back in message.  Check that we are not yanking into a header: !

 qBabyl Header/Text Separatoru3	!* 3: String that ends header.!
 .u0					!* 0: Original point.!
 -:s3"e 				!* If no header-end above, we must be!
					!* in the header.!
    fnq0j				!* Will restore in-header point.!
    zj'					!* But yank down at message end.!
 "# q0j'				!* OK, not yanking into header.!
 .:w					!* MARK: point before yanked message.!
 .f[VB fsZ-.f[VZ g1 g2		!* Yank and bound message.!

 -4"n					!* If NUMARG not 4, indent message.!
    j					!* To top of message.!
    < .-z;				!* Stop when to end of message.!
      2  f=
     "n 4,32i '			!* Indent unless blank line.!
      l > '				!* Next line, until end of message.!

 zj					!* To end of message.!
 0fsZw					!* Widen bounds below!
 0 f   "g i
  '
 b,.

!^R Babyl Add Subject: Field:! !^R Calls & Read Line for subject field.!
 f~Buffer Name*Mail*"n		!* Must be composing a message. *!
    :i*Must be in *Mail* buffer fsErr'
 1,m(m.m& Read Line)Subject: [.1	!* .1: subject field. *!
 q.1"n fq.1"g				!* If user gave us a field. *!
    .-z(bjl .,(iSubject: .1
	      ).f w)+zj		!* Then go put it in. *!
    ''
 1

!^R Babyl Add To-Recipient:! !^R Calls & Read Line for new To-recipient.
NUMARG of 4 means ^R Babyl Add Cc-Recipient.
Negative NUMARG means ^R Babyl Delete Recipient.!

 [1[2
 f~Buffer Name*Mail*"n		!* Must be composing a message. *!
    :i*Must be in *Mail* buffer fsErr'
 0f[VB					!* Wide bounds above.!
 z-.:\u1 fn z-1:j"e zj' 		!* Auto-restoring point.!
 j i
					!* CRLF at top for boundary.!
 "l :i1Un-To'			!* 1: Prompt.!
 "# -4"e :i1Cc'			!* 1: ...!
 "# :i1To''				!* 1: ...!

 1,m(m.m& Read Line)1: u2		!* 2: recipient name.!
 q2"n fq2"g				!* If user gave us a field... *!
    "l q2m(m.m& Babyl Delete Recipient)'	!* ...delete or...!
    "# q2,q1m(m.m& Babyl Add Recipient)'''	!* ...add it.!
 j @f
k					!* Kill CRLF at top.!
 1

!^R Babyl Add Cc-Recipient:! !^R Add new name to Cc field.!
 4:m(m.m^R Babyl Add To-Recipient)

!^R Babyl Delete Recipient:! !^R Delete To- or Cc-recipient.!
 -1:m(m.m^R Babyl Add To-Recipient)

!& Babyl Add Recipient:! !S NUMARGs: name,fieldName.!
!* Reuses existing fields, uses continuations.!

 [1[2				!* 1,2: Field, recipient names.!
 j :s
1:"l 				!* Field already here.!
    <l 1af	 :;>			!* Past contin lines.!
    0:l					!* To end of field.!
    0f  +fq2-70"g -@f, 	k i,
	 '				!* Continuation needed.!
    "# i, ''				!* No continuation needed.!
 "# bjl i1: 
   0:l'				!* Put in field.!

 i2				!* Add the field.!
 

!& Babyl Delete Recipient:! !S NUMARG is recipient name.!
!* Deletes name from either To- or Cc-fields.!

 u1					!* 1: Name.!
 j < :s
To:
Cc: ;					!* Next To-/Cc-field.!
     < < :fb1;			!* Find name in line.!
	 1af,M@ :"l			!* Ends ok...!
	   fkc -@f	 l
	   0af:,
	   :"l				!* ...starts ok, so is it.!
	       .,(:fb,"e :l').k'' >	!* ...Kill it.!
       l 1af	 "l 0:l 1;'		!* No continuation line.!
       >				!* Repeat for contin lines.!
     >					!* Repeat for each field.!
 w					!* Cant figure damn redisplay...!

!& Push To Edit Mail:! !S Set up *Mail* buffer and window for editing.
Selects back when caller returns.
Non-0 pre-comma numeric argument means use 2-window mode.
Non-0 post-comma numeric argument means reset the buffer (no buffer filenames,
    default filename of *Mail* or MAIL.TEMP, Text Mode.!

 m(m.m& Declare Load-Time Defaults)
    Pre-*Mail* Buffer,:0
    Window 1 Size,:0


 qPre-*Mail* Buffer"n			!* No recursion allowed.!
    :i*You are already in the process of sending mailfsErr'
 q..o[Pre-*Mail* Buffer		!* Save original buffer for yanker.!

 "n					!* Use 2 windows if 1,.!
    0fo..qWindow 2 Size"e		!* Unless now in 2-window mode.!
      qWindow 1 Size"N [Window 1 Size ' !* Push old size, if set.!
      (fsHeight)-(fsEchoLines)-1/2-1uWindow 1 Size	!* 1/2 screen.!
      1:< 4m(m.m^R Two Windows)f >w	!* Ensure in two window mode.!
      @fn|1:<@m(m.m^R One Window)f>w	!* When done, back to one!
					!* window, unless C-M-Y already did.!
	  0fsErrorw|''			!* 0 this so C-] exits wont print the!
					!* error message (tho they dont go in!
					!* to the error handler in any case).!

 m(m.m& Push to Buffer)*Mail*		!* Mail is sent in its own buffer.!
					!* Temporarily select it.  When our!
					!* caller returns, we will select back!
					!* to original buffer.!

 "n					!* If ,1 then we reset the buffer.!
    f~ModeText"n m(m.mText Mode)'	!* If not in text mode now, be.!
    0uBuffer Filenames		!* No buffer filenames.!
    fsOSTeco"e !<! et*Mail* >'	!* Set a nice default.!
    "# etMAIL.TEMP''			!* ... (careful of *s on TNX)!

 m.m& Set Mode Linef[ModeMac		!* Dont use the Babyl mode macro.!
 qEditor Name[..j :i..j..j 	!* Force recompute of mode line.!
 1fsModeChangew			!* ...!

 :					!* Dont let any of our stuff pop off!
					!* -- only when caller returns can!
					!* that happen.!

!& Push To Buffer:! !S Push-select buffer STRARG.
When caller returns, the original buffer will be re-selected.!
!* Minor assumption: caller cant use a STRARG with ^]..N (heh heh...)!

 [Previous Buffer			!* save previous buffer!
 qBuffer Name[0			!* 0: Original buffer name.!
 @:i*|m(m.mSelect Buffer)0|(]0)[..n	!* Make cleanup handler that will!
					!* select back to the original buffer.!
					!* Pop Q0 since not needed any more.!
 m(m.mSelect Buffer)		!* Select the buffer that caller wants!
 :					!* Exit without popping ..N etc. so!
					!* that when caller returns, we!
					!* select back.!

!& ITS Mail Buffer:! !S Mail message as specified by buffer contents.!
!*
Buffer should contain header information followed by a line containing
Babyl Header/Text Separator, followed by the text.
Header info is as described in .MAIL.;MAILRQ INFO
except that To: allows several recipients separated by commas,
and Cc: is allowed.  Also, use From: to say who you are.
S: or Re: may be used for Subject: if desired.!

 m(m.m& Declare Load-Time Defaults)
    Babyl Header/Text Separator,
	* 1 line that separates header and text in recursive mail edit:
	|--Text follows this line--|
    !* The COMSAT ... FIELD variables allow us to put USER-HEADER in front of!
    !* anything else the user comes up with, e.g. Reply-To.!
    COMSAT AUTHOR FIELD,:0
    COMSAT RCPT FIELD,:0
    COMSAT CLAIMED-FROM FIELD,:0
    COMSAT FAKE-TO FIELD,:0
    COMSAT FROM FIELD,:0
    COMSAT FROM-PROGRAM FIELD,:0
    COMSAT FROM-XUNAME FIELD,:0
    COMSAT FROM-UNAME FIELD,:0
    COMSAT TO FIELD,:0
    COMSAT SUBJECT FIELD,:0
    COMSAT HEADER-FORCE FIELD,:0
    COMSAT REGISTERED FIELD,:0
    COMSAT USER-HEADER FIELD,:0
					!* End of declare.!

 [1[2[3[4[5 g(q..o(f[BBind))		!* Make copy of buffer to do munging!
					!* in, so C command will win!
 !* & TNX Mail Buffer ensures that message ends in CRLF, and Gumby complains!
 !* that ZMAIL has had trouble with tnx-mail-file messages that dont end with!
 !* CRLF, so we will ensure the ending CRLF too: !

 -2 f=
"n i
'

 m.m& Process Recipient Field[P	!* P: Parser.!
 0[Babyl Strip Local Host		!* Dont strip local host name in mail!
					!* ..we send (something about the pot!
					!* ..calling the kettle black).!
 qBabyl Header/Text Separatoru2	!* 2: E.g. --Text Follows...!
 j 1f[BothCase :s
2
"e :i*No text, just header fsErr'

 0u4					!* 4: counts number of recipients.!
 -l fsZ-.fsVZw			!* Narrow bounds to just the header!
					!* information!

 m(m.m& Maybe Insert In-Reply-To)

 !* Now parse the TO, CC, and BCC fields to get a list of the recipient!
 !* mailboxes (and full recipient fields, which we must ignore) in buffer in!
 !* Q2.  This list is converted to form the ITS-mailer wants, e.g.: !

 !*	RCPT:(EKillian @BBNA)
	RCPT:(EAK @MC)
	RCPT:(JPershing @BBNA)
	RCPT:("Eugene Ciccarelli" @MC)
	RCPT:(BUG BABYL @MC)
	RCPT:([ECC;TEST MAIL] @MC)
	RCPT:(Babyl-Bug-File @MC (R-OPTION CC))
    *!


 q..ou3 f[BBind q..ou2 q3[..o		!* 2,3: Recipient, message buffers.!

 fsMachine:f6,q2 mpORIG-TO		!* parse these fields so they look!
 fsMachine:f6,q2 mpORIG-CC		!* ok to outsiders!
 q2[..o hk ]..o				!* but we dont want them...!

 fsMachine:f6,q2 mpTO			!* Parse TO and leave point at it.!
 fq2"g	0l <k 0,1af	 :;>		!* There was a TO, kill the field,!
					!* including any continuation lines.!
	q2[..o j			!* To recipient buffer.!
	< .-z; :l 0f : fb@ :fx1	!* 1: Removed @host of next TO.!
					!* Note that we use the last @ in the!
					!* line.  Handle multiples, @FILE, etc!
 	  0l 1a-("n			!* Not a (...) form (yet).!
	    1af"[!'!"l		!* If not a [...] must quote if any!
					!* spaces inside it if not already.!
	      :fb "l 0l i" :l i"!''!''	!* ...!
	    0l i( :l i)'		!* Since not a (...), make it one.!
	  0l iRCPT: :lr i 1	!* Finish it off.!
	  %4w				!* 4: Increment recipient count.!
	  l k >				!* Get rid of the full recipient line.!
	hfx1				!* 1: ITS-mailer recipient list.!
					!* Empty the parser buffer.!
	]..o g1'			!* Back to message.  Get ITS-TO-list.!

 !* Now do a similar thing for the CC field, though they have an (R-OPTION CC)!
 !* inside the recipient specification.!

 fsMachine:f6,q2 mpCC			!* Parse CC and leave point at it.!
 fq2"g	0l <k 0,1af	 :;>		!* There was a CC, kill the field,!
					!* including any continuation lines.!
	q2[..o j			!* To recipient buffer.!
	< .-z; :l 0f : fb@ :fx1	!* 1: Removed @host of next CC.!
					!* Note that we use the last @ in the!
					!* line.  Handle multiples, @FILE, etc!
 	  0l 1a-("n			!* Not a (...) form (yet).!
	    1af"[!'!"l		!* If not a [...] must quote if any!
					!* spaces inside it if not already.!
	      :fb "l 0l i" :l i"!''!''	!* ...!
	    0l i( :l i)'		!* Since not a (...), make it one.!
	  0l iRCPT: :lr i 1 (R-OPTION CC)	!* Finish it off.!
	  %4w				!* 4: Increment recipient count.!
	  l k >				!* Get rid of the full recipient line.!
	hfx1				!* 1: ITS-mailer recipient list.!
					!* Empty the parser buffer.!
	]..o g1'			!* Back to message.  Get ITS-CC-list.!


 !* Now do a similar thing for the BCC field, though they have an (R-OPTION!
 !* BCC) inside the recipient specification.!

 fsMachine:f6,q2 mpBCC		!* Parse BCC and leave point at it.!
 fq2"g	0l <k 0,1af	 :;>		!* There was a BCC, kill the field,!
					!* including any continuation lines.!
	q2[..o j			!* To recipient buffer.!
	< .-z; :l 0f : fb@ :fx1	!* 1: Removed @host of next BCC.!
					!* Note that we use the last @ in the!
					!* line.  Handle multiples, @FILE, etc!
	  0l 1a-("n			!* Not a (...) form (yet).!
	    1af"[!'!"l		!* If not a [...] must quote if any!
					!* spaces inside it if not already.!
	      :fb "l 0l i" :l i"!''!''	!* ...!
	    0l i( :l i)'		!* Since not a (...), make it one.!
	  0l iRCPT: :lr i 1 (R-OPTION BCC)	!* Finish it off.!
	  %4w				!* 4: Increment recipient count.!
	  l k >				!* Get rid of the full recipient line.!
	hfx1				!* 1: ITS-mailer recipient list.!
					!* Empty the parser buffer.!
	]..o g1'			!* Back to message.  Get ITS-BCC-list.!


 q4"e :i*No Recipients fsErr'		!* Message is illegal if not mailed!
					!* to anybody.!

 j iFROM-PROGRAM:BABYL
FROM-XUNAME: fsXUnamef6 i
FROM-UNAME: fsUnamef6 i
					!* Insert information about us.!
					!* Provide CRLF for beginning of!
					!* line searches.!
 j :s
FROM:"e 3l iAUTHOR: fsXUnamef6 i
'"# 
AUTHOR:'				!* Change FROM to AUTHOR or insert one!
 j :s
H:"l 
HEADER-FORCE: @fc'			!* Convert line following H: to U.C.!
 "# 3l iHEADER-FORCE:RFC733
'					!* Say which header to use.!

 j :s
S:
Re:"l 
SUBJECT:'				!* Allow S: and Re: for Subject:.!

 j :s
R:"l 
REGISTERED: @fc'			!* R becomes REGISTERED and line!
					!* after it is uppercased.!

 !* Check the fields to see which ones COMSAT will process, and put!
 !* USER-HEADER before the others, so they go through COMSAT verbatim.!
 !* Uppercase the ones that COMSAT does process.!

 0s:					!* Set search default once.!
 j < .-z;				!* Look at each line of header.!
     1af	 :"l l !<!>'		!* Ok if line begins with whitespace.!
     :fb"l r -@f	 k		!* Remove whitespace before colon.!
	    0x1				!* 1: Header field name.!
	    :fo..qCOMSAT 1 FIELD"l	!* One that COMSAT will process?!
	      0l iUSER-HEADER:'	!* No, so quote it!
	    "# 0@fc'			!* Yes, so uppercase the name.!
	    l !<!>'			!* Iterate on next line.!
     1a-15."e k !<!>'			!* If no colon on line, but not!
					!* empty, its garbage!
     :i*Garbage in message header fsErr	!* ...!
     >

 0s
USER-HEADER:ORIG-TO:
USER-HEADER:ORIG-CC:			!* uncomment fields we commented!
 j <:s; 8r 5d>				!* get rid of ORIG- part!

 0s:					!* Set search default!
 j <.-z; 1af	 :"l -l		!* Find continued lines!
    fb ;
					!* Replace colon with semi+return!
    .[0 <l .-z; 1af	 :; >		!* Pass continuation lines!
        .-2-q0( q0-2j )u0 q0\ i.	!* Insert char count!
    l q0c ]0 '				!* Move to end of last line in field!
    l >

 zj iTEXT;-1
					!* Separate text from header.!

 0,(fsZ)fsBoundariesw k		!* Kill --Text follows... line!

 !* For Babyl debugging, allow viewing of the message request  (queue) file!
 !* before we write it out.  Can allow it to be written (C-M-Z) or abort!
 !* (C-]): !
 0fo..qDebugging Babyl"n :i*Debugging Babyl[..j  ]..j'

 f[DFile etDSK:.MAIL.;MAIL >		!* Set filename default to the place!
					!* to write the mail to so mailer!
					!* will find it.!
 e\ fn e^				!* Push output transaction.!
 eihpef				!* Write the mail out.!
 @ft(mail queued) 0fsEchoActivew	!* Tell user we are done.!
 

!& TNX Mail Buffer:! !S Write buffer out to unsent-mail file.!
!* NOTE:     This function is MAILER-INDEPENDENT.  It will call a mailer-
	     dependent subroutine, named by the variable Babyl Queuing
	     Function.  That function can then write out whatever format file
	     it wants, set whatever flags it wants, etc.
  !
!*
Allows multiple To:s, Cc:s.  They are merged and auto-filled by & Process
    Recipient Field.
The original buffer stays the same -- we do all message-massaging in a
    temporary buffer.  This way the original buffer is available for
    resending if desired.
!
 m(m.m& Declare Load-Time Defaults)
    Babyl Queuing Function,
	Name of the mailer-dependent function for queuing mail:
	|& Default Babyl Queuing Function|
    Babyl Parser Control Flags,:0
    Babyl Header/Text Separator,
	* 1 line that separates header and text in recursive mail edit:
	|--Text follows this line--|


 f[DFile [1[2[3[4[5 0f[VB 0f[VZ	!* Widen bounds of message.!
 qBabyl Parser Control Flags7[Babyl Parser Control Flags	!* Set bits!
					!* for RFC822, for host reformation!
 g(q..o( f[BBind ))			!* Temporary buffer, with copy of!
					!* the message to send.!
 zj -2 f=
"n i
'					!* Make sure message ends in a CRLF,!
					!* since XMAILR at least needs that.!

 q..ou3					!* 3: Message copy buffer.!

 f[BBind q..ou4 q3[..o			!* 4: Temporary buffer for mailbox!
					!* list.  Push (so f[BBind pops and!
					!* kills ok) to message buffer.!

 qBabyl Header/Text Separatoru1	!* 1: E.g. --Text Follows...!
 j :s
1
"e :i*No text, just header fsErr'	!* Didnt find separator.!
 0:l 0k					!* Replace separator with blank line.!
 z-.fsVZ				!* Set bounds to just header.  Parser!
					!* and header-completer need bounds.!

 !* Note that by having the header completer go first, the BCC and FCC!
 !* searches later can be assured of a CRLF before the BCC: or FCC:, since!
 !* the Date field is put on the top line.!

 q4m(m.m& Complete TNX Header)		!* Add date, from, ensure good header.!
					!* It ensures that date is top line,!
					!* and header ends with blank line.!

 !* Do the FCC processing, i.e. appending to TNX mail files, now.  This is not!
 !* a great solution, but the problem is that doing it later will see all!
 !* those rubouts put in for XMAILR by the parser (at XMAILR sites) and the!
 !* mail file will contain those rubouts.  At least at this point we have a!
 !* semi-valid header -- valid enough for Babyl to handle at least, if not for!
 !* formal mailing.!

 0s
Fcc					!* Set search default once.!
 j <:s; @f	 l 1a-:"e c :x2 l-k	!* Get filename!
    etDSK:FOO.TXT fsHSnamefsDSnamew et2	!* Set default!
    0f[VZ m(m.m& Append to TNX Mail File) f]VZ '>	!* Append to file!

 fsMachine:f6u2			!* 2: Default host name.!
 m.m& Process Recipient Field[p	!* P: Parser.!
 0[Babyl Strip Local Host		!* Dont strip local host name in mail!

 !* Check the From and Sender fields:  be sure they have hosts specified, and!
 !* be sure they use @ instead of AT for RFC822: !

 q2,q4mpFrom
 q2,q4mpSender
 q2,q4mpOrig-To
 q2,q4mpOrig-Cc
 q4[..o hk ]..o				!* Empty the recipients collected from!
					!* From/Sender.  We only want To/etc.!

 q2,q4mpTo				!* Parse, pull together, and auto-fill!
					!* the TO fields.!
 q2,q4mpcc				!* Ditto for CCs.!
 q2,q4mpbcc				!* Ditto for BCCs!
					!* 4: Now filled in with mailbox and!
					!* full recipient lines (though we!
					!* dont actually want the recipient!
					!* lines).!

 0s
Orig-To:
Orig-Cc:
Orig-Fcc:				!* uncomment fields we commented!
 j <:s; 0l 5d>				!* get rid of Orig- part!

 0s
Bcc:					!* Set search default once.!
 j<:s; -4ck				!* Find Bcc lines and kill!
    <@f 	 @; k>>		!* Kill continuation lines also!

 j <  @f	 l			!* Past leading whitespace on line.!
      15.,1a-15."e 0lk'"# l'		!* Kill the line if just blank.!
      .-z; >				!* Go over each line in header.!

 0,fsZfsBoundw			!* Wide bounds.!

 !* For Babyl debugging, allow viewing of the message and recipient list (Q4)!
 !* before we write out the queue file.  Can allow it to be written (C-M-Z) or!
 !* abort (C-]): !
 0fo..qDebugging Babyl"n :i*Debugging Babyl[..j  ]..j'

 qBabyl Queuing Functionu5		!* 5: Name of queuing function.!
 q4m(m.m5)				!* Let the mailer-specific function do!
 					!* the queuing.!

!& Default Babyl Queuing Function:! !S Numarg is recipient buffer.!
!* This is the default for Babyl Queuing Function.  It checks for various!
!* things and handles a few different mailers.  It should probably be split,!
!* so it branches to various queuing functions, as it does for MMAILR.!


 !* A stab at some convenient way for site maintainers to specify which mailer!
 !* to use -- for running MMAILR, they put a file named BABYL.USE-MMAILR in!
 !* the EMACS: directory.!

 e?EMACS:BABYL.USE-MMAILR"e		!* If this exists, we use MMAILR,!
					!* which is much like XMAILR, for!
					!* flags, e.g.!
    f:m(m.m& MMAILR Babyl Queuing Function)'




 [2 q..o[3 [4 [5			!* 3: Message buffer.!
					!* 4: Recipient buffer.!

 q4u..o j				!* Select recipient buffer.!
 etPS: :i5EMACS:			!* Main structure;  EMACS directory.!
 fsOSTeco-2"e etDSK: :i5DSK:<EMACS>'	!* If TNX use DSK: and <EMACS>.!

 !* BABYL(M) may be generated together with the IMAIL library for sending mail!
 !* with the IPCF mailer, and for non-net sites.  If so, see how many we can!
 !* send to: !
 1,m.m& Immediate Mailf"nu2		!* 2: 0 or & Immediate Mail.!
    e?emacs:immediate-mail.exe"e	!* If this is there, use IPCF mailer!
      q3m2'				!* And fall through to queue remotes!
    z-b"e ''w				!* Nobody left to send to.!

 e?<SYSTEM>XMAILR.FLAGS"n		!* If this exists, use XMAILR.!
					!* Does not exist, use MAILER.!
   e?<SYSTEM>MAILER.FLAGS"n		!* See if any mailer at all...!
      :i*No Mailer For Queued messagesfs err'	!* Nothing there!

   etDSK: fsHSnamefsDSnamew		!* Default filename to home dir.!
   < .-z; :x2 q3u..o			!* 2: Mailbox name.  Switch to message!
					!* copy buffer.!
     et[--UNSENT-MAIL--].2		!* File to use when close.!
     f[DFile et[TECO] OUTPUT 0fsDVersionw ei	!* Open to safe file.!
       f]DFile hpef			!* Write mail file for this recipient.!
     @ft(Mail to 2 queued)		!* And tell user.!
     q4u..o 2l				!* Past mailbox and full recipient to!
					!* next mailbox name.!
     >					!* Repeat for other recipients in!
					!* this line.!
     -(@fz5QUEUE-MAIL.SAV)fz'	!* Use inferior to set bit!
					!* in MAILER.FLAGS to queue it.!

 "#					!* Will use XMAILR to send.!
     :f : fb@$  :l  2l 		!* Sort recipients by host name, each!
					!* being a pair of lines.!
    j :i2				!* 2: Initialize current host name.!
    <.-z; :f : fb@ d :f~2"e :k'"# :fx2 0l 14.i g2 i
'   l k>				!* 2: Put recipients for one site on!
					!* one page and update current host.!
					!* The full recipient lines are!
					!* discarded.!

    f[dfile				!* save file defaults!
    j <:s.ARPA
;					!* find .ARPA domain!
    fkc :k				!* remove it!
    >					!* do all of them...!

    <:s
"@; !'! -2d i@ :l -d 0l c :x2		!* [fHsu]find indirections!
      q2fsdfile			!* [fHsu]set default!
      1:< 4,er >"e			!* [fHsu]let mailer complain!
	g(fs I File)
	-@f0123456789k		!* [fHsu]get rid of version num!
	-d :k'				!* [fHsu]replace with full name!
      "#
      :i* Local File does not exist: 2 @fg'w	!* [fHsu]give warning!
      >					!* [fHsu]end of indirection code.!
    f]dfile				!* restore default file!
    zj					!* to end of recip. buffer.!

    14.ii
   g3					!* Put message on next page.!
    etDSK: fsHSnamefsDSnamew		!* Default to home directory.!
    et[--NETWORK-MAIL--]..0	!* File for XMAILR.!
    f[DFile et[TECO] OUTPUT 0fsDVersionw ei	!* Open to safe file.!
      f]DFile hpef			!* Close to XMAILR file.!
    er 11.fs IF FDB&7777777777.,11.fs IF FDB EC !* Get file back, set !
					!* generation-retention count to 0 !

					!* BBN sites should!
					!* set variable Babyl Subfork Control!
					!* so subfork is kept!
    m(m.m& Run Mail Subfork)5QUEUE-XMAIL.EXE'

 0fsEchoActivew			!* Keep echo printout there.!
 

!& MMAILR Babyl Queuing Function:! !S Numarg is recipient buffer.!
!* To use this, either edit ALL the declarations of the variable Babyl Queuing!
!* Function so that its definition is the name of this function, or else!
!* generate BABYL or BABYLM with another file that has an & Setup.. function!
!* that explicitly sets the Babyl Queuing Function.!

!* ***We should find a way to have this automatically set, i.e. find something!
!* to test whether MMAILR is in use.!

 [2 q..o[3 [4				!* 3: Message buffer.!
					!* 4: Recipient buffer.!
 q4u..o j				!* Select recipient buffer.!

  :f : fb@$  :l  2l 		!* Sort recipients by host name, each!
					!* being a pair of lines.!
 j :i2					!* 2: Initialize current host name.!
 <.-z; :f : fb@ d :f~2"e :k'"# :fx2 0l 14.i g2 i
' l k>					!* 2: Put recipients for one site on!
					!* one page and update current host.!
					!* The full recipient lines are!
					!* discarded.!
 14.ii
 g3					!* Put message on next page.!
 fsXUName[u[d 8[..E fsDate:\ud ]..E	!* Get uname and TAD for queue file!
 etMAILQ:[--QUEUED-MAIL--].NEW-D-U-BABYL.0
 f[DFile etDSK: fsHSnamefsDSname	!* Default to home so we can rename!
    et[TECO] OUTPUT 0fsDVersionw ei	!* Open to safe file.!
    f]DFile hpef			!* Close to MMAILR file.!
 @ft(mail 				!* Start telling user.!
 1:< -(@fzEMACS:WAKEMM.EXE)fz >	!* Try waking up MMAILR.!
 @ftqueued)				!* End telling user.!
 0fsEchoActivew			!* Keep echo printout there.!
 

!& Complete TNX Header:! !S Make sure From and Date fields are there, etc.
Numarg is recipient-list buffer.!
!*
Remove blank lines in header.
Change S: and Re: to Subject:, and
replace the Babyl Header/Text Separator line with a blank line.
Expects bounds around just header.

The caller is expected to go over the From and Sender fields, calling the
recipient parser (& Process Recipient Field), to ensure that the host names
are there, and to ensure that @ is used for RFC822 instead of AT.!

 m(m.m& Declare Load-Time Defaults)
    Babyl Day of Week Flag,
	* (TNX only) If non-0 day of week is added to Date field of outgoing mail: 0
    Babyl Personal Name,
	* (TNX only) A full name to use with user name as in Personal Name <ME at HERE>: 0
    Babyl User Name,
	* (TNX only) A name to use in From field possibly overriding username: 0
					!* End of declare.!

 [0[1[3[4
 j < :s

; -k 2r >				!* Delete blank lines in the header.!

 m(m.m& Maybe Insert In-Reply-To)

 j 5 f~Date:"n			!* If date isnt at top,!
    :s
Date:"e				!* And isnt elsewhere,!
      iDate: 
     0:l				!* then make one.!
      .u1				!* 1: Start of date.!
      212221000000.,fsDatefsFDConvertw	!* Let TNX do the work, e.g.!
					!* Wed 16 Mar 1983 10:10-EST!
					!* But for RFC822 we need, e.g.: !
					!* Wed, 16 Mar 1983 10:04 EST!
      .-z( 0,-3a--"e 4r di  r'	!* Leave point before space for -S.!
					!* Remove the hyphen, RFC822 illegal.!
	   -s  i 			!* 2 spaces between date and time.  OK!
	   q1+3j 0,1a- "e i,'	!* Comma after the day.!
		   )+zj			!* by rfc822, and prettier.!
      qBabyl Day of Week Flag"n	!* User wants day of week in there.!
	.-z( 0l 6c .(s,r),.fx3 2d	!* 3: Day.!
	     )+zj i (3)'		!* Use (day).!
      '"# 0l fx1 bj g1'			!* If had a date field before, put!
					!* it at the top.  Helps below as!
					!* well as being standard.!
    '					!* End of date field.!

 fsXUname:f6u0				!* 0: user name.!
 fsMachine:f6u3			!* 3: host name.!
 fq3"g :i00 at 3'			!* 0: User at Host.!

 j :s
From:"e				!* If no from field yet, make one.!
      l iFrom: 
     2r .u1				!* 1: Start FROM field!
      qBabyl User Nameu3 fq3:"g q0u3'	!* 3: Babyl user name, or USER at HOST!
      g3				!* insert it!
      qBabyl Personal Nameu3		!* 3: Full name.!
      fq3"g q1j g3 i < :l i>'		!* Maybe put in RFC733 style from with!
					!* personal name.!
      q1j				!* return to start of field!
      '					!* Done inserting new from: field!

 @f 	l .u1				!* 1: Start of FROM field.!
 :l .u3					!* 3: end of from field.!
 -:s<"n .-q1:"l			!* look for RFC733 style header!
      c .u1				!* 1: save point as start of field!
      :s>"'e + (.-q3"'g)"n		!* look for close bracket!
            :i*Unmatched < ... > found in From: field fsErr'
      r .u3''				!* 3: save point as close of field!
 q3j q1,.f~0"n			!* Check if it matches known user.!
      fsXUName:f6u3			!* 3: didnt, get bare uname!
      q1,.f~3"e			!* if that matched!
	    i at 			!* add at!
	    fsMachinef6'		!* and machine!
      "# 0l .u4 j :s
Sender:(q4j)"e iSender: 0
'''					!* else add Sender: field!
					!* done with From: field!

 j :s
S:
Re:"l					!* Can do search with CRLF since!
					!* date appears on top line.!
    0k iSubject:'			!* Change S: and Re: to Subject:.!

    j :s
Message-ID:"e				!* generate Message-ID: field?!
    l iMessage-ID: < fsXUNamef6 .i fsDate\ i.BABYL@	!* ...!
    fsMachinef6 i>
'

					!* Now clean up To/Cc fields: *!
 j < :s
To:
Cc: ;					!* A start of a To/Cc field.!
     @f 	,k i 			!* Ensure one space after colon.!
     <:fb,; @f 	k i >		!* Only one space after commas.!
     0l <:fb, , ; ,  2r>		!* Eliminate empty entries.!
     0l 4c 0,1a-15."e			!* If next line is not a continuation,!
	0,3af	 "l			!* then this must be an empty field.!
	  0lk 0:l''			!* So kill it.!
     >					!* Done formatting To/Cc fields.!

 

!& Process Recipient Field:! !S Merge, reform and parse.  See source for args.!
!* 
NUMARG is recipient buffer, pre-comma NUMARG is default host name.
STRARG is field name, without any colon.
Bounds should be set to just the header.
Point is left at the start of the field body.
Recipient buffer has the parse, a pair of lines per recipient:  1st
    line is mailbox name, 2nd line is full (cleaned up) recipient
    specification.  Host names are upper-case since TWENEX mailer
    requires it.!

!* Variables that the caller or user may set:
   Babyl Strip Local Host		Non-0 means we strip local host.
   Babyl Parser Control Flags		Has bit-flags:
      1-bit:  Non-0 says mail is going out.  So use @, not the word at; check
	      for rfc822 specials forcing personal name quoting.
	      Also signals that rubouts may be used if 2-bit on.
      2-bit:  Non-0 says to put rubouts around host name.
	      E.g. for XMAILR, which will change to full host names, and/or
	      handle USER%MIT-OZ@MIT-MC etc.  Only for outgoing mail, i.e. the
	      1 bit is also on.
      4-bit:  Non-0 says to put only one recipient per line.  E.g. for XMAILR
	      when it is expanding hostnames (with rubouts around them) -- it
	      will do the auto-filling.  For now, it NEEDS one-per-line.  Only
	      for outgoing mail.
   !

!*  All instances of the field are merged into one, with continuation
    lines.  Some cleaning is done (of whitespace, @s), host name is
    added if necessary, and field is auto-filled.
    If variable Babyl Strip Local Host is non-zero, then the local host
    name is removed.  We experimented with the idea of removing all at-ITSes
    on any ITS, but there are names (not those in INQUIR) which are not
    defined on the local host.  And removing the host name is not an obviously
    wrong thing -- the user doesnt know that it is wrong.  Whereas one reason
    for removing any ITS was to catch this-user at another-its, and not get
    duplicates when reply sets up -- it wont know that FOO@AI = FOO@MC.  But
    the user sees this and correct for it if desired, whereas cant see the
    alternatives problems.  And getting two copies of a message isnt a
    disaster.!

 m(m.m& Declare Load-Time Defaults)
    Babyl ..D,:0
    Babyl Strip Local Host,
	* Non-zero removes local host from reformed headers: 1
    Babyl Parser Control Flags,:0

 [0[1[2[3[4[5[6[7[8[9[.0[.1[.2[.3 [..o	!* save regs!
 qBabyl ..D[..d			!* All set up for nifty parsing,!
					!* especially using s-expressions.!

 !* Find all instances of this header field and merge them into the first one!
 !* found.  And merge all its continuation lines into a long 1-line field for!
 !* easier parsing.  (We will fill it later.)!


 @fn|.-z(j 0,1a-15."e 2d')+z:j|		!* Will cleanup top blank line.!
 j i
					!* Boundary condition for search.!
 f[VB f[VZ				!* Restore bounds before the top-line!
					!* cleanup goes off.!

 qBabyl Strip Local Host"n fsMachine:f6u7	!* 7: Local host.!
    fsOSTeco"e :i7 at 7 at MIT-7 '	!* With ATs for stripping.!
    "# 
      f~7MIT-OZ"e			!* Special hack.... ugh...!
					!* Careful of order of search parts.!
					!* I.e. not PREFIXLONGER, as the!
					!* prefix would then be the match.!
	:i7 at 7%7 at MIT-MC.ARPA%7 at MIT-MC ' !* ...!
      "# :i7 at 7 '''		!* 7: ...!
 "# 0u7 '				!* 7: Zero if keeping the local host.!

 u8 q..ou9				!* 8: recipient buffer, 9: header!
					!* buffer.!
 0s
					!* Initialize search string to CRLF!
					!* field name.!
 j <:s"e 0' @f	 l 0,1a-:@; >    !* Find first such field.!
 c @f	 k 5-(fsHPos)f"lw0',40.i .u0	!* 0: point just before first!
					!* ..non-whitespace.!
 < l 0,1af	 :; 0:k >		!* Merge continuations.!
 0:l .u1				!* 1: end of first field.!

 < :s; @f	 l 0,1a-:"n ! <!>'	!* Find next such field.!
   c 0k					!* Kill field name.!
   < :l k 0,1af	 :; >		!* Merge continuations.!
   0fx2 q1j i, g2 .u1			!* Remove it from here and go append!
   >					!* field body to first.!
					!* 1: Still end of first field.!

 q0j .f[VB fsZ-q1f[VZ		!* Set bounds to just this field!
					!* body.!



 !* Now we parse this 1-line recipient field.!
 !* Qregs set above and used below:  Q7 (trimming hosts), Q8 (recipient!
 !* buffer), Q9 (header buffer).  All others available for use.!

 qBabyl Parser Control Flagsu0	!* 0: Bit flags.!

 <					!* Iterate over recipients.!
   @f	 ,k .-z; .u1 i 		!* Move to beginning of next!
					!* recipient.!
					!* 1: Point where recipient starts,!
					!* before one leading Space.!
   .u.0					!* .0: Possible uname start, after the!
					!* leading Space.!
   -1u6 0u2 0u.2			!* 6: <> state, 2, .2: @ flags.!

   <					!* Iterate over tokens.!
     @f	  f"gd i 'w .-z;	!* Skip over whitespace.  To 1 space.!
     1au5 q5"b c :o5 r'		!* Dispatch if break character.!
     q6:"g				!* If not past <>...!
	@flu4u3 q4j			!* 3,4: bounds of sexp.!
	q3,q4f~at"e oAT'		!* Is an AT word token.!
	q3-b,q4-b(q8u..o)g9		!* Add sexp to recipient buffer.!
	i  q9u..o ! <!>'		!* And go get another token.!
     ! <!:i*Text after > in recipientfsErr	!* ...!
     !<! q1,.-1x.3			!* .3: Personal name field.!
	 f[BBind g.3			!* Into temp buffer.!
	   q0&1"n			!* Outgoing mail, so see if personal!
					!* name field needs quoting.!
	    !* First a check for 822 specials and whether we can quote the!
	    !* entire personal name field, a common, prettier case: !
	    j :@f;:.[]l .-z"n	!* Yes, there are some specials.!
	      j :s"!'!"e		!* No double-quotes at all, so can!
		j @f	 l i"!'!	!* quote the whole field.!
		zj -@f	 l i"!'!'	!* ...!
	      "# j			!* Already some double-quotes, so be!
					!* more careful -- use \-quoting and!
					!* ignore stuff in quoted forms.!
		< @f	 l		!* Past whitespace.!
		  .-z;			!* Stop at end.!
		  0,1a-"!'!"e @fll'	!* Skip over already quoted forms.!
		  "# !* Check the unquoted forms for 822 specials: !
		     @flfsBoundw	!* Bounds around this next form.!
		     < :@f;:.[]l .-z;	!* Find next special.!
		       0,0a-\"n i\' c >	!* \-quote it if not already.!
		     zj 0,fsZfsBoundw' 	!* Wide bounds.!
		  >'''			!* ...!
	   "#				!* Incoming mail.!
	      !* See if whole personal name field is quoted, and if can!
	      !* unquote it since it just has the new 822 specials, e.g. dot.!
	      j @f	 l 0,1a-"!'!"e	!* Quote at the start.!
		.u.0			!* .0: Start.  Temp re-use...!
		zj -@f	 l 0,0a-"!'!"e	!* Quote at end.!
		  .u.2			!* .2: End.  Temp re-use...!
		  q.0+1j @f	 0123456789!#$^&*-/=?`{}|~ ;:.[]
		  ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzl
		  !* Those are all ok for Babyl -- it doesnt need them quoted.!
		  .-q.2+1"e		!* That left us at end quote.!
		    d q.0j d''''	!* So can remove the quotes.!
	   hx.3 f]BBind		!* Back to original buffer.!
	  r q1,.k g.3 c			!* Replace with quoted name.!
	 .u.0 0u.2 0u2			!* .0, .2, 2: Reset where uname is!
					!* 6: Flag saying have angle-bracket!
	 q8u..o 0k q9u..o %6"e ! <!>' :i*Extra < in recipientfsErr
     !>! q6"e .-1u6 ! <!>' :i*Extra > in recipientfsErr	!* ...!
     !,! r -@f k c 0;		!* Comma ends a recipient.!
     !AT! q0&1"n -3d i@ d'		!* AT becomes @ for RFC822, with no!
					!* Spaces before or after it.!
	  o@-AT			!* To common @/AT code.!
     !@! q0&1"e -d 0a-32"n i ' iat 1a-32"n i  r''	!* @ becomes at.!
	 !@-AT!				!* Code common to @ and AT.!
	 q2"n				!* Have another @ earlier.!
	      q0&1"n .-z(q2j -d i%)+zj	!* If RFC822, change earlier!
		     q8u..o q.2j -d i% :l q9u..o''	!* @s to %s.!
	 .u2 				!* 2: Point after at, and a flag.!
	 q8u..o .u.2			!* .2: Point after at in recip buf.!
	 0f  "e		
	    !* If mailbox line empty so far we either have a null recipient or!
	    !* a parenthesis recipient.  (Parentheses usually surround!
	    !* comments, but if there is ONLY a comment we assume it is an ITS!
	    !* thing like (BUG FOO).)!
	    q9u..o -2:@fll .u3		!* 3: Maybe point after (...).!
	    -@fll .-q1-1"n :i*Null recipientfsErr'	!* Not just (...) as!
							!* the recipient.!
	    .-b,q3-b(q2j q8u..o)g9'	!* Ok, add (...) as the recipient.!
	 -@f k i@ q9u..o ! <!>	!* Insert @ into recipient buffer and!
					!* go get another token.!
     !(! fll				!* Skip over comments, (...).!
     >					!* End of token iteration.!

   q8u..o -@f k			!* Select recipient buffer.!
   q2"e					!* We havent had a @ yet; use default.!
	0f  "e
	    !* If mailbox line empty so far we either have a null recipient or!
	    !* a parenthesis recipient.  (Parentheses usually surround!
	    !* comments, but if there is ONLY a comment we assume it is an ITS!
	    !* thing like (BUG FOO).)!
	  q9u..o .u2 -:@fll .u3		!* 3: Maybe point after (...).!
	  -@fll .-q1-1"n :i*Null recipientfsErr'	!* Not just (...) as!
							!* the recipient.!
	  .-b,q3-b(q2j q8u..o)g9'	!* Ok, add (...) as the recipient.!
	i@ g()			!* Add default host name, if none, to!
					!* recipient buffer.!
	q9u..o .-z(q6"g q6j'"# -@f, l'	!* And header.!
		   q0&1"e i at '	!* Is not outgoing mail.!
		   "#	  i@		!* Is outgoing, so use @, and maybe...!
			  q0&2"n i''	!* ... surround host with rubouts.!
		   g()		!* Insert the host name.!
		   q0&3#3"e i'	!* If both 1 and 2 bits on, then!
					!* surround host with rubouts.!
		   )+zj'		!* ...!
   "#					!* We did have an @/AT.!
      q9u..o				!* To header buffer.!
      q0&3#3"e				!* Surround host with rubouts?!
	!* This mess should be using results of parsing -- except we dont have!
	!* that detailed information...  Sigh...  Someday should get the guts!
	!* to return more information about placement of the host name?!
	.-z( <	! <!-@f
			 ,>l		!* Yes.!
		!(! 0a-)"e		!* Skip comments after host name,!
			    -@fll !<!>'	!* ...and keep looking for host.!
		1; >			!* Have found the host name.!
	     i			!* Rubout after ...!
	     q2j @f	 l i	!* ...and before host name.!
	     )+zj''			!* Ugh...  What a mess.!
   q8u..o				!* Back to recipient buffer.!

   :l -s@ @fc :l			!* Uppercase host name.!
   i
					!* Finish off mailbox line.!
   g(q9[..o q1+1,.x*(]..o)) 0a-,"e -d' i
					!* Put in full recipient line, without!
					!* any ending comma.!
   q9u..o				!* Select header buffer.!

   !* Maybe flush local host name, iff it is at the end of the recipient!
   !* field.!

   q7"n					!* Trimming host for header reformer.!
	  .-z( -@f,<>l .u3 -:s7"n fk+.-q3"e fkd ''	!* 3: temp!
	       )+zj'			!* Restore point.!

   !* Done that recipient.  See if we need to auto-fill here.  We fill at!
   !* column 70.!

   q0&5#5"e oFILL-BREAK'		!* Auto-fill after EVERY recipient.!
   fsSHPos-70"g  !FILL-BREAK!		!* Auto-fill after column 70.!
      q1-b-4"g .(q1j i
     	)+7j''				!* Auto fill, making next line a!
					!* continuation, indented 6 spaces!
					!* (these 5 plus the standard 1 we put!
					!* on).!

   >					!* End of recipient iteration.!



 !* Done parsing this recipient field.  Do minor final cleanup.!

 -@f, k				!* Remove any trailing commas or!
					!* spaces.!
 j					!* Leave point at start of field body.!
 

!& Append to TNX Mail File:! !S Append buffer to default file, with header!
 !* Note that Babyl File Version does not have to be handled here -- this!
 !* routine always appends to exactly the same file, same version, etc. A !
 !* numeric argument is the date to write out in the TNX header. !

 !* Check that this is not a Babyl file -- appending this kind of!
 !* non-Babyl-format junk can really wreak havoc.  And sometimes it can seem!
 !* natural, e.g. for FCC, to try it.  (We should perhaps handle that case.)!

 fsQPPtr( e[fne]  f[BBind 1:<er 16fy ec>w hf~BABYL OPTIONS:
"e fsDFile[1 :i*Attempt to append TNX format mail to Babyl file 1fsErr'
    )fsQPUnwindw

 FF-1"E [0 '"# FS Date[0 '
 j h (20000000.,Q0 fsFDConvert ,i)\ i;000000000000
					!* insert TNX message header!
 j e?"e fsDFilem(m.m& Babyl Append)"n jk'	!* append to old file if any!
    z-.fsVZw er fsIFilefsDfilew @y	!* prepend old file to buffer!
    zj 0fsVZw'				!* ...!
 f[DFile et[TECO] OUTPUT 0fsDVersionw ei	!* Open to safe file.!
    f]DFile hpef			!* Write out new contents of file.!
 b,.k k					!* kill old contents and header line!
 

!& Babyl Append:! !S Append B,Z to NUMARG file. Returns non0 iff success.!
 !* Note that Babyl File Version does not have to be handled here -- this!
 !* routine always appends to exactly the same file, same version, etc.!
[1 e[e\fne^e]			!* 1: filename.  push input, output!
 er1 fsIFLengthu1 q1/5*5-5fsIFAccessw
 j @fn|b,.k| fsZ-.f[VZ @y zj f]VZ	!* Preserve Z-bound.!
 1:<@:ei>"n 0' fsOFLength-q1"n :i*File changed size??fsErr'
 q1/5*5-5fsOFAccessw hp :ef 1	!* Make sure to not write out tail!
					!* end of the Babyl file.!

!& Setup BABYLM Library:! !S Create some variables needed, do init/vars file.!

 m(m.m& Declare Load-Time Defaults)
    Babyl ..D,:0
    Babyl Parser Control Flags,: 0
    Babyl Setup Hook,
	If non0, is run immediately after loading Babyl library: 0
    Babyl Queuing Function,
	Name of the mailer-dependent function for queuing mail:
	|& Default Babyl Queuing Function|


 !* Note that & Setup BABYL Library will also call & Setup BABYLM Library, so!
 !* loading either BABYL or BABYLM will cause init/vars file processing, and!
 !* only once between them.!

 1,m(m.mProcess Babyl Init or Vars File)	!* Process if havent yet.!

 !* Set up Babyl ..D, used for parsing: !

 qBabyl ..D"e				!* If 0 hasnt been set up yet.!
    [1[2 128*5,40.:i1			!* 1: Everythying starts out as a!
					!* break character.!
    40.u2 176.-40.<%2*5:f1AA>	!* 2: Set up normal characters to be!
					!* letters, both for words and!
					!* s-expressions.!
    "*5:f1 | !'!			!* Double-quote delimits a string.!
    \*5:f1 /			!* Backslash is an escape character.!
    (*5:f1 (			!* Parentheses are parentheses.!
    )*5:f1 )			!* ...!
    @:i2| *5:f1  |			!* 2: Macro to set random break char.!
    <m2 >m2				!* Brackets are random breaks, as are!
    ,m2 @m2				!* comma and at-sign.!
    q1uBabyl ..Dw'			!* Save that away for the parser.!

 !* Check which mailer to use, and set up to use the mailer-specific queuing!
 !* function, and tell the parser anything it needs to know: !

 !* ***This needs to do more here to determine the mailer, rather than in!
 !* & Default Babyl Queuing Function.!

 !* For now, just determine whether XMAILR is being used, and thus whether the!
 !* parser should put rubouts around the host names: !

 fsOSTeco"n				!* On a TNX, not an ITS.!
    f[DFile etPS: fsOSTeco-2"e etDSK:'	!* PS: or, on TENEX, DSK:.!
    e?<SYSTEM>XMAILR.FLAGS"e		!* If this exists, we use XMAILR.!
      qBabyl Parser Control Flags6(	!* Turn on bits to have rubouts around!
					!* host names, and only 1 recip/line.!
	)uBabyl Parser Control Flags''

 !* Running BabylM should be just like running Babyl, except that those!
 !* functions not needed in the library are not around, and so the load is!
 !* quicker.  This means we still must run the user setup hook.  If that hook!
 !* wants, it could see which library is loaded, e.g. by!
 !*  f~(m(m.m& Get Library Pointer)Babyl m.m~FILENAME~)BabylM   !

 qBabyl Setup Hookf"n[1 m1'w		!* Run user hook if any.!



!& DECnet Mail Buffer:! !S Do DECnet stuff!
					!* none of this has been tested...!
    e?SYSTEM:DECNET-MAILER.FLAGS"n	!* is it there? !
            :i*No Mailer For Queued messagesfs err'	!* Nothing there!

     :f : fb@$  :l  2l 		!* Sort recipients by host name, each!
					!* being a pair of lines.!
    j :i2				!* 2: Initialize current host name.!
    <.-z; :f : fb@ d :f~2"e 0l k'"# :fx2 0l g2 k' k>
					!* make buffer a list of host names!
   etDSK: fsHSnamefsDSnamew		!* Default filename to home dir.!
   < .-z; :x2 q3u..o			!* 2: Mailbox name.  Switch to message!
					!* copy buffer.!
     et[--DECNET-MAIL--].2		!* File to use when close.!
     f[DFile et[TECO] OUTPUT 0fsDVersionw ei	!* Open to safe file.!
       f]DFile hpef			!* Write mail file for this recipient.!
     @ft(2: queued)		!* And tell user.!
     q4u..o l				!* Past host to next host!
     >
     -(fz5QUEUE-DMAIL.EXE)fz	!* twiddle bits...!
 

!Net Mail:! !C Send off network mail in user directory!
    e?SYSTEM:XMAILR.FLAGS"e
      -(fzSYS:XMAILR.EXE)fz'
    "#
      -(fzEMACS:EMAILER.EXE)fz'w	!* TENEX needs privs disabled!
    					!* run link file that does this!

!& Run Mail Subfork:! !S Run Queue-Xmail to send our local mail, or
queue network mail and set bits in SYSTEM:XMAILR.FLAGS.
Note: if Babyl Subfork Control is non0, DONT dump after sending a message.!
  m(m.m& Declare Load-Time Defaults)
    Babyl Mailer Subfork,:0
    Babyl Subfork Control,
     Controls handling of QUEUE-XMAIL subfork.
     Non0 ==> Keep and read RSCAN; 0 ==> Dont keep and no RSCAN
     Note that a special QUEUE-XMAIL is needed if you set this :0

[0 [1

 qBabyl Subfork Controlf"euBabyl Mailer Subfork	!* no keep?!
   @ft Queuing...
   -(@fz)fz			!* run ephemeral!
 '"#
   @ft Sending...			!* say we're working on it.!
   qBabyl Mailer Subfork"e		!* see if we have one already!
    @fzuBabyl Mailer Subfork'"#	!* STRARG is program to run.!
    f*w qBabyl Mailer Subfork@fz'	!* eat STRARG if have one!
  f[b bind		!* Work in temp buffer. maybe use spec buffer?!
  <			!* loop to read reply from rscan!
  fs listen"E		!* If run out of input early,!
   :i* ?Success unknown: ..o @fg '
			!* Complain, but dont die!
   fiu1 q1-177.@;			!* DEL ends all input.!
   q1-176."e				!* tilde ends single response.!
     j :s?:"n			!* did we get an error?!
       -(qBabyl Mailer Subfork)fz	!* kill dead fork.!
       0uBabyl Mailer Subfork		!* fatal error. get new one next time.!
       sn:				!* past ?:unhandled exception: biz.!
       :x0				!* rest of error msg.!
       :i*
Fatal error: 0; Abort & Reset...Done @fg '
     :s?"n
Error: ..o; Continuing... @fg '
     j :x0 @ft[0] 			!* show recipient!
     hk				!* kill him!
     qBabyl Mailer Subfork @fz'	!* go send some more, maybe!
   "# q1i' > w				!* read character, loop for more!
 'w
     @ftDone.				!* all done. go home now...!
 

!* 
 * Local Modes:
 * Fill Column:78
 * Comment Column:40
 * End:
 *!
   
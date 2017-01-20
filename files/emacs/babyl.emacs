!* -*-TECO-*- *!

!*
 The latest sources for Babyl are MC: EMACS1; BABYL > and MC: EMACS1; BABYLM >.
     You can just use the Compile command -- it will get these sources and put
     the result in MC: ECC; XBABYL :EJ, which is the latest version being
     tested.
 The source for the installed EMACS; BABYL  :EJ is either some BABYL nnn
    (see the automatically-generated description of & SetUp Compressed
    BABYL Libraries) or MC: ECC; BABYL  SOURCE if patched.  (Rare)
 The source for the installed EMACS; BABYL' :EJ is some BABYL nnn or MC:
    ECC; BABYL' SOURCE.  (Rare)

 Maintainers:  Note that there are some conventions regarding documentation.
 I (ECC) have a library that produces the INFO file command/variable
 abstracts, that expects these conventions:  First, use of SubDoc must come at
 the end of documentation, and start out exactly alike, see an example.
 Second, documentation may contain (anywhere) code to INSERT other
 documentation.  E.g. see documentation for |.

 Modification history:

 1/25/85 773	KMP	The warning about locked mail file which used to read
			"... some other program, such as MM, ..."
			was changed to read
			"... another program, such as MM or the mailer, ..."
10/09/84 772	ECC	Have F take string args when called as subr, and not
			have parse errors be fatal.  Change Babyl Reformation
			Merges From/Reply-To to default 0, less confusing.
 4/12/84 770	ECC	^T to show load average.  Edit Labels List cleans up
			,,s and makes CRLFs separate labels.  Added pushes to
			*Babyl* so can use M-X instead of (in addition to) X
			in SvMenu:  Label Labeled Messages, Delete Labeled
			Messages, UnDelete Labeled Messages, Output Labeled
			Messages, Label Message, Edit Labels List, and
			Label Messages Containing String.  Slight problem:
			SvM doesnt know resurveying needs to be done.
			***We still need to fix the bug about sorting, losing
			bounds, and autolabeling.
01/05/84 765	KMP	Added babyl options Expiration-Check-Interval
			and Expiration-Check-Time. This should not affect
			normal Babyl users but will be essential to ZBabyl
			at some point.
11/30/83 764	KMP	Make & Jump to Current Survey Line be much more
			choosy about where it goes.
11/27/83 763	KMP	Make & Babyl Set Mode Line do f[InsLen and f[SString 
			since it can go off at unpredictable times in the
			middle of things which are relying on the default.
11/18/83 762	ECC	Move trimming of BBOARD, SYSTEM, etc. out of & Setup
			Reply Template as special cases to use vars.  Also,
			change & Babylize Buffer to handle either TNX or ITS
			mail files on either system.  Thus you can I to either
			file on any system, for example.  Fixed bug in & Form
			Header, to not put space after colons in contin lines.
11/02/83 759	ECC	Bump version number, since BabylM changed.
10/22/83 757	ECC	Received: field flushed by default.  ^S code cleaned
			slightly -- :Ms and Ms made consistent, commented.
			Clean up some documentation:  ^C/^Z, ^X.
09/21/83 754	ECC	Switching to use the new survey arg code.  Consists of
			deleteting the old survey functions, renaming the New
			Survey.. functions to just Survey.., and deleting the
			changeover helper Use New Survey Commands.
			Changed default for Babyl Reformation Flushes These
			Fields to be more conservative: no longer flushes
			Redist.. and Keywords.  Just low-level things.
08/06/83 752	ECC	Extended Output Labeled Messages for use as subr.
06/26/83 750	SHSU	Add # Babyl > and # Babyl < to get to end-begin of
			current message. no :EJ file generated.
06/09/83 749	ECC	Put in new survey arg code.  For now, since
			incompatible change, all replacement functions have
			New... names, e.g. New # Babyl B.  See & Setup... and
			Use New Survey Commands function.  In a few weeks or
			so, after users have changed hooks etc., will fully
			install these functions.  More ITS 3F work.
06/08/83 745	ECC	Worked on ITS 3F a bit.
06/06/83 744	ECC	& Setup Reply Template made more robust when cannot
			parse recipients.  User can now continue, edit header.
05/26/83 742	ECC	\ checks Fill Extra Space List.  A revised so nA
			doesn't iterate, printing survey headers etc.  3F
			should now work on ITS (added :f6s).  Labels list when
			created will default to the semi-official default user
			labels, e.g. RemindNow.
05/18/83 740	KRONJ	Improve date reformatter.
04/14/83 739	ECC	Fixed ^S prompting and ? bugs.
04/11/83 738	ECC	Added Sam Hsu's ^W command.
04/10/83 737	ECC	BabylM now calls Babyl Setup Hook, in its & Setup..
			Noisy warning of unknown babyl options commented out,
			for ZMail options.  Reformation customizing extended
			by adding Babyl Reformation Control and Babyl
			Reformation Flushes These Fields;  users can now
			specify which fields appear, which dont.  | can take
			negative args, & Map Over Labeled Messages too.  B
			takes negative args.  Survey Undeleted Messages added.
			^SUx form added for Survey UN...  R and F also query
			for aborted mail.
03/09/83 734	ECC	Remove OZ-hack in & Form Header, since XMAILR is now
			taking care of USER@OZ, e.g. turning it into
			USER%MIT-OZ@MIT-MC if it thinks it necessary.  Changed
			& Setup Reply Template so that Babyl CC To overrides
			Babyl Dont Reply To, i.e. the auto-ccs are added after
			pruning, if pruning is being done.   Return-Path: not
			shown in reformed headers.  n^F and -n^F fixed to
			search for the nth matching message.  & Form Header
			tries skipping leading day names in reforming dates.
02/12/83 729	SHSU	Some cosmetic changes to In-reply-to: field; M will
			confirm if last message aborted. REMAIL command on
			3F. For TNX, set read date on mail file before renaming
			so FINGER and MAICHK will work right.
12/20/82 728	ECC	Changes to BABYLM to do minimal RFC822 support:  uses
			@ instead of "at" in outgoing headers, if multiple @s,
			the earlier ones turn into %s.  Still work to do:
			1. If spaces in uname, make into a quoted string.
			2. Header reformation might know about %s.
12/15/82 727	ECC	Dummy message message prettified.  Adding a x=y label
			works (Label Message and & Add to Labels Option
			changed).  Reply setup fixed for no-From/Reply-to and
			to not reply to System or Forum.  ^F doc improved and
			n^F iter removed as useless.  Added Babyl O Confirm
			New File.
12/01/82 725	ECC	Moved insertion of in-reply-to out of & Setup Reply
			Template and into its own subr, called AFTER editing
			the mail, so user never sees it.  # Babyl R now sets
			the current template name to Standard Reply, as a
			signal.
11/18/82 723	LNZ	Change # Babyl ^O to use the Rcvd-Date: field
			rather than the current date and time if the message
			to be output has a Rcvd-Date: field.
11/18/82 722	GZ	If Babyl Trim Recipient List is negative, do not do
 			*machine, INFO-xxx and BBOARD@ trimming, but still
			do duplicate and Babyl Dont Reply To removal.
			Also, fixed Undigestify to allow topic separator
			lines to have up to 85 dashes.
11/14/82 721	LNZ	If Babyl Suppress In-Reply-To exists and is non-zero,
			do not generate an In-Reply-To field.
11/12/82 720	LNZ	Fixed code for Babyl Keep TNX Received Date to properly
			handle messages that don't end in CRLF.
		EAK	Added ~ command to GC.
10/14/82 717	ECC	0Y flusheds K-text.  Shh (;) uses fsTYISource and
			should be more general and intuitive now, not
			dangerous -- changed: ; and exec, added & Babyl TYI
			Source.  & Bounds Of Header fixed to return good
			bounds if null text field (should fix F, R, and H
			problems).

			NEW: Empty babyl files now handled fairly generally by
			creating dummy messages in a few places: E, I, select,
			& Initialize Babyl Buffer, & Reformed Bit, added &
			Make Dummy Message.

 9/12/82 716    Moon    Make & Setup Reply Template put in In-reply-to field.
 8/25/82 713-5	ECC	Fix bug just introduced into reformer where it no
			longer removed excess CRLFs and dashes at end.  Also
			improved it so as not to remove dashes at end of the
			last text line, e.g. -Foo- type signature.
			Changed & Parse Header and & Form Header so that
			duplicate recipient fields (e.g. two separate From
			fields) get merged with a separating comma.  All
			variable declarations for recipient fields, e.g.
			From:, have comments starting with a comma.  Also, &
			Form Header now indents multiple Date lines nicely.
			^T wont error if function not found.  Have Create
			Babyl File send its messages to something other than
			BUG-BABYL, so if we want we can redirect them.
			Add Babyl Variables Reset variable, so & Reset Babyl
			Options and others can tell the exec to reset qregs.
 8/22/82 708-12	ECC	& Form Header OZ-hack changed to use MC, not AI, since
			AI is not reliable.  Fix & Bounds Of Header and &
			Reform Header re messages with no text field --
			extra-CRLF removal was removing the terminating blank
			line and the original header therefore wasnt including
			it.  Broke 1H and F in cases where 1H had been done,
			at least.
 7/18/82  704-7	ECC	arg^L keeps window.  Add Babyl Reformation Merges
			From/Reply-To, so people can disable just this if they
			find its change-of-meaning effect on survey From field
			unacceptable.  Fix D, U to not 1u..h unless is typeout.
 7/15/82  697-3	ECC	Finishing touches:  Fix return-value bugs in L, | --
			when aborted they left the Babyl arg around.  Have
			label completer use Return/Linefeed distinction --
			Return completes, Linefeed is for exactly what typed,
			e.g. new label.  Label abbrevs work in unlabelling.  E
			protects itself more when 0 messages left.  Create..
			asks whether to send message re INFO-BABYL.  Answered
			is now a basic label, compatible with ZMail.  Label
			reading for several commands allows new ones.
			Surveyor fixed to not expect FW to always work.
			Put unseen-handling into standard code, no longer in
			the Babyl Command Hook.  Have default R Done hook
			label answered, since now a basic label.  Unseen
			handling now done in code, not Babyl Command Hook.
			User can still override it, though slightly trickier.
			But our handling is better now than was.
			Fix Os check of Append -- past space before number.
 7/14/82  695-6	ECC	Extend Owner to allow several.  & Reset Babyl Options
			translates from list to just one.  <ENTRY> separated
			from Babyl, for documentation purposes.  Further fix
			mode line check of buffer.  Add Babyl Two Window
			Survey Menu.  Split creator into two commands:  Create
			Babyl File, and Edit Babyl Options.  Change & Babyl
			Survey One Message so that Babyl Survey FROM/TO
			Control can also be a macro, to tailor survey a bit.
			Improve documentation for several commands.  Note
			BABYLM additions for init/vars processing, templates.
 7/12/82  693-4	ECC	Have T remove Unseen label, especially for SvM.
			Have & SvMenu ^RNormal Macro and SvM T reform headers.
			Change default Babyl Command Hook to remove unseen
			after SvM T command, and only remove unseen in
			exec if no typeout or typeahead.
			Fix & Form Header bug re @ vs. at.
 7/11/82  692   KRONJ	Add parens to reply-to funny-char list (again).
 7/08/82  690-1	ECC	Added babyl reply-to field variable, used in F, M, R.
			# Babyl G handles mail from old crash now, making two
			passes.  Fixed comments about what the argument to
			Babyl G Done Hook is, what & Initialize Babyl Buffer
			returns.  Not # new, but # of last new message.  G
			keeps point and window if no new mail.
 7/08/82  688-9	ECC	Special reformation to handle BABYLM changes for
			MIT-OZ -- sending from OZ gives Sender: User at
			MIT-OZ, but From: User at MIT-AI, so is legal Arpanet
			and can be replied to.  Yet reformation hack allows
			Oz-to-Oz messages not to look ugly and lets them reply
			directly without going through AI.
 7/05/82  685-7	ECC	Finishing touches to this release:  1G handles any
			kind of mail file on TNX or ITS, fix mode line
			routine to handle empty file (e.g. called while
			creating), 1G arg to & Read Filename.  Refill some
			documentation so will fit in info file when indented.
			Fix incredibly dumb, disastrous bug in new version
			control, to only set fsDVersion on TNX.  Also fix
			some wrong args to TNX & Read Filename.  Make & Babyl
			Execute Options check for empty file and quit.
 7/04/82 683-84	ECC	Fixed & Push Message re fsWindow being B-relative.
			Change & Babyl Set Mode Line so last "label" means
			last undeleted message.  See if slows down too much.
			On OZ it is fine...  Perhaps option?
			More version work:  be sure is TNX-robust, by having
			file opened to [TECO].OUTPUT, then renamed when close.
			This for writing over versions.  Changed: Create..,
			Output Labeled.., O, G, and see BABYLM.
 6/28/82 675-82	ECC	Add Babyl File Version -- changed: I, Output
			Labeled Messages, # Babyl O, Create Babyl File, & Read
			Babyl File.  Have 1G handle ITS mail/rmail files on
			TNX, so people can FTP them over and merge them in.
			Fix bug in Create.. so gives mail files correct
			structure.  Auto-N after D now tries P if cannot N if
			option is -1.
 6/27/82  673-4	ECC	Output Labeled Messages changed to have O collect
			messages in a buffer, with OLM reading/writing and
			running done-hook, and to offer to unlabel.
 6/27/82   672	ECC	F command doesnt insert Babyl CC/FCC To variables.
			Babyl O Filename can be a buffer, causing O to collect
			messages in there, not writing each time.
 6/22/82   671	ECC	Answering no to new-label confirm goes back to read
			label.  Lets user then type <Alt><CR>.
 6/21/82   670	ECC	Also, change End (C-Alt) into Return instead of Q at
			top-level.  (Q is bad if type two Ends instead of one,
			exiting mail edit.)
 6/20/82   669	ECC	Fixed & Add to Labels Option to use @FO, fixing new
			label Z not being added if ZZZ existed.  Label
			completer can handle new labels now.  May be
			controversial -- Lpre<CR> wont complete to
			Lprefix<CR>.  It takes pre as new.  Now you must
			Lpre<alt><cr>.  Abbrevs can get around this though.
 6/20/82   668	ECC	Play with KMP's filler a bit, e.g. to handle Undoing
			last fill if needed.  Fix & Babyl Set Mode Line QNS
			bug, & Read Babyl File to protect against errors in
			Create Babyl File.  Add Babyl O Message Hook.
 6/20/82   667  KMP     Experimental change to ^R Fill Indented Mail Region
			so that with an arg it can grok indented paragraphs.
 6/02/82   665	KRONJ	Fix Edit Labels List to not leave blank
			Labels option.  Zap from of self in SvM.
 5/21/82   664	KRONJ	Don't merge Reply-to into From if Reply-to
			contains special chars (comma, angle brackets).
 4/21/82   663	LNZ	Fixed & Setup Reply Template to properly handle the
			case of Babyl CC To being nonzero.  (zu5 was located
			before the insertion of this name rather than after.)
 4/18/82   662	LNZ	Fixed looping bug where Label Messages Containing
			String expected # Babyl ^F to error at end of file.
 4/16/82   661	LNZ	Added Babyl Keep TNX Received Date to control
			adding a Rcvd-Date header line with the TNX received
			date and time (in & ITSify TNX Mail).
 4/14/82   660	LNZ	Fixed # Babyl O to correctly handle all three forms of
			Append option (Append:<number>, Append, or nothing).
 4/14/82   659	KRONJ	Don't produce blank From: fields
 4/12/82   658	LNZ	Fixed # babyl O UTC Error.
 4/12/82   657	LNZ	Added Before Babylizing File Hook and fixed O
			command to obey Append option of output file.
 3/15/82   656	EAK	Added Babyl Default File for KRONJ.
 3/05/82   655  KRONJ	Flush superfluous Reply-to: and Sender: headers,
			merge Reply-to: into From: field when possible in
			message reformation.
 3/04/82   654  Chiron  Fixed Babyl reply command to not flush Babyl FCC To.
 1/16/82   653	ECC	Various small changes suggested lately:  add Babyl FCC
			To for TNX, more care about Mail-From line for getting
			host, new name Re-Enter Babyl for apropos use.
11/14/81   651	ECC	Changing "badHeader" to "bad-header".
 9/14/81   649	ECC	Do (BUG foo) and comment removal first in & Babyl
			Survey One Message so comment contents, e.g. commas,
			wont confuse later processing.
 8/18/81   648  KRONJ   Abbreviate Stanford host names in SvM.
 8/12/81   647	EAK	Remove TNX code to force Babyl files to be version 1.
 8/09/81   646  KMP	Fixed & ITSify TNX Mail to allow for TNX message
			length counts pointing past end of buffer. Some
			mailers like to pad last word with nulls which TECO
			treats as not there.
 7/30/81   645	ECC	H works better for bad headers:  user can edit the
			visible header and then H.  H will no longer complain
			about the lack of original header -- thus also ok to H
			if original header discarded.
 7/28/81   644  KRONJ   Turn off auto fill mode within Edit Labels List.
			Fix bug in # Babyl U where it wasn't catching the
			lack of anything to undelete.
 5/29/81   642	ECC	Fix Babyl/ZMail incompatibility: ZMail puts ^L<CRLF>
			at end of Babyl files, and we werent trimming it
			properly.  Copied the code that does it to & Read
			Babyl File, in addition to # Babyl G where it used to
			be.  (Probably ought to just be in one place, e.g. the
			babylizer.)  This should fix totalmsg# bugs, and NIBs
			when appending new mail.
 4/07/81   639  Moon	Fix handling of BABYL Append Option so that things
			default reasonably, and add appropriate questions to
			the babyl-file-creation dialogue.
 4/04/81   638	ECC	& Babyl Set Mode Line only resets ..J if changed.
			Mode line thus wont redisplay unless has changed.
			Babyl G Done Hook does not get run if no-argument G
			finds no MAIL option, but & Initialize Babyl Buffer
			does get run since I needs it.
 3/28/81   636  KRONJ   If there's no ^_ at end-of-file Babyl will still warn
			but will insert it if continued.
 3/27/81   635	ECC	Babyl G Done Hook now gets #messages argument, counted
			by & Initialize Babyl Buffer.  Rechecked URK handling
			to never assume an URK cannot happen when consing or
			inserting, but instead make it more failsoft.
			Generalized Moon's useful change, e.g. to allow
			reverse for appenders too (e.g. if mailer prepends
			to their mail file) or for prependers to choose not.
 3/26/81   633  Moon	When reading new mail, in Prepend mode, put the
			messages in the correct order.  Handle ..H correctly
			in the command loop so that survey typeout gets
			replaced by message display at the right time.
 3/25/81   631	ECC	Made reforming URK-failsoft.  Made the resurveyor use
			the same 1st-text-line heuristic as the surveyor, and
			fixed a couple of minor bugs in the resurveyor (q5 not
			pushed, not always set).  Moved F, V, R, and & Setup
			Reply Template into BABYL from BABYLM to make latter
			smaller;  not needed there.
 2/22/81   626	ECC	Added low-level mechanism for quiet surveys -- the
			Survey Quietly variable.  Changed one command to use
			it -- # Babyl '.  (Will hold all during that survey
			menu invocation.)  Renamed all *Brief*s to *Survey*s.
 2/22/81   625	ECC	^S K changed to ^S L.  Fixed up T and Space -- were
			all garbled from antiquity.  E.g. Space wont reshow
			header, will end with CRLF.  T does header/200char
			check properly.  The SvM T changed:  T types all of
			message, nT just part of text (-nT header);  in 2w, T
			uses OTHER window, does so generally (EMACS switching,
			so other window commands will work), nT displays just
			text.  Survey Menu binds window variables and uses
			Babyl Command Hook so user can bind things.  Default
			value for Babyl Command Hook is code, now that IVORY
			fixed to allow Altmodes in there.
 2/20/81   622	ECC	Y sets Babyl Modified Messages, resurveyor tells ^R of
			changes more precisely for better redisplay, SvM
			fs^RNormal doesnt let Select Buffer set fsModeChange
			(though this should soon be unnecessary when & Set
			Mode Line has f=..J check), added 0K, K uses & Push
			Message, Y and K ensure blank lines between killed
			messages.
 2/18/81   617	ECC	Fixed I<cr> bug not using default Babyl file.  (Fix is
			to have # Babyl S f[DFile.)
 2/12/81   613	ECC	\ uses argument or Fill Column, not screen width.
 2/10/81   612	ECC	Changed expunger algorithm to be two pass.  Old way
			was one pass but used a S...... which is 10 TIMES
			SLOWER...  Also changed status line hackers to not
			touch fsWindow, since virtual buffer no longer
			includes status line.
 2/04/81   610	ECC	& Babyl Survey Several Messages no longers uses &
			Maybe Flush Output, instead checking itself.  Better,
			since it will stop if user types Rubout.  Sets
			fsFlushed though, so others higher can use the
			subroutine for convenience; fsFlushed reset to 0 in
			command loop.  Should stop the bug of
			alternating survey line / Flushed when user types a
			Space or Rubout ahead.  Added Babyl Command Hook.
			G allows multiple mail filenames in Mail option, but
			currently only uses the first.  Will later iterate
			over them.  This lets ZMail start using them.
 1/30/81   606	ECC	# Babyl I should be more robust: it marks buffer read
			only until all babylization and conversion is done,
			and only then may mark buffer writable.
 1/27/81   601	ECC	Made all dispatch table functions have documentation
			class "C#".  Changed the Babyl Helper accordingly.
			Documentation now checks SubDoc to see if should
			print information about subroutine use.  Processes
			active documentation. & Read Babyl File can ask for
			another filename.  See MC:ECC;BABSTR for command to
			insert command, option, and variable abstracts, e.g.
			for INFO file update.
 1/17/81   580	ECC	Putting in the Version 5 stuff from now-empty BABYLV,
	    to		with standardized version-converting routines.
	   598		Terminology change: "key", "keyword" to "label", etc.
			with several functions renamed for this.
			Status bits now are basic labels, except reformed bit.
			See & Convert Babyl File Version for format details.
			Some new label routines.  New basic label "recent".
			G and O now may perform version conversion.  More
			robust G -- no leaving partial conversion or
			babylization.  See its comment.  Message attribute
			variables gone (e.g. Message Seen).  Selector now just
			bounds.  E should be twice as fast since corrects
			message# variables without another pass over file.
			Line count in survey was +1, corrected.  Quicker mode
			line, no cache.  O works on any bounds now, and
			unlabels deleted and adds recent.  ^S K not changed,
			but maybe ought.
12/19/80   578	ECC	Routines emptying *Brief* empty Babyl Modified
			Messages since none to resurvey.  It gets quite long.
			Virtual bounds now just around the visible message,
			not including old header or status line.  No routine
			should rely on whether bounds are set to get to status
			line.  Should make spurious display of EOOH etc
			unlikely, improve use of two window operations, make
			things safer and simpler for ^R command and X commands
			that act on buffer, and prepare for day when Babyl
			command loop disappears in favor of a Babyl mode.
			Yanker changed in BABYLM to work with this.
12/14/80   575	ECC	& Parse Header takes pre-comma numarg telling it not
			to give error message about bad headers, but just
			-1fsErrThrow so that the reformer can just mark it
			and let the mode line tell the user about it.  And
			leaves point at top so EOOH line doesnt show.  Other
			callers though (e.g. R, F...) want the error message.
			Also changed "Can't grok header" to more
			understandable "Bad header -- not ITS nor NET style"
			and "Bad header -- no colon in field".
12/08/80   573  GZ	Changed & Babylize Digest Contents to not add a
			"To:List-name" field if it is already there, and
			to clean up any blanks/tabs on the "empty" line
			separating the header from the message.  Also
			changed the use of some temporary q-regs so it will
			be possible to have different host names for various
			lists.  Changed default host to MC, since SPACE is
			not available at AI.

11/30/80   570	ECC	Merged KEYSET and SVMENU sources into BABYL, since
			they do not change frequently anymore and will thus
			simplify bookkeeping (and my directory).  Here is
			KEYSET history:

	6/20 JP	Under advisement from ECC, changed labeller to keep track of
		changed messages for the (SvMenu) resurveyor.
	4/19 EC	Changed to use keyword-reading with completion, with
		keyword-abbrevs added and old crufty number defaults removed.
		Added Undelete Keyset, changed | to use any keyset, added
		Label Key Set.  Made mapper not recalculate message#s since
		that has awful paging behavior.  Added Label Messages
		Containing String.
	...	Random changes over time...  (lazy history keeping)
	9/?? EC	Added and rearranged mapping stuff.
	8/26 EC	Remind Me Of This Message takes negative argument to forget
		message, fixed to start from next message correctly.
		RemindNow is automatically declared a valid keyword.  The
		default filename for Output Key Set is made from the keyword.
	Originated in the dark prehistoric days of late Spring 1979 or early
	Summer of said-same year.  Worked on considerably in July and released
	to the world of Babyl on 12 August.

			Here is the SVMENU history:
	Oct JP	Changed to make use of fs^RNormal for intercepting printing
		characters and interpreting them as Babyl commands.

	7/4 ECC	Born under colored patches of sky on 4 July, 1979.  Worked on
		considerably in late July and early August and released to the
		world of Babyl on 12 August.  After that, survey stuff
		reworked to use real buffer and survey mode, use whatever last
		survey was; T command changed and R added.  Changed (along
		with main-line Babyl) to keep track of altered messaged, and
		to resurvey them.  T command now tries to be clever with 2
		windows.

11/15/80   568	KMP	Fixed ^R Fill Indented Mail Region which was making
			certain indented lines lose their indentation without
			due cause.
11/09/80   564	ECC	Added Gail Zacharias's M-x Undigestify Babyl Message,
			& Babylize Digest Contents, & Find Digest Dash
			Separator, and the option Undigestify Keep Digest.
11/08/80   563	ECC	Merged in Kent Pitman's VBabyl extensions and
			modifications:
			Extended F (see BABYLM), added pre-comma argument to
			M-x Babyl for DDT-run (^X exits to DDT if so), added
			^R Fill Indented Mail Region, & Estimate Mail-Line
			Category, \, Tab.  & Read Babyl File offers to create
			a non-existant file.  So M-x Babyl<cr> can create.
			Fixed Create Babyl File messages, adding safe answers.
			& Babyl Execute Options has fs^REnter reset to a nice
			mode line macro, and ^R command does 1fsModeChange.
			M-X Fill Mail Text is gone -- newer one is better.
10/02/80   536	JP	Purged Babyl Abort Message in favor of throwing the
			error message.  Changed command lookup function.
			Installed fs^RNormal hack in SvMenu.  Installed hack
			(by ECC) where if G gets a numeric argument, it will
			prompt for a filename.  Can grab system mail (ITS/20X)
			as well as other Babyl files.  Tweaked the
			documentation a bit, plus some function names, so that
			the help facility will work better.  Fixed the bug
			that crashes Babyl if the XMail file doesn't exist.
			Installed the infamous missing-host heristic into the
			header reformer.
 8/24/80   532	ECC	Swapped names of ^F and F commands, so finder is now
			^F and forwarder F.  Removed recipient-adders and
			yanker to move them into BABYLM.
 7/17/80   526	ECC	Create Babyl File will ask if want mail file, so TNX
			users can say no -- they cant rubout-abort filenames.
			# Babyl I and # Babyl E check if no messages, asking
			user to either Q or I something else.  Thus I think we
			should now be able to have empty Babyl files without
			trouble.  D's N-after-D won't print message if no next
			undeleted message.  (N and ^N take 1, NUMARG.)
 6/20/80   514  JP      Fixed parser to recognize Re: as synonym for Subject:.
 6/20/80   513  JP      Installed various hacks of ECC's:  Surveyor now takes
			an option variable to limit the amount of effort it
			will expend.  New SvMenu hack keeps track of all
			messages which have been munged -- when a survey is
			reentered, modified messages are resurveyed in order
			to keep the survey up to date.  Also, & Initialize
			Babyl Buffer now flushes the survey.
 6/11/80   511	ECC	& Parse Header takes NUMARG telling about the
			message, and won't reparse if possible.  # Babyl T
			and # Babyl R no longer uses ancient parser.  R now
			uses & Parse Header.  & Initialize Babyl Buffer will
			force reparsing.  The ancient parser, & Babyl Parse
			Header is gone.  See at the end of this history the
			large comment discussing Babyl parsing.
 6/11/80   510	ECC	& Setup BabylM Library will set up Babyl ..D, thus
			avoiding problems with calling & Process Recipient,
			which expects it to be around.  Also added local
			variable Compile Command so can use M-X Compile.
 6/10/80   509	ECC	Changed _BABYL _TEMP file to be [BABYL <xuname>, in
			order to avoid to avoid conflicts between users
			sharing a directory.  This will eventually be changed
			again to avoid an intermediate file -- instead doing a
			"transaction processing" approach, with the mail file
			locked until the Babyl file is written.  Also fixed
			bug in # Babyl G that caused the Babyl file written
			then (appending) to not have a good format:  no
			^L<CRLF> or ^_ at the end.  This is probably the
			causes of all those strange crashes where there was no
			^_ at the right place -- someone had quit out of Babyl
			without # Babyl Q or # Babyl S, and thus the Babyl
			file written by # Babyl G was the one left.  (Normally
			the others clobber it to the correct format file.)
 5/21/80   503	ECC	Moved Create Babyl File into here from BabylV, since I
			want that library to only be sources of converters
			and then only the out-of-date ones -- a history.  The
			creator should ask some questions about options.
 5/15/80   501	ECC	^R Babyl Yank has better window control -- won't go
			to 1 window unless was Babyl in top, mail in bottom.
			Similarly, # Babyl R will allow 2 windows to already
			be in use, and just use the current window.  Several
			mail-sending routines removed to the BABYLM library.
			It now needs to be compressed in with this, along with
			KEYSET and SVMENU.
 4/26/80   497	ECC	Changed # Babyl ^S prompting to work with new EMACS
			prompting scheme, especially on printing tty.
			Also added Babyl-Command-Abort catch and replaced
			several fsERRs with throws to this.  These are
			"user mistakes", not internal errors.  Added fsXMods.
 4/20/80   466	ECC	Removed old keyword validation declarations, since
			KEYSET now uses new completion scheme.  Removed & Read
			And Set Default that L used to use.  Added Babyl
			Keywords Option.
 4/17/80   493	ECC	Added Survey Unlabelled Messages.  Needs a little more
			work, but mostly will benefit in efficiency from a
			restructuring of the surveying routines.
 4/14/80   490	EAK	FCC now appends directly to a TNX mail file.
 4/11/80   489	ECC	Removed autoloading stuff for KEYSET and SVMENU,
			since they are now to be compressed in.
 4/09/80   488	EAK	Added Fcc: to & TNX Mail, and ^O command.
 3/03/80   472	EAK	Removed FR before @V.
 2/27/80   470	ECC	Renamed & Babyl Survey to & Babyl Survey Several
			Messages to avoid naming conflicts being a prefix.
			Added Babyl G Done Hook, though it needs more
			work, concerning what conventions are, what state
			should be before and after etc.  Made mode line
			display before message.  Added Babyl Setup Hook.
 1/09/80   464	ECC	Added Babyl File Consistent flag, which is
			bound to 0 locally by & Babylize Buffer.  & Read
			Babyl File resets it locally to 0 before reading in
			file, and then to 1 when done.  Note that killing
			the *Babyl* buffer will allow a new MM Babyl (it
			checkes if *Babyl* is empty), but doing MM Babyl on
			a non-empty *Babyl* which is marked inconsistent
			will err.
12/07/79   461	ECC	Added cheap forward command (^F).  Made & Babyl
			Parse Header set up its own ..D.
10/29/79   454	EAK	Random cleanup.
10/03/79   439	ECC	Changed format of modification history.  Don't you
			wish you knew what it used to be?
10/03/79   438	EAK	Changed Q and S to use Write File.  Finished
			simplifying R's help.
 9/29/79	ECC	Removed R's Submode stuff -- awaiting better, more
			general help.  Maybe should keep just [Mail] as
			submode?  Simplified R since TMACS now doesn't have
			help or abort -- Babyl alone provides that.
 9/23/79	ECC	Added Submode help message to R, added ^S command,
			made F show its argument.
 9/19/79	ECC	& TNX Mail Buffer copies message into a temporary
			buffer before editing it.  Original stays same, e.g.
			for resending.
 9/18/79	ECC	Added Babyl R Done Hook and Babyl O Done Hook,
			e.g. for autolabelling messages "answered" or
			"filed".  Added Abort Babyl Mail Edit and Babyl R
			Help Macro.
 9/13/79	EAK	Added K and Y commands.  Added 1R.
 9/06/79	ECC	Continuing Catch Errors change:  ^G is not rebound
			by Babyl, and fsNoQuit is set to 0.
 9/03/79	ECC	Changed to use new TMACS Catch Errors and have
			fs^REnter bind it to 0 so errors don't exit  modes.
 8/15/79	ECC	Worked on the survey commands:  fixed up the unseen
			handling to work with version 4.  Spurious "Done"s
			not printed by Survey Messages Containing String, B
			prints "Done" or "Flushed".  B takes pre-comma
			NUMARG for not-emptying survey 1st and
			not-typing-as-go.  0B just prints the label.  &
			Create Brief Variables is gone, replaced by &
			Declare...  & Push Message doesnt smash qregs 0 and
			1 now.  ? command takes "*" instead of "?" to
			document all commands.  Survey Messages.. works on
			the starting message too now. ' autoloads SVMENU.
 8/12/79	ECC	Changed ? command to automatically generate its output.
 8/04/79	ECC	Put & Babyl Get Message Keys into Babyl, from KEYSET.
			Changed & Process Recipient Field to uppercase host
			names in the recipient buffer, for TNX mailer.  Made
			most subroutine descriptions one-liners, with a
			comment following so that Babyl takes less pure space.
 8/03/79	EAK,ECC	Added & Process Recipient Field, used by & TNX Mail
			Buffer and hopefully soon by lots of others -- is a
			pretty fair RFC733 recipient field parser.
 8/02/79	EAK	Fixed & Complete TNX Header - it wasn't narrowing
			the bounds to just the header.
 8/01/79	ECC	(And EAK a few days ago) Getting BABYL' ready for
			installation.  KEYSET loaded by L, |.  Optional auto
			labelling from subject fields.  Cacheing used in
			mode line setting.  Status setting checks more
			carefully that it is setting status bits, instead of
			just bfing.
 Bastille Day	ECC	Removed ..P to go into TMACS, changed to use & Declare
			Load-Time Defaults, & Setup ensures that TMACS is
			loaded.
 7/10/79	EAK	Removed EOOH subroutines in a few places to restore
			reasonable functionality (if you can get the proper
			functionality with them then go ahead).  Removed
			blank line after ITS headers, and fixed bug in & Form
			Header that deleted whitespace at beginning of message.
			Fixed bug where things that begin with MSG: are
			considered ITS messages.  Things still need work.
 7/04/79	ECC	Isolated EOOH handling into few subroutines, and
			changed Babylization to start out by inserting EOOH
			lines, simplifying other routines.  In addition,
			after Babylization, there is always a blank line
			after the header, even for ITS headers.  Added
			routines for finding bounds of original and reformed
			headers.  & Reform no longer creates and kills its
			variables each time -- I put that into the & setup,
			in order to speed up reformation.  The rest of the
			changes were largely to help make Babyl more robust,
			modular.
 7/03/79	ECC	Merged Tenex/Twenex SEND-MAIL library into Babyl, so
			that the reply command works on ITS, Tenex, and
			Twenex now.
 6/30/79	ECC	& Form Header trims away keywords in subject line, and
			added & Push Message, new ..P, and Fill Mail Text.
			Main command loop uses new ..p errset mechanism.
 4/30/79	ECC	O can take 1, argument.
 3/21/79	EAK	Added No Original option.
 3/18/79	EAK	Removed Comment:s, added REPLY-TO.
 3/06/79	ECC	Only set options if not exist already.
 3/05/79	ECC	Add key-display support, in B and & Babyl Set Mode Line
 2/27/79	ECC	Fix bugs and add minor features before doing major
			keyset and survey- work.
 <  2/79	EAK,ECC	Ancient history beyond all recall... back in the days
		when people were apes and Babyl was RMail.
 *!

!~FILENAME~:! !Mail subsystem!
BABYL

!& SetUp BABYL Library:! !S Create option variables, call setup hook.
If the variable Babyl Setup Hook is non0 it is called at the end of Babyl's
    setup, each time Babyl or BabylM is loaded.!

 m(m.m& Declare Load-Time Defaults)
    SubDoc,
	If non0, command documentation mentions subroutine use: 0
    Babyl Setup Hook,
	If non0, is run immediately after loading Babyl library: 0


 !* & Setup BabylM Library will call the setup hook.!
 


!<ENTRY>:! !S Mail file editor subsystem.
Same as the Babyl and Re-Enter Babyl commands.!
!* Separate just so that it does not appear in the automatically produced INFO!
!* section concerning commands.!
 f:m(m.mBabyl)			!* Turn into the other command.!

!Babyl:! !Re-Enter Babyl:! !C Mail file editor subsystem.
String argument is Babyl filename.  It defaults, and can be
    overriden.  Describe the I command for details.
If Babyl was temporarily exited before, this command will re-enter it
    instead of starting a new session.  The # Babyl ^X command is
    the one that temporarily exits Babyl.
DOC
.(g(m.m~DOC~ Process Babyl Init or Vars File)
  -:sSubDoc"l 0:l 2r .,zk)j kCOD
qSubDoc"n i
A pre-comma numeric argument means this should exit back to DDT or EXEC.
Remembers this in Babyl Standalone Job (non0 if exiting to DDT).'!

 m(m.m& Declare Load-Time Defaults)
    Babyl Standalone Job, Non0 means will exit to DDT/EXEC: 0

 m(m.m& Push to Buffer)*Babyl*	!* Select BABYLs own buffer.!
 1f[^RMore				!* use --MORE-- in mode line!
 fsZ"e					!* If buffer is new!
    m(m.mText Mode)			!* initialize its mode!
    1f<!Non-Empty!
      1f<!Babyl-Catch!			!* I may call Q which throws.!
	:i*,m(m.m# Babyl I)	!* Read BABYL file!
	f;Non-Empty >			!* If I ok, can continue.!
       >				!* But if empty, exit.!
    '					!* ...!
 "# @ftReentering temporarily exited Babyl...
   0fsEchoActivew			!* Remind user not new file.!
    f*'				!* Ignore but require a string!
					!* argument for compatibility.!
 "'nuBabyl Standalone Job		!* Remember whether should exit back!
					!* to DDT directly, not EMACS.!
 fs^RMode"n :m(m.m& Babyl Execute Options)'

!* Babyl expects to be inside a ^R.  If that isnt so, we must call
   a ^R, after arranging for the ^R to call & Babyl Execute Options.
 *!

 @:i*|	f]^REnter			!* Reset to old fs^REnter now that!
					!* we are in  mode.  See below for!
					!* where fs^REnter is pushed.!
	m(m.m& Babyl Execute Options)	!* call command processor!
	fs^RExit			!* exit stupid ^R mode!
	| f[^REnter			!* push fs^REnter to reset once!
					!* inside  mode.!
 					!* Enter  and call Babyl!
 

!Edit Babyl Options:! !C Lets user change options for current Babyl file.
Will ask you about each of the various Babyl options that a Babyl file
    may have.
This command should only be called from within Babyl.
qSubDoc"n iPre-comma numarg means called by creator: dont check buffer,
    and dont print message about [..].!

 [U[Y [1[2[3[4[5[6[7[8[9 f[DFile
 fsXUName:f6uU				!* U: Uname!
 1f[FNamSyntax				!* Lone filename becomes fn1 without!
					!* changing fn2.!
 m.m& Yes or NouY			!* Y: Asks yes (-1) or no. (0)!

 "e					!* Unless called from creator, check.!
   .u1					!* 1: Original point.!
   f~Buffer Name*Babyl*"n		!* Check correct buffer.!
      oBadFile'			!* ...!
   0,(fsZ)fsBoundw j :f f~BABYL OPTIONS:"n oBadFile'	!* ...!
   :s
"e !BadFile! q1j			!* No good Babyl file.!
      :i*Edit Babyl Options must be used within BabylfsErr'	!* ...!
   q1j					!* Restore point, so message push uses!
					!* it. hmm...!
   !* Restore point etc. carefully when done all this resetting: !
   m(m.m& Push Message)'		!* ...!

 @fn|m(m.m& Reset Babyl Options)|	!* And reset variables too.!

 j s
 0l b,.fsBoundw			!* Bound to just BABYL OPTIONS.!

 !* Qregs 1-7 will collect the new options.  Reset now to old values, so!
 !* can use as defaults.  Use values in buffer, for sureness.  Could use!
 !* variables, but at least Babyl Owner Option is not the same -- trimmed!
 !* to one if this user is in an owner list.  Note that at the moment, not!
 !* all these old values are used as defaults.  The others are Yes/No!
 !* questions anyway, so easy to answer.!

 1f[BothCase				!* Case-independence in option names.!
 j 0u1 :s
XMail:"l @f	 l  :x1'		!* 1: 0 or XMail filename.!
 j 0u2 :s
Mail:"l @f	 l :x2'		!* 2: 0 or Mail filename.!
 j 0u5 :s
Owner:"l @f	 l :x5'		!* 5: 0 or owner string.!


 !* Ask for the new options: !

 ff&2"e				!* Caller might already have printed.!
   ftTypical (and safe) answers to questions will be shown inside brackets,
    as in: [Y].
'

 q2"n et2'				!* Try old mail option as default,!
 "# etDSK: fsHSnamefsDSNamew		!* or default to users directory.!
    fsOSTecof"ew etU MAIL'		!* ITS mail file.!
    "#-1"e etMAIL.TXT.1'		!* TWENEX mail file.!
    "# etMESSAGE.TXT;1'''		!* TENEX mail file.!
 0u2					!* 2: 0 if no mail file.!
 ftIs there an incoming-mail file [Y]?  mY"n	!* ...!
    1m(m.m& Read Filename)Mail filenameu2'	!* 2: 0 or mail filename.!
 q2"n et2 fsDFileu2'		!* 2: 0 or full mail filename.!

 0u4					!* 4: accumulates Babyl Append Option.!
 ftDo you want new mail to be appended to the end (rather than inserted
    at the beginning) of the Babyl file [Y]?  mY"n 1u4 '	!* 4: append.!
 1u8					!* 8: will be non0 if mailer appends.!
 q2"n	!* If the Babyl file has an incoming-mail file, then find out whether!
	!* new mail needs to be reversed or not: !
   fsOSTeco"e				!* ITS, where user can tell the mailer!
					!* either to append or prepend to the!
					!* mail file.!
     ftDo you tell Comsat (R-OPTION APPEND) [N]?  mY"e 0u8''	!* 8: prepends!
   q4-q8"e				!* If do same thing (append/prepend)!
					!* to both mail and Babyl file,!
					!* messages are ordered.!
      ftDo you want the incoming new mail reversed (this will make it
      inconsistent with the BABYL file though) [N]? '	!* Prompt.!
     "# ftDo you want the incoming new mail reversed (to be consistent
      with the BABYL file) [Y]? '	!* Prompt.!
   mY"n q4+2u4''			!* 4: add in whether should reverse.!

 q1"n et1'				!* Use old XMail as default, if one,!
 "# etXMAIL.TXT'			!* or use standard default.!
 0u1 0u3				!* 1,3: 0 or XMail, XMail Append opts.!
 q2"n fsOSTeco"n			!* On TNX dont have mailing lists, so!
					!* see if wants to fake one.!
    ftDo you want an XMail file, which gets copies of all incoming mail as it
    is added to the Babyl file [N]? 
    mY"n m(m.m& Read Filename)XMail filenamef"nu1	!* yes.!
	    et1 fsDFileu1		!* 1: XMail filename.!
	    ftDo you want mail appended to the XMail file [Y]? 
	    mY"n 1u3'''''		!* End of XMail option hacking.!

 q5f"ew qu'u8				!* 8: Default owner spec.!
 0u5					!* 5: Will be 0 or owner string.!
 ftIs there an owner for this Babyl file [Y]?  mY"n	!* yes.!
    1,m(m.m& Read Line)Owner user name (8): f"nu5	!* 5: Owner.!
	fq5"e q8u5'''			!* 5: If user typed CR, default owner.!

 ftHeader can be reformatted to look better and not show redundant or useless
    fields, and missing host names will be added so other commands will work
    better, e.g. the reply and forward commands.
Do you want headers to be reformed [Y]? 
 mY"e 1u6 0u7'				!* 6: No Reformation option.!
 "# 0u6					!* 6: 0 means DO reformation.!
    0u7					!* 7: No Original, default 0.!
    ftIn general the old headers are saved, so the 1H command can show them.
Should original headers be discarded [N]?  mY"N 1u7''	!* 7: No original.!

 !* Now that we have picked up all the options we can set them.  (Dont want to!
 !* set as go, since if user aborts with ^G, then some options would be reset,!
 !* some not.)!

 j :s
Mail:"l 0lk'				!* Default is for no mail file.!
 q2"n jl iMail: 2
'					!* Put in Mail option if one, at top!
					!* since is important.  Not matter.!
 j :s
Append"l 0lk'				!* Remove old Append option.!
 jl iAppend:  q4\ i
					!* Insert new Append option.!
 j :s
XMail:"l 0lk'				!* Default is for no XMail.!
 q1"n zj iXMail: 1
'					!* Insert new XMail if one.!
 j :s
XMail Append"l 0lk'			!* Default is for no XMail Ap..!
 q1"n q3"n zj iXMail Append
''					!* Put in XMail Append if one.!
 j :s
Owner:"l 0lk'				!* Default is for no owner.!
 q5"n jl iOwner: 5
'					!* Put in Owner if one.!
 j :s
No Reformation"l 0lk'			!* Default is for reformation.!
 q6"n zj iNo Reformation
'					!* Maybe turn off reformation.!
 j :s
No Original"l 0lk'			!* Defult is to keep originals.!
 q7"n zj iNo Original
'					!* Discard them if desired.!

 0u..h					!* Dont leave typeout on screen.!

 !* Not a real abort, since 0 causes no message.  But forces & Babyl Execute!
 !* Options to reset its qregs to pick up new option values: !

 0f;Babyl-Command-Abort

!Create Babyl File:! !C Create a new Babyl file, with sample message.
Will ask you for the Babyl filename, or you can give it as a string
    argument.  With a standard default for a user's main Babyl file
    that reads the user's mail file.  Will ask you about each of the
    various Babyl options that a Babyl file may have.
Offers to send a message to BABYL-REQUEST@MIT-MC, requesting that
    you be added to INFO-BABYL@MIT-MC.
qSubDoc"n i
The filename may be passed as a pre-comma argument.'!

 m(m.m& Declare Load-Time Defaults)
    Babyl File Version, * 0: read max version, write back to same;
	  1: read and write version 1, similar for other positive N;
	 -1: read max version, write back to next version
	  This only applies to Tenex or Tops-20 systems.: 0


 [H[U[V[Y[1[2 0[3 f[DFile "e :i3 fq3"e 0u3''	!* 3: 0 or filename!
 fsXUName:f6uU				!* U: Uname!
 1:<fsMachine:f6uh>"n 0uh'		!* H: Hostname or 0.!
 fsOSTeco"e :ihMIT-h'		!* H: Change AI, e.g., to MIT-AI.!
 qBabyl File Versionuv		!* V: Version spec.!
 e[e\ fne^e]'				!* Push I/O.!
 1f[FNamSyntax				!* Lone filename becomes fn1 without!
					!* changing fn2.!
 m.m& Yes or NouY			!* Y: Asks yes (-1) or no. (0)!
 etDSK: fsHSnamefsDSNamew		!* Default to users directory.!
 etU BABYL				!* Default Babyl filename.!
 fsOSTeco"n qv"g qv'"# 0'fsDVersionw'	!* Set version to 0 or N.!

 f"ew q3f"ew 1m(m.m& Read Filename)Babyl filenamef"ew'''u3

 !* I think overwriting max is correct, even for Create -- not to mention the!
 !* soon-to-be Edit Babyl Options: !
 et3 fsOSTeco"n fsDVersion"e	!* TNX user didnt say particular N.!
    qv"e				!* If overwriting max, find N.!
	1u1 1:<er fsIFVersionu1 ec>w q1fsDVersionw'	!* ...!
    "# qv"g qvfsDVersionw''''		!* Or set it from version spec.!
 fsDFileu3				!* 3: Babyl filename.!

 ftCreating Babyl file 3.
Typical (and safe) answers to questions will be shown inside brackets,
    as in: [Y].


 !* Clobber check only necessary on ITS (no version) or if specific version!
 !* being used: !
 fsDVersion"n oCLOBCHK'		!* Specific version mentioned.!
 fsOSTeco"e   !CLOBCHK!		!* Check on ITS no matter what...!
    e?"e ftClobber existing 3 [N]? 
	  mY"e ftAborted. 0'''	!* ...!

 !* Will build a basic Babyl file in a temporary buffer, then call Edit!
 !* Babyl Options to let user specify the options.!

 f[BBind				!* Temporary buffer.!

 iBABYL OPTIONS:
Version:5

0, recent, unseen,,
*** EOOH ***
Date:  fsDATEfsFDConvertw i
From: BABYL at  qh"n gh'"# iHere' i
To: U at  qh"n gh'"# iHere' i
Subject: New Babyl file

This is a sample message in the new Babyl file.
Feel free to delete it.


 1f<!Babyl-Command-Abort!		!* To catch throw from Edit Babyl!
					!* Options.!
    1,m(m.mEdit Babyl Options)		!* Let user reset the options.!
    >w					!* ...!

 0,(fsZ)fsBoundw			!* Widen bounds to whole buffer.!
 et3					!* Set Babyl filename.!
 f[DFile et[TECO] OUTPUT fsOSTeco"n 0fsDVersionw'	!* On TNX, open to!
    ei					!* a safe file.!
    f]DFile hpef			!* Write out the file.!
 fsOFileu1 @ft
Written: 1
 0fsEchoActivew			!* Tell user.!

 qh"n ftWould you like mail sent to BABYL-REQUEST@MIT-MC, requesting
  that U@H be added to the INFO-BABYL@MIT-MC
  mailing list?  mY"e '		!* No.!
  hk					!* Yes, clear way for message.!
  iFrom: U at H
Sender: Babyl
To: BABYL-REQUEST at MIT-MC
Re: INFO-BABYL

gBabyl Header/Text Separator i
Please add U@H to INFO-BABYL.

 1:< fsOSTeco"e m(m.m& ITS Mail Buffer)'	!* Send it off.!
     "# m(m.m& TNX Mail Buffer)'
     >"n ftCould not mail the request.'	!* If we can...!
 

!^R Fill Indented Mail Region:! !^R Fill Region being smart about indentation.
Fills region something like ^R Fill Region, but will keep
    indentation and will not touch mail header or mail separator (e.g.
    dashes) lines.
In particular, this is good for filling an indented message yanked
    into a *Mail* buffer by the ^R Babyl Yank command.  It will
    respect indentation within the indented text too -- e.g. if the
    yanked message contains within it another yanked message, etc.
Will also check for an ITS-header subject and put it on its own line,
    in case the subject is very long and might be too long for the
    screen width.
M-x Undo<cr> will bring back the old text, in case filling caused more
    problems than it is worth.
With an explicit arg, this will try a different algorithm which may be
    useful for filling messages with indented paragraphs, but which
    will probably lose on some included messages.!

 [0[1[2[3[4[5[6[7[8[9[.0[.1[.2
 qFill Extra Space Listu.2		!* .2: Chars that want 2 spaces.!
 [Fill Column qFill Columnu6	!* 6: Fill Column.!
 f[VB f[VZ				!* Save virtual bounds.!
 m.m^R Back to Indentationu3		!* 3: Moves past indentation.!
 m.m^R Delete Horizontal Spaceu4	!* 4: Deletes whitespace.!
 m.m& Estimate Mail-Line Categoryu5	!* 5: Mail header detector.!
 m.m^R Fill Regionu8			!* 8: ...!
 m.m^R Indent Rigidlyu9		!* 9: ...!

 !* Before saving for our Undo, see if we should first Undo an immediately!
 !* preceding mail-fill.  This typically happens when the user used the!
 !* default mail-filling, noticed that it fouled up paragraph indentation!
 !* lines, and decides to mail-fill again, this time specifying the other!
 !* method.  We have to Undo first, since otherwise those paragraph!
 !* indentation lines wont get merged back together, and will look like!
 !* separate paragraphs, leaving the user with no improvement whatsoever.!

 .,(:)f u1u0				!* 0,1: sorted region points.!
 q:..u(0!*buf!)-q..o"e			!* Same buffer as previous Undo,!
    q:..u(2!*start!)-q0"e		!* same starting point,!
      q:..u(3!*end!)-(fsZ-q1)"e	!* same ending point,!
	f~:..u(4!*desc!)message-fill"e	!* and same description.!
	  !* All that rules out the easy cases of different.  However, we!
	  !* still have to ask the user.  E.g. inside mail edit, fills the!
	  !* whole message.  Sends it off.  Now another mail edit, with same!
	  !* header, and filling the whole text part.  Has the same start and!
	  !* end "points', so it looks the "same'.!
	  ftIs this the very same message you filled before?  (I.e. are you
correcting an immediately preceding fill of this message, perhaps by
giving different argument or Fill Column this time?
If unsure, safest thing is to answer no.) 
	  m(m.m& Yes or No)"n 1m(m.mUndo)w' 0u..h''''	!* ..H: Let redisplay.!
	  !* That should have reset Point and Mark, so we can use them below.!

 .,(:)f fsBoundw			!* Set buffer bounds to region.!
 hm(m.m& Save for Undo)message-fill	!* Make this command undoable.!
 5*5fsQVector[..u @fn|q..ufsBKillw|	!* Dont let ^R Fill Region mess up our!
					!* undo qvector...sigh...!

 j 0l .u0				!* Start at head of line, put in q0!
 q0f(:\u0 fn0jw )u0			!* Come back here when done!
 .( zj 0f  "n				!* Make file end in a newline!
	i
'					!* ...!
    )j					!* ...!

 <  .-z; 0l				!* Loop from point to bottom!
    m5"n l !<!>'			!* Skip mail header/separator lines.!
    :f  "e l !<!>'			!* Skip blank lines.!

    !* Found a line which can be filled.  Now merge this line and each!
    !* successive line with the same indentation.  (As long as that line is!
    !* not a header or separator or blank line: !

    @m3w				!* Skip past indentation.!
    fsSHPosu1				!* 1: offset from head of line!
    @m4w				!* Get rid of initial indentation!
    0u.0				!* .0: flag saying if first time thru.!
    < l m5:@;				!* Next line.  Exit if a header line.!
      @m3				!* Skip past indentation.!
      :f  @;				!* Exit if null line or at end.!
      fsSHPosu.1			!* .1: Indentation for this line.!
      q.1-q1"e				!* Same indentation.!
	0:k @m4w			!* .0: So merge it with previous line.!
	0,0af.2:"l i ' i 	!* Need 2 spaces if after some chars.!
	1u.0 !<!>'			!* .0: Not first time through.  Now go!
					!* check next line..!
      q.0"e				!* If first time through!
       ff"n				!* and if paragraph-option !
        q.1-q1 f"l +9"g			!* and indentation decreased 1-8!
	 -1l q1-q.1, i		!* then reindent paragraph starter.!
         l @m3w q.1u1			!* 1: Go back where we were, and reset!
					!* current indentation for rest of!
					!* paragraph.!
         0:k @m4w i  1u.0 !<!>''w''	!* .0:  and loop for more lines there.!

      0; >				!* Different indentation, so exit.!

    !* The previous line is now one long merged line that can be filled and!
    !* then reindented: !

    0l .: -l				!* Set the Region around that line.!
    q6-q1uFill Column			!* Account for indentation.!
    @m8w				!* Fill the merged lines.!
    .-z( q1m9w )+zj			!* Reindent them.!
    >					!* Go see if any more lines that can!
					!* be filled.!

 q0j					!* Jump to top again.!

 !* Now try to check for ITS header subjects and if long, put them on their!
 !* own line.  Will recognize one by seeing if a date-like thing is followed!
 !* by Re: .!

 <  :s:: Re: ; .u7		!* 7: Point where subject starts.!
    :l fsSHPos-q6"g			!* Subject goes past fill column.!
	q7j -4d i
Subject: 				!* Move subject to its own line.!
	-l m3 fsSHPos(l), i' >	!* Make indentation match.!


 z:					!* Set point after region altered.!
 q0,z 				!* Return region changed.!

!& Estimate Mail-Line Category:! !S Categorize current line.
Return	0 if not mail-related,
	1 if header line,
	2 if separator line,
	-1 if send header line.!
!* Heuristic, for use on mail text which might contain an embedded message.!

!* A comment about the heuristics determining whether a line is a header field!
!* line and the effectiveness of them:  Some lines will be considered not!
!* mail-related (0) which really are, e.g. a two-word field name or a!
!* continuation line.  But these will frequently be ok, at least for the!
!* command ^R Fill Indented Mail Region since if the two-word field name line!
!* is surrounded by lines which are correctly categorized, it will not be!
!* merged into them.  Similarly continuation lines will be filled together but!
!* not merged into surrounding lines since their indentation will be!
!* different.  Thus, for ^R Fill Indented Mail Region at least, the!
!* 0-categorization is generally not detrimental.!
!* Note also that the filling of code -- especially code where there is much!
!* variance in indentation such as lisp -- will tend to do the right thing!
!* since lines will so often occur at different indentation levels that they!
!* will not get merged. Other languages -- eg, Midas -- which do not vary!
!* indentation much, will come out totally screwy, but this would be too slow!
!* if it tried to check too much unless someone can find a good heuristic for!
!* identifying language regions quickly!

 [0 0f[vbw f[vzw			!* Open bounds above.!
 !* First, ^_-related checks to protect the structural integrity of!
 !* a Babyl file in case of uncontrolled (mistaken) filling.!
 0l 0,1a-"e 2'			!* Babyl file separator line.!
 -4 f=
"e 2'				!* Babyl file status line.!

 1:fsBoundw				!* Bind bounds to this line.!
 qBabyl ..D[..d			!* ..D: Use header syntax table.!
 :g..du..d				!* ..D: Make a copy of it.!
 :*5:f..d 				!* ..D: Modify to make : a word!
					!* delimiter.!
 !* Maybe Babyl ..D should standardly have word syntax for skipping over field!
 !* name???!

 1:<fwl>"n j oLast'			!* Maybe exit if past line end.!

 (-1,1a-:)*(-1,1a-@)"e j 1'	!* Look for @ or : after first word!
 0l @f	 l			!* Skip whitespace!
 12 f=MESSAGE FROM"e j -1'		!* Old style send header!
 13 f=[MESSAGE FROM"e j -1'		!* New style send header!
 :f f~*** EOOH ***"e j 2'		!* Call EOOH-line a separator.!
 qBabyl Header/Text Separatoru0	!* 0: E.g. --Text follows...!
 :f f~0"e j 2'			!* This line is a separator.!

 !Last!					!* Come here before giving up!

 @f	 l				!* Past whitespace.!
 :f  "n @f-_l :f  "e j 2''	!* If rest of line is dashes and!
					!* underscores, call it a separator.!
 j 0					!* Nothing special.!

!Undigestify Babyl Message:! !C Break up a digest into individual messages.
The digest is assumed to be the currently selected message.  It will
    be replaced by the series of messages which made up the digest.  A
    "To:List-name" field will be added to each message header, for
    replying and visual identification of the source digest list. 
The option variable Undigestify Keep Digest controls what happens to
    the original digest.  This variable can have several values:
	0:	digest is discarded
	+n:	digest is kept, before the individual messages
	-n:	digest is kept, after them
	+1:	digest is additionally marked Deleted
	-1:	same
If a precomma arg is given it is used instead of the value of the
    variable.!

 m(m.m& Declare Load-Time Defaults)
    Undigestify Keep Digest,
	* Describe M-x Undigestify Babyl Message for details on values: 0


 [l[d

 m(m.m& Bounds of Header)w		!* Move to start of message.!
 @f 	
l					!* Move to first non-blank.!
 .,(fb	  r).xl			!* L:first word (list name).!

 m.m& Find Digest Dash SeparatoruD		!* D: Separator finder.!
 65,85mD"e				!* Find end of topics list.!
    :i*Bad Digest formatFSErr'	!* Not found - err out.!
 f:m(m.m& Babylize Digest Contents)	!* OK, so go undigestify.!

!& Find Digest Dash Separator:! !S Find a line of numarg1 to numarg2 dashes.
Blanks before end of line are ignored.  We move past the found line if any.
Returns 0 for failure, -1 for success.!

 f[SString [1				!* Save search default.!
 ,-:i1				!* 1: minimal separator string of!
					!* dashes.!
 0s
1					!* Set search default to line!
					!* starting with minimal separator.!
 f u1				!* 1: number of extra dashes allowed.!

 <  :s"e 0'				!* Find line starting with separator.!
					!* If none, exit failing.!
    q1,z-.f : u1w			!* 1: min(q1, #chars-left-in-buffer),!
					!* to avoid NIB error in F^B below.!
    q1 @f-l				!* Move past extra separator chars,!
					!* up to the number allowed.!
    @f	 l			!* Move to first non-blank character!
					!* after those allowed dashes.!
    .-(:l .)@;				!* Exit if at end of line.!
    >					!* Else not it, loop.!

 1l -1				!* Move to next line and exit!
					!* successfully.!

!& Babylize Digest Contents:! !S Does the work.
Bounds must be around a digest and . must be just past Topics section
separator, before contents of the digest.
QL must contain list name of digest.
QD must hold & Find Digest Dash Separator.!
!* This routine will:
	1. Save for Undo.
	2. Check Undigestify Keep Digest as well as precomma arg and
	   do the right thing as described for M-x Undigestify Babyl Message.
	3. Insert babyl-separators between messages past point.
	4. Update Message Number,Parsed Message Number and Number of
	   Babyl Messages.
	5. Flush the survey buffer, because message numbers changed.
	6. Select the Topics section as the current message.!

 m(m.m& Declare Load-Time Defaults)
    Undigestify Keep Digest,
	* Describe M-x Undigestify Babyl Message for details on values: 0


 [0[1 [b[t
 .-b[p					!* P: offset of start of digest.!
 qNumber of Babyl Messages[N		!* N: Total # of messages before!
					!* undigestifying.!
 :itTo: l at MIT-MC
					!* T: To: list-name at host   line.!
				    !* In future might need different hosts!
				    !*  for different lists but for now every!
				    !*  digest is available from MC (and SPACE!
				    !*  is only at MC).!

 b,zm(m.m& Save for Undo)undigestify	!* Make us undoable.!

!* Undo will work as long as no non-digest msgs are messed with however the!
!* message numbers will be really messed up...  Need to do & Initialize Babyl!
!* Buffer to recover completely.!
!* No help for it I think -- cretinous undo facility in EMACS.. -- ECC!

 ff&2"e				!* Get option or numarg.!
   qUndigestify Keep Digest' "# 'u1 !* 1: ... Keep digest?!
 q1"n					!* Non-0 means yes: !
    hx0 bj g0 i
					!* Make copy of entire message.!
    %nw					!* N: increment # of messages.!
    q1  -1"e				!* 1, or -1, so mark digest deleted.!
      .(q1"l z' "# b'j			!* Move to the appropriate copy.!
	m(m.m& Add Basic Label)deletedw	!* Delete it,!
	)j'				!* and restore point.!
    q1"l 4r fsZ-.fsVZw'		!* Negative - work on 1st copy.!
    "# .fsVBw				!* Otherwise work on 2nd copy.!
       %Message Numberw''		!* so increment Q$Message Number$.!

 b+qpj					!* Go to start of messages.!
 f[vb				        !* Save top of digest.!
 fsbconsub				!* B: temp buffer for parsing headers.!
 f<!Msgs!
    @f
	 L				!* Move past any whitespace.!
    .-z;				!* Exit if no text.!
    i
0, recent, unseen,,
*** EOOH ***
					!* Insert Babyl message start text.!
    %nw					!* N: increment # of messages since we!
					!* have just added a message.! 
    !* Babyl cannot hack non-empty blank lines as message header separators!
    !* (something Rmail has no trouble with...).  Since this often happens in!
    !* digests, we try to correct such headers.!
    .-21fsvb				!* Narrow bounds to rest of msg.!
    :fb@:+2"e			!* If a non-ITS header!
     :s


 
	+1"l				!* and if a line starting with a blank!
					!*  comes before any empty lines.!
	 @f 	l 13,1a-13"e		!* If it is a blank line!
	   0k'				!* kill the blanks.!
	   "# 0li
'''					!* Else insert an empty line before it!

    1:< 0m(m.m& Parse Header)		!* Now let babyl parser try it.!
      >"n				!* If still not a good header!
         j 2lit
'					!* make To:listname line the header.!
      "# qb[..o gTo: gCc:		!* Else get recepients in temp buffer!
         j :sl (			!* and search for list name.!
	 hk ]..o			!* (all done with temp buffer)!
	   )"e				!* If listname not among recepients!
	     j 3l gt''			!*  insert it as 2nd line of header.!

    < 27,33md"e f;Msgs'		!* Find separator, exiting if not!
					!* found.!
      -:l.,(0l).@f 	 (2l)@; >	!* Make sure really separator.!
					!* The line before it should be blank.!
    >					!* Else do it again.!

 qbfsbkill				!* Kill the temp buffer.!

 qnuNumber of Babyl Messages		!* Updated total # of messages from QN!
 0uParsed Message Number		!* Numbering changed, so don't rely on!
					!* it.!
 :iBabyl Modified Messages		!* No messages to resurvey.!
 fq*Survey* Buffer"g			!* If non-empty survey buffer.!
    q*Survey* Buffer[..o		!* Select it.!
      hk 0fsModifiedw 0fsXModifiedw	!* Flush it since numbers changed.!
      ]..o '				!* And return to original buffer.!

 f]vb j				!* Go back to Topics section.!
 :m(m.m& Babyl Select Message)		!* And select it.!

!Shorten From Field For Hermes:! !C Only username.
Forces the From field to be just Username at Host, no personal name
    part.
Nice for Hermes, so other people can see your subject line in a
    survey, since Hermes doesn't truncate a long From field.!

 fsOSTeco"e :i*Only intended for use on TNX fsErr'
 z-.[1					!* 1: Original Z-.!
 bj .,(i
).f					!* Boundary condition.!
 bj :s
From:"l 0lk'"# l'			!* Kill old From if any.!
 .,(iFrom:  g(fsXUName:f6) i
   
    ).f				!* Just username.!
 j .,(@f
k).f					!* Remove boundary condition.!
 z-q1j 1				!* Back to original point.!

!# Babyl ^C:!
!# Babyl ^Z:! !C# (^C on ITS, ^Z on Tops-20)  Return to DDT/EXEC temporarily.!
 100000.fsExit
 

!# Babyl ^D:! !C# Delete message and move backward.!
 -1,(f) :m(m.m# Babyl D)

!# Babyl ^F:! !C# Find and select message containing a specific string.
Given no numeric argument the search is forward, starting with the message
    after the current one.
Given a positive argument, N, searches forward for the Nth message to
    contain the string.
Given a negative argument, -N, the search is backward, starting with the
    message before the current one, for the Nth message to contain the
    string.
If no match is found, returns to current message.!
!*
Pre-comma NUMARG is string to search for.  If no pre-comma NUMARG, uses & Read
Line to ask for it.  We return -1 on success and zero on failure.  Diagnostic
is only issued if no pre-comma argument (e.g. we prompted the user for the
search string).  Otherwise, we just return.
!

 m(m.m& Declare Load-Time Defaults)
    Babyl F Default,: ||


 [0[1[2
 ff&2"n u0'			!* 0: string passed as pre-comma.!
 "# qBabyl F Defaultu1		!* 1: Default from last F.!
    ff"n :\u2 :i22 '"# :i2'	!* 2: Stringified NUMARG.!
    1,m(m.m& Read Line)2Find (Default "1"): u0 !''!
					!* 0: string read from user.!
    fq0"l '				!* Give up if rubbed out!
    fq0"n q0uBabyl F Default'"# q1u0'	!* Null string => use default; else!
    '					!* it is new default.!

 0f[vb 0f[vz .u1 @fn| q1j |		!* save current state of things in!
					!* case search fails!
 f"ew 1',0f  <			!* Search for abs(N)th match.!
    "l -':s			!* Start at end/top of this message.!
    "l -':s0"E			!* Search for the string.!
	ff&2"N 0'			!* Not found -- exit quietly,!
	:i*Not foundf;Babyl-Command-Abort'    !* or not-so-quietly maybe.!
    >					!* ...!
 ]..N ]*w ]*w			!* Throw away saved state.!
 m(m.m& Babyl Select Message)	!* set bounds around found message!
 m(m.m& Calculate Message Number)	!* Figure out where we ended up.!
 ff&2"N -1'

!# Babyl ^H ~:!
!# Babyl <Backspace>:! !C# Move to previous screenfull.!
 f @m(m.m^R Previous Screen)w
 

!# Babyl ^I ~:!
!# Babyl <Tab>:! !C# Reformat a losing message that contains ^J's, ^H's, etc.
Replace them with their visual counterparts...
 ^H deletes character before it,
 ^J inserts carriage return + whitespace
 ^M becomes CRLF.
This is undoable.  (I.e. M-X Undo<cr> brings back old message.)!

 [0[1
 m(m.m& Bounds Of Header): jw		!* Go to top of header.!
 .u1 fnq1j				!* 1: Auto-restoring point.!
 .f[VB :s"l r'"# zj' fsZ-.f[VZ	!* Bounds around message.!
 hm(m.m& Save for Undo)character fix	!* Make this command undoable.!

 !* Convert LF to CRLF + whitespace: !
 j <:s
   ; rd				!* Delete stray linefeeds.!
    fsHPosu0				!* 0: Current column.  Not SHPos since!
					!* wrapping should be handled as is!
					!* visually.!
    i
   q0, i r >				!* Put in CRLF, indentation.!

 !* Backspaces delete themselves and previous character (unless at beginning!
 !* of line): !
 j <:s; 0f  -1"g -2d'>		!* ...!


 !* Convert CRs to CRLFs: !
 j <  :s
;			!* Find stray ^M.!
      -d i
     >					!* Convert to CR LF.!

 

!# Babyl ^J ~:!
!# Babyl <Linefeed>:! !C# Jump to next unseen message.!

 .[0[1					!* 0: Original point in case dont!
					!* find anyone.!
 m.m# Babyl ^N[N			!* N: Next message mover.!
 m.m& Check Message Label[C		!* C: Label checker.!
 qMessage Numberu1			!* In case we just happen to want to!
					!* come back here.!
 f<!Babyl-Command-Abort! 1mN MCunseen@:; >"E '	!* Go until unseen.!
					!* If control gets here, then we are!
					!* ..throwing up [sic].!
 q1m(m.m# Babyl J)			!* Go back to starting message.!
 :i*No more unseen f;Babyl-Command-Abort  !* Change diagnostic and propogate!
					    !* ..the throw.!
 

!# Babyl ^L:! !C# Clear screen.  Given a numeric argument, keeps same window.!
 ff&1"n fsWindow(f+)fsWindoww '	!* Keep same window.!
 f+ 

!# Babyl ^M ~:!
!# Babyl <Return>:! !C# No-op, flushes argument, and goes to next line.!
!* & Babyl Execute Options has already echoed the return.  So we simply!
!* get rid of the argument by returning no value -- returning a value!
!* means keep the argument that has accumulated in Q5.!

 

!# Babyl ^N:! !C# Move to next message, whether deleted or not.
If argument, n, goes to nth next.
qSubDoc"n i
1, NUMARG means dont print any error message (just throw quietly).
String precomma numarg is label to f;-throw to if fail.'!
 -[1 [2				!* 1: Count messages moved past.!
					!* 2: 0, 1, or f;-label.!
   m.m& Babyl Select Message[S		!* S: Message selector.!
 < 0fsVZw				!* Set wide bounds below.!
   :s
;					!* To next message if any.!
   ms					!* Select it.!
   %Message Numberw			!* Probably better to keep in loop so!
					!* 1 case is best -- N does 1^N loop.!
   %1; >				!* 1: Count message, stop if done.!
 q1"n ms				!* Reset bounds, message status.!
      q2fp"g f;2'			!* Caller wants to catch this case.!
      q2-1"n :i*Now at end, no next message '(	!* Set error message if no 1,!
						!* ..NUMARG.!
	 ) f;Babyl-Command-Abort '	!* And throw out of here.!
 

!# Babyl ^O:! !C# Append current message to a TNX mail file.!
 m(m.m& Declare Load-Time Defaults)
    Babyl ^O Filename,: |FOO TXT|

 FS Date[0				!* Use current date and time. !
 0F[V B 0F[V Z .[2 -S C :SRcvd-Date:+1"E @F 	L
 FS FD Convert F"G U0 '' Q2J ]2 F]V Z F]V B !* unless Rcvd-Date: is present. !

 [1 qBabyl ^O Filenamef"ew'f[DFile	!* Bind default filename to ^O!
					!* default if one exists.!
 5,fAdd message tou1 et1		!* 1: Get filename.!
 fsDFileuBabyl ^O Filename'		!* Remember altered filenames!
 e[ e\ fn e^ e]			!* Push i/o.!
 !* Assumably the message has been selected, and therefore bound.  If not, we!
 !* wont err, but strange stuff could be appended to the file.  Should we!
 !* bound carefully?!
 q..ou1  f[BBind			!* 1: Original buffer, message.!
 g1
 :s
Re:

+1"e @f l 0k iSubject: '		!* change Re: to Subject: !
 Q0:m(m.m& Append to TNX Mail File)	!* append buffer to file!

!# Babyl ^P:! !C# Move to previous message, whether deleted or not.
If argument, n, moves to nth previous.!
 -[1					!* 1: Count messages moved past.!
 qMessage Number-1<			!* don't go back too far!
   0fsVBw				!* Set wide bounds above.!
   -:s;				!* Back to end of previous message.!
   1:<m(m.m& Babyl Select Message)	!* Select that one!
      >@:;				!* Abort if error!
   qMessage Number-1uMessage Number	!* ...!
   %1; >				!* 1: Count message, stop if done.!
 q1"n 1:< m(m.m& Babyl Select Message)	!* Select that one!
	  >"n 1m(m.m# Babyl J)'	!* If can.!
      :i*Now at top, no previous message f;Babyl-Command-Abort'   !* ...!
 

!# Babyl ^R:! !C# Enter a recursive edit level on current message.!

 [0[1[2 [3[4				!* Temp registers.!
 fsVB[3 fsVZ[4			!* Save prev bounds.!
 1fsModeChangew 0f[^RMore 		!* Let user edit.!
 qMessage Number:\u0			!* 0: Add message number to resurvey!
 :fo..qBabyl Modified Messagesu2	!* ...list.!
 q:..q(%2)u1				!* ...!
 :i:..q(q2)10M0
					!* ..!
 fsVB-q3"E fsVZ-q4"E q3+q4"N  '''	!* If bounds still same and narrow,!
					!* ..assume only selected message was!
					!* ..edited.!
 m(m.m& Initialize Babyl Buffer)	!* Otherwise, reset number variables.!
 

!# Babyl ^S:! !C# Survey-prefix.  Also ignores ^S^Q for VT52 lossage etc.
^S^A or ^SA is M-X Survey All Messages
^S^D or ^SD is M-X Survey Deleted Messages
       ^SUD is M-X Survey Undeleted Messages
^S^L or ^SL is M-X Survey Labeled Messages (reads a label)
       ^SUL is M-X Survey Unlabeled Messages (reads a label)
^S^M or ^SM is M-X Survey Messages Containing String (reads a string)
^S^F of ^SF is --ditto--
^S^R or ^SR is M-X Survey Reminders
	^SS is M-X Survey Seen Messages
       ^SUS is M-X Survey Unseen Messages
^S? shows this description and then reads another character.
To correct for stupid terminals, any number of ^S's followed by a ^Q
	are ignored.  This is for VT52s, H19s, maybe others.!
 [1 0[2					!* 2: 0 if have not prompted.!
 20:"e				!* If no typing from user, prompt.!
    1u2					!* 2: Remember that we prompted.!
    :i*CfsEchoDisplay		!* Clear prompt area.!
    @ftKind of survey (A,D,L,M,R,S,UD,UL,US, or ?): '	!* ...!
 <  2,m.i fi:fcu1			!* 1: Dispatch character.!
    q1-:@; >			!* Exit when not a ^S, thus we!
					!* ignore ^S^S...^S^Q.!
 (q1-177."'e)(q1-"'e)"n '	!* Exit quietly, no-op, if it was a!
					!* rubout or ^Q.!
 q1-32"l q1@u1'			!* 1: Turn ^A to A, etc.!
 q2"n @ft1'			!* Extend the prompt.!
 fsRGETTY"e ft
'					!* New line if printing tty.!
 q1-A"e				!* ^S^A or ^SA.!
    f:m(m.mSurvey All Messages)'	!* ...!
 q1-D"e				!* ^S^D or ^SD.!
    f:m(m.mSurvey Deleted Messages)'	!* ...!
 q1-L"e				!* ^S^L or ^SL.!
    !* Note that we cannot :M, since we need to pass a string arg: !
    fm(m.mSurvey Labeled Messages) '	!* Null STRARG means it should!
						!* use the reader to get!
						!* label.!
 (q1-M"'e)(q1-F"'e)"n		!* ^S^M or ^SM or ^S^F or ^SF.!
    f:m(m.mSurvey Messages Containing String)'	!* ...!
 q1-R"e				!* ^S^R or ^SR.!
    f:m(m.mSurvey Reminders)'	!* ...!
 q1-S"e				!* ^SS (not ^S^S...)!
    f:m(m.mSurvey Seen Messages)'	!* ...!
 q1-U"e				!* ^S^U or ^SU.  Another char follows.!
    < q2"e 20:"e			!* If no typing from user, prompt.!
	1u2				!* 2: Remember that we prompted.!
	:i*CfsEchoDisplay		!* Clear prompt area.!
	@ft^SU (D,L,S): ''		!* ...!
      2,m.i fi:fc@u1		!* 1: Uppercase char.!
      q2"n @ft1'			!* Extend the prompt.!
      q1-D"e f:m(m.mSurvey Undeleted Messages)'	!* ^SUD.!
      q1-L"e f:m(m.mSurvey Unlabeled Messages)'	!* ^SUL.!
      q1-S"e f:m(m.mSurvey Unseen Messages)'	!* ^SUS.!
      1u2 fg @ft
^SU (D,L,S):  >'			!* 2: Help and repeat if illegal.!
 q1-?"e m(m.mDescribe)# Babyl ^S	!* ? gives help and then!
	  f:m(m.m# Babyl ^S)'	!* reads another character.!
 fg 					!* Illegal choice.  Complain noisily.!

!# Babyl ^T:! !C# Call ^R Display Load Average, for TNX users.!
 1,m.m^R Display Load Average[1	!* 1: Function or 0.!
 q1"n @m1'				!* Do it if can.!
 "# fsOSTeco"n				!* Else do it ourselves, if can.!
    1:< fsLoadAvu1			!* 1: Load av string.!
	:i*CfsEchoDisplayw		!* Clear echo area.!
	@ft(Load average = 1) 	!* Type message.!
	0fsEchoActivew	>w''		!* Keep it around.!
 

!# Babyl ^]:!
!# Babyl ^X:! !C# Temporarily exit Babyl.  Doesn't file out.
Exits to EMACS or DDT/EXEC, depending on how Babyl was called:
	If was 1,M-X Babyl or a BABYL job then will exit back to DDT/EXEC.
Repeating the M-X Babyl command will resume with state unchanged.!
 m(m.m& Declare Load-Time Defaults)
    Babyl Standalone Job, Non0 means will exit to DDT/EXEC: 0

 :i*CfsEchoDisplayw			!* Clear echo area.!
 qBabyl Standalone Job"e f;Babyl-Catch'	!* Exit to EMACS.!
 100000.fsExitw 			!* Exit to DDT.  When job is!
					!* continued, exit back to Babyl.!

!# Babyl ^[ ~:!
!# Babyl <Altmode>:! !C# Execute a TECO command string.!
 f@m(m.m^R Execute Minibuffer)w
 

!# Babyl ^V ~:!
!# Babyl ^` ~:!
!# Babyl <Space>:! !C# Print more of this message.
On printing terminal:  prints rest of message.
On display terminal:  goes to next screenful.
    n<Space> scrolls up n lines.
    9999 Space (or any semi-infinite numeric argument) goes to the
    end of the message.!


 fsRGETTY"n 1:<f @m(m.m^R Next Screen)>w '	!* Display, scroll.!
					!* The errset is so passing a very!
					!* large numeric argument will just go!
					!* to the end without erring.!

 ft
					!* On printing tty, print!
 ff"n .,(l).t			!* As many lines as specified (maybe!
    m(m.m& Babyl --MORE--)'		!* then --MORE--).!
 "# .,zt				!* Or all the rest of the lines.!
    zj -2 f=
"n   ft
''					!* Supply a CRLF at end if need it.!
 

!# Babyl ^W:! !C# What is left of this message? Gives line/window count.!

!* The bounds are set around the current message.  To calculate how many lines!
!* are left, we take the top line, go down size-of-window lines, and start!
!* counting from there.!

m(m.m& Declare Load-Time Defaults)
 Next Screen Context Lines,:1

 [0[1[2[3[4
 .u0 fnq0j				!* 0: Auto-restoring point.!
 fsLinesf"ew				!* If 0, have just one window.!
    fsHeight-(fsEchoLines)-1(		!* One window.  -1 ignores mode line.!
      )'u1				!* 1: Window size.!
 fsWindow+bj				!* To top of window.!
 q0m(m.m& Count Screen Lines)+1u2	!* 2: Count, and include this line.!
 !* @ftWindow size= q1@:= @ft Message lines= q2@:=!
 :i*CfsEchoDisplayw			!* Clear echo area.!
 (q2-1)/q1u4				!* 4: how many screens left.!
 q4"e @ftBottom of message. 0fsEchoActivew '	!* None.!
 q2-q1u2				!* 2: lines not seen already.!
 (q2-1)/(q1-qNext Screen Context Lines)+1u4	!* 4: How many screens,!
					!* correcting for overlap.!
 q2@:= @ft Line q2-1"g @fts'
 @ft left in message  @ft( q4@:= @ft screen
 q4-1"g @fts' @ft). 
 0fsEchoActivew			!* Keep printout there.!
 

!& Count Screen Lines:! !S Count number of physical screen lines from point.
Postcomma arg gives point to go back to.
Precomma arg means go backwards.!
0[0					!* count of lines!
[1					!* point to preserve!
 @fn|q1j|				!* point to return to when we exit!
 ff&2"e				!* given precomma arg?!
!* @ft Counting forwards!
   < 1:<1,0:fm>"n 0;'			!* go down one screen line!
     %0					!* count it!
   >
   z-."e q0-1u0 '			!* EOB? not really another line!
 '"#
!* @ft Counting backwards!
   < 1:<-1,0@:fm>"n 0;'		!* go up a screen line!
     %0					!* count it!
   >
  '
  q1j					!* back to where we belong!
  fn					!* now safe to clear this!
  0fsechoactive
  q0					!* return our count!

!# Babyl ':! !C# Into recursive edit level on survey.
No arguments means use the last survey.  If no last survey,
    we call .
M,N arguments means survey messages M through N.
N argument means survey next N messages.
-'<character> is like ^S<character>' but does not print while
    surveying.  (Except for a "Done" which is unavoidable without
    serious work.)
For more details, see documentation for M-X Survey Menu.!
!*
This is a separate function from Survey Menu to work better with the EMACS
documentation facilities.
!

 m(m.m& Declare Load-Time Defaults)
    Survey Quietly,:0


 "l 2[Survey Quietly		!* Force quiet survey.!
      @m(m.m# Babyl ^S)'		!* Do a survey.!
 "# f':m(m.mSurvey Menu)		!* Pass arguments if not -1.!

!# Babyl .:! !C# Return the message number of current message.
To reposition at top of current message, do .J!
 qMessage Number:\[1			!* 1: no. as a string!
 :i551 0			!* append to Q5, return something to!
					!* say we have set Q5!


!# Babyl ;:! !C# Accumulate a line, then execute it with no display.!
 m(m.m& Declare Load-Time Defaults)
    Babyl Shh Text,: ||

 !* Can sometime try to have more than one line accumulated...!
 [..J :I..JBabyl-Shhh
 m(m.m& Read Line);uBabyl Shh Text	!* Save the text.!
 m.m& Babyl TYI SourcefsTYISourcew	!* Now FIs will read from this text.!
 

!& Babyl TYI Source:! !S Uses ;-generated text, sets fsReread.!
 m(m.m& Declare Load-Time Defaults)
    Babyl Shh Text,: ||

 qBabyl Shh Text[3 
 fq3:"g 0fsTYISourcew 0'		!* Done shh-rereading.!
 0:g3fsReReadw				!* Next FI gets this char.!
 1,fq3:g3uBabyl Shh Text		!* Remove that char.!
 0

!# Babyl =:! !C# Type value of numeric argument.!
 = 

!# Babyl 0 ~:!
!# Babyl 1 ~:!
!# Babyl 2 ~:!
!# Babyl 3 ~:!
!# Babyl 4 ~:!
!# Babyl 5 ~:!
!# Babyl 6 ~:!
!# Babyl 7 ~:!
!# Babyl 8 ~:!
!# Babyl 9 ~:!
!# Babyl + ~:!
!# Babyl - ~:!
!# Babyl , ~:!
!# Babyl * ~:!
!# Babyl / ~:!
!# Babyl ) ~:!
!# Babyl ( ~:!
!# Babyl <Digit>, <Comma>, +, -, *, /, (, and ):!
!# Argument Part:! !C# Part of a Babyl numeric argument.!
!* The extra, final name there will cause Describe to use a reasonable name --!
!* without it, you can ask to have 5 described and be confused when it uses!
!* the name # Babyl (.  It must be first alphabetically.!

 :i550 0

!# Babyl A:! !C# Move to next message and summarize it.
Given an argument, moves forward that many undeleted messages, and
    summarizes the intervening messages as well as the last one.
If the option variable Babyl A Mode Display is non-0, we will update
    the mode line.  (Default is to update it.)
Users on slow display terminals may want to disable updating, and use
    an occasional Z= instead, to see how many messages there are.!

 m(m.m& Declare Load-Time Defaults)
    Babyl A Mode Display, * Non-0 lets A update mode line: 1

					!* End of declare.!

 qMessage Number[1[2			!* 1: Message# originally at.!
 m(m.m# Babyl N)			!* To next (nth) message.!
 qMessage Numberu2			!* 2: Message# going to.!
 qBabyl A Mode Display"n		!* Update mode line if enabled.!
    1fsModeChw fr'			!* Display mode line since B will!
					!* inhibit it.!
 m(m.m& Push Message)			!* Will come back here when done.!
 !* ***Change this for new scheme -- simpler.!
 q1+1m(m.m# Babyl J)			!* To original+1 message.!
 q2-q1m(m.m& Babyl Survey Several Messages)	!* Survey intervening msgs.!
					!* This includes last one but not the!
					!* original message.!
 

!& Babyl Survey Several Messages:! !S survey next NUMARG2 msgs.
NUMARG1 has bits:
1, dont 1st empty survey buffer.
2, dont print as go.  ORed with Survey Quietly.
0 NUMARG just makes a label.!
!* Leaves its summary in EMACS buffer *Survey*.!
!* Bits are used by higher level surveyor.  E.g. dont-empty allows appending!
!* of several different surveys.  Dont-print allows computing the survey, in!
!* *Survey*, without having to watch it.  Good, e.g., for survey menu.!

 m(m.m& Declare Load-Time Defaults)
    Survey Quietly,:0
    *Survey* Buffer,:0

 [1[7[8[9 qSurvey Quietly[2	!* 2: 0 iff should print as go.!
 qBabyl ..D[..d			!* ..D: Be sure to use Babyl syntax,!
					!* ignore any strange ..D user may have.!
 .u7 @fn|0,fsZfsBoundw q7:j"e zj' m(m.m& Babyl Select Message)| [7[..o
					!* Auto-restoring point.!
 0fsVBw -s l .fsVBw		!* Put top at status line.!

 -1f[Truncate				!* do not continue, just excl overflow!
 q..ou9					!* 9: mail buffer.!
 q*Survey* Bufferu8			!* 8: 0 or summary buffer.!
 q8fp"n					!* If not a buffer, must create.!
    [Previous Buffer			!* Save default for ^XB.!
    m(m.mSelect Buffer)*Survey*	!* Create/select summary buffer.!
    q..ou*Survey* Buffer		!* Save buffer for quick access.!
    q..ou8				!* 8: Summary buffer.!
    m(m.mSelect Buffer)'		!* Back to Babyl buffer. *!
 q8u..o					!* Select survey buffer.!
 q2&1"e hk :iBabyl Modified Messages'	!* Empty it if no 1, bit.!
					!* This means none to resurvey.!

 q9u..o					!* select mail buffer!
 fsZ-z"e :i*C fsEchoDisplayw @ftNo Messages
	  0fsEchoActivew q8u..o 0fsXModifiedw 0fsModifiedw '

 qMessage Numberu7			!* 7: message no.!
 m.m& Get Labels for Survey[K		!* K: ditto.!
 m.m& Babyl Survey One Message[X	!* X: survey one message!

 ff&1"e 1'"# q8u..o i No. Lines        From->To        Subject or Text
 q2&2"e -t'				!* Label if NUMARG given.  Type it!
					!* if no 2, bit.!

   '<					!* Iterate NUMARG or 1 times.!
    q2&2"e fsListen"n :fi-32"n 1;'''	!* Quit if non-Space typeahead.  This!
					!* includes stopping for Rubout,!
					!* unlike using & Maybe Flush Output.!
					!* More appropriate for surveys,!
					!* unlike for --MORE--s.!

    q9u..o j				!* To message buffer.!
    s
*** EOOH ***
   2r .fsVBw				!* Set bounds past original header.!

    q8u..o 3,q7\			!* Put in message #.!
    
    q9,q8mX				!* survey message!
    
    q2&2"e -t'				!* and display our handiwork if no!
					!* 2, bit.!
    !DEL!				!* Come here to skip delete message.!
    q9u..o zj				!* Prepare to move to next message.!
    0,(fsZ)fsBoundw			!* Widen bounds.!
    4 f=
:@;					!* Stop if no next message.!
    %7w					!* Else bump our temporary message no.!
    l .,(sr). fsBoundw		!* Bounds around next message.!
    >

 q2&2"e					!* if no 2, bit say we are done!
    fsListen"n :fi-32"n ftFlushed.
	1fsFlushedw''			!* Be sure others stop, even if they!
					!* use the standard & Maybe Flush!
					!* Output which wouldnt otherwise stop!
					!* if user types Rubout..!
    "# -1"g ftDone.
     '''				!* Say done if could have done more!
					!* than one message.!
 q8u..o 0fsXModifiedw 0fsModifiedw	!* Unmodify summary buffer.!
 

!& Babyl Survey One Message:! !S msgBuf,surveyBuf NUMARGs.
MsgBuf bound so starts with CRLF.!
!* CRLF start is for easier searching for header field names.!

 m(m.m& Declare Load-Time Defaults)
    Babyl Survey FROM/TO Control,
	* Bits, 1 = enable prettification, 2 = shorten hosts, 4 = no hosts
	Can also be a macro, which is given message, survey buffers as args.
	Q1 gives point where from-to field starts in survey.  It can update
	that, e.g. if it wants to put something before the from-to area.
	It should return number (bits as above).: 3

 [0[1[2[3[4[5 [7
 u..o					!* Select message buffer.!
 mku7u0					!* 7: User label list string.!
					!* 0: Status character.!
 -u1 <.-z;%1wl>				!* 1: no. of lines in the message!
					!* Note the -1 init since CRLF at top.!
 u..o q0i 5,q1\			!* Insert status character, # lines.!

 0u0 0u3 0u4 0u5			!* 0,3,4,5: initially no 1st lines,!
					!* From:s, To:s, or Subject:s!

 u..o jl				!* beginning of 1st line of message!
 4 f=MSG:"e l				!* Skip over MSG: line if system msg!
      <	8 f~DISTRIB:@:;		!* DISTRIB: ?!
	8c @f	 l 1:x4 l >		!* treat DISTRIB: like To: !
      <	8 f~EXPIRES:@:; l >		!* skip over EXPIRES: lines!
      '					!* End of MSG:-handling!
 1:fb@:f"ew u..o i ???		!* Cant grok header.  Truncate survey.!
	       oCGM' +1"e		!* ITS header!
	:s "e u..o i ???		!* Cant grok header.  Truncate survey.!
	       oCGM' r 0x3		!* 3: ITS From.!
	:fb Re: "l 1:x5'		!* 5: subject!
	l 4 f~TO: "e 4c 1:x4 l'	!* 4: To: line!
	< 4 f~TO: @:; l>		!* skip over To lines!
	< 4 f~CC: @:; l>		!* skip over cc lines!
	0l .u0				!* 0: Point of first line.!
	'				!* end of ITS header conditional!
 "#					!* Network header!
	:s

"l 2r .u0				!* 0: Point of first line!
					!* (before actually).!
    '"# zj' fsz-.f[vz			!* set bounds around header!
	j < :s
From; @f	 l 1a-:"n !<!>'	!* find a From: line!
	    c @f	 l 1:x3 1;	!* 3: the From field.!
	    >
	j < :s
To; @f	 l 1a-:"n !<!>'	!* find a To: line!
	    c @f	 l 1:x4 1;	!* 4: the To field.!
	    >
	j < :s
Subject
Re;	    @f	 l 1a-:"n !<!>'	!* find a Subject: line!
	    c @f	 l 1:x5 1;	!* 5: the subject field.!
	    >
	f]vz				!* restore bounds to whole message!
	'				!* end of header conditional!
    u..o i   .u1 q3"n g3' !<!i-> q4"n g4'	!* < put in from->to!


 !* Now we process the FROM and TO a little to prettify it if bit-1 of the!
 !* control option is set.  If from/to is a hook, it can reset q1 which!
 !* specifies where from-to part starts.!

    qBabyl Survey FROM/TO Control[9	!* 9: Control bits.  This should be!
					!* set by & Babyl Survey Several!
					!* Messages actually.!

    fq9"g ,m9+0u9'			!* 9: If control is a macro, call it,!
					!* and let it process first, then!
					!* return to us the control bits.!
    q9&1"n				!* Prettification is enabled.!

      !* First process ITS structured names of BUG form and comments.  By!
      !* processing comments first, they wont confuse later stuff -- e.g.!
      !* there can be commas in the comments.!

      q1j 0s(BUG !)! <:s; BUG- ful -d >   !* Change (BUG FOO) to BUG-FOO.!
      q1j < @:f(l!)! .-z; flk -@f	 k >	!* Delete other comments.!

      !* Find any RFC733 names (e.g. Foo Fah <FOOFAH at HOST>) and just keep!
      !* the stuff inside the angle brackets -- the real username -- since it!
      !* is probably briefer.!

      q1j <[5 >[6			!* setup for loop!
      < @f,-6l .u2		!* 2: Point where next fields name!
					!* starts.!
	@:f,65l .-z;		!* To /\<....> or end of field.  (The!
					!* close bracket is there to catch!
					!* arrows.)!
	1a-q5"e				!* We are at /\<....>.!
	  q2,.kd			!* Kill name before <....> and kill the open!
					!* bracket.!
	  @:f6l .-z;		!* To <...../\>.!
	  d'				!* Delete the close bracket.  We are!
	>				!* now at the end of the field.!
					!* (Usually -- if not, the next!
					!* iteration will move us there.)!

      q1j 0s,  < :s; -d >		!* Compress a bit.!

      q9&4"n				!* Show no host names at all.!
	q1j 0s at @ <:s; fkc @:f,6f(l0,1a-q6"e-1')k>'	!* ...!
      "# q9&2"n				!* Show no local host names and!
					!* shorten some others..!
	    q1j 0s at  < :s; @ >	!* Canonicalize at to @.!
	    q1j 0s@MIT-Multics < :s; @MUL >	!* shorten MIT-Multics!
	    q1j 0s@MIT- <:s; -4d >	!* abbreviate MIT host names!
	    fsOSTeco"e q1j 0s@AI@MC@ML@DMS@DM <:s; fkd >'
					!* Dont show ITSs if on one.!
	    "# q1j fsMachine:f6[2 0s@2 <:s; fkd > ]2'
					!* Dont show own machine else.!
	    q1j 0s@SU-AI <:s; @SAIL >  !* dont confuse SU-AI with MIT-AI.!
	    q1j 0s@SU- <:s; -3d>	!* Shorten other Stanford sites.!
	    q1j 0s@USC-ISI <:s; -3c-4d >  !* abbreviate ISI host names!
	    q1j 0s@CMU-10 <:s; -3D >	!* abbreviate CMU host names.!
	    ''				!* End of host shortening.!

      fsXUname:f6u2 zj i 		!* Delete self.!
      q1j fq2+2 f~2->"e fq2d'	!* Special case for if we sent it!
					!* (because dash isn't a delimiter).!
      < r :s2; r -fq2d		!* Zap our user name.!
	 1a-@"E <@:f,- k 1a--@:; q6,2a-q6@; d>'>	!* Self at non-local!
							!* ..host: zap host.!
      ]6]5				!* Clean up. Hmm... ugh.!
      '					!* End of prettification.!


    !* Now work on the subject area: labels, subject, and/or 1st text line.!

    zj -d 33-(fsHPos)f"l d'"# ,32i'	!* Subject/labels start at column 34.!
    i 7				!* Insert user label list string.  It!
					!* ends with a space if non-null.!
    q5"e q0"n				!* If no subject but have 1st line,!
	u..o 0fsZw q0j		!* go to Babyl buffer and 1st!
					!* text line.!
	!* Errset is so FW doesnt bomb if text is not really text: !
	:<@f
	 l .-z;			!* Past any whitespace.!
	  fw +1af@:-:; :l >		!* Ignore line if 1st word!
					!* ends in : - or @.  (- there!
					!* for things like mail-from.)!
	.-z"e q0j @f
	 l'				!* If heuristic obviously!
					!* failed, dont use it.!
	:x5				!* 5: And use 1st line instead of!
					!* ..subject.!
	u..o''			!* Back to brief buffer.!

    q5"n g5'				!* Insert subject/1stLine.!

    0fsHPosition-(fsWidth-2)f"g,0 d i!'w	    !* Truncate the line.!


    !CGM!				!* come here if cannot grok message!
    u..o i
   					!* end summary of this message!

    

!& Babyl Resurvey One Message:! !S Updates survey line.
Updates status char, length, labels, subject.
NUMARG is msg #.  Buffer should be survey buf.  This will be a
no-op if survey line not found.
Caller should bind:
	K: & Get Labels for Survey
	B: Babyl buffer
	S: survey buffer
	J: # Babyl J!

 .[0[1[2[3[4[5				!* 0: old survey line point.!
 3,:\u1 j:s
1"e q0j '				!* If not find message, quit.!

 qB[..o mJ				!* To babyl buffer, message.!
 0fsVBw -s l .fsVBw		!* Rebound to include original header!
					!* and status line.!
 mku2u1					!* 1,2: Status character, labels.!
 s
*** EOOH ***
					!* At reformed header.!
 .(0u3 <.-z;%3wl>)j			!* 3: # lines in message.!

 !* Both ITS- and network-header messages may start with MSG: fields: !

 4 f=MSG:"e l				!* Skip over MSG: line if system msg!
      <	8 f~DISTRIB:@:; l >		!* Skip over DISTRIB: lines.!
      <	8 f~EXPIRES:@:; l >'		!* Skip over EXPIRES: lines.!

 !* Both clauses, for ITS and network header, will set q4 to the subject line!
 !* or 0 if not found, and set q5 to the point where the 1st text line is.!
 0u4					!* 4: No subject yet.!
 1:fb@:f"ew 			!* Quit if cant grok header.!
	       '+1"e			!* ITS header.!
	:fb Re: "l 1:x4' l		!* 4: subject.!
	< 4 f~TO: @:; l>		!* Skip over To lines.!
	< 4 f~CC: @:; l>		!* Skip over cc lines.!
	0l .u5				!* 5: Start of 1st text line.!
	'				!* end of ITS header conditional!
 "#					!* Network header.!
	:s

"e	  zj' .u5			!* 5: Start of 1st text line.!
	< -:s
Subject
Re;					!* Back to possible subject field.!
	  fkc @f	 l 1a-:"n 0l !<!>'	!* Make sure it is a real one.!
	  c @f	 l :x4 1; >	!* 4: the subject field.!
	'				!* End of header conditional.!

 !* If we have no real subject line, we will use the first text line.  But we!
 !* try a heuristic to get a good 1st text line, skipping ones that appear to!
 !* be embedded header lines, e.g. if the message starts out with a yanked!
 !* message: !

 q4"e q5j				!* No subject -- go to text.!
      < @f
	 l .-z;			!* Past any whitespace to next line.!
	fw +1af@:-:; :l >		!* Ignore line if 1st word ends in : -!
					!* or @.  (- there for things like!
					!* mail-from.)!
      .-z"e q5j @f
	 l'				!* If heuristic obviously failed, dont!
					!* use it.!
      :x4'				!* 4: Now subject or 1st line.!

 !* Now we have all the necessary stuff from the message: !
 !* 1: status character, 2: null or {label list}, 3: # lines, 4: subject!
 !* or 1st text line.!
 !* We will check new status character, line count, and labels+subject against!
 !* the old and carefully tell Teco what changed, so that redisplay will not!
 !* have to retype the entire line.!

 qSu..o 0l				!* Back to survey buffer.!
 4c 0a-q1"n -d q1i -1 f'		!* Maybe reset the status character.!
 @f l \-q3"n -5d 5,q3\ -5 f'	!* Maybe reset line count.!
 0,34:fm				!* Move to column 34, where the!
					!* labels+subject should be.!
	!* Will compare label+subject together since usually have to move!
	!* subject over by retyping if labels change anyway.!
 :fx1					!* 1: Old labels+subject/text.!
 .( g2 g4				!* Get labels and subject/text.!
    0fsHPosition-(fsWidth-2)f"g,0 d i!'w	!* Truncate the line.!    
    )j					!* Back to start of labels.!
 :f f=1f"nf"l*(-1)'cr :f f'w	!* Tell Teco of any changes in labels!
					!* + subject/text.  Range starts at!
					!* difference and goes to end of line.!
 

!# Babyl D:! !C# S Delete this message, maybe select next.
Given numeric argument, n, means delete message n.
The option variable Babyl N After D controls whether Babyl
    automatically moves to another undeleted message after deleting
    this one.  Values are:
	1:  Try to do an automatic N -- move forward if can (default).
	-1: Try an N (go forward), but if no next message, try a P (go
	    backward) instead.
	0:  No movement.  You view the deleted message.
qSubDoc"n i
Pre-comma NUMARG is amount to N after this, e.g. -1 for the ^D
    command.'!

 m(m.m& Declare Load-Time Defaults)
    Babyl N After D,
	* 1 means N after a D, -1 means N or P, 0 means no movement: 1
					!* End of declare.!

 ff&1"n m(m.m# Babyl J)'		!* Go to message NUMARG.!
 m(m.m& Add Basic Label)deleted"n @ft
(Already deleted.) 			!* Department of Redundancy Department!
    0fsEchoActivew'			!* ...!
 ff&1"n fsTypeout"g 1u..h''	!* Dont mess up possible brief.!
 1f<!N-OR-P!				!* Catch if N cant go to undeleted.!
    ff&2"e				!* No pre-comma NUMARG.!
      qBabyl N After D"e '		!* Dont N.!
      1'"# ',(:i*N-OR-P): m(m.m# Babyl N)	!* Go show next!
					!* undeleted message if one exists.!
					!* The 1, (note NUMARGs switched by!
					!* : ) doesnt let N print an error if!
					!* we delete the last message.!
    >w
 qBabyl N After D"l 1m(m.m# Babyl P)'	!* Maybe P if cannot N.!
 

!# Babyl E:! !C# Expunge deleted messages.  Handles empty file.
If expunging leaves the file with no messages, a dummy message is
    inserted, since many Babyl commands don't work without some
    message in the file.!

 m(m.m& Babyl Expunge)			!* Expunge deleted messages.!
 1m(m.m& Initialize Babyl Buffer)	!* Reset things, though not message#s!
					!* since those are ok.!
 !* The initialize selected the current message.  Or if expunging left none,!
 !* it created a dummy message and selected that.!

 

!# Babyl F:! !C# Forward current message.  You can edit the message.
The mail will be set up to include the current message and a subject
    based on the original one if any.  You can then edit any of this
    before sending it off.  Describe Edit and Mail Buffer for details.
If you give a numeric argument of 2 we will try to use 2 windows, with
    the current message in the top and the message being sent in the
    bottom one.
If you give a numeric argument of 3 we will REMAIL the message instead
    of forwarding it. The variable Babyl Remail Control controls the
    action of 1F: 0 (read TO: and send); non0 (read TO: then edit and
    send). Babyl Remail Hook should be a TECO macro to run after message
    is set up. (Sorry. No 2 window mode yet...someday, 4F will do this.)
The option variable Babyl F Control controls the default action of F:
	0:  You are put in a recursive edit level on the outgoing
	    message, which has an empty To: field (point is there), a
	    subject based on the original one, and the forwarded
	    message yanked into the text field.  You can thus edit any
	    field and add comments.  On terminals with insert/delete
	    line capability, we try to optimize redisplay.
	1:  The To: and Subject: are read in the echo area, and you
	    are then put in a recursive edit level on the outgoing
	    message, with the header above the screen window, i.e.
	    with only the text field showing.  (This may be desirable
	    for users with slow terminals without insert/delete line
	    capability, or for users with printing terminals.)  Typing
	    Rubout to the subject prompt makes the message not have
	    any subject;  typing Return makes the default subject be
	    used.
	2:  Reads the To: and Subject: in the echo area, and then
	    mails the message, without entering a recursive edit
	    level.
1F or 2F will force the general default action -- i.e. as if Babyl F
    Control were 0.  (1F uses one window.)
After the message template is set up, runs any Teco program you
    provide in the variable Babyl F Hook.
When successfully exited (not aborted) it will run any Teco program
    you provide in the variable Babyl F Done Hook, passing it F's
    arguments.!

 m(m.m& Declare Load-Time Defaults)
    From:,,:0
    Subject:,:0
    Babyl Reply-To Field, * Automatic Reply-To field in mail if non-0: 0
    Babyl F Done Hook, 0 or a Teco program to run after F successfully exits: 0
    Babyl F Hook, 0 or a Teco program to run after F sets up its template: 0
    Babyl F Control,
      * 0 (general edit), 1 (read To/Re then edit), 2 (read To/Re and send): 0
    Babyl Remail Control,
      * 0 (read To field and send), non0 (read To then edit): 0
    Babyl Remail Hook, 0 or Teco program to run after message set up: 0
    Babyl Header/Text Separator,
      * 1 line that separates header and text in recursive mail edit:
      |--Text follows this line--|

 fsQPPtr[.0 [0[1[2[3[4[5[6[7[8[9	!* .0: Top level unwind point.!
 !* If called as a subroutine, by M (not @M), then pick up To and Subject.!
 !* Note that caller must provide both unconditionally.!
 :f"g :i*( :i7 )u5'		!* 5,7: To,Subj if M-called.!
 -3u6					!* 6: controls whether doing remail.!
 ff&1"n 0'"# qBabyl F Control'u2	!* 2: Controls reading,  entering.!
 :i*To continue editing this message use the C command.(
    )[Abort Resumption Message	!* For Abort Recursive Edit.!

 .(1m(m.m& Parse Header)w)j		!* Parse message, setting variables.!
					!* Leave point where it was.  The 1!
					!* means we are parsing a numbered!
					!* message.!

 fsQPPtru9				!* 9: Unwind to here to reselect back!
					!* to message buffer.!

    -2"'e,1m(m.m& Push To Edit Mail)	!* Use 2 windows if NUMARG=2 and reset!
					!* buffer mode and filenames.!
    fsModified"n			!* Aborting leaves *Mail* modified .!
      ft
Last message being composed seems to have been aborted.
Continue editing aborted message? 
      m(m.m& Yes or No)"n q.0fsQPUnwindw	!* Yes, so pop buffer etc. and!
			   f@:m(m.m# Babyl C)''	!* become a C command.!

    q6"e				!* doing remail? !
       hk
       0fsWindoww
       1,4@m(m.m^R Babyl Yank)w
       j :s

"e zj'
       .,z x3				!* 3: save msg text!
       .,zk				!* and leave header here!
       j i
					!* comment out some fields!
       0s
To:
Cc:
Fcc:					!* Set search default just once.!
       j <:s; 0l iOrig->		!* Comment out some fields.!
       fsOSTeco"e 0s
Sender:
Date:					!* For ITS, COMSAT will put in some!
					!* things anyway,!
	    j <:s; 0l iOrig->'	!* so comment original ones.!

       fsXUname:f6u6
       fsMachine:f6u8
       :i*6@8u8			!* default Sender!

       zj -@f
 	k
       i

       fsOSTeco"n iReSent-From:  g8 i
'					!* Not on ITS -- COMSAT puts on sender!
       q5u8 :f"l 1,m(m.m& Read Line)Remail to: f"ew 'u8'	!* 8: To!
       iReSent-To:  g8 i
					!* Unfortunately redun with TO on ITS,!
					!* since COMSAT doesnt strip the BCC.!
					!* But this emphasizes the remailing.!
       fsOSTeco"n  iReSent-Date:  212221000000.,fsDatefsFDConvertw i
'					!* Just on TNX.  On ITS, COMSAT will!
					!* put in a DATE field.!
	iBcc:  g8 i
					!* On ITS, this will show as TO, a!
					!* COMSAT bug of sorts.!
	qFrom:u8 q8"e :i8Unknown?
'
	fsOSTeco"n j :s
Sender:"e jl iSender:  g8''		!* On ITS, best not to bother?!
	j @f
 	k				!* Kill blank line at top.!
	zj
	gBabyl Header/Text Separator i
 g3

    qBabyl Remail Hookf"nu8 m8'w	!* run hook if any.!
    qBabyl Remail Control"n		!* if wants edit, then!
        'w				!* let user see it first!
    fsOSTeco"e m(m.m& ITS Mail Buffer)'	!* Just mail, without any!
       "# m(m.m& TNX Mail Buffer)'		!* editing.!
    0fsModifiedw 0fsXModifiedw	!* mark success!
'"#					!* begin FORWARD code!
 !* Now set up the message template for editing.  We will keep the same!
 !* subject if any or make one.!

    !* Set up To: field: !
    hk iTo:  .u3			!* 3: Point we may restore later.!
    0fsWindoww				!* Dont use any previous one.!
    q2"g q5u1 :f"l 1,m(m.m& Read Line)To: f"ew 'u1' g1'
					!* 1: Maybe read TO.!
    i
					!* End TO field.!

    !* No use of Babyl CC To or Babyl Fcc To, since forwarding is a different!
    !* idea, isnt outgoing message of this person, and since this user already!
    !* has a copy of the message, so use of cc-to for that reason doesnt help.!
    !* Hmm... strictly not true?  -- e.g. if forward has a comment by this!
    !* user?  But, user can always add a CC if wants to.!

    qBabyl Reply-To Fieldf"nu1 iReply-to:  g1 i
	'w				!* Maybe insert Reply-to field.!

    !* Set up Re: (subject) field: !
    qFrom:u1 fq1"g			!* There is a From to use.!
      iRe: 1			!* Insert it for parsing.!
      :i1???				!* 1: Uname, in case parse fails.!
      fsQPPtr( fsBConsu4 @fn|q4fsBKill|	!* 4: Temporary for parse.!
	1:< :i*,q4m(m.m& Process Recipient Field)Re	!* Parse.!
	    q4[..o j @:f@x1 >w	!* 1: Username part of from.!
	)fsQPUnwindw			!* Back to message.!
      0lk i[1: '			!* End of username part.!
    "# i[???: '			!* Unknown from.!
    qSubject:u1 fq1"g .(g1)j :l .,zk i]'	!* Append original subject if!
						!* one.  But only 1 line.!
    "# iforwarded]'			!* Or make up something.!
    0fx1				!* 1: The default subject, removed.!
    q2"g q7u4 :f"l 1,m(m.m& Read Line)Re: (1): u4' !* 4: Subject.!
	 fq4"n q4u1''			!* 1: 0 or subject line.!
    fq1"g iRe: 1
	  '				!* Done subject field.!

    gBabyl Header/Text Separator i
   q2"g .u3'				!* 3: Point we may restore.!

    j 0u1 < .-z; %1w l >		!* 1: number of lines being added.!
    .fsWindoww				!* This makes the @:f work.!
    .( 1,4@m(m.m^R Babyl Yank)w	!* Yank message to forward, without!
					!* indenting it, and keep 2 windows if!
					!* have them.!
	   )j q2"e q1@:f'		!* Scroll down, if possible, by number!
					!* of lines added.  Only if showing!
					!* new header.!
    x1					!* 1: 1st line of yanked message.!

    q3j					!* Put point in TO or at top of text.!

    qBabyl F Hookf"nu0 fm0'w	!* Run F hook if any.!

    q2-2"l m(m.mEdit and Mail Buffer)'	!* Let user edit the mail and then!
					!* mail it off.!
    "# fsOSTeco"e m(m.m& ITS Mail Buffer)'	!* Just mail, without any!
       "# m(m.m& TNX Mail Buffer)''		!* editing.!
    j :s
1"l fkc l .u1 0u0 j <l %0w .-q1;>	!* 0,1: VPos,. for 1st message line.!
	 !* If can, scroll the yanked message back up to top screen line to!
	 !* optimize probably redisplay when go back to Babyl message!
	 !* display: !
	 fsTopLine+q0fs^RVPosw  q1j q2"e 0@:f''
'					!* end of remail conditional!
    q9fsQPUnwindw			!* Back to Babyl buffer for done hook.!
 qBabyl F Done Hookf"nu1 m1'w		!* Run any done hook.!
 

!# Babyl G:! !C# Get any new mail received since Babyl was started.
1G means get mail from another mail file.  You will be asked for its
    filename.  Any kind of mail file can be read in (it figures out
    which kind it is):  ITS or TNX mail file, an RMail file, or
    another Babyl file.  The file will NOT be deleted -- you must do
    this manually, if desired.
The Append option (at the top of the Babyl file) determines where the
    new messages are put in the Babyl file and in what order:
	0: prepend messages to beginning of Babyl file
	1: append messages to end
	2: prepend and reverse order of new messages
	3: append and reverse
    Reversal is only done for the primary mail file, for the owner.
When G is done, it will run any Teco code in the variable Babyl G Done
    Hook.  Argument is 0 if no new mail, or the number of the last new
    message.
qSubDoc"n i
Pre-comma NUMARG of 1 means not a manual G -- called by I.'!

 m(m.m& Declare Load-Time Defaults)
    Babyl G Done Hook,
	User hook, run (if non0) after new mail is collected;
	argument is 0 or message# for last new message: 0


 [1[2[3[4[5[6[7[8 f[DFile		!* save!
 "e .'"# -1'u7 fsWindowu8		!* 7,8: Original point, window, so!
					!* manual G stays if no new mail. Or!
					!* -1 if auto-G, meaning not to!
					!* restore point.!
 qBuffer Filenamesu3			!* Q3: buffer filenames!
 qBabyl Mail Optionu2			!* 2: 0 (or n...), filename, or list.!
 q2fp"g 0,(,f2f"lw fq2'):g2u2'"# 0u2'	!* 2: 0 or filename.!
					!* For now, ignore others in list.!
 ff&1"e				!* No argument, use mail option.!
    q2"e m(m.m& Initialize Babyl Buffer)w '	!* Return if no mail option.!
					!* Just initialize, no G done hook.!
    et2 fsDFileu2			!* 2: full mail filename.  Directory!
    '					!* now defaults to one with mail file.!
 "# q2"n et2'			!* Default to current mail file.!
    4m(m.m& Read Filename)Mail filef"ew'u2	!* 2: Filename.!
    et2 fsDFileu2			!* 2: Full mail filename.!
    0u3'				!* Make this a non-destructive read.!

 !* Note that when done, just before the following cleanup, buffer bounds will!
 !* be wide (B=0) iff we got NO new mail.  If we did get new mail, the bounds!
 !* are set around that new mail.  (Even if all messages are new, the BABYL!
 !* OPTIONS section will still be out of bounds, and thus B~=0).  & Initialize!
 !* Babyl Buffer will return the number of the last new message, which will be!
 !* the total number (appending mail) or the number of new messages!
 !* (prepending mail).  The multiplication by B (0) or 1 translates this into!
 !* 0 or that value.  Because the bounds are wide or around new mail, the q7:j!
 !* should restore point only if no new mail.!

 @fn| q7:ju3				!* 3: -1 if able to restore point.!
      bf"nw1'*(m(m.m& Initialize Babyl Buffer))u1	!* 1: 0 or last #.!
      !* Note that a select just happend, putting point at the top of the!
      !* message.  So if our q7:j worked but was not at message top, we need!
      !* to redo it: (the :J in case original point was meaningless, e.g. in!
      !* Babyl Options).!
      q3"l q7:j"l q8fsWindoww''	!* Restore point and window.!
      qBabyl G Done Hookf"nu2 q1m2'w |	!* Run Babyl G Done Hook.!

 !REDO-G!				!* Comes here for second round if!
					!* picking up mail from crash.!

 !* ***AFTER HERE DO NOT SMASH Q2 or Q3 -- they need to be the original values!
 !* when we come back for the second round.!


 0,fsZfsBoundw			!* widen bounds!

 !* Possible errors should come after user types 1G string arg so user will be!
 !* able to type ? to error if it happens: !
 qBabyl Append Option&1"n zj		!* Append.  Will trim final whitespace!
					!* just in case user put it there.!
    !* This trimming stuff perhaps should go into just the Babylizer, and then!
    !* have & Read Babyl file call the babylizer even if the file is a Babyl!
    !* file -- it should do all the validity checking/trimming. --ECC!
    -@f
	 :  d			!* Trim any whitespace and ^L at end,!
					!* since ZMail might put them there.!
					!* Avoid K since .,.K modifies!
					!* buffer.!
    0a-"n :i*Babyl bug: no ^_ at end of filefsErr	!* Warn... !
	      i''			!* Put it in if continued !
 "# j s'				!* Prepend.!

 !* Note that we do Babylization in the Babyl file, instead of in a temporary!
 !* buffer.  Thus we save space (fewer URKS for large files), but we have to!
 !* worry about errors leaving a Babyl file with part of it not yet Babylized!
 !* or partially version converted.  So, we set up a ..N to do an HK and!
 !* when we know it is ok, 0u..N.!

 q3"e					!* If perusing, just read in mail.!
					!* This is true for 1G, or just!
					!* reading some Babyl file without!
					!* wriing back allowed.!
      .,.fsBoundw fn hk 		!* ..N: Discard unless know is ok.!
      1:< 1,er @y >w			!* Read in file.!
      0u6				!* 6: Will figure type of mail file.!
      :f~BABYL OPTIONS:"e 1u6		!* 6: This is a Babyl file.!
	1,m(m.mConvert Babyl File Version)w	!* Convert if need.!
	j :s b,.k'			!* Discard BABYL OPTIONS section.!
      "# :f~*APPEND*"e 2u6 k'		!* 6: RMail file, chop off top.!
	 !* Try to figure out if this is an ITS or TNX mail (or RMail, without!
	 !* an *APPEND*) file: !
	 "#				!* Not Babyl or appending RMail file.!
	    zj -@f
	 l				!* To end.  Backup over whitespace.!
	    0,0a-"e			!* Ends with a ^_, so likely ITS...!
	      j:l -@f0123456789l	!* To first line, end, back over!
					!* digits.  Maybe should just be 01?!
	      0,0a-;"n 2u6''''	!* Not ;nn...nn, so IS an ITS file.!
      j q6-1"e 14.,1a-14."n :i*Babyl bug: should be ^L herefsErrw''
      "# q6m(m.m& Babylize Buffer)'	!* If not Babyl file convert.!
      0u..n				!* ..N: Buffer is now consistent.!
      j '				!* Dont append or delete.!

 fsXUName:f6u1				!* 1: Username.!

 !* First check if there is no previous temporary file from a crashed Babyl,!
 !* and if there is, we will skip the rename-mail-to[BABYL for the moment and!
 !* use the existing [BABYL file.  But we will set a flag to remind us to redo!
 !* G later.  It seems to be hard to have this crash mail combined with the!
 !* real new stuff for the G Done Hook, but we print a message, so it may not!
 !* really matter much -- rare.!

 0u4					!* 4: Will redo G if becomes 1.!
 e?[BABYL 1"e fsDFileu1		!* 1: Full temporary filename.!
		   ftThere is some mail from a previous Babyl crash.
It is being read in, and will be 	!* Warning.!
		   qBabyl Append Option&1"e ftafter'"# ftbefore'	!* !
		   ft your new mail if any.
It is possible that it does not belong to this particular Babyl file.
(If you only have one Babyl file then it will belong.  Otherwise you may want
to sort the messages out, using the O command to write them to other files.)

		   1u4'			!* 4: Redo G later.!
 "#					!* No [BABYL file already.!
    q2fsDFilew				!* Default is mail filename.!
    e?"n				!* New mail not found.!
	  q4"e @ft(No new mail) 0fsEchoActivew' '	!* Do tell.!
    fsOSTeco"n :'1< er ec		!* open/close to set read date!
    		     en[BABYL 1	!* Rename for safety.!
		     >+0"n fg ftCannot get new mail (cannot rename mail file).
	Perhaps another program, such as MM or the mailer, has locked the mail file.
	'				!* Typical case on TNX.!
    0u4'				!* 4: Do not need another G.!

 .,.fsBoundw				!* set bounds to .,.!
 e[fne]				!* ..N: Push input.  THIS ..N PUSHING!
					!* MUST BE BEFORE THE HK-ONE SO THE!
					!* 0U..N LATER WILL 0 THE RIGHT ..N.!
 fn hk 				!* ..N: Discard new stuff if not known!
					!* to be consistent.!
					!* NO MORE FNs UNTIL THE 0U..N.!
 :i*AReading Mail file 2fsEchoDisplayw
 er fsIFileu5				!* 5: Name of read-in mail file, the!
					!* [BABYL one.!
 @y @ft
					!* print CRLF when done!

 qBabyl XMail Optionf"n u1		!* 1: XMail filename.!
   e?1"N et1 eief '		!* If not there, create it.!
   qBabyl XMail Append Option"n	!* We are to append new mail.!
     :i*AAppending to XMail filefsEchoDisplay
     q1m(m.m& Babyl Append)"e		!* Try fancy append.!
					!* Didnt work.!
	bj er1 fy			!* Insert XMail at beginning.!
	-@f k 0,0a-14."e -d'	!* Strip off padding.!
	f[DFile et[TECO] OUTPUT fsOSTeco"n 0fsDVersionw'	!* Open to!
	  ei				!* a safe (TNX) file.!
	  f]DFile hpef		!* Write out new XMail file.!
	b,.k'				!* Kill old XMail part.!
     fsOFileu1				!* 1: New XMail filename complete.!
     @ft 1
    0fsEchoActivew'			!* Tell user what took time.!

   "#
      :i*APrepending to XMail filefsEchoDisplay
      zj er1 @a			!* Prepend new mail to XMail file.!
      f[DFile et[TECO] OUTPUT fsOSTeco"n 0fsDVersionw'	!* Open to!
	ei				!* a safe (TNX) file.!
	f]DFile hpef			!* Write out new XMail file.!
      .,zk				!* Kill old XMail stuff.!
      fsOFileu1			!* 1: New XMail filename complete.!
      @ft 1
     0fsEchoActive''w			!* Done XMail hacking.!

 :f~BABYL OPTIONS:"e 1,m(m.mConvert Babyl File Version)w	!* If need.!
		      j:s b,.k'	!* Babyl file, chop off top.!
 "# :f~*APPEND*"e k''			!* RMail file, chop off top.!
 14.,1a-14."n				!* If not Babyl file convert.!
    m(m.m& Babylize Buffer)' j		!* ...!

 qBABYL Append Option&2"n		!* User wants reversal.!
        -.  :s$w '		!* Keep Space after . there, else the!
					!* sort is a no-op for some reason...!


 0u..n					!* ..N: Buffer now ok, can keep it.!

 qBabyl Append Option&1"n		!* Append.!
    :i*AAppending to Babyl filefsEchoDisplay	!* Tell user.!
    q3m(m.m& Babyl Append)"n		!* Can append?!
	@ft 3
	0fsEchoActivew'		!* Yes, do it.!
    "#	m(m.m# Babyl S)''		!* No, just write full combined.!
 "# m(m.m# Babyl S)'			!* Prepend: write out combined files!
 ed5					!* delete mail file!
 q4"n oREDO-G'				!* If all that just brought in mail!
					!* from last crash, go check for some!
					!* real mail.!
 

!# Babyl H:! !C# Reform or display original header.
If no argument, this forces the original header to be reformed.  (You
    can thus manually reform selected messages even if you don't have
    messages normally reformed automatically -- i.e. if you set the No
    Reformation option.)  Reparse original header.
If argument, e.g. 1H, makes the original header be the visible header,
    i.e. it unreforms.!

 [1[2					!* save registers!
 0,(fsZ)fsBoundw			!* Wide bounds to include original.!
 m(m.m& Reformed Bit)"n		!* Message was reformed.!
   m(m.m& Bounds Of Original Header)u2u1	!* 1,2: Bound original header.!
   q1,q2x1				!* 1: Original header.!
   fq1"e m(m.m& Babyl Select Message)	!* Rebound message.!
	 !* There is no original header.  Either it was discarded, or because!
	 !* of a bad header, the refBit was set and the original header is!
	 !* actually the visible one.  In either case, we can just reset the!
	 !* refBit to 0, and try reforming.  Nothing to lose, and if the user!
	 !* has edited the visible header to correct any problems, we can then!
	 !* reform ok.!
	 0m(m.m& Reformed Bit)w'	!* Turn off the bit.!
   "# :g1u2 0u2				!* Ensure room in address space.!
      !* For a moment the address space held the old visible header + 2!
      !* copies of the original header.  This ensures that the G1 below will!
      !* not get an urk and leave us without a visible header.!
      m(m.m& Bounds Of Header)k	!* Kill visible header, & jump there.!
      g1''				!* Put original header in its place.!

 m(m.m& Remove Basic Label)bad-headerw	!* In case was bad, user!
						!* corrected.  If still bad,!
						!* will be relabled.!
 ff"e				!* No NUMARG:  wants reformation.!
    m(m.m& Reform Header)'		!* ...!
 m(m.m& Babyl Select Message)		!* Set bounds around message . is in.!
 

!# Babyl I:! !C# File out Babyl file, read in another.
After saving the current Babyl file (if necessary), asks for a Babyl
    file.  Default filename is DSK:homedir;username BABYL on ITS,
    DSK:<homedir>username.BABYL on TNX.  You can override this with
    the option variable Babyl Default File.
If the Babyl file has an Owner option (either one user name or several
    user names separated by commas), then only the specified user(s)
    can modify the file.
If file is not a Babyl file, we just read -- no deleting, no writing.
The variable Babyl File Version controls the version written.  See its
    description for details.
If you try to read in a Babyl file that does not exist, offers to
    create one, asking you about the various options.
If a numeric argument is given (e.g. 1I), deleting and writing are
    inhibited.  This is like forcing this user to definitely NOT be an
    owner.
Teco programmers: describe the variable Before Babylizing File Hook.
qSubDoc"n i
A pre-comma NUMARG is a filename, so wont ask.'!

!* We try to assure robustness (not leaving a Babyl file with an inconsistent!
!* format, e.g. partially version converted) by first marking the buffer read!
!* only.  Only after done do we mark it writable.  (Not if 1I or not the owner!
!* though.)!

 m(m.m& Declare Load-Time Defaults)
    Babyl Filenames,: 0
    Babyl O Filename,: 0
    Babyl File Version, * 0: read max version, write back to same;
	  1: read and write version 1, similar for other positive N;
	 -1: read max version, write back to next version
	  This only applies to Tenex or Tops-20 systems.: 0
    Babyl Default File, * Set this to specify your normal Babyl file.  If 0,
	Babyl figures out the default filename to use.  If that is
	wrong, you can set this.  Set it to a string, the filename.
	This is especially for users whose Babyl file is not in their
	home directory, or not named from the user name.  E.g. you
	might have a subdirectory full of mail-files, and set this
	variable to (for Tops-20) PS:<SMYTHE.MAIL>SMYTHE.BABYL: 0


 [1 0[2 [3[4				!* 2: 1 if will find that Babyl file!
 f[DFile				!* should be writable.!
 qBabyl File Versionu4		!* 4: Default version control.!
 1f[FnamSyntax				!* Lone fn is FN1, keeping FN2.!

 !* Get filename of new Babyl file: *!

 fsXUname:f6u1 etDSK:1 BABYL	!* Default fn is <username> BABYL!
 fsHSname fsDSnamew			!* Default dir is home dir!
 fsOSTeco"n q4+1"e 0'"# q4'fsDVersionw' !* For prompt. -1 means 0 for read.!
 qBabyl Default Filef"n fsDFile'w	!* Let user change default.!
 ff&2"e				!* no pre-comma NUMARG!
    0[Buffer Filenames		!* 0 so default filename printed!
    m(m.m& Read Filename)Babyl fileu1	!* 1: Babyl filename!
    ]Buffer Filenames			!* Restore.!
    q1"e '				!* 0, abort.!
    !* If user didnt specify version (or said 0 -- we cant tell), then maybe!
    !* use a specific version: !
    et1				!* Set for TNX version control.!
    fsOSTeco"n q4"g fsDVersion"e q4fsDVersionw fsDFileu1'''' !* 1: Use!
								!* version N.!
 "# u1'				!* 1: New MAIL file from pre-comma.!

 !* Now that we have the filename, cleanup old Babyl file if any: *!

 1,m(m.m# Babyl Q)			!* cleanup, save previous Babyl!
					!* file if necessary.!
 :i*CfsEchoDisplay			!* clear echo area!

 !* Now we bring in the new Babyl file: !

 et1					!* Set Babyl filename.  Includes!
					!* proper version by this time.!
 fsDFilem(m.m& Read Babyl File)"n	!* If read in a real Babyl file...!
    ff&1"e 1u2''			!* 2: Non0 if can write.!
 !* It reset fsDFile to be what was actually read.  E.g. user may pick another!
 !* filename.  However, its version may be 0, and might need to be changed to!
 !* specific N for writing back, if Babyl File Version is 0.!
 fsOSTeco"n q4"e			!* User wants writing back to same.!
    fsDVersion"e			!* Greatest was read in.!
      fsIFVersionfsDVersionw'''	!* So reset to use version read.!
 fsDFileuBabyl Filenames		!* Remember this filename.!
 0uBuffer Filenames			!* Mark it read only for now.!
 0u:.b(qBuffer Index+2)		!* ...!
 -1uInhibit Write			!* ...!
 m(m.mConvert Babyl File Version)u3	!* 3: Non0 if version converted.!
 m(m.m& Reset Babyl Options)		!* Set options for this Babyl file.!
 qBabyl Owner Optionf"n u1 f~(fsXUname:f6)1"n	!* Owner?!
	0u2''w				!* 2: No, so no writeback.!
 q2"n					!* Allow write back if ok.!
    fsDFilef(uBuffer Filenames	!* ...!
	      )u:.b(qBuffer Index+2)	!* ...!
    0uInhibit Write			!* ...!
    !* Later we may only append to Babyl file.  Dont want to append version!
    !* n+1 stuff to version n Babyl file so save if converted.!
    q3"n @m(m.m# Babyl S)''		!* Save if converted and writable.!
 qBabyl Append Option&1"n zj -1'"# j's	!* Put point at a good place,!
					!* in case G gets nothing and thus!
					!* keeps point where it is now.!
 0u..h					!* Allow redisplay when we are done,!
					!* unless a user hook in G types.!

 1,m(m.m# Babyl G)			!* Get new mail, if any.!

 qBabyl O Filename"e			!* If havent yet got a default O!
    et XMAIL				!* filename, set it from the Babyls.!
    fsOSTeco"n q4f"g fsDVersion'w'	!* Set its version number now if N.!
    fsDFileuBabyl O Filename'	!* O may still fiddle with versions.!

 qNumber of Babyl Messages"e		!* Empty file.  Shouldnt happen now.!
    :i*Babyl bug:  empty file.  Please report the circumstancesfsErr
    !* In case continued: !
    :@m(m.m# Babyl Q)'			!* ...!

 :m(m.m& Babyl Select Message)		!* Can select since are some messages!
					!* there.  Or it will create a dummy.!

!# Babyl J:! !C# Jump to message with given number.
nJ goes to message n whether deleted or not.  ZJ goes to last message.
J goes to first non-deleted message.
-J goes to last non-deleted message.!

 .[1 0fsVB[2 0fsVZ[3 [4		!* save . and bounds!

 ff&1"e				!* No argument means first message!
    1m(m.m# Babyl J)			!* ...!
    m(m.m& Check Message Label)deleted"e '	!* if is not deleted.!
    1:m(m.m# Babyl N)'			!* Else call N to try next one.!

 "l					!* -J means last undeleted.!
    qNumber Of Babyl Messagesm(m.m# Babyl J)	!* ...!
    m(m.m& Check Message Label)deleted"e '	!* Last message not deleted.!
    1:m(m.m# Babyl P)'			!* Was deleted, search for non.!

 !* Here is where we try to optimize the movement.  The safest way to move,
  * that doesnt rely on Message Number and Number Of Babyl Messages
  * being correct, is to go to the top and then search for N messages.
  * However, I think we now maintain these variables pretty solidly, and so
  * can trust them, unless we get an error, in  which case they should be
  * recalculated.  So, we choose the best of these searches:  from point
  * forward, backward, from top forward, from bottome backward.
  * !

 -qMessage Numberf"gu4		!* 4: Moving forward n.!
    !* ft(Moving forward)!
    qNumber Of Babyl Messages--q4f"l+q4u4	!* 4: Faster searching!
      !* ft(Searching Z back)!
					!* backwards from end of buffer.!
					!* Will leave point at end of!
					!* desired message.!
      !* Note: the f"l:s...' etc are because stupid 0:s wont return a value!
      zj -q4f"l:s
     "e oNoSuch''w'"#w		!* 4: Faster searching forwards from!
      !* ft(Searching . forward)!
					!* point.  Leave point at top of!
					!* desired message.!
      q4f"g:s
     "e oNoSuch''w''

 "#w !* ft(Moving backward)!
     -(qMessage Number-)f"lw	!* Moving back n.!
	!* ft(Searching J forward)!
	j f"ew 1':s
	"e oNoSuch''			!* To top, then past NUMARG messages.!
     "#-u4				!* 4: Move back -q4 from point.!
	!* ft(Searching . backward)!
					!* Will leave point at end of!
					!* desired message.!
	q4f"l:s
	"e !NoSuch!			!* Nada.!
	   q1j q2fsVBw q3fsVZw	!* Nope, restore . and bounds!
	   :i*No Such Message f;Babyl-Command-Abort''w''w !* Message number!
							    !* ..unchanged.!
 f"ew 1'uMessage Number		!* Found it, set its number.!

 m(m.m& Babyl Select Message)		!* Select message . is in!
 

!# Babyl K:! !C# Delete message and append to text to be Y(ank)ed.
K kills current message.  nK kills message n.
0K kills current message, but only appends the text of the message.!

 m(m.m& Declare Load-Time Defaults)
    Babyl K Text,: ||


 [1[2
 m(m.m& Push Message)			!* Will come back here when done.!
 ff&1*"e				!* No or 0 argument, select current!
    m(m.m& Babyl Select Message)'	!* message.!
 "# m(m.m# Babyl J)'			!* Go to message NUMARG.!
 m(m.m& Add Basic Label)deletedw	!* Mark it deleted.!
 "e m(m.m& Bounds of Header)w'	!* Move past header if 0K.!
 .,zx1					!* 1: Killed text of this message.!
 zj 0a-10"n :i11
'					!* 1: Ensure it ends with CRLF.!
 qBabyl K Textu2			!* 2: Old killed text.!
 :iBabyl K Text2
1					!* Append to killed text.!
 

!# Babyl L:! !C# Attach/remove a label to the current message.
Given negative argument, removes the specified label.!
!* This is separate for documentation purposes.!
 f@m(m.mLabel Message)w 		!* Be sure to return NO value, so that!
					!* the Babyl arg gets flushed.!

!Label Message:! !C Attach/remove a label to the current message.
Given negative argument, removes the specified label.!

 m(m.m& Declare Load-Time Defaults)
    Babyl Label Abbrevs Spec,: 0

 [1[2[3
 :f"g :i*'"# 0'u1		!* 1: 0 or label STRARG.!
 m(m.m& Push To Buffer)*Babyl*	!* So works in SvM too.!

 "l					!* Unlabeling.!

    !* We will bind Babyl Labels Option rather than the CRL arguments!
    !* since this will cause other stuff, e.g. validation, to work more!
    !* correctly and is less space.  Note that forcing it to first be set to!
    !* the labels option is really just for forcing computation of the!
    !* abbrevs-only spec, so we can use them.  Abbrevs work for unlabeling.!

    m(m.m& Babyl Get Message Labels)f"ew :i*Not labeledfsErr'(
      )u2				!* 2: Labels on this message.!
    m(m.m& Use Babyl Label Table)	!* Force computation of abbrevs.!
    qBabyl Label Abbrevs Specu3	!* 3: String defining the abbrevs.!
    :i*2,3(			!* Message labels + abbrevs.!
       )m(m.m& Make Babyl Label Table)[Babyl Labels Option	!* ...!
    @fn| qBabyl Labels OptionfsBKillw|	!* Garbage collect the qvector!
						!* when done with it.!
					!* Only complete over this messages!
					!* labels.!
    :i2Remove				!* 2: Prompt part.!
    1u3'				!* 3: 1 means do not confirm if label!
					!* typed by user is not in list, since!
					!* unlabeler will complain anyway.!
"#					!* Labeling.!
    :i2Attach				!* 2: Prompt part.!
    0u3'				!* 3: 0 means confirm a label typed by!
					!* user if not in list.!

 m(m.m& Use Babyl Label Table)		!* Complete over right list.!

 !* 2-bit turned on below for labeling -- allows non-matches, i.e. new labels.!

 :"l 2+'q3,q1m(m.m& Read Babyl Label)2 label: f"e'u1	!* 1: Label.!
 f m(m.m& Label Babyl Message)1'	!* (Un)Label the message.!
 

!# Babyl N:! !C# Go forward to next undeleted message.
If numeric argument, n, goes forward n undeleted messages.
qSubDoc"n i
Pre-comma NUMARG of 1 means not to print any error message if
    no next message.  Or pre-comma numarg of string is label to f; to.'!

 [1[2[3[4
 "e '				!* That was easy -- 0 NUMARG.!
 "l -m(m.m# Babyl P)'		!* Go backwards if negative.!
 -u1					!* 1: - Repetition count.!
 qMessage Numberu2			!* 2: Come back if fail.!
 q2u3 .u4				!* 3: Original message#.!
					!* 4: Original point.!

 m.m# Babyl ^N[N			!* N: Next message mover.!
 m.m& Check Message Label[C		!* C: Label checker.!

 @fn| mCdeleted"n			!* Ended on deleted message.!
	q2m(m.m# Babyl J)		!* Ensure that we end on original or!
					!* undeleted message.!
	q2-q3"e q4:jw''			!* If ended on original, restore!
	|				!* original point.!

 < ,1mN				!* To next message, deleted or not.!
   mCdeleted"e				!* Not labeled deleted.!
	qMessage Numberu2		!* 2: Come back if no more!
					!* undeleted messages.!
	%1;'				!* Undeleted message, see if done.!
   >
 

!# Babyl O:! !C# Write message to a Babyl file.
The message will be labeled recent in the file.  Any deleted label it
    had will be removed in that file.  Other labels remain.
The variable Babyl File Version controls the default version.  See its
    description.
If the variable Babyl O Confirm New File is non-0, you will be asked
    to confirm writing a message to a new file.  The default is 0.
Runs Babyl O Message Hook on the message in the file being written
    to.  (For instance, this might remove some temporary label, e.g.
    "file", used to mark messages for filing with the M-X Output
    Labeled Messages command.)
Runs Babyl O Done Hook when successfully done.  This runs in the
    current Babyl file -- not in the file just written to.
qSubDoc"n i
Pre-comma NUMARG means dont ask for filename -- just output to the default
   for O which is in Babyl O Filename.  If that variable is set to a buffer
   object, not a string, then output to the buffer, letting caller write the
   whole file.   The buffer should start with the whole current file.'!

 m(m.m& Declare Load-Time Defaults)
    Babyl O Confirm New File,
      * If non-0, you must confirm outputting a message to a new file: 0
    Babyl O Done Hook, If non-0, run when O is done: 0
    Babyl O Filename,: 0
    Babyl O Message Hook,: 0
    Babyl File Version, * 0: read max version, write back to same;
	  1: read and write version 1, similar for other positive N;
	 -1: read max version, write back to next version
	  This only applies to Tenex or Tops-20 systems.: 0


 [1[2 qBabyl O Filename[3[4		!* 3: 0, filename, or buffer.!
 q3fp-99"g q3'f[DFile			!* Bind default filename to O!
					!* default if one exists.!
 !* Babyl O Filename should already have version control reflected in it, from!
 !* last use of it, or when init.!
 e[ e\ fn e^ e]			!* Push i/o, arrange cleanup - might!
					!* as well, though may not need it.!
 ff&2"e				!* Ask if no pre-comma NUMARG.!
    5,fAdd message tou1		!* 1: Get filename.!
    qBabyl File Versionu4		!* 4: Version control.!
    et1 fsOSTeco"n fsDVersion"e	!* If TNX user didnt say N, and wants!
      q4"e				!* ...!
	1u2 1:<er fsIFVersionu2 ec>w	!* 2: write-over-max, find N.!
	q2fsDVersionw'			!* ...!
      "# q4fsDVersionw'''		!* Or if wants next or specific, set.!
    fsDFileuBabyl O Filename'	!* Remember altered filenames!

 fsQPPtr(				!* remember place to unwind to for!
					!* running hook!
    0f[VB 0f[VZ			!* Save, open bounds.!
    .:\u1 fn1j			!* 1: string point, auto-restoring.!
    -s
   c .,(s).fsBoundariesw		!* Bound ^L CRLF status line, old!
					!* header, EOOH, message, and ^_.!
    q..ou1				!* 1: Original buffer, message.!
    q3fp"e q3[..o			!* If given output-buffer, select.!
	   fsZ"e oNEW''		!* And see if need to init it.!
    "#					!* Not given buffer, use file.!
      f[BBind				!* Select a temp buffer.!
      fsOSTeco-2"e			!* For TENEX only we have to avoid E?!
	1:<er>"n oNEW'		!* and use the unsafe errset method.!
	@y'				!* For some reason E? doesnt work!
					!* on Tenex.!
      "#				!* ITS or TWENEX can use E?.!
	e?"e er @y'			!* XMAIL file exists.  Read it in.!
	"# !NEW!			!* XMAIL file doesnt exist, will make.!
	   qBabyl O Confirm New File"n	!* Maybe confirm.!
	      @ftOutput message to new file?  1m(m.m& Yes or No)"e '' !* !
	   iBABYL OPTIONS:
Version:5
Append:1
'''					!* That is the new XMAIL files BABYL!
					!* OPTIONS section (append to end). !
    m(m.mConvert Babyl File Version)w	!* Convert if have to.!
    j :s
Append:+1"e @f	 l		!* If Append: option specified. !
       \&1"n				!* Append to file. !
          zj				!* Move to end. !
	  -@f
	  k 0a-"e -d''		!* Trim any garbage at end.  ZMail may!
					!* leave ^L there, people may!
					!* mistakenly put CRLFs.!
       "# j s ''			!* Else prepend past options section. !
    "# j:s
Append
+1"e				!* If Old form of Append option. !
          zj				!* Move to end. !
	  -@f
	  k 0a-"e -d''		!* Trim any garbage at end.  ZMail may!
					!* leave ^L there, people may!
					!* mistakenly put CRLFs.!
     "# j s''			!* Prepend, past options section.!
    .(g1)j				!* Get the message.!
    l :fb, deleted,"l fk+1d'		!* Remove any deleted label.!
    0l :fb, recent,"e 2c i recent,'	!* Add a recent label if necessary.!
    0l qBabyl O Message Hookf"nu1	!* 1:  User hook.!
      m(m.m& Babyl Select Message)	!* Set bounds for hook.!
      m1'w				!* Run hook.!
    0,(fsZ)fsBoundw			!* Open, in case hook left narrow.!
    q3fp"n				!* Maybe write new contents of file.!
      f[DFile et[TECO] OUTPUT fsOSTeco"n 0fsDVersionw'	!* For TNX,!
	ei				!* open file to something safe.!
        f]DFile hpef'			!* When close, rename to proper file.!
    )fsQPUnwind
 qBabyl O Done Hookf"nu1 m1'w		!* Run hook if any when done, and!
					!* when popped back to Babyl buffer.!
 

!& Babyl O Done Hook:! !S Label this message "filed".
Designed to go on Babyl O Done Hook.!

 1,m(m.m& Label Babyl Message)filed 	!* 1, means dont say!
						!* anything if already labeled.!

!# Babyl P:! !C# Move to previous undeleted message.!

 "e '				!* That was easy -- 0 NUMARG.!
 "l -:m(m.m# Babyl N)'		!* If negative NUMARG, do N.!

 -[1[2				!* 1: - Repetition count.!
 qMessage Numberu2			!* 2: Come back if fail.!

 @fn| m(m.m& Check Message Label)deleted"n
	q2:m(m.m# Babyl J)' |		!* Ensure end on undeleted or!
					!* original message.!
 m.m# Babyl ^P[P			!* P: Previous message mover.!

 < 1mP					!* To prev message, deleted or not.!
   m(m.m& Check Message Label)deleted"e
	qMessage Numberu2		!* 2: Come back if no more!
					!* undeleted messages.!
	%1;'				!* 1: Undeleted message, see if done.!
   >

 

!# Babyl Q:! !C# File out Babyl file and exit Babyl.
Deleted messages are expunged from the file before exiting, and the
    survey buffer is emptied.
Giving a numeric argument of 1 means do not expunge, just exit.
qSubDoc"n i
1, NUMARG means just cleanup and file away, but dont exit.'!

 qBuffer Filenames"n			!* if not (RO)!
    ff&1"e 1,m(m.m& Babyl Expunge)'	!* If no NUMARG, expunge.!
    m(m.m# Babyl S)'			!* save babyl file if changed!

 0,fsZfsBoundw hk f?			!* Kill all of buffer Babyl so that!
					!* next MM Babyl knows it must start!
					!* from scratch!
 0fsXModifiedw 0fsModifiedw		!* MM Save All Files shouldnt save!
					!* this empty buffer!
 0uBabyl Filenames
 0uBuffer Filenames
 0u:.b(qBuffer Index+2)

 :iBabyl Modified Messages		!* No messages to resurvey.!
 fq*Survey* Buffer"G			!* Stuff left from last survey.!
    q*Survey* Buffer[..o		!* Select survey buffer if its there,!
    hk 0fsModifiedw 0fsXModifiedw	!* and purge it.!
    ]..o '				!* Back to Babyl buffer.!

 ff&2"n '				!* Have 1, NUMARG so dont exit Babyl.!
 f;Babyl-Catch				!* Quit to EMACS.!

!& Babyl R Done Hook:! !S Label message "answered", remove any "reply" label.
This is a function that is designed to go on Babyl R Done Hook.!

 m.m& Label Babyl Message[L		!* L: labeler.!
 1,mLanswered				!* 1, means dont say anything if!
					!* already labeled.!
 1,-1mLreply				!* 1, means dont say anything if not!
					!* already labeled.!
 

!# Babyl S:! !C# Write out the Babyl file.!

 qBuffer Filenamesf"ew 		!* Do no saving if file is read-only.!
			 '[1  f[DFile	!* Write File smashes default.!
 fsModified"e				!* Dont write if not modified.!
    :i*CfsEchoDisplay		!* Tell user.!
    @ft(No changes need to be written)
   0fsEchoActivew '			!* ...!

 !* Buffer Filenames proably has the correct version for writing, unless the!
 !* user has changed Babyl File Version while visiting this Babyl file.!
 !* But even so, I think that we should write to what the mode line shows,!
 !* i.e. to Buffer Filenames.  Next file read will use the new spec. -ECC.!

 1,m(m.mWrite File)1		!* Write, using Buffer Filenames.!
 

!# Babyl R:! !C# Reply to message using bottom window, with message in top.
Describe Edit and Mail Buffer for details about message editing, and
    the general hooks available.
Numeric argument of 1 means just reply to the FROM field.
Numeric argument of 3 means automatically yank the message.  It will
    have the reformed header.
Numeric argument of 4 means automatically yank the message but with
    the original header.
Recipient names that start with INFO-, BBOARD@, or * will not be
    included in a CC.  (Thus you won't mistakenly reply to INFO-EMACS
    or *ITS or *AI etc.)
Some variables may be set by the user to control header formation if
    they are non-0:
Babyl Trim Recipient List: By making this 0 you can turn off any of
    this removal (including INFO-, BBOARD@, *, etc.) -- you get just
    the basic TOs and CCs based on the FROM, TO, CC, and Babyl CC To
    variable.  By making this negative, you disable the automatic INFO-,
    etc. removal only (duplicates and Babyl Dont Reply To are still
    removed).
Babyl CC To: should be a string, automatically inserted as a CC field.
Babyl Fcc To: should be a string, automatically inserted as a Fcc
    field on Tenex or Tops-20 systems.
Babyl Reply-To Field: should be a string, automatically inserted in a
    Reply-To field.
Babyl Require Subjects: if you don't supply a subject field, you will
    be asked for one before mailing.
Babyl Dont Reply To: should be a Teco search string, selecting CC
    people to remove.  Each recipient mailbox name (the user@host part
    only, not any personal name parts) is searched -- if the search is
    successful that recipient is removed.  This does not affect the
    INFO-xxx, BBOARD@, or *machine checks.  If this is 0, no removal
    searching is done;  if it is a null string, any CCs to yourself
    are removed, as if the string were "yourname@".
Babyl R Hook: a Teco program run just before entering the recursive
    edit level.
Babyl R Done Hook: a Teco program run when R completes successfully.
    By default, this hook labels the message "answered".!

 m(m.m& Declare Load-Time Defaults)
    Babyl R Done Hook, 0 or a Teco program to run after R successfully exits.
	The default is to label the message answered.: |
		m(m.m& Babyl R Done Hook)|
    Babyl R Hook, 0 or a Teco program to run after R sets up its template: 0
    Current Babyl Template Name, 0 or name of template in use: 0


 fsQPPtr[0 [1[2			!* 0: Top level unwind point.!
 :i*Standard Reply[Current Babyl Template Name	!* Signal that this is!
					!* a reply, e.g. used for inserting!
					!* the in-reply-to before mail sent.!
 :i*To continue editing this message use the C command(
    )[Abort Resumption Message	!* For Abort Recursive Edit.!

 .( 1m(m.m& Parse Header) )j		!* Parse message, setting variables.!
					!* Leave point where it was.  The 1!
					!* NUMARG means that we are parsing a!
					!* numbered message.!

 fsQPPtru2				!* 2: Unwind to here to reselect back!
					!* to message buffer.!

    (-3"'e)(-4"'e)"n		!* 3 or 4 NUMARG means yank.!
      0'"# 1',1m(m.m& Push to Edit Mail)	!* Switch to *Mail* buffer,!
						!* reset it, and use 2 windows!
						!* if not yanking.!
    fsModified"n			!* Aborting leaves *Mail* modified .!
      ft
Last message being composed seems to have been aborted.
      Continue editing aborted message? 
      m(m.m& Yes or No)"n q0fsQPUnwindw	!* Yes, so pop buffer etc. and!
			   f@:m(m.m# Babyl C)''	!* become a C command.!

    fm(m.m& Setup Reply Template)	!* Give it our arguments so it can!
					!* figure exactly what template to!
					!* create.!

    qBabyl R Hookf"nu1 m1'w		!* Run R hook if any.!

    m(m.mEdit and Mail Buffer)		!* Let user edit the mail and then!
					!* mail it off.!

    q2fsQPUnwind			!* Unwind till reselect Babyl buffer!
					!* since done hook should go off!
					!* there, not in *Mail*.!

 qBabyl R Done Hookf"nu1 m1'w		!* Done successfully (didnt abort out)!
					!* so run the done hook.!

 

!& Setup Reply Template:! !S Form the message template in buffer.
An internal routine of # Babyl R, and it should pass us its arguments.
Original message should be already parsed, and the *Mail* buffer selected.!

 m(m.m& Declare Load-Time Defaults)
    From:,,:0
    Reply-To:,,:0
    Subject:,:0
    To:,,:0
    Cc:,,:0
    Babyl CC To, * Automatic CC field in mail if non-0: 0
    Babyl Fcc To, * Automatic Fcc field in Tenex or Tops-20 mail if non-0: 0
    Babyl Reply-To Field, * Automatic Reply-To field in mail if non-0: 0
    Babyl Header/Text Separator,
	* 1 line that separates header and text in recursive mail edit:
	|--Text follows this line--|
    Babyl Trim Recipient List,
	* 0 will disable all removal of reply recipients,
-1 will disable automatic removal of INFO-xxx,*machine and BBOARD@ recipients:1
    Babyl Dont Reply To,
	* 0 or a Teco search string of CCs to remove (null means yourself): ||


 [1[2[3[4[5[6 qBabyl Trim Recipient List[7 [8[9	!* 7: Trim control.!
 1f[BothCase 1f[^PCase
 !* We will form a header based on the message being replied to, with From!
 !* becoming To, To and Cc becoming Cc, and any Babyl CC To added as Cc.!

 !* If Babyl Trim Recipient List is non-0 we will then massage this list of!
 !* recipients to see who to remove.!

 !* The TO and CCs are parsed and CCs merged into one CC field.  The parsing!
 !* gives us a list of mailbox/recipient-spec pairs.  We prune this list of!
 !* recipients using the Babyl Dont Reply To search string and maybe remove!
 !* INFO-xxx, System@, Forum@, BBOARD@, and *machine recipients.  Would be!
 !* nice if this could be driven from BBOARD name list??  The Babyl CC To!
 !* recipients are added in after the pruning, to ensure that they dont get!
 !* pruned.  Duplicates are removed, and finally this recipient list is used!
 !* to form a new TO and CC.  First set up the TO and CC fields in the reply: !

 0u0					!* 0: Will be set to the sender.!
 0fsWindoww				!* Dont use any previous one.!
 hk iTo: 				!* FROM or REPLY-TO will be To.!
 qReply-to:u0 fq0"g g0'		!* 0: Use reply-to if one.!
 "# qFrom:u0 fq0"g g0'		!* 0: Otherwise use the from.!
 "# :i*Cannot reply -- no FROM or REPLY-TO field f;Babyl-Command-Abort''
					!* No To field.!


 zj ff&1"n '-1"n			!* Full reply -- not 1R.!
    qTo:u1 fq1"g icc:  gTo:'	!* TOs become CCs.!
    qCc:u1 fq1"g icc:  gCc:''	!* CCs stay CCs.!

 !* The Babyl CC To will be added in NOW only if we are not pruning -- if so,!
 !* then we add Babyl CC To in AFTER the pruning: !

 q7"e zj qBabyl CC Tof"nu1 icc:  g1 i
   ''					!* Insert automatic-CC if one.!

zu5					!* 5: End of TOs and CCs.!

 fsOSTeco"n zj qBabyl Fcc Tof"nu1 iFcc:  g1 i
   ''					!* And auto-FCC if on TNX.!

 qBabyl Reply-To Fieldf"nu1 iReply-to:  g1 i
	'w

 zj -2 f=
"n i
     '					!* Ensure blank line at end.!


 !* Finish up the header preparation by inserting subject and separator: !


 zj qSubject:u1 fq1"g .(iRe: 1)j l.,zk'	!* Keep same subject, if one,!
						!* but at most 1 line.!

 zj gBabyl Header/Text Separator i
					!* Put in separator.!

 -3"e @fn|@m(m.m^R Babyl Yank)w|'	!* Auto-yank message if arg=3.!
 -4"e @fn|16@m(m.m^R Babyl Yank)w|'	!* Auto-yank message with original!
					!* header if argument = 4.!

 q7"e '				!* User wants none of the prune.!
					!* 7: negative to skip * pruning.!

 z-q5u5					!* 5: Z-. for end of TOs and CCs.!

 !* Now parse the TO and CC fields, collecting the recipient list in a buffer!
 !* in Q2.  The TO is parsed first so its recipient will be at the top, thus!
 !* ensuring (1) that we dont prune it (we skip 1st one), and (2) if TO and!
 !* some CC are the same, the TO is preferred.!

 fsBConsu2				!* 2: Recipient list buffer.!
 m.m& Process Recipient Field[p	!* P: Parser.!
 !* Care in the case of parsing errors, so that the user gets at least some!
 !* capability to reply.  Perhaps we could do better -- just skip the!
 !* offending recipient(s)?!
 :i9					!* 9: Collect erring field names.!
 0fo..qDebugging Babyl"e :'1<		!* Errset unless debugging.!
    fsMachine:f6,q2 mpTO		!* 2: Collect parse of TO field.!
    !* The +0 allows this to be an errset or not, since non-errset returns no!
    !* value but the +0 will then make it a no-error value.!
    >+0"n :i9TO field'			!* 9: TO field has an error.!

 fq2u3					!* 3: Point in recipient buffer where!
					!* TOs end.!
 0fo..qDebugging Babyl"e :'1<		!* Errset unless debugging.!
    fsMachine:f6,q2 mpCC		!* 2: Collect parse of CC field and!
					!* merge into one.!
    >+0"n fq9"g :i99 and ' :i99CC field'	!* 9: CC has error.!

 fq9"g fg ftWarning!  Parsing error(s) in the 9.
The recipient pruning stage has been skipped.
Do you want to continue, so that you can edit the header yourself to
   correct this problem?  
       m(m.m& Yes or No)"e 0u..h	!* No.  So clear typeout, and abort.!
			    :i*Aborting the reply f;Babyl-Command-Abort'
       '				!* Give up.  Let user hack it.!

 !* Now remove any unwanted recipients from recipient buffer.  The Dont Reply!
 !* To search string is used to check the entire mailbox name, with the search!
 !* done over <CRLF>username@host<CRLF>.  The INFO-xxx, *machine, etc.!
 !* tests are made separately, but the user can disable them by setting Babyl!
 !* Trim Recipient List negative.  The user can completely specify a mailbox!
 !* or hostname by ending with a CRLF.  No way now to completely specify the!
 !* username part except how it ends... Should come up with something?!

 q..ou4 q2u..o j			!* 4: Message buffer.  Switch to!
					!* recipient list buffer.!
 fq0"g q3j .,zfsBoundariesw'		!* There is a TO field, will ignore it!
					!* in the list (2 lines) for a while.!
 
 fsXUName:f6u1 0s
1@					!* Set removal-search default for self!
					!* at any host.!
 qBabyl Dont Reply Tou1		!* 1: 0, null, or search string.!
 q1fp"g 0s1'				!* If null or string, set search!
					!* default again.  (Null would keep!
					!* same one.)!

 j i
					!* CRLF to start first username.!

 <  .-z; .u6				!* 6: At next mailbox name line.!
   q7"g					!* If wants general pruning, do it.!
      !* First a couple of special case checks, since they are not filters on!
      !* the entire uname part: !
      1a-*"e 2k !<!>'			!* Starts with *, so dont CC.!
      5 f~INFO-"e 2k !<!>'		!* Starts with INFO-, so dont CC.!
      !* Now remove certain unames.  These are intended generally to be set by!
      !* the site-specific EMACS:BABYL.VARS, though perhaps the user might!
      !* have some vars set too.  (Though the user could also use Babyl Dont!
      !* Reply To.)!
      :@f%@x8			!* 8: Uname.!
      0fo..qBabyl No 8 Reply"n	!* If supposed to trim out this one,!
	  2k !<!>''			!* then remove it.!
   q1"n					!* User wants some pruning.!
      2r 2f :fb"l q6j 2k !<!>'	!* This mailbox matches, so prune.!
      q6j'				!* Doesnt match, back to mailbox.!
   2l >					!* Keep this CC recipient.!

 j 2d					!* Remove CRLF at top.!


 !* Pruning is done, so ok to add in the explicitly-wanted auto-cc specified!
 !* by the Babyl CC To variable.  We will parse-collect this from a TEMP!
 !* buffer, so that we dont re-collect the already-pruned CCs.  Note that we!
 !* dont have to insert into the message buffer now, since we will later be!
 !* creating whole new To and CC fields, made from the recipient buffer.!

 qBabyl CC Tof"nu1			!* 1: auto-cc field.!
    zj					!* Will add at end of recip buffer.!
    f[BBind icc:  g1 i
     					!* Put it into a temp buffer.!
    fsMachine:f6,q2 mpCC		!* 2: Collect those new CCs.!
    f]BBind'				!* Back to recipient buffer.!


 !* Remove duplicate recipients (based on mailbox) in the CCs.  Will handle!
 !* TOs shortly.  When removing a duplicate, the 1st appearing recipient is!
 !* preferred -- these may be if in their full recipient (not mailbox) forms.!
 !* Also note that we compare with case ignored.!

   l  l 				!* Sort on mailbox names, each sort!
					!* record being a recipient line pair.!
 :i1					!* 1: Initial comparison will fail.!
 <  .-z; f f~1"e 2k'		!* A duplicate -- remove it.!
    "# x1 2l' >				!* 1: Not a duplicate, so reset the!
					!* name to compare against.!

 !* Now remove any CC which have the same mailbox as a TO.!

 j 0fsVBw				!* Open bounds to include TOs.!
 <  .@; -2l x1				!* 1: Get another TO mailbox.!
    .( 2l <.-z; f f~1"e 2k'"# 2l'> )j	!* Remove duplicates of it!
						!* among the CCs.!
    >					!* Iterate over the TOs.!


 !* Now time to form the real header out of the recipient list we have.  Note!
 !* that it is being massaged in the recipient buffer, not the message buffer.!
 !* Doesnt really matter -- seems a little easier to debug, having both!
 !* around.!

 j .,q3fsBoundariesw			!* Bound to just TOs.!

 z"g  iTo: 				!* 1: There is a TO field.!
      < .u1 k :l i, 			!* 1: Start of this TO.  Keep only the!
					!* full recipient form.!
	fsSHPOS-70"g q1j i
    '					!* Auto-fill if need to.!
	:l 2d .-z; >			!* To next TO mailbox line.!
      -2d i
'					!* Delete final Comma Space and finish!
					!* field with a CRLF.!

 0fsVZw .-z"l iCc: 			!* Open to CCs if there are any.!
      < .u1 k :l i, 			!* 1: Start of this CC.  Keep only the!
					!* full recipient form.!
	fsSHPOS-70"g q1j i
    '					!* Auto-fill if need to.!
	:l 2d .-z; >			!* To next CC mailbox line.!
      -2d i
'					!* Delete final Comma Space and finish!
					!* field with a CRLF.!


 !* Now put this header in the message buffer, and we are ready for the user!
 !* in all his or her gory editing, messing up all the trouble we just took.!

 q4u..o					!* Switch to message buffer.!
 b,(z-q5)k				!* Kill old TOs and CCs.!
 g2 q2fsBKillw				!* Get new TOs and CCs, and kill the!
					!* recipient buffer.!
 zj 					!* Leave point at end and we are done.!

!# Babyl T:! !C# Type some or all of this message.
Numeric argument is optional message number.!
!* Will leave point after typed part of message, so Space will print from!
!* there.!

 ff"n m(m.m# Babyl J)'		!* Goto message# argument.!
 fsz-z"e ftEnd of file
   '					!* Nothing to type.!
 [0[1 [3[4[5
 ft
#  qMessage Number=			!* Label with message number.!
 m(m.m& Bounds Of Header)u4u5		!* 5,4: header.!
 q5j 1u3 <l.-z;%3w>			!* 3: Number of lines in message.!
 q5f[vb j4l .-b-200"g b+200j .u1 :l fshpos-120"g q1j '"# l ''
					!* Print min(4 lines, 200 chars+#till!
					!* end of line).!
 .-q4"l q4j '				!* But print at least all relevant!
					!* header lines.!
 z-.-150"l zj '				!* If less than 150 chars left, print!
					!* all.!
 b,.t -2 f=
"n   ft
'					!* Then type CR unless stuff typed!
					!* ended with one.!
 :m(m.m& Babyl --MORE--)		!* Do more processing.!

!# Babyl U:! !C# Undelete a message.
Giving no numeric argument means undelete current message if deleted,
    or go back to one that is deleted and undelete that.
Giving a numeric argument, n, means undelete message number n.!

 [0[1
 ff&1"n fsTypeout"g 1u..h'		!* dont mess up possible brief!
	m(m.m# Babyl J)		!* Go to message NUMARG.!
	m(m.m& Check Message Label)deleted"e	!* Not deleted?!
	   :i*Message not deletedf;Babyl-Command-Abort''  !* Bitch.!
 "#					!* Have no NUMARG.!
    .u0					!* 0: Original point in case fail.!
    qMessage Numberu1			!* 1: Orig message number in case.!
    m.m# Babyl ^P[P			!* P: Previous message mover.!
    f<!Babyl-Command-Abort!		!* Catch lack of deleted messages.!
       m(m.m& Check Message Label)deleted@:;	!* This is the one to!
						!* undeleted.!
       1mP				!* Else move back a message.!
       >"n q1m(m.m# Babyl J)		!* Found no one, back home.!
	   q0j				!* ...!
	   :i*No previous deleted message f;Babyl-Command-Abort'' !* ...!

 m(m.m& Remove Basic Label)deletedw	!* Unmark deleted.!
 

!# Babyl V:! !C# Edit and send mail, with template initialization.
DOC .(g(m.m~DOC~ Mail With Template))j k COD!
!*
This is separate for documentation purposes!
 f:m(m.mMail With Template)

!# Babyl W:! !C# Access whole file.!
 fsVB+(fsWindow)fsWindoww		!* fix window!
 0,fsZfsBoundw			!* widen bounds!
 

!# Babyl X:! !C# Execute an extended EMACS command.
This is just like the EMACS ^R Extended Command command.!
 fm(m.m^R Extended Command)w 	!* dont return anything!

!# Babyl Y:! !C# Yank and reset (empty) text saved by K.
nY yanks into message number n.
0Y or -nY just discards the saved text, in case you mistakenly typed K.!

 m(m.m& Declare Load-Time Defaults)
    Babyl Modified Messages,: ||
    Babyl K Text,: ||


 [0[1[2
 ff&1"n "g m(m.m# Babyl J)'	!* goto message NUMARG!
	    "# :iBabyl K Text ''	!* 0 or -n means just reset.!
 .( zj 0a-10"n i
'					!* Ensure CRLF after 1st message.!
    gBabyl K Text )j			!* Append Babyl K Text to end of!
					!* this message.!
 :iBabyl K Text			!* and put null in Babyl K Text!
 qMessage Number:\u0			!* 0: message# as string.!
 :fo..qBabyl Modified Messagesu1	!* 1: index of old list/macro.!
 q:..q(%1)u2				!* 2: old list/macro.!
 :i:..q(q1)20m0
					!* Add in our part. (Line count has!
					!* changed).!
 

!# Babyl Z:! !C# Return no. of messages in current file.!
 qNumber of Babyl Messages:\[1	!* 1: no. of messages as a string!
 :i551 0			!* append to Q5, return something to!
					!* say we have set Q5!

!# Babyl <:! !C# Go to the beginning of the current message.!
  bj					!* Bounds are around current message.!
					!* Just jump to beginning of virtual!
					!* buffer.!
  

!# Babyl >:! !C# Go to the end of the current message.!
  zj					!* Bounds are around message.!
  

!# Babyl \:! !C# Refill the current message.
The numeric argument specifies one or two things:  the fill column,
    and whether to consider indented lines as paragraph starters, as
    opposed to lines of a yanked message.
Fill Column:  If no argument, or a 0 argument, is given, the variable
    Fill Column is used.  Otherwise the absolute value of the argument
    is used.
Positive argument says to do default filling -- indented lines are not
    paragraph starters.
0 or negative argument says they are paragraph starters.
Thus, for example, plain \ does default, using default Fill Column.
    0\ does paragraph like filling, using default Fill Column.
This will not touch header or mail separator lines, and will respect
    indentation.  E.g. any yanked messages will be filled separately,
    keeping their indentation.
M-x Undo<cr> will bring back the old message in case filling caused
    problems.!

 [1
 m(m.m& Bounds Of Header)u1u1		!* 1: Top of header.!
 fnq1j					!* Auto-restore point there.!
 .: :s"l r'"# zj'			!* Region around message text.!
 ff"n "n   ''[Fill Column	!* Use abs(NUMARG) or variable.!
 ff"n :"g				!* Maybe use alternate fill style!
    1''@m(m.m^R Fill Indented Mail Region)w 	!* Refill the text.!

!# Babyl ?:! !C# Generate a list of Babyl commands, or just describe 1 character.!
!*
This is separate for documentation purposes.!
 f:m(m.mthe Babyl Helper)

!# Babyl |:! !C# Move to next message with some label.
DOC .(g(m.m~DOC~ Next Labeled Message))j k COD!
!* This is separate for documentation purposes.!
 f@m(m.mNext Labeled Message)w 	!* Be sure to return NO value, so that!
					!* the Babyl arg gets flushed.!

!the Babyl Helper:! !S Quick help for Babyl commands.
Invoked from Babyl with ?, this function prompts for a Babyl command
character and describes what that command does.  If user answers the
prompt with *, all commands are described.  Typing [HELP] at the
prompt will get the standard EMACS helper.!

!* Should it also do a list commands on the Babyl (or all???) file?
 * Asks for a character (* for all) and documents that.!
!* Maybe we can call something used by Wall Chart to insert the list, and
 * then we can mung it?  It is too bad that & List One File doesnt allow the
 * option of inserting rather than typing.!

 [1[2[f @ft
Type a Babyl command character to describe, "*" for all of them: 
 @:fi-233."e fsReRead'		!* Control-Altmode (End) acts like Return.!
 fiu1					!* Read a character.!

 q1-*"n 1,q1m(m.m& Babyl Macro Get) '  !* Single character describe.!

 ft
Single-character Babyl commands:


 m.m& Babyl Macro Getu2		!* cache this.!
 m.m& Maybe Flush Outputuf		!* and this.!
 A-1u1 Z-A+1< 2,%1m2 mf >	!* A-Z.!
 ft0-9: Accumulate a numeric argument

 -1u1 0< 2,%1m2 mf >		!* Control characters.!
 9u1 A-9-1< 2,%1m2 mf >	!* Punctuation.!
 Zu1 a-Z-1< 2,%1m2 mf >	!* More punct.!
 zu1 -z< 2,%1m2 mf >		!* Yet more.!

 ft
Extended commands (invoked with "X"):
 !''!
 m(m.m& Get Library Pointer)BABYL m(m.m& List One File)C 
 !* Using "C " and not "C#" will result in skipping the dispatch table!
 !* functions which have already been listed.!
 

!# Babyl ~:! !C Collect TECO garbage.!
 -f? 

!# Babyl <Rubout>:! !C# Delete the last character from accumulating argument.
Period, Z, digits, comma, plus, minus, etc. are characters that
    make up arguments.
If you rubout the entire argument, the echo area is cleared.!

!* Q5 is a global q-register that Babyl uses to collect the characters!
!* that make up the argument.  (It is actually a little macro.)  Also note!
!* that & Babyl Execute Options has echoed the rubout, and that will erase it!
!* from the screen, sort of...  (Does a backspace-space-backspace.)  This!
!* causes a problem if the user rubs out past the beginning of the!
!* argument -- one character of the previous command history echoing will!
!* be erased.  To avoid this inaccurate history, we just clear the echo area.!

 fq5"g					!* There are some characters to!
					!* rubout.!
    0,fq5-1:g5u5			!* 5: So remove the last one.!
    0'				!* Tell our caller that we have left!
					!* an argument to use.!

 :i*C fsEchoDisplayw 		!* Clear echo area.  Return no!
					!* valu, which means the!
					!* accumulated argument should be!
					!* flushed if any.!

!& Babyl Select Message:! !S Bound msg . is in.
Create dummy message if empty file.!
!*  If after last message in buffer, selects the last one.
    If before first message, selects the first one.
    Sets point at the beginning of the message.!

 [1
 0,fsZ fsBoundariesw			!* Open wide for message search.!

 !* Put virtual buffer boundaries around message of message: !

 :s"e zj -s			!* If at end of buffer, use last.!
	 !* ***Maybe should -:s there and create dummy header?? -ECC!
	 qNumber of Babyl MessagesuMessage Number'	!* Be sure of it.!
 "# r'					!* Now point is before end .!
 fsZ-.fsVZw				!* Find end of message, set virtual!
					!* end.!
 -:s
"e					!* Oops -- trying to select the BABYL!
					!* OPTIONS section.!
    0fsVZw :s
"e   !* Babyl file has no messages (just Babyl Options section), so create a!
      !* dummy message, deleted, so the rest of Babyl can operate: !
      m(m.m& Make Dummy Message)	!* Updates Number of Babyl Messages.!
      r'				!* Leave point inside the dummy.!
    1uMessage Number			!* Be sure to get correct number.!
    :m(m.m& Babyl Select Message)'	!* Move to and select 1st message.!
 :s
*** EOOH ***
"e :i*Babyl bug: no EOOH linefsErr'
 .fsVBw				!* Set virtual beginning at top of!
					!* user visible message.!
 

!& Babyl Expunge:! !S Remove deleted msgs, unlabels recent.
Sets msg# variables.!

!* Changed to try the two-pass method, first removing deleted!
!* messages, second removing recent labels.  Should be about twice as!
!* slow as old BABYL way (which had only one pass) but 5 times faster!
!* than current BABYL' way with 10-times-slower OR-search.!

!* This routine knowns more than most about status line.!

 [0[1 0[2 [3[4[5[x			!* 2: counts # expunged.!
 qMessage Numberu5			!* 5: Current message #.!
 0,fsZfsBoundw			!* Set bounds to whole buffer.!
 .u0 j					!* 0: original point.!

 !* First pass:  remove deleted messages.!

 0s, deleted,				!* Set search default.!
 <  :s;				!* Find label-likely string.!
    0l -4 f=
   "n l !<!>'				!* Not on the status line, so skip it.!
    0l .-3,(@:flc).f(k) u1	!* Expunge message, 1: # of!
					!* characters removed.!
    q0,.f ux,q0-q1f u0w		!* 0: stays in original message or!
					!* becomes the next if the current is!
					!* expunged.!
					!* X: ignored.  Used to get rid of the!
					!* value.!
    .-q0"l q5-1u5'			!* 5: Decrement current message# if!
					!* that message is after the one just!
					!* expunged.!
    %2w >				!* 2: Count # messages expunged.!

 !* Second pass: remove recent labels.!

 j 0s, recent,				!* Reset search default.!
 <  :s; .u4				!* 4: Find label-likely string.!
    0l -4 f=
   "n l !<!>'				!* Not on the status line, so skip it.!
    q4j -8d				!* Remove the label.!
    q0,.f ux,q0-8f u0w		!* 0: stays in original message.!
    >					!* X: ignored.!

 q0:jw					!* Go back to original message.!
 qNumber of Babyl Messages-q2f(uNumber of Babyl Messages	!* Correct.!
    ),q5f : uMessage Numberw	!* Correct.  Note that q5 will be 1!
					!* too large if the current message is!
					!* the last and it is deleted.  That!
					!* is the case the sorting fixes.!
 

!& Calculate Message Number:! !S sets msg# var!
 .[0[1[2				!* 0: Original point.!
 0f[vb 0f[vz				!* Bounds wide.!
 :s"l r' .u2				!* 2: Be sure to start well within the!
					!* message so no problems of being!
					!* midway through the ^L.!
 0s
					!* Out of loop so faster.!
 0u1					!* 1: Message number counter.!
 j < .,q2:fb; %1w >			!* Count until at home.!
 q1uMessage Number			!* Do what we were told.!
 q0j					!* Restore point.!

!& Push Message:! !S So return to original msg, window when caller exits.!
!* Tries to be careful about points not existing.  Always leaves original
   message selected.  Also tries to be careful so no qregs are smashed, and
   not to leave too much stuff pushed.!

 q0,q1(					!* Dont push these on qreg pdl or!
					!* else will leave smashed for caller!
    .:\u0 fsWindow+b:\u1		!* 0,1: Point, window strings for!
					!* numbers.  Window as absolute.!
    @fn| 0fsVBw 0fsVZw		!* Wide bounds for jump back.!
	 0:j"e zj'			!* Restore original point or as!
					!* close as we can.  Should we trust!
					!* Message Number if need to zj?!
	 m(m.m& Babyl Select Message)	!* Select original message.!
	 0-b"l b'"# 0-z"g z'"# 0''j	!* Restore point.!

	 1-b"l b'"# 1-z"g z'"# 1''-bfsWindoww	!* Restore window.!
	 |
    [Message Number
    )u1u0				!* Restore 0 and 1 from paren pdl!
 :					!* Exit without popping.!

!& Bounds Of Header:! !S Return .,. around (reformed) header.
Point left at end of header.!
!* This is the header that is visible -- the reformed one if reformation has!
!* occurred, the original if it has not.  All the special Babyl message!
!* information is above the header.!

!* Some assumptions to be as general as possible, allowing use in non-Babyl!
!* buffers (e.g. after yanking) and allowing different point and bounds: !
!* 1. There may be no ^_^L separator line above point.!
!* 2. There may be no EOOH line.!
!* 3. There may be no blank line after a NET style header.!
!* 4. Point may be anywhere in the envelope -- message plus original header!
!* plus status line.!
!* 5. Bounds may be anything.  Let caller worry if what we return causes!
!* trouble.!

 [1 0f[VB 0f[VZ			!* Wide bounds.!
 -:s"e j'"# l'			!* To status line. if any.!
 :s
*** EOOH ***
w					!* Past original header section if!
					!* any.!
 .u1					!* 1: Top of header.!
 4 f~MSG:"e l				!* If ITS message, move past special!
   < 8 f~DISTRIB:@:; l >		!* header fields for them, DISTRIB,!
   < 8 f~EXPIRES:@:; l >'		!* and EXPIRES.!
 :fb:@f"ew :i*Bad header -- not ITS or NET stylefsErr
 '+1"e :s

+1f"e q1,.			!* Found blank line, ends net header.!
 '+1"e r q1,.'			!* No blank line, ends at ^_.!
 "# zj''				!* No blank line, no ^_, ends at Z.!

 l					!* Is an ITS style header.!
 <4 f~TO: @:; l>			!* Move past any ITS To,!
 <4 f~CC: @:; l>			!* and CC fields.!
 q1,.					!* Return ITS header bounds.!

!& Bounds Of Original Header:! !S Return .,. around original header +-.
Point is left at end of original header.!
!*
This is the (possibly nonexistant) header that is not visible.
If reformation has not occurred, this will be null.
If reformation has occurred, this is the original header if it has been
    kept.
Bounds are like those of & Bounds Of Header.!

!* Some assumptions to be as general as possible, allowing use in non-Babyl!
!* buffers (e.g. after yanking) and allowing different point and bounds: !
!* 1. There may be no ^_^L separator line above point.!
!* 2. There may be no EOOH line.!
!* 3. Point may be anywhere in the envelope -- message plus original header!
!* plus status line.!
!* 4. Bounds may be anything.  Let caller worry if what we return causes!
!* trouble.!

 0f[VB 0f[VZ				!* Wide bounds.!
 -:s"e j'"# 2l'			!* To top of original header section!
					!* (past status line) if any.!
 .( 2:rw :s
*** EOOH ***
   "l -l' ),.			!* Return bounds.  (Null region if no!
					!* EOOH line found.)!

!& Babyl Execute Options:! !S Babyl command loop.
Note variable Babyl Command Hook.!
!*  Global q-register usage in Babyl:
    q5 (local) holds the argument to most commands.
    Thus Q5 is vulnerable to smashing by buggy functions or random
    user arbitrariness.  Will just hope...

    Other q-registers used here are pushed during command execution to protect
    them.

    Q2, Q4, Q6, Q7, Q8, and Q9 are used here to cache some variables.
    Routines (e.g. & Reset Babyl Options) that change those variables should
    signal us to reset these qregs by setting the variable
    Babyl Variables Reset.!

 m(m.m& Declare Load-Time Defaults)
    Babyl Variables Reset,: 0
    Babyl Command Hook,
    0 or Teco program to run at times in command execution.
	Its arg tells situation:
	  In normal Babyl com loop (Q0 has com char, Q5 has arg string):
		1 before display, 2 after,
		3 before com, 4 after.
	  In survey menu (Q..0 has com char):
		5 before com, 6 after.
	  7 when entering SvM level (so you can bind things).: 0


 [0[1[2[3[4[5[6[7[8[9 [..j
 :i*Babyl[Editor Name		!* While inside subsystem, this will!
					!* cause mode lines to be recomputed!
					!* whenever Babyl is first on the!
					!* line.  Could perhaps make Babyl be!
					!* editor type, but more to type...!

 m(m.m& Babyl Select Message)		!* Does this have something to do with!
					!* allowing empty Babyl files??? !

 fsModeMacm.vPre-Babyl Mode Macrow	!* Just used by fs^REnter.!
 m.m& Babyl Set Mode Linef[ModeMac	!* update mode line using this!
					!* function!
 fs^REnteru0				!* But not in recursive levels.!
 @:i*| qPre-Babyl Mode Macrof[ModeMacro	!* ...!
       0|f[^REnter			!* ...!
 -1u0					!* 0: Initialize command character for!
					!* hooks if they want to check.!

 f<!Babyl-Catch!			!* Q, ^X and Altmode options throw out!
					!* of this!
  !* Reset some q-regs.  E.g. so Edit Babyl Options can throw out of inner!
  !* loop, and cause us to recompute q9 = no-reformation option.!
  m.m& Reformed Bitu2			!* 2: checks or sets bit.!
  m.m& Reform Headeru4			!* 4: creates pretty header.!
  m.m& Remove Basic Labelu6		!* 6: removes a label.!
  m.m& Babyl Macro Getu7		!* 7: gets function from character.!
  qBabyl Command Hookf"ew :i*'u8	!* 8: user hook.!
  qBabyl No Reformation Optionu9	!* 9: Flag saying whether to reform.!
  0uBabyl Variables Reset		!* Flag saying that our qregs have the!
					!* current values.  Setting this will!
					!* tell us to come back out here, and!
					!* reset the qregs.!

  @:f<!Babyl-Command-Abort!		!* create error catch, for teco!
					!* error throwing and for commands!
					!* to abort to.!
    !* Protect against random ^Ging when no Babyl file, e.g. when asking y/n!
    !* about new file.  So if no file here, exit: !
    fsZ"e f;Babyl-Catch'		!* Act like a Q.!

    qBabyl Variables Reset"n 0f;Babyl-Command-Abort'	!* Some command, e.g.!
					!* I, has change things.  Reset qregs.!

    :i5				!* 5: argument string!

    fsListen+(fsTYISource)"g oINPUT'	!* If input available then skip!
					!* display.!
    !* Note: & Reformed Bit will (in addition to its main job) check if the!
    !* file has no messages, and if so, create a dummy, deleted message.!
    m2"e q9"e m4''			!* Reform if havent and user wants.!

    !* Display message and mode line: *!

    fsRgetty"n fsEchoActive"l			!* clear echo area if dirty!
      :i*CfsEchoDisplay 0fsEchoActivew''	!* just like ^R would!
    1fsModeChw				!* Tell Teco to compute modeline.!
    1m8					!* Before-display hook.!
    @v					!* Display message and modeline.!
    2m8					!* After-display hook.!
    !* Remove the unseen label if can.  If there is typeout (e.g. a survey),!
    !* or if the user has typed ahead, then redisplay may not have finished!
    !* (or even started), so in that case the message is not yet seen: !
    fsTypeout"l fsListen"e m6unseenw''	!* Maybe remove unseen.!

  !INPUT!

    0f[HelpMacro			!* Turn off Help key.!
       fsRgetty"e fsTyoHPos"e ft:''	!* On printing tty, maybe prompt.!
       @:fi-233."e fsReRead'	!* Control-Altmode (End) acts like Return.!
       fiu0 q0fsEchoOut		!* else read one from terminal.!
       0u..H				!* Display over previous cmds typeout!
       0fsEchoActw			!* Dont erase echo area if only!
					!* echoed commands are in it!
    f]HelpMacro  q0-4110."e ?u0'	!* Respond properly to the Help!
					!* character!
    q0m7u1				!* 1: Look up function.!
    3m8					!* Before-execute hook.!
    [2[3[4[6[7[8[9[0			!* Protect from smashing.!
      5@m1fu1			!* 1: Execute and see if value.!
      ]0]9]8]7]6]4]3]2			!* Get back valuable qregs.!
    0fsFlushedw			!* Ensure typeout allowed now. Not!
					!* otherwise clear on printing tty.!
    4m8					!* After-execute hook.!
    q1"n oINPUT'			!* Macro returns val means dont flush!
					!* argument!
    >f"L u1				!* End of the error catch, which is!
					!* also a loop, so only exit if error!
    @ft
1.  0fsEchoActive'w			!* Print thrown text, if any.!

  >					!* loop back to Babyl-Catch, thus!
					!* re-entering the error catch!

!& Babyl Macro Get:! !S Returns 1char-command function for ASCII arg or:
1, means type its doc-string.
2, means type 1line brief doc.!

 [1[2				    !* Save some registers.!

 fsReReadw fiu1		    !* Strip off funny bits.!
 -4110."E ?u1'		    !* (but look for [HELP] character)!
 q1:i2				    !* Get character as a string.!

 q1-33"L q1+100.u2 :i2^2'	    !* Controlify control-characters.!
 "# q1-127"E :i2<Rubout>''	    !* Give rubout a name.!

 "E 1,m.m# Babyl 2f"N 'w'	!* Look up function.!

 q1-8"E :i2<Backspace>'	    !* Additional long names.!
 "# q1-9"E :i2<Tab>'		    !* ..!
    "# q1-10"E :i2<Linefeed>'	    !* ..!
       "# q1-13"E :i2<Return>'	    !* ..!
	  "# q1-27"E :i2<Altmode>' !* ..!
	     "# q1-32"E :i2<Space>''''''   !* ..!

 "E :i*2 is not a Babyl command f;Babyl-Command-Abort '

 1,m.m~DOC~ # Babyl 2f"Ew -1"G  '    !* Get doc!
    :i*- is Not a Babyl Command.'u1	!* ...!
 -1"e					!* Full documentation.!
    ft2: 				!* Character name.!
    !* Following taken from Describe.!
    f[BBind				!* Check for ... stuff.!
    g1 j:@f k d !* Describe had a [0???!
    < :s;				!* Find active documentation.!
      b,.-1t b,.k			!* Type stuff before it.!
      .,(s -d).fx1			!* 1: Stuff between s.!
      0:g1-"e m1'			!* Call it if ....!
      "# 2,m(m.mWhere Is)1"e	!* Or find what key.!
	 ft1''			!* Or just type the stuff.!
      >					!* Done active.!
    ft..o
   '					!* Type stuff after ....!
 "#					!* Just type 1-liner.!
    2,(f1f"L wfq1'):g1u1	!* 1: Trim it to 1 line.!
    ft2: 1
   '					!* Type it.!
 

!& Babyl --MORE--:! !S Maybe print --MORE-- and # of lines left in msg.!

 [1[2
 .-z"n					!* No-op if no more of message.!
    .( 0u2 <%2wl.-z;> )j		!* 2: # of lines left to print.!
    ft( q2:= z-./(fsWidth*q2)<ft*>	!* Type # lines, plus stars if avg!
    ft lines)--MORE--'			!* linel is more than tty linelength.!
 

!& Reform Header:! !S Format header on msg.  Bounds set.!
!* The header we are reformatting is the one after the EOOH line (probably
    the only one in the message, since generally the space above the EOOH
    line is empty before reformation).
Original header is left at the beginning of the message, before the vbuf.
The user option variables Babyl Reformation Flushes These Fields and
    Babyl Reformation Control affect & Form Header.  See its code for details.
The reformatted header is then inserted after the EOOH line.
Doesnt call & Reformed Bit, just because it is so simple and quick to set
    the bit ourselves.
We do things in an order that preserves Babyl file structure and
    header information in the case of an error/abort (typically an
    URK).  In particular, the following will remain true:
	1. Any header in the Babyl file (that we deal with) will remain intact
	   and be visible or accessible by 1H.
	2. The original header will be visible or accessible by 1H if the user
	   wants it kept.
	3. There will be a visible header.  Thus forming of the reformed
	   header is done in a temporary buffer.  There is a small chance that
	   an error could abort leaving TWO visible headers, with the original
	   header strictly being part of the text field.  However an URK will
	   not cause this kind of abort.  Note that the original header will
	   not be discarded (for that user option) until the reformed header
	   is installed.!

 m(m.m& Declare Load-Time Defaults)
    Babyl Reformation Merges From/Reply-To,
	* Non-0: Reply-To merges with From.
	This is part of header reformation which you can disable separately.
	Surveys of merged messages will unfortunately mention the Reply-To,
	not the From.: 0
    Babyl Reformation Flushes These Fields,
	* Visibility control for fields.
	  0 or a string, with format [fieldname1] [fieldname2] ...
	  Fields mentioned in this string, and otherwise unknown will be
	  removed from the visible header:
	|[Message-id] [Return-Path] [In-Reply-To] [Mail-From] [Rcvd-Date]
	 [Received]
	 |
    Unknown Field Flusher,: 0

 [1[2
 0fsVBw -s
 l .fsVBw				!* Bound before status line.!
 f1					!* Set reformed bit.  (So in case any!
					!* bad trouble, avoid infinitely!
					!* repeating it.)!
 0fsVZw s r z-.fsVZw		!* Now have bounds around status line,!
					!* old header, EOOH line, and message.!
 -2 f=
"e 2r'"# i
 2r'					!* Ensure a CRLF at message end.!

 !* Set cleanup handler that removes extra CRLFs at message end.  Do this!
 !* when exit, not now, so that when we pick up the original header, we will!
 !* include any blank line at its end -- if there is no text field, the!
 !* extra-crlf removal done now would remove that terminating blank line!
 !* first.  We also remove lines consisting of dashes.!

 @fn|					!* Cleanup handler.!
    zj2r .,(-@f
	 -l 0f  "n :l').:  d	!* Delete extra CRLFs at message end.!
					!* Careful about hyphens at end of a!
					!* text line, e.g. signature.!
    j					!* D not K, so if no deletion, doesnt!
					!* set fsModified. (.,.K does)!
    |					!* End of cleanup handler.!

 !* We have a message to reform: !
 qBabyl Reformation Flushes These Fields[Unknown Field Flusher !* Tell the!
					!* parser to ignore some fields.!
 1@:<					!* Catch errors to avoid trouble!
    1,m(m.m& Parse Header)		!* Set field variables.!
	!* The 1, tells it to just -1fsErrThrow if bad header.!
    	!* The 0 NUMARG tells it that it shouldnt reuse the parse variables!
	!* next time but instead reparse, parsing the reformed rather than (as!
	!* now) original header.  Leave . at end of parsed header if ok.!
    >"n					!* If anything goes wrong, just punt.!
	m(m.m& Add Basic Label)bad-headerw	!* Indicate lossage, and!
	j s
*** EOOH ***
	.fsVBw '			!* leave message bound.!

 qBabyl Reformation Merges From/Reply-To"n	!* Maybe play with the From,!
    m(m.m& Babyl Process Sender Fields)'	!* Sender, and Reply-to.!

 !* If parse was successful, point is at end of header.!
 z-.u1					!* Z-q1: end of header.!
 j :l					!* Down past status line.!
 .,(s
*** EOOH ***
  fkc).k				!* Empty anything in original-header!
					!* area, i.e. between status and EOOH!
					!* lines.!
 2l					!* Point is at top of header.!
 qBabyl No Original Option"e		!* User wants a copy of original!
					!* header kept.!
    .,z-q1x2				!* 2: Copy of original header.!
    -l g2 l'				!* Copy original header to area before!
					!* EOOH line.!
 .fsVBw				!* Reset bounds to just message.!
 f[BBind				!* Temporary buffer to form header in.!
    m(m.m& Form Header)		!* Build the reformed header.!
    zj i
					!* Add extra CRLF to be sure the!
					!* header separate from original, even!
					!* if ITS style formed.!
    hx2					!* 2: Reformed header.!
    f]BBind				!* Back to Babyl buffer, killing!
					!* temporary buffer.!
 g2					!* Get the reformed header.  The!
					!* original header follows, part of!
					!* the text now.!
 .-2,z-q1k				!* Safe to discard original header!
					!* now, plus the extra CRLF.!
 j
 0uParsed Message Number		!* Pretend we didnt parse this, since!
					!* the header we formed doesnt quite!
					!* match the parse.  This way, the!
					!* reply header former will benefit!
					!* from our hairyness.!
 

!& Parse Header:! !S Parse header into field-name variables.
& Process Recipient Field parses a recipient field.
Leaves . at end of header if all ok.
0 NUMARG means this is not a numbered message (e.g. outgoing mail).
1 NUMARG means it is a numbered message (and thus we can perhaps avoid redoing
    the parse).
Pre-comma NUMARG says to be silent about a recognized bad header, and just
    -1fsErrThrow leaving point at top.  Else gives an error message.
The variable Unknown Field Flusher is 0 or a flusher string over the field
    name.  See code for details.!

!* If a field does not have a variable defined for it -- which would indicate!
!* that some code is interested in that field -- it is added to the variable!
!* Unknown:, unless it is flushed by the string Unknown Field Flusher.  This!
!* string has field names surrounded by brackets.  The parser searches the!
!* string for the field name and brackets.  If found, it ignores the field.!
!* The intent is that the high-level, calling, function will bind this from!
!* some user option variable, e.g. to control which fields are flushed from!
!* the header.!

!* Note: The comment field of recipient field variables, e.g. From:, must!
!* start with a comma (maybe JUST be a comma).  This is used to say that!
!* continuation lines made because of a duplicate field encountered should be!
!* separated from the previous lines contents by a comma.  For instance, if!
!* the original header has!
!*	From: One@Host!
!*	From: Two@Host!
!* this will be parsed into the From: variable as One@Host,<crlf>Two@Host.!
!* (This only applies for net headers.)!

 m(m.m& Declare Load-Time Defaults)
     Parsed Message Number,: 0
     Date:,: 0
     From:,,: 0
     Sender:,,: 0
     Subject:,: 0
     To:,,: 0
     Cc:,,: 0
     Reply-To:,,: 0
     MSG:,: 0
     Mail-from:,: 0
     Redistributed-By:,,: 0
     Rcvd-Date:,: 0
     Unknown:,: 0
     Unknown Field Flusher,: 0
					!* end of declare!

 [1[2[3[4[5				!* save registers!

 !* First see if we have to do the parse or if we have already parsed this!
 !* message before.  If the message is a numbered one, we might have.  But!
 !* un-numbered messages always have to be reparsed.!

 :fo..qParsed Message Number+1u1	!* 1: ..q index for old# value.!
 :fo..qMessage Number+1u2		!* 2: ..q index for this# value.!

 "n					!* Caller says this is a numbered!
					!* message.!
    q:..q(q1)-q:..q(q2)"e		!* Same as the one we parsed last time.!
	m(m.m& Bounds Of Header)jw '	!* So just leave point at header end.!
    "#					!* Different numbered message.!
	q:..q(q2)u:..q(q1)''		!* Reset Parsed Message Number to be!
					!* this Message Number.!
 "#					!* Caller says this is not a numbered!
					!* message.!
    0u:..q(q1)'				!* Reset Parsed Message Number to 0,!
					!* so wont think it is any numbered!
					!* message.!


 :i1					!* 1: Null string for initializing!
					!* variables!
 q1uDate:
 q1uFrom:
 q1uSender:
 q1uSubject:
 q1uTo:
 q1uCc:
 q1uReply-to:
 q1uMSG:
 q1uMail-from:
 q1uRedistributed-By:
 q1uRcvd-Date:
 q1uUnknown:

 q..o( f[BBind gUnknown Field Flusher	!* Get string for flushing.!
					!* If inserts a 0, no matter.  Will!
					!* act ok -- not find any fields.!
       q..ou5 [..o			!* 5: Buffer with the flush-string.!
       )u..o				!* Back to message buffer.!

 0f[VB -s l .fsVBw		!* To status line. and set bounds!
					!* there so others below can jump up.!
 s
*** EOOH ***
					!* Jump to top of header.!

 4 f=MSG:"e 4c @f	 r @xMSG: l	!* Pick up MSG: line if system msg!
    <	8 f~DISTRIB:@:;		!* DISTRIB:?!
	8c @f	 r @xTo: l >		!* Treat the DISTRIB: line of the!
					!* message as a To: line!
    <	8 f~EXPIRES:@:; l >		!* skip over EXPIRES: lines!
    '					!* End of MSG:-handling!

 .u1					!* 1: start of header!

					!* determine header variety!
 :fb@:f"ew ff&2"n j -1fsErrThrow'	!* Silently err if precomma.!
	      :i*Bad header -- not ITS or NET stylefsErr'+1"e	!* ITS!
	s  r 0x4 :iFrom:4
					!* Get From!
	c 9 f=(Sent by "e 9c .,(fb) ).-2x4 :iSender:4
'					!* Get Sender!
	.u2				!* Q2: Start of date!
	:fb Re: "l @f	 l xSubject: 5r'	!* Pick up subject.!
	"# :l'				!* No subject.!
	q2,.x4 :iDate:4
	l				!* Get Date!
	< 4 f~TO: @:; 3c @f	 l @xTo: l >	!* Get To!
	< 4 f~CC: @:; 3c @f	 l @xcc: l >	!* Get cc!
	'				!* end of ITS header parsing!
 "#	q1j :s

"e zj'"# @f
 d 2r'				!* find end of net style header!
	fsZ-.f[VZ			!* Set bounds to just header!
	q1j < .-z; .,(:fb:"e ff&2"n j -1fsErrThrow'	!* Silent err!
			      :i*Bad header -- no colon in fieldfsErr'
					!* Maybe should give line in message?!
			    r -@f	 r).x1 c	!* 1: field-name.!
	    f~1Sent-by"e :i1Sender'	!* 1: convert to standard names!
	    f~1Received-date"e :i1Rcvd-Date'	!* ...!
	    f~1Re"e :i1Subject'	!* ...!
	    @f	 l x2		!* 2: 1st line (after white) of the!
					!* field text.!
	    < l .-z;			!* pick up text associated with!
	      1af	 :;		!* field-name, add subsequent lines!
	      @x2 >			!* if they start with whitespace!
	    !* Check if field-name recognized, and get any previous contents: !
	    0fo..q1:f"nu3 fq3"g	!* 3: Previous contents.!
	      !* Will add new stuff, which will be a new line, with!
	      !* continuation, since CRLFs are included in old contents.  If!
	      !* the variable comment starts with a comma, we separate old and!
	      !* new contents by a comma -- for recipient fields.!
	      0:g:..q(:fo..q1:+2)-,"e	!* A recipient field.!
		0,fq3-2:g3u3		!* 3: Remove trailing CRLF.!
		:i*3,
 2'"#				!* Non-recipient field.  No comma: !
		:i*3 2''"# q2'u1:'	!* New contents.!
	    "#w !* Field is unknown.  See if we are to collect it: !
		q5[..o j :s[1]"e	!* Will collect it if not in list.!
		  .(g1i:g2),.@fxUnknown:'	!* Field-name not recognized,!
		 ]..o'				!* add to list of unknowns!
	    >				!* End of get field-name iteration!
	f]VZ 2:cw			!* Bounds back to whole message!
	'				!* End of NET header conditional!
 

!& Babyl Process Sender Fields:! !S Reformat From:, Sender:, Reply-to: fields!

!* From: Foo Fah
   Reply-to: Baz at SITE
     becomes
   From: Foo Fah <Baz at SITE>

   redundant Sender: and Reply-to: fields are flushed.
   !

 m(m.m& Declare Load-Time Defaults)
    From:,,:0
    Sender:,,:0
    Reply-To:,,:0


!* From, Sender, and Reply-to will have spaces around them ...!

 [0[1[2[3 f[BBind

 @:i*|j @f 	
kzj -@f 	
k|[S					!* S: space-killer!

 gSender: mS hfx2			!* 2: Sender field!
 gReply-to: mS hfx3			!* 3: Reply-to field!

 gFrom: mS				!* put From field in buffer!
 j :s<"n				!* look for RFC type header!
    .-1u1 :s>"e '			!* save point, look for close bracket!
    .-z"n '				!* don't complain -- someone else will!
    -d q1jd				!* flush brackets!
    q1,zfx1'				!* 1: < ... > text!
 "# :i1'				!* 1: null string if no < ... >!
 mS hfx0				!* 0: main part of From!
 g1 mS hfx1				!* remove spaces from q1!

 fq1"e					!* if < ... > text is null!
    g3j @:f,()<>l .-z"e		!* and no special chars in reply-to!
	hf~0"n q3u1'			!* maybe copy Reply-to into from!
	:i3'"# hk''			!* and flush Reply-to!
 "# f~13"e :i3''			!* else flush Reply-to if redundant!

 fq1"e f~02"e :i2''			!* compare Sender with From!
 "# f~12"e :i2''			!* and flush if they are the same!

 fq1"g :iFrom:0 <1>
'					!* insert RFC733 from if q1 non-null!
 "# fq0"g :iFrom:0
''					!* else simple from!

 fq2"e q2uSender:'			!* if Sender is non-null!
 "# :iSender:2
'					!* make Sender!

 fq3"e q3uReply-to:'			!* if Reply-to is non-null!
 "# :iReply-to:3
'					!* make Reply-to!
 

!& Form Header:! !S Create NET message header, inserted at point.!
!*
Goes to some effort to determine the originating host name, which is used in
    addressees which are missing a host.
Strips leding Re:s from subject, for stupid Hermes messages.
Babyl Remove Subject Labels non-0 means we should trim subject lines that
    start of with excl (implying a reminder) or {...} (a label).
Exactly one blank line separates header from text.!

 m(m.m& Declare Load-Time Defaults)
     Babyl Reformation Control,
	* Non-zero speeds up reformation process.
	1 - Do not worry about missing hosts.
	2 - Do not prettify recipient fields either.: 0
     Date:,: 0
     From:,,: 0
     Sender:,,: 0
     Subject:,: 0
     To:,,: 0
     Cc:,,: 0
     Reply-To:,,: 0
     Redistributed-By:,,: 0
     Mail-from:,: 0
     Rcvd-Date:,: 0
     Unknown:,: 0
     Babyl Reformation Flushes These Fields,
	* Visibility control for fields.
	  0 or a string, with format [fieldname1] [fieldname2] ...
	  Fields mentioned in this string, and otherwise unknown will be
	  removed from the visible header:
	|[Message-id] [Return-Path] [In-Reply-To] [Mail-From] [Rcvd-Date]
	 [Received]
	 |

					!* End of declare.!

 [0[1[2[3[4[5[6[7[8[9 [P .f[VB fsZ-.f[VZ	!* set buffer bounds to .,.!
 fsBCONSu5 fsBCONSu9			!* 5: Temp buffer for parser.!
 @fn|q5fsBKillw q9fsBKill|		!* 9: Temp buffer for flush checks.!
 q9[..o gBabyl Reformation Flushes These Fields ]..o	!* ...!
 fsMachine:f6u7			!* 7: Local host.!
 fsOSTeco"E :i7MIT-7 '		!* (Special hack for MIT)!
 qBabyl Reformation Controlu0		!* 0: Control bits.!

 0u4					!* 4: 0 or originating host, for!
					!* handling missing hosts.!
 q0-1"l					!* Handle missing host names more!
					!* cleverly.!

    !* Cons up macro (in 1) for extracting a host name from a 733ish address.!
    !* Returns non-zero when successful: !
    :@i1|:i2 fq2::"G 0'	!* Field name into 2.!
       .,(g2:).(			!* Yank it in temporarily.!
	  j :s@ at "l		!* Found a host.  Win, Win.!
	     @f	 l .,( @:f
	 ,<>()l			!* Find end of host-name.!
		).x4'			!* 4: Pick up the host name.!
	  )k q4|			!* Kill the text.!

    m1Redistributed-by"E		!* If redistributed, then this is the!
					!* ..originating host.!
       m1From"E			!* If From: has a host, then this is!
					!* ..the next best possible guess. !
	  m1Sender"E			!* Sender:??? !

	     fqMail-from:"G		!* TNX mailers hackish Mail-from.!
		!* Next best guess.  Care required since various formats.!
		f[BBind gMail-from: 	!* Get mail-from line.!
		  qBabyl ..D[..d  0u4	!* 4: 0 until host name.!
		    !* Known kinds of syntax are: !
		    !* MAIL-FROM: network HOST host RCVD AT time!
		    !* MAIL-FROM: host RCVD AT time!
		    !* MAIL-FROM: host!
		    !* MAIL-FROM: user CREATED AT time!
		    j :s HOST "l	!* 1st part matches.!
		      .u4 :s RCVD AT "l q4j	!* 2nd part does too.!
			:@fll @flf(x4)l'	!* 4: Host name.!
		      "# 0u4''		!* 4: 2nd part didnt match, no host.!
		    "# j @f	 l @flf(x4)l	!* 4: Possible host name, move!
		       9 f~ RCVD AT "n	!* Ok if followed by RCVD AT,!
			  :f  "n 0u4'''	!* or if at end of field/line.!
		    ]..d f]BBind'''''	!* End of missing-host setup.!

 q4"E q7u4 '				!* 4: If all else fails, use local!
					!* host.!

				    !* === Start forming header === !

 !* 6: Macro for inserting non-address fields into header, with indentation.!
 !* Pre-comma arg means is required for visible header -- cannot be flushed: !

 :@i6|:i2 fq2:"E'	!* Quit if field is null.!
    "e q9[..o j:s[2]"l' ]..o'	!* Or if flushing this field.!
    i2: 5-(fsHPos)f"lw0'+1,40.i	!* indent uniformly,!
    .(g2:)j l <.-z;i     l>|	!* as we insert the text.!

 !* 1: Macro for inserting addressee fields into the header: !
 !* So far, this macro is redundant -- just calls 6.  But it may be appended!
 !* to, if doing prettification (filling, @-to-at).!

 :@i1|:i2 fq2:"E'	!* Quit if field is null.!
    fm62|			!* Else, just insert.!

 q0-2"l					!* Maybe prettify recipient fields.!
    m.m& Process Recipient FielduP	!* Cache this for later use...!
    :@i1|1				!* Start out the same...!
       0fo..qDebugging Babyl"e		!* Non-hackers dont check the errors.!
        :'1< q4,q5mP2w		!* but add missing host names...!
	     !* +0 below handles case of no : for Debugging Babyl.!
	     >+0"n :i* Parsing error in 2:-fieldfg'   !* ...maybe.!
       zj|'				!* Done.!

 m6MSG					!* Insert any MSG: field.!

 fqDate:"n q9[..o j:s[Date]( ]..o )"e	!* Date: field, if non-null!
						!* and if not flushing.!
    .(1,m6Date)+6u2			!* First insert and do line!
					!* indentation. Smashes 2.!
					!*  2: Point after Date:<space>.!
    fsOSTeco"n				!* Be fancy on TNX...!
       q2j :x8				!* 8: Old date.!
       :l 0a-)"e -flk -@f 	k'	!* Flush comment at end of line.!
       -4c 1a- "e di-'		!* Turn zone space into dash.!
       q2j 1a"a @:f, l @f, l'	!* Back to start, maybe skip weekday.!
       fsFDConvertu3 q3+1"e r'		!* Try to convert into internal form.!
       :f  "e q2,.k			!* If then at end of line, kill the!
					!* ..old one.!
	  332221000000.,q3fsFDConvert	!* And get the new one.!
	  -s  i '			!* Add extra sp between date and time.!
       "# q2j :k g8'			!* Else get back original date.!
       zj'''				!* Go to end of date, header.!

 m1From				!* Do it...!
 fqSender:"n qSender:u2 f~From:2"n m1Sender''	!* Do Sender!
					!* only if not clearly same as From.!

 m1Reply-To
 m1Redistributed-By
 m1To
 m1cc

 fqSubject:"n				!* Subject: !
    q9[..o j:s[Subject][Re]( ]..o )"e	!* Insert if not flushing.!
      .(1,m6Subject)j 8diRe:   	!* Call it Re: for brevity.!
      0fo..qBabyl Remove Subject Labels"n	!* Auto-labeling found some!
					!* labels in subject.!
	<				!* Iterate over all labels.!
	  @f	 k			!* Trim leading whitespace.!
	  0,1a-!"n 0,1a-{"n 1;''	!* Neither reminder nor { label.!
	  0,1a-!"e d'			!* A reminder excl -- trim it.!
	  0,1a-{"e .,(:fb};).k'	!* A label -- trim it.!
	  >'

    < @f	 k			!* Trim whitespace.!
       3 f~Re:@:; 3d >		!* Stip off Re:s.!
    zj''					!* Done subject field.!

 !* Now for fields that by default are not inserted -- but which have!
 !* variables defined for them, since some code is interested in them.  We!
 !* must m1 or m6 them here to allow the user control over whether they are!
 !* seen: !

 m1Mail-From				!* ...!
 m1Rcvd-Date				!* ...!
 m6Redistributed-By			!* ...!

 fqUnknown:"G gUnknown: fkc		!* If any unknowns, yank in.!
    < .-z;				!* Stop at end of field.!
      1af	 "l			!* If not a continuation line,!
	:fb:w 5-(fsHPos)f"lw0'+1,40.i' !* indent prettily after field name.!
      l > '				!* ...!

 !* If flushing left us with no fields at all, insert something, since Babyl!
 !* requires some header visible: !
 z-b"e	iMessage:
	'

 i
					!* put in blank line after header.!
    

!& Read Babyl File:! !S and Babylize.  Leaves wide buffer.
Arg is filename.
May offer to create or ask for another filename.  Resets fsDFile.
Returns nonzero iff file was a Babyl file.!
 m(m.m& Declare Load-Time Defaults)
     Before Babylizing File Hook,
	Run after reading but before Babylizing non-Babyl files: 0
    Babyl File Version, * 0: read max version, write back to same;
	  1: read and write version 1, similar for other positive N;
	 -1: read max version, write back to next version
	  This only applies to Tenex or Tops-20 systems.: 0

					!* End of declare.!

 fsZ-(z-b)"n :i*Bounds not widefsErr'	!* do error check!
 [1[2[3[4 fsDFilew hk
 e[e\ fne^e]				!* Push I/O in case is open.!
 m.m& Yes or No[Y
 qBabyl File Versionu3		!* 3: Version control.!

 !RETRY!
 e?"n					!* No such file.!
    fsDFileu1 ftThere is no Babyl file 1.
Do you want to create one? 		!* ...!
    my"n				!* Yes.!
	 1@:< 0u2			!* 2: 0 until successfully create.!
	      fsDFile, m(m.mCreate Babyl File)	!* This might err,!
	      1u2 >w q2"e oRETRY''	!* which is why the err catch.!
    "# ftWant to specify another filename? 	!* No.!
       my"n m(m.m& Read Filename)Babyl fileu1	!* 1: Filename.!
	    q1"n et1 fsOSTeco"n fsDVersion"e	!* TNX user didnt say!
							!* a version.!
		    q3"l 0u4'		!* 4: Will use version 0.!
		    "# q3"g q3u4'	!* 4: Will use version controls N.!
		    "# 			!* Overwriting max version if one.!
		      1u4 1:<er fsIFVersionu4 ec>w''	!* 4: Find N.!
		   q4fsDVersionw''		!* Set rest of default.!
		 oRETRY''			!* Go try that filename.!
       :i*No Babyl file f;Babyl-Catch''	!* Abort.!

 :i*AReading Babyl filefsEchoDisplay
 er fsIFileu1				!* 1: mail filename!
 @ft 1				!* print filename!
 @y					!* Yank in the Babyl file.!
 @ft
					!* print CRLF to say were done!
 0fsXModifiedw 0fsModifiedw

 j 1f~BABYL OPTIONS:
"e !* Got a Babyl file.  Just in case ZMail has added its typical ^L<CRLF> at!
    !* the end, trim that, since it confuses Babyl: !
    zj -@f
	 :  d			!* Trim any whitespace and ^L at end,!
					!* since ZMail might put them there.!
					!* Avoid K since .,.K modifies!
					!* buffer.!
    0a-"n :i*Babyl bug: no ^_ at end of filefsErr	!* Warn... !
	      i'			!* Put it in if continued !
    j 1'				!* Assume its ok if has BABYL OPTIONS!

 !* Was not a Babyl file, so make it one: !
 QBefore Babylizing File HookF"N U0 M0'W !* But first run user hook. !

 iBABYL OPTIONS:
Version:5
					!* Else put one on, and check it out.!
 10 f~*APPEND*
"e 10d jl iAppend
   '					!* If old-style *APPEND*, change to!
					!* the new-style Append option.!
 j s .fsVBw				!* Point just after , bound below!
 !* I think this is buggy, but am not sure -- seems like babylizer wants!
 !* a ^L beyond fsVZ that isnt there??? -- ECC, 29 May 1981.!
 m(m.m& Babylize Buffer)		!* Go check for good format of file.!
 0,fsZfsBoundariesw			!* widen bounds.!
 0					!* return zero to say this wasnt a!
					!* Babyl file!

!Convert Babyl File Version:! !C Numeric argument is desired version to go to.
This command is invoked automatically by Babyl when necessary, so
    you probably will never need to use this yourself.
If you give no numeric argument, the conversion will be to the version
    that this Babyl assumes.
Buffer should contain a Babyl file.
Point is left at the top.
You may convert up or down in versions.
qSubDoc"n i
1, means convert virtual buffer which means copying.
Returns non-0 if conversion was necessary, 0 if not.'!

 [1[2[3[4
 ff&1"n '"# 5'u2			!* 2: Version to go to.!
					!* This version of Babyl wants V5.!
 j :f f~BABYL OPTIONS:"n		!* Check.!
    :i*Not a Babyl file (no BABYL OPTIONS section)fsErr'	!* ...!
 :s
Version:+1"n :i*No version found in BABYL OPTIONS sectionfsErr'
 @f	 l				!* Past legal whitespace.!
 !* Digit check just in case user edited and maybe stuck in space or tab.!
 1a:"d :i*Version must start with a digitfsErr'	!* ...!
 \u1					!* 1: Version coming from.!
 q1-q2"e j 0'				!* Already at desired version.!
 ff&2"n				!* Convert a copy.!
    fsQPPtru4				!* 4: Unwind point.!
    hfx3				!* 3: Copy.!
    f[BBind g3 			!* Copy into temporary buffer.!
    0u3'				!* 3: 0 to prevent URKs.!
 q1,q2m(m.m& Convert Babyl File Version)	!* Do grungy work.!
 0,(fsZ)fsBoundariesw j :s
Version:+1"n			!* Very bad -- converter busted.!
    :i*No version found in BABYL OPTIONS section after conversion!!fsErr'
 :k q2\					!* Insert new version.!
 ff&2"n				!* Must copy back.!
    hfx3				!* 3: Converted copy.!
    q4fsQPUnwindw			!* Back to original buffer!
    g3 0u3'				!* 3: ...and discard copy.!
 j ft
Done. 1

!& Convert Babyl File Version:! !S Internal routine.
NUMARG1 is from-version, NUMARG2 is to-version.!

 [3[4 fsQPPtr[0			!* 0: Unwind point.!
 0,(fsZ)fsBoundariesw			!* Wide bounds.!
 :\u3 :\u4				!* 3,4: Version from/to as strings.!
 ft
Converting Babyl file from version 3 to 4...

 :oCV 3 to 4			!* If can go convert.!

					!* Could not convert directly.!
 ft by steps:
 -"l				!* Going up in version.!
    --1"e :i*I do not know how to convert 3 to 4fsErr'
    ,+1m(m.m& Convert Babyl File Version)	!* Try converting to next!
						!* version up first.!
    +1,:m(m.m& Convert Babyl File Version)'	!* And from there up!
					!* to the final, maybe stepping up.!
					!* Going down in version.!
 --1"e :i*I do not know how to convert 3 to 4fsErr'
 q0fsQPUnwindw				!* Pop q-registers.!
 ,-1m(m.m& Convert Babyl File Version)	!* Try stepping down.!
 -1,:m(m.m& Convert Babyl File Version)	!* ...!


 !CV 3 to 4!		!* From version 3.  Ensure EOOH lines.  Ensures that!
			!* every message has an EOOH line.  Leaves point at!
			!* top of buffer.  Expects file to be a Babyl file --!
			!* has an options section.  Leaves wide bounds.!

 [1
 j< :s
   ; .u1				!* 1: Next message, start of status!
					!* line.!
    :s
*** EOOH ***
+2"e				!* End of message found before EOOH.!
      q1j l i*** EOOH ***
     '					!* So put one in.!
    q1j >				!* Back to status, then to next!
					!* message.!
 



 !CV 4 to 3!		!* From version 4.  Just change version.  Since!
			!* version 4 is just requiring EOOH lines, changing!
			!* back to version 3 is just a matter of saying 3!
			!* instead of 4.!

 					!* Whew.!





 !CV 4 to 5!

	!* From version 4.  Converts from status bits and old {foo} {fah}!
	!* label format.  Version 5 has standard labels like "deleted" instead!
	!* of bits, and has a label line format that is "pretty" and good for!
	!* grabbing for mode line or surveys and yet distinguishes between!
	!* basic (bit) labels and user labels.  Also Babyl Keywords Option!
	!* renamed to Babyl Labels Option.  For ZMail users, we recognize bits!
	!* 10 and 20 as answered and filed and make those basic labels.!

!* Sample status lines:
0, unseen,,
1, deleted,, filed, junkmail,
0, bad-header,,
The <refBit> is a 0 or 1 character signalling whether the header has been
reformed -- that isn't a user-visible label.  The old bits had:
    D00nn or 100nn, with nn being 2-digit encoding of following bits:
    1: Reformed -- now the <RefBit>.
    2: Seen -- now the absence of an "unseen" label.
    4: Ungrokable header -- now the "bad-header" label.
Leaves point at top of buffer.
Expects file to be a Babyl file -- has an options section.
Leaves wide bounds.!

 [1[2[3
 j :s
Keywords:+1"e fk+2d iLabels:'	!* Rename Keywords option.!
 j< :s
;  @f
   k .-z;				!* Remove any spurious CRLFs, and!
					!* allow a final ^_^L since ZMail does!
					!* that.!
    .u1					!* 1: Next message, start of status!
					!* line.!

    !* In the following, note that legally the current format is more!
    !* flexible than we might want.  There can be arbitrary number of!
    !* spaces between close and open braces.!

    < :fb{; -d -@f	 k i, 	!* { becomes <,Space> before label.!
      :fb}"e :i*Oops -- no } after label!!fsErr'
      -d > :l -@f	 k i,		!* Line ends with one Comma.!

    !* That should have left us with exactly one Comma-Space before each!
    !* label, and exactly one Comma after each label, e.g. the line might be!
    !* 10000, foo, fah, fum,.  If didnt have any labels we have a single comma!
    !* after the status bits, which is right.!

    q1+1j 8f[IBase \u2 f]IBase	!* 2: Pick up status bits,!
					!* sans deleted bit-ha-ha.!
    q1+6j i,				!* Half of the double comma.!
    q2&4"n q1+6j i bad-header,'	!* Convert bad-header bit to label.!
    q2&2"e q1+6j i unseen,'		!* Seen (no label)/unseen.!
    q2&10."n q1+6j i answered,'	!* ZMail bit.!
    q2&20."n q1+6j i filed,'		!* ZMail bit.!
    q1j 1a-D"e q1+6j i deleted,'	!* Deleted.!

    !* The 1-bit becomes the only bit we have in version 5, the <refBit>.!
    q1j 5d q2&1+0i			!* Either 0 or 1 character.!
    >


 !CV 5 to 4!		!* From version 5.  Converts back to status bits and!
			!* old {foo} {fah} label format.  Recent label!
			!* is discarded.  Renames Babyl Labels option to!
			!* Keywords option.  Answered/filed become ZMail bits!
			!* iff they are found as basic labels.!

 [1[2[3
 j :s
Labels:+1"e fk+2d iKeywords:'	!* Rename to old option name.!
 j< :s
;  @f
   k .-z;				!* Allow/fix spurious CRLFs.!
    0l :fb, recent,"l fk+1d'		!* Throw away recent.!
    0l 1a-0u2 d			!* 2: <RefBit> is bit1, and delete it.!
    0l :fb, unseen,"l fk+1d'"# q22u2'	!* OR in seen-bit if has no!
						!* unseen label.!
    0l :fb, bad-header,"l fk+1d q24u2'	!* 2: OR in the bad header!
					!* bit, bit4, and delete the label.!
    0l :fb, answered,,,+1"e fk+1d q210.u2'	!* 2: OR in ZMail answered.!
    0l :fb, filed,,,+1"e fk+1d q220.u2'	!* 2: OR in ZMail filed.!
    8[..e 10000.+q2:\u2 ]..e		!* 2: Convert to string, with high bit!
					!* meaning not deleted.!
    0l :fb, deleted,"l fk+1d 0:f2D'	!* 2: Turn on (off?) the D bit, ha!
					!* ha..., and delete the label.!
    0l :fb,,"e :i*Ooops--broken assumptionfsErr' -d	!* Dont need to!
					!* separate the basic and user labels.!
    0l g2				!* Insert the old-style bits.!
    0s,  <:fb; } {>		!* <,Space><label><,Space> becomes!
					!* <Space>{<label>}.!
    0l5c 1a-}"e d'			!* Remove initial spurious one.!
	   
    :l -d				!* Remove the final Comma.!
    0f  -5"g i}' >			!* If had any labels, end the last!
					!* one.!
 



 !* Other converter code would go in here.   Each should end with a .!


!& Babylize Buffer:! !S Ensure a good Babyl/MAIL file format, autolabel.
Optional arg says mail-file type:  0=TNX, 1=Babyl, 2=ITS.!
!*
If Babyl Autolabel Messages option is non0, we run & Autolabel Subject
    Labels.!
!*  We only change what is in the virtual buffer boundaries, except that we
    (1) always assume there is a  just above the top of virtual buffer, to
    help start the first message.  We open the bounds briefly to make sure
    there isn't any whitespace after the  and before the Control-L we put
    on for the message starter.
    (2) check for messages following the virtual buffer, and make sure they
    concatenate nicely with the virtual buffer's messages.  If anything
    follows, it is assumed to be a sequence of messages, starting with
    a Control-L. (Not Control-L, since either the  before the VB or the
     which will end the last message in VB will concatenate with the
    Control-L.)
Point is left at the beginning of the virtual buffer.
This routine knows about the format of the status line in fair detail.!

 m(m.m& Declare Load-Time Defaults)
    Babyl Autolabel Messages,
	* Non-0 causes autolabeling from subject fields: 0


 [1
 !* These checks here may go away once we are sure of things: *!

 bj 0f[VB				!* Check for  above VB.!
       0a-"n :i*Must have Control-_ just above VB fsErr'
       f]VB				!* Back to original VB.!
 zj 0f[VZ				!* Check for FF or nothing below VZ.!
       14.,1a-14."n :i*Must have Control-L just below VZ fsErr'
       f]VZ				!* Back to original VZ.!
 !* End of validity checking.!

 ff&1"n				!* We were told the type of mail file.!
    "e oITSIFY'"# oITSIFIED''	!* 0=TNX, 1=Babyl, 2=ITS.!



 !* Check its form to see whether it seems to be ITS or TNX mail file: !
 zj -@f
	 l				!* To end.  Backup over whitespace.!
 0,0a-"e				!* Ends with a ^_, so likely ITS...!
      j:l -@f0123456789l		!* To first line, end, back over!
					!* digits.  Maybe should just be 01?!
      0,0a-;"n oITSIFIED''		!* Not ;nn...nn, so IS an ITS file.!



 !ITSIFY!				!* It is a TNX mail file.!
 m(m.m& ITSify TNX Mail)		!* Use s to separate mail.!



 !ITSIFIED!				!* It is (now at least) an ITS mail!
					!* file.!

 bj @f
	 k				!* Kill whitespace before 1st message.!


 !* Now make EVERY  be followed by the message-starting
  * FF<CRLF><Status line><CRLF>*** EOOH ***<CRLF>  sequence.
  * This includes the  sitting above VB, and the final  before VZ.
  * That last one will be corrected later.
  * The status line has a 0 reformed bit and recent and unseen labels.
  * Note the double commas -- separating basic/user label areas.
  *!

 0s					!* set search default!
 <  i
0, recent, unseen,,
*** EOOH ***
					!* Put in message start, status!
					!* line, and end-of-original-header!
					!* marker, which will take on more!
					!* meaning when header is reformed.!
    @f
	 k				!* Kill whitespace up to header.!

   :s; >				!* Repeat for all s in vbuf.!


 !* Now correct that last, extra message starter: *!

 zj -@f
 	k				!* Kill whitespace at end.!
 -36 f=
0, recent, unseen,,
*** EOOH ***"n :i*Mail file does not end with Control-_ fsErrw'
 -36d					!* Kill extra status at end.!

 qBabyl Autolabel Messages"n		!* Subject fields may have labels!
    bj m(m.m& AutoLabel Subject Labels)'

 bj 					!* Leave point at top of VB.!

!& Initialize Babyl Buffer:! !S Buffer has BABYL and MAIL already.
Selects message, flushes survey.  Creates dummy msg if need.
If no NUMARG: Calculates msg#s, returns msg# of last new mail message.!

!* If appending mail, the returned message number is thus the number of!
!* message in the file.  If prepending, it is the number of new messages,!
!* which is good for surveying just new mail -- dont otherwise know when to!
!* stop if prepended mail.!

!* Leaves bounds wide.  Avoiding message# calculation is good if they are!
!* already correct, since it causes a pass through the Babyl file, which if!
!* large causes excessive paging.!

 m(m.m& Declare Load-Time Defaults)
    Parsed Message Number,: 0
    Message Number,: 0
    Number of Babyl Messages,: 0

 0[1 .[2 -[3				!* 3: Will return -1 if dont count.!
 :s"l r'				!* Be sure to start well within the!
					!* message so no problems of being!
					!* midway through the ^L.!
 0s
					!* set search default!
 0uParsed Message Number		!* Force reparsing, since message!
					!* numbers now have different!
					!* messages.!
 ff&1"e				!* No NUMARG, so recalculate.!
    fsVZu3				!* 3: Original end.!
    0,.fsBoundw j <:s;%1>		!* 1: Count up to current message.!
    q1uMessage Number			!* And set it.!
    q3fsVZw <:s;%1> q1u3		!* 1,3: Count up to end of vbuf.!
    0fsVZw <:s;%1>			!* 1: Continue till end of buffer.!
    q1uNumber of Babyl Messages	!* And set total.!
    q2j'				!* Back to point.!

 :iBabyl Modified Messages		!* No messages to resurvey.!
 fq*Survey* Buffer"G			!* Non-empty survey buffer...!
    q*Survey* Buffer[..o		!* Select it,!
    hk 0fsModifiedw 0fsXModifiedw	!* flush it,!
    ]..o '				!* and return to original buffer.!

 m(m.m& Babyl Select Message)		!* Select message, or if none, will!
					!* create a dummy message.!

 q3					!* Return -1 or last message#.!

!& Reset Babyl Options:! !S From options at top of buffer.!
!*
Buffer should contain a BABYL file, which has at the top the options, one
    per line, ending with the first Control-_.
Each option name continues to : or end of line.  The Owner option is special
    in that it can be just "FOO" for owner FOO, or "FOO, BAR, GAG" form for
    several owners.  If one of these is the user, then Babyl Owner Option is
    set to just that owner, e.g. to just "BAR".
Each known option variable is 0 if it does not appear in the file.
If it does appear, its value is 1 if no : is on the line, or else what
    follows the :.
Known options (variables set):
    Babyl Append Option, Babyl XMail Option, Babyl XMail Append Option,
    Babyl MAIL Option, Babyl Version Option, Babyl No Original Option,
    Babyl Owner Option, Babyl No Reformation Option,
    Babyl Expiration-Check-Interval Option, 
    Babyl Expiration-Check-Time Option,
    Babyl Labels Option.!

 m(m.m& Declare Load-Time Defaults)
    Babyl Variables Reset,: 0


 [1[2 0f[VB 0f[VZ jl			!* Goto where options start.!
 0m.vBabyl XMail Optionw		!* 0 known Babyl options.!
 0m.vBabyl XMail Append Optionw	!* ...!
 0m.vBabyl MAIL Optionw		!* ...!
 0m.vBabyl Version Optionw		!* ...!
 0m.vBabyl No Original Optionw		!* ...!
 0m.vBabyl Owner Optionw		!* ...!
 0m.vBabyl No Reformation Option	!* ...!
 0m.vBabyl Labels Option		!* ...!
 0m.vBabyl Expiration-Check-Interval Option	!* ... !
 0m.vBabyl Expiration-Check-Time Option	!* ... !
 fsOSTeco"E 0 '"# 2 ' m.vBabyl Append Optionw	!* ITS mailer prepends, Tenex mailer appends!

 < 1a-@;				!* Stop when down to .!
   :fb:"l				!* Name: Value.!
      r 0x1				!* 1: Option name.!
      c@f 	l :x2			!* 2: Option value.!
      1a"D \w @f 	l (1a)-"E 2u2 '''    !* Maybe numeric...!
   "# :x1				!* 1: Option name, no : type.!
      1u2'				!* 2: Option value defaults to 1.!
   l					!* To next option.!
   1:< q2uBabyl 1 Option		!* Set this option.!
       >"n !* Used to print a message, but seems to be a nuisance.!
	   !**** @ft
(1 is not a Babyl option) 0fsEchoActivew!
					       ' 	!* !
   >

 !* Handle multiple-owners by translation: !
 qBabyl Owner Optionf"nu1		!* 1: Owner specification.!
    q1fp"g ,f1:"l		!* Spec has multiple owners.!
      f[BBind g1 j fsXUName:f6u2	!* 2: User name.!
	j i, zj i,			!* Boundary conditions for ease.!
	j 0s  <:s; -d>		!* Canonicalize: remove spaces.!
	j :s,2,"l			!* See if user in the owner list.!
	  q2uBabyl Owner Option''''w	!* Yes, so reset owner option.!
 1uBabyl Variables Reset		!* Tell & Babyl Execute Options (etc)!
					!* that variables have changed.!
 

!& ITSify TNX Mail:! !S Convert MAIL.TXTish stuff in buffer to ITS format.!
!*
Remove any MAIL FROM lines.
Convert message-length based separation to ^_ separation.
Leaves point at top of buffer.!

 m(m.m& Declare Load-Time Defaults)
     Babyl Keep TNX Received Date,
	If nonzero, add Rcvd-Date line to header: 0


 [0[1[2					!* save registers!
 QBabyl Keep TNX Received DateU0	!* Nonzero to add Rcvd-Date line. !
 j < .-z; .u2				!* 2: start of message!
      :fb,; \u1 0,1a-;@:;		!* 1: Message length.!
     l z-.-q1u1				!* 1: Z-. for message end.!
     Q0"N				!* If adding Rcvd-Date: !
        Q2J				!* Back to beginning of date. !
	IRcvd-Date: 			!* Insert header item. !
	:FB,W -1C I
					!* Add CRLF. !
	.U2 L '				!* And setup new start of message. !
     q1"l 0u1 '				!* Twenex mailers may pad trailing !
					!*  nulls which Teco will pretend !
					!*  arent there getting NIB error !
     <9 f~Mail from@:; l>		!* delete any Mail From lines.!
     q2,.k				!* kill the starting lines.!
     <.,z-q1:fb;^_>		!* Be like ITS mailer and change!
					!* Control-_s to UpArrow form.!
     z-q1j				!* Move to end of message.!
     i				!* Insert ^_ separator.!
     @f
 	k				!* Kill whitespace til next message.!
     >
 .-z"e ,0a-"e j ''		!* if reached end and last character!
					!* is ^_ then all is ok!
 :i*Bad message filefsErr

!& Babyl Set Mode Line:! !S Show msg and file properties.
Msg #, total #, labels, last, filename, whether (RO).!

 !* This mode line routine can go off at strange times, e.g. while inside the!
 !* command name completer, with strange buffers in ..O.  So be careful about!
 !* whether we can run, and if not, ignore the mode line setting: !

 f~(qBuffer Name)*Babyl*"n '	!* Strange buffer...!

 q..o-q:.b(qBuffer Index+4!*BufBuf!)"n '	!* Strange buffer...!

 fsZ"e :i..jBabyl [no file] '	!* Empty, e.g., when Iing to a!
					!* file not yet created.!
 f[InsLen				!* Bind length of last inserted frob.!
 f[SString				!* Bind default search string.!
 [1[2[3[4[5[6[7 m(m.m& Push Message)	!* Restore point, window, etc.!
 qBabyl Filenamesf"ew :i*???'u1	!* 1: Babyl filename!
 qBuffer Filenames"e :i11 (RO)'	!* (RO) if no writeback!
 qNumber Of Babyl Messages:\u2	!* 2: Total number.!
 b"e fsZ-z"e				!* Are bounds open?!
	:i3Babyl (Messages 1-2) 1 	!* 3:  Yes, new modeline.!
	f=..j3"n q3u..j' ''	!* Update modeline iff changed.  So if!
					!* has not, Teco wont redisplay it.!
 qMessage Number:\u3			!* 3: Message # as string.!
 0f[VB -s
lc					!* Back to status line, past refbit.!
 .,(fb,,).-1x4				!* 4: Basic labels.!
 :@x4					!* 4: Basic+user labels.!
 0,fq4-1:g4u4				!* 4: Trim off last comma.!
 0l :fb, deleted,"l !<!:i7>'"# :i7'	!* 7: Maybe greater-than for last.!

 !* New-style last-hacking:  last now means last-undeleted.  A greater-than!
 !* before the last means we are looking at a deleted message after the last!
 !* undeleted one.  This new version is slower -- we do an N.  If there are!
 !* many many deleted messages in a row after this one, it is slow.  Another!
 !* possibility is to do a -J, see what the message # is.  Similar problem if!
 !* mail file ends with lots of deleteds.!

 0u6					!* 6: Flag will say if found a next.!
 1f<!BSML! :i*BSML,1m(m.m# Babyl N)w	!* Forward to any next undeleted.!
	   1u6>w			!* 6: 1 iff is a next undeleted.!
 q6"e :i44, 7last'			!* 4: Include whether this is last!
					!* undeleted message, or after it.!
 :i5Babyl (Message 3/24) 1 	!* 5: New modeline.!
 f=..j5"n q5u..j'			!* Update modeline iff changed.  So if!
					!* has not, Teco wont redisplay it.!
 

!& Babyl Get Message Labels:! !S Return 0 or list of labels for message.!
!* This is also in-line within & Babyl Set Mode Line for speed.!

 .:\[1 fn1j 0f[VB			!* Auto-restoring point.!
 -s
lc					!* Back to status line, past refbit.!
 .,(fb,,).-1x1				!* 1: Basic labels.!
 :@x1					!* 1: Basic+user labels.!
 0,fq1-1:g1u1				!* 1: Trim off last comma.!
 fq1"g q1'				!* Return list if non-null.!
 0					!* Else return 0.!

!& Get Labels for Survey:! !S Status,labels.
In babyl buffer.
Returns 2 values:
First is status character.
Second is null or the curly-braced user label list.!

 0f[VB .[0 fnq0j [1[2
 -s
l

 :fb, deleted,"l Du2'		!* 2: Status character.!
 "# :fb, unseen,"l -u2'		!* ...!
 "# :fb, answered,"l Au2'		!* ...!
 "# :fb, recent,"l +u2'		!* ... (seen and recent)!
 "# :u2''''				!* ... (seen and old).!

 0l fb,, :x1				!* 1: User labels.!
 fq1"g 1,fq1-1:g1u1 :i1{1} '	!* 1: Null or list.!
 q2,q1

!Label Labeled Messages:! !C Add/remove label2 from label1'ed messages.
First string argument is label1, specifying which messages to
    consider.
Second string argument is label2, the label to add or remove from the
    considered messages.
No numeric argument means label all considered messages.
Numeric argument n (positive) means label the next n considered.
Numeric argument -n means unlabel the next n considered.
Numeric argument 0 means unlabel all considered messages.!

 [0[1[2[3[4
 :f"g :i*( :i1 )u0'		!* 0: if STRARG, label.!
					!* 1: if STRARG, the label.!
 "# 0u0 0u1'				!* 0,1: 0s if need to read.!

 m(m.m& Push To Buffer)*Babyl*
 m(m.m& Push Message)			!* Return to current message.!

 ff&1"e				!* No NUMARG, label all.!
    1m(m.m# Babyl J)w			!* To top.!
    qNumber of Babyl Messagesu2	!* 2: # of messages.!
    1u3'				!* 3: 1 means label, -1 unlabel.!
 "# "l -u2 -1u3'			!* 2,3: for -NUMARG.!
    "e 1m(m.m# Babyl J)w		!* To top.!
	 qNumber of Babyl Messagesu2	!* 2,3: for 0 NUMARG.!
	 -1u3'				!* ...!
    "g u2 1u3''			!* 2,3: for +NUMARG.!
 q3"g :i4Add'"# :i4Remove'		!* 4: Prompt part.!

 2,q0m(m.m& Read Babyl Label)Consider messages labeled: f"e'u0
					!* 0: Label.!
 2,q1m(m.m& Read Babyl Label)4 label: f"e'u1	!* 1: Label.!

 m.m& Label Babyl Message[L		!* L: labeler.!

 1,q2m(m.m& Map Over Labeled Messages)1,q3mL10 
					!* The 1, means do not say anything if!
					!* not labeled or already.!

!Delete Labeled Messages:! !C Delete messages with some label.
String argument is label.
See also UnDelete Labeled Messages.
Numeric argument is number of messages (with the label) to delete,
    from the current message forward.
No numeric argument means delete all messages with the label.!

 [k
 m(m.m& Push To Buffer)*Babyl*	!* So works in SvM too.!
 2,(:f"g :i*')(
    )m(m.m& Read Babyl Label)Delete messages labeled: f"e'uk
 0[Babyl N After D			!* Dont do all that extra work.!
 m.m# Babyl D[D			!* D: Deleter.!
 fm(m.m& Label Map Command)kmd 

!UnDelete Labeled Messages:! !C Undelete messages that have some label.
Numeric argument is number of messages (with the label) to undelete,
    from the current messageforward.
No numeric argument means undelete all the labeled messages.!

 [k
 m(m.m& Push To Buffer)*Babyl*	!* So works in SvM too.!
 2,(:f"g :i*')(
    )m(m.m& Read Babyl Label)Undelete messages labeled: f"e'uk
 m.m& Remove Basic Label[U		!* U: unlabeler.!
 fm(m.m& Label Map Command)k mudeletedw 

!Output Labeled Messages:! !C Write messages with some label to a file.
String argument is the label.
This is like going to each of these messages, and using the O command
    to write it to the file, except that it does not read/write for
    each message: it collects all the messages first, then writes the
    file.
It asks whether the given label should be removed.  E.g. the label
    could be temporary, marking those files to output now.
Asks for filename.  Also asks if can mark messages as deleted.  (They
    are deleted only after the file is successfully written.)
Default filename is based on the label, say foo:  for ITS default is
    FOO XMAIL, for TNX it is FOO.XMAIL.  The version is controlled by
    the variable Babyl File Version.  See its description.
The filename may also be specified by a second string argument.
Numeric argument is number of labeled messages to output, from the
    current message forward.
No numeric argument means output such-labeled all messages in mail
    file.
There are two hooks that the user may provide: Babyl O Message Hook,
    which is run on each outgoing message as it is collected, and
    Babyl O Done Hook, which is run on each labeled message in the
    current Babyl file (this hook is run only after the file has been
    written).
qSubDoc"n i
Optional pre-comma numarg has bits to answer questions.'!

 m(m.m& Declare Load-Time Defaults)
    Babyl O Done Hook, If non-0, run when O is done: 0
    Babyl O Filename,: 0
    Babyl O Message Hook,: 0
    Babyl File Version, * 0: read max version, write back to same;
	  1: read and write version 1, similar for other positive N;
	 -1: read max version, write back to next version
	  This only applies to Tenex or Tops-20 systems.: 0


 !* DONT SET ANY QREGS UNTIL WE HAVE PICKED UP STRING ARGS!
 f[DFile [k[1[2[3[4[5
 :f"g :i*( :i*u1 )uk'	!* K, 1: Get string args.!
 "#	:ik :i1'			!* K, 1: Null to force asking user.!
 !* OK TO SET QREGS NOW.!

 m(m.m& Push To Buffer)*Babyl*	!* So works in SvM too.!

 !* Get label and filename from string arg, or if null by asking user: !

 fqk"e					!* If null, ask user.!
    2,m(m.m& Read Babyl Label)Output messages labeled: f"e'uk'
					!* K: label.!

 qBabyl File Versionu5		!* 5: version control.!
 fq1"e					!* If null, ask user.!
  etk XMAIL				!* Default filename by label.!
  fsOSTeco"n				!* Version control only on TNX.!
    q5+1"e 0'"# q5'fsDVersionw		!* Add version.  -1 means 0 for read.!
    q5"e e[fne] 1u2			!* 2: Figure default version, if user!
					!* likes write-over-max.!
      1:<er fsIFVersionu2 ec>w	!* 2: Max version now.!
      q2fsDVersionw''			!* Set to write back to that version.!
    
  q5+1"e 1'(				!* Bit to filename reader saying!
					!* default version of 0 means max+1.!
    )m(m.m& Read Filename)Output Labeled Messages to filef"ew'u1'

					!* 1: Filename.!
 et1					!* Set default carefully.!
 fsOSTeco"n fsDVersion"e		!* User didnt say version, or said 0,!
    q5"e				!* and wants write-over-max.!
	1u2 1:<er fsIFVersionu2 ec>w	!* 2: Max version now.!
	q2fsDVersionw'			!* Set to write back to that version.!
    "# q5"g q5'"# 0'fsDVersionw'''	!* User wants particular version or 0.!

 fsBConsu2				!* 2: Temp buffer for collecting.!
 q2[Babyl O Filename			!* Tell O to use this buffer.!
 e[ e\ @fn|e^ e] q2fsBKill|		!* Push i/o and arrange cleanup.!

 !* Rather than let # Babyl O read and write the file for each message, we!
 !* will do the reading, and let O collect messages in a buffer.!

 q2[..o 1:< er @y >w ]..o		!* 2: Read any file into temp buffer.!

 ff&2"n				!* There are pre-comma numarg bits.!
    &1u3				!* 3: Non-0 if unlabel first.!
    &2u1'				!* 1: Non-0 if delete afterwards.!
 "#					!* No pre-comma numarg bits, so ask.!
    @ftRemove the label k? 	!* ...!
    1m(m.m& Yes or No)u3		!* 3: Non-0 if unlabel first.!
    @ftMark messages as deleted? 	!* ...!
    1m(m.m& Yes Or No)u1'		!* 1: Non-0 if delete afterwards.!

 0[Babyl N After D			!* Since it may delete.!
 m.m# Babyl O[O			!* O: Outputter.!

 !* First mapping pass -- collect the messages: !

 q3"n m.m& Label Babyl Message[L'	!* L: Unlabeller if needed.!

 fsQPPtr(
    0[Babyl O Done Hook		!* We will run the hook, not O.!
    q3"n qBabyl O Message Hookf"ew :i*'u4	!* 4: User hook.!
	 !* Bind hook on outgoing messages, to unlabel along with user hook: !
	 @:i*|-mLkw 4|[Babyl O Message Hook'	!* ...!
    1,(f)m(m.m& Label Map Command)k1,mO	!* Collect messages.!
					!* 1, means dont say done yet.!
    )fsQPUnwindw			!* Pop hook.!

 q2[..o 0,(fsZ)fsBoundw		!* Prepare to write (whole) file.!
    f[DFile et[TECO] OUTPUT fsOSTeco"n 0fsDVersionw'	!* Open to!
      ei				!* safe (TNX) file.!
      f]DFile hpef ]..o		!* Write out the xmail file.  On!
					!* close, it is renamed to right file.!
 fsOFileu4 @ft
Written: 4 ... 

 !* Second mapping pass -- run user hook, maybe delete:!


 qBabyl O Done Hook[H			!* H: User hook, or 0.!
 :i4					!* 4: Will cons up function to map.!
 q1"n m.m# Babyl D[D			!* D: Deleter, if needed.!
      :i4mD'				!* 4: Maybe add deleter.!
 qh"n :i44w mh'			!* 4: Maybe add running user hook.!
 q3"n @:i4|4w 1,-1mLk|'	!* 4: Maybe add unlabeling.!

 fq4"g					!* If have anything to map,!
    1,(f)m(m.m& Label Map Command)k4' !* ...then do second pass.!
 @ftDone.  0fsEchoActivew 

!& Label Map Command:! !S NUMARG control, msg pushing, done.
No NUMARG: iterate over whole mail file, all msgs with label.
NUMARG:  iterate over next NUMARG msgs with label.
1, NUMARG: do not print Done -- is not.
STRARG1: Label name.
STRARG2: Teco to apply to each msg.
Mapper uses 1-dot qregs.!

 [.0[.2 :i*( :i.2		!* .2: Teco commands.!
		)u.0			!* .0: Label.!
 m(m.m& Push Message)			!* return here when done.!
 ff&1"e 1m(m.m# Babyl J)w		!* No NUMARG, start at top.!
	    1,z'"# 1,'(		!* Do all or n messages.!
	      )m(m.m& Map Over Labeled Messages).2.0	!* Map.!
 "e ftDone.
' 

!& Map Over Labeled Messages:! !S Maps over labeled messages.
NUMARG1 is direction: 1 forward, -1 backward.
NUMARG2 is number of messages (in set) to apply to.
STRARG1 is teco commands.
STRARG2 is label.!
!* Selects before apply.!
!* This function will not use qregs 0 - 9, or the letter qregs, so the caller!
!* can pass information in them to the mapping function.!
!* Both apply the function to the current message if labeled.!
!* BUT IS THAT AT ALL THE RIGHT THING TO DO?????!

 [.0[.1[.2[.3[.4[.5[.6
 :i*(				!* .1: Teco commands.!
    :i.0 )u.1			!* .0: Label name.!
 m.m& Babyl Select Messageu.2		!* .2: Message selector.!
 "g -'1+qMessage Numberu.3		!* .3: Current message# +/- 1.!
 @fn| q.3umessage number |		!* when done, reset message#.!
 0fsVBw 0fsVZw			!* Wide bounds.!

 "g -s'				!* Start at top/bottom of this!
 "#   s r'				!* message so include it if in set.!
 .u.5					!* .5: Starting point: /\^_^L.!
 0s, .0,				!* Set search default for label.  We!
					!* want an efficient loop looking for!
					!* a message with the label on it.  So!
					!* dont keep remaking search default.!
 "g @:i.4|:@fl :cw .-z|		!* .4: Macro to move to next message,!
					!* and return value for ; in iter.!
					!* Leaves point:  ^_/\^L ...!
      @:i.6|%.3w|'			!* .6: Macro to bump/dec msg #, .3!
 "#   @:i.4|r-:@fl b-.|		!* ...!
      @:i.6|q.3-1u.3|'			!* ...!

 < 0,fsZfsBoundw			!* Wide bounds.!
     q.5j m.4;				!* Forward/backward to next message.!
     .u.5				!* .5: ^_/\^L ...!
     1a-"n !<!@>'			!* Oops, not a message starter.!
     m.6				!* .3: Inc/dec message number.!
     l :fb"e !<!@>'			!* Check status line for the label.!
					!* Repeat if not there.!

     !* End of the efficient inner loop.  Now we have found a message with the!
     !* label, and have the message# in Q.3.!

     q.3uMessage Number		!* Reset official message# variable.!
     m.2				!* Select this message.!
     m.1				!* Apply function to this message.!

     0s, .0, 0fsVZw		!* Reset search default for next!
					!* efficient inner loop, widen bounds!
     >					!* below, and go.!

 

!& Label Babyl Message:! !S (Un)Label current message with string argument.
-1 means unlabel.
1, means do not warn "already labeled foo" etc.!
!* Knows about basic labels (deleted, unseen, recent).!

!* Unlabeling makes no distinction between user and basic labels, and the!
!* & Remove Basic Label can be used instead if the redisplay and user-message!
!* features of this command are not desired.!

!* Keeps fsVB using Z-it.  (un)Labelling may look weird if bounds are wide!
!* and status line is visible.  Tough.  But if we do want to put the f back!
!* in, we will have to f[Window since f will reset it using different!
!* bounds.!
!* We add our message number to the list of messages needing resurveying.!

 m(m.m& Declare Load-Time Defaults)
    Babyl Modified Messages,: ||


 [0[1[2[3  :i0			!* 0: Label.!
 z-.:\u1				!* 1: point to restore.!
 z-(fsVB):\u3				!* 3: fsVB to restore.!
 @fn| z-1:j"e j'			!* Will restore point,!
      z-3fsVBw |			!* and bounds.!

 0fsVBw				!* Wide bounds above.!
 -s
				    !* Find start of message.  Should this!
				    !* be a conditional???!
 l				    !* Down to status line.!

 "l					!* Negative argument means unlabel.!
    :fb, 0,"e "n '		!* Not there.  Done if no complaint.!
	@ft
Not labeled 0 to begin with 0fsEchoActivew '	    !* Warn, done.!
    fk+1d'				!* Remove the label.  Note one of the!
					!* commas stays.!

 "#					!* Argument says label.!
    :fb, 0,"l "n '		!* There already.  Done if not to!
					!* complain.!
    @ft
Already labeled 0 0fsEchoActivew '	!* Warn, done.!
    :l					!* User labels after ,,.!
    f~0deleted"e 0l2c'			!* Basic labels before ,,.!
    "# f~0unseen"e 0l2c'		!* ...!
    "# f~0recent"e 0l2c'		!* ...!
    "# f~0answered"e 0l2c''''		!* ...!
    i 0,'				!* Label it.!

 qMessage Number:\u0			!* 0: message# as string.!
 qBabyl Modified Messagesu2		!* 2: old list/macro.!
 :iBabyl Modified Messages20m0
					!* Add in our part.!

 

!& Add Basic Label:! !S Label message with string argument, a basic label.
Returns 0 if not previously labeled, non0 if was.!
!* More efficient than using & Label Babyl Message.!
!* We add our message number to the list of messages needing resurveying.!

 m(m.m& Declare Load-Time Defaults)
    Babyl Modified Messages,: ||


 [0[1[2  :i0			!* 0: Label.!
 z-.:\u1 z-(fsVB):\u2			!* 1,2: point,fsVB to restore.!
 @fn| z-1:j"e j'			!* Will restore point,!
      z-2fsVBw |			!* and bounds.!

 0fsVBw				!* Wide bounds above.!
 -s
l					!* To status line.!
 :fb, 0,"l -1'			!* Already labeled that.!
 0l2c					!* Basic labels before the ,,.!
 i 0,				!* Label it.!
 qMessage Number:\u0			!* 0: message# as string.!
 :fo..qBabyl Modified Messagesu1	!* 1: index of old list/macro.!
 q:..q(%1)u2				!* 2: old list/macro.!
 :i:..q(q1)20m0
					!* Add in our part.!
 0

!& Remove Basic Label:! !S Unlabel message with string argument, label.
Returns 0 if not previously labeled, non0 if was.!
!* More efficient than using & Label Babyl Message.  Will work on user labels!
!* too, but wont give any messages or care for redisplay.!
!* We add our message number to the list of messages needing resurveying.!

 m(m.m& Declare Load-Time Defaults)
    Babyl Modified Messages,: ||

 [0[1[2  :i0			!* 0: Label.!
 z-.:\u1 z-(fsVB):\u2			!* 1,2: point,fsVB to restore.!
 @fn| z-1:j"e j'			!* Will restore point,!
      z-2fsVBw |			!* and bounds.!

 0fsVBw				!* Wide bounds above.!
 -s
l					!* To status line.!
 :fb, 0,"e 0'			!* Return, was not labeled.!
 fk+1d					!* Remove the label.!
 qMessage Number:\u0			!* 0: message# as string.!
 :fo..qBabyl Modified Messagesu1	!* 1: index of old list/macro.!
 q:..q(%1)u2				!* 2: old list/macro.!
 :i:..q(q1)20m0
					!* Add in our part.!
 -1

!& Check Message Label:! !S See if labeled with string argument.
Returns non0 iff labeled that.!
!* Perhaps generally in-line code.!

 :i*[0 .[1 fnq1j 0f[VB -s
l					!* Back to status line.!
 :fb, 0,"'l			!* Return whether labeled.!

!& Reformed Bit:! !S Check or reset reformed bit.  Returns old value (0/-1).
NUMARG is new value (0/non0).
If no NUMARG, doesnt change it -- just returns it.!
!* Creates dummy message if empty file.!

 0f[VB .[1 fnq1j -:s
"l l 1a-1"'e(				!* Pick up old value.!
	ff&1"n "n f1'"# f0''	!* Reset it if have NUMARG.!
	)'					!* Return old value.!
 m(m.m& Make Dummy Message)		!* Empty file -- put in a message.!
 f:m(m.m& Reformed Bit)		!* Now try again with dummy.!

!& Make Dummy Message:! !S Make empty file have a (deleted) message.!
 !* Assuming we must have at least Babyl Options section. (?)!
 !* Best to have some header -- & Bounds Of Header, e.g., wants some visible!
 !* header there -- so H, 1H, etc. commands dont bomb.  (Better if they didnt!
 !* anyway...?)!
 0,fsZfsBoundw			!* Wide bounds.!
 j :s"e :i*Babyl bug: no Babyl Options section?fsErr'
 i
0, deleted,,
*** EOOH ***
From: Babyl

Babyl file  gBabyl Filenames i
is empty except for this dummy message.

 1uNumber of Babyl Messages		!* Now there is one message.!
 

!Remind Me Of This Message:! !C (Un)Labels RemindNow.
Negative argument means remove the reminder label from this message.!

!* Note that the user will be asked to verify the RemindNow label!
!* not yet been in the list.  This will happen if the user has his own!
!* labels list (Babyl option) and it doesnt include RemindNow.  If the user!
!* has no list, it will be around by default in the qvector.!

 ff"n '"# 1' m(m.mLabel Message)RemindNow
 

!Next Labeled Message:! !C Move to next/previous message with some label.
| or 2| moves forward, -| or -2| moves backward.
No numeric arg, e.g. |, or -1 arg, e.g. -|, means use the last label
    again.  (If you explicitly give a string argument , though, it
    will be used.) The label defaults initially to RemindNow, for
    reminders.
With a numeric argument of -2, 1, or 2, will read the label to use.!

 m(m.m& Declare Load-Time Defaults)
    Babyl Last | Label,: |RemindNow|

 [k[0[1

 :f"g :ik'"# 0uk'		!* K: 0 or string argument.!
 fqk:"g					!* No or null string argument.!
    +1"e oREUSE'			!* -1| does not read label.!
    ff&1"e !REUSE! qBabyl Last | Labeluk'	!* No NUMARG, so use last one.!
    "# "l :i1Previous'"# :i1Next'	!* 1: Part of prompt.!
       2,m(m.m& Read Babyl Label)1 message labeled: f"e'uk''
					!* K: label.!
 qkuBabyl Last | Label		!* Save this label.!

 qMessage Numberu0			!* Remember where to come back to...!
 "l @m(m.m# Babyl ^P)'		!* Start at previous message, or!
 "#   @m(m.m# Babyl ^N)'		!* ... at next message, since mapper!
					!* will find the current message if!
					!* labeled.!
 "l -'1,1 m(m.m& Map Over Labeled Messages)wk	!* Nothing to map,!
					!* really, just using map as a!
					!* search.!
 m(m.m& Babyl Select Message)		!* ...!
 m(m.m& Check Message Label)k"e	!* Lose, lose.!
    q0m(m.m# Babyl J)			!* Reselect original message.!
    @ft(No more k) 0fsEchoActivew'	!* Tell user.!
 

!& AutoLabel Subject Labels:! !S Subject begins with excl or {...}.!
!*  We iterate the following until it fails:
    If subject line begins with an exclamation mark, it is a reminder.
      We label it with a RemindNow label.
    If subject line begins with {, then we have an arbitrary label up to the
      following }.
When header reformation occurs, the {...}s and/or excls are removed from
    the subject line in the reformed header, since we set Babyl Remove
    Suject Labels.  We shouldnt do it now, since
    we dont really parse and therefore might be wrong.

******** It doesn't now but should *******

This is designed to be quick, so may catch things that aren't really:
    It looks for "<CRLF>Subject:<white>", thus not having to parse.
    In particular it will NOT find ITS header subject lines (Re:).
	For the moment trying searching for <sp>Re:<sp> too....!

 0[0 [1 .[2 fnq2j			!* 2: auto-restoring point.!
 0f[VB 0f[VZ				!* Wide bounds, restored later.  Any!
					!* autolabeling wont change them, it!
					!* turns out ... hack hack... !
 !* It is critical that point and the bounds be reset exactly, so that the!
 !* Babyl file that # Babyl G writes out (appends perhaps) will have a good!
 !* format.  It will append whatever the virtual buffer is.  Thus dont leave!
 !* any message selected -- the virtual buffer should be the entire,!
 !* Babylized, new mail.  It starts with ^L and ends with ^_.!

				    !* 0: 0 iff no labels found.!
 m.m& Label Babyl Message[L	    !* L: Labeler.!
 <  :s
Subject: Re: ;		    !* Next subject maybe.!
    <				    !* Iterate over all labels.!
      @f	 l		    !* Forward past whitespace.!
      0,1a-!"n 0,1a-{"n 1;''    !* Neither reminder nor { label.!
      0,1a-!"e .-z(1,mLRemindNow)+z+1j   !* A reminder -- label it.!
		 1u0'		    !* 0: say we found one.!
      0,1a-{"e .+1,(:fb};).-1x1    !* 1: Get label.!
	       .-z(1,mL1)+zj   !* Label with that.!
	       1u0'		    !* 0: Say we found one.!
      > >
q0"n 1m.vBabyl Remove Subject Labelsw'	    !* Tell header reformer to!
				    !* trim labels it finds in subject line.!


!& Make Babyl Label Table:! !S numeric argument is string.
Returns abbrev-only-string,qvector.!
!* 
String has form "label,label,...label".  For now, it ignores whitespace
    following commas -- though maybe that should be removed to make it faster?
A label can also have the form "la=label", which means that "la" is to be
    a label-abbrev for "label".
The "=" and "," characters are illegal in a label.
The pre-comma value returned is a labels-string, but only containing the
    abbrevs.  This is for unlabeling -- they get merged with whatever the
    message labels are.!

!* A label-abbrev clause causes 3 entries to be put in the qvector:  the!
!* full label, its abbrev, and the "la=label" clause itself.  The full!
!* clause is there so that "?" to the completing reader shows it.  The abbrev!
!* (only) is there so that the completing reader will allow "la<cr>" to be!
!* typed to return the label-abbrev without ambiguity.!

!* A label-abbrev clause also causes 2 variables to be created: !
!* Babyl la Labelab and Babyl la=label Labelab, both with the label as a!
!* string value.  The first is the primary abbrev mechanism.  The second (the!
!* full clause) is there just in case the user types the full clause to the!
!* completing reader -- since it is possible we ought to handle it.  By making!
!* it be an "abbrev" too we will strip it down to just the label part!
!* without any special handling.!

 [1[2[3[4[5[V
 :i5					!* 5: Will collect abbrevs-only spec.!
 5fsQVectoru1 1u:1(0)			!* 1: The qvector, initialized to just!
					!* the entry length.!
 f[BBind g()				!* Temporary buffer with the list!
					!* string.!
 @:iV|					!* V: internal routine to add a name!
					!* to the qvector.  It uses Q1 (the!
					!* qvector), Q..O (also the qvector).!
					!* Its NUMARG is the name to add.!
      [2[3
      @:fo12u3			!* 3: Index into table for this next!
					!* name.!
      q3"l -q3*5j q:1(0)*5,0i		!* Needs to be added -- make space in!
					!* table.!
	   q2u:1(-q3)'			!* Put the name into that new slot.!
      |				!* End of V.!

 i, j					!* Put comma at end for easy parsing.!
 0u4					!* 4: 0 means no label-abbrev.!
 < @f	 l .-z;			!* Move past leading whitespace before!
					!* name.!
   .u2					!* 2: Point before label.!
   @:f,=l				!* To end of label or label-abbrev.!
   .(-@f	 l q2,.x2)j c		!* 2: This label or label-abbrev.!
   fq2"e !<!>'				!* Ignore it if a null label.!
   0a-="e q2u4 !<!>'			!* 4: If that was a label-abbrev,!
					!* keep it and go back to get the!
					!* label.!

   !* 2: This label.!
   !* 4: 0 or the label-abbrev for this label.!
   !* Note that mV below smashes Q3.!

   q1[..o				!* Select the table as the current!
					!* buffer for editing. MV needs this.!
      q2mV				!* Add the label to the qvector.!
      q4"n  q4mV			!* If a label-abbrev, add it too.!
	    :i34 = 2		!* 3: Full clause in canonical form.!
	    fq5"e q3'"# :i*5,3'u5	!* 5: Collect abbrevs spec.!
	    q3mV			!* Add the la=label clause too.!
	    q2m.vBabyl 4 Labelabw	!* Define the label-abbrev!
	    q2m.vBabyl 3 Labelabw'	!* translation.!
      ]..o				!* Back to buffer with list string.!
   0u4 >				!* 4: no label-abbrev now.!

 q5,q1				!* Return the abbrevs-spec and the new!
					!* symbol table.!

!& Use Babyl Label Table:! !S Prepare for calling & Read Command Name.
Binds CRL List and CRL Prefix for reading labels.
Ensures that Babyl Labels Option is a qvector, maybe converting.!

!* Note that there are some semi-standard labels, like reply,!
!* that used to be pre-defined.  However that forces those hooks on people who!
!* dont use them so we wont do that if the user has a labels list option.!
!* But if you use the hooks those labels will be added to the valid list.!
!* Note that there are also standard labels that are necessary for correct!
!* Babyl operation -- like deleted or unseen -- and these WILL be pre-defined.!

 m(m.m& Declare Load-Time Defaults)
    Babyl Labels Option,: ||
    CRL List,: 0
    CRL Prefix,: 0
    Babyl Label Abbrevs Spec,: 0


 [1[2					!* VERY CAREFUL about pushes.!
 qBabyl Labels Optionu1		!* 1: label list.!
 fq1"l					!* User doesnt have a list.!
    :i1RemindNow,filed,reply'		!* 1: So make it the default.!
 q1fp-1"n				!* Not a qvector, must convert.!
    :i11,deleted,unseen,recent,answered,bad-header	!* 1: Add standard!
					!* labels.!
    q1m(m.m& Make Babyl Label Table)u1u2	!* 1: Now it is a qvector.!
					!* 2: Abbrevs-only spec.!
    q2uBabyl Label Abbrevs Spec	!* Save it for unlabeling.!
    q1uBabyl Labels Option'		!* Save the qvector for next time.!
 !* MUST POP WHAT PUSHED SO LEAVE ONLY THE CRL VARIABLES PUSHED: !
 q1(]2]1)[CRL List			!* Leave CRL arguments bound for!
 :i*[CRL Prefix			!* caller.!
 :					!* Exit without popping.!

!& Read Babyl Label:! !S Read, process, and return label with completion.
String argument is prompt.
Returns 0 if aborted, else full label.  Label-abbrevs recognized and the
    full label returned.
NUMARG if any is label to use, else completing-read.
1, bit means do not confirm a label not in list.
2, bit means allow non-matches, i.e. new labels.!
!*  Here is the way the caller can call us:
      (:f"g :i*')m(m.m& Read Babyl Label)f"e'u...
    :f returns positive if called by M. (Versus @M or from ^R mode.)!

 m(m.m& Declare Load-Time Defaults)
    CRL Non-match Method,:2


 :i*[0 [1 :i*[2			!* 0: prompt string.!
					!* 1: Possible label already.!
					!* 2: Initial string for completer, null.!
 0f[ModeMacro				!* Dont let any modeline hackery!
					!* happen when waiting for user input!
					!* -- bounds are wide and wed lose the!
					!* message number etc.etc...!

 m(m.m& Use Babyl Label Table)		!* Bind arguments for the completing!
					!* reader to use label list.  This!
					!* must be done even if we already!
					!* have the label since it will be!
					!* validated.  Or should the other!
					!* routine do it (too)...!

 fq1:"g					!* If no or null label, read it.!
    !* The 16+ below is the bit telling the completer to allow non-matches,!
    !* i.e. new labels.  With CRL Non-match Method bound to 4, this means that!
    !* Return will force completion first, but Linefeed returns exactly what!
    !* has been typed, match or new.  For unlabeling, dont allow non-matches,!
    !* since makes no sense, and here is where CR-completion is especially!
    !* handy.  One letter usually suffices.  And note that we now have label!
    !* abbrevs work in unlabelling too.!

    !READ!				!* Comes back here if user does not!
					!* confirm a new label.!
    &2"n 4[CRL Non-match Method	!* CR completes, LF returns new.!
	   16+'2,q2m(m.m& Read Command Name)0f"ew	!* If aborted, clear!
	!ABORT!				!* ...!
	:i*CfsEchoDisplayw 0'u1'	!* echo area and return 0.!
					!* 1: label read.!
 fq1"e oABORT'				!* Treat null label like abort --!
 !* makes typing Return like Rubout, when at beginning of line.!

 !* Ensure that label is in list of valid ones, possibly getting a!
 !* confirmation if new.  If user does not confirm, back to completer.!
 &1"e 1',q1m(m.m& Add to Labels Option)"e q1u2 oREAD'w  !* 2: Reread!
					!* label, starting with what was!
					!* already typed.  Good for <alt><cr>!

 0fo..qBabyl 1 Labelabf"nu1'w	!* 1: Full label if we were given!
					!* just a label-abbrev.!

 q1					!* Return full, confirmed label.!

!& Add to Labels Option:! !S Ensure label is in valid list.
NUMARG is label to check.
1, means confirm new labels.
Returns 0 iff the user did not confirm a new label.!

!*  This may discard the qvector of label names, so caller should not use a
    previously bound one.  If needed, it should call & Use Babyl Label Table
    again.!

 m(m.m& Declare Load-Time Defaults)
    Babyl Labels Option,: ||


 [0					!* 0: label.!
 @:foBabyl Labels Option0"g 1'	!* Label is in list, so!
						!* return 1 for ok.!

 !* Label is not in list.!

 "n					!* We need to confirm.!
    @ft
Add 0 to label list?  1m(m.m& Yes or No)f"e'w'
					!* If user did not confirm it, return!
					!* (that) 0 to say unconfirmed.!

 !* Ok to add label to list in the BABYL OPTIONS section.  Note that since!
 !* there may not yet be a labels option there we might have to make one.!

 !* Hmmmm....... damn..... where the hell IS the Babyl file???  We probably!
 !* cannot assume that it is in the current buffer.  But we will for now....!

 z-.[1 z-(fsVB)[2 @fn|1:<z-q1j		!* Autorestore point and!
			  z-q2fsVB>w|	!* bounds.!
 0fsVBw				!* Widen bounds above.!
 j :f f~BABYL OPTIONS:"n :i*There is no BABYL OPTIONS sectionfsErr'
 :s
Labels:+2"n				!* No labels option yet.!
    jl iLabels: RemindNow,filed,reply,
					!* Start with the semi-standards.!
    0:l'				!* Point is now at 1st label place.!
 .( g0					!* Insert the label.!
    @f	 k			!* Kill following whitespace just to!
					!* be compact and make our end of line!
					!* check easier.!
    13,1a-13"n i,'			!* Separate by comma if more labels!
					!* follow this one.!
    )j					!* Back to start of option string.!
 qBabyl Labels OptionfsBKillw	!* Garbage collect old qvector.  This!
					!* will also ensure that our caller!
					!* isnt using the qvector after we!
					!* have discarded it.!
 :xBabyl Labels Option		!* Reset to the string list version so!
					!* the next use will compile it into a!
					!* qvector.!
 m(m.m& Use Babyl Label Table)		!* Fake-use it, to force it to compile!
					!* now.  Good, e.g., for label reader,!
					!* so it can then translate.!

 1					!* Return OK now that label is added!
					!* and confirmed.!

!Edit Labels List:! !C Edit the list of valid labels for this Babyl file.
Goes into recursive editing level on the current label list, or
    allows you to create a new list.  Only uses a few lines of the
    screen.  A line of --------- ends this window.
The list has the format: label1,label2,...,labelN
You can define "bl" to be a label-abbrev for "BabylLabel" by using
    in place of the label the string "bl=BabylLabel".
The actual list in the option field will be one line only but while
    editing you can use multiple lines -- this command cleans it all
    up when you exit via ^R Exit.  If you do use several lines, be
    sure to include commas at the end of each line since only commas
    separate labels -- the end of the line is completely ignored.
Aborting via Abort Recursive Edit will leave the list unchanged,
    even if you have done some editing.  (You are editing a copy.)
An example label list might be: b=bug,i=info,babyl,f=feature!

 [1[2
 m(m.m& Push To Buffer)*Babyl*	!* So works in SvM too.!
 0f[VZ					!* Widen bounds.!
 z-.:\u1 z-(fsVB):\u2 0fsVBw		!* ...!
 @fn|0fsVBw 0fsVZw z-1j z-2fsVBw|	!* Restore point and bounds.!
 0f[ModeMacro				!* No sense running anything tricky.!

 j :f f~BABYL OPTIONS:"n :i*There is no BABYL OPTIONS sectionfsErr'


 j :s
Labels:+2"e				!* Has a list already.!
    :x2'				!* 2: Get the string list.!
 "# :i2'''				!* 2: No list yet.!

 fsQPPtr(
  f[BBind g2				!* Temp buffer with list.!
 
  !* Use only as much of the screen as need, leaving room for 50 more!
  !* characters to be added.!

  :ft z+1+50/(fsWidth+1)+1f(<ft
   > ft--------			!* Type the --- line at the end.!
    )f[Linesw  0u..h			!* And narrow redisplay window.!

  @:i*|	0fsLinesw m(m.mDescribe)Edit Labels List 
	|f[HelpMacro			!* Bind the HELP key.!
  :i*Edit Labels List[..j		!* Recursive edit mode line.!
  0[Auto Fill Mode			!* Dont break lines at spaces!
  					!* Let user edit the list.!
  !* Replace CRLFs with commas, so becomes 1-line and CRLFs act like!
  !* separators, and clean up multiple commas: !
  j <:s
;     ,>				!* CRLFs to commas.!
  j <:s,,; -d r>			!* ,, to just ,.!
  zj -@f	 ,k			!* Kill trailing junk.!
  hx2					!* 2: New list.!
  )fsQPUnwindw				!* Back to Babyl buffer.!

 j:s
Labels:+2"e 0L k'			!* Flush old labels option!
 "# jl'					!* unless does not have one yet.!

 fq2"g iLabels:2
'					!* Add new labels list if non-null!

 q2uBabyl Labels Option		!* Reset option to new list.  It will!
					!* be recompiled some time when used.!
 

!Label Messages Containing String:! !C Label search-selected messages.
1st string argument is a string.  Messages containing that string will
    be labeled.
2nd string argument is the label to add.
Given a numeric argument, it goes through the entire Babyl file,
    rather than just forward from the current message.
Each message containing the given string is labeled with the given
    label.
Note that the string is actually a Teco search string, so for
    instance, if you want to label messages containing "foo" OR "bar",
    you can provide the string "foobar".!

 [0[1
 m(m.m& Push To Buffer)*Babyl*	!* So works in SvM too.!
 :f"g :i*( :i1 )u0'		!* 0,1: STRARGs if M-called.!
 "# 1,fLabel messages containing string: f"e'u0	!* 0: read string if!
							!* @M-called.!
    0u1'				!* Must read label if @M-called.!
 fq0:"g 1,m(m.m& Read Line)For messages containing string: f"e'u0'
					!* If STRARG was null, read string.!
 2,q1m(m.m& Read Babyl Label)Attach label: f"e'u1	!* 1: label.!

 m(m.m& Push Message)			!* Return to this message.!
 m.m# Babyl ^F[F			!* F: finder of strings.!
 m.m& Label Babyl Message[L		!* L: labeler of messages.!
 ff&1"n 1m(m.m# Babyl J)w'		!* If NUMARG, to top.!
 
 j 0fsVBw -l				!* Hmmm... back up so F may find 1st!
					!* message if it contains string.!
 
 <  q0,1mF;				!* Find next message with string.!
    1,mL1w				!* Label it. 1, means no!
					!* message printed if already labeled.!
    zj >				!* To end of this message, then on to!
					!* next one with string.!
 ftDone.

 

!* The following functions implement Survey Menu.  This was formerly a!
!* separate source file.!

!Survey Menu:! !C Edit Babyl file from a survey.
The last survey created is used, e.g. from a B command, or if none,
    you are asked what kind of survey to first perform.
Babyl commands which are not control characters work as usual (plus
    Control-D and Rubout), except that Space exits Survey Menu, just
    like ^R Exit.
Control characters may be executed as Babyl commands by quoting them
    with ^R Quoted Insert.
When the recursive edit level is exited we will go back to Babyl
    buffer, selecting the current survey line's message.
The option variable Babyl Two Window Survey Menu, if non-0, says that
    the survey should use one window, messages another.  Back to one
    window when exit Survey Menu.
The user can tailor Survey Menu by providing a Survey Mode Hook
    variable, or by providing a Babyl Command Hook.!

 m(m.m& Declare Load-Time Defaults)
    Window 1 Buffer,:0
    Window 1 Pointer,:0
    Window 2 Buffer,:0
    Window 2 Pointer,:0
    Babyl Two Window Survey Menu,
	* If non-0, Survey Menu will use two windows.: 0
    Babyl Command Hook,
    0 or Teco program to run at times in command execution.
	Its arg tells situation:
	  In normal Babyl com loop (Q0 has com char, Q5 has arg string):
		1 before display, 2 after,
		3 before com, 4 after.
	  In survey menu (Q..0 has com char):
		5 before com, 6 after.
	  7 when entering SvM level (so you can bind things).: 0


 ff-1"e				!* One argument, n.!
    2,m(m.m& Babyl Survey Several Messages)'	!* Survey next n messages.!
 "# ff-3"e				!* Two arguments, m,n.!
    m(m.m# Babyl J)			!* Jump to message m.!
    2,(-+1)m(m.m& Babyl Survey Several Messages)''	!* Survey range m,n.!

 q*Survey* Bufferf"n[1 fq1'"e	    !* No survey yet.!
    @m(m.m# Babyl ^S)w		    !* Let user pick one.!
    !* This is a bit crockish, as it will type the survey as it goes (with!
    !* --MORE-- hacking) before entering -mode.  Maybe should give ^S a 1,!
    !* argument to pass along???!
    q*Survey* Bufferf"n[1 fq1'"e  ''	!* User quit out; merely exit.!

 @fn| m(m.mSelect Buffer)*Babyl*| !* Select *Babyl* when done.!
 q:.b( :i**Babyl* m(m.m& Find Buffer)+4 )m.vSvMenu Babyl Bufferw
				    !* Keep Teco buffer pointer around for!
				    !* easy switching in commands.!
 m(m.mSelect Buffer)*Survey*	    !* Switch to survey buffer.!
 q..o m.vSvMenu Bufferw	    !* Save it too.!
 f~ModeSurvey"e		    !* Already in Survey mode.!
    m(m.m& Get Library Pointer)BABYL-(0fo..qBabyl Library Pointer)"n
       m(m.mSurvey Mode)'	    !* But not at same place so have to rebind!
				    !* keys so they have good pointers.!
    qBABYL Loaded-qPrevious BABYL Loaded"N	!* At same place, but version!
       m(m.mSurvey Mode)''			!* ..changed.!
 "# m(m.mSurvey Mode)'		    !* If not already in Survey mode, go in.!

 !* Bind some window variables, in case survey menu commands play with them,!
 !* e.g.  changing what the original buffer was in other window.  User!
 !* shouldnt be left with *Babyl*, say, selected in other window.  Must be!
 !* careful since these dont necessarily exist -- thus the declaration above.!

 !* What if the user ends survey menu with two windows?  Then we might restore!
 !* 0 for some of these variables...  Shouldnt bind them if 0 originally?!
 !* What if user ends with *Babyl* showing?  Then later switches to that!
 !* window and finds -- what?  another buffer?!

 0fo..qWindow 1 Buffer"n		!* If this is defined, all these are.!
    [Window 1 Buffer [Window 1 Pointer	!* ...!
    [Window 2 Buffer [Window 2 Pointer'	!* ...!

 qBabyl Two Window Survey Menu"n	!* User wants 2-window SvM.!
    0fo..qWindow 2 Size"e		!* Not in 2window mode now.!
      4m(m.m^R Two Windows)w		!* So into it now, in bottom w.!
      @fn~1:<@m(m.m^R One Window)>w	!* Back to 1w when out of svmenu.!
	  0fsErrorw~''			!* 0 this so C-] exits wont print the!
					!* error message (tho they dont go in!
					!* to the error handler in any case).!

 qBabyl Command Hookf"n[1 7m(q1(]1))'w	!* Let user bind things.  Pop!
						!* q1 BEFORE user binds.!

 :i*Babyl [Editor Name	    !* Force recompute of mode line.!
 :i*Babyl [..j			    !* ...!
 1fsModeChangew		    !* ...!

 m(m.m& Jump To Current Survey Line)	    !* Put point on line with!
				    !* current message survey on it.!
 				    !* Let user go.!
 [..o m(m.m& Survey-Select Message)	    !* make sure we end up in right!
				    !* message in Babyl buffer.!
 				    !* Back to Babyl buffer.!

!Survey Mode:! !S Execute Babyl commands from survey menu.
Most Babyl commands function as usual, applying to the message
    indicated by the cursor.  Space will exit recursive edit,
    selecting the message which had the cursor at its survey.
User can tailor by providing a Survey Mode Hook variable.!
!* 
To protect against garbage key-binding pointers if Babyl is temporarily loaded
once and then again in a different place, we will save the pointer to the
Babyl library in a variable.  Survey Menu will look at that and use it to see
if it needs to redo the Survey Mode.  Likewise with the (IVORY generated)
variable BABYL Loaded, which gives the Babyl version (sort of).
!

 [1				    !* Scratch register.!

 qBABYL Loadedm.vPrevious BABYL Loadedw
 m(m.m& Get Library Pointer)BABYLm.vBabyl Library Pointerw
				    !* That may not actually be right -- BABYL!
				    !* might by prefix-matching find the!
				    !* BABYLM library... Maybe have to do a &!
				    !* Get Containing Library kind of thing?!
 m(m.m& Init Buffer Locals)	    !* .Q: Make Local Q-register!
 1,(m.m& SvMenu ^RNormal Macro)m.QFS^RNormal	!* Self-inserting keys get run!
						!* ..as Babyl commands.!

 !* Now bind some keys local to this buffer.!
 m.m^R SvMenu Argumentu1	    !* Use this a lot...!
 1,q1m.q-			    !* Hyphen always autoargs.!
 1,q1m.q0			    !* So do the digits.!
 1,q1m.q1			    !* ...!
 1,q1m.q2			    !* ...!
 1,q1m.q3			    !* ...!
 1,q1m.q4			    !* ...!
 1,q1m.q5			    !* ...!
 1,q1m.q6			    !* ...!
 1,q1m.q7			    !* ...!
 1,q1m.q8			    !* ...!
 1,q1m.q9			    !* ...!
 1,q1m.q,			    !* Comma!
 1,q1m.q+			    !* Plus!
 1,q1m.q*			    !* Times!
 1,q1m.q/			    !* Divides!

 Afs^RInitu1			    !* 1: Builtin TECO self-inserter.!
 1,q1m.q.D			    !* C-D indirects through Babyl.!
 1,q1m.q			    !* Ditto for Rubout.!

 1,(33.fs^RInit)m.q 	    !* Space exits.!
 1,(m.m^R Survey Menu T)m.qT    !* T is special.!

 1m(m.m& Set Mode Line)Survey	    !* Tidy up and get going...!
 

!^R Survey Menu T:! !^R Type message text for current survey line.
Remove "unseen" label, if one.
If in 2-window mode, will display message in opposite window.
nT means type only n lines of text, no header (for 2-window mode the
    n is ignored -- any argument means just display text).
-nT will show just header lines.!

 m(m.m& Declare Load-Time Defaults)
    Babyl Command Hook,
    0 or Teco program to run at times in command execution.
	Its arg tells situation:
	  In normal Babyl com loop (Q0 has com char, Q5 has arg string):
		1 before display, 2 after,
		3 before com, 4 after.
	  In survey menu (Q..0 has com char):
		5 before com, 6 after.
	  7 when entering SvM level (so you can bind things).: 0


 !* We handle command hook just as if T were handled by fs^RNormal dispatcher.!

 qBabyl Command Hook[0[1 fsQPPtr[2	!* 0: User hook.!
					!* 2: Unwind point to reselect.!
 0f[ModeMacro f[ModeChange		!* Inhibit modeline display when do!
					!* our @V in other window, and inhibit!
					!* the returning Select Buffer from!
					!* causing final redisplay to display!
					!* mode line in this window.!
 q..0fsEchoOutw 0fsEchoActivew	!* Echo character as if we were going!
					!* through general svm dispatch.!
 m(m.m& Survey-Select Message)w 	!* Make sure message selected.!
 m(m.m& Reformed Bit)"e qBabyl No Reformation Option"e	!* Reform?!
    m(m.m& Reform Header)''		!* Yes.!
 q0"n 5m0'				!* Pre-SvMenu-command hook.!

 ff&1"n m(m.m& Bounds Of Header)jw'	!* Jump past header if nT.!

 0fo..qWindow 2 Size"n			!* Now in 2-window mode.!
    m.m^R Other Windowu1		!* 1: Switches windows.!
    .(					!* Be sure to keep same point.!
      @m1w @fn|@m1w|			!* To other window,!
      m(m.mSelect Buffer)*Babyl*w	!* selecting Babyl buffer there.!
      )j				!* Same point.!
	!* Selecting *Babyl* is good for scrolling other window, for example.!
	!* Exiting Survey Menu will restore old Window variables.!
    .-bfsWindoww			!* Put current line at top, e.g. maybe!
					!* 1st text line.!
    0u..h @v				!* Redisplay Babyl window.!
    q0"n 6m0'				!* Post-SvMenu-command hook.!
    m(m.m& Remove Basic Label)unseen	!* Message has now been seen.!

    q2fsQPUnwindw			!* Back to svmenu buffer, window.!
    0'				!* End of 2-window hacking.!

 ff"e .,zx1'			!* 1: No NUMARG:  All.!
 "# x1'				!* 1: NUMARG lines.!
 ft1				!* Type it.!
 q0"n 6m0'				!* Post-SvMenu-command hook.!
 0					!* Back to survey.!

!& SvMenu ^RNormal Macro:! !S Used inside Survey Mode.
Note Babyl Command Hook.!
!*
This behaves much like & Babyl Execute Options.  We catch all
self-inserting characters typed by the user, and interpret them as
Babyl commands.  TECO's  passes us the typed character in q..0
!

 m(m.m& Declare Load-Time Defaults)
    Babyl Command Hook,
    0 or Teco program to run at times in command execution.
	Its arg tells situation:
	  In normal Babyl com loop (Q0 has com char, Q5 has arg string):
		1 before display, 2 after,
		3 before com, 4 after.
	  In survey menu (Q..0 has com char):
		5 before com, 6 after.
	  7 when entering SvM level (so you can bind things).: 0


 [1[2[3[4[5
 qBabyl Command Hookf"ew :i*'u4	!* 4: User hook.!

 1@:f<!Babyl-Command-Abort!	    !* In case something barfs.!

    q..0m(m.m& Babyl Macro Get) u1 !* 1: Function to run.!

    0l @f l \u2		    !* 2: Message number.!
    q2"E			    !* No message number -- look at command.!
       q..0:fcfCEIJMQS"L	    !* If not one of these...!
	  :i*No message selected f;Babyl-Command-Abort'   !* ...barf.!
       1u2'			    !* Else, run command with msg.1 selected.!

    q..0fsEchoOutw 0fsEchoActw    !* Echo the character.!

    @fn| fsModeChange(			!* Arrange to reselect survey, dont!
	  m(m.mSelect Buffer)*Survey*w	!* let this force modeline!
	  )fsModeChangew			!* redisplay,!
	 m(m.m& Jump To Current Survey Line) |	!* and goto correct line.!

    fsModeChange( m(m.mSelect Buffer)*Babyl*w )fsModeChangew
					!* Select Babyl buffer.!

    q2 m(m.m# Babyl J)			!* Select designated message.!
    m(m.m& Reformed Bit)"e qBabyl No Reformation Option"e	!* Reform?!
	m(m.m& Reform Header)''	!* Yes.!
    5m4					!* Pre-SvMenu-command hook.!
    :i5 f@m1w			!* Run the function.!
    6m4					!* Post-SvMenu-command hook.!

    fq5"G :i*Arg-hackery is unimplemented in SvMenu f;Babyl-Command-Abort '
				    !* Merging Babylish arguments w ish!
				    !* ..arguments is too hard...!

    >f"Lu1 @ft
1.  0fsEchoActive'w		    !* Maybe something crapped out.!

		    !* Note that the resurveyor will change our buffer, and!
		    !* ..report its brutality via F.  Therefore, we can get!
		    !* ..away with claiming that nothing has changed...!
 1

!& Survey-Select Message:! !S Select message in Babyl buffer from
the current survey line.
We leave with the Babyl buffer teco-selected, but with a cleanup handler
    pushed that will return to the survey buffer and select the current
    message's line.!

 @fn| m(m.m& Jump To Current Survey Line) |
 [..o f[Window			    !* Ensure return to the survey buffer and!
				    !* current message line and dont let any!
				    !* routines foul up our window, thinking!
				    !* we are a Babyl buffer.!
 fsQPPtr( [1			    !* Can pop q1 when we are done.!
    0l @f 	l		    !* Past leading whitespace.!
    \u1				    !* 1: Grab the number from survey.!
    qSvMenu Babyl Bufferu..o	    !* Select message buffer.!
    q1 m(m.m# Babyl J)		    !* Go select the message.!
    )fsQPUnwindw		    !* Pop off extra junk.!
 :				    !* Dont pop cleanup stuff.!

!& Jump To Current Survey Line:! !S Put point on appropriate survey line.
Puts point on line corresponding to current message.  If line
not found, try to stay on whatever line we were on before.  Resurveys if
necessary.!

!* Babyl Modified Messages is sorted first and duplicates removed.  It has!
!* the following format:  each line is a message# as a numeric argument passed!
!* to M0.  I.e. lines are <message#>M0.  Thus, whoever wants to update the!
!* changed messages binds 0 to a macro and calls Babyl Modified Messages!
!* which maps M0 over the list.!

 m(m.m& Declare Load-Time Defaults)
    Babyl Modified Messages,: ||


 !* Allow modification of svmenu buffer, in case user has it disallowed (for!
 !* user edits).  Must do here since user cannot with available hooks turn off!
 !* fsReadOnly when this runs -- is after recursive-svmenu-entrance-hook in!
 !* Survey Menu, and is after post-command-hook in & SvMenu ^RNormal Macro.!
 0f[ReadOnly

 [9[0[1[2 .[3 [K[B[S[J			!* 3: Original point.!
 qMessage Numberu2			!* 2: Will jump back to this message!
					!* after any possible updating of!
					!* survey lines.!

 0l .-b"E l' @f l z-."E -l @f l' \u3  !* 3: Msg number of original line.!

 qBabyl Modified Messagesu9		!* 9: macro to map over changed messages.!
 fq9"g					!* Need to resurvey some messages.!
    .,.fsBoundariesw g9 \l	!* Get and sort map list.!
    j<:x1  l .-z; :f f=1"e -k'>	!* Remove duplicates.!
    hfx9 0,fsZfsBoundariesw		!* 9: Trimmed, sorted mapper.!
    m.m& Get Labels for SurveyuK	!* K: for resurveyor.!
    qSvMenu Babyl BufferuB		!* B: ...!
    q..ouS				!* S: ...!
    m.m# Babyl JuJ			!* J: ...!
    m.m& Babyl Resurvey One Messageu0	!* 0: resurveyor.!
    m9					!* Resurvey.!
    :iBabyl Modified Messages	!* Reset to none needing resurveying.!
    qBu..o q2mJ qSu..o'			!* Jump back to real current message.!

 j 3,q2:\u1			    !* 1: Current message number as string  !
 :s
1"l 0l '			    !* Position on that line if found	    !
    "# [T[P[N			    !* Else,...				    !
       q3-q2"l			    !* If moving forward,...		    !
	 jl .uP 0uN		    !* Seed our guess			    !
	 j <.-z; @f	 l	    !*  Skip whitespace			    !
	    \uT qT"g		    !*  T: Test line number (use iff pos)   !
	     qT-q2"l		    !*  If before desired line,...	    !
	      qN-q2"l		    !*   If best guess is also,...	    !
	       qT-qN"g .uP qTuN ''' !*    If bigger, update guess	    !
	     "#			    !*  Else,...			    !
	      qN-q2"l .uP qTuN '    !*  If last guess was low, use this	    !
	       "# qT-qN"l .uP qTuN'''' l >' !* Else use if lower high guess !
	    "#
	zj .uP qNumber of Babyl Messages+1uN
	zj <-.; @f	 l	    !*  Skip whitespace			    !
	    \uT qT"g		    !*  T: Test line number (use iff pos)   !
	     qT-q2"g		    !*  If after desired line,..	    !
	      qN-q2"g		    !*   If best guess is also		    !
	       qT-qN"l .uP qTuN ''' !*    If littler, update guess	    !
	     "# qN-q2"g .uP qTuN '  !*  Else, if last guess high, use this  !
		"# qT-qN"g .uP qTuN'''' -l>' !* Else use if higher low guess!
        qPj 0l '		    !* Jump to best guess		    !

 

!^R SvMenu Argument:! !S Put on digits, minus, and comma to get arguments!
!*
Stolen for use here from the TMACS library.  Echoing added for Babyl, and
range of allowable characters expanded.
!

 fsQPPtr[9			    !* 9: where to unwind to!
 [0[1				    !* save q-regs!
 q..0&127:i0			    !* 0: argument as string!
 q0fsEchoOutw 0fsEchoActw	    !* echo it.!
 < 2,m.i			    !* read next character!
   :fif0123456789-,+*/:;	    !* if not digit, minus, or comma then exit!
   fiu1 :i001		    !* add character to string!
   q1fsEchoOutw 0fsEchoActw >	    !* echo it.!   
 @fiu..0			    !* ..0: terminating character!
 1fs^RArgpw  -1u1		    !* argument present, no digits yet!
 fq0< %1:g0"d 3fs^RArgpw 1;' >	    !* if find digit then set bit!
 0(q9fsQPUnwind)@:m(q..0fs^RIndirectfs^RCMacro)

!& Survey Arg Doc:! !S Return survey arg documentation.
String arg is kind of messages surveyed, e.g. "deleted", "".!

 :i*[1 [2				!* 1: String arg: label.!
 fq1"g					!* If not null, will have a!
    0:g1- "n :i1 1''		!* separate word, so add leading!
					!* space.!

 :i2Survey argument convention:
    No argument means survey all1 messages in the Babyl file.
    One positive argument n means survey the next n1 messages.
 fq1"e					!* Only mention -n for B -- for others!
					!* it is not well defined.!
    :i22
    One negative argument -n means survey the previous n messages.'

 :i22
    Two arguments  m,n  mean survey n1 messages
	starting with message number m.
 q2					!* Return arg documentation string.!

!& Survey Args:! !S Canonicalize survey args to message#,itercount.
Validates message#s, so range is real.  Itercounts are positive.!

 qMessage Number[1  qNumber of Babyl Messages[2 [3[4	!* 1,2: .,Z!

 ff"e     1,q2'			!* No args, full file:  1,Z.!

 ff-1"e				!* One arg, iteration count.!
    "g				!* One arg, next n:  .,n.!
	      ,q2-q1+1f u3u3		!* 3: Min of n and Z-.+1.!
	      q1,q3'			!* Return validated .,n.!

    "#					!* One arg, prev n:  .-n,n.!
	      -,q1-1f u3u3		!* 3: Min of n and .-1.!
	      q1-q3,q3''		!* Return validated .-n,n.!

 ff-2"e				!* One arg and comma -- m,Z??!
	      ,1f u3w		!* 3: Max of m and 1.!
	      q3,q2f u3u3		!* 3: Min of that and Z.!
	      q3,q2'			!* Return validated m,Z.!

 !* Two args  m,n.  Must validate message#m and handle +/-n.!

 ,1f u3w				!* 3: Max of m and 1.!
 q3,q2f u3u3				!* 3: Min of that and Z.!

 "g					!* m,+n.!
	      ,q2-q3+1f u4u4		!* 4: Min of n and Z-v(m)+1.!
	      q3,q4'			!* Return validated m,n.!

 "#					!* m,-n  becomes  m-n,n.!
	      -,q3-1f u4u4		!* 4: Min of n and m-1.!
	      q3-q4,q4'		!* Return validated m-n,n.!

!Survey All Messages:!
!# Babyl B:! !C# Survey all or a range of messages.
 DOC g(m(m.m& Survey Arg Doc)) COD!
 fm(m.m& Survey Args)[2[1		!* 1,2: message#, itercount.!
 m(m.m& Push Message)			!* Return to . when done.!
 q1m(m.m# Babyl J)			!* Jump to message 1.!
 q2m(m.m& Babyl Survey Several Messages)	!* Survey q2 messages.!
 

!Survey Deleted Messages:! !C Survey messages labeled "deleted".
 DOC g(m(m.m& Survey Arg Doc)deleted) COD!

 fm(m.mSurvey Labeled Messages)deleted 

!Survey Labeled Messages:! !C Survey all or some messages with some label.
String argument is label.  Messages with that label will be surveyed.
 DOC g(m(m.m& Survey Arg Doc)labeled) COD!

 fm(m.m& Survey Args)[2[1		!* 1,2: Message#,itercount.!
 [b[f[k					!* Mapper lets us use number & letter!
					!* qregs.!
 m.m& Maybe Flush Outputuf		!* F: Aborter.!
 2,(:f"g :i*')(
    )m(m.m& Read Babyl Label)Survey messages labeled: f"e'uk
 m.m& Babyl Survey Several Messagesub		    !* b: Surveyor.!
 0mb					!* Print label, empty survey buffer.!
 m(m.m& Push Message)
 q1m(m.m# Babyl J)			!* To start message.!
 1f<!SurLab!				!* Catch aborts.!
    q2m(m.m& Label Map Command)k 1,mb mff;SurLab
    >
    !* Have throw since most label mapping does not abort on typeahead.  Note!
    !* that surveyor types Flushed, mapper types Done.  Do survey first to!
    !* ensure the typeahead check first says Flushed.!
 


!Survey Messages Containing String:! !C Surveys search-selected messages.
Surveys messages which contain a string (the string argument).
(Actually this is a Teco search string.)
 DOC g(m(m.m& Survey Arg Doc)matching) COD!

 [0[1[2
 1,fSurvey messages containing string: f"e'u0	!* 0: STRARG.!
 fm(m.m& Survey Args)u2u1		!* 1,2: Message#,itercount.!
 m.m& Babyl Survey Several Messages[B	!* B: Briefer.!
 m.m# Babyl ^F[F			!* F: Finder.!
 m.m& Maybe Flush Output[A		!* A: Toilet.!

 0mB					!* Print a survey label.!
 m(m.m& Push Message)			!* Return to . when done.!
 q1m(m.m# Babyl J)			!* Move to starting message.!
 0fsVBw -:sw			!* Move back a bit so that F will!
					!* find the starting message if it!
					!* matches.!

 q2<mA1;				!* Stop if user types ahead.!
    q0,1mF;				!* Find next matching message if any!
    1,mBw				!* Survey it, no label, and dont!
					!* kill the rest of the survey.!
    zj >w				!* Move to end of message.!

 fsListen"e ftDone.
'"# ftFlushed.'			!* Since came out slowly.!
 


!Survey Reminders:! !C Survey messages with RemindNow label.
 DOC g(m(m.m& Survey Arg Doc)reminder) COD!

 fm(m.mSurvey Labeled Messages)RemindNow 

!Survey Unlabeled Messages:! !C Survey messages not labeled somehow.
Given no (or null) string argument, surveys messages with no (user)
    labels.  A string argument is a label;  surveys messages without
    that label.
 DOC g(m(m.m& Survey Arg Doc)unlabeled) COD!

 [1[2[3[4[5
 m(m.m& Use Babyl Label Table)	!* Prepare completing list.!
 8+2,fSurvey unlabeled with: u2	!* 2: Label or null.!
	!* Someday the completer will allow entries not in the list, including!
	!* null.  For now, if completer-read, will always be non-null.!
 fm(m.m& Survey Args)u5u4		!* 4,5: Startmsg#,itercount.!
 m(m.m& Push Message)			!* Return to this message when done.!
 m.m& Babyl Survey Several Messages[B	!* B: surveyor.!
 m.m& Babyl Select Message[S		!* S: Selector.!
 m.m& Maybe Flush Output[F		!* F: toilet.!

 fq2"e	@:i2| fb 1a-13 |		!* 2: Macro to return 0 iff should!
					!* survey a message.!
	@:i3| 0s,, |'			!* 3: Macro to reset search default.!
 "#	@:i3| 0s, 2, |		!* ...!
	@:i2| :fb |'			!* ...!

 0,0mBw					!* Print the survey label line and!
					!* empty the survey buffer.!
 q4m(m.m# Babyl J)			!* Go to starting message.!
 q4-1u1					!* 1: message number - 1.!
 0,(fsZ)fsBoundariesw			!* Wide bounds.!
 -s					!* Start just before this message.!

 q5<					!* Next q5 unlabs.!
    mf1;				!* Quit if user types ahead.!
    0fsVZw				!* Widen bounds below again, since!
					!* selecting in B will narrow them.!

    !* We will maintain the search default until we find a message without a!
    !* label.  Then we will call the surveyor and the search default will!
    !* be presumed lost.  But that doesnt matter much since the surveying!
    !* takes a long time compared to setting the search default.   We only!
    !* want to optimize the finding of the unlabeled messages.!

    m3					!* Set search default for finding!
					!* if a message is labeled.!

    < @:fl c .-z;			!* Forward to next message.!
      1a-"n !<!>'			!* Not a message starter, repeat.!
      %1w				!* 1: Update message counter.!
      l m2@; >				!* See if message is labeled.!
					!* Exit iteration if it is.!

    .-z;				!* Done if at end of whole buffer.!

    q1uMessage Number			!* Set message number for surveyor.!
    mS					!* B only works if we select.!
    1,mBw				!* Survey this message.!
    zj >				!* Down to end of this message!
					!* (but before the ^_ ) and go!
					!* find some more.!
 fsListen"e ftDone.
'"# ftFlushed.'			!* Since came out slowly.!
 

!Survey Seen Messages:! !C Survey messages not labeled "unseen".
 DOC g(m(m.m& Survey Arg Doc)seen) COD!

 fm(m.mSurvey Unlabeled Messages)unseen 

!Survey Undeleted Messages:! !C Survey messages not labeled "deleted".
 DOC g(m(m.m& Survey Arg Doc)undeleted) COD!

 fm(m.mSurvey Unlabeled Messages)deleted 

!Survey Unseen Messages:! !C Survey messages labeled "unseen".
 DOC g(m(m.m& Survey Arg Doc)unseen) COD!

 fm(m.mSurvey Labeled Messages)unseen 


!* Following should be kept as (only) long comments so will be compressed out:
 * Local Modes:
 * Fill Column:78
 * Comment Column:40
 * Compile Command:m(m.mGenerate Library)mc:ecc;xbabylmc:emacs1;babylbabylm
 * End:
 * *!


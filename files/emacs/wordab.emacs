!* -*-TECO-*- *!
!* This source is compiled with IVORY, not PURIFY!
!* Recent modifications:
 11/4/83  622	ECC	Improve ^R Unexpand Last Word so that when it tells
			Teco of the changed area, it tries to trim away any
			prefix part that is the same.  Typical case since the
			whole line is kept for unexpanding.
 8/14/82  621	KRONJ	Fix tab-expander to not get NIB (0, before q1-.a)
 4/24/82  619	ECC	1. Fix tab-expander installation to check the function
			being replaced in the same way the others do, by
			looking at the first n characters.  This allows
			loading WORDAB twice without tab exploding, or test
			loading.  2. STL (if word too long) bug fixed.  3. Fix
			Define.. to not rely on user ..d to define lispy ().
 3/21/82  618	ECC	1. Merge in the active-documentation code written long
			   ago and kept in WABDOC.  Remove Old... user command.
			2. Change & WRDAB Process Options Hook to not bind any
			   keys to expanders if in a recursive edit level.
			   This allows unbinding when exit levels to work --
			   otherwise WRDAB Old nnn variables are smashed and
			   cannot be restored.
			3. Change ^R Abbrev Expand for Tab to allow any kind
			   of insert at point, not just whitespace.  Checks
			   old tab's return values more carefully to decide.
 9/04/81  615	ECC	Removed spurious ; in tab expander.  Made WORDAB All
			Caps be a option variable, so Edit Options will see
			it, as will Help-V etc.
 *!
!~FILENAME~:! !Word Abbrev Mode package.  Documentation in INFO under EMACS.!
WORDAB

!& Setup WORDAB Library:! !S Run when WORDAB is loaded.
If you do non-trivial hacking of Word Abbrev mode, you should be on
    the WORDAB@MIT-AI mailing list.
Calls variable WORDAB Setup Hook, if it exists.  That can do things
    like auto-loading a file of abbreviations.  It must also connect
    keys.
If the hook does not exist (or is 0), we will connect the standard
    Word Abbrev mode keys:
	C-X C-A	  runs ^R Add Mode Word Abbrev,
	C-X C-H	  runs ^R Inverse Add Mode Word Abbrev,
	C-X +	  runs ^R Add Global Word Abbrev,
	C-X -	  runs ^R Inverse Add Global Word Abbrev,
	M-'	  runs ^R Word Abbrev Prefix Mark,
	C-M-Space runs ^R Abbrev Expand Only, and
	C-X U	  runs ^R Unexpand Last Word.
Appends to variables Set Mode Line Hook and Exit Hook.!

 m(m.m& Declare Load-Time Defaults)
    Word Abbrevs Modified, Non0 means definitions have changed: 0
    Save Word Abbrevs,
      * 1 => save all abbrevs on exit, -1 => just save incrementals: 0
    Additional Abbrev Expanders,: 0
    Only Global Abbrevs,: 0
    Word Abbrev Mode,: 0
    WORDAB Setup Hook,
	If non0 is Teco code to run when WORDAB loaded (it must set keys): 0


 [1[2					!* save regs!
 6*5fsQVectoru.e			!* .E: QVector of random WORDAB!
					!* variables.!
 qOnly Global Abbrevs"e		!* Both globals and modals.!
    m.m& WRDAB Mode or Global Expandu:.e(0)'	!* .E(0): abbrev lookup!
						!* subroutine!
 "#					!* Only globals.!
    m.m& Global Expandu:.e(0)'		!* .E(0): abbrev lookup subroutine.!

 m.m& Expandu:.e(1)			!* .E(1): & Expand subroutine.!
 0u:.e(2)				!* .E(2): old string.!
 0u:.e(3)				!* .E(3): new string.!
 0u:.e(4)				!* .E(4): new string end.!


 @:i1|(					!* 1: Our SML hook.!
					!* The parenthesis passes along!
					!* any value since we are appending.!

    !* Inserts " Abbrev", and passes along any given string (old style!
    !* hooks accumulated a string of mode line things instead of!
    !* inserting).  Call & WRDAB Process Options Hook to do the expander!
    !* character reconnecting.!

    m(m.m& WRDAB Process Options Hook)	!* Set characters if necessary.!
    0fo..qWord Abbrev Mode"n		!* In Word Abbrev Mode.!
      i Abbrev'			!* so put that into mode line.!
    )|					!* End of our SML hook.!

 0fo..qSet Mode Line Hooku2		!* 2: Old SML hook.!
 q2"e q1'"# :i*21'm.vSet Mode Line Hookw
					!* Install our SML hook if none!
					!* previous, otherwise append to!
					!* SML hook.!


 0fo..qExit Hookf"ew :i*'u1		!* 1: Old exit hook.!
 @:i*|1				!* Old stuff.!
      qWord Abbrevs Modified"n	!* New hook.!
	qSave Word Abbrevsf"gw	!* ...!
	      m(m.mWrite Word Abbrev File)'	!* ...!
	"#"l  m(m.mWrite Incremental Word Abbrev File)'''	!* ...!
      |m.vExit Hookw			!* ...!


 !* Set up Word Abbrev Mode fsVarMacros so setting variables causes action!
 !* Note that the value passed to a fsVarMacro is the new value, and the!
 !* current value of the variable is still available in the variable itself --!
 !* i.e. the variable value isnt changed until after the macro.!

 :fo..qWord Abbrev Modeu1		!* 1: ..Q index of mode variable.!
 @:i:..q(q1+2)|!* 1 => turn on Word Abbrev Mode, 0 => turn it off!
					!* This variable is an option too.!
    !* Now the fsVarMacro part.  NUMARG is the new value of the!
    !* variable: positive if the mode shoud be turned on, 0 or!
    !* negative if should be turned off.  Old value is still in the!
    !* variable.  Make sure we run & Set Mode Line to (1) put "Abbrev"!
    !* in the mode line, and (2) set all the expander keys.!

    1fsModeChangew  |		!* The fsVarMacro.  A shortie.!


 :fo..qOnly Global Abbrevsu1		!* 1: ..q index.!
 @:i:..q(q1+2)|!* 1=> use only global word abbrevs, 0 => both kinds!
					!* This variable is an option too.!

    !* Now the fsVarMacro part.  NUMARG is new value, old is still in!
    !* variable.  Sets C-X C-A and C-X C-H unless user has a WORDAB!
    !* Setup Hook.  Changes the abbrev-checker.!

    qWORDAB Setup Hook[1		!* 1: 0 or hook.!
    "n m.m& Global Expandu:.e(0)	!* 1, just global abbrevs.!
	 q1"e m.m^R Add Global Word Abbrevu:.x()		!* C-X C-A.!
	      m.m^R Inverse Add Global Word Abbrevu:.x()''	!* C-X C-H.!
    "# m.m& WRDAB Mode or Global Expandu:.e(0)	!* 0, both kinds.!
       q1"e m.m^R Add Mode Word Abbrevu:.x()		!* C-X C-A.!
	    m.m^R Inverse Add Mode Word Abbrevu:.x()''	!* C-X C-H.!
     |				!* End of the fsVarMacro.!


 :fo..qAdditional Abbrev Expandersu1	!* 1: ..Q index of expander list.!
 q:..q(q1+1)f"n,m(m.mMake These Characters Expand)'w	!* Check if any.!
 @:i:..q(q1+2)|!Non-standard characters that should cause expansion.!
	       ,:m(m.mMake These Characters Expand)	!* Give the!
	       |			!* list a varMacro comment.!

	       !* Note that it isnt an option.  If we decide to make it one,!
	       !* then the fsVarMacro will have to worry about repeatedly!
	       !* appending the same characters, e.g. because Edit Options!
	       !* will reset the variable upon exit even if unchanged.!

 !* Finally, we do key-setting unless the user has a setup hook.  In that!
 !* case the hook must set any keys, along with whatever else it wants to!
 !* do.!

 0fo..qWORDAB Setup Hooku1		!* 1: Setup Hook or 0.!
 q1"n m1'				!* Call the hook if there is one.!
 "# !* No hook, so we connect the standard keys.  Note that regardless of!
    !* Only Global Abbrevs, C-X + and C-X - will always be global hacking!
    !* definers.  The variable only affects C-X C-A and C-X C-H.!

    m.m^R Unexpand Last Wordu:.x(U)			!* C-X U.!
    m.m^R Abbrev Expand Onlyu... w			!* C-M-Space.!
    m.m^R Word Abbrev Prefix Mark!"!u..'		!* M-Apos.!
    m.m^R Add Global Word Abbrevu:.x(+)		!* C-X +.!
    m.m^R Inverse Add Global Word Abbrevu:.x(-)	!* C-X -.!
    qOnly Global Abbrevs"n				!* Globals only.!
      m.m^R Add Global Word Abbrevu:.x()		!* C-X C-A.!
      m.m^R Inverse Add Global Word Abbrevu:.x()'	!* C-X C-H.!
    "#							!* Modals and globals.!
      m.m^R Add Mode Word Abbrevu:.x()		!* C-X C-A.!
      m.m^R Inverse Add Mode Word Abbrevu:.x()''	!* C-X C-H.!
 
 1fsModeChangew 			!* Go into Word Abbrev mode if its!
					!* variable says to.!

!Expand Word Abbrevs in Region:! !C Finds abbrevs in region; offers to expand each.
Searches region for word abbrevs.  When one is found, the buffer is
    displayed with the cursor just after the abbrev.  The character
    you then type determines what action is taken:
Space	expands the abbrev and goes on to the next one.
Rubout	goes on to the next one without expanding.
Altmode	exits this command without expanding.
Period	expands and then exit.
Comma	expands and stays so you can look it over.  Then type one
	of these characters again.
Exclamation mark expands this and each remaining abbrev without
	asking.
Hyphen	expands and glues to a prefix and stays.  The prefix and
	abbrev should be separated by a "-".
F	causes this paragraph to be filled.
C-R	enters a recursive edit level, so you can move point or do
	minor editing.
C-L	clears and redisplays the screen and stays.!

 !* Note the s used below to bound the WORDAB Ins Chars string value.!
 m(m.m& Declare Load-Time Defaults)
    WORDAB Ins Chars, Self-inserting expanders: !~@#;$%^&*-_=+[]()\|:`"'{},<.>/? 

    WORDAB Old Chars, Hairy expanders: ||
    Word Abbrev Prefix Mark, Point of prefix mark: 0


 [0[1[2[3[4[5 0[6			!* 6: 0 iff should ask.!
 0[..f					!* ..F: Disallow file hacking.!
 :,.f -zu0j				!* Jump to top of region.!
					!* 0: End of region as .-Z.!
 [.1[.2					!* Dot-qregs for passing to!
					!* .E(1), the expander.  .1!
					!* will be the abbrev, and .2!
					!* will be index into ..Q!
 0[Auto Fill Mode			!* Bind auto-filling off.!
 0u..h					!* First redisplay will.!
 qModeu2				!* 2: Mode for expand checking.!
 qWORDAB Ins Charsu1			!* 1: Get list of all characters that are expanders.!
 qWORDAB Old Charsu4 :i114	!* ...!
 :i*Expanding abbrevs[..j fr		!* Display modeline.!

 f<!DONE!				!* Throw here to quit.!
    @:f1l .-(q0+z);		!* Move to next expander.!
    1:<-fwu4u3>"e			!* 3,4: bound last word.!
      q3,q4x.1				!* .1: last word.!
      :fo..qX .1 2 Abbrevf"gu.2 oEXP'w	!* .2: ..q index if abbrev.!
      :fo..qX .1 * Abbrevf"lw :c !<!>'u.2	!* ...!

      !EXP!
      1u5				!* 5: Non-0 means can expand.!
      < q6"e 2,m.i			!* Redisplay and prepare for input!
					!* without prompting or echoing.  This!
					!* will handle HELP, for instance.!
	     fi:fcu4'			!* 4: Ask if expand.!
	"# 32u4'			!* 4: Force expand without asking.!

	!* Each of the following conditionals should either exit (1;) or!
	!* repeat (Excl<Excl>) this iteration.  Falling through to the end of!
	!* the iteration means an illegal character was typed.  First the!
	!* expanders.  They expand if Q5 not = 0.!

        q4-!"e 1u6 32u4'		!* 4: Excl turns into Space, and!
					!* 6: sets no-asking flag.!
	q4-32"e q5"n m:.e(1)' 1;'	!* Space means expand and go.!
	q4-,"e q5"n m:.e(1) 0u5'"# fg' !<!>'	!* Comma means expand, stay.!
	q4-."e q5"n m:.e(1)' f;DONE'	!* Period means expand, quit.!
	q4--"e			!* Dash means mark, expand, and stay.!
	    q5"n -:@f-*0 ,0 -1uWord Abbrev Prefix Mark
					!* The *0 ,0  just gets the!
					!* 1st value.!
		  m:.e(1)		!* Do the expansion and gluing.!
		  0u5'			!* 5: 0 means have expanded here.!
	    "# fg' !<!>'		!* Cannot expand any more.!
	q4-"e  0u5 !<!>'		!* 5: Let user edit and then disallow!
					!* further expanding here since point!
					!* may not be after the abbrev which!
					!* may not even be there either.!
	q4-F"e fsVZ-q0f[VZ		!* Protect end of region Q0.!
		  m(m.m^R Fill Paragraph)w	!* Fill.!
		  f]VZ			!* Get back end of vbuf.!
		 @v 0u5 !<!>'		!* 5: Stay but disallow further!
					!* expanding since we dont really know!
					!* that we are at an abbrev.!
	q4-"e f;DONE'		!* Altmode means quit.!
	q4-14."e f+ !<!>'		!* Clears, redisplays, stays.!
	q4-"e 1;'			!* Rubout means not expand, go.!
	q4-?"e 4110.fsRereadw !<!>'	!* ? is like typing Help-character.!

	!* Getting here means none of the character-conditionals were taken,!
	!* so the character is illegal.  Complain.!

	fg q4m(m.m& Charprint) ft is meaningless here.
					!* Tell what character is wrong.!
	4110.fsRereadw			!* Go act like Help-character so tell!
					!* what is ok.!
	>				!* Ignore any other commands.!
      '					!* End of conditional on finding a!
					!* word to check for expansion.!
    @f1l >			!* Move past expanders.!

    !* Used to be :FWL but since expanders do not have to be word!
    !* delimiters, might loop infinitely on an abbrev which expands!
    !* essentially to itself (e.g. emacs), followed by a non-delim!
    !* expander, e.g. apostrophe in Text mode.!

 

!^R Abbrev Expand Only:! !^R Expand abbrev before point, but insert nothing.
If given an argument, will feep if last word isn't an abbrev.!
!^R Abbrev Expand !			!* For & Set Word Abbrev Chars.!
 .(					!* Save . for checking if expanded.!
    1f<!ExpandQuit!			!* Allow wabmac throwing, though it!
					!* doesnt make any difference for us.!
       0,0a"c m:.e(0)'			!* Expand.!
       >				!* ...!
    )-."e ff"g fg'' 1	    !* Feep if ARG and no expansion.!

!^R Abbrev Expand And Call Old Char:! !^R Expand abbrev before point, then old action.
Explicit numeric argument inhibits expanding.
 f*0+1m(m.m& WRDAB Old Char Describe)!

!^R Abbrev Expand !
 1f<!ExpandQuit!			!* Allow wabmac throwing.!
    ff"E				!* No expanding if an ARG.!
      0,0a"c m:.e(0)''			!* Expand.!
    [.1 8[..e
    q..0fs^RIndirect:\u.1 ]..e		!* .1: Octal for char.!
    f @mWRDAB Old .1		!* Call old char function.!
 !* Do not use :M yet since currently :Ming to a builtin(it might be) will not!
 !* exit popping q-register pdl.!
    > 1				!* Exit here if thrown to.!

!^R Abbrev Expand And Self-Insert:! !S Expand last word if an abbrev, then self-insert.
Giving an explicit numeric argument inhibits expansion, just inserting
    that many copies of character that ran this.
 f*0m(m.m& WRDAB Old Char Describe)!
!^R Abbrev Expand !
 1f<!ExpandQuit!			!* Allow wabmac throwing.!
    ff"e 0,0a"c m:.e(0)''		!* Maybe expand.!
    f@m(q..0@fs^RIndirect@fs^RInit)	!* Self-insert.!
 !* Do not use :M yet since currently :Ming to a builtin(it might be) will not!
 !* exit popping q-register pdl.!
    > 1				!* Exit here if thrown to.!

!^R Abbrev Expand for Tab:! !^R Expand abbrev at point if old Tab action inserts.
If Tab will not insert at point, no expansion is attempted.
    (E.g. the Tab is reindenting the line, but point is mid-line.)
Explicit numeric argument inhibits expanding.
 f*0+2m(m.m& WRDAB Old Char Describe)!

!^R Abbrev Expand !
 [1[2[3[4 qWRDAB Old 11[5 [6		!* 5: Old tab function.!
 1f<!ExpandQuit!			!* Allow wabmac throwing.!
    .u1					!* 1: Original point.!
    @f	 l z-.u2 q1j		!* 2: Z-Point right past whitespace.!
    .,.f				!* Tell  that buffer is modified so!
	!* that simple-minded tabs calling fs^RInsert wont be too primitive!
	!* and echo a tab which might thus get echoed twice here.!
    f@m5f(f				!* Run old tab and tell .!
      )f(+0u4+0u3			!* 3,4: Values returned by tab, or 0s.!
      )f-3"e				!* If tab returns 2 values, we can!
					!* guess if it inserted at point.!
	.u6				!* 6: Point after running old tab.!
	ff"e			!* Expand possible only if no ARG.!
	 0,q1-.a"c			!* If possible abbrev at old point,!
	  q3-q1"e			!* if tab values start at old point,!
	    q4j @f	 l z-.(q6j)-q2"e	!* end after old-./whitespace,!
	      q3,q4k			!* then kill the tabs insertion.  Note!
					!* that this leaves point at q3=q1.!
	      m:.e(0)			!* Expand any abbrev.!
	      f@m5f'''''		!* And run the old tab again.!
    > 1				!* Maybe thrown out of.!

!^R Word Abbrev Prefix Mark:! !^R Remember point as end of an abbrev prefix.
Expansion of the prefix may occur unless an numeric argument is given.
Remembers this point as a prefix-end, and inserts a hyphen (which will
    disappear if an abbrev expands just after that hyphen).  E.g. you
    might type "inter", mark that as a prefix (you see "inter-"), and
    then type an abbrev ("inter-comm " which becomes
    "intercommittee").!
 m(m.m& Declare Load-Time Defaults)
    Word Abbrev Prefix Mark, Point of prefix mark: 0


!^R Abbrev Expand !
 ff"E			    !* No expanding if an ARG.!
    0,0a"c m:.e(0)''		    !* Expand!
 . m.vWord Abbrev Prefix Markw
 .,(i-). 			    !* Hyphen is deleted when!
				    !* expansion occurs.!

!& WRDAB Mode or Global Expand:! !S Maybe expand previous word.
Expand previous word if mode or global abbrev.
This goes on Q:.E(0) if user wants both modals and globals.!
 -fwx*[.1 fq.1-86"g'			!* .1: Last word, 86 max length to!
					!* avoid STL error.!
 qMode[.2				!* .2: Mode name.!
 :fo..qX .1 .2 Abbrevf"lw :fo..qX .1 * Abbrevf"lw''u.2
				    !* .2: Abbrev ..Q offset!
 :m:.e(1)			    !* expand!

!& Global Expand:! !S Expand previous word if global abbrev.
This goes on Q:.E(0) if user wants only globals.!
 -fwx*[.1 fq.1-86"g '			!* .1: Last word, 86 max length to!
					!* avoid STL error.!
 :fo..qX .1 * Abbrevf"lw'[.2 !* .2: Abbrev ..Q offset!
 :m:.e(1)			    !* expand!

!& Expand:! !S .1 is abbrev, .2 is ..Q offset
This is the abbrev-expander, goes on Q:.E(1).
A pre-comma numeric argument inhibits auto-filling.  (Since ^^M, e.g.,
    is called by some to insert CRLF but not auto-fill.)!

 m(m.m& Declare Load-Time Defaults)
    WORDAB All Caps,
	* Controls whether all-caps abbrev expands to all-caps.
	1 - all-caps expands to all-caps; if 0 - only 1st letters are caps: 0
    Word Abbrev Prefix Mark, Point of prefix mark: 0

!* 
Say last word is "foo" and current mode is "ala":
If X foo ala Abbrev (for current mode ala) exists, it has exp.
Else if X foo * Abbrev exists (global abbrev), it contains expansion.
    (Thus any mode abbrev "foo" overrides a global abbrev "foo".)
If expansion occurs:
    If a hyphen to left of last word, and Word Abbrev Prefix Mark points
	before it, then the hyphen is removed, gluing prefix to expansion.
If first letter of abbrev is capitalized, first letter of expansion will
    be capitalized too.
If first and last letter of abbrev is capitalized (e.g. all letters),
    we do more upper-casing, controlled by WORDAB All Caps:
    If 0 then the first letter of each word in expansion is capitalized.
    If non-0 then the entire expansion is upper-cased.
    For one-word expansions, the former choice is meaninless so we do the
    latter, fully upper-casing the single word.
In fill mode, line may be broken.
The comment for the abbrev variable is a string-number that tells the
    number of times the abbrev has been used.!

!*  Information saved to allow unexpanding:
    .E(2) is the "old string" -- from the beginning of the line up to and
	including the abbrev.
    .E(3) is the "new string" -- from the beginning of the line up to and
	including the expansion.
    .E(4) is the end point of the new string.

    Note that this allows auto-filling to change things a little before the
    abbrev (e.g. whitespace) that will be ok since it doesnt go back before
    the beginning of the line.  We assume that the stuff after the abbrev
    remains the same after expansion.  Possibly some day auto-filling might
    change it but...!
				    !* .1: abbrev.!
				    !* .2: ..Q-offset for abbrev var.!
 [..0				    !* ???!
 q:..q(q.2+2)[.3		    !* .3: usage-count string for ab var.!
 q.3fp-101"N :i:..q(q.2+2)1'	    !* If count wasnt string, e.g. set by!
				    !* local mode of file, make string of 1.!
 "# .(g.3)j .(1a-#"n \+1:\u:..q(q.2+2)')j fq.3d'	!* Increment!
					!* usage-count (string).!

 0f f(x:.e(2)): [.6w			!* .E(2): save old string for!
					!* unexpanding later.!
					!* .6: Point at start of line.!

 -fq.1d				    !* Delete the abbrev.!
 0,0a--"E			    !* Hyphen to left, !
   qWord Abbrev Prefix Mark+1-."E	!* ...and a prefix just before it.!
      :i.1-.1		    !* Update last word to include hyphen.!
      -d''			    !* ...So remove hyphen, gluing prefix on.!

 .[.4				    !* .4: Point before expansion.!
 g:..q(q.2+1)			    !* Insert the expansion.!
 .[.5				    !* .5: Point after expansion.!
 -1[.7				    !* .7: start at char 0 (we increment 1st)!
 fq.1[.8			    !* .8: get length of Q.1!
 <%.7-q.8;			    !* dont search beyond the end of string!
    q.7 :g.1"a0;'>		    !* but find the first alphabetic char !
 q.7-q.8"l q.7:g.1"u		    !* 1st letter of abbrev was capitalized.!
     q.4j :fwl			    !* find where to start capitaliztion.!
     1  @fc			    !* So capitalize expansion.!
     q.8-1 :g.1"u		    !* Last letter of abbrev was capitalized.!
      qWordab All Caps"e	    !* Supposed to uppercase first letters.!
	0u.3			    !* ... .3: 0 word count.!
	:< 2:fwl .-q.5; %.3w	    !* ... .3: Iter over expansion, count!
				    !* ... words.!
	   1  @fc >w		    !* ... Cap each word in expansion.!
	q.3"e q.4,q.5 @fc''	    !* ... One-word expansion means all caps.!
      "#			    !* Supposed to cap whole expansion.!
	q.4,q.5 @fc''		    !* ...So uppercase everything.!
     ''				    !* End of first let capped.!


 q.5j				    !* Move to end of expansion.!
 q.4,q.5 f			    !* Tell ^R of changes to buffer.!


 !* Now repeatedly auto-fill this line until it fits.  We may need to fill!
 !* multiple times since expansion may be several words long.  Calling ^R!
 !* Auto-Fill Space with an argument of 0 tells it to insert no spaces but!
 !* fill once if necessary.  We limit the number of iterations to a!
 !* reasonable maximum (each auto-fill should rip off at least one space +!
 !* one char (word).  This is so some buggy auto-filler or tab wont!
 !* infinitely keep causing us to fill.!

 ff-1"G oUPDATE '			!* No auto-fill if pre-comma ARG.!

 qAuto Fill Mode"e oUPDATE'		!* If not filling, can skip this.!

 m.m^R Auto-Fill Space[S		!* S: space.!
 0f  /2< .-(0mSf			!* Auto-fill maybe, tell ^R mode.!
      ).@; >				!* Repeat until point doesnt change,!
					!* which means no fill happened.!

 !UPDATE!

 q.6,.x:.e(3)				!* .E(3): Save new string for!
					!* unexpanding later.!
 .u:.e(4)				!* .E(4): Save end of new string too.!

 !* Now we maybe call a word abbrev macro.!
 0:g:..q(q.2+2)-#"e			!* Aha -- a word abbrev macro.!
    q:..q(q.2)u.4			!* .4: abbrev variable name.!
    fq.1+3,fq.4-7:g.4u.4		!* .4: just the mode part of it.!
    mX .1 .4-WABMAC Abbrev'	!* So call its macro part.!

 

!^R Unexpand Last Word:! !^R Undo last expansion, leaving the abbrev.
Another ^R Unexpand Last Word will redo the expansion.
An effort is made to keep point unchanged, but if unexpanding causes a change
    in the text around point, point may move.!

!*  Information saved to allow unexpanding:
    .E(2) is the "old string" -- from the beginning of the line up to and
	including the abbrev.
    .E(3) is the "new string" -- from the beginning of the line up to and
	including the expansion.
    .E(4) is the end point of the new string.!


 [0[1[2[3[4[5

 !* First figure what point to restore when done.  Note that string is not!
 !* just expansion or abbrev, but entire line up to and including expansion or!
 !* abbrev.  We restore point if after the string (using .-Z), or if it is!
 !* before the string (using .), or if it is in the first part of the string!
 !* -- the part of length min(l(old),l(new)).  This part is likely to be text!
 !* before the abbrev on the same line, so is a good guess for restoration.!
 !* P is .E(4), L1 is .E(3), L2 is .E(2).!

 .-(q:.e(4)-(fq:.e(3)-fq:.e(2)f"lw 0'))"l	!* . lt P-(max(0,l1-l2)).!
    .u4 fnq4j'				!* 4: Point before or in overlap.!
 "# q:.e(4)-.f"g+.'"#w .'-zu4 fnq4+zj'	!* 4: Point after string restored, but!
					!* in string moves to end of string.!

 q:.e(4):j"e oNONE'			!* Back to end of new string.!
 q:.e(3)u0				!* 0: New string.!
 fq0u1 q1:"g oNONE'			!* 1: Length of new string.!
 .-q1f"l oNONE'u2			!* 2: Start of new string.!
 q:.e(2)u3 q3fp"l oNONE'		!* 3: Old string.!
 q2,.f~0"n				!* Make sure new string is where it is!
					!* supposed to be.!
    !NONE! fg @ft
No last expansion 0fsEchoActivew 1 '	!* ...!

 q2,.k					!* Remove the new string.!
 g3					!* Insert the old string.!

 !* Now try to specify the changed region as small as possible.  The problem!
 !* is that the old/new strings are entire lines.  We will compare them to try!
 !* to trim down to (near) the difference.  In particular, for common case of!
 !* one word expanding to larger word or phrase, dont want the beginning part!
 !* of line included:  (note that ,0f   takes the absolute value) !

 q2+(f=03,0f  )-1,.f		!* Tell Teco of the changed area.!

 !* Now reorder .E information to allow another unexpand to actually do a!
 !* re-expansion.!

 q0u:.e(2)				!* New string becomes old string.!
 q3u:.e(3)				!* Old string becomes new string.!
 .u:.e(4)				!* Current point is end of the now new!
					!* string which is to say the old!
					!* string if you catch my meaning.!
 0

!WORDAB:!
!Word Abbrev Mode:! !C Turn Word Abbrev mode on or off.
Given no argument, the mode is toggled (turned on if it was off, and
    turned off if it was on).
Given positive argument, the mode is always turned on.
Given 0 or negative argument, the mode is turned off.
Giving this command 1 as a pre-comma argument means that you only use
    global abbrevs, and things are set up to be faster (e.g. faster
    expansion checking since it doesn't have to check both global and
    local abbrevs).
Each of the following chars: ~@#;$%^&*()-_=+[]\|:'`"{},<.>/?, Space,
    Return, and Tab, will cause expansion of abbrevs followed by their
    normal action.
If you wish to supply additional characters that should expand, see
    the description of Make These Characters Expand.
If you wish to completely replace this list of expanding characters,
    set the variable WORDAB Ins Chars in your init or EVARS file to
    the string of characters that should expand.!

!* M-X Word Abbrev should be M-X Word Abbrev Mode, by the policy that says!
!* that just giving the name of the mode should call the mode function.  Just!
!* as M-X Text should turn on Text mode.!

 [0
 ff&2"n !* First, if we were given a pre-comma NUMARG, that means we!
	    !* should reset the kind of expander-checker (modal/global or just!
	    !* global).  We let the fsVarMacro for Only Global Abbrevs!
	    !* do all the work.!
	    uOnly Global Abbrevs'	!* ...!

 ff&1"n "'gu0'			!* 0: if NUMARG, then -1 if NUMARG was!
					!* positive, 0 else.!
 "# qWord Abbrev Mode"'eu0'		!* 0: 0 if was on, -1 if was off.!
 q0,0f  uWord Abbrev Mode		!* Set the variable, running its!
 0					!* fsVarMacro to turn the mode!
					!* on/off.!

!Define Word Abbrevs:! !C Define abbrevs from a definition list in the buffer.
Buffer should contain the word abbrev definition list.
If given a pre-comma numeric argument, all abbrevs will be killed
    before defining the new ones from the buffer.  (The old abbrevs
    are not killed until we are sure that the syntax of the buffer's
    definition list is correct.)!

!* We put the whole definition list (teco version) onto the variable for the!
!* incremental definitions, just to be complete.  For huge lists this could be!
!* pretty bad, but then that doesnt seem likely.!

!* Format of buffer:
<buf> ::= null | <defline> <CRLF> <buf>
<defline> ::= <abbrev> : <white> <optionals> <white> " <expansion> "
    <expansion> may be more than one line, and may have '"'s in it as long as
    they are quoted with another '"'.
<optionals> ::= <optmode> <white> <optcount>
<optmode> ::= null | ( <mode> )
<optcount> ::= null | <number>
For now nothing else, no :s in <abbrev>.
<mode> is the name of a major mode (e.g. LISP), if abbrev is to be
    effective only in that mode.  It is ommitted if the abbrev is to be
    effective in all modes.
<number> is a usage-count for the abbrev -- i.e. how many times the
    abbrev has been used before.  Could be #0 too for word abbrev macros.
<white> is any number (including 0) of spaces and tabs.!

 m(m.m& Declare Load-Time Defaults)
    Word Abbrevs Modified, Non0 means definitions have changed: 0


 !* For nice errors to the user, since the standard EMACS ..P will redisplay!
 !* the buffer, syntax errors jump to a common point to switch back to the!
 !* human buffer.!

 [.1[.2[.4[E				!* E for error messages.!
 q..o[B					!* B: Users definition buffer.!
 g(q..o(f[BBindw))			!* Temp buf, init with defns.!
 bj 0s <:s;ric>		!* Teco-quote alts, ^]s.!
 zj i
					!* Ensure something after final quote!

 bj
 < @f
l  .-z;				!* Past any blank lines.!
   fwfx.1				!* .1: Next <abbrev>.!
   0,1a-:"n :iENo : ending abbrev .1 oERR'
   d					!* Remove colon.!
   @f 	k			!* Remove <white>.!
   0,1a-("E d .u.2 :fb)"e :iENo ) after mode name for abbrev .1 oERR'
					!* .2: Point starting <mode> name.!
		-d q.2,.fx.2 d'		!* .2: <mode> name.!
   "# :i.2*'				!* .2: * for global.!
   @f 	k			!* Remove <white>.!
   @f#0123456789 fx.4		!* .4: <number> usage-count.!
					!* Note that # can be used to flag!
					!* this ab as having a WABMAC.!
   fq.4"E :i.40'			!* .4: 0-string by default.!
   @f 	k			!* Remove <white>.!
   0,1a-34"N :iENo quote to start expansion for .1 oERR'
   d i:i*				!* Delete quote, make command.!
   0s" !'! <:s"e :iENo quote to end expansion for .1 oERR'
	     0,1a-":@; c> !'!		!* Find unquoted doublequote.!
   15.,1a-15."n
      :iEPossible unquoted " in expansion for .1 -- final " not at end of line
      oERR !''!'
   -d					!* Remove endquote.!
   iM.VX .1 .2 Abbrevw	!* Make expansion command.!
   i M.CX .1 .2 Abbrev.4	!* Make set-comment command.!
   >					!* Next abbrev defn.!
 j 0s"" <:s; -d> !''!			!* Take quote-quoters off.!

 !* If we got here ok, the syntax in the buffer is good.  Now we can kill!
 !* previously defined abbrevs if we were given a pre-comma.!

 ff&2"n m(m.mKill All Word Abbrevs)'	!* Kill, kill, kill.!

 m(hx*)					!* Define by running buffer.!
	!* This used to be m..o but sometimes Teco seems to have trouble --!
	!* rare but strange when it happens, e.g.  seeming to get the wrong!
	!* start PC or something.!

 1uWord Abbrevs Modified

 j g( 0fo..qLately Changed Abbrevsf"ew :i*' ) i
					!* Append to incremental definitions.!
 hx*m.vLately Changed Abbrevsw		!* ...!

 

 !* Syntax error reporting.  Switch to users definition buffer, and!
 !* put point at the beginning of the erring line.  We cannot really!
 !* do better with certainty since Teco-quoting altmodes and ^]s fouls!
 !* up point (otherwise Z-. would be about the same as in the human!
 !* buffer except for final CRLF.)  So we count lines back from end of!
 !* buffer.!

 !ERR!

 0l .fsVBw 0u.2 zj <-l b-.; %.2w>	!* 2: # of lines from end.!
 qb[..o					!* Switch to user buffer.!
 zj <q.2-1f(:;)u.2 -l>			!* Put point at erring line.!
 qe fsERR 				!* Report the error, and catch any!
					!* unexpected continuing.!

!Make Word Abbrev:! !C Define one word abbrev, global or for any mode.
After doing M-X Make Word Abbrevfoofind outer otter, typing "foo"
    will automatically expand to "find outer otter".
3rd string argument, if any, is the mode for the abbrev.
No 3rd string argument means use the current mode.
3rd string argument = "*" means this make a global abbrev.
This command defines just one abbrev, as compared to Define Word
    Abbrevs which defines several abbrevs from a list in the buffer.!

 :i*( :i*( :i*[.3)[.2)[.1    !* .1: Abbrev.!
					!* .2: Expansion.!
					!* .3: Mode or * or null.!
 fq.3"E qMODEu.3'			!* .3: Mode or *.!

 q.1,q.2 m(m.m& Check And Make Word Abbrev).3	!* Define.!
 w 1 

!Make These Characters Expand:! !C Add characters to the list of abbrev expanders.
E.g. M-X Make These Characters Expand1234567890 will cause the
    digits to expand any abbrev before them, just like #$%.,/? etc.
    Note, though, that this will not necessarily make digits be
    word-delimiters.
If your keyboard has Top-characters (e.g. Top-Z is alpha), you can
    have them be expanders too, though some of them can't be typed to
    ^R Extended Command (namely Top-Q and Top-M).  Also: if you
    put this command into an init file, be careful to double any use
    of Top-S (namely C-]).
You can have an EVARS file (as opposed to an init file) declare
    additional expanders too in a simple way -- just put the
    characters into the variable Additional Abbrev Expanders.  E.g. to
    make the digits expand, put the following line into your EVARS
    file (you need the "*" to force it to be a string):
Additional Abbrev Expanders:*1234567890 (Top-character users:  in an
    EVARS file you would not need to double Top-S.)!
!* The string of expanders may also be passed as a pre-comma numeric argument.!

 !* Note the s used below to bound the WORDAB Ins Chars string value.!
 m(m.m& Declare Load-Time Defaults)
    WORDAB Ins Chars, Self-inserting expanders: !~@#;$%^&*-_=+[]()\|:`"'{},<.>/? 

    WORDAB Old Chars, Hairy expanders: ||


 !* We add the new expanders to the self-inserter list, since they will be!
 !* moved to the old-character list automatically and correctly in most cases.!
 !* There are some weird situations, possibly wrong:  having lambda (Top-V and!
 !* also Backspace) in the list will make Backspace self-insert a lambda!
 !* instead of moving back.  This is because the check is not for!
 !* self-insertion but just builtin-ness.  That could be corrected.  See the &!
 !* WRDAB Turn On Ins Char routine.!

 [0[1
 ff&2"n u0'			!* 0: Pre-comma NUMARG, new expanders.!
 "# :i0'				!* 0: STRARG, new expanders.!
 qWORDAB Ins Charsu1			!* 1: self-inserter list.!
 :iWORDAB Ins Chars10	!* Append new expanders to!
					!* self-inserter list.!
 :m(m.m& WRDAB Process Options Hook)	!* Process the expander lists now to!
					!* install the expanders and migrate!
					!* any hairy old definitions to the!
					!* WORDAB Old Characters list.!

!^R Add Mode Word Abbrev:! !^R Define an abbrev for word(s) before point.
Negative numeric argument means to delete the word abbrev.  (If there
    is no such mode abbrev, but there is a global, it asks if it
    should kill the global.)
Positive numeric argument (>0) means expansion is that many last
    words.
Zero numeric argument means expansion is between point and MARK.
(Extension writers: If Teco's fs^RMark set, that means expansion is
    between . and fs^RMark.)
The abbrev is only effective when in the current mode (e.g. LISP).!
 "L f @:m(m.m^R Kill Mode Word Abbrev) '   !* Neg ARG, delete.!
 qMode[.1				!* .1: Current major mode.!
 f @m(m.m& Add Word Abbrev).1.1 Abbrev	!* Call with SP <mode>!
					!* for varname, MODE Abbrev as prompt.!
 w 1 

!^R Add Global Word Abbrev:! !^R Define an abbrev for word(s) before point.
Negative numeric argument means to delete the word abbrev.
Positive numeric argument (>0) means expansion is that many last
    words.
Zero numeric argument means expansion is between point and MARK.
(Extension writers: if fs^RMark set, that means expansion is between
    . and fs^RMark.)
The abbrev is effective in all major modes.!
 "L f @:m(m.m^R Kill Global Word Abbrev) '	    !* Neg ARG, delete.!
 f @m(m.m& Add Word Abbrev)*Global Abbrev	    !* Call with * !
				    !* stringarg for varname, Global... as!
				    !* prompt string.!
 w 1 

!^R Inverse Add Mode Word Abbrev:! !^R Define the expansion for abbrev before point.
Numeric argument n means nth word before point is to be an abbrev
    (e.g.  you thought it already was, and you are now n words
    beyond).  No numeric argument means the word just before point,
    same as argument of 1.
Reads a one-line expansion for the abbrev, defines it, and expands
    it.!

 qMode[.4
 .-z[.0				    !* .0: Orig .-z.!
 -:fwl			    !* Move back to end of abbrev.!
 -fwx*[.1			    !* .1: Abbrev.!
 1,m(m.m& Read Line)Expansion for .4 abbrev ".1": [.2 !''!
				    !* .2: 0 or expansion string.!
 q.2"e 1'			    !* 0, abort.!
 fq.2"e 1'			    !* Null, abort.!
 m(m.mMake Word Abbrev).1.2    !* Current mode abbrev.!
 @m(m.m^R Abbrev Expand Only)f   !* Expand abbrev before point.!
 q.0+zj				    !* Back to orig point.!
 1				    !* Return, display done already.!

!^R Inverse Add Global Word Abbrev:! !^R Define the expansion for abbrev before point.
Numeric argument n means nth word before point is to be an abbrev
    (e.g.  you thought it already was, and you are now n words
    beyond).  No numeric argument means the word just before point,
    same as argument of 1.
Reads the expansion in the echo area.  (This command cannot define
    multi-line expansions.)
Defines that abbrev, and then expands the abbrev before point.
Aborts if you abort the line-reading with Rubout, or if the expansion
    is null.!

 .-z[.0				    !* .0: Orig .-z.!
 -:fwl				   !* Move back to end of abbrev.!
 -fwx*[.1			    !* .1: Abbrev.!
 1,m(m.m& Read Line)Expansion for global abbrev ".1": [.2 !''!
				    !* .2: 0 or expansion string.!
 q.2"e 1'			    !* 0, abort.!
 fq.2"e 1'			    !* Null, abort.!
 m(m.mMake Word Abbrev).1.2*    !* Current mode abbrev.!
 @m(m.m^R Abbrev Expand Only)f   !* Expand abbrev before point.!
 q.0+zj				    !* Back to orig point.!
 1				    !* Return, display done already.!

!^R Kill Mode Word Abbrev:! !^R Remove the definition for one abbrev.
Same as ^R Add Mode Word Abbrev with a negative numeric argument.!
 :i*Fundamental fo..qMODE[.2	    !* .2: Mode name.!
 1, m(m.m& Read Line)Kill .2 Abbrev: [.1	    !* .1: Abbrev.!
 q.1"E '			    !* Abort.!
 0fo..qX .1 .2 Abbrev"E	    !* No such mode abbrev.!
    0fo..qX .1 * Abbrev"E	    !* And no global either.!
	FG @ft".1" is neither .2 mode nor global abbrev. !''!
	0fsEchoActivew 1 '	    !* Do nothing, and dont erase message!
    "# FG @ft".1" is not a .2 mode abbrev, but is a global abbrev.
Kill it? !''!
	  1m(m.m& Yes Or No)"E	   !* ask him!
	     @ft Not killed.  0fsEchoActivew 1 '	    !* he said no!
	  :i.2*''		    !* .2: Reset to kill global.!
 m(m.mKill Variable)X .1 .2 Abbrev    !* Expunge abbrev.!
 m(m.mKill Variable)X .1 .2-WABMAC Abbrev	!* And any hook on it.!
 1uWord Abbrevs Modified

 0fo..qLately Changed Abbrevsf"ew :i*'u.4	!* .4: Incremental abbrevs.!
 @:i*|.4
mkX .1 .2-WABMAC Abbrev
mkX .1 .2 Abbrev| m.vLately Changed Abbrevsw
					!* Add an incremental.  K will be!
					!* bound to Kill Variable in the!
					!* file.!
 w 1 

!^R Kill Global Word Abbrev:! !^R Remove the definition for one abbrev.
Same as ^R Add Global Word Abbrev with a negative numeric
    argument.!
 1, m(m.m& Read Line)Kill Global Abbrev: [.1	    !* .1: Abbrev.!
 q.1"E '			    !* Abort.!
 0fo..qX .1 * Abbrev"E	    !* No such.!
    FG @ft".1" is not a global abbrev.	!* so tell him!
    0fsEchoActivew 1  !''! '		!* and let it stay on the screen!
 m(m.mKill Variable)X .1 * Abbrev	!* Expunge abbrev.!
 m(m.mKill Variable)X .1 *-WABMAC Abbrev	!* And any hook on it.!
 1uWord Abbrevs Modified

 0fo..qLately Changed Abbrevsf"ew :i*'u.4	!* .4: Incremental abbrevs.!
 @:i*|.4
mkX .1 *-WABMAC Abbrev
mkX .1 * Abbrev| m.vLately Changed Abbrevsw
				    !* Add an incremental.  K will be bound to!
				    !* Kill Variable in the file.!
 w 1 

!& Add Word Abbrev:! !S Reads an abbrev for words before point.
Stringarg1 is "*" for global abbrev, and space-modename for a mode
    abbrev, e.g. " TECO".
Stringarg2 is & Read Line prompt.
Calls & Read Line to read the abbrev.
ARG non-0 means expansion is last ARG words.  (Includes breaks in
    between words, but not those before first or after last word.)
ARG 0 means expansion is between point and MARK.
If fs^RMark set, then for any ARG expansion between . and fs^RMark.
If the abbrev is already defined, user is asked if redefinition
    wanted.
The abbrev must not contain any break characters.
Abbrev variable is constructed: X abbreviation <mode/*> Abbrev.  Its
    value is a string which is the expansion.!
 :i* [.2			    !* .2: Modename part of varname.!
 [.3[.4[.5.[.6 fnq.6j		    !* .6: Auto-restoring point.!

 1:<fs^RMark+1f"G-1 u.3 1;'	    !* FS ^R Mark$ set, use that to point.!
    "E .(:f(j)u.3)j 1;'	    !* ARG=0, use MARK and validate.!
    "N -fwl .u.3 fwl 1;'	    !* ARG non-0, use last ARG words.!
    >"N FG F*w 1 '	    !* No expansion found.!
				    !* .3: expansion start.!
 Q.3,. f x.3			    !* .3: expansion.!
 m.m& Shorten String[S		    !* S: & Shorten String.!
 m.m& Read Line[R		    !* R: & Read Line.!
 q.3mSu.4			    !* .4: Short expansion string.!
 1,mR for ".4": [.1 !''!   !* .1: Abbrev.!
 q.1"E 1 '			    !* Abort.!

 q.1,q.3 m(m.m& Check And Make Word Abbrev).2   !* Define.!
 1 

!& Check And Make Word Abbrev:! !S Basic definer subroutine.
Pre-comma numeric argument is abbrev.
Post-comma numeric argument is expansion.
String argument is "*" or modename.
Checks for break characters in abbrev (not allowed).!

 m(m.m& Declare Load-Time Defaults)
    Word Abbrevs Modified, Non0 means definitions have changed: 0
    Last Word Abbrev Defined, Variable name: 0


 :i*[2 [1 [3		    !* 1,2,3: abbrev, mode, expansion.!
 :iLast Word Abbrev DefinedX 1 2 Abbrev
 q1[4 [5			    !* 4: Abbrev copy, for letter checking.!
 fq1< 0,1:g4u5			    !* 5: 1st char in rest of abbrev copy.!
       5"b fg @ft
Break chars not allowed in abbrev 0fsEchoActivew 1 '
       1,fq4:g4u4>		    !* 4: Each iter, chop off one letter.!

 m.m& Shorten String[S		    !* S: & Shorten String.!

 0fo..qX 1 2 Abbrevu4	    !* 4: 0 or old expansion.!
 q4"N f=34"N FG		    !* Already defined, ask confirm.!
	 q4mSu4			    !* 4: short form of old expansion.!
	 @ftRedefine "1" from "4"?  !''''!	    !* ...!
	 1m(m.m& Yes or No)"E @ftNot redefined.   !* tell him!
	      0fsEchoActivew 1 ''	    !* dont flush the message!
       "# @ftAlready so defined.   !* tell him, and!
	  0fsEchoActivew 1 ''    !* Dont reset usage-count.!

 q3m.vX 1 2 Abbrevw	    !* Define expansion.!
 m.cX 1 2 Abbrev0		    !* Set usage-count comment string.!
 1uWord Abbrevs Modified

 f[BBind				!* Temporary buffer.!
 0fo..qLately Changed Abbrevsf"ew :i*'u4	!* 4: incrementals.!
 g4					!* Get previous incrementals.!
 @i|
mvX 1 2 Abbrev|		!* Up to where expansion goes.!
					!* V will be bound to & Make Non-Usage!
					!* Abbrev Variable in the file.!
 .(g3)j					!* Get expansion, point before.!
 0s <:s; r i c>		!* Teco-quote altmodes and C-]s.!
 zj @i|0|				!* Finish off the incremental.!
					!* Note that the usage count is a fake!
					!* -- seems not possible to do right!
					!* for incrementals.!
 hx*m.vLately Changed Abbrevsw		!* Save the incrementals.!
 

!Edit Word Abbrevs:! !C Allow user to edit the list of defined word abbrevs.
Note that any '"'s are doubled so that the syntax is unambiguous.
    E.g.  if the abbrev 'xsay' is to expand to 'He said "Hello".',
    then it will be:
	xsay: 	1	"He said ""Hello""."
A recursive edit level is entered.  When exited by ^R Exit the
	buffer will be considered as new definitions of all word
	abbrevs.  Any abbrevs missing from the list will be killed.
Abort Recursive Edit will abort M-X Edit Word Abbrevs, leaving
	word abbrevs untouched.!

 fq(:i*)"g				!* We do not edit just some.!
    :i*C fsEchoDisplayw		!* So clear the echo area,!
    @ftWarning: M-X Edit Word Abbrevs ignores its string argument --
it does not filter.  All abbrevs are being edited.	!* ...!
    0fsEchoActivew'			!* ...!

 0[..f					!* Disallow file hacking.!
 f[BBind				!* Get a temp buffer, !
 m(m.mInsert Word Abbrevs) bj		!* ...and set up list to edit.!
 :i*Edit Word Abbrevs[..J		!* Set mode line.!

 !* The iteration/error-catch is so that if the user gets an error in!
 !* Define Word Abbrevs, the user will stay editing the abbrevs, so can!
 !* correct incrementally -- rather than having one error force the!
 !* entire edit again.!

 f<!DoneEditWordAbbrevs!		!* Throw out when successfully!
					!* defined.!
    					!* Let user edit.!
    1@:<				!* Catch errors after reporting them.!
	1,m(m.mDefine Word Abbrevs)	!* Define new ones from buffer list.!
					!* If that gets an error, we will!
					!* iterate.!
	f;DoneEditWordAbbrevs >w	!* But if successful, exit.!
    >					!* ...!

 fsEchoDisplayw CfsEchoDisplayw	!* Clear echo area.!
 @ftWord abbrevs redefined.		!* Tell user.!
 0fsEchoActivew			!* Dont clear echo area after.!
 1

!List Word Abbrevs:! !C Print some or all word abbrev definitions.
Lists a table of word abbrev definitions for currently defined
    abbrevs.
If string argument is null, all abbrevs are listed.
If there is a string argument, it filters which abbrevs' definitions
    are listed.  (Actually, it is a TECO search string.)  If the
    abbrev, its mode, or its expansion contains the filter that
    definition is listed.
Giving a numeric argument will control what the filter applies to:
	0 or 7 (same as no argument): abbrev, mode, or expansion
	1: abbrev only
	2: expansion only
	4: mode only
Combinations by summing the above -- e.g. 3 means abbrev or expansion,
    but not mode.!

 f[BBind				!* Temporary buffer to insert into.!
 :ftabbrev:	(mode)	count	"expansion"

					!* Print header.!
 1,(f)m(m.mInsert Word Abbrevs)
					!* Insert them, listing as go.  Pass!
					!* along any argument and filter.!
 fsListen"e ftDone.
'"# ftFlushed.
'					!* Tell user we are done, how.!
 1

!Insert Word Abbrevs:! !C Insert a list of some or all word abbrev definitions.
Inserts a table of word abbrev definitions for some or all of the
    currently defined abbrevs.  Format is that used by M-X List Word
    Abbrevs and M-X Edit Word Abbrevs.
If string argument is null, all abbrevs are inserted.
If there is a string argument, it filters which abbrevs' definitions
    are inserted.  (Actually, it is a TECO search string.)  If the
    abbrev, its mode, or its expansion contains the filter, that
    definition is inserted.
Giving a numeric argument will control what the filter applies to:
	0 or 7 (same as no argument): abbrev, mode, or expansion
	1: abbrev only
	2: expansion only
	4: mode only
    Combinations by summing the above -- e.g. 3 means abbrev or
    expansion, but not mode.
Extension writers: giving a 1 pre-comma argument causes the
    definitions to be listed as they are inserted.!

 [1[2[3[4[5[6[7 [9 1,fInsert abbrevs matching: f"e'[0

					!* 0: Match string.!
 fq0"g 0s0'"# 0u0'			!* 0: 0 if no filter.  Else!
					!* set search default here.!
 f"n&7'"#w 7'u1			!* 1: Bits, non-0.!
 .f[VB fsZ-.f[VZ			!* Narrow bounds.!

 "n m.m& Maybe Flush Output[A'	!* A: Flusher needed if typing as we!
					!* go.!

 :fo..qX  u9 q9"l -q9u9'		!* 9: ..Q index to first!
					!* abbrev.!


 fq..q/5-q9/(q:..q(0))(			!* Number of slots to examine.!
    q9-1u9				!* 9: Start back one word.!
    )<					!* Iterate over variables.!

	q:..q(%9)u2			!* 2: Next variables name.!
	q:..q(%9)u3			!* 3: Its value.!
	q:..q(%9)u4			!* 4: Its comment.!

	.u5				!* 5: Start of abbrev insert.!

	q3fp"l oNEXT'			!* Skip variable if numeric value.!
					!* E.g. may be a local abbrev in!
					!* another buffer.  Or just broken.!

	g2				!* Insert variable name.!
	-7 f~ Abbrev"n oNEXT' -7d	!* Skip if not abbrev.!
	q5j 2 f~X "n oNEXT' 2d	!* ...!

	@:f l d .u6			!* 6: Point between abbrev, mode.!

	zj .u7 g3			!* 7: Point between mode, expansion.!
					!* Insert value string.!

	q0"n				!* Must filter this abbrev.!
	  q1&1"n q5,q6:fb"l oINS''	!* Bit 1 -- filter abbrev.!
	  q1&2"n q7,z:fb"l oINS''	!* Bit 2 -- filter expansion.!
	  q1&4"n q6,q7:fb"l oINS''	!* Bit 3 -- filter mode.!
	  oNEXT'			!* Filter failed -- skip abbrev.!

	!INS!				!* Now we are sure we insert this!
					!* abbrevs definition.  Must prettify!
					!* the junk inserted so far.!

	q6j				!* To end of abbrev.!
	.,q7f=*"e			!* Global abbrev.!
	  d i:		'		!* ..!
	"# q7-zu7			!* 7: Z-relative point now, between!
					!* mode and expansion.!
	   i:	(			!* Separate abbrev, mode.!
	   q7+zj i)	'		!* Separate mode, count.!
	g4				!* Get comment -- usage count or sharp!
					!* if WABMAC.!
	i	"			!* Separate count, expansion.!
	<@:f"l .-z; i" c>		!* Double all double quotes in the!
					!* expansion.!
	i"
	!''''!				!* Terminate the expansion, finishing!
					!* the definition for this abbrev.!

	"n				!* Pre-comma NUMARG means type out as!
					!* go and flush if typeahead.!
	    q5,.t'			!* Type now, flush later.!

	.u5				!* 5: Set so the q5,zk is no-op.!


	!NEXT!				!* Some jump here to skip an abbrev.!

	q5,zk				!* Kill garbage if skipping.!
	"n ma1;'			!* Abort if typeahead.  Done here so!
					!* will flush as soon as user types --!
					!* if did it when type, would be long!
					!* wait until a filtered abbrev,!
					!* perhaps.!

	>				!* On to next variable.!

 h					!* Return bounds of inserted!
					!* definitions.!

!Kill All Word Abbrevs:! !C Kill all abbrev definitions, leaving a blank slate.
It is as if you had not read or defined any word abbrevs.!
!* For use in conjunction with editing what M-X Insert Word Abbrevs inserts,
    and then after M-X Kill All..., doing M-X Define Word Abbrevs.
    Or just something user might want (I do at times).!

 [.1[.2[.3
 q..q[..o zj			    !* Buffer: symbol table.!
 				    !* Will go thru symtab backwards looking!
				    !* for word abbrev variables.!

 :f<!DONE! 15r			    !* At a variable entry.!
    1<				    !* COND.!
       0,2:g(.fsWord)u.3	    !* .3: 1st 2 letters of varname.!
       f~.3X f"N "L f;DONE'	    !* Past abbrevs, done.!
		  1;'		    !* Not abbrev, skip.!
       .fsWordu.3		    !* .3: Variable name.!
       .+5fsWordu.2		    !* .2: Value.!
       q.2fp:;			    !* Value is number, skip this abbrev.!
       fq.3-7,fq.3 :g.3 u.3	    !* .3: Last 7 letters of name.!
       f~.3 Abbrev"E 15d'	    !* This is an abbrev variable, kill it.!
       >			    !* End of COND.!
    >				    !* End of iter over all entries.!

 0uWord Abbrevs Modified		!* Since as if never defined any!
					!* abbrevs, they are therefore not!
					!* modified yet.!
 :i*m.vLately Changed Abbrevsw	!* And no incrementals.!
 

!Read Word Abbrev File:! !C Define word abbrevs from an abbrev definition file.
Stringarg is word abbrev definition file.
Default is <homedir>;WORDAB DEFNS.
File may be in default fast-loading foramt or human-readable format.
This will not complain if the file does not exist.!


 f[DFile 1f[FnamSyntax		!* Save default filename *!
 0fo..qLast Word Abbrev Filef"n fsDFilew'	!* Either last-used or *!
 "#w etDSK:WORDAB DEFNS fsHSnamefsDSnamew'	!* else a default. *!
 4,4fWord Abbrev Filef"ew'fsDFilew	!* Read string argument *!
 fsDFilem.vLast Word Abbrev Filew	!* save for defaulting *!
 e?"n '				!* Exit if file not found, quietly.!
 f[BBind er @y			!* Read in QWABL file. *!

 !* See if human-readable format definition file: !

 10 f~m.m& Make "n			!* All QWABL files start that way, and!
					!* no Define Word Abbrevs type can.!
    :m(m.mDefine Word Abbrevs)'	!* Is user-readable kind, define from!
					!* it, the slow way.!

 !* The file is in the QWABL style: !

  m(hx*)				!* Define by running buffer since!
					!* QWABL files are just big Teco!
					!* macros that define the abbrevs.!
	!* This used to be m..o but sometimes Teco seems to have trouble --!
	!* rare but strange when it happens, e.g.  seeming to get the wrong!
	!* start PC or something.!

 					!* Make sure we pop things.!

!Write Word Abbrev File:! !C Write all the current abbrev definitions to a file.
Stringarg filename.  Default is WORDAB DEFNS.
Argument present means do not write out usage counts.
Normally writes a fast-loading format file, but if you have the
    Readable Word Abbrev Files option variable set to 1, it will write
    a human-readable format file (like that used by
    List Word Abbrevs).
Default filenames come from last definition filename used.!

 m(m.m& Declare Load-Time Defaults)
    Readable Word Abbrev Files, * Non-0 means write human-readable kind: 0

 [.0[.1[.2[.3[.4[.5 f[DFile	    !* save regs!
 1f[FnamSyntax			    !* Lone fn is first fn. *!
 0fo..qLast Word Abbrev Filef"n fsDFilew'
 "#w etDSK:WORDAB DEFNS fsHSnamefsDSnamew'
 4,1fWord Abbrev Filef"ew'u.0	!* Read string argument *!
 et.0 fsDFileu.0		    !* .0: Set default fn. *!
 q.0m.vLast Word Abbrev Filew	    !* Save for next time. *!

 f[BBind			    !* Temp buffer. *!

 qReadable Word Abbrev Files"n	!* User wants readable kind.!
    m(m.mInsert Word Abbrevs)		!* Make a list of that kind.!
    oWRITE'				!* Go write them out.!

 :fo..qX  u.2			    !* .2: $X ^@$ offset, before any abbrevs.!
 q.2"L -q.2u.2'			    !* .2: $X ^@$ offset, positive.!
				    !* .2: Running ..Q index for abbrevs.!
 ff&1"E			    !* QWABL file has usage counts. *!
  @i|m.m& Make Usage Abbrev Variable[V	    !* V: Will be variable-maker. *!
|'"#				    !* QWABL file has no usage counts. *!
  @i|m.m& Make Non-Usage Abbrev Variable[V !* V: Will be variable-maker. *!
|'
 iq..q[..o			    !* Will select symtab buffer. *!

 0s				!* Search default, used for!
					!* quoting Alts and C-]s.!
 fq..q/5-q.2/3(			    !* Number of var slots to examine in ..Q.!
 q.2-1u.2			    !* .2: Start ..Q - 1.!
  )< q:..Q(%.2)u.3		    !* .3: Next variable name.!
     q:..Q(%.2)u.4		    !* .4: Next variable value.!
     q:..Q(%.2)u.5		    !* .5: Next variable comment.!
     q.4fp"L oNEXT'		    !* Skip variable if value is number.!
				    !* (Local vars become 0 when not in their!
				    !* buffer.)!
     f~(0,2:g.3)X "N oNEXT'	    !* Skip this variable if not $X ...$, !
     f~(fq.3-7,fq.3:g.3) Abbrev"N oNEXT'	!* ...or if not $... Abbrev$.!
     iMV.3			!* Insert var-maker call, varname. *!

     .(g.4)j <:s; r i c> zj i	!* Insert expansion and Teco-quote any!
					!* Altmodes or C-]s in it.!

     ff&1"E g.5 i'		!* Insert usage if no argument or only!
					!* pre-comma argument.!
     i
					!* Finish this definition.!

     !NEXT! >				!* Repeat for next variable.!

 !WRITE!

 eihpef.0				!* Write it out.!
 er fsIFileu.0 ec @ft
Written: .0
					!* Tell user the full filename.!
 0uWord Abbrevs Modified		!* Abbrevs no longer modified with!
					!* respect to save files.!
 0fsEchoActivew 1 

!Write Incremental Word Abbrev File:! !C Write abbrevs defined/changed since dumping this environment.
Writes to file named by string argument.  Defaults to home directory,
    INCABS > (INCABS..0 on Twenex.).
This command is used by people with a large number of abbrevs, and who
    dump their environments.  The init file should generally use M-X
    Write Word Abbrev File, and the & Startup... should use
    M-X Read Incremental Word Abbrev File.!

!* (This does not reset the default filename for M-X Write Word Abbrev
    File and Read Word Abbrev File.  I'm not sure of the correctness
    of this, though.)!

 m(m.m& Declare Load-Time Defaults)
    Word Abbrevs Modified, Non0 means definitions have changed: 0


 [1
 e[e\ fne^e] f[DFile 1f[FNamSyntax	    !* Save I/O channels, filename.!
 etDSK: fsHSNamefsDSNamew etINCABS >    !* Default to home directory.!
 4,1fIncremental Filef"e w'u1	    !* Read string argument *!

 f[BBind				!* Temporary buffer.!
 g(0fo..qLately Changed Abbrevsf"ew :i*')	!* Get incrementals, which are!
						!* teco commands.!
 z"e :i*No incremental abbrevs to write fsErr'    !* Better to err than!
				    !* print a message, since more useable!
				    !* by other commands.!
 !* Put the file-header on, which will bind QV and QK, as well as select the!
 !* symbol table buffer.  Keep this header as two lines, for possible back!
 !* compatibility to Lisp Machine usage.  (Ugh...  Still necessary/)!

 j @i|m.m& Make Non-Usage Abbrev Variable[V q..q[..o
m.mKill Variable[K
|					!* Were no incrementals.!

 eihpef1				!* Write to filename STRARG.!
 er fsIFileu1 ec @ft
Written: 1

 0uWord Abbrevs Modified		!* No longer modified with respect!
					!* to save files.!
 0fsEchoActivew 1

!Read Incremental Word Abbrev File:! !C Define abbrevs changed since dumping.
String argument is filename that contains incremental abbrev
    definitions, written by M-X Write Incremental Word Abbrev
    File.  Default is home directory, INCABS >.
This command is used by people with a large number of abbrevs, and who
    dump their environments.  The init file should generally use M-X Write
    Word Abbrev File, and the & Startup... should use this function.
This will not complain if the file does not exist.!

!* (This does not reset the default filename for M-X Write Word Abbrev
    File and M-X Read Word Abbrev File.  I'm not sure of this, but it
    seems correct.)!

 [1 f[DFile				!* Save default fielname *!
 e[ fne] f[DFile 1f[FNamSyntax	!* Save input channel, filename.!
 etDSK: fsHSNamefsDSNamew etINCABS >	!* Default to home directory.!
 4,4fIncremental word abbrev filef"e w'u1	!* Read string argument *!
 et1					!* Set default from argument *!
 e?"e					!* File exists.!
    f[BBindw er @y			!* Read in QWABL file. *!
    j @:i1|m.m& Make Non-Usage Abbrev Variable[V q..q[..o
m.mKill Variable[K
|					!* 1: Header lines (new type).!
    fq1 f=1"e fq1c'"# g1'		!* Past header lines if there.!
					!* Doesnt really matter though, and!
					!* old-style ones are ok to keep on.!
					!* Just is less junk to keep in!
					!* variable, and Write Incremental!
					!* Word Abbrev File will add it on!
					!* anyway.!
    .,zx*m.vLately Changed Abbrevsw	!* Save the incls.!
    m(hx*)'				!* Define and kill abbrevs by running!
					!* buffer.!
	!* This used to be m..o but sometimes Teco seems to have trouble --!
	!* rare but strange when it happens, e.g.  seeming to get the wrong!
	!* start PC or something.!

 

!& Make Usage Abbrev Variable:! !S Like .V and .C combined, for speed.
STRARG1 is abbrev variable name.
STRARG2 is abbrev expansion with altmodes, ^]s quoted with ^]s.
STRARG3 is usage-count string.
Assumes ..Q is selected as buffer (..O).!
 :i*[.1			    !* .1: Abbrev varname. *!
 :i*[.2			    !* .2: Abbrev expansion. *!
 :i*[.0			    !* .0: Usage count string. *!
 :FO..Q.1[.3		    !* .3: Variable index. *!
 Q.3"L -Q.3*5J 15,0I 15R q.1,.FSWORDW 0,.+10FSWORDW	    !* .3 neg *!
       -Q.3U.3'			    !* .3: Pos index. *!
 q.3+1*5j q.2,.fswordw		    !* Stick in expansion string. *!
 5c q.0,.fswordw 		    !* Stick in usage count string. *!

!& Make Non-Usage Abbrev Variable:! !S Like .V and .C combined,
but faster.
STRARG1 is abbrev variable name string.
STRARG2 is abbrev expansion string.
Assumes ..Q is selected as buffer (..O).!
 :i*[.1			    !* .1: Abbrev varname. *!
 :i*[.2			    !* .2: Abbrev expansion. *!
 :FO..Q.1[.3		    !* .3: Variable index. *!
 Q.3"L -Q.3*5J 15,0I 15R q.1,.FSWORDW 0,.+10FSWORDW	    !* .3 neg *!
       -Q.3U.3'			    !* .3: Pos index. *!
 q.3+1*5j q.2,.fswordw		    !* Stick in expansion string. *!
 

!Attach Word Abbrev Keyboard Macro:! !C Abbrev will run a macro after expanding.
The last keyboard macro defined is attached to a word abbrev as its
    word abbrev hook.  Just after that abbrev expands, this hook is
    executed.
BE CAREFUL  -- keyboard macro attachment is not always
    well-defined, due to some strange Teco effects.  Not everything
    works that "ought to".
First string argument is abbrev to attach it to.  If null, the last
    one defined is used.
Second string argument is mode (null means use current mode).  Use "*"
    if you mean to attach it to a global abbrev.  If you are attaching
    to the last defined abbrev, you can use anything for this string
    argument.
Note that word abbrev hooks will be saved by M-X Write Word Abbrev
    File and M-X Write Incremental Word Abbrev File, just like normal
    abbrevs.  Also, they appear in definition listings (e.g. by M-X
    List Word Abbrevs or M-X Edit Word Abbrevs) in pairs, such as the
    following:
textmode:		#0	"-*-Text-*-"
textmode: (*-WABMAC)	0	"m(m.mText Mode)"!

 [1[2[3[4
 qModeu2				!* 2: Current mode.!
 1,fAbbrev: u1			!* 1: Abbrev.!
 1,fMode (2): u3			!* 3: Mode specified.!
 fq3"n q3u2'				!* 2: Mode to use.!
 :fo..qLast Kbd Macro"e :i*No last keyboard macrofsErr'
 qLast Kbd Macrou4			!* 4: Last keyboard macro string.!
 m(m.m& Attach Word Abbrev Hook)124
 

!& Attach Word Abbrev Hook:! !S Put some Teco code on a word abbrev.
The first string argument is the abbrev, second is mode name (or "*"
    for global abbrev).  Given null abbrev, we use the last defined.
The third string argument is a hook to call after expanding that
    abbrev.
Note that word abbrev hooks get saved in incremental and full files,
    just like normal abbrevs.!

 m(m.m& Declare Load-Time Defaults)
    Word Abbrevs Modified, Non0 means definitions have changed: 0
    Last Word Abbrev Defined, Variable name: 0


 [1[2[3[4[5
 :i*( :i*( :i3 )u2 )u1	!* 1,2,3: abbrev, mode, hook.!
 f[BBind				!* Temporary buffer, accumulates!
					!* incremental definitions.!

 fq1"e qLast Word Abbrev Definedf"ew :i*No last word abbrevfsErr'u1
       2,32f1u2			!* 2: Position of abbrev end.!
       2,q2:g1(				!* Just the abbrev.!
	q2+1,fq1-7:g1u2			!* 2: Mode name.!
	)u1'				!* 1: Just the abbrev.!

 :fo..qX 1 2 Abbrevu4		!* 4: ..Q index for abbrev.!
 q4"l					!* No such existing abbrev.!
    :i*CfsEchoDisplayw		!* Clear echo are.!
    q2u5 f=5*"e :i5global'		!* 5: Better for error message.!
    "#					!* Was modal -- see if user!
					!* meant the global version.!
      :fo..qX 1 * Abbrev"g		!* Aha, the global one exists.!
	@ft1 is not a 2 abbrev.  Did you mean global? 	!* ...!
	1m(m.m& Yes or No)"n :i2* oOK'''	!* Yes.!

    @ft1 is not a 5 abbrev.  Want to define it? 	!* Prompt.!
    1m(m.m& Yes or No)"e '		!* No.!
    1,m(m.m& Read Line)Expansion for 5 abbrev 1: f"e'u5
					!* 5: New expansion.!
    q5m.cX 1 2 Abbrev0w		!* Define the abbrev.!
    i
mvX 1 2 Abbrev		!* Up to expansion.!
    .(g5)j <:s;ric>	!* Teco-quote , C-]s.!
    zj i0'			!* Finish the incremental.!

 !OK!

 !* This next must be M.V not M.C since M.C would not redefine it, and!
 !* we want to allow redifining these.!

 q3m.vX 1 2-WABMAC Abbrevw		!* Make the corresponding abbrev that!
					!* carries the hook as its expansion.!
 m.cX 1 2-WABMAC Abbrev0w		!* Make sure it has a usage count.!
 m.cX 1 2 Abbrev#0w		!* Set the usage count to indicate a!
					!* word abbrev hook.!
 i
mvX 1 2-WABMAC Abbrev		!* Incremental up to expansion.!
 .(g3)j <:s;ric>		!* Teco-quote s, C-]s.!
 zj i0
m.cX 1 2 Abbrev#0w		!* Finish the incrementals.!

 j g(0fo..qLately Changed Abbrevsf"ew :i*')	!* Append our incrementals to!
						!* the old ones.!
 hx*m.vLately Changed Abbrevsw		!* Put the bunch back.!
 1uWord Abbrevs Modified		!* They need saving now.!

 

!& WRDAB Old Char Describe:! !S Tell what a character does after expanding.!
!*  Called by WORDAB "active documentation", with the arguments passed by
    Described modified slightly by F*0+n, where n becomes our
    post-comma, and any pre-comma is passed to us from Describe.
Post-comma numeric argument tells which caller:
	0: ^R Abbrev Expand And Self-Insert
	1: ^R Abbrev Expand And Call Old Char
	2: ^R Abbrev Expand for Tab
Pre-comma numeric argument:
	none: no character being described, we just return.
	string: q-register name.  If not a 9-bit q-register we return.
	9-bit: we describe the old function.!

 [0[1[P
 ff&2"e '				!* Just return if no character!
					!* given to us.!
 u0					!* 0: 9-bit or q-register name.!
 fp:"l 1:<f0u0>"n ''		!* 0: Q-register to 9-bit, or if!
					!* cannot, just return.!

 "e Afs^RInitu1'			!* 1: Old function is self-inserter.!
 -1"e	8[..e q0:\u1 ]..e		!* 1: Code as octal string.!
	qWRDAB Old 1u1'		!* 1: Old function.!
 -2"e	qWRDAB Old 11u1'		!* 1: Function run after Tab.!

 ftAfter possibly expanding, it 	!* Note that they wont print the!
					!* character name again.!

 !* Temporarily bind key to the old thing so M-? will describe it!
 !* correctly -- e.g. even if it is a previx dispatcher, in which case!
 !* it looks at the keys binding.!

 q1,q0f[^RCMacro			!* Will be bound back when done.!
 q0,q1:m(m.m^R Describe)

!& WRDAB Process Options Hook:! !S Check for characters to change.
Calls a subroutine to see-if/do any expand characters need updating.!
!* Is a little slow for someone who makes Word Abbrev Mode local.  Could fix.!
!* Note the s used below to bound the WORDAB Ins Chars string value.!
 m(m.m& Declare Load-Time Defaults)
    WORDAB Ins Chars, Self-inserting expanders: !~@#;$%^&*-_=+[]()\|:`"'{},<.>/? 

    WORDAB Old Chars, Hairy expanders: ||


 [.0[.1[.6[.7[.8 Afs^RInit[.2	!* .2: Self-inserter, used by checkers!
					!* and turn-offers.!
 m.m^R Abbrev Expand for Tabu.0	!* .0: Tab expander.!
 0fo..qWord Abbrev Mode"n		!* word abbrev mode?!
   !* Recursive edit levels are tricky:  we cannot bind new expanders there,!
   !* without having old-vars which are separate by level, e.g. using the!
   !* variable WRDAB Old [1] 40 for a level-1 binding.  Otherwise, rebinding!
   !* in a recursive level will destroy the lower levels old-var, if any.!
   !* This scheme is complicated to implement, so I will not bother, but!
   !* instead just disallow binding in a recursive level.  However, unbinding!
   !* should be handled, in case the user turns word abbrev mode off.!
   0:g..j-["e				!* We are in a recursive level.!
      :i.0'				!* .0: A null macro -- no check/bind.!
   "# qI-q.0"n			!* Not rec-level.  Turn on Tab?!
       f~I!^R Abbrev Expand -19"n	!* Be sure -- e.g. WORDAB might be!
					!* loaded twice, or test-loaded.!
        qIm(m(m.m& Global or Local)I)WRDAB Old 11 !* Yes, save old tab!
		      !* in either global (using .V) or local (using .L) var.!
	q.0uI''			!* and set it to tab expander.!
      m.m& WRDAB On PO Checku.0'	!* .0: Checker loop.!
   m.m& WRDAB Turn On Ins Charu.7	!* .7: Turn on ins.!
   m.m& WRDAB Turn On Old Charu.8'	!* .8: Turn on old.!
 "# qI-q.0"E				!* WAM off.  Must turn off Tab?!
       qWRDAB Old 11uI'		!* Yes.!
    m.m& WRDAB Off PO Checku.0		!* .0: Checker loop.!
    m.m& WRDAB Turn Off Ins Charu.7	!* .7: Turn off ins.!
    m.m& WRDAB Turn Off Old Charu.8	!* .8: Turn off old.!
    '					!* End WAM off conditional.!
 qWORDAB Ins Charsu.1			!* .1: inserting breaks.!

 m.m^R Abbrev Expand And Self-Insertu.6	!* .6: ^R Ins!
 m.0					!* Check them, fix.!

 qWORDAB Old Charsu.1			!* .1: Call-old breaks.!
 m.m^R Abbrev Expand And Call Old Charu.6	!* .6: Old Char!
 q.8u.7					!* .7: Old version for m.0.!
 m.0					!* Check them, fix.!

 

!& WRDAB Off PO Check:! !S Check list of chars for expanders, fix.
q.1:    List of characters.
q.6:    ^R Macro to check against.
q.7:    Subroutine to call if char runs .6.!
 -1[.4[.5			    !* .4: Index into .1.!
 < %.4-fq.1;			    !* Stop when done with .1.!
   q.4:g.1u.5			    !* .5: Charcode for next INS char.!
   q.5-q.6"E q.5m.7' >	    !* If same, fix it.!
 

!& WRDAB On PO Check:! !S Check list of expand characters for changes
q.1:    List of characters.
q.6:    ^R Macro to check against.
q.7:    Subroutine to call if change.!
 -1[.4[.5			    !* .4: Index into .1.!
 < %.4-fq.1;			    !* Stop when done with .1.!
   q.4:g.1u.5			    !* .5: Charcode for next INS char.!
   q.5-q.6"N q.5m.7' >	    !* If changed, fix it.!
 

!& WRDAB Turn On Ins Char:! !S Make a self-inserter expander.
Caller has .2 bound to self-inserter builtin.
Numeric argument: 9-bit of key to use.!
!*  If character does not run the self-inserting builtin routine,
it becomes a call-old expander, and character is moved from the
    variable WORDAB Ins Chars to WORDAB Old Chars.!
 !* Note the s used below to bound the WORDAB Ins Chars string value.!
 m(m.m& Declare Load-Time Defaults)
    WORDAB Ins Chars, Self-inserting expanders: !~@#;$%^&*-_=+[]()\|:`"'{},<.>/? 

    WORDAB Old Chars, Hairy expanders: ||


 [.0				    !* .0: Ascii for key.!
 q.0[.4			    !* .4: Keys macro.!
 q.4-q.2"e				!* It runs the self-inserter.!
    m.m^R Abbrev Expand And Self-Insertu.0   !* Set ins.!
    '				    !* And return.!

 !* Character does NOT run a self-inserter.  It might already be running an!
 !* expander.  Or if not, it will migrate to the call-old list.!

 q.4fp"g			    !* Cannot F~ a builtin, not a string.!
    f~.4!^R Abbrev Expand -19"e ''	    !* If already an expander, quit.!
				    !* (Works for uncompresseds too.)!
 qWORDAB Ins Chars[.1		    !* .1: $ins$!
 f.1[.2		    !* .2: Position in $ins$!
 0,q.2:g.1[.3			    !* .3: Ins chars before this one.!
 q.2+1,fq.1:g.1u.1		    !* .1: Ins chars after.!
 :iWORDAB Ins Chars.3.1  !* $ins$: Take out this char.!
 qWORDAB Old Charsu.1		    !* .1: $old$!
 :i.2				    !* .2: This char, string.!
 :iWORDAB Old Chars.1.2  !* $old$: Add this char.!

 m.m^R Abbrev Expand And Call Old Charu.0    !* Set key.!
 [.6 8[..e :\u.6 ]..e		    !* .6: Octal string for char.!
 q.4m(m(m.m& Global or Local).0)WRDAB Old .6
				    !* Yes, save old char in either global!
				    !* (using .V) or local (using .L) var.!
 

!& WRDAB Turn On Old Char:! !S Make a call-old expander.
Numeric argument: 9-bit of key to use.!

 [.0				    !* .0: Old char 9-bit.!
 q.0[.1			    !* .1: Old char macro.!
 q.1fp"G			    !* If not a builtin now, !
   f~.1!^R Abbrev Expand -19"E	    !* If already an  expander, !
     ''			    !* ...then quit while ahead.!
 m.m^R Abbrev Expand And Call Old Charu.0    !* Set key.!
 [.6 8[..e :\u.6 ]..e		    !* .6: Octal string for char.!
 q.1m(m(m.m& Global or Local).0)WRDAB Old .6
				    !* Yes, save old char in either global!
				    !* (using .V) or local (using .L) var.!
 

!& WRDAB Turn Off Ins Char:! !S Reset char ARG to @fs^RInit.!
 [.0				    !* .0: 9-bit.!
 @fs^RInitu.0 	    !* Reset.!

!& WRDAB Turn Off Old Char:! !S Reset char ARG to what was before.!
 [.6 8[..e :\u.6 ]..e		    !* .6 Octal string for char.!
 0fo..qWRDAB Old .6[.1	    !* .1: Maybe old char function.!
 [.2				    !* .2: 9-bit.!
 q.1u.2 		    !* Reset key.!

!& Global or Local:! !S Return Q.L or Q.V...
Returns Q.L if argument is a local q-register,  Q.V otherwise.!
 [1[2[3[9				!* save regs!
 [ -1:fsQPHome(]*w)u3		!* get home of our q-register argument!
 qBuffer Indexu9 q9+8u2		!* !
 q:.b(q9)-9/2u1				!* !
 q1< q:.b(%2)-q3"e q.L ' %2w >	!* if q-register is local then return!
					!* .L!
 q.V 					!* else return .V!

!& Shorten String:! !S Produce a short string, showing beginning/end.
Numeric argument is a string pointer.!
 [.3[.4[.5			    !* .3: Long ARG string.!
 fq.3-40"G			    !* If expan is long, only show part.!
    0,16:g.3u.4			    !* .4: first 16 letters of exp.!
    fq.3-16,fq.3:g.3u.5		    !* .5: last 16 letters.!
    :i.4.4.....5'	    !* .4: first and last 16 letters.!
 "# q.3u.4'			    !* .4: expan is short, whole expan.!
 q.4 				    !* Return short string.!

!* Following should be kept as (only) long comments so will be compressed out:
 * Local Modes:
 * Fill Column:78
 * End:
 *!
   
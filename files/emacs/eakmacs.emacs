!* -*-TECO-*-!

!~FILENAME~:! !EAK's personal EMACS environment!
EAKMACS

!& Setup EAKMACS Library:! !S Set flags, variables, and ^R characters
for EAKMACS environment.!

!* Set FS flags!
    1fsEchoErrorsw			!* display error msgs in echo area!
    1fsBothCasew			!* ignore case when searching!
    1fs^PCasew				!* sorting ignores case!
    0fs%Topw				!* allow cursor on 1st line!
    0fs%Bottomw			!* allow cursor on last line!
    60fs%Endw				!* !
    1fs^LInsertw			!* don't insert/delete last ^L!
    fsOSTeco"e -1fsFnamSyntaxw'	!* lone filename means FN >!
    "# 1fsFnamSyntaxw'			!* except on Twenex!

    m.m^^ TMACS Error Handleru..P	!* for better debugging!

!* Set variables!
    1		m.vLess Asking			!* no silly questions!
    2		m.vTags Find File		!* Have Tags use Find File!
    1		m.vFind File Inhibit Write	!* Don't use autowriteback!
    1		m.vFile Versions Kept		!* don't need two versions!
    :i*.?!	m.vFill Extra Space List	!* default is crufty!
    77		m.vFill Column			!* don't use linel for filling!
    0		uPermit Unmatched Paren	!* beep on umatched!
    :i*Babyl	m.vMail Reader Library		!* tell ^XR to use Babyl!
    -uSave Word Abbrevs		!* incremental saving!
    1uAuto Save Default		!* Auto Save on by default!
    m(m.m& Get Library Pointer)EMACSuz
    fsOSTeco-2"e 0,qzm.m& Read Filenamem.vMM & Read Filename'
    m.m& MIDAS Mode Hook	m.vMIDAS Mode Hook
    m.m& Text Mode Hook	m.vText Mode Hook
    m.m& LISP Mode Hook	m.vLISP Mode Hook
    m.m& TECO Mode Hook	m.vTECO Mode Hook
    m.m& Edit Picture Hook	m.vEdit Picture Hook
    @:i*|:m(m.m& Babyl R Done Hook)|m.vBabyl R Done Hook
    :i*/B			m.vSRCCOM switches
    fsOSTeco"e'			!* ITS!
    "#					!* TNX!
	:i*Earl Killian	m.vBabyl Personal Name'
    

!* Set ^R characters!
    m.m^R Execute Minibuffer		u	!* ESC is minibuffer!
    316.@fs^RInit			u.N	!* Use airless ^N!
    320.@fs^RInit			u.P	!* Use airless ^P!
    m.m^R Character Search		u.S	!* use simple search instead!
	q.Sm.vNon-VT52 Control-S
    m.m^R Reverse Character Search	u.R	!* of bletcherous i-search!
    m.m^R Next Several Screens		u.V	!* use winning ^V!
    m.m^R Prefix Meta			u.W	!* Put metizer on ^W!
    m.mAbort Recursive Edit		u.]	!* avoid question!
    m.m^R Argument			u..1	!* use new Meta argtizer!
	q..1u..2 q..1u..3 q..1u..4 q..1u..5
	q..1u..6 q..1u..7 q..1u..8 q..1u..9
	q..1u..0 q..1u..- q..1u..,
    m.m^R Just One Space		u.. w	!* winning Meta-Space!
    m.m^R String Search		u..S	!* string versions too!
    m.m^R Reverse String Search	u..R	!* ...!
    m.m^R Previous Several Screens	u..V	!* use winning M-V!
 fsOSTeco"e
    m.mCompile				u..Z	!* compile buffer!
    m.m^R Goto LISP			u...Z	!* create/continue LISP!
    '
    m.m^R Insert EMACS Function Name	u...M	!* !
    m.m^R Center Line			u...S	!* instead of M-S!
    m.mBuffer Menu	u:.x()	!* Use TMACS' !
    m.m^R Kill Region		u:.x()	!* ^X^K is replacement for ^W!
    m.m^R Down Real Line	u:.x()	!* move EMACS' ^N to ^X^N!
    m.m^R Up Real Line		u:.x()	!* move EMACS' ^P to ^X^P!
m(m.mKill Variable)MM ^R Save File
    m.m^R Save File		u:.x()	!* auto-save version!
    m.m^R Examine Key		u:.x(E)	!* very handy!
m(m.mKill Variable)MM Kill Buffer	!* kill EMACS patch version!
    m.mKill Buffer		u:.x(K)	!* get own version!
    m.m^R Display Date and Timeu:.x(T)	!* I need a watch!
    m.m^R View Q-reg		u:.x(V)	!* very handy!

!* Set minor modes!
    1m(m.mAuto Fill Mode)		!* turn on Auto Fill Mode!
    1,1m(m.mWord Abbrev Mode)		!* turn on word abbrev mode!

    etDSK:EAK QWABL			!* create DSK:<hsname>;EAK QWABL!
    fsHSnamefsDSnamew fsDFile[1	!* ...!
    m(m.mRead Word Abbrev File)1	!* read word abbrevs!
    ]1

    :iEditor NameEAKMACS		!* set editor name!
    :i..JEAKMACS 			!* ...!

    1fsModeChangew			!* force mode line to be recomputed!
    

!& Startup EAKMACS:! !S Do startup type things!

    0fsQPUnwind			!* clear PDL!
    0u1					!* clear stupid version string in Q1!

    m.m^^ TTY InitfsTTYMacw		!* install function for initializing!
					!* after fsTTYInit!
    m(fsTTYMac)			!* and call it!

    fsOSTeco"n fsRgetty-3"e
	m.m^R VT52 Control-Su.S'	!* TNX VT52, use special  hack!
     "# qNon-VT52 Control-Su.S''	!* TNX non-VT52, use standard !

    0[1 0[2				!* no commands, no filename (yet)!

!* Interpret command line!
    hk fj 0,0a-3"e -d'			!* hack ^C at end of command string!
    "# 0,-1a-15."e -2d''		!* remove CRLF at end if any!
    j:s"n .,zfx1 -d'		!* check for commands to execute!
    z"n hfx2'		!* save file name specified for processing later!
    0fsModifiedw 0fsXModifiedw	!* mods we've made aren't real!

    etDSK:INCABS > fsHSNamefsDSNamew	!* if incremental word abbrevs!
    e?"e				!* exist then read them!
	ft-- Reading incremental word abbrev definitions --
					!* inform me though!
	m(m.mRead Incremental Word Abbrev File)INCABS >'	!* ...!

    etDSK:FILE >			!* set default filename!
    fsMSnamefsDSnamew			!* ...!

    fsXJname:f6[J			!* XJNAME!
    f=JLISPT"e				!* LISP inferior?!
	m(m.mLoad Library)LISPT	!* load LISPT libarary!
	0fsQPUnwind :m..l		!* that's it!
	'

    f=JMAILT"e				!* MAIL inferior?!
	m(m.mText Mode)		!* enter Text mode!
	q2"n 1,m(m.mVisit File)2w'	!* read in text so far!
	0fsQPUnwind :m..l		!* that's it!
	'

!* Type greeting message!
    [1[2[3[4				!* non-silent startup, save regs!
    fsVersion:\u1			!* get TECO version!
    qEMACS Version:\u2		!* get EMACS version!
    qEAKMACS Library Filenamef[DFile	!* get EAKMACS version!
    fsDVersion:\u3 f]DFile		!* ...!
    .(4,fsRuntime\ 3ri.),.+3fx4	!* get run time!
    ftTECO.1   EMACS.2   EAKMACS.3   Run = 4
   ]4]3]2]1 0fsModifiedw 0fsXModifiedw	!* restore regs!

    q2"n m(m.mFind File)2'		!* read file specified in command line!

    q1"n m1'				!* execute any commands specified!
    0fsQPUnwind :m..l			!* now act line G!

!^^ TTY Init:! !S Personal FS TTY MAC.!
 2fsEchoLinesw				!* 2 line echo area!
 1fs^HPrintw				!* BS's don't overstrike!
 1fs^MPrintw				!* CR's don't overstrike!
 1fsVerbosew				!* print full error messages!
!* FS TRUNCATE and FS SAIL are also reset by FS TTY INIT.!
 

!Generate EAKMACS:! !C Generate EAKMACS library file!
 f[DFile				!* save default filename!
 fsOSTeco"e				!* ITS!
    m(m.mGenerate Library)dsk:eak;eakpur >dsk:eak;eakmacemacs1;ivoryecc;fixlibemacs1;tmacsemacs1;wordabeak;auto-s
    '"#					!* Tnx!
    '
 

!Dump EAKMACS:! !C Dump the current environment to TS EAKMAC or EAKMACS.SAV!
 m(m.mLoad Library)PURIFY		!* get mmDump Environment!
 fsOSTeco"e				!* ITS!
    etDSK:TS EAKMAC			!* set filename for dump to!
    fsHSnamefsDSnamew			!* DSK:<hsname>;TS EAKMAC!
 '"#					!* Tnx!
    qEAKMACS Library FilenamefsDFilew	!* get EAKMACS version!
    f[DVersion				!* ...!
    fsOSTeco-1"e etDSK:EAKMACS.EXE'	!* set filename for dump to!
    "# etDSK:EAKMACS.SAV'		!* DSK:<hsname>EAKMACS.EXE.<version>!
    fsHSnamefsDSnamew			!* ...!
    f]DVersion				!* ...!
    '
 0fsTTYMacw				!* don't dump out with TTYMac nonzero!
					!* to avoid TECO trying to run!
					!* functions when the world is only!
					!* half in existance!
 0fsQPUnwind				!* flush stack!
 :m(m.mDump Environment)		!* create ..L and do @EJ!

!& MIDAS Mode Hook:! !S Hook to make Comment Begin be semicolon space.!
 1,(:i*; )m.lComment Begin		!* semicolon space is prettier!
 

!& Text Mode Hook:! !S Hook to set Fill Column to 65 for Text mode.!
 65m.lFill Column			!* leave some margin space!
 1uDisplay Matching Paren		!* turn on feature!

!& Scribe Mode Hook:! !S Hook to set Fill Column to 65 for Scribe mode.!
 65m.lFill Columnw

!& LISP Mode Hook:! !S Hook to set LISP special characters in ..D.!
 1,(:i*; )m.lComment Begin		!* semicolon space is prettier!
 48m.lComment Column			!* 56 leaves no room at all!
 

!& TECO Mode Hook:! !S Hook to set extra TECO mode characters.!
 m.q..D
 0fo..qTECO ..Df"nu..D'
 "#w :g..du..d 1m(m.m& Alter ..D)"(')[ ] 
     q..dm.vTECO ..D'
 1uDisplay Matching Paren		!* turn on feature!
 

!& Edit Picture Hook:! !S Hook to restore vertical ^N/^P.!
 m.m^R Down Real Line[.N
 m.m^R Up Real Line[.P
 :

!Kill Buffer:! !C Kill the buffer with specified name.
Takes name as a string (suffix) argument, or reads it from terminal.
Alternatively, the name (as string pointer) or the buffer
number may be given as a prefix argument.
If the buffer has changes in it, we offer to write it out.!

    [1[2[3				!* save regs!
    ff&1"n u1'			!* numeric arg is buffer to select!
    "# 1,fKill Buffer: u1'		!* Read name of buffer to kill!
    fq1"e mmm & Check Top Levelbuffers
	  qBuffer Nameu1'		!* Null string means current buffer!
    q1m(m.m& Find Buffer)u1		!* Get index in buffer table of this name!
    q:.b(q1+2)"n			!* If the buffer is visiting a file,!
      q:.b(q1+4)[..o			!* then select it!
      fsModified"n			!* to see if it needs to be written back!
        q:.b(q1+1)u2
        fsTypeout"l @' ft
Buffer 2 contains changes.  Write them out
	fsTypeout"l 1' m(m.m& Yes or No)"n
	  q:.b(q1+2)f[DFile
	  0[..f m(m.mWrite File) ]..f
	  f]DFile''
      ]..o'
    q:.b(q1)u2				!* Get length in words of entry!
    q1-qBuffer Index"e		!* Trying to kill the current buffer?!
      :i*m(m.mSelect Buffer)'		!* Yes, select a different one first!
    q:.b(q1+4)[..o 0fsReadOnlyw
    q..o(]..o)fsBKill			!* Kill the actual buffer (why wait for GC?)!
    10.f?				!* Also errs out if try to kill selected buffer!
    q.b[..o q1*5j q2*5d			!* Delete the entry from the table!
    qBuffer Index-q1f"g +q1-q2uBuffer Index'
    					!* If killed buffer preceded current!
					!* one, current index is changed!

!^R Goto LISP:! !^R Goto LISP job!
 f+ LISP 

!& Yes or No:! !S Read in a yes or no answer.
Returns -1 for yes, 0 for no.
Types "? " first.  Echoes the answer and then a CRLF.
An NUMARG of 1 means use the echo area.  -1 means don't echo.
A pre-comma NUMARG of 1, means any character other than Y or N should
    be returned as itself.!

 [1[2

 < +1"g "g @'ft (Yes or No)? '	!* Else just finish the callers prompt!
					!* if we are echoing.!
   :i2					!* 2: Initz accumulated answer.!
   < fiu1 q1-15.@;			!* 1: Next character.  Exit!
					!* iteration if Return.!
     q1-177."e fq2"g			!* Rubout.!
	   0,fq2-1:g2u2			!* Knock off one character of answer.!
	   +1"g "g :i*XfsEchoDisplay'	!* If echoing, erase it.!
		    "# :i*XfsMPDisplay'''	!* ...!
	!<!>'				!* Done processing rubout.!
     +1"g "g @'ft1'		!* Echo character.!
     :i221			!* And add it to the answer.!
     >					!* Done that character.!
   f~2Y"e :i22es +1"g "g @'ftes''	!* Y<cr> becomes Yes<cr>.!
   f~2N"e :i22o  +1"g "g @'fto''	!* N<cr> becomes No<cr>.!
   +1"g "g @'ft
'					!* Echo the Return.!
   f~2YES"e -1'			!* Return -1 for yes,!
   f~2NO"e 0'			!* 0 for no.!
   "n 0:g2:fc'			!* Or the 1st character if!
					!* supposed to return non-Y/N.!
   @fg >				!* Otherwise dont allow non-Y/N.!

!^R VT52 Control-S:! !^R Act like old ^S, more or less, but ignore ^S^Qs.
^S^Q is ignore.
^S^Vx becomes old^Sx.  Any other characters following are as if to old^S.
^Sx becomes old^Sx if x is not ^Q or ^V.!

 !* Old^S is in $Non-VT52 Control-S$. *!

 m.i :fi[1				!* 1: Next char after ^S!
 200.+Su..0				!* ..0: ^S, since .I smashes.  I.e.!
					!* simulate ^R calling the ^S!
 q1-"e fiw 1'			!* Gobble the ^Q!
 q1-"e fiw'				!* Gobble the ^V!
 f @mNon-VT52 Control-S 		!* Pass character or none to old C-S!

!* Following should be kept as long comments:
 * Local Modes:
 * Comment Column:40
 * End:
 * *!

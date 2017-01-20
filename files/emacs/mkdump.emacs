!*   -*-Teco-*-  !

!~FILENAME~:! !Dumped EMACS environments made easy.
Bugs/features to BUG-EMACS@MIT-AI.  Maintained by ECC@MIT-MC.!

MKDUMP				    !* Must be compressed with IVORY.!

!* Update History:

16-Oct-82 (55) (ECC) Removed old notice about name change.
19-Oct-81 (54) (ECC) Added the old name Prepare For Loading Libraries to
    <ENTRY>, so any remaining references to it will still work.  There seem to
    be a few.  Also changed & Setup.. to make an impure copy of our Load
    Library, in case this library is only temporarily loaded.  This should
    only affect the case where the library is loaded and then killed
    explicitly -- not temporarily loaded by Run Library, since <ENTRY> has
    always made an impure copy.  This change is necessary now that MKDUMP's
    version is no longer named Load Library -- it thus gets installed on the
    MM-variable.

 5-Feb-81 (50) (ECC) Startup made more in line with normal EMACS
    startup:  *Initialization* contains most of the startup code that used to
    be put in & Startup EMACS (e.g. calls the default init), while &
    Startup EMACS is something that goes into ^R using the standard fs^REnter
    (to be sure *Initialization* is called) and then jumps into the user's
    ..L.  Thus the startup sequence is (for default ..L, i.e. & Toplevel ^R,
    and for MKDUMP-created & Startup EMACS):
	1. PURIFY's Dump Environment-created ..L :EJs and then calls out &
	   Startup EMACS.
	2. & Startup EMACS goes into  using default fs^REnter.
	3. fs^REnter calls MKDUMP-created *Initialization*.
	4. *Initialization* resets timer, fsTTYMacro, etc. then (for
	   init-start) calls the default init which processes jcl etc.
	5. *Initialization* then exits ^R mode, back to & Startup EMACS.
	6. & Startup EMACS then restores user's fs^REnter and jumps off into
	   the user's ..L.  For the default, that is & Toplevel ^R.
	7. ..L (& Toplevel ^R) then goes into  and the user is editing.
    Things are unchanged, though, for users who provide their own & Startup
    EMACS.  It can go into ^R mode, call inits, or whatever it wants.

28-Nov-80 (45) Renamed: Dump My EMACS ==> Dump Emacs.  Flushed Dumped EMACS
    Startup Time.  Changed default dumped filename from MYEMACS to DEMACS.
    Gene was good enough to write an INFO node.  Fixed yet another bug whereby
    PURIFY was being incorrectly loaded by the dump.  Flushed the name Prepare
    for Loading Libraries in favor of <ENTRY>.  Default filename is now set
    to connected directory on startup.

 1-Jul-80 (42) Changed Dump My EMACS to be non-destructive.  Renamed: Load
    Library ==> MkDump Load Library;  Old Load Library ==> Pre-MkDump Load
    Library.

23-Apr-80 (41):  Fixed bug whereby PURIFY gets mapped in twice if the user has
    loaded it before dumping.

15-APR-80 (40):  Now that fsClkMacro is dumped, we only set it if it is
    zero.  However, due to an apparent TECO bug, we still have to copy it into
    itself in order to start the clock running.  Removed a couple of
    error-sets, for good measure.

This library was originally authored by Gene Ciccarelli (ECC), then at BBN.
It was later maintained by John Pershing <JPERSHING@BBNA>, and then back to
ECC, at MIT-AI.!

!Prepare for Loading Libraries:!
!<ENTRY>:! !C Comes first in an init file.
The only preparation necessary to use MKDUMP is to insert the
following line into your init file, at the top before any library
loading (note that there are TWO Altmodes at the end of the line):

MM Run LibraryMKDUMP

Or if you have an EVARS file, insert this line into it, at the top:

*: MM Run LibraryMKDUMP

This will prepare EMACS for later dumping by causing M-X Load
Library to start remembering exactly where it finds the libraries
it loads.

To make a dumped EMACS job, first start up EMACS the normal way:

	:EMACS<cr>				(on ITS)
	EMACS<cr>				(on Tenex or Tops-20)

Then type:

	M-X Dump EMACS<cr>

This will write the dump to the file TS DEMACS (on ITS), DEMACS.EXE
(on Tops-20), or DEMACS.SAV (on Tenex) in your home directory.

The next time you want to run EMACS, you can run the dump:

	:DEMACS<cr>				(on ITS)
	DEMACS<cr>				(on Tenex or Tops-20)

For more detailed information, see the INFO node.!

 !* Create MM-variables with impure macros, so that this library may be only!
 !* temporarily loaded by the init.!

 :m(m.m& Make Impure MKDUMP Copies)

!& Make Impure MKDUMP Copies:! !S Make Load Library and its doc impure.!

 :g(m.mLoad Library) m.vMM Load Libraryw
 :g(m.m~DOC~ Load Library) m.vMM ~DOC~ Load Libraryw
 :g(m.mDump EMACS) m.vMM Dump EMACSw
 :g(m.m~DOC~ Dump EMACS) m.vMM ~DOC~ Dump EMACSw
 

!& SetUp MKDUMP Library:! !S Install our little hook (hack?).
Hack Load Library so that it always maintains the
filename variables required for dumping.!

 [1[2				    !* Save some registers.!
 m.mLoad Libraryu1		    !* 1: Old one.!
 m.mMkDump Load Library m.vMM Load Libraryw   !* New one -- PURE version.!
 m(m.m& Make Impure MKDUMP Copies)	!* Make it IMPURE.!
 f=MM Load Library1"n		!* Old one was different.!
    q1m.vMM Pre-MkDump Load Libraryw'	!* So save old one.!
 "#					!* They are the same.!
    0fo..qMM Pre-MkDump Load Library"e	!* But was no saved old one.!
       m(m.m& Get Library Pointer)EMACS(	!* So get the tried and true one !
	  )m.mLoad Librarym.vMM Pre-MkDump Load Libraryw''	!* from EMACS!
								!* ..library!
 

!Dump EMACS:! !C Dump this EMACS out to file given by string argument.

Default is home directory, TS DEMACS on ITS, DEMACS.EXE on TWENEX,
DEMACS.SAV on TENEX.  The dump, when started, will call the default
init-file (e.g. to do JCL processing) unless this command is invoked
with a numeric argument.  For more information, see the documentation
for & Setup MKDUMP Library, or the INFO node.

Should probably only be called from top-level -mode, as it is
somewhat sensitive to what has been pushed onto the PDL.

This clobbers q-registers .1, .2, and .3 for necessary reasons -- do
not push them.!

 m(m.m& Declare Load-Time Defaults)
    Dumped EMACS Name,
	* If non-0, is filename to dump to: 0
    Dumped EMACS Default Filename,
	* If non-0, is default filename for dumped EMACS when it starts: 0
    Dumped EMACS Quick Start?,
	* If non-0, we dump out a quick-starting EMACS: 0
    Dumped EMACS Startup Hook,
	If non-0, will be called at dump startup time: 0
    Dumped EMACS fsTTYMacro,
	Contains the fsTTYMacro to restore after libraries are loaded: 0


			    !* NOTE:  We cannot push .1, .2, or .3, as PURIFY!
			    !* ..leaves stuff laying around in them which is!
			    !* ..used at startup time.!

 f[DFile			    !* Cons-up dumped filename: !
 etDSK: fsHSNamefsDSNamew	    !* Default to home directory.!
 qDumped EMACS Namef"nfsDFile'   !* Default name.!
 "#w fsOSTecof"ew etTS DEMACS'    !* ITS.!
    "#-1"e etDEMACS.EXE'	    !* TWENEX.!
       "# etDEMACS.SAV'''w	    !* TENEX.!
 et			    !* Use STRARG filename if one.!

 qEditor Nameu.1		    !* .1: Name of editor.!
 1,m.m& StartUp .1"e		    !* No startup exists.!
    @:i*|m.m& Recursive ^R Set Modef[^REnter	    !* Use normal one to be!
				    !* sure calls *Initialization*.!
	 			    !* Enter ^R, run *Init.. which exits ^R.!
	 q..0u..h		    !* *Init.. set ..0 from ..H.  Exiting ^R!
				    !* seems to 0 ..H.  Keeps any greeting.!
	 0fsQPUnwindw		    !* Pop fs^REnter, anything else.!
	 :m..l | m.vMM & StartUp .1w	    !* User restart, e.g. enters ^R.!

    !* *Initialization* is different for quick-start, default-init-start,!
    !* though both start out with the same basic code.!

    @:i.2|			    !* .2: Basic startup code.!
	  fsClkIntf"Ew 5*3600'fsClkIntw   !* Start clock running.!
	  qDumped EMACS fsTTYMacrof(fsTTYMacrow  !* Restore this now that!
						    !* ..libraries are loaded!
	     )"n m(fsTTYMacro)'    !* And call it if non-0.!
	  qDumped EMACS Startup Hook"n    !* Hook is non-0,!
	     mDumped EMACS Startup Hook'| !* ...so call it.!

    ((ff"'n)&("'n))(qDumped EMACS Quick Start?)"n
				    !* Explicit non-0 NUMARG or the default is!
				    !* for quick-starts.!
       @ft
Creating a quick-starting EMACS, no JCL.   !* Can be defaulted so tell.!

       @:i*|.2		    !* Basic startup code.!
	  etDSK: fsMSNamefsDSNamew !<! etFOO >  !* Smash default fn.!
	  0fo..qDumped EMACS Default Filenamef"nfsDFilew' !* User deflt.!
	  q..hu..0		    !* ..0: pass ..h across ^R exit.!
	  fs^RExit |m.v*Initialization*w' !* Set post-^R startup code.!
    "#
       @ft
Creating a default-init EMACS.	    !* Can be defaulted so tell.!
       @:i*|.2		    !* Basic startup code.!
	  etDSK:EMACS;		    !* Not so quick -- default init.!
	  fsOSTeco"e er* EMACS'"# erEMACS.INIT' @y	!* Suck it in.!
	  :i*[..9		    !* Backwards compatibility hack.!
	  m(hfx*)		    !* Go do it.!
	  q..hu..0		    !* ..0: pass ..h across ^R exit.!
	  fs^RExit |m.v*Initialization*w''  !* Set post-^R startup code.!

 1,m(m.m& Get Library Pointer)PURIFY"e    !* Even if PURIFY not loaded,!
    m(m.mKill Variable)PURIFY Library Filenamew'  !* it might have been...!

 0fsTTYMacrouDumped EMACS fsTTYMacro	!* Dont let this go off until!
					!* ..libraries are loaded.!
 0fs^RArgPw			    !* Forget any argument we were given so it!
				    !* ..isnt sitting there when the dump!
				    !* ..starts up.!
 0u..H				    !* Dont let the new EMACS think there is!
				    !* ..anything on the screen.!

 0fo..qCache Enabled"N 1:<m(m.mPurge Cache)>w'    !* Maybe CACHE is in use.!

 0u0 < q0*5-fq.b; q:.b(q0+4)[..O 1f? ]..O q:.b(q0)+q0u0 >   !* Close all gaps.!
 q.b[..O 1f? ]..O		    !* Close gap in buffer table.!
 q..q[..O 1f? ]..O		    !* Close gap in variable list.!

 q..L( q..P(			    !* These are clobbered by the dumper, so!
				    !* ..save them on the paren-stack.!
       fs:EJPage(		    !* Save this, in case we load PURIFY.!
	  1,m.mDump Environment"E  !* If PURIFY not already loaded,!
	     f[DFile :ejDSK:EMACS;PURIFY :EJw f]DFile '	!* load it.!
	  m(m.mDump Environment)  !* Null strarg dumps using the default!
				    !* ..filenames.!
	  )fs:EJPagew		    !* Pop PURIFY back off list.!
       )u..P )u..L		    !* Restore previous values.!

 qDumped EMACS fsTTYMacro fsTTYMacrow    !* Restore our TTY macro.!
 0u*Initialization*		    !* Dont let this hang around in case user!
				    !* dumps again but with own & Startup.!
				    !* Maybe it could also affect restarting!
				    !* this EMACS, not sure.!

 fsDFile u.1			    !* Pick up dumped filename as a string.!
 @ft
Dumped .1			    !* Report what we did.!

 fsOSTeco"E fsDFn2:f6'"# fsDFn1'u.1	!* Get name we ended up dumping.!

 0fsEchoActivew		    !* Keep typage from being erased.!

 -1fs^RLastw			    !* This seems to cure the funny echo!
				    !* ..problem.!

 0u.1 0u.2 0u.3			    !* Clear these, so garbage collector can!
				    !* ..reclaim the strings.!

 0				    !* Nothing changed (we hope).!

!MkDump Load Library:! !C Load a library of functions.
Takes filename as string arg;  default FN2 is :EJ.
Tries both the specified (or home) directory and EMACS.
An argument means don't run the library's & Setup function.
Creates a variable with the library's real filename, so this EMACS may
    later be dumped out.
Returns a pointer to the file in core.!

 1,(f):m(m.mPre-MkDump Load Library)
 
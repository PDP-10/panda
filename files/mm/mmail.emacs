!* -*-TECO-*-!
!* [PANDA]MRC:<MM>MMAIL.EMACS.94, 10-Dec-85 15:09:15, Edit by MRC!
!~Filename~:! !Macros for MM - EMACS interface!
MMAIL

!& Setup MMAIL Library:! !S Set up MMAIL commands.
C-M-Y is yank in current msg, C-X C-Q is don't change field (abort),
and C-X C-S is send mail if  q$MMAIL C-X C-S Send$ nonzero.
But, if q$MMAIL Setup hook non-zero, runs it instead.!
    :I*TextM.VDefault_Major_Mode  !* [PJG] just to make sure the!
				    !* default is o.k.!

    1,m(m.m &_Get_Library_Pointer) MWIND"e	    !* If no fancy windowing!
	m(m.m Load_Library) MWIND'	    !* Then load it in now!

    m.m &_MMAIL_FS_Superiorfs superior    !* Setup interface to MM!
    m.m &_MMAIL_..Lu..l	    !* And for when restart!
    :iEditor_type MMAIL
    1f[ reread			    !* Save mode line redisplay.!
    m(m.m Text_Mode)		    !* Default to text mode.!
    m(m.m Rename_Buffer) Message
    f] reread
    -1[0 m.m&_Create_Buffer[1 [2 [3
    qMode[4
    @:i2| m1u3 q4u:.b(q3+3) |	    !* Create all buffers in Text mode!
    :i* Headersm2 :i* Replym2
    m(m.m &_Set_Mode_Line)	    !* Now update the mode line.!
    1fs exit			    !* Tell superior MMAIL is loaded.!
    0fo..q MMAIL_Setup_Hook[0
    fq0"g m0 '
    fs rgettym.vMMAIL_Two_Window_Reply_Default
    fs rgettym.vMMAIL_Two_Window_Send_Default
    0m.vMMAIL_Two_Window_Dired_Default
    m.m^R_MMAIL_Yanku...Y	    !* C-M-Y is yank in current msg.!

    m.m^R_MMAIL_Return_to_Superioru:.X()
    1:<M(M.M Kill_Variable)MM_^R_Return_to_Superior>
				    !* [PJG] Kill any earlier!
				    !* definitions for ^R Return to Superior!
    M.M^R_MMAIL_Return_to_SuperiorM.VMM_^R_Return_To_Superior
				    !* [PJG] Replaces the old!
				    !* definition with the proper one!
				    !* for MMAIL.  This allows ^Z^Z to!
				    !* work properly and get the!
				    !* correct address for restarts.!

    0FO..Q_MMAIL_C-X_C-S_Send"N (m.m^R_MMAIL_Send_Mail)u:.X()'
				    !* Redefine C-X C-S only for wizards!

    m.m^R_MMAIL_Dont_Change_Fieldu:.X()
    

!& MMAIL ..L:! !S ..L for MMAIL.
Gets what we are doing from the JCL!

    [0[1[2 .,(fj -@f
k              -@:ffx0 -d) .fx1	    !* Get jcl!
    q1m(m.mSelect_Buffer)
    0fs^r enter		    !* Just in case!
    m(m.m&_MMAIL_0_Setup)
    0FO..QReturn_from_Superior_Hooku0 q0 "N m0 ' ]2 ]1 ]0
    :m(m.m&_Toplevel_^R)

!& MMAIL FS Superior:! !S FS Superior for MMAIL.
Gets the name of the buffer to select from the JCL as well as making room!

    [1 0f[Read Only f[Modified f[XModified	    !* Save some stuff!
    .,(fj -@f
k                ).fx1		    !* Get the name of the buffer!
    f]XModified f]Modified f]ReadOnly    !* Restore fs flags!
    q1m(m.mSelect_Buffer) j	    !* Back to buffer we wanted!
    0f[Read Only		    !* Make that one writeable!
    "l 0' "# hk ' ,0i	    !* Make room for MM to stuff with text!
    0fs exit			    !* Let MM do its work!
    				    !* All done!

!^R MMAIL Return to Superior:! !^R Return to MM and update field being editted!
    0 fs READ ONLY		    !* Just in case !
    :I*FO..QEditor_Name[A :i..JA_ ]A !* [PJG] Redefines the!
					    !* mode line so an update!
					    !* will occur!
    0f[ top line 0f[ lines 0f[ refresh
    0FO..QExit_to_Superior_Hook[0 q0 "N m0 '
    f+ 0fs exit
    0FO..QReturn_from_Superior_Hooku0 q0 "N m0 ' ]0


!^R MMAIL Yank:! !^R Insert the current message (one being replied to)
Indents arg spaces (default 4).  Leaves point and mark around inserted text.
If the variable MMAIL PRUNE HEADERS is nonzero, a cleanup of the
headers is performed leaving only the Date, From, and Subject fields.!

    :i* Message m(m.m&_Find_Buffer)[0
    .,(g:.b(q0+4)			!* Insert the contents of the message!
	.) fs boundaries		!* buffer!
    ff"N '"# 4'[A			!* Get the amount to indent!
    0 FO..Q MMail_Prune_Headers [P	!* Get the value of prune headers!
    QP"N J <:FB;			!* Make sure line has text because!
	    0l				!* headers end with a blank line!
	    5 F~DATE:"N		!* Be very careful!
		5 F~FROM:"N
		   8 F~SUBJECT:"N 1K'"#1L'
		   '"# 1L'
		'"#1L'
	    >'
    J QA"G w<.-z; WQA,32I 1@l>w J'	!* Insert the fill if necessary!
    .:				!* Mark the beginning!
    J 13I 10I				!* Insert a blank line at the!
					!* beginning!
    zj 0,fsz fsboundaries		!* Open the bounds!
	
    1,m(m.m ^R_Kill_Windows)	    !* Make sure we only have one window!
    m(m.m &_MMAIL_Send_Setup)	    !* And then if user wants them add headers!
    :,.

!^R MMAIL Send Mail:! !^R Pass contents of the buffer to superior to send.!

    [0 0FO..QExit_to_Superior_Hookf"nu0 m0'
    0f[ top line 0f[ lines 0f[ refresh
    f+ -1fs exit		    !* Say Send.!
    0FO..QReturn_from_Superior_Hookf"nu0 m0' ]0

!^R MMAIL Dont Change Field:! !^R exit and tell MM not to make the edit change!

    [0 0FO..QExit_to_Superior_Hookf"nu0 m0'
    0f[ top line 0f[ lines 0f[ refresh
    f+ -2fs exit		    !* Say Send.!
    0FO..QReturn_from_Superior_Hookf"nu0 m0' ]0

!& MMAIL Default Setup:! !S Nothing special.!

    

!& MMAIL Message Setup:! !S Prepare for editting an existing message.!

    1,:m(m.m ^R_Kill_Windows)	    !* Make sure no extra windows!

!& MMAIL Send Setup:! !S Prepare for editting a message in send mode.!

    1,m(m.m ^R_Kill_Windows)	    !* Make sure we only have one window!
    0fo..q MMAIL_Two_Window_Send_Default"g
      m(m.m Select_Buffer)Headers !* Want headers in top window!
      j bfsWindow		    !* Set window to start of message!
      m(m.m &_MMAIL_Redisplay)	    !* Hack redisplay for windowing!
      1[0 :< 1,0:fm %0 >	    !* Count lines!
      j q0,m(m.m ^R_Split_Window)' !* Make window with that many lines!
    m(m.m Select_Buffer)Reply	    !* Want reply buffer in current window!
    

!& MMAIL Reply Setup:! !S Prepare for editting a message in reply mode.!

    1,m(m.m ^R_Kill_Windows)	    !* Make sure we only have one window!
    0fo..q MMAIL_Two_Window_Reply_Default"g
      m(m.m Select_Buffer)Message !* Want message in top window!
      j s 
 
 .-bfsWindow  !* Find start of message text!
      m(m.m &_MMAIL_Redisplay)	    !* Hack redisplay!
      m(m.m ^R_Split_Window)'	    !* Make split screen (same buffer in each)!
    m(m.m Select_Buffer)Reply	    !* Want reply buffer in lower window!
    

!& MMAIL Dired Setup:! !MMAIL Dired:! !C Edit the message headers
	Enters ^R mode with the list in the buffer.
	D deletes the message which is on the current line. (also K,^D,^K)
	U undeletes the current line message.
	Rubout undeletes the previous line message.
	Space is like ^N - moves down a line.
        M toggles the unseen (marked) bit.
	F toggles the flag bit.
	R replies to the current line message.
	T types the message.
	E edit the message in a recursive ^R.
	? types this cruft.
	Q or X exits
The D,U commands repeat if given an argument, backwards if negative.!

    1,m(m.m ^R_Kill_Windows)	    !* Make sure we only have one window!
    j 0fo..q MMAIL_Two_Window_Dired_Default"g
      m(m.m Select_Buffer) Messagew	    !* Put message in top window!
      m(m.m &_MMAIL_Redisplay)	    !* Hack redisplay!
      m(m.m ^R_Split_Window)'	    !* And use other window for DIRED!
    m(m.m Select_Buffer)Dired
    m.m&_MMAIL_DIRED_Enter f[^R enter	    !* Make next ^R be a DIRED!
    [..J :I..J (MMAIL_DIRED)	    !* Set mode line!
    1f[ read only		    !* Dont allow unknown buffer munging.!
    0u..h

!& MMAIL Redisplay:! !S Fool redisplay for multiple windows!

    fs Height-(fs Echo Lines)/2f[Lines   !* Limit screen!
    @:i*|@v fs^R Exit|f[^R Enter 	    !* Do redisplay!
    

!& MMAIL DIRED Enter:! !S FS ^R ENTER for DIRED.
Puts & MMAIL DIRED ..F into ..F so that this ^R becomes
a DIRED command loop.!
    0 F[ ^R ENTER		    !* Don't screw any recursive ^R's.!
    m.m &_MMAIL_DIRED_Help f[Help Mac	    !* Make Help win like ?!
    M.M &_MMAIL_DIRED_..F [..F W Q..F [.F
    1F[ ^R MDLY W 0F[ ^R MCNT
    M.V MMAIL_DIRED_Dispatch	    !* Make sure variable exists.!
    [ MMAIL_DIRED_Dispatch
    13*5 FS Q VECTOR[0
    Q0 U MMAIL_DIRED_Dispatch	    !* Create the dispatch table!
		    !* Note that the 13 slots correspond to the characters!
		    !* DKU<rub><sp>MFRET?QX!
		    !* via the F in & MMAIL DIRED ..F.!
    -1[1	    !* So fill the slots with appropriate macros.!
    M.M &_MMAIL_DIRED_Delete U:0(%1)	    !* D deletes this message.!
    M.M &_MMAIL_DIRED_Delete U:0(%1)	    !* K also deletes this message.!
    M.M &_MMAIL_DIRED_Undelete U:0(%1)	    !* U takes away a delete-mark.!
    M.M &_MMAIL_DIRED_Reverse_Undelete U:0(%1) !* Rubout undeletes backwards.!
     FS ^R INIT U:0(%1)	    !* Space moves down a line.!
    M.M &_MMAIL_DIRED_Mark U:0(%1) !* M toggles seen bit.!
    M.M &_MMAIL_DIRED_Flag U:0(%1) !* F toggles flag bit.!
    M.M &_MMAIL_DIRED_Reply U:0(%1)	    !* R Replies to message.!
    M.M &_MMAIL_DIRED_Examine U:0(%1)	    !* E edits!
    M.M &_MMAIL_DIRED_Type U:0(%1) !* T types message!
    M.M &_MMAIL_DIRED_Help U:0(%1) !* ? prints documentation.!
    M.M &_MMAIL_DIRED_Quit U:0(%1) !* Q exits DIRED.!
    M.M &_MMAIL_DIRED_Quit U:0(%1) !* X exits DIRED.!
    ]1 ]0 0_			    !* No ^\.!

!& MMAIL DIRED ..F:! !S ..F macro to make ^R understand DIRED commands.
It reads DIRED commands and executes them.  When a control- or
meta- character is typed, it is left for ^R to execute.!
    FS ^R MODE"E '		    !* Don't be confused if called on exit!
    [0 [1 [2 0 ^ V
    < 2,M.I ^:FI:FCU0		    !* Read input with no prompting.!
      Q0F DKU_MFRET?QX U1
      Q0-200. F DK F"G U1'	    !* Is it ^D or ^K?!
      Q1+1"G FI			    !* Yes => run it.!
	FS ^R ARGP&2"N
	  FS ^R ARG' "# 1' U2	    !* Compute the arg like ^R.!
	FS ^R EXPT< Q2*4U2>	    !* Run the command!
	FS ^R ARGP"N Q2' ^ M:MMAIL_DIRED_Dispatch(Q1) (
	  0 FS ^R ARGPW  0 FS ^R ARGW  0 FS ^R EXPTW
	    -1FS ^R PREVW	    !* Flush the ^R arg we gave it.!
	  ) ^ V !<!>'		    !* Hand its values back to ^R.!
      ^:FIU0 Q0&177.-137."G Q0-40.U0'	    !* Is it a ^R command?  Get 9-bit!
      Q0 ^ FS ^R CMAC-( 32 FS ^R INIT)"E
	FG FI!<!>'		    !* Don't run anything self-inserting.!
      0;> 0		!* Any other ^R command => return so ^R can gobble it.!

!& MMAIL DIRED Delete:! !S Delete current file.!
    500.+4,m(m.m&_MMAIL_DIRED_Mark_Subr)D

!& MMAIL DIRED Undelete:! !S Delete current file.!
    600.+4,m(m.m&_MMAIL_DIRED_Mark_Subr)D

!& MMAIL DIRED Mark:! !S Delete current file.!
    1,m(m.m&_MMAIL_DIRED_Mark_Subr)U

!& MMAIL DIRED Flag:! !S Delete current file.!
    2,m(m.m&_MMAIL_DIRED_Mark_Subr)F

!& MMAIL DIRED Reverse Undelete:! !S Move up one line and undo a D.!
   -l 1m(m.m &_MMAIL_DIRED_Undelete) (-l)

!& MMAIL DIRED Mark Subr:! !S Pre-comma is position.!
    0l "g z-'. "e fg 1 '	    !* Barf at end of buffer.!
    0f[ read only		    !* Allow munging the buffer.!
    :i*[0			    !* Get char!
      < .-z;		    !* Iterate |arg| times, stop at end!
	"l .; -l ' &77.c
	&300.f"n &100."n 1a-32"e f0'' "# 1a-32"n f_'''
	  "# w 1a-32"e f0' "# f_''
	"g l ' >
    &400."e -l' "# -' f    !* Mark these lines as changed.!

!& MMAIL DIRED Help:! !S Type our help msg.!
    m(m.m describe)MMAIL_DIRED 

!& MMAIL DIRED Type:! !S Type out this message.!

    0l .[0 @f NRUFAD_ l \(		!* [PJG] Skip N -- Find message number!
      qCurrent_Window[C	    !* Save number of current window!
      1:<m(m.m ^R_Goto_Window)>"n 0uC'	    !* Try picking a different window!
    )+777774777777.fs Exit	    !* Now we can call MM to do the work!
    0fsPJATY			    !* Don't mung redisplay!
    "e ht'			    !* Type message!
    "# 0[..F Q..F[.F		    !* Or fix self-insertion chars!
       qEditor_Name[1 [..J :i..J[1_]   !* and mode line!
       j '			    !* Enter recursive edit of message!
    qC"g 1:< qCm(m.m^R_Goto_Window) >'	    !* Back to old window!
    m(m.m Select_Buffer) Dired    !* Make sure we're back in the Dired buf!
    0f[ Read Only
    q0j 1a-N"e fR' 2a-32"n .+1f_' 

!& MMAIL DIRED Quit:! !S Exit from DIRED.!

    :M(M.M ^R_MMAIL_Return_to_Superior)    !* Run same code as normal quit!

!& MMAIL DIRED Reply:! !S Reply to current message.!

    0l .[0 @f NRUFAD_ l		!* [PJG] Skip N -- Find start of line!
    \+777773777777.fsexit	    !* Give message number for MM to use!
    

!& MMAIL DIRED Examine:! !S ...!
    1,:m(m.m&_MMAIL_DIRED_Type)

!* 
/ Local Modes: \
/ MM Compile: M(M.MGenerate Library)MMAILMMAIL
1:<M(M.MDelete File)MMAIL.COMPRS>W \
/ End: \
!  
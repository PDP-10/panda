!* -*-TECO-*-!

!Make Prefix Character:! !C Make definition for a ^R command prefix.
For usage conventions, look at the source code.!

!* Takes as string arg the name of a q-register, and
returns a consed up function which, when run, will
use the common prefix-handler in q-reg .P
to dispatch through the q-vector assumed to be
in the specified q-reg.  Also puts a suitable q-vector
in that q-reg if it contains 0.  In that case, a numeric arg
specifies the length of the q-vector (default is 96).
Example: MMMAKE PREFIX CHARACTER.X  U.^RX
makes ^X a prefix character with dispatch table in Q.X.!

    :I*[0			    !* Get our string arg!
    Q0 "E F"E+96'*5FS Q VECTOR U0'	    !* Q-reg is 0 =) put a qvector in it!
    @:I0/!PREFIX! F@:M(Q0 M.P)/	    !* Cons and return the function!
    Q0 

!& Macro Name:! !S Given an object, returns its full name.
The object should be given as a prefix arg, and
the name is returned as a string pointer.!
    [2 [3 [4
    fp-101"e			    !* If function is impure, search through TECO variables!
	q:..q(0)u2		    !* for one whose value is this function.!
	:fo..qMM_  u3	    !* Find the segment of variables that start with "MM ".!
	:fo..qMM!  u4	    !* Q4 gets end, Q3 gets beginning.!
	< q3,f..qu3		    !* Search for next occurrence of value in ..Q.!
	  q3:; q3-q4;		    !* Give up if none, or past end of MM vars.!
	  q3/3*3+2-q3"e -69u4 0;'   !* Ignore if we found a name or comment.!
	  %3>
	q4+69"n 0'
	3,10000:g:..q(q3-1)'	    !* If find one, return var name sans the "MM '.!
    fp+4"e			    !* Object is just a number => look through builtins.!
      0,m(m.m&_Get_Library_Pointer)BAREu2 !* Get ptr to library if loaded.!
      q2"n ,q2m(q2m.m~Invert~)u2'	    !* if loaded, get invert function and call it.!
      q2'			    !* Return name, or 0 if has none or BARE not loaded.!
    fp-100"n @ fe QNS fs err'
    fs:ejpage*5120+400000000000.u2  !* q2 is current file.!
    400.*5120+400000000000.u4        !* q4 points to end of memory!
    <q2-q4; q2-;                   !* Stop at end of memory, or at target!
      q2+fq2+4-;                   !* stop if reach file containing desired object!
      q2+fq2+4u2 >                   !* else skip to next file.!
    q4-q2"e 0'                     !* Reached end =) return 0 for object not found!
    :i4~INVERT~ q4,q2m(Q2+4) u4     !* Found right file - get its ~INVERT~ function!
    ,q2m4                        !* Pass our arg off to it!

!& Charprint:! !S Print pretty descrpition of 9-bit character.
Example:  415.MMCharprint prints "Meta-CR".
The 1 bit in the precomma arg means print in the echo area.
The 2 bit means say "^M" instead of "CR", etc, and
^B instead of an alpha on TV's.
The 4 bit means use "C-" instead of "Control-".!

    [1 :I1 &1"N :I1@'	    !* Q1 has "@" if we should use the echo area.!
    -4110."E M1FT Help '
    &4"N
      &200."N M1FTC-'	    !* Handle the "control' bit!
      &400."N M1FTM-''	    !* And Meta!
    "#
      &200."N M1FTControl-'	    !* Handle the "control' bit!
      &400."N M1FTMeta-''	    !* And Meta!
    [0 &177.U0		    !* Get just the ASCII part!
    Q0-127"E M1FTRubout '	    !* Handle special cases that look bad!
    Q0-27"E  M1FTAltmode '	    !* if we just type the character!
    &2"E
      Q0-8"E   M1FTBackspace '
      Q0-9"E   M1FTTab '
      Q0-10"E  M1FTLinefeed '
      Q0-13"E  M1FTReturn '
      Q0-32"E  M1FTSpace ''
    &2"N Q0-32"L M1FT^ Q0+100.U0'''
    M1FT0 		    !* Other characters, just print!

!& Read Q-reg Name:! !S Read name of qreg from terminal, return as string.
 refers to most recent mini-buffer string.
 is followed by a variable name.
( is followed by an expression to evaluate.
 followed by command refers to its definition.
Prefix argument serves as first character of input.
If non-zero pre-comma argument, undefined symbols return it.!
    [0 [1 :I1                      !* q0 has last char, q1 accumulates name.!
    :@I*/ M(M.M Describe) &_Read_Q-reg_Name / F[ HELPMAC
    [2			    !* Q2 gets arg, or 0 if none!
    < Q2"G Q2U0 0U2'		    !* If have arg, gobble it as 1st char!
        "# M.I FIU0'		    !* else read a char!

      Q0-"E :I*:.N(0) '	    !* Short for mini-buffer contents. !

      Q0-"E			    !* Read a variable name!
         1, M(M.M &_READ_LINE) Variable_Name:U2
	 FQ2:"G 0 FS ERR'	    !* quit if null string!
	 :I1  2  
	 :FO..Q 2  "L	    !* See if name is defined!
	        FF&2"N ' 
	        @FT Define_Variable_"2"  !''!
		1M(M.M &_Yes_or_No)"E	    !* Not defined => should we create it?!
		   0 FS ERR'	    !* No => abort command.!
		M.V 2 '	    !* yes => define it, and let command continue.!
	 Q1'

      Q0-("E 1, M(M.M &_READ_LINE) Value_of_expression:_ F"E :I*' U0
	       :I* ( 0 ) '

      Q0-?"E 4110.FS REREAD !<!>'	    !* Describe this subroutine.!

      Q0-"E                     !* After ^R, read command name.!
        1,M.I @FI+(200.*FQ1) FS ^R INDIRU0   !* 1, => Handle metizer chars.!
	Q0/200.,.:I2		    !* Q2 gets a dot for each meta-bit.!
	Q0&177.U0
	:I0 2  0 	    !* Follow by a ^R and the basic character.!
	FQ1"N Q0'		    !* If there was a dot, return this.!
	Q0U1			    !* Otherwise, if a prefix char was specified,!
	Q1 FP-101"E		    !* ask which element of it to use.!
	 F=1 !PREFIX!-9"E	    !* Prefix char?!
	   f[b bind g1	    !* Get name of q-vector!
	   J S @:M(Q 		    !* Decypher the function!
	   .,(SM.P 3R.)X1
	   f] b bind		    !* Unbind now, or M.I will display the bound buffer!

	   M.I FI U0		    !* Get dispatch char!
		      [2 :I2Q:1(0)	    !* [PJG] Maybe lowercase!
						    !* character is defined!
		      2"E q0 :FC u0' ]2   !* [PJG] If nothing then uppercase!
					    !* it !
			0<
	   M.I FI:FCU0		    !* Get dispatch char!
			  >

	   :I1 : 1 ( 0 ) ''
	Q1'
      :I110                !* Char not ^R =) accumulate it.!
      Q0-.:@; >		    !* After ".', need another character.!
    Q1'

!& Macro Execute:! !S Standard MM: runs function with given name (string arg).!

    :F"L @' F:M( M.M )	    !* Use M.M to get the function, then call it.!
!* If we were called with @, specify @ so that the default arg is 1.!

!& Macro Get:! !S Standard M.M: returns function for given name (string arg).
The second argument, if nonzero, is the file to load from.
The first argument, if nonzero, means return 0 for an
undefined or ambiguous name, instead of causing a TECO error.!

!** Don't use any multi-digit decimal numbers here !

    :I*[0			    !* GET FUNCTION NAME AS A STRING.!
    "E 0FO..Q MM_0 F"N ''    !* IF TECO VARIABLE EXISTS, IT OVERRIDES PURE FILE!
    FS:EJPAGE*12000.+400000000000.[1 !* GET STRING POINTER TO 1ST FILE LOADER FUNCTION!
    "N U1'			    !* EXPLICIT 2ND ARG IS FILE TO USE INSTEAD.!
    Q0,Q1 M(Q1+4) U1		    !* CALL LOADER.  FUNCTION VALUE IN Q1!
    "E Q1F"N 'W  "N Q1''    !* IF NO ERROR, OR IF NONZERO 1ST ARG, RETURN IT.!
    "# Q1"L +FQ()+4-Q1"L 0U1''  !* If explicit file spec'd, and function was found!
       Q1F"L '  "N Q1''	    !* in another file, then it is undefined.!

    "E F[D FILE
         FQ0-5,FQ0:G0U1		    !* If "FOO Mode" is undefined,!
	 F~1_Mode"E
	   0,FQ0-5:G0U1		    !* and there is a library FOO,!
	   E?EMACS:1.:EJ"E	    !* try loading it if it isn't already loaded.!
	     1,Q1M(M.M&_Get_Library_Pointer)"E
	       M(M.MLoad_Library)1
	       M.M0'''
	 F[:EJPAGE		    !* See if BARE defines this name.!
	 1:< 1,(:EJEMACS:BARE.:EJ)M.M 0 F"N '>  !* If so, return the definition.!
	 F]:EJPAGE'

    :I*0__Undefined_or_ambiguous_function_name FS ERR

!& Prepare for Input:! !S Standard M.I: prepares for an FI,
by prompting and/or finishing redisplay.
A post-comma argument is used for prompting instead
of the most recent character typed in.
The pre-comma argument is bit-decoded;
   1 => Check for metizer characters.  Echo meta bits.
   2 => Don't prompt or echo.
   4 => Echo meta bits on non-digits.!

    [0 [1
    FS HELPMAC-(M.M^R_Documentation)"E
      M.M&_Read_Line_HelpF[HELP MAC'  !* Set up help for arg char if caller didn't.!
    0[D				    !* Provide parameter for & Read Line Help.!
    FS OLDFLUS"E FSTYPEOU"L 0@V'' !* Finish redisplay, unless would erase typeout.!
    &2"N  O METIZE'		    !* If specified, skip echoing/prompting.!
    FS ECHO ACTIVE"E		    !* If no echoing happening yet,!
      20:"E			    !* and no input for 2/3 second,!
	FS TYI COUNT-(FS TYI BEG)U0	    !* find out how many chars so far in this cmd,!
	Q0< FS .TYI BACK>	    !* and echo them all.!
	@FT_
	Q0< FS .TYI NXTU1	    !* read them out of the buffer of recent input.!
	    Q0-1U0 "N Q0@;'	    !* But if prompt string supplied, omit last char!
	    5,Q1M(M.M &_Charprint)
	    @FT_ >
	FF&1"N U1 @FT1''' !* and print the string instead, with no space after.!
    FS ECHO ACTIVE"N		    !* If echoing already,!
      FS RGETTY"N @FT_ '	    !* put cursor back in echo area.!
      &5"N @' :FIU1		    !* Now get the input,!
      &4"N :FI F_0123456789"G :FIU1''  !* 4 bit => echo metabits only on nondigits!
      5,Q1 M(M.M&_Charprint)	    !* echo the character just read.!
      @FT_'

 !METIZE!			    !* Now, on non-TVs, check for metizer characters.!

    :FIW			    !* Make sure that, even if M.I isn't doing anything else,!
				    !* we do wait for the input inside it.!
				    !* That makes the M.I help function work.!

    &1"E '			    !* Dont handle metizers if 1-bit not set in 1st arg.!
    @:FI FS ^R INDIRECT U0	    !* Get the input char, and trace ^R indirect definitions.!
    FQ0"G
       F~0!BIT-PREFIX-12"E	    !* If this char claims to be a metizer function,!
          FIW Q0,M0 FS REREAD''    !* Then let it do its stuff.  It returns the input char.!
    

!& Prefix Character Driver:! !S Standard M.P: handles a prefix character.
Given a q-vector as argument, it reads a character
and returns the q-vector element it selects.
The character read is left in Q..1.!

    [0 0F[HELPM
    M.I FIU0			    !* Read the subcommand character.!
    F]HELPM			    !* The HELP character is not processed, just read in!
    Q0-4110."N
      Q0U..1			    !* If char is not a rq for help, put it into Q..1.!
      FQ()/5-Q0"G Q:()(Q0) F"N ''	    !* If char is defined, return definition.!
      Q:()(Q0:FC) F"N (Q0:FCU..1)'	    !* Else try uppercasifying.!
      Q0-?"N :I* FG''	    !* Not defined, if not "?" return command to ring bell.!
    FS ^R LASTU0		    !* Help or ?:  user wants documentation.!
    Q0,Q0 M(M.M &_Prefix_Describe)
    :I*0_

!& Error Handler:! !S Standard Q..P: handles TECO errors.
See the source for more info.!

!* Handling is like TECO's default, except that if the
first character typed is "?" then Backtrace is called.
A space makes us exit and redisplay over the error message.
Quits are not handled at all unless QDebug is nonzero.
That is so a quit will cause the buffer and ..J to be
popped and redisplayed immediately.!

!* It is dangerous to push anything on the qreg pdl
before we have checked for a QRP error.!

    :? fs errorf"n @:fg	    !* Leave trace mode, print error message!
      fserror-(@feURK)"e	    !* If out of address space, clean up right away.!
        FT
_executing_Make_Space...

        mMM_Make_Space''	    !* We can get there without consing any strings.!
    "# 0fo..q Debug"e
         fs errorfs err thr''	    !* Decide whether to handle a quit.!
    q..h"e @v'			    !* Maybe display the current state of buffer.!
    @:fi-?"e fiw		    !* Else offer him a ^R break loop.!
	1fsverbof(f"e		    !* If he wants it, and hasn't seen full message, show it!
	    fserrorfg' )fsverbo
	fs error-(@feqrp)"e
	  :ft
Unwinding_partially_to_make_room_for_error_handler
	  -9-9fsqp un
	  2m(m.m Backtrace)
	  m(m.mTop_Level)'
	f[error		    !* Preserve this for the fs err throw below.!
	2m(m.m Backtrace)+0"n F)'	    !* Nonzero value from Backtrace means proceed.!
	f]error'
    "# fs echoerr"e
        @:fi-_"e fiw 0u..h 0fserrflg''' !* Space means display over the error message now.!
    fs errorfs err throw

!Backtrace:! !C View the functions which are active on the stack.
Displays one invoked function, copied into a buffer,
with point at the PC.  Then reads a command character:
 Linefeed or D goes down the stack (to earlier invocations),
 ^ or U goes up to more recent invocations,
 ^R calls ^R on what you see,  ^L clears the screen,
 B calls ^R on the buffer that was being edited,
 V displays a q-register's contents,
  runs a minibuffer, X starts an extended command, Q exits.
 C continues erring function.  Period lets you move PC, then continues.!

!*** This function should not contain any multi-digit decimal numbers
 whose precise values matter.!

    1f[ctlmta			    !* set fs ctlmta since, if do call ^R,!
				    !* we will be editing TECO code.!
    0F[Help Mac
    8f[i.base			    !* Make multi-digit octal numbrs work.!
    0u..h 1fserrflg		    !* Wipe out err msg and any typeout immediately.!
    [..j 0[..f
    [Backtrace_temp		    !* We use funny names so do not shadow anything!
    f[b bind			    !* Must be last pushed outside LP.!
    2[0 1:< -2fsbacktrace>"e	    !* Find in Q0 a useful initial depth.!
          -7 f~ M:.N(0)"e %0''    !* Going up past ^R Execute Mini if there.!
        ff"n u0'		    !* Numeric arg specifies depth.!
    fs back depth-q0 uBacktrace_temp ]0

  !LP!				    !* Here after setting depth - fetch new frame!

    qBacktrace_temp:\[0 :i..j Backtrace__Depth_0__ ]0

    hk 1:< qBacktrace_tempf"l w99999999.' f(fs backtrace  !* Try to read that function in.!
           !* if we fail, we exit the errset.  Otherwise, we leave depth on ( pdl.!
	   !* Now try to get name of function which lives in that frame.!
             )fsback strm(m.m &_Macro_Name)[0
	     :i..j ..j 0_ ]0 >
    z"e :i..j ..jOut_of_range._ '
    0fswindow
    0fsmodif
    fs rgetty"e f+'		    !* Make sure the @v really displays.!

!*** This loop just redisplays the buffer (containing the current level
of executing function.  Exiting the loop goes to LP to load in a different
level of function, based on the value of QBacktrace Temp.!

    :@< 
      fs tyi count fs tyi beg
      fs echo act"n :i*Cfs echo dis'
      0fs echo act
      @v
      :fi:fc[1 q1-4110."e ?u1 fi'
	 "# @fi @fs ^r cmac-(33.fs ^r init)"e Qu1''
		      !* Read input char, make C-Altmode act like Q.!
      q1u..0 ]1
      q..0fD
:"l qBacktrace_temp-1uBacktrace_temp  0;'
      q..0fU^:"l %Backtrace_temp  0;'
      q..0-C"e 1 '		    !* Tell ..P to return to erring program.!
      q..0fQ:"l '	    !* Tell ..P to quit.!
      q..0fBV?X."L FG'    !* Check for undefined commands.!
      q..0-"E f+'
      q..0-"e '
      q..0-"e m(m.m ^R_Execute_Mini)'
      q..0-B"e -1fs qp slot[..o  ]..o'
      q..0-V"e m(m.m ^R_View_Q-reg)'
      q..0-?"e FT You_are_inside_a_break_loop,_running_
	         m(m.m Describe)Backtrace'
      q..0-X"e m(m.m ^R_Extended_Command)'
      q..0-."e :i..j Set_PC_to_return_to  
		 qBacktrace_Tempf((
		 -2fs qp un
		 .,)fsback pc
		 )fsback ret'
      >
    o lp

!& Toplevel ^R:! !S Enter a loop entering ^R mode within a catch.  Default ..L.
The function MM Top Level will then effectively return to this ^R.!

    FS TTY MAC"N M(FS TTY MAC)'   !* Do this now, on first startup,!
				    !* since it did nothing immediately after start!
				    !* because the libraries were not loaded.!
    < 1F< !TOPLEVEL_^R!  
          > "E M(M.M ^R_Return_to_Superior) !<!>'
      FG @FT
	     Back_to_Top_Level
      0FS ECHO ACTIVE>

!Top Level:! !C Return to the top level EMACS command loop or to TECO.
With no arg, returns to the top level EMACS command loop.
With an arg, returns to TECO's command level.!

    FF"N
      @FT
Type_:M..L_to_return_to_real-time_editing.
 '
    1F; TOPLEVEL_^R 

!& Recursive ^R Set Mode:! !S Standard FS ^R ENTER.
This is hairy; look at the code and comments.!

!* This is the top-level value of FS ^R Enter.
It takes effect in the outermost ^R call.
Inside it, FS ^R Enter is what this function binds it to,
a simple function to put [ ... ] around ..J.
The purpose of & Recursive ^R Set Mode is to be
able to have this change to ..J made at recursive ^R's
inside a given ^R, but not at that given ^R itself.

However, it may happen that the outermost call made to ^R
is from within a function called by the user with MM from TECO.
In that case, with ..J bound to something strange, we do
the [ ... ] thing to it even in the outermost call.

The first time we are called, *Initialization* will be a function
to run the user's init file.  We execute that, then zero it out
so that it will not be done again.  The goal is that init files
be executed inside of a ^R.!

    @:I*`
      f=..j(-1"g 0'!)!
      [..J :I..J[..J]_0:
      ` F[^R ENTER
    F~Editor_Name..J*+fqEditor_Name+1"N
      :m(fs ^r enter)'
    0fo..q*Initialization*f"nu..0
      0u*Initialization*
      m( :@I*| 1:@< m..0 > |)'
		!* This hair in doing m..0 is to make sure that!
		!* anything pushed by ..0 gets popped,!
		!* but our push of FS ^R ENTER does not.!
    0:

!& Maybe Push Point:! !S Implements Auto Push Point Option.
Functions which move the pointer by an unpredictable amount call
this subroutine, with the old pointer as an argument.  If
Auto Push Point Option is non-zero, and less than the distance
moved, the old pointer is pushed onto the mark pdl and "^@"
is typed in the echo area.!

    qAuto_Push_Point_OptionF"G    !* If Option in effect
!     -(,.F  )"L		    !* and pointer moved a long way !
	:	 		    !* then push point !
	FS TYI SOURCE"N '
	QAuto_Push_Point_Notification[0
	@FT0 0FS ECHO ACTIVE '' !* and tell user !
    W 

!& Maybe Display Directory:! !S Implements Auto Directory Display option.
Functions which do file operations call this function.  If the
Auto Directory Display is nonzero, it does a directory display.
Read operations (not changing directory) should give an argument of 1.
Write operations should give an argument of 0 or no argument.!

    "n qAuto_Directory_Display"g ''
				    !* For "read' operations, option must be negative!
    qAuto_Directory_Display"N
				    !* For write operations, need only be nonzero!
	mDirectory_Lister' 	    !* run the directory display function!

!& Subset Directory Listing:! !S Lists subset of current directory, selected by FN1!

      fsListen"N  '		    		!* Do nothing if typed ahead!
      [1[3 0f[case f[bbind f[s string f[window   !* Must push window since T can clobber!
      FSddevF6 I:_ FSdsnameF6 I;_		!* Type out file name defaults !
      FSdfn1f6 i_ FSdfn2f6 15.I 12.I :FT HT
      HK FSdfn1f6 hf=TS"E hkfsdfn2f6 ' hfx3	!* Q3 gets file name to match !
      EM					!* Get the directory into buffer !
      JL 0[4 0[2 0[5				!* q2 pri blks free, q5 sec blks !
      :<FB# \-13"E c\+q5u5 '"# c\+q2u2 ' %4w >	!* q4 non-zero if disk !
      f=(fs d fn1 :f6)*"e ht'		!* If FN1 is *, type whole dir.!
      q4"e j2t'					!* Non-disk => always type 1st 2 lines.!
      J 2K 0S_3_ < :S; 0TT L		!* Disk, type out matching lines !
	 fs Flushed"N  ' fs Listen"N  ' >	!* But stop if char typed or flushed !
      q4"e '					!* Non-disk => give up, can't compute blocks.!
      FTFree:_ Q2:= Q5"N FT+ Q5:= ' FT,_Used:_   !* Type trailer line !
      J 0u2 :< 3a-L"N 20c \+q2u2' L>		!* Q2 counts all blocks used!
      J 0u5 :< 2c 2 f=13"E 18c \+q5u5 ' L>	!* Q5 counts secondary blocks!
      Q2-Q5:= Q5"N ft+ Q5:= ' 

!& Rotated Directory Listing:! !S Lists current directory rotated.
The files with FN1 matching the current default are rotated to the top.!

    m.m &_Maybe_Flush_Output [a    !* QA gets subroutine such that MA !
    f[ b bind 0f[case [3 0[4
    f[s string f[window	    !* Push window since T can clobber.!
    fs d devf6 hf=TTY"e '	    !* Some devices we want full listing for!
		hf=XGP"e '
	        hf=D"e '
    hk fs d fn1f6 6-.,32i hfx3	    !* Q3 gets default FN1, padded to 6 chars w/ spaces!
    ez ma			    !* Get dir in buffer.  If flushed, give up!
    [..j :i..j Directory_Listing__ fr	    !* Tell user what is going on!
    :ft j :t :k		    !* List dev name and sname, at top of screen!
    ft___--___ g(fs d file)	    !* Followed by default file name.!
    j 2t :2k ma		    !* ACtually type the filename, and # blocks free!
    z-2"e '
    :s
___3"n			    !* Try to find 1st file with desired FN1.!
      < 0l tk %4		    !* Found one =) print and kill them all,!
	6:c; 6 f=3:@;>'	    !* and Q4 counts how many of them there were.!
    "# <l .-z; 6c 6 f=3"g 0;'>   !* None found =) find 1st file with FN1 too big!
       FT <<_File_not_present_in_dir_>> !* and inform the user.!
       '
    FT==MORE==			    !* Does user want to see rest of dir?!
    :fi-32"e fiw'		    !* Read char:  space =) YES!
	  "# :fi-127"e fiw 0u..h'   !* else NO, and flush char iff space or rubout;!
		    "#-'1fs flushed !* Indicate output now flushed!
	     '
    fs top line+q4+2 f[top line   !* Else arrange to write over the ==MORE==!
       :ft f]top line		    !* with the rest of the directory,!
    0L .,zt ma		    !* which we now print.!
    ft---------------------------------------------
    b,.t 			    !* After end half of dir, print top half.!
				    !* Note 1st thing at B now is a CRLF.!

!& Maybe Flush Output:! !S For typeout commands, see if should stop typing.
Do M(M.M &_Maybe_Flush) ^\ to return if typeout flushed.!

    fs flushed"n '
    fs listen"n :fi-32"n :fi-127"n ''' !* returns if output flushed!
    f* 			    !* if not flushed, ignore the .!

!& Save Region and Query:! !S Save the region for undo, and maybe query.
Given a string pointer as arg, we ask "Do you really want to <string>
such a large region?" if the region is bigger than Region Query Size.
We return 0 if the user says No, or -1, having saved the region, for Yes.!
    1003 fs ^r last		    !* Cause m-Y to be able to restore saved region!
    [1
    FQ1"G
     :,.F  -qRegion_Query_Size"G	    !* About to hack a very big region => query.!
      @FT
      Do_you_really_want_to_1_such_a_large_region
      1M(M.M &_Yes_or_No)"E 0'''
    :,.M(M.M &_Save_for_Undo)1
    -1

!& Save for Undo:! !S Save part of buffer for Undo.
Takes args like K; also a string arg for the operation name.!

    :I:..U(4) 		    !* name of type of operation.!
    FF [1[0
    Q..OU:..U(0)		    !* Store info for Undo command: buffer,!
    FF X:..U(1)			    !* text,!
    Q0U:..U(2)			    !* start addr,!
    FSZ-Q1U:..U(3)		    !* distance from end of text to end of buffer,!
    0

!& Kill Text:! !S Subroutine for killing text.
Give arguments as for TECO K command, to kill text and save
on the kill ring.  Also, Q9 must be >= 0 for deleting forwards
and < 0 for deleting backwards.
If the previous ^R command also killed (FS ^R PREV = 1001),
the kill ring is appended- (if deleting forward) or
prepended- (if deleting backwards) to instead of pushed.
The only significance of the "direction of deleting"
is to choose between appending or prepending.
We return two values to pass on to ^R.!

    1001 fs ^R Last		    !* Signal this a deleting command!
    [1 F X1			    !* Pick up the stuff!
    fs ^R Prev-1001"E		    !* If previous command deleting also,!
      Q:..K(0) [0		    !* pick up what it deleted!
      Q9"L :I:..K(0)10 '   !* If this deletes backward, pre-pend!
      "# :I:..K(0)01 '	    !* otherwise ap-pend!
      Q:..K(0)U:..U(1)		    !* Store text for Undo command.!
      Q9"L Q:..U(2)-FQ1U:..U(2)'    !* And adjust either address of start!
      "# Q:..U(3)-FQ1U:..U(3)' '    !* or address of end.!
    "# Q..K[..O ZJ-5D		    !* Last command, not deleting, push onto ring!
       J 5,0I ]..O		    !* by flushing oldest, making space at front,!
       Q1U:..K(0)		    !* and storing into it.!
       Q1U:..U(1)		    !* Store text and addresses for Undo command.!
       FF U1U:..U(2)
       FSZ-Q1U:..U(3)'
    Q..OU:..U(0)
    :I:..U(4) kill
    F K .,.			    !* Stuff safely stored away, now delete it!

!& Secretary Macro:! !S Standard ..F:  Auto-save for use in ^R mode editing.
If Auto Save Mode is  non-zero, the buffer is saved
(as by ^R Save File) after every FS ^R MDLY characters.!

    QBuffer_Index[1 0[2
    Q:.B(Q1+4!*bufbuf!)[..O	    !* Make sure we save the real EMACS bfr, not a temp.!
    FS XMODIF"N		    !* Don't save buffer unless it needs an auto save.!
      Q:.B(Q1+10!*bufsav!)"N	    !* Is saving enabled for this buffer?!
        FSZ"N			    !* Is there anything in the buffer?!

	  1U2			    !* Say we've saved one file already.!
	  FSRGETTY"N @FT _(Auto_Save)'
	  "# @FT'		    !* Don't use FG - it screws FS TYISRC$ !
	  F[D FILE			    !* Don't clobber TECO default filenames.!
	  1:< 2,1M(M.M ^R_Save_File) >"L
	      FG @FT_(Auto_Save_Failed!) 60 0FS ECHO ACT'
	  '''

    QAuto_Save_All_Buffers"N
      1,Q2M(M.M &_Auto_Save_All_Buffers)'
    0

!& Real-time Interrupt:! !S Save file after 5 minutes of idle time.!

    0fsin count"n 0'
    q.f-q..f"n 0' q..f"e 0'
    m..f
    0@v 0

!& Check Top Level:! !S Error if not OK to switch buffers, files, etc.
Switching is OK if Q..F equals Q.F.
Follow by what it is you want to hack, such as "files".!
    Q.F-Q..F"E F* '
    :I*Not_top_level;_can't_hack_ FS ERR

!& Set Mode Line:! !S Set the ..J Mode to display options.
When setting the major mode, call this with a nonzero argument
and the major mode name as a string argument.  It will change the mode
and run the <modename> Mode Hook variable, if there is one.!

    -(FSQP PTR*2)FS MODE CH	    !* Arrange to be called again if qpdl is popped.!
    Q..O[9
    FSVZ+B[4			    !* Nonzero if buffer is narrowed.!
    QEditor_Name[0
    QMode[1
    QBuffer_Index[3
    "N :I1 Q1UMode
         0FO..Q 1_Mode_Hook[2    !* If called with arg 1, we are entering a major mode,!
         Q2"N M2''		    !* so run its hook.!
    0[.1 q..J[.2
    < fq.2@; 0:g.2-[:@; %.1	    !* .1: Count levels of ^R recursion.!
      1,fq.2:g.2u.2 >		    !* .2: Strip of [s indicating ^R levels.!
    F~.20-1-FQ0"N 0'	    !* If inside ^R indicators, is not standard looking mode line!
				    !* then exit with mode line unchanged.!
    F[B Bind G0 I_		    !* Accumulate new ..J in a temp. buffer.!
    0FO..Q Editor_Type[2	    !* If this is a LEDIT, etc, say so before major mode.!
    Q2"N G2 I_'
    I( G1			    !* Mention the major mode in ..j,!
    QSubmodeU2 FQ2"G		    !* followed by submode, if any.!
      I [ 2 ] '
    QAuto_Fill_Mode"N		    !* If in Auto Fill Mode, say so.!
      I_Fill'
    Q:.B(Q3+10!*bufsav!)"N
      I_Save'			    !* If in Auto Save Mode, say so.!
    "# QAuto_Save_Default"N
	I_Save(off)''		    !* Else if in inhibited auto save mode, say so.!
    FS ^R REPLACE"N I_Ovwrt'
    FS TYI SINK"N I_Def'
    Q4"N I_Narrow'
    MSet_Mode_Line_Hook+0U2	    !* Add in any other things the user wants.!
    FQ2"G G2'			    !* We used to tell him to return a string to be inserted.!
    I)__
    QBuffer_NameU2
    QBuffer_FilenamesU1
    Q1"N Q1F[D FILE		    !* Insert the buffer name unless it matches visited FN1.!
      F~(FS D FN1:F6)2"E 0U2''
    Q2"N I2:__'
    FQ1"G G1			    !* If there is a visited file, insert it,!
      FS OSTECO"N		    !* but on Twenex,!
	FQ1R FS H SNAME:F6U2
	FS OSTECO-1"E		    !* 20X,!
          FQ2 F~2"E FQ2D''	    !* leave the PS:<hsname> out.!
	"# 4 F~DSK:"E 4D	    !* 10X, delete DSK: if possible!
	    FQ2+2 F~<2>"E FQ2+2D'''
	ZJ FS D VERS"E -2D''	    !* And if the version is 0, leave it out.!
      FS D VERS"'E+(FS D VERS+2"'E)"L	    !* Include file's actual version number.!
        Q:.B(Q3+9!*Bufver!)U1
	I_( G1 I)'
      Q:.B(Q3+12!*Bufnwr!)"G I_(R-O)'
      Q:.B(Q3+12!*Bufnwr!)"L I_(Buf_R-O)'
      I_'
    ZJ Q.1<I]_> J Q.1,[I	    !* Put back on indicators of ^R level.!
    hf=..j"n hx..j'	    !* Set ..j unless no difference.  If same,!
				    !* keep old one since Teco can then avoid!
				    !* redisplaying the mode line.!
    0

!& Yes or No:! !S Read in a yes or no answer.
Returns -1 for yes, 0 for no.
Types " (Y or N)? " first.  Echoes the answer and then a CRLF.
An arg of 1 means use the echo area.  -1 means don't echo.
An arg of 1, means any character other than Y or N should be
returned as itself.!

  !Retry!
    +1"g "g @' ft_(Y_or_N)?_'  !* Say what answers we want, if desired.!
    fi:fc[1			    !* Read in the answer character.!
    +1"g "g @' ft1
'				    !* Echo the answer if desired.!
    q1f YN"l "N q1'	    !* Character not Y or N => maybe return it,!
		@fg o Retry'	    !* maybe try again.!
    q1-Y"e -1' 0		    !* Return -1 for yes, 0 for no.!

!& Read Filename:! !S Read a filename from the tty.
Return it as a TECO string object.
Numeric args are ignored, but supply one for Twenex compatibility.
The prompt should be supplied as a string argument;
it should not contain a trailing colon or space.!

    :I*[1
    QBuffer_Filenames[2
    FS D FILE[0

    FS RGETTY"E FS LISTEN"E
      :FT Default_is_0''	    !* On printing tty, type defaults since no mode line.!

    "# Q2"N F=02"N 0U2''
       Q2"E :I1 1_(Default_0)''	    !* On display, include defaults!
				    !* in the prompt if they aren't in mode line.!
    1,M(M.M &_Read_Line)1:_

!& F^K Hook:! !S The command normally called by F^K.
We call & Read Line;  if that returns 0, we make our caller exit.
Otherwise, we pass along the value.!

    FM(M.M &_Read_Line)F"N '
    -3 FS BACK RET

!& Read Line:! !S Read in and return a line of text with simple editing.
Takes a prompt-string as a string argument, and types it
when necessary.  A numeric argument is the initial
contents of the string to be accumulated.
The prompt string and initial contents are assumed to be
on the screen already, unless an argument of "1," is given,
in which case they are typed out at the beginning.
An arg of "2," means treat "?" like the Help character
(run FS HELP MAC).  "3," combines "1," and "2,".
"4,", the bit, means call & Read Filename, passing args to it.
"8,", the bit, means call & Read Command Name, passing args to it.
An attempt to rub out when the line is empty returns 0.!

    &8"n fm(m.m&_Read_Command_Name)[1w q1'
    &4"n f:m(m.m&_Read_Filename)'
    :I* [3			    !* Read in prompt string.!
    Q..O[B F[B BIND FQ()"G G()' [0
    QRead_Line_Delay[5
    FS Help Mac[D		    !* Save old Helpmac for Read Line Help to see.!
    M.M&_Read_Line_HelpF[HELP MAC
    FS ^R MODE"E  O SLOW'	    !* In non-^R, with system echoing, we can't delay it.!

!*** As long as we get nothing but ordinary characters, typed fast,!
!*** don't echo anything, but accumulate them in Q4 in case the typist!
!*** pauses or starts editing his input.!
    < Q5:"E -1U0 0;'
      QB[..O FIU0 ]..O
      Q0F?;	    !* Not a special character => just insert it.!
      Q0I >
    Q0-15."E			    !* If it's a ^M, just return the typed-ahead string!
       HX*'			    !* without ever echoing anything.!
    Q0 FS REREAD		    !* Got editing char => reread it and fall into slow loop.!

!*** Come here at the first pause > 1 second,!
!*** or at the first editing character.!

 !SLOW!
    FN @FT
        			    !* Clean up by outputting a CR, at the end.!
    &1"N  O Redisp'		    !* Arg of "1," means print the prompt at the beginning.!
    @HT				    !* Otherwise, print just what user has typed so far.!

!*** this is the loop that reads and echoes, once we have started echoing.!

 !LOOP!
    QB[..O FIU0
    &2"N Q0-?"E M(FS HELPMAC) ]..O O LOOP''
    ]..O
    Q0F"L		    !* Not a special character => just insert it.!
	Q0I			    !* Ordinary char - accumulate and echo.!
	FS^RMODE"N -1 @T'
	O LOOP'
    Q0F:"L @FT XXX?	    !* ^U and ^D flush accumulated input and reprompt.!
       HK U0'
    Q0-"E			    !* ^L redisplays the current string (for TTYs).!
 !Redisp!
       FSRGETTY"N :I*CFS ECHO DIS'
         "# :FT'
       @FT 3 @HT		    !* Type a CRLF, the prompt string and the current line.!
       O LOOP'
    Q0-177."E Z"E 0'		    !* Rubout:  if nothing to rub, just exit.!
	   ZJ 0AU0 -D		    !* Q0 gets character being rubbed.  Remove it from buffer.!
	   FSRGETTY"E @FT0 '	    !* Now show user:  by re-echoing if can't erase,!
				    !* or by erasure if we can.!
		    "# Q0-40."L :I*C FSECHO DIS @FT3 @HT'
			     "# :I*X FSECHO DIS ''
	   O LOOP'
    HX* 			    !* After CR, exit, returning accumulated string.!

!& Read Line Help:! !S FS Help Mac while inside & Read Line and M.I.!

!* QD should be nonzero if we are called from & Read Line.
If QD is zero, we give help for M.I instead of & Read Line.
A 1, argument means we are being called about
a recursive editing level.  QD should be zero in that case.
A 2, argument is like 1, but also means print only the name of the function.!

    QDF"N-(M.M ^R_Documentation)"N :MD'' !* If command provided special help mac, run it.!
    0[0 "N 1U0' [2 [4
    M.M &_Macro_Name[1
    :< -%0FS BACK STRINGU2	    !* Look up stack!
       1:< Q2M1U4 >		    !* for something with a name!
       Q4"N 0:G4-&:@;'	    !* which does not start with a &.!
       >[3
    "N Q3"L :FT You_are_at_top_level. 0'
	 :FT You_are_in_a_recursive_editing_level_inside_
	 -2"E FT4.'
	 "# Q2M(M.M Describe)'
	 FT
To_abort_the_command,_type_C-].__To_proceed_with_it,_type_C-M-
	 FS OSTECO"E FTC' "# FTZ' FT.

	 -2"E 
	   FT For_more_information_about_this_command,_use_Help_option_R.
'
	 1'
    QD"N
     FT You_are_entering_an_argument_to_a_command.
        Terminate_it_with_a_Return.__Rubout_cancels_one_character.
        C-U_cancels_the_argument.__C-L_retypes_the_argument.'
    "# FT You_are_typing_a_character_as_an_argument_to_a_command.'

    FT

    FS NOQUIT:"G FT C-G_aborts_the_command.__'
    Q3"L 0'			    !* Ran off end of stack?!
    FT The_command_is_
    Q2M(M.M Describe)		    !* Print doc of the command on the stack.!
    FT
Now_type_the_argument.
    0U..H f 

!& Make Dispatch String:! !S Create a dispatch string for ..D, F^A, etc.
First string arg is the default syntax for most characters.
Following string args contain a character and the syntax for it.
A null argument ends the call.  Example:
MM & Make DispatchAA:  ,   makes each entry "AA   "
except those for Colon and Comma, which are made "     ".
The resulting dispatch string is returned as a value.!

    F[B BIND [0 [1 [2
    I 5-ZF"G,32I' 5,ZK	    !* Fill or truncate 1st arg to 5 chars.!
    HFX1 128< G1 >		    !* initialize all chars to that.!
    < :I0			    !* Read next spec for one break char.!
      -FQ0;			    !* Null arg signifies end of list.!
      0:G0U1 1,5:G0U2		    !* Separate out 1st char of spec - it is the break char.!
      Q1*5 F2 >		    !* Put rest of spec in as its definition.!
    HX*			    !* Return the string we have constructed.!

!& Alter ..D:! !S Alters specified entries in ..D delimiter dispatch.
Followed by string arg made up of pairs of characters.
The first of a pair is the character to change;  the second
is the syntax for it.  The numeric arg should be 0
for modifying the word syntax, 1 for modifying the LISP syntax.
Example:  1M(M.M & Alter ..D)<(>) makes <,> act like (,).!

    [2 < u2 q2-33.@;
         q2*5+ :f..d  >
    

!& Default FS Superior:! !S A Default FS SUPERIOR function to allow autoloading
of various libraries, independent of where the editor is started or
what its JNAME is (primarily for LISPT, LEDIT, etc).!
   :"L ,0I 100100. FS EXIT'  !* Nonnegative arg means make space in bfr.!
   
   FS OSTECO"E FS %OPLSP"N 1,M.M LISPT_Command"E    !* If under LISP and LISPT not loaded!
               M(M.M Load_Library) DSK:EMACS;LISPT '''
   "L [1 0[2 F[B BIND FJ	    !* JCL supplied => gobble it!
	J :S,"L \U2'		    !* Extract charpos, if any.!
	J :S,"L R :K' HX1	    !* Extract filename.!
	F]B BIND
	0fo..qTags_Find_File"e
	  1,M(M.M Visit_File)1' !* Visit file specified.!
	"# m(m.mFind_File)1'    !* unless user generally likes Find File,!
	Q2J ]2 ]1'
   100100. FS EXIT		    !* exit silently !

!& Autoload:! !S Load a library temporarily and return ptr to function.
Do <args>M(M.A<library><function name>)<args to function>.
This leaves several things pushed on the q-register pdl,
so be sure to do a ^\ later.!

    f[:ejpage  fs qp ptr(	    !* Save fs :ejpage and leave it pushed when we exit.!
           :i*( :i*[3 )[1 !* Get filename in Q1 and function name in Q3.!
        )[4
    f~3<entry>"e :i3'		    !* If fn name is <entry>, must do q2m.m, below.!
    f[ d file 1f[fnam syntax
      fs hsnamefs dsname
      et DSK: _:EJ		    !* Read in library file name.!
      et1			    !* If only one name, it is FN1, and FN2 is :EJ!
    fs d fn1 @f6[2		    !* Get FN1 as string in Q2.!
    1,q2 M( M.M &_Get_Library_Pointer) u2
    q2"E			    !* Is that file in core?!
	 m(m.mLoad_Library)1u2' !* If not, load it.  It will be flushed later.!
    fq3"e q2M.M<entry> '	    !* If function name empty, use <entry> of that file;
 otherwise just look it up now that the file is loaded, so we find an MM-variable first.
!   "# M.M3'(
        q4 fs qp unwind	    !* Pop all but push of fs :ejpage,!
	f[:ejpage		    !* push new (incremented) value,!
	fn ]*-(fs:ejpage)"n ]*'   !* This will, at unwinding time,!
				    !* discard the saved original fs:ejpage$ value!
				    !* if more libraries are in core after this one.!
				    !* This fixes case of autoload library FOO,!
				    !* while running it load BAR permanently,!
				    !* then return from FOO and flush BAR too.!
	)			    !* Return the function to be run.!

!& Check Redefinition:! !S Verify that a certain command can be redefined.
Do not allow a command to be redefined unless it is undefined,
self-inserting, or a string starting with Temp.
The command is specified with a q-register name in a string
passed as a string pointer.!

    [1
    q1[0			    !* Q0 gets old definition.!
    fq0+1"g			    !* If old definition is a string not made by this function,!
      f~(0,6:g0)!Temp!"n	    !* don't let user clobber useful command.!
!lose!  !"! :I*Can't_clobber_specified_character_1 fs err''
    "# Afs^r init-q0"n
         200.@ fs^rinit-q0"n	    !* Don't redefine built-ins except error and self-insert.!
	   q0"n			    !* Undefined slots in dispatch prefix are 0.!
	     o lose''''
    

!& Make Variable:! !S Creates a variable (standard M.V).
After M.VFoo, you can use qFoo.
A numeric arg sets the variable;  
otherwise, it is set to 0 if it didn't already exist.!

    :i*[0
    < 0:G0-32:@; 1,FQ0:G0U0 >	    !* Flush leading spaces from name.!
    Q..Q[..O Q..Q[2
    @:FO20[1		    !* Search for var name in ..Q.  No abbreviations.!
    Q1"L -Q1U1 Q1*5J
	 1F[NOQUIT
	 Q:2(0)*5,0I Q0U:2(Q1) 0U:2(1+Q1) 0U:2(2+Q1)'
			    !* Create the var with value 0 if it doesn't already exist.!
    FF"N U0'	    !* If we have an arg, set the var.!
    Q:2(Q1+1)			    !* Return value of variable.!

!& Set Variable Comment:! !S Puts a comment on a variable (standard M.C).
Format:  M.CFOOThis variable is a test.
The comment string goes in the third word
of the three words in ..Q used by each variable.
A numeric argument, if any, is used to initialize the variable
if it didn't already exist.!

    :I*( :I* [3)[0	    !* Read two string args into Q0, Q3 (pushing them).!
				    !* We read both before setting in case second has ^]1.!
    < 0:G0-32:@; 1,FQ0:G0U0 >	    !* Flush leading spaces from name.!
    Q..Q[..O Q..Q[2
    @:FO20[1		    !* Search for var name in ..Q.  No abbreviations.!
    Q1"L -Q1U1 Q1*5J
	 1F[NOQUIT
	 Q:2(0)*5,0I Q0U:2(Q1) U:2(1+Q1)'
			    !* Create the var with value from arg if it doesn't already exist.!
    FQ3"E 0U3'
    Q3,Q1*5+10FSWORD		    !* Store second string in comment slot.!
    Q:2(Q1+1)			    !* Return value of variable.!

!& Count Lines:! !S Returns the number of lines in part of the buffer.
<m>,<n> M(M.M& Count Lines) returns the number of lines
between character <m> and character <n>.!

    [0 0U0
    [1 .U1  FN Q1J                 !* SAVE . IN CASE WE ERR!
    FF"N F[VBW F[VZW FFSBOUND'
    J <.-Z; L %0>
    Q0

!& Exit EMACS:! !S Prepare for exiting EMACS.
An argument means save the visited file.
We always do an auto save and run the user's Exit Hook;
also clear the mode line and home down.!

    0FO..Q Exit_HookF"N[0 FM0'   !* If hook is supplied, do that.!
    Q.F-Q..F"E			    !* If at top level,!
      FF"N M(M.M ^R_Save_File)'  !* do an explicit save if have arg,!
      FQ..F"G M..F''		    !* do autosave if appropriate.!
    :FR				    !* Clear mode line.!
    FS OSTECO"N :I*Z FS ECHODIS'
    "# :I*Z FS MPDIS'	    !* Home down so star comes at top of screen.!
    0FSECHO CHAR		    !* Don't echo after $P'ing on printing tty.!
    

!& End of Screen Address:! !S Return the address of the last char on the screen.
Chooses a window position if there isn't one already.!

				    !* First, we need to know how many lines!
    FS Lines"N FS Lines[2'	    !* FS Lines can override everything else!
	     "# FS Echo Lines[2    !* Else, start with echo lines!
	       q2"L -1*q2-1u2'	    !* which may be negative, compute cnt!
	       FS Height-q2-(FS Top Line)-1u2'    !* Then get lines in window!
    .[1 FN q1j 		    !* Arrange to restore point!
    FS Window"l :f'		    !* Make sure FS WINDOW is reasonable.!
    FS Window+bj		    !* Go to the start of the window.!
    1:<q2-1,(FS Width-1)FM>	    !* Move down correct number of screen lines!
    .				    !* and we must be there.!

!& Process Init Vars:! !S Process EVARS file; auto-loads from AUX.!

   :m(m.aAUX&_Process_Init_Vars)
       
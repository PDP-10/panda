!* -*-TECO-*- *!

!~FILENAME~:! !Support package for TeleVideo-9xx terminals
Sets up emacs to run nicely on 1200-baud and slower lines
and allows definition of up to 22 hard-coded function keys
on those TeleVideo terminals supporting them.!
TVI9xx

!& Setup TVI9xx Library:! !S Do initial setup for TeleVideos.
Loads the BARE library to get docs on built-in teco functions,
sets up line speed (teco flag 1FS OSPEED) to supress multitudes of
padding characters, defines Cntl-A as a prefix character, defines ^A^A
to be the standard ^A (^R Beginning of Line), modifies the teco flag
FS HELP MAC to provide documentation for Fkey definitions, and puts
some initial default assignments on several Fkeys.  If $TVI9xx Setup
Hook$ is defined, it is run afterwards to make any additional
assignments or changes.!

M(M.M load_library)BARE	    !* Get the BARE library !
FS tty macro [0		    !* Current tty mac pushed on q-reg 0 !
@:I*|1FS ospeed
 0| FS tty macro	!* Add redefinition of FS ospeed !
				    !* to beginning of fs tty macro      !
FS tty init			    !* Run tty init to process our tty macro!

[0 QPREFIX_CHAR_LISTU0	    !* Allow recognition of ^A as a prefix !
@:I*\0Control-A__QTVFUN	    !* character for doc functions by adding !
\UPREFIX_CHAR_LIST		    !* its name to the emacs variable    !
]0				    !* $prefix char list$                !

M.VTVFUN
128M(M.M MAKE_PREFIX_CHARACTER)TVFUNU.A   !* Make ^A a prefix char!
				    !* with 128 entries to handle lower case!

M.M ^R_Beginning_of_LineU:tvfun()    !* Two ^A in row runs standard !
				    !* ^A (in case I forget ^A is pfx char)!

FS help macro [0		    !* Push current help mac onto q-reg 0!
@:I*|0
!F!:I*CFkey:_FSECHODIS
@:I*\:M(M.M^R_Describe)\ [0 M0 2,M.I FI 
|FS help macro			    !* Add help function F to the help   !
				    !* macro to do the regular ^R Describe  !
				    !* but also gobble the <cr> from the fkey!

!* ---------------------- Default Fkey definitions ----------------------- !

12M(M.M_^R_SET_FKEY)^R_SET_FKEY   !* Make shifted F1 run ^R Set Fkey. !

!* ---------------------- End of defaults -------------------------------- !

  0FO..QTVI9xx_Setup_HookF"N [1 M1' !* run user hook if any!
  0

!^R Set Fkey:! !^R Assign Emacs function to TVI Function key.
For best performance call with C-M-X or assign to a key.  If given a numeric 
argument will interpret it as the Fkey on which to put the function. 
Unshifted Fkeys are numbered 1 through 11 and shifted Fkeys 12 through 22.
Without argument will attempt to read the Fkey from the terminal--you should
press the appropriate shifted or unshifted Fkey.  The function name will be
read from the terminal.!

 9,fFunction_name:_ [1	    !* Get Function name and put in q-reg 1 !
     m.m1 [2			    !* Get Function definition and put in qr 2!
     q2 m(m.m&_macro_name)u1	    !* Get full function name!
     ff&1"N			    !* If there is a postcomma arg!
        -12"L ( - 1 + @) [3'  !* Then use it as the fkey number and save!
             "# ( - 12 + `) [3' !* the corresponding Q-vector index in!
				    !* Q-reg 3!
        '
        "#   @ft_Put_1_on_fkey:_	    !* Else read the fkey from the tty!


              :i* m.i		    !* prepare to read without prompt!
              fi-"N :i*_Not_an_FKEY fs err'   !* check if 1st char is ^A!
              fi [3		    !* save ascii value of 2nd char in q-reg 3!
              2,m.i fi		    !* read and discard 3rd char (the CRLF)!
        '			    
    @:I*|FI W f@m(m.m1) |M.VMM_FKEY_1	    !* define a new!
				    !*function named FKEY <function name> !
				    !* which does the following!
				    !* 1.  reads and discard the CRLF!
				    !* 2.  runs the function named <function!
				    !* name> passing it any numeric arguments!
				    !* given to the fkey!
				    !* 3.  would pass it the string argument!
				    !* given to the FKEY but I can't figure!
				    !* out how to give it one therefore!
				    !* 4.  fools the function into thinking!
				    !* it is being run directly from a key!
				    !* rather than as an extended command!
				    !* so it will prompt for its string arg!

    qmm_fkey_1u:tvfun(Q3)	    !* put the def of FKEY <function name>!
				    !* in the dispatch table for ^A!

    @:I*|C_Which_runs_the_function_1.|m.vmm_~doc~_fkey_1
                                    !* create this!
				    !* variable containing the documentation!
				    !* for the documentation reader!
				    !* For proper documentation, use the !
				    !* help character with option F !
				    
    


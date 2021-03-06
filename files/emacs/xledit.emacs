!* -*-TECO-*- !

!* This file runs on both ITS and Twenex.
   KEEP IT THAT WAY!

!~FILENAME~:! !The teco half of lisp LEDIT editing system.!
LEDIT

!& Setup LEDIT Library:! !S Set up LEDIT variables and assign ^R commands.!
   
   0M.C LEDIT_LISP_JnameJob_name_of_LISP_job_to_return_to
   -1FO..Q LEDIT_Save_All_Files_Query M.C LEDIT_Save_All_Files_Query
                                   0_=_No_saving.
                                   1_=_Save_All_Files_with_querying.
				  -1_=_Save_current_buffer_without_query,
				        and_all_other_files_with_querying.
   0FO..Q LEDIT_Auto_Save M.C LEDIT_Auto_SaveIf_non-zero,_use_Auto_Save

   M.M &_LEDIT_Execute_JCL FS SUPERIOR
   FS OSTECO"N
     @:I*| M(M.M&_LEDIT_Execute_JCL) | M.V Return_from_Superior_Hook'
				    !* Upon return, execute JCL. !

   :IEditor_Type LEDIT

   FS OSTECO"E
      FS HSNAME:F6[1		    !* file goes on home directory !
      FS UNAME:F6[2		    !* second file name is user name so several can share !
      :I* DSK: 1; _LEDIT_2 M.V LEDIT_Filename'

   "# F[B BIND					  
      HK G(FS UNAME:F6)		    !* Strip off prefixes from UName.!
      -:S."L 0,.+1K'
      J ILEDIT-TEMPORARY-FILE.
      HX* M.V LEDIT_Filename
      F]B BIND'

   [..O				    !* Preserve temporary buffer if any!
   [Previous_Buffer		    !* Make buffer creation more transparent to user!
   M(M.M Select_Buffer) *LEDIT*   !* Create the buffer *LEDIT* in Lisp mode!
   Q:.B(QBuffer_Index+4) M.C LEDIT_BufferHolds_s-exp's_to_return_to_lisp
   M(M.M Lisp_Mode)
   M(M.M Select_Buffer)	    !* Return to previous selected buffer!

   0FO..Q LEDIT_Setup_Hooku1	    !* see if setup hook defined !
   FQ1"G M1'			    !* if so, run it, otherwise default key assignments !
   "# M.M ^R_LEDIT_Save_DEFUN U..Z
      M.M ^R_LEDIT_Zap_to_LISP U:.X(Z)
      M.M ^R_LEDIT_Save_Region U:.X(C)
      FS OSTECO"E
        M.M ^R_LEDIT_Save_Region U...Z''

   FS LispT"N			    !* If Started by Superior on TOPS-20, !
      M(M.M&_LEDIT_Execute_JCL) '  !* then execute any JCL it passed. !
   

!& LEDIT Execute JCL:! !S Run when tty returned to TECO.
If there is JCL, then execute it.  Otherwise do nothing.!

 1:@<
   [0
   F[B BIND			    !* Make temporary buffer for JCL processing.!
   FJ				    !* Get JCL. into 0!
   HX0
   F]B BIND			    !* Note: execution of jcl typically may switch buffers !
   FS OSTECO"E M0'
   "# FS XJName [1		    !* Put Name from JCL into Q Register 1. !
      F~1LEDIT "E M0 ''	    !* Execute JCL only if for LEDIT. !
   >
 

!& LEDIT Find Tag:! !S Like ^R Find Tag, except takes string argument.!

    0FO..Q Tag_Table_Buffer"E	    !* If no tag table selected, select one.!
      5,M(M.M &_Read_Line) Tag_Table[1    !* Read tag table name.!
      FQ1-1"L '
      M(M.M Visit_Tag_Table)1'  !* Select it.!
    QTag_Table_FilenamesF[D FILE
    :I* :M(M.M &_Find_Tag_Display)


!& LEDIT Find File:! !S Find File insuring Logical Device Name expansion (TWENEX).
The standard Find File function, when invoked by m(m.m Find File)device:
fails to properly expand Logical Device Names, often causing it to select
a bogus buffer name.  This function calls the standard Find File after
forcing the Logical Device Name expansion. !

   [0				    !* Save Q Register 0. !
   F[D File			    !* Save Default File Names. !
   F[I File			    !* Save Input File Names. !
   1:< ER EC>		    !* Open and Close the File Name
				       to set FS I File to the true file. !
   0 FS I F Version		    !* But force Version Number to 0. !
   FS I FileU0			    !* Put true File Name in Q Register 0. !
   F]I File			    !* Restore Input File Names. !
   F]D File			    !* Restore Default File Names. !
   M(M.M Find_File)0	    !* Call standard Find File. !
   ]0				    !* Restore Q Register 0. !
   				    !* Return. !

!^R LEDIT Find Function:! !^R Find Function in Buffer.
This function will find a Lisp Function in the buffer, repeatedly searching
greater and greater portions of the File centering its search about an
approximate location of the Function.  This function will search for a string
of the form ^J, ^M, or ^L followed by "(DEFUN <Function Name> ".  If called
from ^R Mode, the function will prompt for a function name.  The format of the
Teco call is:

<Approximate Location>M(M.M & LEDIT Find Function)<Function Name>

If no <Approximate Location> is given or if the function is called with more
than one argument, then the entire file is searched starting from the
beginning. !

   .[0				    !* Save Point in Q Register 0. !
   FS VB[1			    !* Save Virtual B in Q Register 1. !
   FS VZ[2			    !* Save Virtual Z in Q Register 2. !
   0 FS VB			    !* Expand to search entire file. !
   0 FS VZ			    !* Expand to search entire file. !
   1,FFind_Function:_[3	    !* Put Function Name in Q Register 3. !
   FF-1"E			    !* Execute if exactly one argument... !
      F[4			    !* Save center of search in Q Register 4. !
      1000[5			    !* Radius in Characters to search. !
      <Q4-Q5:J;			    !* Start of this pass of search. !
         <.,Q4+Q5 :FB(DEFUN_3_;	    !* Search for Function, !
	    13,FKA F_
"G '>	    !* returning if found. !
         Q5*3U5>		    !* Search 3 times as far on next pass. !
      ]5 ]4 '			    !* Restore Registers. !
				    !* No Luck -- Search Entire File. !
   J				    !* Start at beginning of Buffer. !
   <:S(DEFUN_3_;		    !* Search for Function, !
      13,FKA F_
"G '>	    !* returning if found. !
				    !* Error if unable to find Function. !
   Q2 FS VZ			    !* Restore Virtual Z. !
   Q1 FS VB			    !* Restore Virtual B. !
   Q0 J				    !* Restore Point. !
   :I* Unable_to_find_function_3  FS Err
   				    !* Return and Print Error Message. !

!^R LEDIT Save Region:! !LEDIT Save Region ~:! !C Stores region between mark and point to be returned to LISP.
Stuff is appended to the contents of the buffer kept in QLEDIT Buffer
If given argument (e.g. ctl-U), also selects buffer *LEDIT*!

   M(M.M &_LEDIT_Save_Region)
   FF"N M(M.M Select_Buffer) *LEDIT*'
   0

!& LEDIT Save Region:! !S Stores region between mark and point to be returned to LISP.
Stuff is appended to the TECO buffer in LEDIT Buffer (the EMACS buffer *LEDIT*).
A pair of arguments may be given instead of the mark, if called from a teco pgm!

    F[VB F[VZ			    !* Push bounds.!
    FF"E :,.' "# F' F  FS BOUND   !* binding them to the region.!
    Q..O[3
    QLEDIT_Buffer[..O		    !* Insert the region into the buffer of stuff to zap.!
    ZJ				    !* Make sure pointer at end of buffer !
    G3 0

!^R LEDIT Save DEFUN:! !^R Stores the toplevel list the pointer is in to be returned to LISP.
If the pointer is between lists, the following list is stored.
If numeric argument is given, then also select buffer *LEDIT*.!

    M(M.M ^R_Mark_DEFUN) !* MARK LIST!
    M(M.M &_LEDIT_Save_Region)	    !* SAVE IT!
    FF"N M(M.M Select_Buffer) *LEDIT*'
    0

!^R LEDIT Zap to LISP:! !^R Returns to LISP
If called with no argument, writes out *LEDIT* buffer to be returned to LISP,
   and save files according to LEDIT Save All Files Query.
If called with non-zero argument, writes out *LEDIT* buffer only and returns.
If called with zero argument, just goes directly back to LISP
   discarding the changes which were saved instead of zapping them.
String argument is LISP jname, if currently zero.!
 
    FS QP PTR[P
    QLEDIT_Save_All_Files_Query[2
    FF"E Q2"L QLEDIT_Auto_Save"E 1,M(M.M ^R_Save_File)'
                                    "# 1,1M(M.M ^R_Save_File)''
             Q2"N WM(M.M Save_All_Files)'''


    :I2 NIL			    !* initialize 2 with NIL !
    QLEDIT_Buffer[..O		    !* select *LEDIT* buffer !

    Z"N				    !* write out file only if something in buffer !
       FF"'E+("'N)"N	    !* If either no arg or nonzero arg,!
	  F[D FILE		    !* then write out *LEDIT* buffer.!
	  FS OSTECO"N FS MSNAME FS DSNAME'
	  QLEDIT_Filename[1
	  ET 1
	  FS D FILEU2  :I2|2|
	  EIHPEF		    !* write buffer !
	  ]1 F]D FILE'
       HK '			    !* clear buffer !
    ]..O

    FS OSTECO"N	    !* On Twenex, Lisp is our superior.  Just return.!
     F~2 NIL"E :I2' "# :I2_'
     :M(@:I*|
      :FR			    !* Clear Mode Line. !
      :I*Z FS Echo Display	    !* Put cursor at bottom of screen. !
      0 FS Echo Char		    !* Dont echo when continued. !
      2			    !* Return to Superior after putting
				       a Blank into the ReScan buffer if there
				       is information for Lisp to read in. !
      M(M.M &_LEDIT_Execute_JCL)   !* Upon return, execute JCL. !
       |)'			    !* Return. !

    QLEDIT_LISP_Jname"E	    !* ask for lisp jname if none !
       1,F LISP_Jname:_ ULEDIT_LISP_Jname '

    QLEDIT_LISP_Jname[0	    !* put together valret string !
    FS JNAME:F6[1
    :m( @:i*`   0 $J :JCL_(1_2)
$P` (QPFSQPUN))

!^R LEDIT Zap DEFUN to LISP:! !^R Save Defun and Zap to LISP
Takes same arguments as LEDIT Zap to LISP, but saves the
current DEFUN and then zaps it immediately.!

   "N 1M(M.M ^R_Mark_DEFUN)	    !* mark defun !
        M(M.M &_LEDIT_Save_Region)'	    !* save it !
   F@:M(M.M ^R_LEDIT_Zap_to_LISP)	    !* zap to lisp !

!COMPLR Inferior:! !C Call COMPLR as Inferior (on Twenex only)
or continue it if we have one already.  An argument means to kill fork. !

   0 FO..Q COMPLR_Fork[2	    !* Create COMPLR Fork Handle Varable
				       or get old Fork Handle and put
				       into Q Register 2. !
   FF"N			    !* If there is an Argument, !
      Q2"N -Q2FZ'		    !* and there is a Fork, then Kill Fork. !
         0 UCOMPLR_Fork	    !* Remember that there is no Fork. !
         0			    !* Nothing changed in Buffer. !
          '			    !* Return. !
   :FR				    !* Clear mode line. !
   :I*Z FS Echo Display	    !* Put cursor at bottom of screen. !
   0 FS Echo Char		    !* Dont echo when continued. !
   Q2F"N FZ			    !* Continue old Fork if one exists. !
      0				    !* Nothing changed in Buffer. !
       '			    !* Return. !
   FZ PS:<Maclisp>Complr.Exe M.V COMPLR_Fork !* Start new COMPLR Fork
				                  and save Fork Handle. !
   0				    !* Nothing changed in Buffer. !
   				    !* Return. !

!LEDIT ReCompile:! !C Check for FASL files to recompile (TWENEX).
When called with no arguments, takes directory from current default file.
Takes directory as string argument, or prompts when put on a ^R character
and called with numeric argument. !

   [0 [1 [2 [3			    !* Save Q Registers 0, 1, 2, & 3. !
   QBuffer_FilenamesU0	    !* Put Buffer Filenames in Q Register 0. !
   Q0"N ET0'			    !* Use Buffer Filenames as Default. !
   FF"N 5,2F DirectoryU0	    !* Read Directory if appropriate. !
      FQ0"L  '		    !* Rubout past start, return. !
         ET0 '		    !* Set up Default File Names. !
   FS D SNameU2		    !* Put Default Directory in Q Register 2. !
   FS D DeviceU3		    !* Put Default Device in Q Register 3. !
   FTChecking_3:<2>_for_FASL_files_to_recompile...
				    !* Print Message. !
   E[ FN E]			    !* Push input file. !
   F[B Bind			    !* Save Buffer. !
   EZ*.FASL			    !* Get Directory Listing of .FASL files
				       (only the highest version numbers). !
   J				    !* Beginning of Buffer. !
   <:S.FASL; 0F -5X1		    !* Put Filename in Q Register 1. !
      2S,			    !* Move to Start of its Creation Date. !
      1:<1,ER1.LSP>"E	    !* Open corresponding .LSP file and
				       compare Creation Dates. !
         (FS FDConvert)-(FS If CDate)"L !* But dont set Reference Date. !
         FT 1_needs_ReCompilation.
 '				    !* Print Message if ReCompilation needed. !
         EC'                 	    !* Close file. !
      "# FT 1.LSP_not_found.
 ' >				    !* Print Message if .LSP file not found. !
   FTDone.
				    !* Print Message. !
   0				    !* Nothing changed in Buffer. !
   				    !* Return. !

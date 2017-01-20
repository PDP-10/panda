(FILECREATED "23-Apr-84 17:11:15" <LISPUSERS>EMACS.LSP.40423 32551  

      changes to:  (FNS BytePointer Down DumpLines EMACS EmacsPP 
			EmacsTerminalSetup EmacsReturn MapBytes 
			PageOfByte ReadEditResult)

      previous date: " 1-Apr-83 15:09:21" <LISPUSERS>EMACS.LSP.30401)


(PRETTYCOMPRINT EMACSCOMS)

(RPAQQ EMACSCOMS ((FNS * EMACSFNS)
	(BLOCKS * EMACSBLOCKS)
	(RECORDS PROCESS)
	(VARS * EMACSVARS)
	(PROP MACRO Left Right)
	(LISPXMACROS LEDIT)
	(P (RPAQ emacsReadTable (COPYREADTABLE FILERDTBL))
	   (SETSYNTAX 3 '(MACRO IMMEDIATE (LAMBDA (FL RDTBL)
						  (ERROR 
					     "End of EMACS buffer!")))
		      emacsReadTable))
	(ADDVARS (BEFORESYSOUTFORMS (FlushEmacs)))
	(P (/NCONC AFTERSYSOUTFORMS '((EmacsTerminalSetup)
		    (StartEmacs))))
	(DECLARE: EVAL@COMPILE DONTCOPY (FILES (SYSLOAD FROM LISPUSERS)
					       CJSYS))
	(P (StartEmacs))))

(RPAQQ EMACSFNS (BinaryMode BytePointer CallEmacs ClearScreen Down 
			    DumpLines EnterEmacs EMACS EmacsPP 
			    EmacsSubsys EmacsTerminalSetup 
			    Enable^CCapability EmacsReturn 
			    FixBreakMacros FlushEmacs LEDIT Left 
			    MapBytes MapProcessToFile OtherWindow 
			    PageOfByte ReadAc ReadEditResult Right 
			    SFCOC STIW ScratchBuffer ScratchFile 
			    SetEmacsVars SetupBreakMacros 
			    SetupEmacsDribble Stack StartEmacs 
			    WriteRscan))
(DEFINEQ

(BinaryMode
  (LAMBDA NIL                                   (* edited: 
						"11-Sep-79 20:27")

          (* We turn off Bit 29 in the JFN mode word of the 
	  controlling terminal. If the user is in ASCII mode, 
	  this puts him in binary mode, which is what is 
	  required by EMACS)


    (JS SFMOD (LOGAND (LOGXOR (LLSH 1 6)
			      -1)
		      (JS RFMOD 101Q NIL NIL 2)))))

(BytePointer
  (LAMBDA (base offset)                         (* edited: 
						"14-Sep-79 22:29")
    (IPLUS
      base
      (LOGOR
	(LLSH (LOGOR (LLSH (ADD1 (ITIMES 7 (IDIFFERENCE
					   5
					   (IREMAINDER offset 5))))
			   12)
		     (LLSH 7 6))
	      18)
	(IQUOTIENT offset 5)))))

(CallEmacs
  (LAMBDA (process binFlg start)                (* edited: 
						"13-Sep-79 20:46")

          (* Procedure to call EMACS. If luser types ^C we 
	  exit from LISP and dive back to EMACS when we are 
	  continued)


    (PROG (proc)
          (SETQ proc (EmacsSubsys process binFlg start))
          (while (NOT (ZEROP (LOGAND 17179869184
				     (JS RWM (fetch FORK of proc)
					 NIL NIL 2))))
	     do                                 (* Test is true iff 
						EMACS was exited with a 
						^C)
		(JS HALTF)
		(DISMISS 1000)
		(SETQ proc (EmacsSubsys proc binFlg start)))
          (RETURN proc))))

(ClearScreen
  (LAMBDA NIL                                   (* edited: 
						"10-Feb-80 20:34")

          (* Clears the screen for whatever type of terminal 
	  this is. We write directly with the SOUT jsys to 
	  prevent the screen blanking sequence from being 
	  written on the dribble file.
	  It is assemble code so we can call the UPATM coreval
	  to get string pointers.)


    (ASSEMBLE NIL
	      (CQ CLEARSCREEN)
	      (FASTCALL UPATM)
	      (MOVE 2 , 3)
	      (MOVN 3 , 4)
	      (MOVEI 1 , 101Q)
	      (JS SOUT)
	      (JFCL)
	      (MOVE 1 , KNIL))))

(Down
  (LAMBDA (flag)                                (* edited: 
						"14-Sep-79 10:20")

          (* This is the main function of the EMACS interface 
	  for diving down into EMACS. Once StartEmacs has been
	  called, DOWN may be called at any time to enter 
	  EMACS. The ^RExit to Lisp will exit from EMACS and 
	  return to DOWN. When DOWN calls EMACS, it pases to 
	  EMACS a number whose absolute value is the current 
	  file pointer of the file EMACS.TEMP.
	  The number is passed to a teco macro in FSSUPERIOR 
	  which is invoked when EMACS gains control.
	  If the arg to DOWN is NIL then the current file 
	  pointer is passed and EMACS simply inserts the text 
	  at the end of the buffer. If Down is given the arg 
	  T, then the negative of the current file pointer is 
	  passed. EMACS takes a negative number to be the 
	  instruction to insert that much text in q-register 
	  a, delete the text and macro A.
	  Thus, if you wimply want to insert some text into 
	  the EMACS buffer, just print that text into 
	  EMACS.TEMP and call (DOWN). But if you want a 
	  fancier event to occur when EMACS gains control, 
	  then print teco code to EMACS.TEMP and then call 
	  (DOWN T))


    (PROG (temp)
          (SETQ temp (GETFILEPTR emacsTempFile))
          (CLOSER (GETPROP 'emacsArg 'EMACS.LOC)
		  (COND
		    (flag (IMINUS temp))
		    (T temp)))
          (SETFILEPTR emacsTempFile 0)
          (SETQ LASTEMACS (CallEmacs LASTEMACS T 'START))
                                                (* Now make sure the 
						luser exits from EMACS 
						with a ^T command)
          (ClearScreen)
      LOOP(SetEmacsVars)
          (COND
	    ((NOT (ZEROP emacsExtrac))
	      (printout T T 

"Illegal exit from EMACS. Use a ^T command.
(The gap is not closed). Returning to EMACS."
			T)
	      (DISMISS 3000)
	      (SETQ LASTEMACS (CallEmacs LASTEMACS T))
	      (GO LOOP))))))

(DumpLines
  (LAMBDA (n)                                   (* edited: 
						"23-Mar-81 22:11")

          (* Dumps n lines from the DRIBBLE file to the 
	  terminal to refresh after returning from EMACS)


    (PROG (end lineCount ptr char jfn)
          (SETQ end (GETEOFPTR emacsDribbleFile))
          (SETQ lineCount 0)
          (SETQ jfn (OPNJFN emacsDribbleFile))

          (* Now RIN characters from the dribble file until 
	  either n CRs have passed, or the beginning of the 
	  file is reached)


          (SETQ ptr (IPLUS end))
          (while (AND (IGREATERP ptr 0)
		      (ILESSP lineCount n))
	     do (SETN char (JS RIN jfn NIL ptr 2))
		(SETN ptr (SUB1 ptr))
		(COND
		  ((EQP char 13)
		    (add lineCount 1))))
          (SETN ptr (IPLUS ptr 2))

          (* We copy the bytes bypassing the INTERLISP I/O 
	  system because in the event that the user created 
	  the dribble file, LISP will not recognize the file 
	  name)


          (for i from 1 to (IDIFFERENCE end ptr)
	     do (JS BOUT 101Q (JS BIN jfn NIL NIL 2))))))

(EnterEmacs
  (LAMBDA NIL
    (DECLARE (LOCALVARS . T)
	     (SPECVARS exp))                    (* edited: 
						" 7-Dec-80 16:01")

          (* Mike Genesereth%'s hack. It expects one of 
	  several things to happen -
	  either a normal return from Emacs, in which case the
	  first s-expression from the buffer is read and 
	  evaluated. If there is a multi-return, then the 
	  whole buffer of s-expressions is evaluated.
	  If the return is abort, then no s-expressions are 
	  evaluated and NIL is returned.)


    (PROG ((exp (<NIL>))
	   newExp)
          (SETFILEPTR emacsTempFile 0)
          (printout emacsTempFile "FS TTYINI-1FS PJATY")
          (Down T)
          (newExp_(EmacsReturn))
          (DumpLines REFRESH.LINE.COUNT)
          (if (newExp is equal to exp)
	      then                              (* This was an abort 
						return)
		   (RETURN NIL)
	    elseif newExp:1=%'***Multi***
	      then (for x in newExp::1 do (LISPXEVAL x '_))
		   (RETURN newExp::1)
	    else                                (* Single sexp return)
		 (LISPXEVAL newExp '_)
		 (RETURN <newExp>)))))

(EMACS
  (LAMBDA (exp fnFlg)                           (* edited: 
						"25-Sep-79 22:21")
    (DECLARE (SPECVARS exp fnFlg))

          (* This function is the interface between the lisp 
	  EDITOR and EMACS. The expression exp is written to 
	  the emacs temp file, and we pass control to EMACS.
	  Smash the changed exp into the original, to allow 
	  editing of expressions and have results EQ to 
	  original)


    (PROG (newExp)
          (EmacsPP exp fnFlg)
          (Down)
          (SETQ newExp (EmacsReturn))
          (DumpLines REFRESH.LINE.COUNT)
          (COND
	    ((NOT (EQUAL exp newExp))
	      (COND
		(EDITCHANGES (RPLACA (CDR EDITCHANGES)
				     T)))
	      (/RPLACA exp (CAR newExp))
	      (/RPLACD exp (CDR newExp))
	      (COND
		((EQ (CADDR EDITCHANGES)
		     'FNS)
		  (FIXEDITDATE exp)))
	      (RETURN exp))
	    (T (RETURN exp))))))

(EmacsPP
  (LAMBDA (form flg samepos)                    (* edited: 
						"21-Nov-80 23:55")
                                                (* Pretty prints a form 
						on EMACS.TEMP for 
						reading by th editor)
    (COND
      ((NOT samepos)
	(SETFILEPTR emacsTempFile 0)))
    (RESETLST (RESETSAVE (OUTPUT emacsTempFile))
	      (RESETSAVE CHANGECHAR NIL)
	      (RESETSAVE FONTCHANGEFLG NIL)
	      (RESETSAVE #RPARS NIL)
	      (RESETSAVE (GCGAG NIL))
	      (COND
		(flg (PRINTDEF form 1 T))
		(T (PRINTDEF form 1 NIL))))))

(EmacsSubsys
  (LAMBDA (process binaryFlg start)             (* edited: 
						"14-Sep-79 10:57")

          (* A straightforward call to SUBSYS loses in this 
	  instance because EMACS diddles the terminal 
	  interrupt words, control character output control 
	  and the binary/ascii mode word.
	  This procedure tries to do the right thing to 
	  preserve the original status when the lower fork 
	  returns)


    (PROG (fork tiw coc)
          (COND
	    ((LITATOM process)
	      (Enable^CCapability)
	      (SETQ fork process)
	      (SETQ tiw (STIW))
	      (SETQ coc (SFCOC)))
	    (T (SETQ fork (fetch FORK of process))
	       (SETQ tiw (fetch TIW of process))
	       (SETQ coc (fetch COC of process))))
          (RETURN (RESETFORM (STIW tiw)
			     (RESETFORM (SFCOC coc)
					(PROG (handle)
					      (COND
						(binaryFlg (BinaryMode))
						)
					      (SETQ handle
						(create PROCESS
							FORK _(SUBSYS
							  fork NIL NIL 
							  start)))
					      (replace TIW of handle
						 with (STIW))
					      (replace COC of handle
						 with (SFCOC))
					      (RETURN handle))))))))

(EmacsTerminalSetup
  (LAMBDA (type)                                (* cvs "23-Apr-84 17:10"
)

          (* Sets up the value of CLEARSCREEN for whatever 
	  type of terminal this happens to be)


    (SETQ terminalSpeed (Right (JS MTOPR 101Q 27Q NIL 3)))
    (SETQ REFRESH.LINE.COUNT (IMIN (IQUOTIENT (ITIMES terminalSpeed 15)
					      1200)
				   20))
    (SELECTQ type
	     (DATAMEDIA-2500 (PROGN CLEARSCREEN_(MKSTRING
				      (FCHARACTER 30))
				    (ECHOCONTROL 30 'REAL)))
	     (TELERAY-1061 (PROGN CLEARSCREEN_(MKSTRING (PACKC
							  <27 106>))))
	     (HEATH-19 (PROGN CLEARSCREEN_(MKSTRING (PACKC <27 69>))))
	     (CONCEPT-100 (PROGN (SETQ CLEARSCREEN
				   (MKSTRING (PACKC (LIST 27 112 13 10))
					     ))))
	     (PROGN                             (* Unknown terminal 
						types do not have a 
						clear-screen sequence)
		    CLEARSCREEN_(MKSTRING (PACKC <126 126 12 13>))))))

(Enable^CCapability
  (LAMBDA NIL                                   (* edited: 
						"11-Sep-79 21:38")
    (JS EPCAP 400000Q 0 (XWD 400000Q 0))))

(EmacsReturn
  (LAMBDA (flg)                                 (* edited: 
						"23-Mar-81 22:15")

          (* This function is called after returning from 
	  EMACS. It looks at the return code from the ^T 
	  command used to exit and does the appropriate thing.
	  If flg is non-NIL then we assume we%'re being called
	  from LEDIT)


    (PROG (arg1 form)
          (SETQ arg1 (Left emacsFsexit))
          (RETURN
	    (SELECTQ arg1
		     (0                         (* Normal return to get 
						edit result)
			(ReadEditResult))
		     (1                         (* CLISPIFY the entire 
						buffer)
			form_
			(CLISPIFY (ReadEditResult))
			(EmacsPP form fnFlg)
			(Down)
			(EmacsReturn flg))
		     (2                         (* DWIMIFY the entire 
						buffer)
			form_
			(DWIMIFY (ReadEditResult)
				 T)
			(EmacsPP form fnFlg)
			(Down)
			(EmacsReturn flg))
		     (3                         (* Pretty-print the 
						entire buffer)
			(EmacsPP (ReadEditResult)
				 fnFlg)
			(Down)
			(EmacsReturn flg))
		     (4                         (* Undo edit by 
						re-printing the original
						sexp)
			(EmacsPP exp fnFlg)
			(Down)
			(EmacsReturn flg))
		     (5 

          (* ABORT: reurn original sexp if we%'re under lisp 
	  editor, otherwise we retfrom LEDIT)


			(if flg
			    then (DumpLines REFRESH.LINE.COUNT)
				 (RETFROM 'LEDIT)
			  else exp))
		     (6 

          (* Read an s-expression from user and print its 
	  value in the other window)


			(printout T "*")
			(OtherWindow (EVAL (READ)))
			(EmacsReturn flg))
		     (7                         (* Evaluate sexp after 
						point and print in other
						window)
			(OtherWindow (EVAL (ReadEditResult)))
			(EmacsReturn flg))
		     (8                         (* Return a specially 
						flagged list of all s 
						expressions in buffer)
			<%'***Multi*** ! (ReadEditResult)
			>)
		     (9                         (* Just eval 
						s-expression and return 
						to editor)
			(EVAL (ReadEditResult))
			(SETFILEPTR emacsTempFile 0)
			(printout emacsTempFile "FS TTYINI-1FS PJATY"
				  )
			(Down T)
			(EmacsReturn flg))
		     (10 

          (* Evaluate variable under NLSETQ and print the 
	  result in the EMACS scratch buffer)


			 (ScratchBuffer
			   (CAR (NLSETQ (EVAL (ReadEditResult)))))
			 (EmacsReturn flg))
		     (11 

          (* Get the function definition typed by user to LISP
	  and pretty print it to the other window in function 
	  format)


			 (printout T "Function: ")
			 functionName_
			 (READ)
			 functionDef_
			 ((GETDEF functionName NIL NIL
				  '(NODWIM NOERROR))
			    or %'               (* Function undefined))
			 (OtherWindow functionDef T)
			 (EmacsReturn flg))
		     (PROGN (printout T T 
				     "Unimplemented return code - "
				      arg1 T)
			    exp))))))

(FixBreakMacros
  (LAMBDA NIL                                   (* edited: 
						"26-Nov-80 09:43")
                                                (* Restore break macros 
						to their original state)
    (RPLACD (FASSOC 'BTV BREAKMACROS)
	    (LIST '(BAKTRACE LASTPOS NIL (BREAKREAD 'LINE)
			     1 T)))
    (RPLACD (FASSOC 'BTV+ BREAKMACROS)
	    (LIST '(BAKTRACE LASTPOS NIL (BREAKREAD 'LINE)
			     5 T)))
    (RPLACD (FASSOC 'BTV* BREAKMACROS)
	    (LIST '(BAKTRACE LASTPOS NIL (BREAKREAD 'LINE)
			     7 T)))
    (RPLACD (FASSOC 'BTV! BREAKMACROS)
	    (LIST '(BAKTRACE LASTPOS NIL (BREAKREAD 'LINE)
			     47 T)))))

(FlushEmacs
  (LAMBDA NIL                                   (* edited: 
						"21-Nov-80 21:54")

          (* This function gets rid of the EMACS fork and 
	  closes the 3 temporary files that EMACS uses)


    (COND
      (LASTEMACS (KFORK (fetch FORK of LASTEMACS))
		 (SETQ LASTEMACS NIL)))
    (UNADVISE EDITL)
    (FixBreakMacros)
    (COND
      ((OPENP EMACS.MAP.FILE)
	(CLOSEF EMACS.MAP.FILE)))
    (COND
      ((OPENP EMACS.TEMP.FILE)
	(CLOSEF EMACS.TEMP.FILE)))
    (COND
      ((OPENP EMACS.DRIBBLE.FILE)
	(DRIBBLE)))
    (COND
      ((NUMBERP ourBlockStart)                  (* Make sure pages are 
						unmapped before 
						releasing the block)
	(JS PMAP -1 (XWD 400000Q (LLSH ourBlockStart -11Q)))
	(COND
	  ((EQ emacsBlockSize 2)
	    (JS PMAP -1 (XWD 400000Q (LLSH ourBlockStart -11Q)
			     + 1))))
	(NLSETQ (RELBLK (VAG ourBlockStart)
			emacsBlockSize))
	(SETQ ourBlockStart NIL)))))

(LEDIT
  (LAMBDA NIL                                   (* edited: 
						"23-Mar-81 22:45")

          (* This function simulates MACLISP LEDIT.
	  It just goes down to the editor, then has function 
	  LeditReturn which works kind of like EmacsReturn, 
	  except it doesn%'t assume it%'s being called under 
	  the editor)


    (PROG (sexp)
          (SETFILEPTR emacsTempFile 0)
          (Down T)
          (sexp_(EmacsReturn T))
          (DumpLines REFRESH.LINE.COUNT)
          (RETURN (LISPXEVAL sexp)))))

(Left
  (LAMBDA (word)                                (* edited: 
						"11-Sep-79 20:19")

          (* Returns the left half of a word.
	  MACRO is compiled open for efficiency)


    (LOGAND (LLSH word -18)
	    262143)))

(MapBytes
  (LAMBDA (start end)                           (* edited: 
						"10-Feb-80 20:37")

          (* PMAP all pages of the EMACS process from start to
	  end to the EMACS.MAP file)


    (for i from (PageOfByte start) to (PageOfByte end)
       do (MapProcessToFile (fetch FORK of LASTEMACS)
			    i emacsMapFileJfn
			    (COND
			      ((IEQP i (PageOfByte start))
				(IREMAINDER start 2560))
			      (T 0))
			    (COND
			      ((IEQP i (PageOfByte end))
				(IREMAINDER end 2560))
			      (T 2560))))))

(MapProcessToFile
  (LAMBDA (process page jfn startByte endByte)
                                                (* edited: 
						"14-Sep-79 10:43")
    (JS PMAP -1 (XWD 400000Q emacsMapBlockPage))
    (JS PMAP (XWD process page)
	(XWD 400000Q emacsMapBlockPage)
	(XWD 100400Q 0))
    (JS SOUT jfn (BytePointer (LOC emacsMapBlock)
			      startByte)
	(IDIFFERENCE endByte startByte))))

(OtherWindow
  (LAMBDA (sexp fnflg)                          (* edited: 
						"27-Dec-80 22:40")
                                                (* Prints an 
						s-expression into window
						W2)
    (PROG (fixPos tecoPos endPos)
          (SETFILEPTR emacsTempFile 0)
          (printout emacsTempFile 
	 "FS TTYINI0FO..QWindow 2 Size%"E M(M.M^R Two Windows)'"
		    T 
	    "%"#M(M.M^R Other Window)' M(M.MSelect Buffer)W2HK"
		    T)
          (fixPos_(GETFILEPTR emacsTempFile))
          (printout emacsTempFile "     FYJM(M.M^R Other Window)"
 "-1FS PJATY")
          (tecoPos_(GETFILEPTR emacsTempFile))
          (EmacsPP sexp fnflg T)
          (endPos_(GETFILEPTR emacsTempFile))
          (SETFILEPTR emacsTempFile fixPos)
          (printout emacsTempFile (endPos-tecoPos))
          (SETFILEPTR emacsTempFile tecoPos)
          (Down T))))

(PageOfByte
  (LAMBDA (byte)                                (* edited: 
						"13-Sep-79 20:14")
    (PROG (quo rem)
          (SETQ quo (IQUOTIENT byte 5))
          (SETQ rem (IREMAINDER byte 5))
          (RETURN (LLSH (COND
			  ((ZEROP rem)
			    (ADD1 quo))
			  (T quo))
			-9)))))

(ReadAc
  (LAMBDA (process ac)                          (* edited: 
						"13-Sep-79 20:55")
                                                (* Returns the contents 
						of an ac for inferior 
						process)
    (PROG ((acBlock (CONSTANT (ARRAY 16 16))))
          (JS RFACS process (IPLUS (LOC acBlock)
				   2))
          (RETURN (ELT acBlock (ADD1 ac))))))

(ReadEditResult
  (LAMBDA NIL                                   (* edited: 
						"24-Sep-79 15:10")

          (* This function maps in the EMACS buffer, and then 
	  reads the edited S-expression off the file and 
	  returns it)


    (COND
      ((IGREATERP emacsZ emacsMapFileEof)
	(SETFILEPTR emacsMapFile emacsZ)
	(SETQ emacsMapFileEof emacsZ)))
    (SETFILEPTR emacsMapFile emacsPt)
    (MapBytes emacsPt emacsZ)
    (SETFILEPTR emacsMapFile emacsPt)

          (* The buffer has been mapped and the file 
	  positioned. Read in the s-expression and return it)


    (PROG ((NORMALCOMMENTSFLG T))
          (RETURN (READ emacsMapFile emacsReadTable)))))

(Right
  (LAMBDA (word)                                (* edited: 
						"11-Sep-79 20:20")

          (* Returns the right half of a word.
	  MACRO is compiled open for efficiency)


    (LOGAND word 262143)))

(SFCOC
  (LAMBDA (pair)                                (* edited: 
						"13-Sep-79 20:39")

          (* Sets the terminal control character output codes 
	  to the left and right halves of pair Returns the old
	  value)


    (PROG1 (CONS (JS RFCOC 101Q NIL NIL 2)
		 (JS RFCOC 101Q NIL NIL 3))
	   (COND
	     (pair (JS SFCOC 101Q (CAR pair)
		       (CDR pair)))))))

(STIW
  (LAMBDA (tiw)                                 (* edited: 
						"13-Sep-79 20:37")
                                                (* Resets the terminal 
						interrupt word, and 
						returns its previous 
						value)
    (PROG1 (JS RTIW -5 NIL NIL 2)
	   (COND
	     (tiw (JS STIW -5 tiw))))))

(ScratchBuffer
  (LAMBDA (sexp)                                (* edited: 
						"17-Dec-80 10:36")
                                                (* Print s expression in
						EMACS SCRATCH buffer)
    (PROG (fixPos tecoPos endPos)
          (SETFILEPTR emacsTempFile 0)
          (printout emacsTempFile 
		    "FS TTYINIM(M.MSelect Buffer)ScratchHK")
          (fixPos_(GETFILEPTR emacsTempFile))
          (printout emacsTempFile "     FYJ")
          (tecoPos_(GETFILEPTR emacsTempFile))
          (EmacsPP sexp T T)
          (endPos_(GETFILEPTR emacsTempFile))
          (SETFILEPTR emacsTempFile fixPos)
          (printout emacsTempFile (endPos-tecoPos))
          (SETFILEPTR emacsTempFile tecoPos)
          (Down T))))

(ScratchFile
  (LAMBDA (fileName)                            (* edited: 
						"11-Sep-79 20:51")

          (* Creates a scratch file with a ;T designation with
	  the given name. The file will be open for reading 
	  and writing)


    (PROG (realFileName jfn)
          (SETQ realFileName (OPENFILE fileName 'OUTPUT))
          (CLOSEF realFileName)
          (SETQ jfn (GTJFN realFileName))
          (JS CHFDB (XWD 1 jfn)
	      -400000000000Q -400000000000Q)
          (IOFILE realFileName)
          (RETURN realFileName))))

(SetEmacsVars
  (LAMBDA NIL                                   (* edited: 
						"12-Sep-79 22:56")

          (* Takes all the EMACS variables and sets them to 
	  the current value as mapped into our block)


    (for var in emacsVars do (SET var (OPENR (GETPROP var
						      'EMACS.LOC))))
    (SETQ emacsFsexit (ReadAc (fetch FORK of LASTEMACS)
			      3))))

(SetupBreakMacros
  (LAMBDA NIL                                   (* edited: 
						"22-Nov-80 01:22")
                                                (* Redefine BTV, BTV+, 
						BTV* and BTV! so they 
						use EMACS)
    (RPLACD (FASSOC 'BTV BREAKMACROS)
	    (LIST '(Stack 1)))
    (RPLACD (FASSOC 'BTV+ BREAKMACROS)
	    (LIST '(Stack 5)))
    (RPLACD (FASSOC 'BTV* BREAKMACROS)
	    (LIST '(Stack 7)))
    (RPLACD (FASSOC 'BTV! BREAKMACROS)
	    (LIST '(Stack 47)))))

(SetupEmacsDribble
  (LAMBDA NIL                                   (* edited: 
						" 4-Dec-80 09:29")
    (DECLARE (LOCALVARS . T))

          (* To refresh the screen upon returning to LISP, we 
	  use a dribble file to find out what was recently on 
	  the screen.)


    (PROG (dribbleFileName)
          (COND
	    ((SETQ dribbleFileName (DRIBBLEFILE))
	      (SETQ emacsDribbleFile dribbleFileName))
	    (T (SETQ emacsDribbleFile (ScratchFile EMACS.DRIBBLE.FILE))
	       (DRIBBLE emacsDribbleFile T T)))
          (RETURN dribbleFileName))))

(Stack
  (LAMBDA (flags)                               (* edited: 
						"22-Nov-80 01:18")

          (* This function passes the stack backtrace to EMACS
	  so it can be examined easily.)


    (SETFILEPTR emacsTempFile 0)
    (BAKTRACE LASTPOS NIL (BREAKREAD 'LINE)
	      flags emacsTempFile)
    (Down)
    (DumpLines REFRESH.LINE.COUNT)))

(StartEmacs
  (LAMBDA NIL                                   (* cvs " 1-Apr-83 15:08"
)

          (* This procedure opens all the temporary files 
	  needed by the interface, and starts up EMACS in the 
	  lower fork, initialized with the INTERMACS macro 
	  library)


    (PROG (temp name)

          (* Re-initialize all the file names, since we may be
	  coming back from a SYSOUT being run by a user 
	  different from the SYSOUT%'s creator)


          (for x in '(MAP TEMP DRIBBLE)
	     do (SET (PACK* 'EMACS. x '.FILE)
		     (PACKFILENAME 'DIRECTORY (DIRECTORYNAME)
				   'NAME
				   (COND
				     ((BOUNDP 'EMACS.FILENAME)
				       EMACS.FILENAME)
				     (T (SETQ EMACS.FILENAME
					  'EMACS)))
				   'EXTENSION x)))
                                                (* First check if any 
						old EMACS is laying 
						around)
          (FlushEmacs)

          (* Redifine the editor so it will call EMACS instead
	  of doing the usual thing)


          (ADVISE 'EDITL 'BEFORE
		  '(PROGN (COND
			    ((NULL COMS)
			      (RETURN (RPLACA L (EMACS (CAR L)
						       ATM))))
			    ((EQ (CAR COMS)
				 T)
			      (SETQ COMS NIL)))))
                                                (* Relink the functions 
						which call EDITL --cvs)
          (RELINK 'EDITFBLOCK)

          (* Now set up the EMACS.TEMP.FILE which is the file 
	  to which we print in lisp and from which EMACS reads
	  via FSSUPERIOR)


          (SETQ emacsTempFile (ScratchFile EMACS.TEMP.FILE))
          (SETFILEPTR emacsTempFile MAX.EMACS.INPUT)

          (* EMACS wants the name of our program to be LISP, 
	  so make sure that%'s true for the initial call)


          (SETQ name (MKATOM (SIXBIT (JS GETNM NIL NIL NIL 1))))
          (COND
	    ((NEQ name 'LISP)
	      (JS SETNM (SIXBIT 'LISP))))

          (* We now put into the rescan buffer a string that 
	  EMACS will execute when it is fired up.
	  The string that EMACS obtains via FJ is the string 
	  put into the RSCAN minus the first word.
	  EMACS executes the TECO code after the first altmode
	  in the JCL returned by FJ. See <EMACS>EMACS.INIT)


          (WriteRscan (CONCAT "EMACS M(M.MLoad Lib)" 
			      EMACS.INTERMACS.FILE "FSEXIT"))
          (SETQ LASTEMACS (CallEmacs EMACS.EXE.FILE))
          (COND
	    ((NEQ name 'LISP)
	      (JS SETNM (SIXBIT name))))
          (SETQ emacsBufferBlock (ReadAc (fetch FORK of LASTEMACS)
					 2))

          (* AC2 contains the beginning of the EMACS buffer 
	  block. Now map in the EMACS buffer block into LISP 
	  so we can see what%'s going on down there and so we 
	  can give an arg to FSSUPERIOR.
	  We may need one page or two depending on whether the
	  buffer crosses a page boundary)


          (COND
	    ((IEQP (LLSH emacsBufferBlock -9)
		   (LLSH (IPLUS emacsBufferBlock 9)
			 -9))
	      (SETQ emacsBlockSize 1))
	    (T (SETQ emacsBlockSize 2)))
          (SETQ ourBlockStart (LOC (GETBLK emacsBlockSize)))
                                                (* Now initialize the 
						addresses of all the 
						EMACS variables in our 
						block)
          (for var in emacsVars as i from 0
	     do (PUTPROP var 'EMACS.LOC
			 (IPLUS i (LOGOR ourBlockStart
					 (LOGAND 511 emacsBufferBlock)))
			 ))                     (* Now map the emac 
						buffer block into our 
						address space)
          (JS PMAP (XWD (fetch FORK of LASTEMACS)
			(LLSH emacsBufferBlock -11Q))
	      (XWD 400000Q (LLSH ourBlockStart -11Q))
	      (XWD 150000Q 0))                  (* We may have to map in
						2 pages)
          (COND
	    ((EQ emacsBlockSize 2)
	      (JS PMAP (XWD LASTEMACS:FORK (LLSH emacsBufferBlock -11Q)
			    + 1)
		  (XWD 400000Q (LLSH ourBlockStart -11Q)
		       + 1)
		  (XWD 150000Q 0))))

          (* Now we put the entry vector for EMACS at the end 
	  of the buffer block. When we start up the fork again
	  with EmacsSubsys, we will ask for the proces to be 
	  STARTed. This causes the control to go to the 
	  FSSUPERIOR since the entry vector is sitting at the 
	  location one is supposed to commence to get 
	  FSSUPERIOR fired up)


          (SetEmacsVars)
          (JS SEVEC (fetch FORK of LASTEMACS)
	      (XWD 1 emacsRestart))

          (* The EMACS.MAP.FILE is the file into which we will
	  PMAP the buffer pages of EMACS.
	  We read from that file to get the value of the edits
	  performed)


          (SETQ emacsMapFile (ScratchFile EMACS.MAP.FILE))
          (SETQ emacsMapFileEof 0)
          (SETQ emacsMapFileJfn (OPNJFN emacsMapFile))
          (SETQ emacsMapBlock (GETBLK 1))
          (SETQ emacsMapBlockPage (LLSH (LOC emacsMapBlock)
					-9))
          (EmacsTerminalSetup (TerminalType))
          (SetupEmacsDribble)
          (SetupBreakMacros)
          (WHENCLOSE emacsMapFile 'CLOSEALL 'NO)
          (WHENCLOSE emacsTempFile 'CLOSEALL 'NO))))

(WriteRscan
  (LAMBDA (string)                              (* edited: 
						"10-Sep-79 21:55")

          (* This function puts a string in the RESCAN buffer 
	  for consumption by the next TTY read issued by this 
	  job)


    (ASSEMBLE NIL
	      (CQ MACSCRATCHSTRING)             (* Get a pointer to the 
						scratch string)
	      (FASTCALL UPATM)
	      (PUSHN 3)                         (* Save the scratch 
						string pointer)
                                                (* Convert to a byte 
						pointer)
	      (MOVE 2 , 3)                      (* AC2 has the scratch 
						byte pointer)
	      (CQ string)                       (* Now make a byte 
						pointer to the string)
	      (FASTCALL UPATM)
	  LOOP(LDB 1 , 3)
	      (DPB 1 , 2)                       (* Move bytes from the 
						scratch string)
	      (IBP 0 , 2)
	      (IBP 0 , 3)
	      (SOSL 0 , 4)
	      (JRST LOOP)
	      (MOVEI 1 , 0)                     (* Deposit a 0 byte at 
						the end of string)
	      (DPB 1 , 2)
	      (POPN 1)                          (* Get the scratch 
						string pointer)
	      (JS RSCAN)                        (* Put the string in the
						buffer)
	      (JFCL)
	      (MOVEI 1 , 0)                     (* Make it available)
	      (JS RSCAN)
	      (JFCL)
	      (MOVE 1 , KNIL))))
)

(RPAQQ EMACSBLOCKS ((EMACSBLOCK BinaryMode BytePointer CallEmacs 
				ClearScreen Down DumpLines EnterEmacs 
				EMACS EmacsPP EmacsReturn EmacsSubsys 
				EmacsTerminalSetup Enable^CCapability 
				FlushEmacs Left MapBytes 
				MapProcessToFile OtherWindow PageOfByte 
				ReadAc ReadEditResult Right SFCOC STIW 
				ScratchBuffer ScratchFile SetEmacsVars 
				SetupEmacsDribble StartEmacs WriteRscan
				(ENTRIES StartEmacs FlushEmacs EMACS 
					 STIW SFCOC Down EmacsReturn 
					 EmacsPP EmacsTerminalSetup 
					 DumpLines EnterEmacs)
				(NOLINKFNS . T))))
[DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY
(BLOCK: EMACSBLOCK BinaryMode BytePointer CallEmacs ClearScreen Down 
	DumpLines EnterEmacs EMACS EmacsPP EmacsReturn EmacsSubsys 
	EmacsTerminalSetup Enable^CCapability FlushEmacs Left MapBytes 
	MapProcessToFile OtherWindow PageOfByte ReadAc ReadEditResult 
	Right SFCOC STIW ScratchBuffer ScratchFile SetEmacsVars 
	SetupEmacsDribble StartEmacs WriteRscan
	(ENTRIES StartEmacs FlushEmacs EMACS STIW SFCOC Down 
		 EmacsReturn EmacsPP EmacsTerminalSetup DumpLines 
		 EnterEmacs)
	(NOLINKFNS . T))
]
[DECLARE: EVAL@COMPILE 

(RECORD PROCESS (FORK COC TIW))
]

(RPAQQ EMACSVARS ((SUBSYSRESCANFLG T)
	(MAX.EMACS.INPUT 896000)
	(LASTEMACS NIL)
	(EMACS.EXE.FILE 'SYS:EMACS.EXE)
	(EMACS.INTERMACS.FILE '<LISPUSERS>INTERMACS)
	(emacsVars '(emacsBeg emacsBegv emacsPt emacsGpt emacsZv emacsZ 
			      emacsExtrac emacsRestart emacsArg 
			      emacsModiff))))

(RPAQQ SUBSYSRESCANFLG T)

(RPAQQ MAX.EMACS.INPUT 896000)

(RPAQQ LASTEMACS NIL)

(RPAQQ EMACS.EXE.FILE SYS:EMACS.EXE)

(RPAQQ EMACS.INTERMACS.FILE <LISPUSERS>INTERMACS)

(RPAQQ emacsVars (emacsBeg emacsBegv emacsPt emacsGpt emacsZv emacsZ 
			   emacsExtrac emacsRestart emacsArg 
			   emacsModiff))

(PUTPROPS Left MACRO (X (LIST 'LOGAND (LIST 'LLSH (CAR X)
					    -18)
			      262143)))

(PUTPROPS Right MACRO (X (LIST 'LOGAND (CAR X)
			       262143)))

(ADDTOVAR LISPXMACROS (LEDIT (LEDIT)))
(RPAQ emacsReadTable (COPYREADTABLE FILERDTBL))
(SETSYNTAX 3 '(MACRO IMMEDIATE (LAMBDA (FL RDTBL)
				       (ERROR "End of EMACS buffer!")))
	   emacsReadTable)

(ADDTOVAR BEFORESYSOUTFORMS (FlushEmacs))
(/NCONC AFTERSYSOUTFORMS '((EmacsTerminalSetup)
	 (StartEmacs)))
(DECLARE: EVAL@COMPILE DONTCOPY 
(FILESLOAD (SYSLOAD FROM LISPUSERS)
	   CJSYS)
)
(StartEmacs)
(DECLARE: DONTCOPY
  (FILEMAP (NIL (1375 30113 (BinaryMode 1387 . 1780) (BytePointer 1784 . 
2086) (CallEmacs 2090 . 2724) (ClearScreen 2728 . 3318) (Down 3322 . 
5273) (DumpLines 5277 . 6362) (EnterEmacs 6366 . 7503) (EMACS 7507 . 
8406) (EmacsPP 8410 . 8962) (EmacsSubsys 8966 . 10117) (
EmacsTerminalSetup 10121 . 11053) (Enable^CCapability 11057 . 11207) (
EmacsReturn 11211 . 14143) (FixBreakMacros 14147 . 14793) (FlushEmacs 
14797 . 15737) (LEDIT 15741 . 16270) (Left 16274 . 16507) (MapBytes 
16511 . 17048) (MapProcessToFile 17052 . 17449) (OtherWindow 17453 . 
18347) (PageOfByte 18351 . 18650) (ReadAc 18654 . 19025) (ReadEditResult
 19029 . 19711) (Right 19715 . 19933) (SFCOC 19937 . 20320) (STIW 20324 
. 20640) (ScratchBuffer 20644 . 21399) (ScratchFile 21403 . 21950) (
SetEmacsVars 21954 . 22330) (SetupBreakMacros 22334 . 22821) (
SetupEmacsDribble 22825 . 23391) (Stack 23395 . 23751) (StartEmacs 23755
 . 28752) (WriteRscan 28756 . 30110)))))
STOP

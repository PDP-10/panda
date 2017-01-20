;;;  LEDIT    				-*-Mode:Lisp;Package:SI;Lowercase:T-*-
;;;  *************************************************************************
;;;  ***** MacLISP ****** Interface Twenex EMACS to MacLISP ******************
;;;  *************************************************************************
;;;  ******** (c) Copyright 1981 Massachusetts Institute of Technology *******
;;;  *************************************************************************

(herald LEDIT /43)

(eval-when (eval compile)
  (or (get 'SUBLOAD 'VERSION)
      (load '((LISP) subload))))

(subload SUBFORK)


;;;	This is the Lisp side of the LEDIT Lisp/Emacs Interface Package at CMU.
;;;	For user documentation, please see the file Ledit.doc.  The LEDIT
;;;	package provides a standard means for a Lisp fork to inform an Emacs
;;;	subfork of the name of a file and the name of a function within that
;;;	file that the user desires to edit, and for the user to be able to
;;;	return edited function definitions and other Lisp code from an Emacs
;;;	subfork to Lisp.
;;;
;;;	When Emacs is invoked by Lisp as an Ledit subfork, it is expected to
;;;	obey the following convention.  An Emacs invoked in this manner will
;;;	be started at an offset of 2 into its entry vector, causing the Teco
;;;	FS Flag LispT to be nonzero; in addition, the name of the program being
;;;	run will be changed from LISP to LEDIT.  If both of these conditions
;;;	are met, Emacs is expected to Load the LEDIT Library, which will 
;;;	execute as Teco code whatever Lisp has placed into the job's ReScan
;;;	buffer.  In addition, any time control is returned to Teco from Lisp,
;;;	Emacs is again expected to execute the Teco code placed in the ReScan
;;;	buffer.  The Emacs LEDIT Library and Emacs Init file distributed in 
;;;	this package follow this convention.  When the user invokes Emacs by
;;;	calling the Lisp function LEDIT with a function name, Lisp will provide
;;;	Teco code calling LEDIT Library functions that will Find the File and
;;;	the Function within the File that the user has requested to edit.
;;;
;;;	When control is returned to Lisp from Emacs, Lisp is expected to obey 
;;;	the following convention.  If the terminal buffer is not empty, it is a
;;;	signal to Lisp that Emacs has placed Lisp code that the user desires to
;;;	be returned to Lisp into a file named LEDIT-TEMPORARY-FILE.<User Name>
;;;	on the currently connected directory and that the first line of data 
;;;	read from the terminal is to be ignored (since it serves solely as the 
;;;	signal from Emacs to Lisp).  The function LEDIT provided in this file
;;;	obeys this convention.

;;;	Declarations for the Lisp compiler.

(declare 
  (*expr CALL-LEDIT KILL-LEDIT LEDIT-READ LEDIT-FIND LLOAD-PARSE
	 LEDIT-TTYINT COMPLR KILL-COMPLR COMPLR-TTYINT FRESH-LINE RESCAN)
  (*fexpr LEDIT LLOAD)
  (*lexpr SUBSYS)
  (special LEdit-Fork		;Fork Data Structure for Emacs SubFork
	   LEdit-Load-File	;NameString for Emacs executable file
	   Complr-Fork		;Fork Data Structure for Complr SubFork
	   Lload-Last-File 	;Name of Last File LLOADed
	   LEdit-EOF 		;"internal" marker for detecting End-of-file
	   LEdit-temp-file-names  
	   LEdit-tyi 		;Relativized file for the standard terminal
	   LEdit-tyo ) 		; input and output.  May be SFA's.
  (defprop LEDIT T SKIP-WARNING))

;;;	Define the standard location of the Emacs executable file we are to
;;;	use unless the user has already done so.

(if (or (not (boundp 'LEdit-Load-File))
	(null LEdit-Load-File))
    (setq LEdit-Load-File (caseq (status OPSYSTEM-TYPE)
			    (TOPS-20 "Sys:Emacs.exe")
			    (TENEX   "Dsk:<subsys>Emacs.sav")
			    (T       (break "You can't use LEDIT on this operating system")))))

(setq-if-unbound Lload-Last-File () 
		 LEdit-tyo       TYO 
		 LEdit-tyi       TYI)


;;;	CALL-LEDIT allows for running Emacs as a subfork to Lisp.  The first
;;;	time it is called, it creates and starts an Emacs subfork.  On
;;;	subsequent calls, it merely continues the already existing subfork.
;;;	In either case, the function waits for the subfork to halt before
;;;	it returns.

(defun CALL-LEDIT ()
  (cond 
    ((and (boundp 'LEdit-Fork) LEdit-Fork)
      (SUBSYS LEdit-Fork 'CONTINUE () 'LEDIT))
    ('T (FRESH-LINE)
	(setq LEdit-temp-file-names (status USERID))
	(do ((i (flatc LEdit-temp-file-names) (1- i)))
	    ((< i 1) )
	  (cond 
	    ((= #/. (getcharn LEdit-temp-file-names i))
	       ;;Use only last part of USERID, since it might be like G.JONL, 
	       ;; and we'd have to do something about the "." in a file 
	       ;; extension name
	      (do ((j (flatc LEdit-temp-file-names) (1- j))
		   (z () (cons (getcharn LEdit-temp-file-names j) z)))
		  ((<= j i) 
		    (setq LEdit-temp-file-names (implode z))))
	      (return 'T))))
	(setq LEdit-temp-file-names 
	      `(|LEDIT-TEMPORARY-FILE| ,LEdit-temp-file-names)
	      LEdit-EOF "internal-EOF-mark")
	(and (null ^W) (princ '|[LEDIT Created.]| LEdit-tyo))
	(setq LEdit-Fork
	      (SUBSYS LEdit-Load-File 'START 2 'LEDIT))))
  '*)



;;;	KILL-LEDIT kills any existing Emacs subfork created by CALL-LEDIT.

(defun KILL-LEDIT ()
       (cond ((and (boundp 'LEdit-Fork) LEdit-Fork)
	      (SUBSYS LEdit-Fork 'KILL)
	      (setq LEdit-Fork ())
	      (cond ((null ^W)
		     (FRESH-LINE)
		     (princ '|[LEDIT Killed.]| LEdit-tyo)))))
       '*)

;;;	LEDIT is the function which is the primary user-visible interface
;;;	to the Lisp/Emacs Interface Package.  If LEDIT is called with no
;;;	arguments, it merely continues or creates an Emacs subfork and the
;;;	user will either be placed into an empty Emacs with the LEDIT Library
;;;	loaded or will be returned to whatever he was last editing with LEDIT.
;;;	If LEDIT is called with one or more arguments, each argument will be
;;;	assumed to be the name of a function to be edited that was previously
;;;	loaded from a source file by the LLOAD function, and the following
;;;	series of actions will be taken for each function so specified.  First,
;;;	the function name will be checked to insure that it is an expr, fexpr,
;;;	or macro and that it was loaded by LLOAD.  Second, the appropriate
;;;	Teco code will be placed in the ReScan buffer so that when the Emacs
;;;	is started or continued it will Find the correct source File and the
;;;	correct Function within the File.  Third, an Emacs subfork is created
;;;	or continued and LEDIT waits for that fork to halt.  Finally, LEDIT
;;;	determines whether or not the Emacs created a file of code to be 
;;;	returned to Lisp, and if so, loads the file into Lisp.  Thus LEDIT
;;;	effectively calls an Emacs subfork passing it a file and a function
;;;	to edit and accepts back a file of Lisp code to be executed.

(defun LEDIT fexpr (Function-List)
  (cond ((null Function-List)
	  (RESCAN '||)
	  (clear-input LEdit-tyi)
	  (CALL-LEDIT)
	  (LEDIT-READ)
	  (cond ((null ^W)
		  (FRESH-LINE)
		  (princ '|[LEDIT Completed.]| LEdit-tyo))))
	('T (do ((functions Function-List (cdr functions))
		 (function)
		 (source))
		((null functions))
	      (setq function (car functions)
		    source (get function 'LLOAD-SOURCE))
	      (cond ((not source)
		      (ledit-msg 'LEDIT '"can't find function for" function))
		    ('T (clear-input LEdit-tyi)
			(LEDIT-FIND (car source) function (cdr source))
			(CALL-LEDIT)
			(LEDIT-READ)
			(cond ((null ^W)
			       (FRESH-LINE)
			       (princ '|[LEDIT Completed.]| LEdit-tyo))))))))
  '*)

(defun LEDIT-MSG (fun msg datum)
  (terpri msgfiles)
  (princ '|;| msgfiles)
  (princ fun msgfiles)
  (princ '| | msgfiles)
  (princ msg msgfiles)
  (princ '| | msgfiles)
  (prin1 datum msgfiles)
  (terpri msgfiles))



;;;	LEDIT-READ tests to see if the Emacs subfork placed anything in the
;;;	terminal input buffer.  If the Emacs subfork did, LEDIT-READ clears
;;;	the input buffer and reads the file of Lisp code written by the Emacs 
;;;	subfork to be returned to Lisp.

(defun LEDIT-READ () 
  (cond 
    ((and (zerop (listen LEdit-tyi)) 
	  (not (eq (status OPSYSTEM-TYPE) 'TENEX)))
       ;; Well, on TENEX we may not be able to use the RSCAN stuff
       ;;  but if it did get used, a null RSCAN means no file to read.
      )
    (T 
     (clear-input LEdit-tyi)
     (let ((file-name (let ((DEFAULTF '((* *) * LSP)))
			(probef LEdit-temp-file-names)))
	   (file () )
	   (succeed? () ))
       (if file-name
	   (unwind-protect 
	     (cond ((prog2 (errset (setq file (open file-name 'IN) 
					 succeed? 'T)
				   () )
			   succeed?)
		     (cond ((null ^W)
			     (FRESH-LINE)
			     (princ '|[Reading from LEDIT...]| LEdit-tyo)))
		     (sstatus UUOlinks)
		     (do ((form (read file LEdit-EOF) (read file LEdit-EOF) )
			  (result)
			   ;; Don't snap any UUO's until all loaded
			  (NOUUO 'T))
			 ((eq form LEdit-EOF))
		       (cond ((prog2 (errset (setq succeed? ()
						   result (eval form) 
						   succeed? 'T) 
					     () )
				     (not succeed?))
			       (ledit-msg 'LEDIT '|Eval error in| form))
			     ((null ^W) (print result LEdit-tyo))))))
	     (deletef (cond ((filep file) (close file) file) 
			    (T file-name)))))))))


;;;	LEDIT-FIND takes as arguments the name of a function, the name of
;;;	the file it was source LLOADed from, and an approximate location 
;;;	within the file and places the appropriate Teco code in the ReScan 
;;;	buffer to cause Emacs to Find the File and then Find the Function
;;;	within the file, using the location passed as a guide to limit the
;;;	the searching for the function.

(defun LEDIT-FIND (File Function Location)
       (prog (BASE *NOPOINT)
	     (setq BASE 10.)
	     (RESCAN (maknam (append
			      '#.(exploden '|LEDIT M(M.M & LEDIT Find File)|)
			      (exploden (cond ((symbolp File) File)
					      (T '||)))
			      '#.(exploden '| |)
			      (exploden (cond ((fixp Location) Location)
					      (T 0)))
			      '#.(exploden '|M(M.M ^R LEDIT Find Function)|)
			      (exploden (cond ((symbolp Function) Function)
					      (T '||)))
			      '#.(exploden '||))))))

;;;	LLOAD is a fexpr that takes as argument a file specification and loads
;;;	the file into Lisp.  Whenever a function definition is loaded at top
;;;	level in a source file, the name of the source file and the location 
;;;	within the file are saved and placed on the LLOAD-SOURCE property of
;;;	the function name so defined.  If LEDIT is later called to edit a
;;;	function loaded in this manner, it will pass to Emacs the Teco code
;;;	necessary to find the appropriate file and the function within the
;;;	file.  If no argument is given to LLOAD, then the highest version 
;;;	number of the file last LLOADed will be loaded.  If an argument or
;;;	arguments is given, the list of arguments is given to LLOAD-PARSE to
;;;	interpret as a file specification.  See the definition of LLOAD-PARSE
;;;	for a description of how this is done.  For example:
;;;
;;;	Call to LLOAD				File Specification
;;;
;;;	(LLOAD foo/.lsp)			foo.lsp
;;;	(LLOAD |foo.lsp|)			foo.lsp
;;;	(LLOAD Ps: <Zubkoff> foo lsp)		Ps:<Zubkoff>foo.lsp
;;;	(LLOAD Ps: <Zubkoff Lisp> foo lsp)	Ps:<Zubkoff.Lisp>foo.lsp
;;;
;;;	If no explicit file extension is given, LLOAD will first look for a
;;;	FASL file of the name given, and if found, will call fasload to load
;;;	the file.

(defun LLOAD fexpr (File)
  (prog (FileName FileName0 LLoad-EOF succeed?)
	(setq LLoad-EOF LEdit-EOF)
	(multiple-value (FileName succeed?) 
			(LLOAD-PARSE (cond (File)
					   (Lload-Last-File 
					     (list Lload-Last-File)))))
	(cond ((not succeed?) 
	        (ledit-msg 'LLOAD '"unable to find file" file)
		(return () )))
	(setq FileName0 (intern (namestring (mergef '((* *) * * /0) FileName)))
	      Lload-Last-File FileName0)
	(sstatus UUOlinks)
	(unwind-protect 
	  (cond 
	    ((prog2 (errset (setq succeed? () 
				  File (open Filename 'IN) 
				  succeed? 'T) 
			    () )
		    (not succeed?))
	      (ledit-msg 'LLOAD '"unable to open file" FileName)
	      (return () ))
	    (T (cond 
		 ((faslp File)
	            ;; Its ok to just "LOAD" in a fasl file.
		   (let ((^W 'T) (NOUUO 'T)) (load File)))
		 ((prog (form fun formsl location NOUUO succeed?)
			(setq NOUUO 'T)
		          ;; Don't want UUOlinks snapped until all loaded
		     A	(cond (formsl (pop formsl form)) 
			      ('T (setq location (filepos File)
					form (read File LLoad-EOF))
				  (if (eq form LLoad-EOF) (return () ))))
		     B  (setq form (macroexpand form))
			 ;;Do macroexpansion and check for (PROGN 'COMPILE ...)
			(cond ((and (pairp form) 
				    (eq (car form) 'PROGN)
				    (pairp (cdr form))
				    (equal (cadr form) '(QUOTE COMPILE)))
			       (setq formsl (append (cdddr form) formsl)
				     form (caddr form))
			       (go B)))
			 ;; Look for function DEFUNitions
			(setq fun (cond ((or (not (pairp form))
					     (not (eq (car form) 'DEFUN))
					     (not (pairp (cdr form))))
					  () )
					((symbolp (cadr form)) (cadr form))
					((not (pairp (cadr form))) () ) 
					((symbolp (caadr form)) (caadr form))))
			 ;; Do the evaluation, and remember spots of DEFUN's
			(cond ((prog2 (errset (progn (setq succeed? () )
						     (eval form) 
						     (setq succeed? 'T))
					      () )
				      (not succeed?))
			       (ledit-msg 'LLOAD '|Eval error in| form))
			      ((and fun 
				    (memq (car (fboundp fun)) 
					  '(EXPR FEXPR MACRO)))
			        (putprop fun 
					 (cons FileName0 location)
					 'LLOAD-SOURCE)))
			(go A))))
	       (cond ((null ^W)
		       (FRESH-LINE)
		       (princ '|[LLOAD of file | LEdit-tyo)
		       (princ FileName LEdit-tyo)
		       (princ '| completed.]| LEdit-tyo)))))
	  (if (filep file) (close File)))
    (return '*)))

;;;	LLOAD-PARSE accepts as argument a list that represents a file
;;;	specification and attempts to return a completed namestring to
;;;	an existing file.  If a file extension is not explicitly given,
;;;	the function first looks for a FASL file and then for a LSP file.
;;;	If an explicit directory is not given, it will look first on the
;;;	connected directory, next on the user's login directory, and finally
;;;	on the <MacLisp> directory.  The formats of the argument are
;;;	interpreted as follows.  If the argument is a list of length zero, it
;;;	is interpreted as a blank filename.  If the argument is a list of
;;;	length one, its car is expected to be a valid TOPS-20 file 
;;;	specification; if a period is to be included in this format, the
;;;	period must either be slashified as in foo/.bar or the whole file
;;;	specification should be enclosed in vertical bars as in |foo.bar|.
;;;	If the argument is a list of length greater than one, the file
;;;	specification is interpreted to be the same as what the argument
;;;	would look like if printed by princ, with enclosing parentheses
;;;	removed and each space replaced by a period except when it is
;;;	immediately preceeded by a colon (:) or right angle bracket (>).
;;;	Thus the list (Ps: <Zubkoff> Foo Lsp) is interpreted as specifying
;;;	the file Ps:<Zubkoff>Foo.Lsp.  If no existing file can be found after
;;;	the above directories are attempted, then the function will return
;;;	the namestring of the basic file for which it was looking, in case
;;;	the caller wishes to apply other defaults and try himself.

(defun LLOAD-PARSE (File)
  (prog (FileName succeed?)
    (cond
     ((null File) (setq FileName '||))
     ((and (null (cdr File)) (car File) (symbolp (car File)))
       (setq FileName File))
     ('T (setq FileName 
	        ;; Strip off the two parentheses
	       (nreverse (cdr (reverse (cdr (exploden File))))))
	 (do ((chars FileName (cdr chars))
	      (lastchar () (car chars))
	      (fchars))
	     ((null chars) (setq FileName (maknam (nreverse fchars))))
	   (cond ((= (car chars) #\SPACE)
		   (cond ((or (= lastchar #/:) (= lastchar #/>)))
			 (T (push #/. fchars))))
		 ('T (push (car chars) fchars))))))
      ;; Maybe have to search to find dev/dir for this file?
    (do ((defaults '(((* (STATUS UDIR)) FASL) 
		     ((* (STATUS UDIR)) LSP) 
		     ((PS (STATUS USERID)) FASL)
		     ((PS (STATUS USERID)) LSP)
		     ((PS 'MACLISP) FASL)
		     ((PS 'MACLISP) LSP))
	   (cdr defaults))
	 (file)
	 (default-devdir)
	 (xtn))
	((null defaults) )
      (setq default-devdir (caar defaults)
	    xtn (cadar defaults))
      (setq default-devdir (list (car default-devdir) 
				 (eval (cadr default-devdir)))
	    file (mergef FileName `((* *) * ,xtn /0)))
      (errset (cond ((let ((DEFAULTF (cons default-devdir (cdr DEFAULTF))))
		        (setq file (probef file)))
		     (setq FileName (namestring file) 
			   succeed? 'T)
		     (return 'T)))
	      () ))
    (return (values FileName succeed?))))


;;;	Define the character Control-E to be a terminal interrupt character
;;;	that is equivalent to calling the function LEDIT.

(defun LEDIT-TTYINT (file char)
       (declare (ignore file char))
       (LEDIT)
       (and (null ^w) (terpri LEdit-tyo)))

(sstatus TTYINT #^E 'LEDIT-TTYINT)


;;;	COMPLR allows for running Complr as a subfork to Lisp.  The first
;;;	time it is called, it creates and starts an Complr subfork.  On
;;;	subsequent calls, it merely continues the already existing subfork.
;;;	In either case, the function waits for the subfork to halt before
;;;	it returns.

(defun COMPLR ()
  (cond ((null ^W) 
	 (FRESH-LINE)
	 (princ '|[COMPLR | LEdit-tyo)))
  (cond 
    ((and (boundp 'Complr-Fork) Complr-Fork)
      (cond ((null ^W)
	     (princ '|continued.]| LEdit-tyo)
	     (terpri LEdit-tyo)
	     (princ '|_| LEdit-tyo)))
      (SUBSYS Complr-Fork 'CONTINUE () 'COMPLR))
    (T (and (null ^W) (princ '|Created.]| LEdit-tyo))
       (setq Complr-Fork
	     (SUBSYS (namestring (mergef '(COMPLR *) LEdit-Load-File))
		     'START () 'COMPLR))))
  (cond ((null ^W) 
	 (terpri LEdit-tyo)
	 (princ '|[COMPLR completed.]| LEdit-tyo)))
  '*)


;;;	KILL-COMPLR kills any existing Complr subfork created by COMPLR.

(defun KILL-COMPLR ()
       (cond ((and (boundp 'Complr-Fork) Complr-Fork)
	      (SUBSYS Complr-Fork 'KILL)
	      (setq Complr-Fork () )
	      (cond ((null ^W)
		     (FRESH-LINE)
		     (princ '|[COMPLR Killed.]| LEdit-tyo)))))
       '*)


;;;	Define the character Control-K to be a terminal interrupt character
;;;	that is equivalent to calling the function COMPLR.

(defun COMPLR-TTYINT (file char)
       (declare (ignore file char))
       (COMPLR)
       (and (null ^w) (terpri LEdit-tyo)))

(sstatus TTYINT #^K 'COMPLR-TTYINT)


;;;	FRESH-LINE prints a CRLF if the terminal is not already at the left
;;;	margin of a line.

(defun FRESH-LINE ()
  (cond ((and (sfap LEdit-tyo) 
	      (memq 'FRESH-LINE (sfa-call LEdit-tyo 'WHICH-OPERATIONS () )))
	 (sfa-call LEdit-tyo 'FRESH-LINE () ))
	((cursorpos 'A LEdit-tyo))
	((not (zerop (charpos LEdit-tyo))) (terpri LEdit-tyo)))
  'T)
  
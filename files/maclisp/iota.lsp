;;; -*- LISP -*-
;;; IOTA: Macros for doing I/O correctly.
;;; Bugs/suggestions/complaints to KMP@MC

;;; Functions defined in this package are:
;;;
;;; IOTA - Macro for binding I/O streams
;;; PHI  - A different flavor of IOTA that works more like LAMBDA


;;; IOTA
;;;
;;; Mnemonic Basis: A form of Lambda for doing I/O binding.
;;;
;;; This is a LAMBDA binding macro that will open a lisp file object
;;; in such a way that it is automatically closed when the lambda binding
;;; range is exited. 
;;;
;;; Syntax:
;;;
;;; (IOTA ((<var1> <filename1> <filemodes1>)
;;;        (<var2> <filename2> <filemodes2>) ...)
;;;       <body>)
;;;
;;;
;;; Description:
;;;
;;;   [1]  <var1> ... <varN> are, in essence, bound to
;;;			     (OPEN <filenameK> <filemodeK>)
;;;			     for K = 1 thru N.
;;;
;;;   [2] <filename>'s and <filemode>'s are evaluated before entering
;;;       the context in which the <var>'s are bound. (constant names
;;;	  must be quoted.)
;;;
;;;   [2] Body is of the same form as a lambda-body (ie, an implicit PROGN).
;;;
;;;   [3] All files are closed upon any exit from the LAMBDA (including
;;;       normal exit, ^G Quit, or an error).
;;;
;;;   
;;; Expands into:
;;;
;;; ((LAMBDA (<temp> <var1> <var2> ... <varN>)
;;;          (UNWIND-PROTECT
;;;           (PROGN (WITHOUT-INTERRUPTS
;;;			(SETQ <var1> (APPLY 'OPEN (POP <temp>)))
;;;			(SETQ <var2> (APPLY 'OPEN (POP <temp>)))
;;;			...)
;;;		     <body>)
;;;           (AND (OR (SFAP <var1>) (FILEP <var1>)) (CLOSE <var1>))
;;;           (AND (OR (SFAP <var2>) (FILEP <var2>)) (CLOSE <var2>))
;;;           ...))
;;;  (LIST (LIST <filename1> <filemodes1>) (LIST <filename2> <filemodes2>) ...)
;;;  () () ... ())
;;;
;;; On LISPM, uses pseudo-FILEP operation omits the SFAP operation.
;;;
;;; Example:
;;;
;;; (DEFUN FILECOPY (FROM TO)
;;;    (IOTA ((FOO FROM 'IN)
;;;           (BAR TO 'OUT))
;;;          (DO ((C (TYI FOO -1) (TYI FOO -1)))
;;;              ((MINUSP C))
;;;	         (TYO C BAR))))
;;;
;;;   Note:
;;;         This function should never be called on TYO, TYI, or T
;;;         since it will close them upon its return, leaving the
;;;	    Lisp in a hung state.
;;;

(DEFUN (IOTA MACRO) (X)
   (LET* ((STREAMS (CADR X))
	  (BODY (CDDR X))
	  (VARS (MAPCAR 'CAR STREAMS))
	  (VALS (MAPCAR #'(LAMBDA (X) `(LIST ,@(CDR X))) STREAMS))
	  (TEMP (GENSYM 'F)))
	 `((LAMBDA (,TEMP ,@VARS)
		   (UNWIND-PROTECT
		    (PROGN
		     (WITHOUT-INTERRUPTS
		      ,@(MAPCAR #'(LAMBDA (X)
				    `(SETQ ,X (APPLY 'OPEN (POP ,TEMP))))
				VARS))
		     ,@BODY)
		    ,@ (MAPCAR #'(LAMBDA (VAR)
				   #+LISPM
				     `(AND
					(CLOSUREP ,VAR)
					(MEMQ ':CLOSE
					      (FUNCALL ,VAR ':WHICH-OPERATIONS))
					(CLOSE ,VAR))
				   #-LISPM
				     `(AND (OR (FILEP ,VAR)
					       (AND (STATUS FEATURE SFA)
						    (SFAP ,VAR)))
					   (CLOSE ,VAR)))
			       VARS)))
	   (LIST . ,VALS)
	   ,@(MAPCAR #'(LAMBDA (THING) THING ()) ; Create a list of NILs
		     VARS))))


;;; PHI 
;;;
;;; Mnemonic basis: PHI is a special LAMBDA for PHIle object binding.
;;;
;;; This is a LAMBDA binding macro that will accept an open lisp file object
;;; or SFA and guarantee that the object will be closed when the binding is
;;; exited.
;;;
;;; Syntax:
;;;
;;; (PHI ((<var1> <form1>)
;;;       (<var2> <form2>) ...)
;;;      <body>)
;;;
;;; Description:
;;;
;;;   [1] <var1> ... <varN> are, in essence, bound to
;;;			    the EVAL'd form of <formK>.
;;;			    for K = 1 thru N.
;;;
;;;   [2] <form1> ... <formN> are evaluated outside of the scope of 
;;;			      <var1> ... <varN> according to traditional
;;;			      LET-semantics. They should return file objects
;;;			      or SFA's.
;;;
;;;   [3] <body> is of the same form as a lambda-body (ie, an implicit PROGN).
;;;
;;;   [4] All variables of the PHI bound variable list which contain files
;;;       or SFA's at time of return from the PHI (by normal return, ^G quit,
;;;	  or error) will be properly closed.
;;;
;;; Expands into:
;;;
;;;
;;;     ((LAMBDA (<temp> <temp'>)
;;;       (UNWIND-PROTECT
;;;	   (PROGN
;;;	    (WITHOUT-INTERRUPTS
;;;	       (SETQ <temp'> <form1>)
;;;            (SETQ <temp> (CONS <temp'> <temp>))
;;;            ...
;;;            (SETQ <temp'> <form2>)
;;;            (SETQ <temp> (CONS <temp'> <temp>))
;;;            (SETQ <temp'> <form2>)
;;;            (SETQ <temp> (CONS <temp'> <temp>))
;;;            (SETQ <temp'> ())
;;;            (SETQ <temp> (REVERSE <temp>)))
;;;         ((LAMBDA (<var1> <var2> <var3> ... <varN>)
;;;	      (UNWIND-PROTECT (PROGN (SETQ <var1> (CAR <temp>))
;;;				     (POP <temp>)
;;;				     (SETQ <var2> (CAR <temp>))
;;;				     (POP <temp>)
;;;				     ...
;;;				     (SETQ <varN> (CAR <temp>))
;;;				     (POP <temp>)
;;;				     <body>)
;;;			      (AND (OR (FILEP <var1>) (SFAP <var1>))
;;;				   (CLOSE <var1>))
;;;			      (AND (OR (FILEP <var2>) (SFAP <var2>))
;;;				   (CLOSE <var2>))
;;;			      ...
;;;			      (AND (OR (FILEP <varN>) (SFAP <varN>))
;;;				   (CLOSE <varN>))))
;;;	     () () () ... ()))
;;;         (COND ((OR (FILEP <temp'>) (SFAP <temp'>))
;;;		   (CLOSE <temp'>)))
;;;	    (DO ((X <temp> (CDR X)))
;;;		((NULL X))
;;;	        (COND ((OR (FILEP (CAR X)) (SFAP (CAR X)))
;;;		       (CLOSE (CAR X)))))))
;;;       NIL NIL)
;;;
;;;
;;; Example:
;;;
;;; (DEFUN DUMP-DATA (FROM TO)
;;;    (PHI ((FOO (MY-SFA-MAKER FROM 'INPUT))
;;;          (BAR (MY-SFA-MAKER TO 'OUTPUT)))
;;;         (DO ((C (TYI FOO -1) (TYI FOO -1)))
;;;             ((MINUSP C))
;;;	        (TYO C BAR))))
;;;
;;;   Notes:
;;;
;;;     (1) MY-SFA-MAKER is of course not a Lisp builtin function. 
;;;	    Presumably it returns an SFA object of the proper type.
;;;
;;;     (2) This function should never be called on TYO, TYI, or T
;;;         since it will close them upon its return, leaving the
;;;	    Lisp in a hung state.
;;;

(DEFUN (PHI MACRO) (FORM)
       (LET ((TEMP1 (GENSYM))
	     (TEMP2 (GENSYM))
	     (FORMS (CADR FORM))
	     (BODY (CDDR FORM))
	     (VARLIST ())
	     (FORMLIST ()))
	    (DO ((FORMS FORMS (CDR FORMS)))
		((NULL FORMS)
		 (SETQ VARLIST  (NREVERSE VARLIST))
		 (SETQ FORMLIST (NREVERSE FORMLIST)))
		(PUSH (CAAR FORMS)   VARLIST)
		(PUSH (CADAR FORMS) FORMLIST))
	    `((LAMBDA (,TEMP1 ,TEMP2)
	       (UNWIND-PROTECT
		(PROGN
		 (WITHOUT-INTERRUPTS
		   ,@(NREVERSE
		      (MAPCAN #'(LAMBDA (X)
					`((SETQ ,TEMP1
						(CONS ,TEMP2
						      ,TEMP1))
					  (SETQ ,TEMP2 ,X)))
			      (REVERSE FORMLIST)))
		   (SETQ ,TEMP2 ())
		   (SETQ ,TEMP1 (REVERSE ,TEMP1)))
		 ((LAMBDA ,VARLIST
			  (UNWIND-PROTECT
			   (PROGN
			    ,@(MAPCAN #'(LAMBDA (X)
					  `((SETQ ,X (CAR ,TEMP1))
					    (SETQ ,TEMP1 (CDR ,TEMP1))))
				      VARLIST)
			    ,@BODY)
			   ,@ (MAPCAR #'(LAMBDA (VAR)
					  #+LISPM
					    `(AND
					       (CLOSUREP ,VAR)
					       (MEMQ ':CLOSE
						     (FUNCALL ,VAR
							 ':WHICH-OPERATIONS))
					       (CLOSE ,VAR))
					  #-LISPM
					    `(AND (OR (FILEP ,VAR)
						      (AND (STATUS FEATURE SFA)
							   (SFAP ,VAR)))
						  (CLOSE ,VAR)))
				      VARLIST)))
		  ,@(MAPCAR #'(LAMBDA (THING) THING ()) ; List of NILs
			    VARLIST)))
		(COND ((OR (FILEP ,TEMP2) (AND (STATUS FEATURE SFA)
					       (SFAP ,TEMP2)))
		       (CLOSE ,TEMP2)))
		(DO ((X ,TEMP1 (CDR X)))
		     ((NULL X))
		     (COND (#-LISPM (OR (FILEP (CAR X))
					(AND (STATUS FEATURE SFA)
					     (SFAP (CAR X))))
			    #+LISPM (AND (CLOSUREP (CAR X))
					 (MEMQ ':CLOSE (FUNCALL (CAR X) ':WHICH-OPERATIONS)))
			    (CLOSE (CAR X)))))))
	      () ())))
	    

;;; Mnemonic basis: PI is a special form for binding Program Interrupts
;;;
;;; PI has been replaced by the Maclisp system function WITHOUT-INTERRUPTS

(DEFUN (PI MACRO) (X) 
   (LET ((Y `(WITHOUT-INTERRUPTS ,(cdr x))))
     #-LISPM (SETQ Y (OR (MACROFETCH X) (MACROMEMO X Y 'PI)))
     Y))


;;; Note that the package has loaded.

(SSTATUS FEATURE #+LISPM : IOTA)

#+LISPM (GLOBALIZE 'IOTA)
#+LISPM (GLOBALIZE 'PHI)

;;; Version Number Support

#-LISPM (HERALD IOTA /40)


;;;   MAKLAP 						  -*-LISP-*-
;;;   **************************************************************
;;;   ***** MacLISP ***** (File parser for COMPLR) *****************
;;;   **************************************************************
;;;   ** (C) Copyright 1981 Massachusetts Institute of Technology **
;;;   ****** This is a Read-Only file! (All writes reserved) *******
;;;   **************************************************************

(SETQ MAKLAPVERNO '#.(let* ((file (caddr (truename infile)))
			   (x (readlist (exploden file))))
			  (setq |verno| (cond ((fixp x) file)  ('/80)))))

(EVAL-WHEN (COMPILE) 
     (AND (OR (NOT (GET 'COMPDECLARE 'MACRO))
	      (NOT (GET 'OUTFS 'MACRO)))
	  (LOAD `(,(cond ((status feature ITS) '(DSK COMLAP))
			 ('(LISP)))
		  CDMACS
		  FASL)))
)


(EVAL-WHEN (COMPILE) (COMPDECLARE) (FASLDECLARE) (GENPREFIX |/|mk|))


(comment COUTPUT and MACRO-EXPAND)

(DEFUN COUTPUT (X)
    (COND ((AND EXPAND-OUT-MACROS (NOT (ATOM X)) (NOT (EQ (CAR X) 'QUOTE)))
	   (SETQ X (MACRO-EXPAND X))))
    (ICOUTPUT X))

(DEFUN MACRO-EXPAND (X) 
    (COND ((OR (not (pairp X)) (eq (car x) 'QUOTE))
	   X)
	  (((LAMBDA (MCX-TRACE)
		    (COND ((EQ (*CATCH 'MCX-TRACE (MCX-TRACE X)) CLPROGN)
			   (SETQ MCX-TRACE ())
			   (MCX-TRACE X))
			  ('T X)))
	      'T))))

(DEFUN MAP-MCX-TRACE (L)
    (AND L 
	 (DO ((ANS) (TEM))
	     ((NULL L) (NREVERSE ANS))
	   (SETQ TEM (MCX-TRACE (CAR L)))
	   (AND (NULL MCX-TRACE) (PUSH TEM ANS))
	   (POP L))))


(DEFUN MCX-TRACE (X)
   (COND ((OR (not (pairp X)) (EQ (CAR X) 'QUOTE))
	  X)
	 ((LET (Y Z)
	       (COND ((ATOM (CAR X))
		      (COND ((NOT (SYMBOLP (CAR X))) X)
			    ((and (setq z (get (car x) 'SOURCE-TRANS))
				  (do ((l z (cdr l)))
				      ((null l) () )
				    (multiple-value (y z) (funcall (car l) x))
				    (if z (return 'T))))
			     (COND (MCX-TRACE (*THROW 'MCX-TRACE CLPROGN))
				   ('T (MCX-TRACE Y))))
			    ((GET (CAR X) '*FEXPR) X)
			    ((NOT (EQ (SETQ Y (P1MACROGET X)) NULFU))
			     (COND (MCX-TRACE (*THROW 'MCX-TRACE CLPROGN))
				   ('T (MCX-TRACE Y))))
			    ((OR (EQ (CAR X) 'LAMBDA)
				 (EQ (SYSP (CAR X)) 'FSUBR))
			     (CASEQ (CAR X)
				    ((SETQ PROG LAMBDA ARRAY SIGNP 
					   ARRAYCALL SUBRCALL LSUBRCALL 
					   STATUS SSTATUS EVAL-WHEN)
				      ;All but first "arg" is eval'd
				     (SETQ Y (MAP-MCX-TRACE (CDDR X)))
				     (COND (MCX-TRACE ())
					   ((LIST* (CAR X) (CADR X) Y))))
				    ((COND) 
				     (CONS 'COND (MAPCAR 'MAP-MCX-TRACE (CDR X))))
				    ((DO CASEQ) 
				     (SETQ X (COND ((EQ (CAR X) 'DO) (P1DO X))
						   ('T (P1CASEQ X))))
				     (AND (NULL X) (*THROW 'MCX-TRACE ()))
				     (MCX-TRACE X))
				    ((FUNCTION) 
				     (COND ((OR (ATOM (SETQ Y (CADR X)))
						(NOT (EQ (CAR Y) 'LAMBDA)))
					    X)
					   ('T (SETQ Z (MAP-MCX-TRACE (CDDR Y)))
					       (COND (MCX-TRACE () )
						     (`(FUNCTION 
							(LAMBDA ,(cadr y) 
								,.z)))))))
				    ((GO AND OR ERRSET ERR STORE PUSH POP SETF
					 PROGV *CATCH *THROW CATCH-BARRIER 
					 CATCHALL UNWIND-PROTECT)
				       ;All args eval'd
				     (MAP-MCX-TRACE X))
				    ((CATCH THROW)
				       ;First arg is eval'd, second quoted.
				     (SETQ Y (MCX-TRACE (CADR X)))
				     (SETQ Z (MAP-MCX-TRACE (CDDDR X)))
				     (COND (MCX-TRACE ())
					   ((CONS (CAR X) 
						  (CONS Y 
							(CONS (CADDR X) Z))))))
				    ((DEFUN)
				     (AND (MEMQ (CAR (SETQ Y (CDDR X)))
						'(EXPR FEXPR MACRO))
					  (POP Y Z))
				     (SETQ Y (CONS (CAR Y) 
						   (MAP-MCX-TRACE (CDR Y))))
				     (COND (MCX-TRACE ())
					   (`(DEFUN ,(cadr x)
						    ,@(and z (list z))
						    ,.y))))
				    ((DECLARE COMMENT DEFPROP 
					      FASLOAD INCLUDE UWRITE UREAD 
					      UCLOSE UKILL UAPPEND UPROBE CRUNIT 
					      BREAK EDIT GCTWA)
				     X)
				    (T (BARF X |Unknown FSUBR in MCX-TRACE|))))
			    ('T (MAP-MCX-TRACE X))))
		     ((EQ (CAAR X) 'LAMBDA)
		      (SETQ Y (MAP-MCX-TRACE (CDDAR X))
			    Z (MAP-MCX-TRACE (CDR X)))	      
		      (COND (MCX-TRACE ())
			    ('T `((LAMBDA ,(cadar x) ,.y) ,.z))))
		     ('T (SETQ Y (MCX-TRACE (CAR X)) 
			       Z (MAP-MCX-TRACE (CDR X)))
			 (COND (MCX-TRACE ())
			       ((CONS Y Z)))))))))



(COMMENT FILE-TRANSDUCERS)

(DEFUN CMP1 (GSBSTACK) 	 ;Transduce a file compileing those sexps which try to define functions
  SYMBOLS CREADTABLE COBARRAY CMSGFILES
(LET ((SYMBOLS SYMBOLS) (READTABLE CREADTABLE)
      (OBARRAY COBARRAY) (MSGFILES CMSGFILES))
  (PROG (ERRFL X NAME NAMEFORM  DECLARATION-FLAGCONVERSION-TABLE FL FORM 
	       PRATTSTACK PXHFL EOF-COMPILE-QUEUE EOF-SEEN)
	(SETQ DECLARATION-FLAGCONVERSION-TABLE 
	      '((*FEXPR . FEXPR) (*EXPR . EXPR) (*LEXPR . EXPR)))
	(AND RECOMPL 
	     (MAP '(LAMBDA (L) (AND (NOT (EQ (CAR L) (SETQ X (INTERN (CAR L)))))
				    (RPLACA L X)))
		  RECOMPL))
	(SETQ PRATTSTACK GSBSTACK)
    A0	(SETQ FILEPOSIBLE (AND (NULL GSBSTACK)
			       (FILEP INFILE) 
			       (MEMQ 'FILEPOS (STATUS FILEMODE INFILE))))
    A   (COND (PRATTSTACK (POP PRATTSTACK FORM))
	      ((OR GSBSTACK (EQ GOFOO (SETQ FORM (COMPREAD GOFOO))))
	       (AND FASLPUSH LAPLL (TERFASL))
	       (RETURN GOFOO)))
	(AND CHOMPHOOK (MAPC '(LAMBDA (F) (FUNCALL F FORM)) CHOMPHOOK))
    B   (COND ((ATOM FORM) (GO ICF))
	      ((EQ (CAR FORM) 'DEFPROP) 
	       (SETQ X (CDDR FORM) FL (CADR X) NAME (CADR FORM))
	       (COND ((OR (NULL (CDR X)) (CDDR X) (NOT (SYMBOLP NAME)))
		      (GO GH))
		     ((OR (ATOM (CAR X)) (NOT (EQ (CAAR X) 'LAMBDA)))
		      (GO ICF))
		     ((EQ FL 'MACRO) 
		      (CMP1-MACRO-ENLIVEN (CONS 'DEFUN
					   (CONS NAME 
					    (CONS 'MACRO 
						   (CDAR X))))
					  () ))
		     ((ASSQ FL COMPILATION-FLAGCONVERSION-TABLE)
		      (SETQ FORM (CONS 'DEFUN 
				  (CONS NAME 
				   (CONS FL 
				 	  (CDAR X)))))
		      (GO B))
		     ((AND (SETQ X (GETL NAME '(*EXPR *FEXPR *LEXPR)))
			   (NOT (EQ FL (CDR (ASSQ (CAR X) DECLARATION-FLAGCONVERSION-TABLE)))))
		      (WRNTYP NAME)
		      (PUTPROP NAME 'T (CAAR (MEMASSQR FL DECLARATION-FLAGCONVERSION-TABLE)))))
	       (GO ICF))
	      ((EQ (CAR FORM) 'DEFUN)
	       (AND (OR (NULL (CDR FORM)) (NULL (CDDR FORM)) (NULL (CDDDR FORM)))
		    (GO GH))
	       (COND ((SYMBOLP (SETQ NAME (CADR FORM))) (SETQ NAMEFORM () )) 
		     ((ATOM NAME) (GO GH))
		     ('T (SETQ NAME (CAR (SETQ NAMEFORM NAME)))
			 (AND (COND ((NOT (SYMBOLP NAME)))
				    ((NULL (CDR NAMEFORM)))
				    ((NOT (SYMBOLP (CADR NAMEFORM))))
				    ((NULL (CDDR NAMEFORM)) ())
				    ((NOT (SYMBOLP (CADDR NAMEFORM)))))
			      (GO GH))))
	       (AND (NOT (MEMQ (SETQ FL (CADDR FORM)) '(FEXPR EXPR MACRO)))
		    (SETQ FORM (CONS 'DEFUN 
				(CONS (OR NAMEFORM NAME) 
				 (CONS (SETQ FL 'EXPR) 
					(CDDR FORM))))))
	       (AND (NULL (CDDDDR FORM)) (GO GH))
	       (COND ((ATOM (SETQ X (NTH 3 FORM)))) 
		     ((OR (MEMQ '&OPTIONAL X)
			  (MEMQ '&REST X)
			  (MEMQ '&AUX X)
			  (MEMQ '&RESTV X)
			  (MEMQ '&RESTL X)
			  (DO L X (CDR L) (NULL L) 
			      (AND (NOT (SYMBOLP (CAR L))) 
				   (RETURN 'T))))
		      (SETQ FORM (CONS 'DEFUN& (CDR FORM)))
		      (GO B)))
	       (AND NAMEFORM 
		    (EQ (CADR NAMEFORM) 'MACRO)
		    (CMP1-MACRO-ENLIVEN (CONS 'DEFUN
					 (CONS NAME 
					  (CONS 'MACRO 
						 (CDDDR FORM))))
					() ))
	       (COND ((AND (NULL NAMEFORM) (EQ FL 'MACRO)) 
		      (CMP1-MACRO-ENLIVEN FORM 'T))
		     ((AND RECOMPL (NOT (MEMQ NAME RECOMPL))))
		     ((ASSQ FL COMPILATION-FLAGCONVERSION-TABLE)
		      (SETQ UNDFUNS (DELQ NAME UNDFUNS))
		      (SETQ LAP-INSIGNIF () )
		      (SETQ PXHFL 'T)
		      (COND ((NULL NAMEFORM) (SETQ NAMEFORM NAME))
			    ((NOT (ATOM NAMEFORM))
			     (COND ((NULL (CDDR NAMEFORM))
				    (SETQ NAME (PNAMECONC (CAR NAMEFORM)
							  '/  
							  (CADR NAMEFORM)))
				    (ICOUTPUT (LIST 'DEFPROP 
						    (CAR NAMEFORM)
						    NAME  
						    (CADR NAMEFORM)))
				    (SETQ NAMEFORM NAME))
				   ('T (SETQ PXHFL () ))) ))
		      (AND EXPR-HASH 
			   PXHFL 
			   (ICOUTPUT (LIST 'DEFPROP 
					   NAME 
					   (SXHASH (CONS 'LAMBDA (CDDDR FORM)))
					   'EXPR-HASH)))
		      #%(LET ((COMPILER-STATE 'COMPILE) (^W ^W) (^R ^R))
			  (COMPILE NAMEFORM 
				   FL 
				   (CONS 'LAMBDA (CDDDR FORM)) 
				   INFILE  
				   () )
			  (COND (TTYNOTES 	
				  (SETQ ^W (SETQ ^R () )) 
				  (LET ((TTN-FUN (GET (IF (ATOM NAMEFORM) 
							  NAMEFORM 
							  (CAR NAMEFORM))
						      'TTYNOTES-FUNCTION)))
				    (AND TTN-FUN 
					 (SETQ NAMEFORM 
					       (FUNCALL TTN-FUN NAMEFORM))))
				  (COND (NAMEFORM 
					   (INDENT-TO-INSTACK 0)
					   (PRIN1 NAMEFORM)
					   (PRINC '| Compiled|)))))
			  (SETQ ^W (SETQ ^R 'T))
			  (COND (FASLPUSH (AND LAPLL (TERFASL)))
				('T (TYO #\FORMFEED )))
			  (COND ((AND TTYNOTES NAMEFORM) 
				  (SETQ ^W (SETQ ^R () ))
				  (IF FASLPUSH 
				      (PRINC '| and assembled |)
				      (TYO #\SPACE )))))
		      (GO A))
		     ('T (GO ICF) ))
	       (AND RECOMPL (GO A)))
	      ((COND ((AND (EQ (CAR FORM) 'ARRAY) (SETQ NAME (CADR FORM)))
		      (MEMQ (SETQ FL (CADDR FORM)) '(T () FIXNUM FLONUM OBARRAY)))
		     ((AND (EQ (CAR FORM) '*ARRAY) 
			   (P1EQQTE (CADR FORM))
			   (SETQ NAME (CADADR FORM))
			   (COND ((MEMQ (SETQ FL (CADDR FORM)) '(T () )))
				 ((P1EQQTE FL)
				  (MEMQ (SETQ FL (CADR FL)) 
					'(T () FIXNUM FLONUM OBARRAY READTABLE)))))))
	       (AND (NOT (MEMQ FL '(FIXNUM FLONUM))) (SETQ FL 'NOTYPE))
	       (SETQ X (DO ((L (CDDDR FORM) (CDR L)) (Z) (T1))
			   ((NULL L) (LIST (CONS NAME (NREVERSE Z))))
			   (COND ((OR (FIXP (SETQ T1 (CAR L)))
				      (AND (P1EQQTE T1) (FIXP (SETQ T1 (CADR T1)))))
				  (PUSH T1 Z))
				 ('T (RETURN (LIST NAME (LENGTH (CDDDR FORM)))) ))))
	       (COND ((GET NAME '*ARRAY)
		      (PUTPROP NAME () '*ARRAY)		;To prevent spurious re-declared msgs
		      ((LAMBDA (T1) (AND (COND (T1 (PUTPROP NAME () 'NUMFUN)
						   (COND ((CADR T1) (NOT (EQ (CADR T1) FL)))
							 ((NOT (EQ FL 'NOTYPE)))))
					       ((NOT (EQ FL 'NOTYPE))))
					 (PUTPROP NAME '(() () ) 'NUMFUN)))
		       (GET NAME 'NUMFUN))))
	       (AR*1 (CONS FL X))
	       (SETQ LAP-INSIGNIF () )
	       (COUTPUT FORM))
	      ((MEMQ (CAR FORM) '(DECLARE EVAL-WHEN))
	       (SETQ X INFILE)
	       (LET ((COMPILER-STATE COMPILER-STATE) LOADP EVALP (L FORM))
		    (AND (COND ((EQ (CAR FORM) 'DECLARE) 
				(SETQ EVALP 'T COMPILER-STATE 'DECLARE)
				'T)
			       ((PROG2 (SETQ L (CDR L))
				       (MEMQ COMPILER-STATE '(MAKLAP COMPILE DECLARE)))
				(SETQ LOADP (MEMQ 'LOAD (CAR L)) 
				      EVALP (MEMQ 'COMPILE (CAR L)))
				(OR EVALP LOADP))
			         ;This allows for COMPILER-STATE to be () and TOPLEVEL
			       ((SETQ EVALP (MEMQ 'EVAL (CAR L)))))
			 (PROGN (AND EVALP 
				     (ATOM (ERRSET (MAPC 'EVAL (CDR L)) 'T))
				     (PDERR (COND ((NULL FILEPOSIBLE) FORM)
						  (`(,form (,fileposible = BEGINNING FILEPOS))))
					    |Evaluation loses due to some error|))
				(AND LOADP 
				     (SETQ PRATTSTACK 
					   (APPEND (CDR L) PRATTSTACK))) )))
	       (COND ((NOT (EQ INFILE X))
		      (MAPC '(LAMBDA (DATA)
				     (AND (FILEP DATA)
					  (SETQ X (CAR (STATUS FILEM DATA)))
					  (EQ (CAR X) 'IN) (EQ (CADR X) 'ASCII)
					  (NOT (EQ (CADDR X) 'TTY))
					  (EOFFN DATA 'COEFN)))
			    (CONS INFILE INSTACK))))
	       (GO A0))
	      ((COND (#%(SAILP) (MEMQ (CAR FORM) '(INCLUDE INCLUDEF REQUIRE)))
		     ((MEMQ (CAR FORM) '(INCLUDE INCLUDEF))))
	       (cond ((eq (car form) 'includef)
		      (setq form `(include ,(eval (cadr form))))))
	       (SETQ X INSTACK FL () )
	       (AND (NOT (PROBEF (COND ((CDDR FORM) (CDR FORM))
				       ((CADR FORM))))) 
		    (DBARF (CDR FORM) |File for INCLUDEsion is missing|))
	       (ERRSET (SETQ FL (EVAL FORM)) 'T) 			;Try to "include" file
	       (COND (TTYNOTES
		       (PROG (^W ^R)
			     (INDENT-TO-INSTACK 1)
			     (PRINC (COND (FL '|;Including file |)
					  ('T '|;Failure to include file |))) 
			     (PRIN1 (TRUENAME FL)))))
	       (COND (FL (EOFFN FL 'COEFN))
		     ('T (AND (NOT (EQ X INSTACK)) (INPUSH -1))
			 (PDERR FORM |File not included|)))
	       (GO A))
	      ((EQ (CAR FORM) 'CGOL) (CGOL))
	      ((EQ (CAR FORM) 'LAP) 
	        (CMP-LAPFUN (CDR FORM))
		(COND ((AND RECOMPL (NOT (MEMQ (CADR FORM) RECOMPL)))
			(ZAP2NIL FORM () ))
		      (FASLPUSH (AND LAPLL (TERFASL))
				(FASLIFY FORM 'LAP))			;Hack the LAP code
		      ('T (ZAP2NIL FORM 'T)
			  (AND TTYNOTES ((LAMBDA (^R ^W)
						 (PRINT (CADR FORM)) 
						 (PRINC '|LAP code zapped |))
					   () () )))) )
	      ((AND (EQ (CAR FORM) 'LAP-A-LIST)
		    (NOT (ATOM (CADR FORM)))
		    (EQ (CAADR FORM) 'QUOTE)
		    (SETQ X (CADADR FORM))
		    (NOT (ATOM (CAR X)))
		    (EQ (CAAR X) 'LAP))
	       (CMP-LAPFUN (CDAR X))
	       (COND ((OR (NOT FASLPUSH)
			  (AND RECOMPL (NOT (MEMQ (CADAR X) RECOMPL))))
		      (ICOUTPUT GOFOO)
		      (ICOUTPUT FORM))
		     ('T (AND LAPLL (TERFASL))
			 (FASLIFY X 'LIST))))
	      ((AND (EQ (CAR FORM) 'PROGN) 			;(PROGN 'COMPILE . . .)
		    (NOT (ATOM (CADR FORM)))
		    (EQ (CAADR FORM) 'QUOTE)
		    (EQ (CADADR FORM) 'COMPILE))
	       (SETQ PRATTSTACK (APPEND (CDDR FORM) PRATTSTACK))
	       (GO A))
	      ((COND ((OR (NOT FORM) (NOT (SYMBOLP (CAR FORM)))) () )
		     ((GET (CAR FORM) 'MACRO))
		     ((AND (GET (CAR FORM) 'AUTOLOAD) 
			   (NOT (GETL (CAR FORM) '(SUBR FSUBR LSUBR EXPR FEXPR)))
			   (OR (NULL (SETQ FL (GET (CAR FORM) 'FUNTYP-INFO)))
			       (EQ (CAR FL) 'MACRO)))
		      (FUNCALL AUTOLOAD (CONS (CAR FORM) (GET (CAR FORM) 'AUTOLOAD)))
		      (GET (CAR FORM) 'MACRO)))
	       (SETQ FL () )
	       (COND ((OR (NULL (ERRSET (SETQ FORM (MACROEXPAND FORM)
					      FL 'T )
					'T))
			  (NULL FL)) 
		      (PDERR (COND ((NULL FILEPOSIBLE) FORM)
				   (`(,form (,fileposible = BEGINNING FILEPOS))))
			     |Error during top level MACRO expansion|)
		      (GO A)))
	       (GO B) )						;Apply macro property and try again
	      ((NOT RECOMPL) 
	       (SETQ LAP-INSIGNIF () )
	       (ICOUTPUT GOFOO)
	       (COUTPUT FORM)
	       (AND (EQ (CAR FORM) 'COMMENT) LAPLL (TERFASL)) ))
	(AND (NOT FASLPUSH) (ICOUTPUT GOFOO))
	(GO A)

     ICF 	(SETQ LAP-INSIGNIF () )
		(ICOUTPUT FORM)
		(AND (NOT FASLPUSH) (PROG2 (ICOUTPUT NULFU) (ICOUTPUT GOFOO)))
		(GO A)

     GH (DBARF FORM |Illegal DEFUN format| 4 4) )))

;; COMPREAD reads forms from INFILE until there are none, then from
;; EOF-COMPILE-QUEUE until there are none, and then returns its argument.
;; EOF-COMPILE-QUEUE can be added to by the user as "things to compile after
;; everything else in the file.  It uses EOF-SEEN to keep track of whether or
;; not it has seen the end of the file or not, to avoid reading a closed file.

(DEFUN COMPREAD (eof-val)
   (LET ((form eof-val))
     (COND ((AND (OR EOF-SEEN	   ;If EOF or newly EOF, and stuff is on
		     (EQ eof-val   ;the EOF-COMPILE-QUEUE, compile it
			 (SETQ FORM (COND (EOF-SEEN eof-val)
					  (READ (FUNCALL READ eof-val))
					  ('T (AND FILEPOSIBLE 
						   (SETQ FILEPOSIBLE
							 (FILEPOS INFILE)))
					      (READ eof-val))))))
		 EOF-COMPILE-QUEUE)
	    (SETQ EOF-SEEN T)  ;We've seen the end, don't read past it!
	    (SETQ EOF-COMPILE-QUEUE (NREVERSE EOF-COMPILE-QUEUE))
	    (POP EOF-COMPILE-QUEUE FORM)
	    (SETQ EOF-COMPILE-QUEUE (NREVERSE EOF-COMPILE-QUEUE))
	    form)
	   ((OR EOF-SEEN (EQ form eof-val)) eof-val)
	   (T form))))


(eval-when (eval load)
      (cond ((alphalessp (status lispv) '/2025)
	     (putprop 'OLD-+INTERNAL-/"-MACRO
		      (get '+INTERNAL-/"-MACRO 'subr)
		      'subr)
	     (defun +INTERNAL-/"-MACRO ()
		    ((lambda (x)
			     (putprop x 'T '+INTERNAL-STRING-MARKER)
			     (putprop x `(SPECIAL ,string) 'SPECIAL)
			     string)
		        (OLD-+INTERNAL-/"-MACRO)))))
)



(DEFUN CMP1-MACRO-ENLIVEN (FORM FL)
;;; Expects input to be of form  "(DEFUN name MACRO (var) . body)"
    ((LAMBDA (NAME)
	     (COND ((NULL MACROS))
		   ((NOT FL))
		   ('T (ICOUTPUT FORM)
		       (SETQ LAP-INSIGNIF () ) ))
	     (COND ((LAND '(EXPR FEXPR SUBR FSUBR LSUBR AUTOLOAD)
			  (STATUS SYSTEM NAME))
		    (OR (GET NAME 'SKIP-WARNING)
			(WARN (cond ((filep infile) 
				     `(,name FROM USER FILE ,infile))
				    (name))
			      |being redefined as a MACRO -- definition is pushed onto MACROLIST|))
		    (PUSH (CONS NAME (CONS 'LAMBDA (CDDDR FORM))) MACROLIST))
		   ('T (EVAL FORM))))
	(CADR FORM)))
	

(DEFUN TERFASL ()
       (FASLIFY (NREVERSE (PROG2 () LAPLL (SETQ LAPLL () )))
		'LIST))

(DEFUN COEFN (FIL EOFVAL)							;Standard EOFFN for main
       (AND (EQ FIL INFILE) (INPUSH -1))					; input source file
       (COND (TTYNOTES								;Pop file off stack
	      (PROG (^W ^R)
		    (INDENT-TO-INSTACK 0)
		    (PRINC '|;End Of File |)
		    (PRIN1 (NAMESTRING (TRUENAME FIL))))))
       (AND (FILEP FIL) (CLOSE FIL))	 	;Close file.  If more is on
       (COND (INSTACK 'T)	 		;  stack, keep reading;
	     ('T EOFVAL)))	 		;  otherwise we have a real EOF


(DEFUN CHMP2 (L FILE)				;"CHOMP"ing also to a file
       (AND (NOT (GET 'FASL-START 'SUBR)) 
	    (DBARF () |Cant CHOMP to file without FASLOAD|))
       (FASL-START FILE () )
       (LAP-FILE-MSG (CONS '|##IN-CORE-FUNCTIONS##| L) 
		     (CONS TYO UFFIL))
       (MAPC '(LAMBDA (X) (CHMP1 X) (FASLIFY LAPLL 'LIST))
	     L)
       (FASL-CLOSEOUT FILE '((|##IN-CORE-FUNCTIONS##|)) FILE))


(DEFUN CMP-LAPFUN (X)
   #%(LET ((TYPE (CDR (ASSQ (CADR X) '((SUBR . *EXPR)
				       (FSUBR . *FEXPR)
				       (LSUBR . *LEXPR)))))
	   (PROP (GETL (CAR X) '(*EXPR *FEXPR *LEXPR))))
       (SETQ LAP-INSIGNIF () 
	     TOPFN (CAR X) )
       (COND ((AND PROP (NOT (EQ (CAR PROP) TYPE)))
	       (WRNTYP (CAR X)))
	     (TYPE (SETQ UNDFUNS (DELQ (CAR X) UNDFUNS))
		   (PUTPROP (CAR X) 'T TYPE)))))


(DEFUN INDENT-TO-INSTACK (II)		     ;TERPRI and indent proportional to length of INSTACK
       (TERPRI)
       (DO ((N (- (LENGTH INSTACK) II 2) (1- N))) 
	   ((MINUSP N))
	 (PRINC '|   |)))

(DEFUN PRINT-LINEND (X FLAG)
   (COND (FLAG (PRIN1 X)) ((PRINC X)))
   (PRINC '|/) |)
   (TERPRI)
   'T)

(DEFUN LAP-FILE-MSG (REALI L)
  #%(LET ((TERPRI 'T) (OUTFILES L) TEM)
	(SETQ TEM (STATUS DATE))
	(SETQ ^W (SETQ ^R 'T))
	(COND (FASLPUSH (UNFASL-MSG REALI))
	      ('T (TERPRI)
		  (PRINC '|'(THIS IS THE LAP FOR |)
		  (PRINT-LINEND REALI 'T)))
	(PRINC '|'(COMPILED BY LISP COMPILER //|)
	(PRINC COMPLRVERNO)
	(PRINC '| COMAUX //|) (PRINC COMAUXVERNO)
	(PRINC '| PHAS1 //|)  (PRINC PHAS1VERNO)
	(PRINC '| MAKLAP //|) (PRINC MAKLAPVERNO)
	(PRINC '| INITIA //|) (PRINT-LINEND INITIAVERNO () )
	(COND (TEM #%(LET ((BASE 10.) (*NOPOINT 'T) (APM 'AM) (II 0))
			 (TERPRI)
			 (PRINC '|;COMPILED ON |)
			 (COND ((AND #%(ITSP) (SETQ APM (STATUS DOW)))
				(PRINC APM)
				(SETQ APM 'AM)
				(PRINC '|, |)))
			 (PRINC (CAR #%(NCDR '(JANUARY FEBRUARY MARCH APRIL MAY 
					      JUNE JULY AUGUST SEPTEMBER 
					      OCTOBER NOVEMBER DECEMBER)
					   (1- (CADR TEM)))))
			 (PRINC '| |)
			 (PRINC (CADDR TEM))
			 (PRINC '|, |)
			 (PRINC (+ 1900. (CAR TEM)))
			 (COND ((SETQ TEM (STATUS DAYTIME))
				(PRINC '|, AT |)
				(SETQ II (CAR TEM))
				(COND ((ZEROP II)
					(AND (= (CADR TEM) 0) 
					     (SETQ APM 'MIDNITE))
					(PRINC '/12))
				      ((= II 12.)
				       (SETQ APM  (COND ((= (CADR TEM) 0)
							 'NOON)
							('PM)))
					(PRINC '/12))
				       ('T (AND (> II 12.) 
						(SETQ APM 'PM II (- II 12.)))
					   (PRINC II)))
				(COND ((< (CADR TEM) 10.) (PRINC '/:/0))
				      ('T (PRINC '/:)))
				(PRINC (CADR TEM))
				(PRINC '/ )
				(PRINC APM)))
			 (TERPRI))))
	(SETQ LAP-INSIGNIF 'T)))

(DEFUN MAKLAP FEXPR (L)
 (COND (FILESCLOSEP (SETQ CMSGFILES () ) (GC) (SETQ FILESCLOSEP () )))
#%(LET ((EOC-EVAL EOC-EVAL) (RECOMPL RECOMPL) (LINEL 120.) (READ READ) (*LOC 0)
       (OCMSGFILES CMSGFILES) (IMOSAR IMOSAR) (INFILE 'T) (FILOC 0) (LITLOC 0))
 (PROG (BRKC LINE INMLS ONMLS JCLP REALI FSLNL DEFAULT-NAMELIST DEF2N TOPFN 
	SWITCHLIST OPNDP FASLERR COMPILER-STATE LAP-INSIGNIF CURRENTFNSYMS 
	CURRENTFN MAINSYMPDL UNFASLSIGNIF ENTRYNAMES ALLATOMS FBARP START-LINE 
	SYMPDL ATOMINDEX DDTSYMP SYMBOLSP LITERALS NOC F-NOC TEM OUTFILES 
	INSTACK FILEPOSIBLE UFFIL CMSGFILES FASLPUSH ^W ^Q ^R ) 
 B0 	(SETQ UNDFUNS () COMPILER-STATE 'MAKLAP FSLNL () 
		REALI () FASLPUSH () LAP-INSIGNIF 'T FASLERR () 
		CMSGFILES OCMSGFILES F-NOC () )
 B	(SETQ ^W (SETQ ^R (SETQ ^Q () )))
	(SETQ SWITCHLIST () INMLS () )
	(SETQ DEFAULT-NAMELIST (CONS (LIST 'DSK (STATUS UDIR))
				     (CONS '* (COND (#%(ITSP) '(>) )
						    (#%(SAILP) '(|___|) )
						    ('(LSP) )))))
	(COND ((NULL L)						   ;Normal case
	       (TERPRI)
	       (PRINC '|_| TYO)
	       (AND (NUMBERP (SETQ TEM (READLINE TYI 0))) (GO B))
	       (SETQ LINE (EXPLODEN TEM)))
	      ((AND (CAR L) (ATOM (CAR L))) 			   ;Compilation begun from JCL
	       (SETQ JCLP 'T LINE L L () ))
	      ('T (AND TTYNOTES (NOT DISOWNED) (TERPRI))	   ;JPG's case
		  (SETQ DEF2N (FASL-LAP-P))
		  (COND ((CDR L) 
			 (SETQ ONMLS (LIST (MERGEF (MERGEF (CAR L) DEF2N) 
						   DEFAULT-NAMELIST)) 
			       INMLS (MAPCAR 'NAMELIST (CDR L)))
			 (MAKLAP-MERGEF 
			  INMLS 
			  (COND ((EQ MAKLAP-DEFAULTF-STYLE 'MIDAS)
				 (MERGEF (CDR DEFAULT-NAMELIST)
					 (CAR (LAST ONMLS))))
				(DEFAULT-NAMELIST))))
			((SETQ INMLS (LIST (MERGEF (CAR L) DEFAULT-NAMELIST))
			       ONMLS (LIST (MERGEF DEF2N (CAR INMLS))))))
		 (GO A)))
	(AND (= (CAR LINE) #/( ) (PUSH #/  LINE))
	 ;; Position START-LINE for switch parsing
	(SETQ START-LINE (DO L LINE (CDR L) (NULL (CDR L))
			     (COND ((OR (= (CADR L) #/) (= (CADR L) #//))
				    (POP L))
				   ((= (CADR L) #/( ) (RETURN L)))))
	(AND (NULL START-LINE) (GO A0))
	(DO ( (OBARRAY SOBARRAY) (PARITY 'T)
	      (L (CDR START-LINE) (CDR L)) )
	    ((NULL L)) 
	  (COND ((= (CAR L) #/) )			;right parens
		 (RPLACD START-LINE (CDR L))		;cuts out chars for switches
		 (RETURN () ))
		((NOT (> (CAR L) #/ )))			;ignore space and tab
		((OR (= (CAR L) #/I) (= (CAR L) #/i))	;Upper and lower case I
		 (PUSH 
		  (COND ((= (CADR L) #/[)		;Aha!, a "["
			 (POP L)
			 (DO ((Z)) 
			     ((OR (NULL L) (= (CAR L) #/]))	; so look for "]"
			      (MAKNAM (NREVERSE Z)))
			     (PUSH (POP L) Z)))
			('(T)))
		  INITIALIZE)
		 (SETQ PARITY 'T))
		((= (CAR L) #/-) (SETQ PARITY () ))			;- means set to ()
		((DO ((C (COND ((AND (NOT (< (CAR L) #/a)) 
				     (NOT (> (CAR L) #/z)))
				(- (CAR L) #.(- #/a #/A)))
			       ('T (CAR L))))
		      (SWS SWITCHTABLE (CDR SWS)))
		     ((NULL SWS) () )
		   (COND ((= C (GETCHARN (CAAR SWS) 1)) 
			  (PUSH (LIST (CADAR SWS) PARITY) SWITCHLIST)
			  (RETURN 'T))))
		 (SETQ PARITY 'T ))))
	(AND (NULL INITIALIZE) (NULL SWITCHLIST) (GO IIS))
    ;	Create file names from input line characters and do filename defaulting
    A0	(SETQ DEF2N (FASL-LAP-P))	
	 ;;YOU LOSER! howcome the function which actually activates the
	 ;;  switches in the switchlist is called FASL-LAP-P?
	(AND JCLP (NOT TTYNOTES) (SSTATUS FEATURE NOLDMSG))
	(AND (OR (NULL LINE) (= (CAR LINE) #/_) (= (CAR LINE) #/,))
	     (GO IIS))
	(SETQ START-LINE LINE BRKC () )			;scan to "_" or end
	(DO  ( (L LINE (CDR L)) )
	     ( (OR (NULL (CDR L)) (= (CADR L) #/_))
		(SETQ BRKC (CADR L) LINE (CDDR L))
		(RPLACD L () )))
	(COND ((NULL LINE)
	       (SETQ INMLS (RDSYL START-LINE DEFAULT-NAMELIST) 
		     ONMLS (LIST (MERGEF DEF2N (CAR INMLS)))))
	      ('T (SETQ ONMLS (RDSYL START-LINE (CONS (CAR DEFAULT-NAMELIST)
						      DEF2N)))
		  (AND (OR (NULL BRKC) 
			   (NULL LINE) 
			   (= (CAR LINE) #/_) 
			   (= (CAR LINE) #/,))
		       (GO IIS))
		  (SETQ START-LINE LINE BRKC () )	;scan to "_" or end
		  (DO  ( (L LINE (CDR L)) )
		       ( (OR (NULL (CDR L)) (= (CADR L) #/_))
			(SETQ BRKC (CADR L) LINE (CDDR L))
			(RPLACD L () )))
		  (AND (OR BRKC LINE) (GO IIS))
		  (SETQ INMLS (RDSYL START-LINE 
				     (COND ((EQ MAKLAP-DEFAULTF-STYLE 'MIDAS)
					    (MERGEF (CDR DEFAULT-NAMELIST)
						    (CAR (LAST ONMLS))))
					   (DEFAULT-NAMELIST)) ))
		  (AND (EQ MAKLAP-DEFAULTF-STYLE 'MIDAS)
		       (EQ (CADAR ONMLS) '*)
		       (MAKLAP-MERGEF ONMLS (CAR INMLS)))))
	(AND (OR (OR (NULL INMLS) (EQ (CADAR INMLS) '*))
		 (OR (NULL ONMLS) (EQ (CADAR ONMLS) '*)))
	     (GO IIS))
    A   (SETQ FASLPUSH (AND (NOT ASSEMBLE) NOLAP))
	(SETQ FILESCLOSEP 'T)
	(SETQ REALI (ERRSET (EOPEN (COND (#%(SAILP) (UGREAT1 (CAR INMLS)))
					 ((CAR INMLS)))
				   'IN) 
			    () ))
	(COND (REALI 
		(SETQ REALI (TRUENAME (INPUSH (CAR REALI))))
		((LAMBDA (BASE *NOPOINT)
			 (SETQ GENPREFIX 
			       (NCONC (COND ((OR #%(SAILP) #%(DEC10P))
					     (NCONC (LIST '/[)
						    (EXPLODEC (CAR (CADAR REALI))) 
						    (LIST '/,)
						    (EXPLODEC (CADR (CADAR REALI)))
						    (LIST '/])))
					    (#%(DEC20P)
					      (NCONC (LIST '/<)
						     (EXPLODEC (CADAR REALI))
						     (LIST '/>)))
					    ('T (NCONC (EXPLODEC (CADAR REALI)) (LIST '/;))))
				      (EXPLODEC (CADR REALI))
				      (LIST (COND (#%(ITSP) '/ ) ('/.)))
				      (EXPLODEC (CADDR REALI))
				      '(/_))))
		 10. 'T))
	      ((AND L (NOT JCLP)) (RETURN () ))
	      ('T (PRIN1 (CAR INMLS)) 
		  (PRINC '| File Not Found - MAKLAP|)
		  (GO B0)))
	(COND ((AND JCLP (OR TTYNOTES YESWARNTTY)) () )
	      ((OR DISOWNED JCLP) (GIVUPTTY)))
	(COND (ASSEMBLE (FASL-A-FILE (CAR ONMLS) INMLS)
		 	(AND NOLAP 
			     (NOT (MEMBER (CAR ONMLS) INMLS))
			     (MAPC 'FASL-DELETEF INMLS))
			(GO ENDUP)))
	(COND (FASLPUSH  (FASL-START (SETQ FSLNL (CAR ONMLS)) () ))
	      ('T (POP ONMLS TEM)
		  (AND FASL (SETQ FSLNL TEM))
		  (LAPOP TEM)))
	(AND (OR YESWARNTTY TTYNOTES)
	     (NOT (MEMQ TYO CMSGFILES))
	     (PUSH TYO CMSGFILES))
	(SETQ OPNDP 'T)
    D2  (COND ((NULL (CAR INMLS)) (WARN () |Phooey on JPG - MAKLAP|) (GO ENDUP)))
	(SETQ NOC () )
	(COND (OPNDP (SETQ OPNDP ())
		     (COND (#%(SAILP)
			     (EOPEN INFILE 'IN)))
		     (SETQ REALI (LIST REALI)))
	      ('T (APPLY 'EREAD (CAR INMLS))
		  (SETQ FILEPOSIBLE 
			(AND (FILEP UREAD)
			     (MEMQ 'FILEPOS (STATUS FILEMODE UREAD))
			     '0))
		  (PUSH (NAMELIST UREAD) REALI)))
	(AND TTYNOTES 
	     (PROG (^R ^W)
		   (TERPRI)
		   (PRINC '|Compilation begun on |)
		   (PRIN1 (CAR REALI))
		   (PRINC '| |)))
	(LAP-FILE-MSG (CAR REALI) (COND (FASLPUSH UFFIL)		;Sets LAP-INSIGNIF to T
					('T (CONS LAPOF UFFIL))))	; as well as ^R ^W

	(SETQ ^Q 'T)
    C	(SETQ TOPFN () 
	      TEM (COND ((OR (NOT (FILEP INFILE))
			     (NULL (STATUS FILEMODE INFILE)))
			 CLPROGN)
			((ERRSET (CMP1 () ) 'T))))
	(COND ((ATOM TEM)
		(AND (EQ TEM 'FASLAP) (SETQ FASLERR 'T))
		(COND (FASLPUSH)
		      ('T (PRINC '| () | LAPOF)))
		(AND TOPFN (SETQ NOC (CONS TOPFN NOC)))	;NOC accumulates function names that cop out 
		(COND ((NULL TEM)
		       #%(WARN `((TOPFN ,topfn)
				,(cond ((null fileposible) '(CLOSED FILEPOS))
				       (`(,fileposible = BEGINNING FILEPOS))))
			      |Lisp Error during file compilation|)
		       (MSOUT-BRK () COBARRAY CREADTABLE 'LISP-ERROR)
		       (GO C))
		      ((EQ TEM GOFOO) 
		       #%(DBARF `((INFILE ,infile)
				,(cond ((null fileposible) '(CLOSED FILEPOS))
				       (`(,fileposible = BEGINNING FILEPOS))))
			       |EOF encountered during READ, 
		possibly misbalanced paresn?|))
		      ('T (GO C))) ))
	      (SETQ TOPFN () )
	(COND (NOC 
	       (SETQ NOC (NREVERSE NOC))
	       (SETQ F-NOC (NCONC F-NOC (APPEND NOC () )))
	       #%(WARN NOC |- Failed to compile|)))
	(COND ((SETQ INMLS (CDR INMLS)) (GO D2)))
	(COND (UNDFUNS #%(WARN UNDFUNS |have been used but remain undefined in this file|)))
	(SETQ REALI (NREVERSE REALI))
	(AND TTYNOTES 
	    (PROG (^Q ^R ^W)
		  (TERPRI)
		  (PRINT (COND ((CDR REALI) REALI) ((CAR REALI))))
		  (PRINC '| Finished compilation|) 
		  (COND (F-NOC  (PRINC '|, but |)
				(PRIN1 F-NOC)
				(PRINC '| Failed to compile|)))
		  (PRINC '| |) ))
	(COND (FASLERR 
		#%(WARN () |/
  **ERROR** FASL file aborted due to errors during FASLAP|)
		(AND FASLPUSH (FASL-CLOSEOUT () () FSLNL)))
	      (FASLPUSH 
		 (FASL-CLOSEOUT (CAR ONMLS)
				(AND (NOT LAP-INSIGNIF) REALI)
				FSLNL))
	      ('T (LAPCL (CAR ONMLS))
		  (SETQ ONMLS (NREVERSE ONMLS))
		  (AND FSLNL (FASL-A-FILE FSLNL ONMLS))))
	(AND (FILEP INFILE) (CLOSE INFILE))
	(SETQ FILESCLOSEP () )
  ENDUP	(MAPC 'EVAL EOC-EVAL)
	(AND (OR JCLP DISOWNED) (QUIT))
  EXIT  (AND L (RETURN () ))
  	(GO B0)
  IIS	(PRINC '|INCORRECT COMMAND SYNTAX - MAKLAP|) (GO EXIT) )))


(DEFUN FASL-LAP-P () 
	(AND INITIALIZE 
	     (MAPC '(LAMBDA (X) (COND ((SYMBOLP X) (ELOAD X))
				      ('T (INITIALIZE))))
		   INITIALIZE))
	(MAPC 'SETQ SWITCHLIST)
	(COND ((OR ASSEMBLE NOLAP FASL) '(* FASL))
	      ('(* LAP))))
	;Returns "LAP" iff this run is compile-only

;;;  HOW TO DISOWN FROM A ^B BREAK
(DEFUN DISOWN FEXPR (X) (SETQ DISOWNED 'T) (GIVUPTTY) (*THROW 'BREAK X))

(DEFUN GIVUPTTY () 
    (SETQ GAG-ERRBREAKS (SETQ ^W 'T) TTYNOTES () YESWARNTTY () )
    (SSTATUS FEATURE NOLDM)
    (AND (MEMQ TYO CMSGFILES) 
	 (SETQ CMSGFILES (DELQ TYO (APPEND CMSGFILES () ))))
    (AND (MEMQ TYO MSGFILES) 
	 (SETQ MSGFILES (DELQ TYO (APPEND MSGFILES () ))))
    (AND (STATUS TTY)
	 (EQ (STATUS OPSYSTEM-TYPE) 'ITS)
	 (STATUS HACTRN)
	 (VALRET (COND (DISOWNED '|:PROCED :DISOWN |) ('|:PROCED |))))
    (AND RUNTIME-LIMITP 
	 (NUMBERP RUNTIME-LIMIT)
	 (> (SETQ RUNTIME-LIMIT (FLOAT RUNTIME-LIMIT)) 2.0)
	 (SETQ ALARMCLOCK 'STOP-RUNAWAYS)
	 (ALARMCLOCK 'RUNTIME RUNTIME-LIMIT)))

(DEFUN STOP-RUNAWAYS (())
       (MSOUT-BRK RUNTIME-LIMIT COBARRAY CREADTABLE 'RUNTIME-LIMITP))


;; SPLITFILE/EOF-COMPILE-QUEUE/PRATTSTACK interaction works as follows.
;; If there are no forms on EOF-COMPILE-QUEUE, the SPLITFILE splits the file.
;; Otherwise, a call to SPLITFILE is put onto the PRATTSTACK so we get called
;; again, and one form from the EOF-COMPILE-QUEUE is pushed onto the PRATTSTACK
;; to be run.  We will be re-called with the same argument when the PRATTSTACK
;; is popped down to the (DECLARE (SPLITFILE ...)) we pushed.
;; Once the new splitfile has been done, the forms on SPLITFILE-HOOK are
;; compiled in reverse order, as if withing a (PROGN 'COMPILE ...)

(DEFUN SPLITFILE FEXPR (L)
  (cond (EOF-COMPILE-QUEUE
	 (PUSH `(DECLARE (SPLITFILE ,@L)) PRATTSTACK)
	 (PUSH (CAR (LAST EOF-COMPILE-QUEUE)) PRATTSTACK)
	 (SETQ EOF-COMPILE-QUEUE (DELQ (CAR PRATTSTACK) EOF-COMPILE-QUEUE)))
	(T
	 (COND ((OR ASSEMBLE (NULL L) (CDR L))
		(PUSH 'SPLITFILE L)
		(COND (ASSEMBLE
		       (PDERR L |SPLITFILE not yet implemented for A switch|))
		      ((PDERR L |Lose lose - SPLITFILE|)))))
	 (SETQ L (LIST (CAAR ONMLS) (CAR L) (CADDAR ONMLS)))
	 (COND (FASLPUSH 
		(FASL-CLOSEOUT (CAR ONMLS)
			       (COND (LAP-INSIGNIF (POP ONMLS) () )
						   ;() FLUSHES NULL FASL FILE
				     ('T (TERFASL) (CAR ONMLS)))
			       () )		   ;Dont close unfasl file
		(FASL-START L 'T)		   ;but do continue it
		(UNFASL-MSG L)
		(PUSH L ONMLS))
	       ('T (LAPCL (CAR ONMLS))		  ;SETS LAP-INSIGNIF TO T
		   (COND (LAP-INSIGNIF 	  	  ; AS WELL AS ^R ^W
			  (FASL-DELETEF (CAR ONMLS))
			  (POP ONMLS)))
		   (LAP-FILE-MSG (LAPOP L) (LIST LAPOF))))
	 (SETQ PRATTSTACK (REVERSE SPLITFILE-HOOK))
	 (SETQ SPLITFILE-HOOK ()))))

(SETQ SPLITFILE-HOOK ())

(DEFUN LAPCL (F)
   (SETQ CMSGFILES (DELQ LAPOF CMSGFILES))
   (SETQ OUTFILES (DELQ LAPOF OUTFILES))
   (COND (F (AND (PROBEF F) (FASL-DELETEF F))
	    (AND (FILEP LAPOF) (FASL-RENAMEF LAPOF F))))
   (AND (FILEP LAPOF) (CLOSE LAPOF))
   F)

(DEFUN LAPOP (F)
      (SETQ F (MERGEF '((DSK *) * LAP) F))
      (SETQ LAPOF (EOPEN (MERGEF '(* _LAP_) F) 'OUT))
	  (LINEL LAPOF 80.)
	  (PUSH LAPOF OUTFILES)
	  (PUSH LAPOF CMSGFILES)
      (PUSH F ONMLS)
      F)


(DEFUN RDSYL (L DF) 
  (PROG (LL BRAKP ANS CH)
	(SETQ DF (MERGEF DF '((* *) * *)))
     AA	(SETQ LL (SETQ BRAKP () ))
     A	(SETQ CH (OR (CAR L) #/_))
        (COND ((OR (= CH #/) (= CH #//))	 			;"/", ""
	       (POP L)
	       (SETQ CH (CAR L)))
	      ((AND (= CH #/[) (NOT #%(ITSP)))				;"["
	       (SETQ BRAKP 'T))
	      ((AND (= CH #/]) (NOT #%(ITSP))) (SETQ BRAKP () ))	;"]"
	      ((OR (= CH #/( ) (= CH #/) )) (RETURN () ))		;Cant have parens here
	      ((= CH #/,)					;Comma
	       (COND ((NOT BRAKP)
		      (POP L)
		      (GO RET))))
	      ((= CH #/_) (GO RET)))
	(PUSH CH LL)
	(POP L)
	(GO A)
   RET  (SETQ DF (MERGEF (NAMELIST (MAKNAM (NREVERSE LL))) DF))
	(SETQ ANS (NCONC ANS (LIST DF)))
	(AND (= CH #/,) (GO AA))
	(RETURN ANS) ))

(DEFUN MAKLAP-MERGEF (LL DFNL)
  (MAP '(LAMBDA (L) (RPLACA L (SETQ DFNL (MERGEF (CAR L) DFNL))))
	LL)
  () )



;;;(DEFUN FNCP (II)			;File-Name-Character-Predicate
;;;    (OR (LESSP 59. II 95.)		;Gets <, ?, @, A-Z, [, \, ], ^
;;;	(LESSP 47. II 58.)		;Gets 0 - 9
;;;	(LESSP 32. II 40.)		;Gets ! to ' (Tops of 1 to 4)
;;;	(= II 43.) (= II 45.)		;Gets + and -
;;;	(COND ((NOT #%(ITSP)) () )
;;;	      ((OR (= II 42.)		;Gets *
;;;		   (= II 46.))))))	;Gets .



(DEFUN ZAP2NIL (DATA FL) 
  (DECLARE (SPECIAL LINEL) (FIXNUM LINEL CHAR))
  (PROG (CHAR FLAG N LINEL ^R ^W)
	(SETQ LINEL (LINEL LAPOF))
	(SETQ ^R (SETQ ^W 'T))
	(COND (FL (TERPRI)
		  (LINEL LAPOF 0.)
		  (PRINT DATA)))
     A  (SETQ CHAR (ZTYI))
	(COND ((= CHAR #\CR ) 						;<carriage-return>
		(AND (= #\LF (TYIPEEK)) (TYI)) 				;flush any following line-feed
		(SETQ FLAG () ))
	      (FLAG)
	      ((= CHAR #//) (AND FL (TYO CHAR)) (SETQ CHAR (ZTYI)))	;<slash>
	      ((= CHAR #/;) (SETQ FLAG 'T))				;<semi-colon>
	      ((= CHAR #/( ) 						;<open-parens>
		(AND (ZEROP N) 
		     (= (TYIPEEK) #/) )					;<close-parens>
		     (PROG2 (AND FL (PRINC '|() |) (TERPRI) (TYO #\FORMFEED))
			    (GO XIT)))
		(SETQ N (1+ N)))
	      ((= CHAR #/) ) (SETQ N (1- N)))				;<close-parens>
	      ((AND (OR (= CHAR #/N) (= CHAR #/n)) (ZEROP N))		; |N|, |n|
		(AND FL (TYO CHAR))
		(COND ((OR (= (SETQ CHAR (ZTYI)) #/I) (= CHAR #/i))	; |I|, |i|
			(AND FL (TYO CHAR))
			(COND ((OR (= (SETQ CHAR (ZTYI)) #/L) 		; |L|, |l|
				   (= CHAR #/l))
				(AND FL (TYO CHAR))
				(COND ((= (SETQ CHAR (ZTYI)) #/ )
					(AND FL (PRINC '| |) 
						(TERPRI) 
						(TYO #\FORMFEED ))
					(GO XIT)))))))))
	(AND FL (TYO CHAR))
	(GO A)
    XIT (LINEL LAPOF LINEL) ))


(DEFUN ZTYI ()
    ((LAMBDA (CHAR)
	(AND (OR (= CHAR -1) 
		 (AND #%(ITSP) 
		      (= CHAR 3)
		      (OR (NOT (FILEP INFILE))
			  (AND (MEMQ 'FILEPOS (CDR (STATUS FILEM INFILE)))
			       (> (FILEPOS INFILE) (- (LENGTHF INFILE) 6))) )))
	     (SETQ TOPFN (CADR DATA))				;set up name of losing LAP function
	     (DBARF '? |End-Of-File in middle of LAP code - check for misbalanced parens|))
	CHAR)
      (TYI -1)))


;;; FASL-A-FILE SHOULD ONLY BE CALLED BY MAKLAP, FOR MAKLAP BINDS LOTS OF LOSING SPECIAL VARIABLES
;;; HOWEVER, FASLTRY TRYES TO SIMULATE THIS CALL FOR A TEST CASE

(DEFUN FASL-A-FILE (TARGETFILE SOURCEFILES)
  ((LAMBDA (BASE IBASE OBARRAY READTABLE MSDIR EOF WINP REALSFS TOPFN)
	   (ERRSET 
		(PROGN 
		  (GCTWA T)
		  (FASL-START TARGETFILE () )
		  (DO SFS SOURCEFILES (CDR SFS) (NULL SFS)
		     (APPLY 'EREAD (CAR SFS))				;OPEN LAP SOURCE FILE
		     (PUSH (STATUS UREAD) REALSFS)
		     (UNFASL-MSG (CAR REALSFS))
		     (SETQ ^Q T)
		     (DO Y 
			 (READ EOF) 
			 (AND ^Q (READ EOF))
			 (OR (NULL ^Q) (EQ Y EOF))
			(FASLIFY Y ())))
		  (SETQ WINP T)))
	   (GCTWA ())
	   (COND ((OR (NULL WINP) FBARP)				;IF SOME ERROR OCCURRED,
		  (SETQ TOPFN CURRENTFN)
		  (PDERR (LIST *LOC FILOC) |Faslization aborted after so many words| )
		  (AND ^Q (DO () ((EQ EOF (READ EOF)))))		;CLEAN OUT TO END OF FILE
		  (SETQ REALSFS ()) 					;IDENTIFY LOSER TO FASL-CLOSEOUT
		  (ERR 'FASLAP)))
	   (FASL-CLOSEOUT TARGETFILE REALSFS TARGETFILE) 
	   (AND TTYNOTES 
		(PROG (^W ^R)
		      (INDENT-TO-INSTACK 0)
		      (PRIN1 (COND ((NULL (CDR SOURCEFILES)) (CAR SOURCEFILES))
				   (SOURCEFILES))) 
		      (PRINC '| assembled - |)
		      (PRIN1 FILOC)
		      (PRINC '| Words|)))
	   (GCTWA)
	   WINP)
    8. BASE COBARRAY CREADTABLE MSDIR (LIST ()) () () ()))


(DEFUN FASL-START (FILE CONTINUEP)
  ((LAMBDA (UNFASL-DIR)
      (SETQ USERATOMS-INTERN () ) 
      (SETQ IMOSAR (EOPEN (MERGEF '(* /_FASL/_) FILE) '(OUT FIXNUM)))		;Open FASL output file
      (COND ((NOT CONTINUEP) 
	     (SETQ UFFIL (EOPEN (MERGEF (CONS (LIST '* UNFASL-DIR) 		;Open UNFASL file
					      '(* /_UNFA/_))
					FILE) 
				'(OUT)))
	     (PUSH UFFIL CMSGFILES)
	     (LINEL UFFIL 80.)
	     (AND (SETQ UNFASL-DIR (PROBEF IMOSAR)) (FASL-DELETEF UNFASL-DIR))
	     (AND (SETQ UNFASL-DIR (PROBEF UFFIL)) (FASL-DELETEF UNFASL-DIR))
	     (SETQ UFFIL (LIST UFFIL)) ))
      (FASLOUT #.(CAR (PNGET '|*FASL+| 6)))				;First of two word header
      (FASLOUT LDFNM)							;  is SIXBIT |*FASL+|
      (SETQ ALLATOMS (SETQ ENTRYNAMES (SETQ SYMPDL 
	    (SETQ MAINSYMPDL (SETQ CURRENTFNSYMS ())))))
      (SETQ BINCT 0)
      (FILLARRAY 'NUMBERTABLE '(()) )
      (SETQ FILOC (SETQ LITLOC (SETQ *LOC (SETQ ATOMINDEX 0))))
      (SETQ ^W (SETQ ^R T)))
  (COND (MSDIR)
	((CADAR FILE))
	('*))))


(DEFUN FASL-CLOSEOUT (TARGETFILE SOURCEFILES UNFASLNAM)
      (AND UNFASLNAM (SETQ UNFASLNAM (MERGEF '(* UNFASL) UNFASLNAM)))
      (BUFFERBIN 17 0 ())						;End of file flag
      (COND ((NOT SOURCEFILES) 
	     (SETQ TARGETFILE (MERGEF '(/_FASL_/ OUTPUT) TARGETFILE)))
	    ((NOT #%(DEC20P)) )
	    ((LET ((SRC (PROBEF (CAR SOURCEFILES)))
		   (F))
	       (COND ((NULL SRC) () )	;Cant win if no real sourcefile?
		     (T (AND (SETQ F (RENAMEVERNOP TARGETFILE SRC))
			     (SETQ TARGETFILE F))
			(AND UNFASLNAM 
			     (SETQ F (RENAMEVERNOP UNFASLNAM SRC))
			     (SETQ UNFASLNAM F)))))))
      (FASL-RENAMEF IMOSAR TARGETFILE)
      (SETQ IMOSAR ())							;Close binary output file
      (COND (SOURCEFILES  
	     (AND UNFASLCOMMENTS 
		  (NOTE-IN-UNFASL '|TOTAL = | FILOC '| WORDS|))		;Close UNFASL file
	     (COND ((NULL UNFASLNAM)) 					;If kill-flag permits, and
		   ('T (FASL-RENAMEF (CAR UFFIL) UNFASLNAM)
		       (AND (NULL UNFASLSIGNIF) 
			    (SETQ SOURCEFILES (PROBEF (CAR UFFIL)))
			    (FASL-DELETEF SOURCEFILES))
		       (SETQ UFFIL () ))))
	    ('T (FASL-DELETEF TARGETFILE)				;Kill FASL file, if 
		(COND ((AND UFFIL UNFASLNAM)				; wrong or INSIGNIF
		       (FASL-RENAMEF (CAR UFFIL) UNFASLNAM) 
		       (SETQ UFFIL () )))
		(MOBYSYMPOP MAINSYMPDL)
		(REMPROPL 'SYM CURRENTFNSYMS)))
      (AND #%(SAILP) 
	   (NOT UNFASLCOMMENTS)
	   (SETQ UNFASLNAM (PROBEF UNFASLNAM))
	   (DELETEF UNFASLNAM))
      (REMPROPL 'ENTRY ENTRYNAMES)					;Flush no-longer-needed props
      (REMPROPL 'ARGSINFO ENTRYNAMES)
      (REMPROPL 'ATOMINDEX ALLATOMS)
      (FILLARRAY 'BSAR '(()) )
      (FILLARRAY 'NUMBERTABLE '(()) )
      (SETQ SYMPDL (SETQ MAINSYMPDL (SETQ CURRENTFNSYMS () )))
      (SETQ USERATOMS-INTERN () ) 
      (SETQ ALLATOMS (SETQ ENTRYNAMES () )))


(DEFUN RENAMEVERNOP (MAINFILE SRC)
  (IF (OR (ATOM MAINFILE) (ATOM (CAR MAINFILE)))	;Normalize inputs as 
      (SETQ MAINFILE (NAMELIST MAINFILE)))		; namelists
  (IF (AND (OR (NULL (CDDDR MAINFILE)) (EQ (CADDDR MAINFILE) '*))
	    ;If the mainfile didn't already get supplied a version number
	    ; and if such a versioned file doesn't already forcibly exist 
	   (PROGN (IF (OR (ATOM SRC) (ATOM (CAR SRC)))
		      (SETQ SRC (NAMELIST SRC)))
		  (SETQ MAINFILE (MERGEF `((* *) * * ,(cadddr src)) MAINFILE))
		  (OR (NULL (PROBEF MAINFILE)) 
		      (ERRSET (DELETEF MAINFILE) () ))))
      MAINFILE))



(eval-when (eval compile)
(defsimplemac NULDEVP (x)
   `(AND (NOT (ATOM (CAR ,x))) (EQ (CAAR ,x) 'NUL)))
)

(DEFUN FASL-DELETEF (X)
    (IF (OR (NOT #%(ITSP)) (NOT #%(NULDEVP X))) (DELETEF X)))

(DEFUN FASL-RENAMEF (X Y)
   (AND (NOT #%(ITSP)) (NOT #%(DEC20P)) (PROBEF Y) (FASL-DELETEF Y))
   (IF (OR (NOT #%(ITSP)) 
	   (AND (NOT #%(NULDEVP X)) (NOT #%(NULDEVP Y))))
       (RENAMEF X Y)))



(DEFUN UNFASL-MSG (FILE)
 #%(LET ((^W 'T) (^R 'T) (TERPRI 'T) (OUTFILES UFFIL))
       (TERPRI)
       (PRINC '|'/(THIS IS THE UNFASL FOR |)		;BARF OUT HEADER
	(PRINT-LINEND FILE 'T)				; FOR UNFASL FILE
       (PRINC '|'(ASSEMBLED BY FASLAP //|)
	(PRINT-LINEND FASLVERNO () )))



(DEFUN NOTE-IN-UNFASL (MSG W FL)
   #%(LET ((^R 'T) (^W 'T) (TERPRI 'T) (OUTFILES UFFIL)
	   (BASE 10.) (*NOPOINT () )
	   (FUNAME (AND (NOT (ATOM W))
			(SYMBOLP (CADR W))
			(CADR W)))
	   TTN-FUN)
       (COND ((COND ((AND FUNAME 
			  (SETQ TTN-FUN (GET FUNAME 'TTYNOTES-FUNCTION)))
		      (IF (SETQ FUNAME (FUNCALL TTN-FUN FUNAME))
			  (SETQ W `(,(car w) ,funame ,.(cddr w)))))
		    ('T))
	         (TERPRI)				;TERPRI before comment
		 (PRINC '|	(COMMENT **FASL** |)
		 (PRINC MSG)
		 (AND W (PRINC '| |) (PRIN1 W))
		 (AND FL (PRINC FL))
		 (PRINC '|) |) ))
       (AND ^R (SETQ UNFASLSIGNIF ^R))))


  


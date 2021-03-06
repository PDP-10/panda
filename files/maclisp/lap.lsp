;;;   -*-LISP-*-
;;;   **************************************************************
;;;   ***** MACLISP ****** LISP IN-CORE ASSEMBLER (LAP) ************
;;;   **************************************************************
;;;   ** (C) COPYRIGHT 1981 MASSACHUSETTS INSTITUTE OF TECHNOLOGY **
;;;   ****** THIS IS A READ-ONLY FILE! (ALL WRITES RESERVED) *******
;;;   **************************************************************



(HERALD LAP /110)

(DECLARE (SPECIAL LOC ORGIN AMBIG UNDEF RMSYM TTSR/| POPSYM/| 
	  SIDEV CNST/| /|GWD LAPEVAL-Q/|)
	 (*EXPR GETMIDASOP POPSYM/| /|GWD /|RPATCH LAPEVAL-Q/|)
	 (*FEXPR LAP)
	 (GENPREFIX |/|Lap|)
	 (MAPEX T)
	 (FIXNUM (LAPEVAL) (1WD/| NIL FIXNUM) (SQOZ/|)
		 (SPAGETTI/| FIXNUM) II NN WRD MM)
	 (NOTYPE (ADDRHAK/| FIXNUM FIXNUM) (/|RPATCH FIXNUM)))


(DEFUN CK@ MACRO (X)
   '(AND (EQ (CAR X) '@) 
	 (PROG2 (SETQ WRD (BOOLE 7 WRD 1_22.))
		(AND (NULL (SETQ X (CDR X))) (GO B)))))



;CURRENTLY /|GWD HOLDS FIELD NUMBER OF THE FIELD THAT LAPEVAL IS 
;WORKING ON. 3 FOR OP, 2 FOR AC, 1 FOR ADR, 0 FOR INDEX
;TTSR/| HOLDS LOC OF CONSTANTS LIKE [1,,1], [2,,2] ETC.

(DEFUN LAPEVAL (X)
  (COND ((ATOM X)
	 (COND	((NOT (SYMBOLP X)) X)
		((EQ X '*) (+ ORGIN LOC))
		((GET X 'SYM))
		((NULL X)  0) 
		((SETQ SIDEV (COND ((GET X 'UNDEF) () )
				   ((AND (= /|GWD 3) (GETMIDASOP X)))
				   ((GETDDTSYM X))))
		 (PUTPROP X SIDEV 'SYM))
		('T (AND (NOT (MEMQ X UNDEF)) (PUSH X UNDEF))
		    (PUTPROP X (CONS (CONS LOC /|GWD) (GET X 'UNDEF)) 'UNDEF)
		    0)))
	((MEMQ (CAR X) '(QUOTE FUNCTION)) (LAPEVAL-Q/| (CADR X)))
	((EQ (CAR X) 'SPECIAL)
	 (GCPROTECT (CADR X) 'VALUE)			;MAKUNBOUND WILL 
	 (VALUE-CELL-LOCATION (COND ((BOUNDP (CADR X)) (CADR X))
				      ;RECLAIM VALUE CELLS UNLESS PROTECTED
				    (T (MAKUNBOUND (CADR X))))))
	((EQ (CAR X) '%)
	  (COND ((AND (SIGNP E (CAR (SETQ SIDEV (CDR X)))) 
		      (SETQ SIDEV (CDR SIDEV))		;FAILURE HERE INDICATES (% 0)
		      (SIGNP E (CAR SIDEV))
		      (CDR SIDEV))
		 ((LAMBDA (VAL TYPE)
			(COND ((AND (EQ TYPE 'FIXNUM)
				    (< VAL 16.)
				    (FIXP (CADR SIDEV))
				    (= VAL (CADR SIDEV))) 
				(+ VAL TTSR/|))
			      ((AND (EQ TYPE 'LIST)
				    (EQ (CAR VAL) 'QUOTE) 
				    (EQ (CADR VAL) 'NIL))
			        TTSR/|)
			      ((EQ VAL 'FIX1) (- TTSR/| 2))
			      ((EQ VAL 'FLOAT1) (1- TTSR/|))
			      ((SETQ CNST/| (CONS (CONS (CDR X) LOC) CNST/|)) 0)))
		  (CAR (SETQ SIDEV (CDR  SIDEV)))
		  (TYPEP (CAR SIDEV))))
		((NULL SIDEV) TTSR/|)				;CASE OF (% 0)
		((SETQ CNST/| (CONS (CONS (CDR X) LOC) CNST/|)) 0)))
	((EQ (CAR X) 'ARRAY) (TTSR/| (CADR X)))
	((MEMQ (CAR X) '(ASCII SIXBIT)) (1WD/| (CADR X) 1 (CAR X)))
	((EQ (CAR X) 'SQUOZE) (SQOZ/| (CADR X)))
	((EQ (CAR X) 'EVAL) (LAPEVAL-Q/| (EVAL (CADR X))))
	((MEMQ (CAR X) '(- +)) (APPLY (CAR X) (MAPCAR 'LAPEVAL (CDR X))))
	((+ (LAPEVAL (CAR X)) (LAPEVAL (CDR X))))))

(DEFUN LAPEVAL-Q/| (X)
 (MAKNUM  (COND (GCPROTECT (PUSH X LAPEVAL-Q/|) (CAR LAPEVAL-Q/|))
		((AND PURE *PURE)
		 (COND ((GCPROTECT X '?))	;PROBE, RETURN NIL IF NOT THERE
		       ((GCPROTECT (PURCOPY X) T))))
		((GCPROTECT X T)))))		;PROBE, AND ENTER IF NOT THERE

(DEFUN 1WD/| (X NN ASCIIP)
    (DECLARE (FIXNUM I N))
    (DO ((I (COND ((SETQ ASCIIP (COND ((EQ ASCIIP 'ASCII) 'T) 
				      ('T () )))
		   (SETQ NN (1+ (* NN 5)))  5)
		  ((SETQ NN (1+ (* NN 6)))  6))
	    (1- I))
	 (N 0)
	 (II 0))
	((ZEROP I) (COND (ASCIIP (LSH N 1)) ('T N)))
     (SETQ II (GETCHARN X (- NN I)))
     (AND (ZEROP II) (RETURN (LSH N (COND (ASCIIP (1+ (* 7 I))) (T (* 6 I))))))
     (SETQ N (COND (ASCIIP (+ II (LSH N 7)))
		   (T 	(AND (LESSP 96. II 123.) (SETQ II (- II 32.)))
			(+ (BOOLE 1 (- II 32.) 63.) (LSH N 6)))))))

(DEFUN SPAGETTI/| (NN)
	(SETQ NN (+ LOC NN))
	(AND (NOT (< (+ BPORG NN) BPEND)) 
	     (NULL (GETSP (+ NN 8))) 
	     ((LAMBDA (ERRSET) (ERROR NIL 'NO-CORE? 'FAIL-ACT)) '/|LAP-NIL))
	NN)

(DEFUN /|GWD (X)
    (PROG (WRD NN) 
	  (COND ((EQ (CAR X) 'SQUOZE) (SETQ WRD (SQOZ/| (CDR X))))
		((EQ (CAR X) 'BLOCK)
		 (SETQ NN (LAPEVAL (CADR X))) 
		 (SETQ LOC (SPAGETTI/| NN))
		 (DO II (- LOC NN) (1+ II) (= II LOC) (DEPOSIT (+ ORGIN II) 0))
		 (RETURN NIL))
		((COND ((EQ (CAR X) 'ASCII) (SETQ NN 5) T)
		       ((EQ (CAR X) 'SIXBIT) (SETQ NN 6) T))
		 (SETQ NN (// (+ (FLATC (CADR X)) NN -1) NN))
		 (SETQ LOC (SPAGETTI/| NN))
		 (DO ((II 1 (1+ II)) (MM (- (+ ORGIN LOC) NN 1))) 
		     ((> II NN))
		   (DEPOSIT (+ MM II) (1WD/| (CADR X) II (CAR X))))
		 (RETURN NIL))
		(T (SETQ /|GWD 3 WRD (LAPEVAL (CAR X)))
		   (COND ((SETQ X (CDR X))
			  (CK@)
			  (SETQ /|GWD 2 NN (LAPEVAL (CAR X)))
			  (SETQ WRD (+ WRD (LSH (BOOLE 1 NN 15.) 23.)))
			  (COND ((SETQ X (CDR X))
				 (CK@)
				 (SETQ /|GWD 1 NN (LAPEVAL (CAR X)))
				 (SETQ WRD (BOOLE 7 (BOOLE 1 WRD -1_18.)
						    (BOOLE 1 (+ WRD NN) 262143.)))
				 (COND ((SETQ X (CDR X))
					(CK@)
					(SETQ /|GWD 0 NN (LAPEVAL (CAR X)))
					(SETQ WRD (+ WRD (ROT NN 18.)))))))))))
      B   (DEPOSIT (+ ORGIN LOC) WRD)
	  (SETQ LOC (SPAGETTI/| 1))
 	  (RETURN (AND (LESSP 11. (SETQ WRD (LSH WRD -27.)) 20.)	;Returns T iff opcode 
		       (ZEROP (BOOLE 1 WRD 2))))))			; is smashable CALL type

 

(DEFUN LAP FEXPR (TAG) (LAP-IT-UP TAG NIL))
(DEFUN LAP-A-LIST (LLL) (AND LLL (LAP-IT-UP (CDAR LLL) LLL)))

(DEFUN LAP-IT-UP (TAG LLL)
 ((LAMBDA (BASE IBASE)
  (PROG (LOC ORGIN SIDEV AMBIG UNDEF RMSYM /|GWD POPSYM/| NORET TEM 
	 DDT DDTP DSYMSONLY WINP ENTRYPTS SL SYFLG SMBLS LL 
	 CNST/|)
	(SETQ NORET T LOC 0)
	(GETMIDASOP NIL)	;LET GETMIDASOP BE AUTOLOADED IN IF NECESSARY
	(COND (PURE (AND (NOT (NUMBERP PURE)) (SETQ PURE 1))
		    (LAPSETUP/| 'T PURE)))
	(SETQ ORGIN BPORG DDTP (SETQ SYFLG SYMBOLS))
	(AND (NULL TAG) (RETURN () ))
	(SETQ ENTRYPTS (LIST (LIST (CAR TAG) ORGIN NIL (CADR TAG))))
		 ;( . (FUN 125 (() . 3) SUBR) . )
	(ERRSET 
	  (PROG ()  
	   A	(COND (LL (SETQ SL (CAR LL)) 
			  (POP LL)
			  (COND ((NULL SL)
				 (POPSYM/| (CAR LL) (CADR LL))
				 (SETQ LL (CDDR  LL))
				 (GO A)))) 
		      (LLL (POP LLL) 
			   (AND (NULL (SETQ SL (CAR LLL)))
				(SETQ LLL T)
				(GO END)))
		      (T (AND (NULL (SETQ SL (READ () ))) (GO END))))
		(COND  	((ATOM SL) 
			 (COND ((EQ (TYPEP SL) 'SYMBOL)
				(DEFSYM SL (+ ORGIN LOC))
				(COND (SYFLG (PUSH (CONS SL LOC) SMBLS))))))
			((EQ (CAR SL) 'ARGS)
			 (AND (SETQ TEM (ASSQ (CADR SL) ENTRYPTS))
			      (RPLACA (CDDR TEM) (CADDR SL))))
			((EQ (CAR SL) 'ENTRY)
			 (PUSH (LIST (CADR SL) 
				     (+ LOC ORGIN)
				     ()  
				     (COND ((CADDR SL)) ((CADR TAG))))
				ENTRYPTS))
			((EQ (CAR SL) 'DEFSYM) (DEFLST/| (CDR SL)))
			((EQ (CAR SL) 'BEGIN) 
			 (SETQ TEM (EVAL (CADR SL)))
			 (SETQ LL (APPEND (EVAL (CADDR SL)) 		;BLOCK BODY
					  '(() )
					  (LIST TEM 
					        (MAPCAR 
						 '(LAMBDA (X) 
						   (AND (SETQ X (REMPROP X 'SYM))
							(CADR X)))
						 TEM)) 
					  LL))
			 (GO A))
			((EQ (CAR SL) 'DDTSYMS) (SETQ DSYMSONLY (APPEND (CDR SL) DSYMSONLY)))
			((EQ (CAR SL) 'SYMBOLS) 
			 (SETQ SYFLG (CADR SL))
			 (SETQ DDTP T))
			((EQ (CAR SL) 'EVAL)
			 (MAPC (FUNCTION EVAL) (CDR SL)))
			((EQ (CAR SL) 'COMMENT))
			(T (AND (/|GWD SL)
				PURE 
				(LAPSETUP/| (MUNKAM (+ ORGIN LOC -1)) PURE))))
		(GO A)
	   END  (SETQ WINP 'UNDEF)
		 ;INDICATES THAT THE CLOSING NIL HAS BEEN READ
		(MAPC '(LAMBDA (X) (/|RPATCH LOC (CDR X) () )
			           (/|GWD (CAR X)) () )
		      (NREVERSE (PROG2 () CNST/| (SETQ CNST/| () )))) 
		(AND CNST/| (GO END))
	   END1	(COND (UNDEF 
			  (SETQ UNDEF 
				(MAPCAN 
				 '(LAMBDA (X)
				    (COND ((SETQ SIDEV (GETDDTSYM X))
					   (PUSH X DDT)
					   (DEFSYM X SIDEV)
					   () )
					  ((AND (EQ WINP 'SYM) (SETQ SIDEV (GET X 'SYM)))
					   (DEFSYM X SIDEV)
					   () )
					  (T (LIST X))))
				 (PROG2 () UNDEF (SETQ UNDEF () ))))
			  (COND ((AND DDT (STATUS NOFEATURE NOLDMSG))
				 (PRINC '|Symbols obtained from DDT: |) (PRINT DDT)))
			  (AND (EQ WINP 'SYM) (GO END2))))
		(COND ((OR SMBLS DSYMSONLY)
			(AND DSYMSONLY 
			     (SETQ SMBLS (NCONC (MAPCAN '(LAMBDA (X) 
							   (AND (SETQ X (CONS X (GET X 'SYM)))
								(CDR X)
								(LIST X)))
							DSYMSONLY)
						SMBLS)))
			(MAPC '(LAMBDA (X) (AND (OR (NULL DSYMSONLY) (MEMQ (CAR X) DSYMSONLY))
					   (PUTDDTSYM (CAR X) (+ (CDR X) ORGIN))))
			      SMBLS)))
		(COND ((COND (DSYMSONLY (MEMQ (CAR ENTRYPTS) DSYMSONLY))
			     (DDTP))
			  (MAPC (FUNCTION PUTDDTSYM) 
				(MAPCAR (FUNCTION CAR) ENTRYPTS) 
				(MAPCAR (FUNCTION CADR) ENTRYPTS))))
		(SETQ ENTRYPTS (MAPCAR 'SET-ENTRY/| ENTRYPTS))
		(COND ((AND UNDEF (EQ WINP 'UNDEF))
			(OR ((LAMBDA (ERRSET)
				     (ERRSET (ERROR 'UNDEFINED/ SYMBOLS/ -/ LAP 
						    (LIST 'GETDDTSYM UNDEF)
						    'FAIL-ACT)
					      () ))
				 '/|LAP-NIL)
			    (RETURN () ))
			(SETQ WINP 'SYM)
			(GO END1)))
	   END2	(AND (NULL UNDEF) (SETQ WINP T))))
	(LREMPROP/| RMSYM 'SYM)
	(COND (UNDEF (COND (WINP (PRINC 'UNDEFINED/ SYMBOLS:/ ) (PRINT UNDEF)))
		     (LREMPROP/| UNDEF 'UNDEF)))
	(COND (AMBIG (PRINC 'MULTIPLY-DEFINED/ SYMBOLS:/ ) (PRINT AMBIG) 
		     (POPSYM/| POPSYM/| () )))
	(COND	((NOT (EQ WINP T))
		 (COND ((AND ^Q (NULL WINP) (NULL LLL))
			(DO () ((NULL (READ () ))))))
		 (PRINC (CAR TAG)) (PRINC 'ABORTED/ AFTER/ ) 
		 (PRINC LOC) (PRINC '/ WORDS/)
		 (GCTWA)
		 (RETURN () ))
		('T (SETQ BPORG (+ ORGIN LOC))))
	(GCTWA)
	(RETURN (CONS BPORG ENTRYPTS))))
   8. 8.))



(DEFUN LREMPROP/| (L PROP) (MAPC '(LAMBDA (X) (REMPROP X PROP)) L) NIL)

(DEFUN DEFSYM (SYM VAL)
  (PROG (SL)
	(COND  ((SETQ SL (GET SYM 'UNDEF))
		(/|RPATCH VAL SL T)
		(REMPROP SYM 'UNDEF)
		(SETQ UNDEF (DELQ SYM UNDEF 1)))
	       ((SETQ SL (GET SYM 'SYM)) 
		(COND ((= SL VAL) (RETURN () ))
		      ((NOT (MEMQ SYM AMBIG))
			(SETQ AMBIG (CONS SYM AMBIG))
			(PUSH (CONS SYM SL) POPSYM/|)))))
	(PUSH SYM RMSYM)
	(PUTPROP SYM VAL 'SYM)))

(DEFUN DEFLST/| (L) (DO L L (CDDR L) (NULL L) (DEFSYM (CAR L) (EVAL (CADR L)))))
(DEFUN POPSYM/| (L Y)
    (PROG (SYM VAL)
	A (COND ((NULL L) (RETURN () ))
		((NULL Y) (SETQ SYM (CAAR L) VAL (CDAR L)))
		(T (SETQ SYM (CAR L) VAL (CAR Y)) (POP Y)))
	  (POP L)
	  (COND (VAL (PUTPROP SYM VAL 'SYM))
		((REMPROP SYM 'SYM)))
	  (GO A)))

(DEFUN ADDRHAK/| (ADDR VAL)
    (PROG (II NN)
	(SETQ NN (EXAMINE (SETQ II (+ ORGIN ADDR))))
	(DEPOSIT II (BOOLE 7 (BOOLE 4 NN 262143.) 
			     (BOOLE 1 (+ VAL NN) 262143.)))))


(DEFUN /|RPATCH (VAL L FL)
    (DECLARE (FIXNUM VAL))
    (COND ((NULL FL) (ADDRHAK/| L (+ ORGIN VAL)))
	  ((DO ((Y L (CDR Y)) (II 0) (NN 0))  ((NULL Y))
	    (COND ((= (CDAR Y) 1) (ADDRHAK/| (CAAR Y) VAL))
		  (T (SETQ II (+ ORGIN (CAAR Y)))
		     (SETQ NN (COND ((= (CDAR Y) 2) (LSH VAL 23.))
				    ((= (CDAR Y) 0) (ROT VAL 18.))
				    (T VAL)))
		    (DEPOSIT II (+ (EXAMINE II) NN))))))))

 

(DEFUN SET-ENTRY/| (X)
  ((LAMBDA (SL SYFLG) 
	(COND ((AND SL FASLOAD)
		(TERPRI)
		(PRINC 'CAUTION/!/ / )
		(PRINC (CAR X))
		(COND ((SYSP (CAR X)) 
		       (PRINC '/,/ A/ SYSTEM/ ))
		      ((PRINC '/,/ A/ USER/ )))
		(PRINC (CAR SL))
		(PRINC '/,/ IS/ BEING/ REDEFINED)
		(TERPRI)
		(DO () ((NULL (REMPROP (CAR X) SYFLG))))))
	(AND (MEMQ SYFLG '(SUBR FSUBR LSUBR)) (ARGS (CAR X) (CADDR X)))
	(PUTPROP (CAR X) (MUNKAM (CADR X)) SYFLG)
	(AND PURE PURCLOBRL 
	     (DO ((Y PURCLOBRL (CDR Y)) (BY (SETQ SL (CONS () PURCLOBRL))))
		 ((NULL Y) (SETQ PURCLOBRL (CDR SL)))
	       (COND ((AND (EQ (MUNKAM (EXAMINE (MAKNUM (CAR Y)))) (CAR X)) 
			   (NULL (LAPSETUP/| (CAR Y) PURE)))
		      (RPLACD BY (CDR Y)))
		     (T (SETQ BY (CDR BY))))))
	(LIST (CAR X) SYFLG (CADR X)))
   (GETL (CAR X) '(SUBR FSUBR LSUBR))
   (CADDDR X)))


(DEFUN /|LAP-NIL (X) NIL)  ;FAKE NO-OP FOR BINDING TO "ERRSET"


(DEFUN REMLAP FEXPR (L) (ERROR '|REMLAP NO LONGER EXISTS| () 'FAIL-ACT))


;;; INITIALIZATION FOR LAP

	(LAPSETUP/| () PURE)
	(DO ((ORGIN 1 (1+ ORGIN))
	     (UNDEF '(A B C AR1 AR2A T TT D R F P  P FLP FXP SP) (CDR UNDEF)))
	    ((NULL UNDEF))
	  (PUTPROP (CAR UNDEF) ORGIN 'SYM))

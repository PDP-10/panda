;;;   COMAUX  						  -*-LISP-*-
;;;   **************************************************************
;;;   ***** MACLISP ***** LISP COMPILER (Auxilliary funs) **********
;;;   **************************************************************
;;;   ** (C) Copyright 1981 Massachusetts Institute of Technology **
;;;   ****** This is a Read-Only file! (All writes reserved) *******
;;;   **************************************************************

(SETQ COMAUXVERNO '#.(let* ((file (caddr (truename infile)))
			   (x (readlist (exploden file))))
			  (setq |verno| (cond ((fixp x) file)  ('/25)))))

(EVAL-WHEN (COMPILE) 
     (AND (OR (NOT (GET 'COMPDECLARE 'MACRO))
	      (NOT (GET 'OUTFS 'MACRO)))
	  (LOAD `(,(cond ((status feature ITS) '(DSK COMLAP))
			 ('(LISP)))
		  CDMACS
		  FASL)))
)


(EVAL-WHEN (COMPILE) (COMPDECLARE) (GENPREFIX |/|ax-|))

(COMMENT AUXILIARY FUNCTIONS - alphabetical order)


(DEFUN 1FREE () (NOT (DVP1 REGACS 1)))

(DEFUN 1INSP (VAR)
    (COND (#%(NUMACP-N ARGNO))		;Tries to figure out if a variable is LOADAC-able
	  (((LAMBDA (MODE)		; in only one instruction;  rets CLPROGN if on NUMPDL
		    (COND ((NULL MODE) (OR CONDPNOB (NOT (MEMQ VAR UNSFLST))))
			  ((NULL CONDPNOB) () )
			  ((CLMEMBER VAR () #%(PDLGET MODE) 'EQ) CLPROGN)))
	       (VARMODE VAR)))))

(DEFUN 6BSTR (X)
     (AND (NOT (SYMBOLP X)) (SETQ X (MAKNAM (EXPLODEN X))))
     (DO ((I 1 (1+ I)) (N 0) (ZZ () (CONS N ZZ)))
	 ((ZEROP (SETQ N (GETCHARN X I))) (MAKNAM (NRECONC ZZ '(/!))))
	(COND ((OR (= N 35.) (= N 94.) (= N 33.)) (SETQ ZZ (CONS '/# ZZ)))	;CHECK FOR # ^ !
	      ((LESSP 31. N 96.))						;VALID SIXBIT
	      ('T (SETQ ZZ (CONS '/^ ZZ))					;ELSE CONTROLIFY
		  (AND (= N 13.) (= (GETCHARN X (1+ I)) 10.) (SETQ I (1+ I)))
		  (SETQ N (BOOLE 6 N 64.))))))


(DEFUN ACSMRGL (X) (ACMRG REGACS NUMACS ACSMODE (CAR X) (CADR X) (CADDR X) () ))
(DEFUN ACMRG (LL ZZ MM L Z M F)		  ;Merge ACCs off L onto LL if F = (),
	      (DO ((LL LL (CDR LL))	  ; set LL from L if F = T
		  (L L (CDR L))
		  (N #%(NACS) (SUB1 N)))
		 ((ZEROP N))
		    (COND (F (RPLACA LL (CAR L)))
			  ((NULL (CAR LL)))
			  ((NOT (EQUAL (CAR LL) (CAR L))) (RPLACA LL () ))))
	      (DO ((A1 MM (CDR A1))
		   (A2 M (CDR A2))
		   (N #%(NUMNACS) (SUB1 N))
		   (LL ZZ (CDR LL))
		   (L Z (CDR L)))
		  ((ZEROP N))
		(COND (F (RPLACA LL (CAR L)) (RPLACA A1 (CAR A2)))
		      ((NULL (CAR LL)))
		      ((NOT (EQUAL (CAR LL) (CAR L)))
		       (RPLACA LL () )
		       (RPLACA A1 () )))))

(DEFUN ADD (X Y) (COND ((MEMQ X Y) Y) ('T (CONS X Y))))

(DEFUN ADR (X)
    (CDR  (COND ((NULL X) '(() . () ))
		((ASSQ X GL))
		('T '(() . () )))))

(DEFUN ASQSLT (X) (OR (ASSQ X REGACS) (ASSQ X REGPDL) (ASSQ X NUMACS)
		       (ASSQ X FXPDL) (ASSQ X FLPDL)))

(DEFUN MEMASSQR (X Y)
    (DO Y Y (CDR Y) (NULL Y) (COND ((EQ X (CDAR Y)) (RETURN Y)))))


(DEFUN BADTAGP (TAG)
   ((LAMBDA (TEM)
	(OR (NOT (EQ (L/.LE/. REGPDL (CAR TEM)) 'EQUAL))
		 (NOT (EQ (L/.LE/. FXPDL (CADR TEM)) 'EQUAL))
		 (NOT (EQ (L/.LE/. FLPDL (CADDR TEM)) 'EQUAL))))
      (CDDDR (LEVEL TAG))))

 
(DEFUN BOOLOUT (TAG FL)
    (COND ((NOT (LESSP 0 ARGNO #%(NUMVALAC)))
	   (WARN () |Predicate in numerical argument position|)
	   (OUTPUT (SUBST ARGNO 'ARGNO '(MOVEI ARGNO 0))))
	  (((LAMBDA (TEM)
		    (OUTPUT TEM)
		    (AND TAG 
			 (COND (FL (AND (OUTTAG TAG)
					(NOT (EQ LOUT1 TEM))
					(BARF TAG |Lost in BOOLOUT|)))
			       ('T (OUTPUT TAG))))
		    (OUTPUT (BOLA ARGNO 2))
		    (|Oh, FOO!|))
	      (BOLA ARGNO 1) ))))


(COMMENT BOOL1 BOOL2 and BOOL3)

(DEFUN BOOL1 (EXP TAG F)				;Compile general boolean form, JRST to TAG when
   (PROG (PROP)						; result matches F, otherwise drop through
	 (SETQ PROP (AND (SYMBOLP (CAR EXP))		;Return non-null only when 

			 (GET (CAR EXP) 'P1BOOL1ABLE)))	;unconditional JRST taken
     A	 (COND ((EQ PROP 'T)
		(COND  ((COND  ((EQ (CAR EXP) 'AND) 
				(BOOL2 (CDR EXP) TAG F 'T) 
				'T)
			       ((EQ (CAR EXP) 'OR) 
				(BOOL2 (CDR EXP) TAG (NOT F) () )
				'T))
			(SETQ CNT (PLUS CNT 2)))
		       ((EQ (CAR EXP) 'NULL) (RETURN (BOOL1 (CADR EXP) TAG (NOT F))))
		       ((EQ (CAR EXP) 'COND) (COMCOND (CDR EXP) TAG F () )) 
		       ((EQ (CAR EXP) 'EQ) (COMEQ (CDR EXP) TAG F))
		       ((EQ (CAR EXP) 'MEMQ)
			(AND F (RETURN (BOOL3 EXP 'T TAG F)))		;CLOSE-CALL, AND JUMPN
			#%(LET (X Y LX (ARGNO 1) (A1 0) (A2 0) EFFS (OEFFS EFFS))
			      (DECLARE (FIXNUM A1 A2))
			      (SETQ X (COMP0 (CADR EXP)) Y (COMP0 (CADDR EXP)))
			      (SETQ EFFS OEFFS)
			      (SETQ LX #%(ILOCF X))
			      (SETQ A1 (LOADINREGAC Y () () ))
			      (CLEARVARS)
			      (CONT A1 '(NIL . TAKEN))
			      (CONT (SETQ A2 #%(FREACB)) () )
			      (OUTJ0 'JUMPE A1 TAG () A2)
			      (AND (NOT (REGADP LX)) 
				   (DBARF EXP |Numeric 1st arg to MEMQ?| 4 6))
			      (AND (NUMBERP LX) 
				   (NOT (EQUAL X (CONTENTS LX)))
				   (SETQ LX (ILOC0 X () ))) 
			      (REMOVEB X)
			      (OUT1 '(HLRZ) A2 A1)
			      (OUT1 '(HRRZ) A1 A1)
			      (OUT1 'CAME A2 LX)
			      (OUTPUT '(JUMPA 0 (* -4)))
			      (CONT A1 () )
			      A1))
		       ((EQ (CAR EXP) 'SIGNP) (COMSIGNP (CDR EXP) TAG F))
		       ((BARF () |Lost dispatch in BOOL1|))))
	       ((NULL PROP)
		(COND  ((AND (EQ (CAR EXP) 'PROG2) (NULL (CDDDR EXP)))
			(COMPE (CADR EXP))
			(RST TAG)
			(RETURN (BOOL1 (CADDR EXP) TAG F)))
		       ((RETURN (BOOL3 EXP 'T TAG F)))))
	       ((EQ PROP 'NUMBERP)
		(COND ((COND (CLOSED (NOT (MEMQ (CADR EXP) '(FIXNUM FLONUM))))
			     ('T (NOT #%(KNOW-ALL-TYPES (CADR EXP)))))
		       (RETURN (BOOL3 EXP 'T TAG F)))
		      ((MEMQ (CAR EXP) '(GREATERP LESSP)) (COMGRTLSP EXP TAG F))
		      ((EQ (CAR EXP) 'EQUAL) (COMEQ (CDR EXP) TAG F))
		      ((MEMQ (CAR EXP) '(ZEROP PLUSP MINUSP ODDP)) (COMZP EXP TAG F))
		      ((BARF EXP |Is this really P1BOOL1ABLE?|))))
	       ((NOT (ATOM PROP)) (COMTP EXP PROP TAG F () ))
	       ('T (SETQ PROP 'NUMBERP) (GO A)))))


(DEFUN BOOL1LCK (EXP TAG F)
    #%(LET ((T1  (BADTAGP TAG)))
	  (COND (T1 (BOOL1 EXP (SETQ T1 (LEVELTAG)) (NOT F))
		    (OJRST TAG () )
		    (SLOTLISTSET (LEVEL T1))
		    (OUTTAG0 T1))
		('T (BOOL1 EXP TAG F)))))

(DEFUN BOOL2 (EXP TAG F ANDFL)						;Compile AND or OR
    (COND (F (COND ((CDR (SETQ EXP (L2F (CDDDDR EXP))))
		    (BOOL2LOOP (CDR EXP) (SETQ F (LEVELTAG)) (NOT ANDFL)))
		   ('T (SETQ F () )))
	     (BOOL1 (CAR EXP) TAG ANDFL)
	     (OUTTAG F))
	 ('T (BOOL2LOOP (CDDDDR EXP) TAG (NOT ANDFL)))))

(DEFUN BOOL2LOOP (EXP BTAG B2F) (MAPC '(LAMBDA (EXP) (BOOL1 EXP BTAG B2F)) EXP))

(DEFUN BOOL3 (EXP FLAG TAG F)
	(PROG (Z LARG LARGSLOTP FL MODE) 
	      (SETQ Z (COND (FLAG (COMPR EXP () 'T 'T)) (EXP)))
	      (SETQ LARG #%(ILOCF Z))
	      (SETQ LARGSLOTP (NUMBERP LARG))
	      (AND LARGSLOTP (SETQ MODE (GETMODE LARG)))
	      (COND ((AND (NOT LARGSLOTP) 
			  (EQ (CAAR LARG) 'QUOTE)
			  (OR (ATOM (CADAR LARG))
			      (NOT (EQ (CAADAR LARG) SQUID))))
		     (REMOVE Z)
		     (COND (#%(EQUIV (CADAR LARG) F)
			    (CLEARVARS)
			    (OJRST TAG () )
			    (RETURN 'T))
			   ('T (RETURN () )))))
	      (COND ((NOT (REGADP LARG)) (REMOVE Z) (CLEARVARS)
		     (RETURN (COND (F (OJRST TAG () ) 'T)))))
	      (SETQ FL (RST TAG))
	      (REMOVE Z)
	      (AND (OR (CLEARVARS) FL)
		   LARGSLOTP 
		   (NOT (PLUSP LARG))
		   (SETQ LARG (ILOC0 Z MODE)))  
	      (OUTJ0 (COND (F 'JUMPN) ('JUMPE)) LARG TAG () LARG)
	      (RETURN () )))


(COMMENT CARCDR)

(DEFUN CARCDR (ITEM ACORFUN) 					;Computes a CARCDR
  (PROG (AC T1 2LONG T2 LT2 ACP N MATCHP TEM FL)		;Compilation - returns SLOTLIST 
	(SETQ ACP (NUMBERP ACORFUN)) 				; number of resultant 
	(SETQ LT2 #%(ILOCREG (SETQ T2 (CDDR ITEM))		;Typical item is (G0025 (D A D D) X . 5) 
			    (COND ((AND ACP 			; for (CDDADR X)  
					(SETQ N ACORFUN) 	;If item is (G0025 
					#%(REGACP-N N))		; (CARCDR-FREEZE A D A D . . .) X . 5),  
				   ACORFUN)			; then no VL crossings may link to it
				  ((FRAC)))))
	(REMOVE T2)
	(SETQ N 0 T1 (CADR ITEM))
	(AND (EQ (CAR T1) 'CARCDR-FREEZE) (SETQ T1 (CDR T1)))
	(COND ((AND (ATOM (CAR T2))
		    (VARBP (CAR T2))
		    (DO ((ZZ SPLDLST (CDR ZZ)) (2LONG-SETP))		;Look for (GN (A . .) X.5)
			((NULL ZZ) MATCHP)
		       (AND (CAR ZZ)
			    (NOT (EQ ITEM (CAR ZZ)))
			    (NOT (ATOM (CDAR ZZ)))			; found (GM . .)
			    (EQ (CADDAR ZZ) (CAR T2))			; found (GM . . X.7)
			    (EQ (CAADAR ZZ) (CAR T1))			; found (GM (A . .) X.7)
			    (COND (2LONG-SETP)				;Setup the variable 2LONG
				  (ACP (SETQ 2LONG #%(NUMACP ACORFUN)
					     2LONG-SETP 'T))
				  ((SETQ 2LONG (COND ((EQ ACORFUN 'FREENUMAC)) 
						     ((EQ ACORFUN 'ARGNO)
						      #%(NUMACP-N ARGNO)))
					 2LONG-SETP 'T)))
			    (COND (2LONG (ASQSLT (CAAR ZZ)))		;2LONG is switch to tell
				  ((ASSQ (CAAR ZZ) REGACS))		; whether or not to look
				  ((ASSQ (CAAR ZZ) REGPDL)))		; everywhere for possibilities
			    (EQUAL (ILOC0 (CDDAR ZZ) () ) LT2) 		;X.5 can be used for X.7
			    (PROG (L LL)
				(SETQ L T1)				;T1- open string of ITEM
				(SETQ LL (CADAR ZZ))			;LL - open string of candidate
				(AND (< (LENGTH LL) N) (RETURN () ))
			      A	(COND ((NOT (EQ (CAR L) (CAR LL))) (RETURN () ))
				      ((SETQ LL (CDR LL))
				       (COND ((SETQ L (CDR L)) (GO A))
				 	     ((RETURN () )))))
				;Candidate is an initial substring of ITEM
				(SETQ MATCHP (CAR ZZ) N (LENGTH (CADR MATCHP)))))))
		(COND ((EQUAL (CADR MATCHP) T1) 
			(PUSH (CONS (CAR MATCHP) (CAR ITEM)) VL) 
			(RETURN (ILOCMODE MATCHP () '(FIXNUM FLONUM))))
		      ('T (SETQ T2 (LIST (GENSYM))
				T1 #%(NCDR T1 N)
				LT2 (ILOCMODE MATCHP () '(FIXNUM FLONUM)))
			  (PUSH (CONS (CAR MATCHP) (CAR T2)) VL)))))
	(SETQ 2LONG (CDDDR T1))
	(SETQ AC (COND ((NOT ACP)
			(COND ((AND 2LONG (OR (EQUAL LT2 1) (1FREE)))
			       1)
			      ('T ((LAMBDA (LDLST LL)
					(COND (2LONG (CC0 (FRAC)))
					      ((EQ ACORFUN 'FRACF) (FRACF))
					      ((EQ ACORFUN 'FREENUMAC) (FREENUMAC))
					      ((EQ ACORFUN 'ARGNO)
						(COND ((AND (NOT EFFS) 
							    (= ARGNO 1) 
							    (PROG2 (SETQ LDLST LL)
								   (DVP1 REGACS 1)
								    (SETQ LDLST TEM)))
							(CC0 (FRAC)))
						      ((OR EFFS #%(NUMACP-N ARGNO)) (FRACF))
						      (ARGNO)))
					      ((BARF ACORFUN |? fun - CARCDR|))))
				    (SETQ TEM (CONS T2 LDLST)) LDLST))))
		       ((OR (NOT 2LONG) (= ACORFUN 1)) ACORFUN)
		       ((OR (EQUAL LT2 1) (1FREE)) 1)
		       ((AND (CDDR 2LONG) (NOT (ZEROP (SETQ N (FRAC))))) (CC0 N))
		       ('T ACORFUN)))
	(SETQ TEM (COND ((AND #%(PDLLOCP LT2) (NOT #%(NUMACP-N AC)))
			 ;LT2 must always be a REGADP.  Thus if it is a PLDLOCP, it is the REGPDL
			 ;    and if AC is a REGAC, then a CPUSH might change the REGPDL
			 (SETQ FL 'T)
			 (AND (NULL TEM) (SETQ TEM (CONS T2 LDLST)))
			 ((LAMBDA (LDLST) (CPUSH AC)) TEM))	;Ordinarily, a semipush would be needed
			('T (SETQ FL () ) (CPUSH AC))))		; but the LDLST prevents trouble here
;;;	Losing T2 may have moved around by CC0 or CPUSH
	(COND ((OR (NOT ACP) (AND TEM FL)) 
		(SETQ LT2 (ILOC0 T2 () ))))
	(SETQ FL () ACP #%(ACLOCP LT2) MATCHP () )
      B (COND ((AND ACP (= LT2 1) (= AC 1) (CDDR T1))
		;ACP now applies to LT2, which is place to start [or continue] CARCDRing from
		;T1 contains D-A list of directions, and this clause is taken if 3 or more.
		;FL=T => We have a private copy of current portion of T1
		(AND (NULL FL) (SETQ FL (SETQ T1 (APPEND T1 () ))))
		(COND ((CDDDDR T1)
			(AND (NOT MATCHP) (SETQ MATCHP 'T) (CLEARNUMACS))
			;If more than 4, then bite of a chunk of 4, feed TO CCOUT, and carry on
			(CCOUT (PROG2 () T1 (RPLACD (SETQ T1 (CDDDR T1)) 
						    (PROG2 (POP T1) () ))))
			(GO B))
		      ((CCOUT T1))))
	      ('T (AND (AND (NOT ATPL) (NOT ATPL1))
		       (EQ (CAR LOUT) 'MOVE)		;If LOUT = (MOVE AC 0 AC)
		       (MEMQ (CAR LOUT1) '(HRRZ HLRZ))
		       (NUMBERP (CADR LOUT))
		       (SIGNP E (CADDR LOUT))		; and LOUT1 had just loaded AC
		       (NUMBERP (CADDDR LOUT))
		       (= (CADR LOUT) AC)		; then flush LOUT
		       (= (CADDDR LOUT) AC)
		       (EQUAL (CADR LOUT1) AC)
		       (SETQ LOUT (SETQ ATPL 'FOO)))
		  (OUT1 (GET (CAR T1) 'INST) AC LT2)
		  (POP T1)
		  (COND (T1 (SETQ LT2 AC ACP 'T) (GO B)))))
      (CONT (SETQ N AC) (LIST (CAR ITEM)))
      (COND ((COND (#%(NUMACP-N AC)) 
		   ((EQ ACORFUN 'FREENUMAC) 
		    (SETQ TEM (CAR SLOTX) AC (FREENUMAC))
		    (RPLACA SLOTX TEM)				;Quick way of (CONT N (CONTENTS AC))
		    'T))
	      (SETMODE AC () )
	      (OUT1 '(MOVE) AC N)))
	(RETURN AC) ))



(DEFUN CCOUT (X)					;(D A D D) => (CALL 1 'CDDADR) 
    ((LAMBDA (FUN)
	     #%(OUTFS 'JSP 
		    'T 
		    (LIST 'CARCDR (CDDR (|carcdrp/|| FUN)))
		    0 
		    FUN))
	(IMPLODE (CONS 'C (NRECONC X '(R)))))) 

(DEFUN CC0 (AC)
;;;  Should be called only when (DVP (CONTENTS 1))    also, (FRAC) leaves SLOTX set
	     (COND ((ZEROP AC) (CPUSH1 1 () () ))
		   ((= AC 1))
		   ((CCSWITCH AC 1))			;If CCSWITCH is (), the SLOTX is undisturbed
		   ('T (RPLACA SLOTX (CAR REGACS))	;(CONT AC (CONTENTS 1))
		       (RPLACA REGACS 			;(CONT 1 (CONS (CAAR (CONTENTS 1)) 'DUP))
			       (CONS (CAAR REGACS) 'DUP))))
	     1)


(DEFUN CCSWITCH (A1 A2)		;A1 is always a REGAC address
	     (COND ((AND (NOT ATPL) 
			 (MEMQ (CAR LOUT) '(MOVE HRRZ HLRZ MOVEI)) 
			 (NUMBERP A2)
			 (NUMBERP (CADR LOUT))
			 (= (CADR LOUT) A2))
		    (OUTPUT (PROG2 ()
			           (CONS (CAR LOUT) (CONS A1 (CDDR LOUT)))
				   (SETQ LOUT (SETQ ATPL 'FOO))))
		    (SETQ A1 (FIND A1) A2 (FIND A2))		;This might move CARCDRs ITEM
		    (RPLACA A1 (CAR A2))			;(CONT A1 (CONTENTS A2))
		    (RPLACA A2 () )				;(CONT A2 () )
		    'T)
		   ('T (OUT1 'MOVE A1 A2) 
		       () )))

;;; If first arg is null, then freez-out all carcdr-ings that are still around
;;; If second arg is null, then freeze-out all carcdr-ings over the variable 
;;;   indicated by the first arg.

(DEFUN CARCDR-FREEZE (V ITEM)
  ((LAMBDA (FL)
    (MAP '(LAMBDA (LL) 
	    (COND ((NULL (CAR LL)) (SETQ FL () ))
		  ((OR (ATOM (CDAR LL)) 
		       (AND V (NOT (EQ (CADDAR LL) V)))))
		  ((OR (ASSQ (CAAR LL) LDLST) (DVP3 (CAAR LL) VL) (AND ITEM (EQ (CAAR LL) ITEM)))
		   (AND (NOT (EQ (CAADAR LL) 'CARCDR-FREEZE))		;Modify the SPLDLST so that
			(RPLACA LL (CONS (CAAR LL) 			;no VL crossings can use this
					 (CONS (CONS 'CARCDR-FREEZE (CADAR LL))
					       (CDDAR LL))))))
		  ('T (CLOBBER-SLOT (CAR LL) REGACS)
		      (CLOBBER-SLOT (CAR LL) REGPDL)
		      (RPLACA LL (SETQ FL () )))))			;Remove this loser from SPLDLST
	SPLDLST)
    (AND (NULL FL) (FLUSH-SPL-NILS)))
   'T))


(COMMENT CLEAR)

(DEFUN CLEAR (Y CLBFL)	;Clean up things possibly side-effected in a COND, PROG, LAMBDA, or LSUBR 
;	  	PROGN on Y ==> Unknown-function-application in form
;		NULFU on Y ==> RPLACA-D in form
;		GOFOO on Y ==> GO or RETURN in form
;		Variable X ==> (SETQ X FOO) in form
    (AND Y 
	 (PROG (L MODE Z PDL)
	       (SETQ L (MAPCAN 
			'(LAMBDA (X)
			  (COND ((OR (EQ X GOFOO) (EQ X NULFU) (EQ X PROGN) (SPECIALP X))
				 () )

				('T 
				  (SETQ MODE (VARMODE X) PDL #%(PDLGET MODE))
				  (COND ((AND MODE 
					      (COND ((SETQ L (CLMEMBER X () REGPDL 'EQ)) 
							(SETQ Z (- (LENGTH L) (LENGTH REGPDL)))
							'T)
						    ((SETQ L (CLMEMBER X () REGACS 'EQ))
							(SETQ Z (- (1+ #%(NACS)) (LENGTH L)))
							'T)))
;					 Dont let local numvars be homed in the regworld
					 (OPUSH Z (CAR L) MODE)
					 (RPLACA L (CONS X CNT))
					 (SETQ L PDL))
					('T (SETQ L (CLMEMBER X () PDL 'EQ))))
				  (COND ((OR (NULL L) (NULL (SETQ PDL (CLMEMBER X 'OHOME PDL 'EQ)))) 
					   () )
					('T (LIST (LIST X MODE L PDL)))))))
			 Y))
;		L is a list of losers that have both valid homes and ohomes on the PDL
	    A	(COND ((NULL L) (GO C))
		      ((OR (SETQ Z (CLCHK (SETQ PDL REGPDL) L)) 
			   (SETQ Z (CLCHK (SETQ PDL FXPDL) L))
			   (SETQ Z (CLCHK (SETQ PDL FLPDL) L)))
			(SETQ L (DELQ Z L) MODE (CADR Z))
			(RPLACA (CADDDR Z) (CAR PDL))
			(OPOP (CLLOC (CADDDR Z) MODE) MODE)
			(GO A)))
	    B	(COND ((SETQ MODE (CADAR L)) (SETQ Z (FREENUMAC)))
		      ('T (SETQ Z (FRAC5))))			    ;SLOTX left set by FREAC
		(SETQ PDL (CADDAR L))
		(OUT1 'MOVE Z (CLLOC PDL MODE))
		(RPLACA SLOTX (CAR PDL))
		(RPLACA PDL () )
		(CPUSH1 Z () () )				    ;SLOTX still set
		(POP L)
		(GO A)
	   C	(COND ((MEMQ GOFOO Y) (SETQ CLBFL 'T) (CPVRL))			;Make sure relevant PROG
		      ((AND PVRL (NULL LPRSL)) (CNPUSH (LAND PVRL Y) () )))	;vars have a home
;;;		Ditto for LAMBDA variables
		(AND OLVRL (CNPUSH (LAND OLVRL Y) () ))
;;;		Push out delayed SPECIALs or CARCDRs that might be clobbered
		(AND LDLST
		     (COND ((MEMQ PROGN Y) (CSLD 'T 'T Y))
			   ('T (CSLD () (MEMQ NULFU Y) Y))))))	
;;;		Depending on input, we flush out the acs
    (AND CLBFL (CLEARACS0 () )))

(COMMENT CLEARACS)

(DEFUN CLEARACS (N CLBFL HOME)
	(DECLARE (FIXNUM MODEFL))
	(PROG (I FL MODEFL)
	A     (COND ((MINUSP N)
		     (SETQ SLOTX NUMACS) (SETQ I #%(NUMVALAC))
		     (SETQ MODEFL (SETQ N (- #%(NUMVALAC) 1 N))))
		    ((SETQ SLOTX REGACS) (SETQ I 1) (SETQ MODEFL 0)))
	B     (COND ((EQ (CPUSH1 I HOME () ) 'PUSH) (SETQ FL 'T)))
	      (AND CLBFL (RPLACA SLOTX () ))
	      (COND ((GREATERP (SETQ I (ADD1 I)) N)
		     (AND (NOT (ZEROP MODEFL)) CLBFL (CLEARACSMODE MODEFL)) (RETURN FL))
		    ((NULL (SETQ SLOTX (CDR SLOTX)))
		     (SETQ N (DIFFERENCE #%(NACS) N))
		     (GO A))
		    ((GO B)))))

(DEFUN CLEARACS0 (CLBFL) (CLEARACS #.(+ (NACS) (NUMNACS)) CLBFL () ))

(DEFUN CLEARACS1 (X HOME) 
	(CLEARACS (COND ((AND X (GET X 'ACS))) (#%(NACS))) 'T HOME)
	(CLEARACS #.(- (NUMNACS)) 'T HOME))

(DEFUN CLEARVARS () (CLEARACS #.(+ (NACS) (NUMNACS)) () 'CLEARVARS))

(DEFUN CLEARNUMACS () (CLEARACS #.(- (NUMNACS)) 'T () ))

(DEFUN CLEARACSMODE (N)
    (RPLACA ACSMODE () )
    (COND ((> N #%(NUMVALAC))
	   (RPLACA (CDR ACSMODE) () )
	   (COND ((> N #.(1+ (NUMVALAC)))
		  (RPLACA (CDDR ACSMODE) () ))))))


(DEFUN CLEANUPSPL (CLBFL) 
;;; Clean up the SPLDLST by tossing out worthless stuff
;;; CLBFL=() allows carcdrings still in the slotlist to stay around
;;;  for possible future VL crossings
   (PROG (FL TEM)
	 (SETQ FL 'T)
         (MAP '(LAMBDA (LL) 
		(AND (NOT (COND ((ATOM (CDAR LL)) (CLMEMBER (CAAR LL) (CDAR LL) LDLST '=))
				((ASSQ (CAAR LL) LDLST))
				((NULL (SETQ TEM (ASQSLT (CAAR LL)))) () )
				((NOT CLBFL) 'T)
				('T (SETQ TEM (OR (MEMBER TEM REGACS)
						  (MEMBER TEM NUMACS)))
				     ;; FOO, CHEAP WAY TO DO (CONT ? () )
				    (AND TEM (RPLACA TEM () )) 
				    () )))
		     (RPLACA LL (SETQ FL () ))))
	     SPLDLST)
	(AND (NULL FL) (FLUSH-SPL-NILS))))


(DEFUN CLCHK (PDL L) (AND PDL (CAR PDL) (NULL (CDAR PDL)) (ASSQ (CAAR PDL) L)))

(DEFUN CLLOC (Z MODE) (CONVNUMLOC (- (LENGTH Z) (LENGTH #%(PDLGET MODE))) MODE))



(DEFUN CLMEMBER (X Y L FUN)
;;; A QUICK WAY OF DOING (MEMBER ZZ L) WHERE X = (CAR ZZ) Y = (CDR ZZ)
;;; AND THE EXPECTATION IS THAT THE "MEMBER" WILL USUALLY FAIL
    (DO Z L (CDR Z) (NULL Z)
	(AND (CAR Z) 
	     (EQ X (CAAR Z))
	     (COND ((EQ FUN 'EQ) (EQ Y (CDAR Z)))
		   ((EQ FUN '=) (AND (NUMBERP (CDAR Z)) (= (CDAR Z) Y)))
		   ((EQ FUN 'EQUAL) (EQUAL Y (CDAR Z))))
	     (RETURN Z))))

(DEFUN CLOBBER-SLOT (X L) 
    (AND (SETQ X (ASSQ (CAR X) L))
	 (RPLACA (MEMQ X L) () )) 
    () )

;;; (FXP0) - Offset for FXPDL addresses, has 2^11. bit off
;;; (FLP0) - Offset for FLPDL addresses, has 2^12. bit off
(DEFUN CONVNUMLOC (AC MODE)
  (COND ((NULL MODE) (COND ((> AC 0) (AC-ADDRS AC))
			   ((> (SETQ AC (+ AC #%(NPDL-ADDRS))) 0) 
			    (PDL-ADDRS 0 AC))
			   ('T (- AC #%(NPDL-ADDRS)))))
	(#%(ACLOCP-N AC) (AC-ADDRS (+ AC #.(1- (NUMVALAC)))))
	((PROG2 (SETQ AC (+ AC #%(NPDL-ADDRS))) 
		(EQ MODE 'FIXNUM))
	 (COND ((> AC 0) (PDL-ADDRS 1 AC))
	       ('T (+ AC #.(- (FXP0) (NPDL-ADDRS))))))
	((EQ MODE 'FLONUM) 
	 (COND ((> AC 0) (PDL-ADDRS 2 AC))
	       ('T (+ AC #.(- (FLP0) (NPDL-ADDRS))))))))


(DEFUN CONT (N Y) (RPLACA (FIND N) Y)) 

(DEFUN CONTENTS (N) (CAR (FIND N))) 



(COMMENT CPUSH)

(DEFUN CPUSH (N) (FIND N) (CPUSH1 N () () ))

(DEFUN CPUSH-DDLPDLP (N AD)
    (FIND N)
    (AND (DVP1 SLOTX N)				;Have I diddled with the PDl for which
	 (EQ (CPUSH1 N () AD) 'PUSH)		; the address AD is an offset thereof?
	 #%(PDLLOCP AD)
	 (EQ (GETMODE N) (GETMODE AD))))


;;; Must preserve SLOTX.  If SLOTX = (FIND N) , 
;;;  then CPUSH1 will compile a PUSH (or MOVE) to the PDL from N
;;; Returns either "PUSH", "T", or "()" depending on what happened.

(DEFUN CPUSH1 (N HOME DONT)
     (COND ((OR (NULL (CAR SLOTX)) 
		(EQ (CAAR SLOTX) 'QUOTE) 
		(EQ (CDAR SLOTX) 'DUP)) 
	    () )
	  ((EQ (CDAR SLOTX) 'TAKEN) (AND (NOT (EQ HOME 'CLEARVARS)) (CPUSH2 (GETMODE N) N)))
	  (((LAMBDA (VFL)
		    (COND ((NOT (DVP2 (CAR SLOTX) N VFL)) () )		;If not DVP, then return ()
			  ((NOT VFL) 					;For GENSYM stuff, PUSH only
				(AND (NOT (EQ HOME 'CLEARVARS))		;If not restricted by home
					  (CPUSH2 (GETMODE N) N)))
			  ((EQ HOME 'GENSYM) () )			;Vars not pushed if restricted
			  (((LAMBDA (MODE) 
				    (COND ((CDAR SLOTX)
					   (OPUSH N (CAR SLOTX) MODE)
					   (RPLACA SLOTX () )
					   'PUSH)
					  ((CPUSHFOO N DONT MODE) 'MOVEM) ;Take existing home-slot on PDL
					  ((CPUSH2 MODE N))))
				(GETMODE N)))))				  ; or create PDL home for local var
		(VARBP (CAAR SLOTX))))))

(DEFUN CPUSH2 (MODE N) 
	(OPUSH N (CAR SLOTX) MODE)
	(RPLACA SLOTX (CONS (CAAR SLOTX) 'DUP))
	'PUSH)



(DEFUN CPUSHFOO (N DONT MODE)
   ((LAMBDA (T1 T2 SL BESTCNT BESTLOC M)
	    (AND (NOT (FIXP DONT)) (SETQ DONT () ))
	    (DO ((Z #%(PDLGET MODE) (CDR Z))
		 (I 0 (1- I)))
		((NULL Z))
		(AND (EQ (CAAR SLOTX) (CAAR Z))
		     (PROG2 (SETQ T1 (CONVNUMLOC I MODE)) 'T)
		     (OR (NULL DONT) (NOT (= DONT T1)))
		     (COND ((AND (EQ (CDAR Z) 'OHOME)
				 (NOT (DVP4 (CAR Z) T1)))
			    (SETQ SL Z BESTLOC T1)
			    (RETURN () ))
			   ((NOT (DVP1 Z T1))))
		      (PROG2 (SETQ T2 (COND ((NUMBERP (CDAR Z)) (CDAR Z)) (CNT)))
			     (> T2 BESTCNT))
		      (SETQ SL Z BESTLOC T1 BESTCNT T2)))
	    (COND (SL (SETQ M (LENGTH #%(PDLGET MODE)))
		      (AND  (REGADP N)
			    (NOT (REGADP BESTLOC))
			    (SETQ SLOTX 
			      (PROG2 () SLOTX
				     (SETQ N (LOADINSOMENUMAC 
					      (CONS (CAR (CONTENTS N)) CNT))))))
		      (SETQ BESTLOC (+ BESTLOC 
				       (COND ((MINUSP (SETQ M (- M (LENGTH #%(PDLGET MODE))))) 1)
					     ((PLUSP M) -1)
					     (0))))
		      (COND ((AND (= N 1)
				  (= BESTLOC 0)
				  (NULL MODE)
				  (AND (NOT ATPL) (NOT ATPL1))
				  (MEMQ (CAR LOUT) '(CALL CALLF))
				  (EQUAL LOUT1 '(PUSH P 1)))
			     (SETQ LOUT1 (SETQ ATPL1 'FOO))
			     (OUTPUT '(PUSH P 1)))
			    ('T (OUT1 'MOVEM N BESTLOC)))
		      (RPLACA SL (PROG2 () 
					(CAR SLOTX) 
					(RPLACA SLOTX (CONS (CAAR SLOTX) 'DUP))))
		      'T)))
	0 0 () 0 0 0))

(COMMENT CSLD)

;;; Apparently the value of CSLD is umimportant

(DEFUN CSLD (VFL CCFL SETQLIST)
  (PROG (L TEM T2 NLARG V)
	(SETQ T2 0 NLARG 0)
	(DO Z LDLST (CDR Z) (OR (NULL Z) (EQ Z EXLDL))
	    (SETQ V (CAAR Z))
	    (COND ((NULL (CDAR Z))					; ITEM IS LIKE (G00001)
		   (AND CCFL 
			(SETQ TEM (ASSQ V SPLDLST))
			(NOT (ASQSLT V))
			(PUSH TEM L)))
;;; ### Does a "MEMQ" really work here?  Is "MEMBER" or "CLMEMBER"  necessary?
		  ((AND (OR (AND VFL (MEMQ (CAR Z) SPLDLST))  		;Loading up SPECIAL vars
			    (AND SETQLIST (MEMQ V SETQLIST)))	;Loading SETQ vars
			(COND ((NOT (NUMBERP (SETQ TEM (ILOC2 'T (CAR Z) (VARMODE V))))))
			      ((PROG2 (SETQ NLARG TEM) #%(PDLLOCP-N NLARG))
			       (NULL (CDR (CONTENTS TEM))))
			      ((AND #%(ACLOCP-N NLARG) 
				    (MEMQ (CDR (CONTENTS TEM)) '(DUP () )))
			       (AND (NOT (SPECIALP V)) (CPUSH TEM))
			       #%(LET ((REGACS REGACS) (NUMACS NUMACS))
				     (SETQ REGACS (APPEND REGACS () )
					   NUMACS (APPEND NUMACS () ))
				     (MAP '(LAMBDA (SL)
					    (AND (CAR SL) 
						 (EQ (CAAR SL) V)
						 (RPLACA SL () )))
					  (APPEND NUMACS REGACS))
				     (SETQ TEM (ILOC2 'T (CAR Z) (VARMODE V))))
			       (OR (NOT (NUMBERP TEM)) (NULL (CDR (CONTENTS TEM)))))
			      (T)))
		   (PUSH (CAR Z) L))))
	;;; At this point, L is the list of goodies to be loaded
	(MAPC 
	 '(LAMBDA (X)
	   (COND ((NOT (ATOM (CDR X))) 					    ;Like (G0001 CAR X . 3)
		  
		  (COND ((NOT (EQ (PROG2 () VL (SETQ T2 (CARCDR X 1))) VL))	;Did this carcdr add
			 (OPUSH T2 (LIST (CAR X)) () ))				; to the VL hackery?
			((CPUSH2 () T2))))
		 ((AND (SETQ T2 (NUMBERP (SETQ TEM (ILOC0 X () ))))
		       (PROG2 (SETQ NLARG TEM) #%(PDLLOCP-N NLARG))
		       (NOT (DVP TEM)))
		  (CONT TEM (CONS (CAR X) 'IDUP)))			    ;LIKE (X.N)
		 ((OPUSH TEM 
			 (COND ((AND T2 (NUMBERP (CDR (SETQ T2 (CONTENTS TEM))))) T2)
			       ((CONS (CAR X) 'IDUP)))
			 () ))))
	 L)))



(COMMENT CPVRL CNPUSH and DIDUP)

(DEFUN CPVRL ()
    (COND (LPRSL)
	  ('T (SETQ LPRSL '(0 0 0))
	      (CNPUSH PVRL 'T)
	      (SETQ PRSSL (SLOTLISTCOPY))
	      (SETQ LPRSL (LIST (LENGTH REGPDL) (LENGTH FXPDL) (LENGTH FLPDL))))))

(DEFUN CNPUSH (L FL)
  (AND L 
    (PROG (NN XN LN MODE LOC ITEM Z ZZ)
	  (DECLARE (FIXNUM NN XN LN))
	  (SETQ NN 0 XN 0 LN 0)
      A   (SETQ MODE (VARMODE (CAR L)))
	  (SETQ LOC (ILOC1 'T (SETQ ITEM (CONS (CAR L) CNT)) MODE))
	  (COND ((OR LOC (AND MODE (ASSQ (CAR L) REGACS) (SETQ LOC (ILOC1 'T ITEM () ))))
		(AND FL #%(ACLOCP LOC) (PUSH LOC ZZ)))
	      ('T (RPLACD ITEM () ) 
		  (COND  ((NULL MODE) (PUSH ITEM REGPDL) (SETQ NN (1+ NN)))
			 ((EQ MODE 'FIXNUM) (PUSH ITEM FXPDL) (SETQ XN (1+ XN)))
			 ('T (PUSH ITEM FLPDL) (SETQ LN (1+ LN))))))
	(AND (SETQ L (CDR L)) (GO A))
	(AND (NOT (ZEROP NN)) (CNPUSH1 NN 0))		;0 IS FOR P
	(AND (NOT (ZEROP XN)) (CNPUSH1 XN 1))		;1 IS FOR FXP
	(AND (NOT (ZEROP LN)) (CNPUSH1 LN 2))		;2 IS FOR FLP
	(MAPC 'CPUSH ZZ)
	(RETURN Z))))

(DEFUN CNPUSH1 (N PDL)
    (DECLARE (FIXNUM N PDL MAX))		;PDL IS THE NUMBER DESIGNATING
    (PROG (MAX)					; WHICH PDL.  N IS THE AMOUNT 
	(SETQ MAX (PVIA PDL 0))			; TO BE PUSHED, AND MAX IS THE
    A   (COND ((> N MAX)			; MAX BITE IN ONE CHUNK
		(OUTPUT (PVIA PDL MAX))
		(SETQ N (- N MAX))
		(GO A))
	      ((> N 2) (OUTPUT (PVIA PDL N)))
	      ((> N 0)
	       (OUTPUT (PVIA PDL 1))
	       (AND (= N 2) (OUTPUT (PVIA PDL 1)))))))



(DEFUN DIDUP (L)
    (COND (L (COND ((EQ L CLPROGN)) 
		   ((MEMQ PROGN L) (SETQ L CLPROGN)))
	     (DIDU1 REGACS L)
	     (DIDU1 NUMACS L)
	     (DIDU1 REGPDL L)
	     (DIDU1 FXPDL L)
	     (DIDU1 FLPDL L))))

(DEFUN DIDU1 (SLOT L)
  (AND SLOT 
       (DO ZZ (MEMASSQR 'IDUP SLOT) (MEMASSQR 'IDUP (CDR ZZ)) (NULL ZZ)
	  (AND (OR (EQ L CLPROGN) (MEMQ (CAAR ZZ) L))
	       (RPLACA ZZ (CONS (CAAR ZZ) CNT))))))


(COMMENT DVP)

(DEFUN DVP (I) (DVP1 (FIND I) I))
			 
(DEFUN DVP1 (SL I)
   (COND ((OR (NULL (CAR SL))			;Tells whether item must be saved (at this point). 
	      (EQ (CAAR SL) 'QUOTE)		;Should not change SLOTX, eg by calling FIND
	      (EQ (CDAR SL) 'DUP))
	  () )
	 ((MEMQ (CDAR SL) '(TAKEN IDUP)))
	 ((DVP2 (CAR SL) I (VARBP (CAAR SL))))))

(DEFUN DVP2 (ITEM I VFL)						;VFL must be result of VARBP
    (COND (VFL (COND ((AND (EQ VFL 'SPECIAL) 
			   (MEMQ (CDR ITEM) '(DUP () )))		;Current home of spec var 
		      () )
		     ((AND (NOT (EQ VFL 'SPECIAL))			;Current home of local var
			   (OR (NULL (CDR ITEM)) (EQ (CDR ITEM) 'OHOME))) ; whose time has not yet
		      (SETQ VFL (ASSQ (CAR ITEM) LOCVARS))
		      (OR (< CNT (CDR VFL)) (DVP4 ITEM I)))		; run out [or is still DVP4]
		     ((NOT (NUMBERP (CDR ITEM))) 
		      (BARF (LIST I ITEM) |Whass happnin - DVP2|))
		     (#%(ACLOCP I)
			(SETQ VFL (GETMODE I))				;Var in AC is not DVP if an
			(SETQ VFL #%(PDLGET VFL))			;IDUP or same-count copy is
			(COND ((OR (CLMEMBER (CAR ITEM) 'IDUP VFL 'EQ)	; on PDL
				   (CLMEMBER (CAR ITEM) (CDR ITEM) VFL '=))
				() )
			      ((DVP4 ITEM I))))
		     ((DVP4 ITEM I))))
	  ((ASSQ (CAR ITEM) LDLST))					;Internal computation quantity on LDLST
	  (VL (DVP3 (CAR ITEM) VL))))					;VarList crossings 

(DEFUN DVP3 (VAR L)
    (AND L 
	(SETQ L (DO ZZ L (CDR ZZ) (NULL ZZ) 				;Look for crossing for this var
		  (AND (EQ VAR (CAAR ZZ)) (RETURN ZZ))))
	((LAMBDA (XTN LL)
	    (COND ((AND LL (NOT (ASQSLT XTN))))				;A primary, needed crossing
		  ((NULL (CDR L)) () )					;No more potential crossings
		  ((AND (NULL LL) (DVP3 XTN (CDR L))))			;Look for "grandsons"
		  ((DVP3 VAR (CDR L)))))				;Look for more direct "sons"
	  (CDAR L) (ASSQ (CDAR L) LDLST))))

(DEFUN DVP4 (ITEM I)
    (AND (ASSQ (CAR ITEM) LDLST)					;Basic var DVP utilizing LDLST
	 #%(LET ((MODE (VARMODE (CAR ITEM)))
		(VAR (CAR ITEM))
		(PDLP (AND #%(PDLLOCP-N I) (NUMBERP (CDR ITEM)))) 
		(FL) (TEM) )
	       (SETQ FL (AND MODE (ASSQ VAR REGACS)))
	       (DO ((Z LDLST (CDR Z)))					;If any item on LDLST needs 
		   ((NULL Z))						; the item of interest
		 (AND (EQ (CAAR Z) VAR)
		      (NUMBERP (SETQ TEM (COND (FL #%(ILOCNUM (CAR Z) () ))
					       ((ILOC1 'T (CAR Z) MODE)))))
		      (COND ((= I TEM))					;Yup, this is the one!
			    ((< TEM 0) () )
			    ((PROG2 (SETQ TEM (GCONTENTS TEM))		;If (X.4) in both PDL and AC 
				    PDLP)  	 			; and LDLST wants either 
			     (EQUAL ITEM TEM))	     			; slot, then PDL slot is DVP
			    ((EQ (CDR TEM) 'DUP) 			;Dont let DUPs mask out
			     (NULL (CDR (GCONTENTS I)))))		; a home slot.
		      (RETURN 'T)))) ))


(COMMENT EASYGO FIND and FLUSH-SPL-NIL)

(DEFUN EASYGO ()				;Should be nothing on LDLST except what was there
    (AND (EQ PROGP LDLST)			; upon entry to the PROG
	 (NULL GOBRKL)				;Not be in LAMBDA requiring special unbind
	 (= (LENGTH REGPDL) (CAR LPRSL))	;   and not under CATCH or ERRSET
	 (= (LENGTH FXPDL) (CADR LPRSL))	;SLOTLIST not need restore to PROG level 
	 (= (LENGTH FLPDL) (CADDR LPRSL))))

(DEFUN FIND (N)
    (SETQ SLOTX (COND ((PLUSP N) 
			(COND (#%(NUMACP-N N) (SETQ N (- N #%(NUMVALAC))) NUMACS)
			      ('T (SETQ N (1- N)) REGACS)))
		      ((NOT #%(NUMPDLP-N N)) (SETQ N (- N)) REGPDL)
		      (#%(FLPDLP-N N) (SETQ N (- #%(FLP0) N)) FLPDL)
		      ('T (SETQ N (- #%(FXP0) N)) FXPDL)))
    (COND ((ZEROP N) SLOTX)
	  ((SETQ SLOTX #%(NCDR SLOTX N)))))


(DEFUN FLUSH-SPL-NILS ()
   (AND SPLDLST 
	(PROG (L OL)
	    A (AND (NULL (CAR SPLDLST)) (SETQ SPLDLST (CDR SPLDLST)) (GO A))
	      (SETQ OL (SETQ L SPLDLST))
	    B (AND (NULL (SETQ L (CDR L))) (RETURN SPLDLST))
	      (COND ((NULL (CAR L)) (RPLACD OL (CDR L)))
		    ((SETQ OL L)))
	      (GO B))))


(COMMENT FRACF etc to FREEREGAC)

(DEFUN FRACF () 
    ((LAMBDA (N)
	     (COND ((ZEROP N) (SETQ SLOTX REGACS) (CPUSH1 1 () () ) 1)
		   (N)))
	(FRAC)))

(DEFUN FRAC () 
	    (COND ((NULL (CAR  (SETQ SLOTX REGACS))) 1)		;This bletcherous code is
		  ((NULL (CAR (SETQ SLOTX (CDR SLOTX)))) 2)	;here purely for speed
		  ((NULL (CAR (SETQ SLOTX (CDR SLOTX)))) 3)	;reasons, since calls to
		  ((NULL (CAR (SETQ SLOTX (CDR SLOTX)))) 4)	;these functions are so frequent
		  ((NULL (CAR (SETQ SLOTX (CDR SLOTX)))) 5)
		  ((DO N (PROG2 (SETQ SLOTX REGACS) 1) 
			 (PROG2 (SETQ SLOTX (CDR SLOTX)) (1+ N))
			 (> N #%(NACS))
		      (AND (NOT (DVP1 SLOTX N)) (RETURN N))))
		  (0)))

(DEFUN FRACB ()
 ((LAMBDA (Y)
	  (COND ((NULL (CADR Y)) (SETQ SLOTX (CDDR SLOTX)) 5)	;TRIES EMPTY 5,4,3 FIRST IN THAT ORDER,
		((NULL (CAR Y)) (SETQ SLOTX (CDR SLOTX)) 4)	;THEN TRIES NON-DVP AC IN BACKWARDS ORDER
		((NULL (CAR SLOTX)) 3)				;ASSUMING SLOT IS BEING USED FOR TEMPS
		((NOT (DVP1 (CDR Y) 5)) (SETQ SLOTX (CDR Y)) 5)
		((NOT (DVP1 Y 4)) (SETQ SLOTX Y) 4)
		((NOT (DVP1 SLOTX 3)) 3)
		((NOT (DVP1 (SETQ SLOTX (CDR REGACS)) 2)) 2)
		((1FREE) (SETQ SLOTX REGACS) 1)
		(0)))
      (CDR (SETQ SLOTX (CDDR REGACS)))))			;THIS HAD BETTER YIELD SLOTX = (FIND 3)
(DECLARE (AND (< #%(NACS) 5) (BARF () |FRACB is losing|)))

(DEFUN FRAC1 () 
    ((LAMBDA (AC)
	(COND ((1FREE) (SETQ SLOTX REGACS) 1) 
	      ((NOT (ZEROP (SETQ AC (FRACB)))) AC)
	      ('T (SETQ SLOTX REGACS) (CPUSH1 1 () () ) 1)))
      0))

(DEFUN FRAC5 () 
     ((LAMBDA (N) (COND ((NOT (ZEROP N)) N)
			('T (SETQ SLOTX (CDDDDR REGACS))			;Must be set SLOTX = (FIND 5)
			    (CPUSH1 #%(NACS) () () ) 
			    #%(NACS))))
	  (FRACB)))

(DEFUN FREEREGAC (F)
    ((LAMBDA (AC) (COND ((ZEROP AC) (BARF () |No free acs - FREEREGAC|) 0)
			(AC)))
	(COND ((EQ F 'FRAC) (FRAC)) ((FRACB)))))


(COMMENT FREENUMAC etc to FUNMODE)

(DEFUN FREEIFYNUMAC () 
      (OR (NOT (ZEROP (FREENUMAC1))) 			;Insure that there is at least
	  (PROG2 (CLEARACS #.(- (NUMNACS)) () 'T) 	; one free NUMAC
		 (NOT (ZEROP (FREENUMAC1)))) 
	  (FREENUMAC0)))

(DEFUN FREENUMAC () 
       ((LAMBDA (AC) 
		(AND (ZEROP AC) (SETQ AC (FREENUMAC0)))
		AC)
	  (FREENUMAC1)))

(DEFUN FREENUMAC1 () 
	     (COND ((AND (NULL (CAR (SETQ SLOTX NUMACS))) (NOT (= TAKENAC1 #.(NUMVALAC))))
		    #.(NUMVALAC))
		   ((AND (NULL (SETQ SLOTX (CDR SLOTX)))
			 (NOT (= TAKENAC1 #.(+ (NUMVALAC) 1)))) 
		    #.(+ (NUMVALAC) 1))
		   ((AND (NULL (SETQ SLOTX (CDR SLOTX)))
			 (NOT (= TAKENAC1  #.(+ (NUMVALAC) 2)))) 
		    #.(+ (NUMVALAC) 2))
		   ((DO I (PROG2 (SETQ SLOTX NUMACS) #%(NUMVALAC)) 
			  (PROG2 (SETQ SLOTX (CDR SLOTX)) (1+ I))
			  (NULL SLOTX)
		      (AND (NOT (= I TAKENAC1)) (NOT (DVP1 SLOTX I)) (RETURN I))))
		   (0)))

(DEFUN FREENUMAC0 ()
	(SETQ SLOTX NUMACS)
	(COND ((= TAKENAC1 #%(NUMVALAC)) 
		(SETQ SLOTX (CDR SLOTX))
		(CPUSH1 (1+ #%(NUMVALAC)) () () )
		(1+ #%(NUMVALAC)))
	      ('T (CPUSH1 #%(NUMVALAC) () () )
		  #%(NUMVALAC))))


(DEFUN FUNMODE (F)
    (DO Y MODELIST (CDR Y) (NULL Y)
	(AND (NOT (ATOM (CAAR Y)))
	     (EQ (CAAAR Y) F)
	     (RETURN (CDAR Y)))))

 
(DEFUN FUNTYP-DECODE (X)
  ((LAMBDA (T1)
	   (COND (T1 (COND ((EQ (CAR T1) 'FUNTYP-INFO) (CAADR T1))
			   ((CAR T1))))
		 ((|carcdrp/|| X) 'CARCDR)
		 ((SETQ T1 (GETL X '(SUBR LSUBR FSUBR)))
		  (AND (OR (SYSP (CADR T1)) (STATUS SYSTEM X))
		       (CAR T1)))))
     (GETL X '(JSP CARCDR *EXPR *FEXPR *LEXPR FUNTYP-INFO))))


(COMMENT GCDR GETMODE)

(DEFUN GCDR (F L)					;Generalized CDR
    (PROG () 
	  (AND (NULL L) (RETURN () ))
	  #.(COND ((NOT (MEMQ COMPILER-STATE '(() TOPLEVEL)))
		    '(SETQ F (GET F 'SUBR)))
		  ('B))
      A   (COND ((AND L (NOT #.(COND ((NOT (MEMQ COMPILER-STATE '(() TOPLEVEL)))
				      '(SUBRCALL T F L))
				     ('(FUNCALL F L)))))
		  (POP L)
		  (GO A)))
	  (RETURN L)))

;;; Get contents, but dont change SLOTX
(DEFUN GCONTENTS (X) 
       ((LAMBDA (SVSLT) (PROG2 () (CONTENTS X) (SETQ SLOTX SVSLT))) SLOTX))


(DEFUN GENTAG (TAG)
    (OR (SYMEVAL TAG)
	(PROGN (SET TAG (SETQ TAG (GENSYM)))
	       (PUSH (CONS () TAG) GL)
	       (PUTPROP TAG 'T 'USED)
	       TAG)))

(DEFUN GETMODE (N)
    (COND ((PLUSP N) (GETMODE0 N #%(NUMACP-N N) 'T))
	  ((NOT #%(NUMPDLP-N N)) () )
	  (#%(FLPDLP-N N) 'FLONUM)
	  ('FIXNUM)))

(DEFUN GETMODE0 (N ACP SHEE-IT)
    (COND ((AND ACP (CAR #%(ACSMODESLOT N))))
	  (((LAMBDA (TEMP)
		    (COND ((NULL (SETQ TEMP (GCONTENTS N)))
			    (BARF N |No thing - GETMODE|))
			  ((EQ (CAR TEMP) 'QUOTE)
			   (CAR (MEMQ (TYPEP (CADR TEMP)) '(FIXNUM FLONUM))))
			  ((NUMERVARP (CAR TEMP)))
			  ((AND ACP (NOT (VARBP (CAR TEMP))))
			   (COND (FIXSW 'FIXNUM) 
				 (FLOSW 'FLONUM) 
				 (SHEE-IT (BARF N |No mode - GETMODE|) () )))))
	     () ))))

     
(COMMENT ILOC and ILOCMODE)

;;; INTERNAL LOCATORS - RETURN ONE OF
;;;	()			;Not found
;;;	((QUOTE MUMBLE) . ())	;Quoted thing
;;;	(SPECIAL FOO)		;Current value of special var
;;;	    1    => 5		;Quantity in REGACS
;;;	    7    => 11[8]	;"	   " NUMACS
;;;	-3777[8] => 0		;"	   " REGPDL
;;;	-7777[8] => -4000[8]	;"	   " FXPDL
;;;	-INF     => -10000[8]	;"	   " FLPDL


(DEFUN ILOC0 (X MODE) 
;;;  Should not change SLOTX, e.g. by calling FIND, or CONT, or CONTENTS
;;;  Internally-located? -  SPECIAL value cells, QUOTE stuff, and SLOTLIST 
;;;    entries are internal places acceptable.  REturns best of these if x is
;;;    somewhere therein;  otherwise ().
    (COND ((EQ (CAR X) 'QUOTE) (LIST X))
	  ((ILOC1 (VARBP (CAR X)) X MODE))))

(DEFUN ILOC1 (FL X MODE)
     (DO ((I 1 (ADD1 I))  (Y #%(ACSGET MODE) (CDR Y)) 
	  (ENDFLAG)  (T1)  (BESTLOC 0)  (BESTCNT 0))
	 ((COND ((NULL Y)
		 (COND (ENDFLAG)
		       ('T (SETQ ENDFLAG 'T)
			   (NULL (SETQ Y #%(PDLGET MODE)))))))
	  (COND ((NOT (ZEROP BESTCNT))
		 (CONVNUMLOC (COND ((< BESTLOC (SETQ T1 #%(NACSGET MODE))) BESTLOC) 
				   ((- T1 BESTLOC)))
			     MODE))
		((AND FL (NULL MODE) (SPECIALP (CAR X))))
		((AND (NOT FL) (SETQ FL (MEMASSQR (CAR X) VL))) 
		  (ILOC1 () (CONS (CAAR FL) (CDR X)) MODE ))))
	(AND (CAR Y) 
	     (EQ (CAAR Y) (CAR X))
	     (COND ((MEMQ (CDAR Y) '(() DUP IDUP))
		    (COND ((ZEROP BESTCNT)
			   (SETQ BESTLOC I BESTCNT 35397.)			;total random no.
			   (COND ((NOT FL) (SETQ Y () ENDFLAG 'T))))))
;		   THE FIRST INSTANCE IN THE SLOTLIST OF A GENSYM QUANTITY WILL BE THE RIGHT ONE
		   ((AND FL (CDR X)
			 (NUMBERP (SETQ T1 (COND ((EQ (CDAR Y) 'OHOME) (GET (CAAR Y) 'OHOME))
						 ((CDAR Y)))))
			 (NOT (< T1 (CDR X)))
			 (OR (ZEROP BESTCNT) (> BESTCNT T1)))
		     (SETQ BESTCNT T1 BESTLOC I))))))

(DEFUN ILOC2 (FL V TYPE)
    (COND ((AND (NULL FL) (EQ (CAR V) 'QUOTE)) (LIST V))
	  ((ILOC1 FL V TYPE))
	  ((AND TYPE (ILOC1 FL V () )))
	  ((AND (NULL FL) (ASSQ (CAR V) SPLDLST)) () )
	  ('T (BARF V |Lost ? - ILOC2|) () )))



(DEFUN ILOCMODE (ITEM ACORFUN TYPE)
 (COND ((EQ (CAR ITEM) 'QUOTE) (LIST ITEM))
       ((PROG (Z NPZ ZZ ATP FL NUMWORLD)
	(SETQ ATP (ATOM TYPE) NUMWORLD (AND ATP TYPE))
	(SETQ FL (VARBP (CAR ITEM)))
	(SETQ Z (ILOC1 FL ITEM NUMWORLD))
	(COND ((NULL Z)
		(RETURN (COND ((COND (NUMWORLD (SETQ ZZ (ILOC1 FL ITEM () ))) 
				     ((AND ATP ACORFUN) () )
				     ((SETQ ZZ (COND (FL (SETQ NPZ (VARMODE (CAR ITEM)))
							 (COND ((NULL NPZ) () )
							       ((ILOC1 T ITEM NPZ))
							       ((ILOC1 T 
								       ITEM
								       (COND ((EQ NPZ 'FIXNUM)
									      'FLONUM)
									     ('FIXNUM))))))
						     ((ILOC1 T ITEM 'FIXNUM))
						     ((ILOC1 T ITEM 'FLONUM))))))
				ZZ)
			      ((NULL ACORFUN) () )
			      ((SETQ ZZ (ASSQ (CAR ITEM) SPLDLST)) (CARCDR ZZ ACORFUN))
			      ((BARF ITEM |Lost datum - ILOCMODE|)))))
	      ((COND ((OR (NULL TYPE) (NULL FL)))	;Tedious decision as to whether or not to
		     ((NUMERVARP (CAR ITEM)) () )	; try the other areas
		     ((NOT (ASSQ (CAR ITEM) NUMACS)))	;Numvars locatable in regarea must be sought in
		     (NUMWORLD () )			; the numworld, and ILOCNUMs might want to check
		     ((NULL (CAR TYPE))))		; the NUMACS
		(RETURN Z))
	      ((PROG2 (SETQ NPZ (NUMBERP Z)) 
		      NUMWORLD)				;Type = FIXNUM [or FLONUM]
		(AND (OR (NOT NPZ)
			 (NOT (NUMBERP (SETQ ZZ (ILOC1 FL ITEM () )))))
		     (RETURN Z))
		(SETQ ZZ (PROG2 () Z (SETQ Z ZZ))))
	      ('T (AND (COND ((NULL (CAR TYPE)) (NOT NPZ))		;(() FIXNUM FLONUM) => call by ILOCREG
			     ((NOT NPZ) (NOT (EQ (CAR Z) 'SPECIAL))))
		       (RETURN Z))					;(FIXNUM FLONUM) =>  call by ILOCNUM
		  (SETQ ZZ (COND ((ILOC1 FL ITEM 'FIXNUM)) 
				 ((ILOC1 FL ITEM 'FLONUM))
				 ('T (RETURN Z))))
		  (AND (NOT NPZ) (RETURN ZZ))))
	;So a call for ILOCREG or ILOCNUM has resulted in finding copies in both 
	; the numworld and the regworld.  So we have to ascertain which copy is best
	;Z holds result of (ILOC0 ITEM () ), i.e. the regworld loc, and
	;ZZ that for (ILOC0 ITEM 'FIXNUM) [or 'FLONUM], the numworld loc
	;RCNT is the time-count for the regworld slot, NCNT for the number world
	(RETURN ((LAMBDA (RCNT NCNT)
		      (AND (NOT (NUMBERP RCNT)) (SETQ RCNT () ))
		      (AND (NOT (NUMBERP NCNT)) (SETQ NCNT () ))
		      (COND ((AND (NOT NCNT) (NOT RCNT)) 
			     (COND ((NUMBERP ACORFUN) (COND (#%(NUMACP ACORFUN) ZZ) (Z)))
				   ((AND FL (NUMERVARP (CAR ITEM))) ZZ)
				   ((NULL (CAR TYPE)) Z)
				   (ZZ)))
			    ((AND NCNT RCNT) (COND ((< RCNT NCNT) Z) (ZZ))) ;PREFER LOWER OF TWO COUNTS 
			    ((AND RCNT (< RCNT CNT)) Z)		;PREFER A COUNT TO A HOME
			    (ZZ)))				;IF COUNT IS ACCEPTABLE
		  (CDR (GCONTENTS Z))
		  (CDR (GCONTENTS ZZ))))))))

(COMMENT ITEML LSUB LJOIN etc))

(DEFUN ITEML  (Y PROP)
; ITEML compiles an itemlist and  returns a list of the compiled 
;   arguments (internal names therefor, that is) in reverse order
	  (DO ((AC 1 (ADD1 AC)) (Y Y (CDR Y)) (PNOB 'T 'T)
	       (Z) (ITEM) (LOC) (ARGNO 1) (EFFS)
	       (PROP (AND PROP (CDDR PROP)) (AND PROP (CDR PROP))))
	      ((NULL Y) Z)
	    (SETQ ARGNO (COND ((NULL PROP) AC)
			       ;Oddly enuf, the next case is for CONS etc. 
			      ((EQ (CAR PROP) 'PNOB) (SETQ PNOB () ) 1)
			      ((MEMQ (CAR PROP) '(FIXNUM FLONUM)) #%(NUMVALAC)) 
			      ('T AC)))
	    (PUSH (SETQ ITEM (COMP0 (CAR Y))) Z)
	    (AND (= ARGNO #%(NUMVALAC))
		 (SETQ LOC (ILOC0 ITEM (CAR PROP)))
		 #%(NUMACP LOC)
		 (SETMODE LOC (CAR PROP)))))

(DEFUN L/.LE/. (L LL)				;Length L less-than-or-equal-to Length LL
    (PROG ()
      A   (AND (NULL L) (RETURN (COND (LL 'LESSP) ('EQUAL))))
	  (AND (NULL LL) (RETURN () ))
	  (SETQ L (CDR L) LL (CDR LL))
	  (GO A)))


(DEFUN L2F (X)
    (COND ((OR (NULL X) (NULL (CDR X))) X)
	  ('T (SETQ X (REVERSE X)) (RPLACD X (NREVERSE (CDR X))))))

(DEFUN LSUB (L LL) 
    (COND ((NULL LL) L)
	  ((NOT (MEMQ (CAR LL) L)) (LSUB L (CDR LL)))
	  ((MAPCAN '(LAMBDA (X) (COND ((MEMQ X LL) () )
				      ((LIST X))))
		    L))))

(DEFUN LADD (L LL)
    (COND ((NULL L) LL)
	  ((LADD (CDR L) (ADD (CAR L) LL)))))

(DEFUN LAND (L LL)
	(COND ((OR (NULL L) (NULL LL)) () )
	      ((NOT (MEMQ (CAR LL) L)) (LAND L (CDR LL)))
	      ((MAPCAN '(LAMBDA (X) (AND (MEMQ X L) (LIST X))) LL))))

(DEFUN LJOIN (L LL)								;Like APPEND, but tries 
    (COND ((NULL L) LL)								; interchanging args if 
	  ((NULL LL) L)								; that will reduce consing
	  ('T (AND (< (LENGTH LL) (LENGTH L)) 
		   (SETQ L (PROG2 () LL (SETQ LL L))))
	     (APPEND L LL))))

(DEFUN LEVEL (TAG) (COND ((GET TAG 'LEVEL)) 
			 ((MEMASSQR TAG GL) PRSSL) 
			 ((BARF TAG |Tag with no slotlist level|))))
(DEFUN LEVELTAG () #%(LET ((Y (GENSYM))) (PUTPROP Y (SLOTLISTCOPY) 'LEVEL) Y))

(COMMENT LOADACS LOADINACetc)

(DEFUN LOADACS (X HLAC PROP)
	(COND ((OR (NULL PROP) (NULL (SETQ PROP (CAR PROP))))
	       (SETQ PROP '(() () () () () )))
	      ((< (LENGTH PROP) HLAC)
	       (DO I (- HLAC (LENGTH PROP)) (1- I) (SIGNP LE I)
		 (PUSH () PROP))))
	(DO ((AC HLAC (1- AC)) (FLAG () () ) (TEM))
	    ((ZEROP AC))
	  (COND ((OR (NULL PROP) 
		     (NULL (CAR PROP)) 
		     (SETQ FLAG (AND (MEMQ (CAR PROP) '(PNOB T)) (CAR PROP)))
		     (PROG2 (SETQ TEM #%(ILOCREG (CAR X) AC)) (REGADP TEM)))
		 (LOADAC (CAR X) AC FLAG))
		((MAKEPDLNUM (CAR X) AC)))
	  (POP PROP) 
	  (POP X)))


(DEFUN LOADAC (VAR AC CONSFL)
;CONSFL = T  	means no pdlnumbers allowed.
;CONSFL = PNOB  means no new pdlnumbers allowed, but existing ones ok
;CONSFL = () 	means anything goes
    #%(LET ((LOC #%(ILOCREG VAR AC)))
	(COND ((COND ((NULL CONSFL) () )
		     ((EQ (CAR VAR) 'QUOTE) () )
		     (#%(NUMACP-N AC) () )
		     ((NOT (REGADP LOC)) 
		      (OR (NOT (EQ CONSFL 'PNOB)) #%(ACLOCP LOC)))
		     ((EQ CONSFL 'PNOB) () )
		     ((UNSAFEP VAR)))
	 	(SETQ VAR (MAKESAFE VAR LOC 'REMOVEB))
		(SETQ LOC (ILOC0 VAR () )))
	      ('T (REMOVEB VAR)))
	(COND (#%(NUMACP-N AC) (LOADINNUMAC VAR AC LOC 'REMOVEB))
	      ((NOT (NUMBERP LOC))				;((QUOTE <frob>)) or (SPECIAL <var>) 
		(CPUSH AC)					;Sets SLOTX to (FIND AC)
		(COND ((AND (NOT (EQ (CAR LOC) 'SPECIAL))	;If QUOTE stuff to be loaded
			    (CAR SLOTX)				; is already there then do nothing
			    (EQ (CAAR SLOTX) 'QUOTE)
			    (EQUAL VAR (CAR SLOTX))))
		      ((AND (NOT (EQ (CAR LOC) 'SPECIAL))
			    (MEMQ (CADAR LOC) '(T () )))
			(COND ((CADAR LOC) (OUTPUT (BOLA AC 2)))	;(MOVEI AC 'T)
			      ((AND (NOT ATPL)				;Convert (MOVEI AD '() )
				    (EQ (CAR LOUT) 'MOVEI)		;	 (MOVEI AC '() )
				    (NOT (ATOM (CADDR LOUT)))		;Into	 (SETZB AD AC)
				    (QNILP (CADDR LOUT)))
				((LAMBDA (AD) 
					 (SETQ LOUT (SETQ ATPL 'FOO))
					 #%(OUTFS 'SETZB AD AC))
				    (CADR LOUT)))
			      ('T (OUTPUT (BOLA AC 5)))))		;(MOVEI AC '() )
		      ('T (OUT1 'MOVE AC LOC)))
		(CONT AC (COND ((EQ (CAR LOC) 'SPECIAL) (LIST (CAR VAR)))
			       (VAR))))
	      (#%(LET ((LOC-IN-ACP #%(ACLOCP LOC)) (NLARG 0))
		(COND ((AND LOC-IN-ACP 
			    (PROG2 (SETQ NLARG LOC) (NOT #%(NUMACP-N NLARG)))
			    (EQ (CDAR (FIND LOC)) 'DUP)		;SLOTX is where LOC is in AC
			    REGPDL 
			    (EQ (CAAR SLOTX) (CAAR REGPDL))	; of PDL and DUP in AC
			    (NOT (VARBP (CAAR SLOTX)))		;GENSYM quantity on top
			    (NOT (DVP1 SLOTX 0)))		; was found
			 (RPLACA SLOTX () )			;Change LOC to top of PDL
			 (SETQ LOC 0)))
		  (COND ((AND LOC-IN-ACP (= LOC AC)) (CPUSH AC))
			((NOT (REGADP LOC)) (PUSH VAR LDLST) (MAKEPDLNUM VAR AC))
			('T ((LAMBDA (ACLOC DAC DATAORG DOD)
				  (COND ((AND (ZEROP LOC) (NOT DOD) (NOT DAC))
					 (OPOP AC () )
					 (RPLACA ACLOC DATAORG))
					((AND (NOT DOD)
					      (CAR ACLOC)
					      (COND (#%(PDLLOCP LOC)
						     (COND ((EQ (CDAR ACLOC) 'DUP) () )
							   ((NOT (VARBP (CAAR ACLOC))))
							   ((SPECIALP (CAAR ACLOC))
							    DAC)
							   ((= LOC 0))
							   ((NOT DAC))
))
						    ((PLUSP HLAC)  ;SAYS CALL FROM LOADACS
						     (OR (> LOC HLAC) (< LOC AC)))))
					 (OUT1 'EXCH AC LOC)
					 (CONT LOC (CAR ACLOC))
					 (RPLACA ACLOC DATAORG))
				       ('T (AND	DAC 
						(PROG2 (FIND AC) 
						       (EQ (CPUSH1 AC () LOC) 'PUSH))
						#%(PDLLOCP LOC)
						(SETQ LOC (ILOC0 VAR () )))
					  (COND ((AND LOC-IN-ACP
						      (NOT ATPL)
						      (EQ (CAR LOUT) 'POP)
						      (= LOC (CADDR LOUT))
						      (EQ (CADR LOUT) 'P))
						 (SETQ LOUT (SETQ ATPL 'FOO))
						 (CONT LOC () )
						 (COND (DOD #%(OUTFS 'MOVE AC 0 'P)
							    (PUSH DATAORG REGPDL))
						       (#%(OUTFS 'POP 'P AC))))
						('T (COND ((AND LOC-IN-ACP
							       (> LOC AC)
							       (PLUSP HLAC)
							       (NOT (> LOC HLAC))
							       (NOT ATPL)
							       (EQ (CAR LOUT) 'EXCH)
							       (EQUAL AC (CADDR LOUT))
							       (EQUAL LOC (CADR LOUT)))
							  (SETQ LOUT (SETQ ATPL 'FOO))
							  (OUT1 'MOVE LOC AC))
							 ('T (OUT1 'MOVE AC LOC)))))
					  (RPLACA ACLOC 
						  (COND ((NUMBERP (CDR DATAORG)) DATAORG)
							((CONS (CAR DATAORG) 'DUP)))))))
			    (FIND AC)	;FIND AND CONTENTS SET SLOTX 
			    (DVP1 SLOTX AC)
			    (CAR (FIND LOC))
			    (DVP1 SLOTX LOC))))))) ))



(DEFUN LOADINNUMAC (ITEM AC LOC RMFLG)
   (PROG (ACFLG MODE NLARG)
	 (SETQ ACFLG 'T)
	 (AND (NULL LOC)
	      (SETQ LOC #%(ILOCNUM ITEM (COND ((ZEROP AC) (SETQ ACFLG () ) 'FREENUMAC)
					     ('T AC)))))
	 (COND ((EQ RMFLG 'REMOVEB) (REMOVEB ITEM) (SETQ RMFLG () ))
	       ((EQ RMFLG 'REMOVE)  (SETQ RMFLG ITEM)))
	 (COND ((REGADP LOC) 
		(AND (NOT ACFLG) (SETQ AC (FREENUMAC)))
		(AND (NUMBERP LOC) (SETQ ITEM (CONTENTS LOC)))
		(SETQ ACFLG (CAR ITEM))
		(COND ((EQ ACFLG 'SPECIAL) (SETQ ACFLG (CADR ITEM))))
		(SETQ MODE (COND ((AND (EQ ACFLG 'QUOTE) 
				       (MEMQ (SETQ MODE (TYPEP (CADR ITEM)))
					     '(FIXNUM FLONUM)))
				  MODE)
				 ((VARMODE ACFLG))
				 (FIXSW 'FIXNUM)
				 (FLOSW 'FLONUM)))
		(COND ((AND (NOT (ATOM LOC)) (EQ (CAR LOC) 'SPECIAL))
		       (SETQ ITEM (CDR LOC))))
		(FIND AC)
		(CPUSH1 AC () LOC)
		(OUT2 '(MOVE) AC LOC))
	       ('T (SETQ NLARG LOC)
		   (COND ((AND #%(ACLOCP-N NLARG) (OR (NOT ACFLG) (= NLARG AC)))
			  (AND RMFLG (REMOVE RMFLG))		;REMOVEs, if so requested
			  (CPUSH LOC)
			  (RETURN LOC)))
		   (SETQ ITEM (CONTENTS LOC))
		   (AND #%(NUMPDLP-N NLARG) (SETQ MODE (GETMODE LOC)))	;A NUMPDL loc
		   (COND (ACFLG (FIND AC) 
				(SETQ ACFLG (EQ (CPUSH1 AC () LOC) 'PUSH)))
			 ('T (AND (ZEROP (SETQ AC (FREENUMAC1))) 
				  (SETQ ACFLG 'T)
				  (SETQ AC (FREENUMAC0)))))
		   (AND ACFLG 						;Signifies a "PUSH" done
			MODE 						; and that loc is a NUMPDL
			(EQ MODE (GETMODE0 AC 'T 'T))			; so which PDL was pushed?
			(SETQ LOC (ILOC0 ITEM MODE)))
		   (COND ((AND (OR (= LOC #%(FLP0)) (= LOC #%(FXP0)))	;Loc is top slot of a NUMPDL
			       (NOT (DVP LOC)))				; and can be popped
			  (OPOP AC MODE))
			 ('T (AND (NULL MODE) 				;If loc be NUMPDLP, then MODE
				  (SETQ MODE (GETMODE0 LOC 'T () )))	; will already have been set
			     (OUT1 'MOVE AC LOC)))))			;  non-null
	 (CONT AC (COND ((OR (NULL (CDR ITEM)) (EQ (CDR ITEM) 'DUP) (EQUAL (CDR ITEM) CNT))
			      (CONS (CAR ITEM) 'DUP))
			     ((OR (NUMBERP (CDR ITEM)) (EQ (CAR ITEM) 'QUOTE)) ITEM)
			     ((NCONS (CAR ITEM)))))
	      (SETMODE AC MODE)
	      (AND RMFLG (REMOVE RMFLG))		;REMOVEs, if so requested
	      (RETURN AC)))



(DEFUN LOADINREGAC (X FUN LOC)
; Place a quantity X in some regular accumulator, removeing from LDLST
; "FUN" is advice or heuristic as to which acc is preferable, 
;  and can be "FRACB", "()", "FREACB", or some specific accumulator number.
; LOC is current location of X; () => look it up again
	 (AND (NULL LOC) (SETQ LOC #%(ILOCF X)))
	 (COND (#%(REGACP LOC) (REMOVEB X) (CPUSH LOC))
	       ((NOT (ZEROP (SETQ LOC (COND ((EQ FUN 'FRACB) (FRACB)) 
					    ((OR (NULL FUN) (EQ FUN 'FREACB)) 
					      #%(FREACB))
					    ((EQ FUN 'FRAC5) (FRAC5))
					    (#%(REGACP FUN)  FUN)
					    ('T 0)))))
		(LOADAC X LOC () ))
	      ('T (SETQ LOC 0)))
	 LOC)


(DEFUN LOADINSOMENUMAC (ITEM) (LOADINNUMAC ITEM 0 () 'REMOVEB))


(DEFUN MAKEPDLNUM (ITEM AC)
    (PROG (LOC MODE NEWLOC TEM)
	  (CPUSH AC) 
	  (SETQ LOC #%(ILOCNUM ITEM AC)) 
	  (REMOVEB ITEM) 
	  (SETQ MODE (GETMODE LOC) NEWLOC LOC TEM () )
	  (COND (#%(ACLOCP LOC)
		  (SETQ TEM (CONTENTS LOC))
		  (CPUSH LOC)
		  (CONT LOC () )
		  (SETQ NEWLOC (ILOC0 ITEM MODE))
		  (SETQ ITEM TEM)
		  (COND ((NULL NEWLOC) (OPUSH LOC ITEM MODE)
				       (SETQ NEWLOC (CONVNUMLOC 0 MODE))))
		  (CONT LOC (CONS (CAR ITEM) 'DUP))))
	  (OUT1 'MOVEI AC NEWLOC)
	  (COND ((NOT (VARBP (CAR ITEM))) 
		 (AND (NOT (CLMEMBER (CAR ITEM) MODE MODELIST 'EQ))
		      (PUSH (CONS (CAR ITEM) MODE) MODELIST))
		 (PUTPROP (CAR ITEM) 'T 'UNSAFEP)))
	  (CONT AC (CONS (CAR ITEM) 'DUP))))


(COMMENT MAKESAFE and MAKESURE)

(DEFUN MAKESAFE (ITEM LOC RMFLG)
 (COND 
  ((COND ((NOT (REGADP LOC))
 	  #%(LET ((FL () ))
		((LAMBDA (TAKENAC1) (SETQ FL (CPUSH 1)))  #%(NUMVALAC))
		(LOADINNUMAC ITEM 
			     #%(NUMVALAC) 
			     (COND ((OR (NOT (EQ FL 'PUSH)) 
					(NOT (CAR REGACS))  			;Check (CONTENTS 1)
					(NOT (EQ (GETMODE LOC) (GETMODE0 1 () 'T))))
				    LOC))
			     'REMOVEB)
		(OUTPUT (COND ((EQ (OR (CAR ACSMODE) (GETMODE0 #%(NUMVALAC) 'T 'T))
				   'FIXNUM)
			       '(JSP T FXCONS))
			      ('(JSP T FLCONS))))
		#%(NULLIFY-NUMAC))
	  'T)
	 ((AND (NUMBERP LOC)
	       (NOT (AND (= LOC 1) 
			 (NOT ATPL)
			 (EQ (CAR LOUT) 'JSP)
			 (MEMQ (CADDR LOUT) 
			       '(FXCONS FLCONS PDLNMK))))
	       (UNSAFEP (CONTENTS LOC)))
	  (LOADAC ITEM 1 () )
	  (OUTPUT '(JSP T PDLNMK))
	  'T))
   (RPLACA REGACS (SETQ ITEM (LIST (GENSYM))))   
   ;The RPLACA is essentially a quick way to do (CONT 1 MUMBLE)
   (AND (NULL RMFLG) (PUSH ITEM LDLST)) )
  ((EQ RMFLG 'REMOVEB) (REMOVEB ITEM))
  ((EQ RMFLG 'REMOVE) (REMOVE ITEM)))
 ITEM)

(DEFUN MAKESURE (UNSAFEP VAR SPFL ARG LARG)
;;; VAR will never be local numvar - checked by caller
     (AND (COND ((NULL (SETQ UNSAFEP (P2UNSAFEP UNSAFEP)))		;Possibly a numquantity 
		  (COND ((REGADP LARG) () )		      
			((NULL (SETQ LARG (ILOC0 ARG () ))) 
			 (SETQ LARG #%(ILOCF ARG))
			 'T)
			((REGADP LARG) () )
			((NULL (P2UNSAFEP VAR)))))			;Here, SPFL is null
		((COND  (SPFL)
			((ATOM UNSAFEP) (LLTV/.UNSAFE UNSAFEP))	;Cons for X in (SETQ X Y) if both are
			((MEMQ PROGN UNSAFEP))			; some weird screw case
			((DO Y UNSAFEP (CDR Y) (NULL Y)		;LLTVs, and Y is unsafe
			   (AND (LLTV/.UNSAFE (CAR Y)) (RETURN 'T))))))
		((NOT (P2UNSAFEP VAR))))			;No cons for local var already unsafe
	  (MAKESAFE ARG LARG ())))

(DEFUN LLTV/.UNSAFE (X)			;Used only by safety-checking function above
    (AND (SYMBOLP X)			;Returns non-() iff X is a local NOTYPE variable
	 (NOT (SPECIALP X))		;   which also happens to be unsafe
	 (NULL (VARMODE X))
	 (MEMQ X UNSFLST)))

(COMMENT NX2LAST OPUSH OPOP etc)

(DEFUN NX2LAST (X)
   (COND ((NULL (CDR X)) () )					;Remember, cdr[()]=()
	 ((PROG (ZZ)
	     A  (SETQ ZZ X)
		(AND (NULL (CDR (SETQ X (CDR X)))) (RETURN (CAR ZZ)))
		(GO A)))))



(DEFUN OJRST (TAG DONT) (OUTJ0 'JRST 0 TAG 'T DONT))

(DEFUN OPUSH (X ITEM MODE) 
	(PROG (TEMP OP)
	      (SETQ OP (COND ((AND (NULL (SETQ TEMP (REGADP X))) (NULL MODE))
				   (BARF X |PUSH P 7 lossage|))
			     ((AND TEMP MODE) '(PUSH))
			     ('PUSH)))
	      (COND ((AND MODE (NOT (ATOM X)) (NOT (ATOM (CAR X)))
			  (EQ (CADR X) 'QUOTE) (NUMBERP (SETQ TEMP (CADAR X))))
		     (SETQ X (LIST '% TEMP))
		     (SETQ OP 'PUSH)))
	      (OUT2 OP 
		    (COND ((EQ MODE 'FIXNUM) (PUSH ITEM FXPDL) 'FXP)
			  ((NULL MODE) (PUSH ITEM REGPDL) 'P)
			  ('T (PUSH ITEM FLPDL) 'FLP))
		    X)))

(DEFUN OSPB (TLOC VAR)
    ((LAMBDA (N)
	#%(OUTFS N TLOC (LIST 'SPECIAL VAR)))
      (COND ((NULL TLOC) (SETQ TLOC 0))
	    ((PLUSP TLOC) 0)
	    ('T (SETQ TLOC (ABS TLOC)) 7_33.))))


(DEFUN OPOP (X MODE)
    ((LAMBDA (PDL)
	(COND ((AND (NOT ATPL)
		    (EQ (CAR LOUT) 'PUSH)
		    (EQ (CADR LOUT) PDL)
		    #%(ACLOCP (CADDR LOUT)))
	       ((LAMBDA (AC)
		    (SETQ LOUT (SETQ ATPL 'FOO))
		    (COND ((AND (SIGNP G X) (= X AC)) (WARN AC |PUSHPOP - OPOP|))
			  ('T (OUT1 'MOVEM AC X))))
		  (CADDR LOUT)))
	    ('T (OUT1 'POP PDL X)))
	(AND MODE 
	     #%(ACLOCP X)
	     (SETMODE X MODE))
	(SHRINKPDL 1 MODE))
      #%(PDLAC MODE)))


(COMMENT OUTFUNCALL COUTPUT etc)

(DEFUN OUTFUNCALL (OP AC FUN)
	 ((LAMBDA (PROP NUMFL)
		(COND ((AND (OR #%(NUMACP-N ARGNO) PNOB EFFS)
			    (OR (SETQ PROP (GET FUN 'NUMFUN))
				(DO Z MODELIST (CDR Z) (NULL Z)
				    (AND (EQ FUN (CAAAR Z))
					 (NULL (CDAAR Z))
					 (RETURN (SETQ PROP (CDAR Z))))))
			    (CADR PROP))
		       (SETQ NUMFL 'T)
		       (SETQ OP (CDR (ASSQ OP '((CALL . NCALL) (JCALL . NJCALL)
					        (CALLF . NCALLF) (JCALLF . NJCALF)))))))
		#%(OUTFS OP AC (LIST 'QUOTE FUN))
		(COND (NUMFL (SETMODE #%(NUMVALAC) (CADR PROP))
			     #%(NUMVALAC))
		      (1)))
	    () () ))


(DEFUN OUTG (X) 
   (OUTPUT (CAR X))
   (DO X (CDR X) (CDR X) (NULL X)
	   #%(OUTFS 'CAIN 1 (LIST 'QUOTE  (CAAR X)))
	   #%(OUTFS 'JUMPA 0 (CDAR X)))
   (OUTPUT '(PUSHJ P *UDT))
   #%(OUTFS 'JUMPA 0 (CAR X))
   (|Oh, FOO!|))



(DEFUN ICOUTPUT (X)
    (COND (FASLPUSH (PUSH X LAPLL))
	  ((ATOM X)
	   (COND ((EQ X GOFOO) (TERPRI))	;Signal for CR
		 ((EQ X NULFU) (PRINC '| |))	;Signal for SPACE
		 ((NULL X) (PRINC '|() |))
		 ('T (PRIN1 X))))
	  ((HUNKP X)
	   '#%(LET* ((EP (AND (EQ (CAR X) '**SELF-EVAL**)
			      (*:EXTENDP X)))
		     (VP (AND EP (GET 'VECTOR 'VERSION) (VECTORP X))))
		(COND ((AND EP (NOT VP))
		       (SEND X 'PRINT () 0 'T))
		      ('T (PROG (N I)
				(DECLARE (FIXNUM N I))
				(SETQ I 0)
				(SETQ N (COND 
					  (VP (PRINC '|#(|) (VECTOR-LENGTH X))
					  ('T (PRINC '|(|)  (HUNKSIZE X) )))
			      A (ICOUTPUT (CXR I X))
				(COND ((= I N) 
				        (COND (VP (PRINC '|/)|))
					      ('T (PRINC '| . )|)))
					(RETURN () )))
				(ICOUTPUT (COND (VP (VREF X I)) 
						('T (CXR I X))))
				(COND (VP (PRINC '| |))
				      ('T (PRINC '| . |)))
				(GO A))))))
	  ((AND (EQ (CAR X) 'QUOTE) (NULL (CDDR X))) 
	   (COND ((AND (NOT (ATOM (CADR X))) 
		       (OR (EQ (CAADR X) SQUID) (EQ (CDADR X) GOFOO)))
		  ((LAMBDA (Y)
			   (COND ((OR (EQ (CDR Y) GOFOO)
				      (NOT (EQ (CADR Y) MAKUNBOUND)))
				  (PRINC '/(EVAL/ )
				  (ICOUTPUT (CAADR X))
				  (PRINC '/)))
				 ('T (PRINC 'MAKUNBOUND))))
			(CADR X)))
		 ('T (PRINC '|'|) (ICOUTPUT (CADR X)))))
	  ('T (PROG ()
		    (PRINC '|(|)
		  A (ICOUTPUT (CAR X))
		    (COND ((NULL (SETQ X (CDR X))))	
			  ((ATOM X) (PRINC '| . |) (PRIN1 X))
			  ('T (PRINC '| |) (GO A)))
		    (PRINC '|)|) )))
    () )





(DEFUN OUTPUT (X) 
    ((LAMBDA (ATP)
	     (COND ((COND ((AND ATP (NOT (EQ X 'FOO))))
			  ((NOT ATPL) (NOT (EQ (CAR LOUT) 'JRST)))
			  ((NOT (EQ LOUT 'FOO)))
			  ((NOT ATPL1) (NOT (EQ (CAR LOUT1) 'JRST)))
			  (T))
		    (COND ((EQ LOUT 'FOO) (SETQ LOUT X ATPL ATP))
			  ('T (COND ((EQ LOUT1 'FOO))
				    ((PROG2 (AND (NOT ATPL1) 
						 (EQ (CAR LOUT1) 'JUMPA) 
						 (SETQ LOUT1 (CONS 'JRST (CDR LOUT1))))
					    () ))
				    (FASLPUSH (PUSH LOUT1 LAPLL))
				    ('T (ICOUTPUT GOFOO) 
					(ICOUTPUT LOUT1)
					(ICOUTPUT NULFU)))
			      (SETQ LOUT1 LOUT ATPL1 ATPL LOUT X ATPL ATP))))))
	(ATOM X)))

(DEFUN OUT1 (A B C)
 #%(LET (Z X ACP (N@P (ATOM A)) (TPC (TYPEP C)) (N 0))
;;; A might be "MOVE"  or "(MOVE)", the latter meaning MOVE indirect
;;; B is usually 0 - 17, or maybe "P", or "T"
;;; C is  N 			for slotloc N
;;;	  "FOO" 		for symbol FOO
;;;	  "(SPECIAL FOO)"	for special variable FOO
;;;	  "(QUOTE FUN)"		for direct reference to "FUN", as in (CALL 1 'FUN)
;;;	  "((QUOTE THING))"	for loading quotified stuff, 
;;;				    as in (MOVEI 1 'THING), or (PUSH P (% 0 0 'THING))
      (SETQ ACP (AND (EQ TPC 'FIXNUM) (PLUSP (SETQ N C))))
      (SETQ X 
	    (COND ((OR (MEMQ TPC '(FIXNUM SYMBOL)) (SYMBOLP (CAR C)))
		   (COND ((AND N@P ACP #%(REGACP-N N) (SETQ X (GET A 'IMMED)))
			  (SETQ N@P () ) X)
			 (N@P A)
			 ((CAR A))))
		 ('T (SETQ C (CAR C))		;C WAS "((QUOTE THING))"
		     (COND ((SETQ X (COND (N@P (GET A 'IMMED)) ((CDR A))))
			    (SETQ N@P 'T)
			    X)
			   ('T (SETQ C (LIST '% 0 0 C))
			       (COND (N@P A) ((CAR A))))))))
      (SETQ Z (COND ((AND ACP (NOT N@P)) (SETQ N@P 'T) (LIST 0 C))
		    ((AND (NOT ACP) (EQ TPC 'FIXNUM))
		     (COND (#%(NUMPDLP-N N) 
			     (COND (#%(FLPDLP-N N) (CONS (- C #%(FLP0)) '(FLP)))
				   ('T (CONS (- C #%(FXP0)) '(FXP)))))
			   ((CONS C '(P)))))
		    ((NCONS C))))
	(SETQ Z (CONS B (COND (N@P Z) ((CONS '@ Z)))))
	(OUTPUT (CONS X Z))))



(DEFUN OUT3 (OP ACX AD) 
   (COND ((REGADP AD) (OUT2   OP     ACX AD)) 
	 ('T	      (OUT1 (CAR OP) ACX AD))))


(DEFUN OUT2 (OP ACX AD)
   (COND ((OR (ATOM OP) (ATOM AD) (ATOM (CAR AD)) (NOT (EQ (CAAR AD) 'QUOTE)))
	  (OUT1 OP ACX AD))
	 (#%(LET* ((NEWAD (CADAR AD)) (TYPE (TYPEP NEWAD)) NEWOP (II 0))
		 (COND ((COND ((AND (EQ TYPE 'FIXNUM)
				    (SETQ NEWOP (GET (CAR OP) 'IMMED))
				    (COND ((AND (NOT (< (SETQ II NEWAD) 0)) 
						(< II 1_18.)))
					  ((AND (LESSP -1_18. II 0) 
						(SETQ NEWOP (GET NEWOP 'MINUS)))
					   (SETQ NEWAD (- II))
					   'T)))
			        ;Fixnum with 18. bits or less
			       'T)
			      ((AND (EQ TYPE 'FLONUM)
				    (ZEROP (BOOLE 1 (SETQ II (LSH NEWAD 0))
						    262143.))	;777777[8]
				    (SETQ NEWOP (GET (CAR OP) 'FLOATI)))
			         ;Exponent/Mantissa combined are 18. bits or less
			       (COND ((AND (> II 0) 
					   (MEMQ NEWOP '(FDVRI FMPRI))
					   (ZEROP (BOOLE 1 II 67108863.)))	;377777777[8]
				        ;Floating-point power of two.
				      (SETQ II (- (LSH II -27.) 129.))
				      (AND (EQ NEWOP 'FDVRI) (SETQ II (- II)))
				      (SETQ NEWOP 'FSC))
				     ('T (SETQ II (LSH II -18.))))
			       (SETQ NEWAD II)
			       'T)
			      ((MEMQ TYPE '(FIXNUM FLONUM))
			       (SETQ NEWOP (CAR OP) NEWAD (LIST '% NEWAD))
			       'T)
			      ((AND (EQ TYPE 'LIST) (EQ (CAR NEWAD) SQUID))
			       (SETQ NEWOP (CAR OP))))
			#%(OUTFS NEWOP ACX NEWAD))
		       ('T (OUT1 OP ACX AD)))))))


(DEFUN OUT3FIELDS (Z Y X) (OUTPUT (LIST X Y Z)))
(DEFUN OUT4FIELDS (V Z Y X) (OUTPUT (LIST X Y Z V)))
(DEFUN OUT5FIELDS (W V Z Y X) (OUTPUT (LIST X Y Z V W)))



(DEFUN OUTJ (INST LARG TAG)
	(AND (NOT #%(ACLOCP LARG)) (BARF LARG |Not ac - OUTJ|))
	(CLEARVARS)
	(OUTJ0 INST LARG TAG () LARG))


(COMMENT OUTJ0)

(DEFUN OUTJ0 (INST LARG TAG JSP DONT)
    (PROG (TEM SVSLT YAGPV AC LARGSLOTP NLARG)
	  (SETQ LARGSLOTP (NUMBERP LARG))
	  (SETQ AC 0 NLARG (COND (LARGSLOTP LARG) (0)))
	  (AND (AND (NOT JSP) LARGSLOTP #%(PDLLOCP-N NLARG))
	       (SETQ SVSLT (CONTENTS LARG)))
	  (AND (RSTD TAG 
		     (COND (#%(ACLOCP DONT) DONT) (0))
		     (COND ((AND LARGSLOTP #%(ACLOCP-N NLARG)) LARG) (0)))
	       SVSLT
	       (SETQ LARG #%(ILOCF SVSLT))
	       (SETQ NLARG (COND ((SETQ LARGSLOTP (NUMBERP LARG)) LARG) (0))))
	  (COND ((AND (NOT JSP)
		      (COND ((NOT LARGSLOTP) 
			     (EQ (CAR LARG) 'SPECIAL))
			    ((AND SVSLT (NULL (CDR SVSLT)) #%(REGACP-N NLARG))
			     (OR (VARBP (CAR SVSLT))
				 (ASSQ (CAR SVSLT) SPLDLST))))
		      (SETQ YAGPV (MEMQ () REGACS)))
		 (SETQ AC (- #%(NACS+1) (LENGTH YAGPV)))
		 (CONT AC (CONS (COND ((NOT (ATOM LARG)) (CADR LARG)) 
				      ((CAR SVSLT))) 'DUP))))
	  (COND ((OR JSP (NOT LARGSLOTP) (NOT #%(ACLOCP-N NLARG)))  () )
		(#%(REGACP-N NLARG)
		 (AND (SETQ TEM (ASSQ INST '((JUMPE () ((QUOTE () )))
					     (JUMPN ((QUOTE () )) () ))))
		      (CADDR TEM)
		      (SETQ SVSLT (CONTENTS LARG))
		      (RPLACA SLOTX (CAADDR TEM))))
		(#%(NUMACP-N NLARG) 
		  (AND (MEMQ INST '(SOJN SOJE)) 
		       (RPLACA SLOTX () ))))
	  ;Set up the acs of the level of TAG, assuming that the jump is taken
	  ; but dont worry about prog tags
	  (AND  (SETQ YAGPV (GET TAG 'LEVEL))
		(ACMRG  (CAR YAGPV) (CADR YAGPV) (CADDR YAGPV) REGACS NUMACS ACSMODE
			(COND ((NOT (GET TAG 'USED)) (PUTPROP TAG 'T 'USED)))))
	  (COND (TEM (FIND LARG)					;Jump falls through, 
		     (COND ((CADR TEM) (RPLACA SLOTX (CAADR TEM)))	; so reset SLOTLIST accordingly
			   (SVSLT (RPLACA SLOTX SVSLT)))))
	  (SETQ DONT (COND (JSP () )
			   ((AND LARGSLOTP #%(ACLOCP-N NLARG))
			    (COND ((AND #%(NUMACP-N NLARG) 
					(NOT (ATOM INST))
					(MEMQ (CAR INST) '(TRNN TRNE TLNN TLNE)))
				   (OUT1 (GET (CAR INST) 'CONV) LARG (CDR INST))
				   (SETQ INST 'JUMPA))))
			   ('T (OUT1 (COND ((EQ INST 'JUMPE) 'SKIPN) ('SKIPE)) AC LARG)
			       (SETQ INST 'JUMPA))))
	  #%(OUTFS INST 
		 (COND (DONT 0) (LARG)) 
		 (COND ((AND (AND (NOT ATPL) JSP (EQ INST 'JRST))
			     (SETQ TEM (GET TAG 'PREVI)) 
			     (EQUAL LOUT TEM))
			(SETQ LOUT (SETQ ATPL 'FOO))
			(LIST TAG -1))
		       (TAG)))
	  (RETURN LARG)))			;  RETURN LOC OF ARG

(COMMENT OUTTAG)

(DEFUN OUTTAG (X) 
;	OUTTAG returns non-null iff TAG was used
	(COND ((AND X (GET X 'USED)) 
		(CLEANUPSPL () )
		(CLEARVARS)
		((LAMBDA (LL) 
		    (COND (LL (RESTORE LL)
			      (ACSMRGL LL))
		  	  ('T #%(CLEARALLACS))))
		 (LEVEL X))
		(OUTTAG0 X)
		X)))


(DEFUN OUTTAG0 (X)
    ((LAMBDA (V)
	     (COND ((AND (AND (NOT ATPL) (NOT ATPL1))		;	JUMPX AC,TG 
			 (MEMQ (CAR LOUT) '(JRST JUMPA))
			 (EQ X (CADDR LOUT1))			;	JRST 0 TG1
			 (NOT (EQ (CAR LOUT1) 'JUMPA))		;TG: . . .
			 (SETQ V (GET (CAR LOUT1) 'CONV)))	;Turns into JUMP[X'] AC,TG1
		    (SETQ LOUT (LIST V (CADR LOUT1) (CADDR LOUT)))
		    (SETQ LOUT1 (SETQ ATPL1 'FOO))))		;ATPL is already ()
	     (COND ((NOT ATPL)
			(AND (NOT (EQ (CAR LOUT) 'JUMPA))
			     (OR (EQ (CAR LOUT) 'JRST)		;	JUMPX AC,TG
				 (GET (CAR LOUT) 'CONV))	;TG: .. .
			     (EQ X (CADDR LOUT))		;Turns into just  TG:
			     (SETQ LOUT (SETQ ATPL 'FOO))))
		   ((NOT (EQ LOUT 'FOO))			;	JUMPX AC,TG
		    (AND (NOT ATPL1)				;TG1:
			 (NOT (EQ (CAR LOUT1) 'JUMPA))
			 (OR (EQ (CAR LOUT1) 'JRST)		;TG: . . .
			     (GET (CAR LOUT1) 'CONV))		;Becomes merely the two tags
			(EQ X (CADDR LOUT1))
			(SETQ LOUT1 (SETQ ATPL1 'FOO)))))
	     (OUTPUT X))
	() ))
;;; Note how the lines (EQ X (CADDR LOUT1)) and (EQ X (CADDR LOUT))
;;; Prevent taking clauses like (SKIPN 0 FOO) or (CAIE AC FOO)
;;; JUMPx and JUMP[x'] are invertible conditions


(DEFUN PROGHACSET (SPFL EXP)
    ;Special hac for (LAMBDA (SVAR1) (PROG (SVAR2) :))   or for 
    ;  (LAMBDA (SVAR1) (COMMENT :) : (PROG (SVAR2) : )) for only one call to SPECBIND
   (COND ((AND SPFL 
	       (COND ((EQ (CAR EXP) 'PROG))
		     ((AND  (EQ (CAR EXP) PROGN)
			    (EQ (CAADR EXP) 'PROG)
			    (NULL (GCDR (FUNCTION 
					 (LAMBDA (Z) 
					   (NOT (MEMQ (CAAR Z) '(COMMENT DECLARE)))))
					(CDDR EXP))))
		      (SETQ EXP (CADR EXP))
		      'T))
	       (GCDR (FUNCTION (LAMBDA (Z) (SPECIALP (CAR Z)))) (CADDR (CDDDR EXP))))
	  (SETQ SFLG 'T)
	  () )
	 ('T (SETQ SFLG () ) SPFL)))

(DEFUN QNILP (X) (AND (NOT (ATOM X)) (EQ (CAR X) 'QUOTE) (NULL (CADR X))))

(DEFUN Q0P+0P (X) 
    (AND (NOT (ATOM X)) (EQ (CAR X) 'QUOTE) (SETQ X (CADR X)))
    #%(LET ((TYPE (TYPEP X)))
	  (COND ((AND (EQ TYPE 'FLONUM) (= X 0.0)) 0.0) 
		((AND (EQ TYPE 'FIXNUM) (= X 0)) 0))) )

(DEFUN Q1P+1P-1P (X) 
    (AND (NOT (ATOM X)) (EQ (CAR X) 'QUOTE) (SETQ X (CADR X)))
    #%(LET ((TYPE (TYPEP X)))
	     (COND ((EQ TYPE 'FLONUM) 
		    (COND ((= X 1.0) 1.0) ((= X -1.0) -1.0)))
		   ((EQ TYPE 'FIXNUM) 
		    (COND ((= X 1) 1) ((= X -1) -1))))))

(DEFUN QNP (X) (AND (NOT (ATOM X)) (EQ (CAR X) 'QUOTE) (NUMBERP (CADR X))))

(DEFUN REGADP (X)
       #%(LET ((N 0))
	     (OR (NOT (NUMBERP X))					;(SPECIAL A), ((QUOTE 5))
		 #%(REGADP-N (SETQ N X)))))		;NUMWORLD

(DEFUN REMOVEB (X) (OR (NULL X) (REMOVE X) (REMOVS X)))

(DEFUN REMOVE (X) 	;REMOVE does not take CARCDR'ings off the SPLDLST
   (AND X (SETQ LDLST (DELQ X LDLST))  
	  (COND ((EQ (CAR X) 'QUOTE))
		((NUMBERP (CDR X)) 
		 (REMOVS X)
		 'T))))

(DEFUN REMOVS (X) 
   (AND (AND X SPLDLST)
	(SETQ X (CLMEMBER (CAR X) 
			  (CDR X)
			  SPLDLST 
			  (COND ((NUMBERP (CDR X)) '=) ('ASSQ))))
       (RPLACA X () )))

(COMMENT REMPROPL and String-processing)

;;;  (PNAMECONC 'ABC 'D '(C  D) '(ASDF DDD ER) 'FOO) => ABCDCDASDFDDDER
;;;     for each single-character symbol, a number in the ASCII range is ok.
(DEFUN PNAMECONC N 
    (PROG (ARGL LL)
	  (SETQ ARGL (LISTIFY N))
	A (SETQ LL (MAPCAN '(LAMBDA (A) (COND ((ATOM A) (PCGAV A))
					      ((MAPCAN 'PCGAV A))))
			   ARGL))
	  (COND ((MEMQ  () LL) (SETQ ARGL (ERROR ARGL 
						 '|Bad argument list - PNAMECONC| 
						 'WRNG-TYPE-ARG))
			       (GO A)))
	  (RETURN (MAKNAM LL))))

(DEFUN PCGAV (A)	;Get the ASCII values for a list of chars
    ((LAMBDA (TP)
	     (COND ((AND (EQ TP 'SYMBOL) (NOT (= (GETCHARN A 2) 0)))  (EXPLODEN A))
		   ((LIST (COND ((EQ TP 'SYMBOL) (GETCHARN A 1))
				((AND (EQ TP 'FIXNUM) (< 1 128.) (NOT (< A 0)))  A)
				('T () ))))))
	(TYPEP A)))


(DEFUN REMPROPL (FL LL) (MAPC '(LAMBDA (X) (REMPROP X FL)) LL))

(DEFUN LREMPROP (NAME L) 
    (PROG (V FL)
     A    (SETQ V (GETL NAME L))
	  (AND (NULL V) (RETURN FL))
	  (COND ((REMPROP NAME (CAR V)) (SETQ FL 'T)))
	  (GO A)))


(COMMENT MSOUT)

(DEFUN MSOUT (W MSG FLAG L1 L2)
 (DECLARE (SPECIAL UNFASLSIGNIF))
 (AND (NOT (AND (EQ FLAG 'WARN) (SYMBOLP W) (GET W 'SKIP-WARNING))) 
      #%(LET ((OUTFILES CMSGFILES) (TERPRI 'T) (PRINLEVEL L1) (PRINLENGTH L2)
	     (BASE 10.) (*NOPOINT () ) (^R 'T) (^W 'T) (II 0))
	    (AND (COND ((OR YESWARNTTY (EQ FLAG 'BARF) (NULL OUTFILES)))
		       ((MEMQ FLAG '(DATA ERRFL)) (NULL GAG-ERRBREAKS)))
		 (NOT (MEMQ TYO OUTFILES))	;^W shuts off "T" output
		 (PUSH TYO OUTFILES))
	    (AND (OR UNFASLCOMMENTS (NULL YESWARNTTY))
		 (SETQ UNFASLSIGNIF 'T))
	    (SETQ II (+ (COND ((MEMQ FLAG '(ERRFL DATA BARF))
			       (PRINC '|/(COMMENT **ERROR**  |)
			       20.)
			      ('T (PRINC '|/(COMMENT ****  |) 15.))
			(FLATSIZE W)
			1 
			(FLATC MSG)))
	    (PRIN1 W) 
	    (PRINC '| |) 
	    (AND (> II 71.) (PRINC '|//	/	|))
	    (PRINC MSG)					
	    (COND ((AND TOPFN (NOT (EQ FLAG 'FASL)))
		   (PRINC '| in function |)
		   (PRIN1 TOPFN)))
	    (PRINC '/))
	    (COND ((MEMQ FLAG '(ERRFL DATA))
		   (COND (QUIT-ON-ERROR 
			  (MAPC 'FORCE-OUTPUT CMSGFILES)
			  (MAPC 'FORCE-OUTPUT OUTFILES)
			  (QUIT))
			 ((NULL GAG-ERRBREAKS)
			  (PRINC '|/; DATA ERROR - TO PROCEED TYPE $P |)
			  (MSOUT-BRK W COBARRAY CREADTABLE 'DATA)))
		   (COND ((EQ FLAG 'ERRFL) (SETQ ERRFL 'T))
			 ('T  (ERR 'DATA))))
		  ((EQ FLAG 'BARF) 
		   (PRINC '|/;%%%%%%%% COMPILER ERROR - CALL JONL %%%%%%%% |)
		   (MSOUT-BRK W SOBARRAY SREADTABLE 'BARF)
		   (ERR 'BARF))))))

(DEFUN MSOUT-BRK (ARGS OBARRAY READTABLE FL)
    (MAPC 'FORCE-OUTPUT CMSGFILES)
    (MAPC 'FORCE-OUTPUT OUTFILES)
    (LET ((MSGFILES '(T)) (BASE 10.) (IBASE 10.) *NOPOINT READ ^R)
      (cond ((not LINEMODEP) (*BREAK 'T FL))
	    ((unwind-protect 
	       (prog2 (sstatus LINMO () )
		      (*BREAK 'T FL))
	       (sstatus LINMO T))))) 
    (TERPRI))

(COMMENT RESTORE and RST etc)


(DEFUN RESTORE (X)
    (AND X 
	(DO ((MODES '(() FIXNUM FLONUM) (CDR MODES))	;Cycles thru pdls REGPDL FXPDL FLPDL
	     (RSL)
	     (XS (CDDDR X) (CDR XS)))
	    ((OR (NULL MODES) (NULL XS)) RSL)
   	(PROG (RSTNO N PDLTP P X MODE)
	      (SETQ X (CAR XS) MODE (CAR MODES))
	      (SETQ P #%(PDLAC MODE) PDLTP #%(PDLGET MODE))
	      (AND (MINUSP (SETQ RSTNO (DIFFERENCE (LENGTH PDLTP) (LENGTH X))))
		   (BARF (LIST X '/ (SLOTLISTCOPY) ) |RESTORE lossage|))
	  A1	(AND (ZEROP RSTNO) (RETURN RSL))  
		(SETQ N 0 RSL 'T)
	  A2    (COND ((NOT (OR (NULL PDLTP) 
				(= N RSTNO)
				(DVP1 PDLTP (CONVNUMLOC 0 MODE))))
			(SETQ N (ADD1 N))
			(SETQ PDLTP (CDR PDLTP))
			(COND ((EQ MODE 'FIXNUM) (SETQ FXPDL PDLTP))
			      ((NULL MODE) (SETQ REGPDL PDLTP))
			     ('T (SETQ FLPDL PDLTP)))
			(GO A2)))
;		So subtract off as much as possible and pop top PDL slot
;		  to some safe slot.  For safe slots try first those with the
;		  same item name  on the back of the PDL, and then those
;		  of the acs; as a last resort try FREEAC.

		(SETQ RSTNO (DIFFERENCE RSTNO N))
;	 	(AND (EQ LOUT 'FOO) (SETQ LOUT LOUT1) (SETQ LOUT1 'FOO))
;		Above instruction had to be removed because of JRST followed FOO case
		(AND (NOT ATPL)
		     (EQ (CAR LOUT) 'SUB) 			;This converts two restores of
		     (EQ (CADR LOUT) P)				;SUB P,[N,,N] - SUB P,[M,,M]
		     (SETQ N (PLUS N (CADDDR (CADDR LOUT)))	; into one
			   LOUT (SETQ ATPL 'FOO)))		;SUB P,[N+M,,N+M]
		(AND (NOT ATPL1)
		     (EQ (CAR LOUT1) 'SUB)
		     (EQ (CADR LOUT1) P)
		     (OR (EQ LOUT 'FOO) 
			 (AND (NOT ATPL) 
			      (OR (EQ (CAR LOUT) 'SUB)
				  (EQ (CAR LOUT) 'PUSHJ)
				  (AND (EQ (CAR LOUT) 'JSP) 
				       (NOT (EQ (CADDR LOUT) 'PDLNMK))))))
		     (SETQ N (PLUS N (CADDDR (CADDR LOUT1)))
			   LOUT1 LOUT ATPL1 ATPL LOUT (SETQ ATPL 'FOO)))
		(AND (COND ((ZEROP N) () )
			   ((AND (NOT ATPL) (EQ (CAR LOUT) 'PUSH))
			    (AND (EQ (CADR LOUT) P) 
				 (PROG2 (SETQ LOUT (SETQ ATPL 'FOO)) 'T)))
			   ((AND (AND (NOT ATPL) (NOT ATPL1))
				 (EQ (CAR LOUT1) 'PUSH)
				 (EQ (CAR LOUT) 'SUB))
			    (AND (EQ (CADR LOUT1) P)
				 (PROG2 (SETQ LOUT1 (SETQ ATPL1 'FOO)) 'T))))
		     (SETQ N (1- N)))
		(AND (NOT (ZEROP N)) #%(OUTFS 'SUB P (LIST '% 0 0 N N)))
		(AND (ZEROP RSTNO) (RETURN RSL))
		((LAMBDA (N BESTCNT BESTLOC FL TEM)
		       (COND ((AND (SETQ TEM (VARBP (CAR FL))) (NOT (EQ TEM 'SPECIAL)))	;localvarp
			      (DO ((L (FIND N) (CDR L)) (V X (CDR V))) 
				  ((NULL V))
				(COND ((NULL (CAR V)))
			 	      ((NOT (EQ (CAAR V) (CAAR PDLTP))))
				      ((NULL (CDAR V)) 
				       (COND ((AND (EQ (CAAR L) (CAAR V))
						   (EQ (CDAR L) 'OHOME)))
					     ((NOT (DVP1 L N)))
					     ((NOT (AND (MEMQ (CDAR L) '(() OHOME))
							(VARBP (CAAR L))))
					      (SETQ BESTLOC (FREACB))
					      (OUT1 'MOVE BESTLOC N)
					      (CONT BESTLOC (CONTENTS N))
					      (CONT N () ))
					     ((BARF N |Someones in my home - RESTORE |)))
				       (RETURN (SETQ BESTCNT (SETQ BESTLOC N))))
				      ((OR (AND (SETQ FL (NUMBERP (CDAR V)))
					        (GREATERP (CDAR V) BESTCNT))
				           (ZEROP BESTCNT)) 
				       (SETQ BESTLOC N) 
				       (AND FL (SETQ BESTCNT (CDAR V)))))
			       (SETQ N (SUB1 N))))
			      (#%(ACLOCP (SETQ FL (ILOC0 FL MODE)))
			       (SETQ BESTLOC FL BESTCNT 1)))
			(SETQ FL (CAR PDLTP))
			(COND ((AND (ZEROP BESTCNT)
				    (NOT ATPL)
				    (EQ (CAR LOUT) 'PUSH)
				    #%(ACLOCP (SETQ BESTLOC (CADDR LOUT))))
			       (WARN (LIST BESTLOC N) |PUSHPOP - RESTORE|)
			       (SETQ LOUT (SETQ ATPL 'FOO))
			       (SHRINKPDL 1 MODE))
			      ('T (AND (ZEROP BESTCNT)
				       (COND ((NULL MODE) (SETQ BESTLOC (FREACB))) 
					     ((NOT (ZEROP (SETQ BESTLOC (FREENUMAC1)))))
					     ('T (BARF () |Not enuf NUMACS - RESTORE|))))
				 (CONT BESTLOC FL)
				 (OPOP BESTLOC MODE))))
		    (CONVNUMLOC (MINUS RSTNO) MODE) 0 0 (CAR PDLTP) () )
		(SETQ RSTNO (SUB1 RSTNO))
		(SETQ PDLTP (COND ((EQ MODE 'FIXNUM) FXPDL)
				  ((NULL MODE) REGPDL)
				  (FLPDL)))
		(GO A1)))))



(DEFUN RST (X) 
;	Restore slotlist to level of a tag,
;	Valuable stuff should not be in accs
;	If value is non-null, it must be a slotlist level
	(AND X (RESTORE (LEVEL X))))

(DEFUN RSTD (TAG A1 A2)					;Restore, but dont take the 
  (DECLARE (FIXNUM A1 A2))
  (PROG (SV1 SV2 RSL)					; accumulators A1 and A2 for temps
	(COND ((ZEROP A1)
		(AND (ZEROP A2) (RETURN (RST TAG)))
		(SETQ A1 A2 A2 0)))
	(AND (= A1 A2) (SETQ A2 0))
	(SETQ SV1 (CONTENTS A1))
	(RPLACA SLOTX '(NIL . TAKEN))
	(COND ((NOT (ZEROP A2))
		(SETQ SV2 (CONTENTS A2))
		(RPLACA SLOTX '(NIL . TAKEN))))
	(SETQ RSL (RST TAG))
	(CONT A1 SV1)
	(AND (NOT (ZEROP A2)) (CONT A2 SV2))
	(RETURN RSL)))

(DEFUN RETURNTAG NIL 
    ((LAMBDA (TAG) 
	     #%(OUTFS 'MOVEI 'T TAG)
	     (OPUSH 'T '(NIL . TAKEN) () ) 
	     TAG) 
      (GENSYM)))



(DEFUN SETMODE (AC MODE)  (RPLACA #%(ACSMODESLOT AC) MODE))


(DEFUN SHRINKPDL (N MODE)
    (CASEQ MODE
	   (NIL (SETQ REGPDL #%(NCDR REGPDL N)))
	   (FIXNUM (SETQ FXPDL #%(NCDR FXPDL N)))
	   (FLONUM (SETQ FLPDL #%(NCDR FLPDL N)))))

(DEFUN STRETCHPDL (N MODE)
    (DO ((I N (1- I)) (L () (CONS '(NIL . TAKEN) L)))
	((ZEROP I)
	 (CASEQ MODE 
		(NIL (SETQ REGPDL (NCONC L REGPDL)))
		(FIXNUM (SETQ FXPDL (NCONC L FXPDL)))
		(FLONUM (SETQ FLPDL (NCONC L FLPDL)))))))


(DEFUN SLOTLISTCOPY ()
	(LIST (APPEND REGACS () ) (APPEND NUMACS () ) (APPEND ACSMODE () )
	      (APPEND REGPDL () ) (APPEND FXPDL () ) (APPEND FLPDL () )))

(DEFUN SLOTLISTSET (L)
    (SETQ REGACS (CAR L) NUMACS (CADR L) ACSMODE (CAR (SETQ L (CDDR L)))
	  REGPDL (CADR L) FXPDL (CAR (SETQ L (CDDR L))) FLPDL (CADR L)))

;;; Returns "(SPECIAL x)"  if "x" is indeed SPECIAL
  (DEFUN SPECIALP (X) 
	 (COND ((GET X 'SPECIAL))
	       ((NULL SPECVARS) () )
	       ((CDR (ASSQ X SPECVARS)))))

(DEFUN STRTIBLE (X)
   (OR (NULL X)
       ((LAMBDA (TYP)
		(COND ((MEMQ TYP '(SYMBOL FLONUM)))
		      ((AND (EQ TYP 'LIST)
			    (NOT (EQ (CAR X) SQUID))
			    (STRTIBLE (CAR X))
			    (STRTIBLE (CDR X))))
		      ((HUNKP X) 
		       (AND (EQ (CXR 1 X) '**SELF-EVAL**)
			    (STATUS FEATURE STRING)
			    (STRINGP X)))))
	   (TYPEP X))))


(COMMENT UNSAFEP and VARBP)


(DEFUN UNSAFEP (X)						;Called only on the output of "COMP"
     (COND ((NULL X) () )					;Must coordinate this function with "VARBP"
	   ((EQ (SETQ X (CAR X)) 'QUOTE) () )
	   (((LAMBDA (Y)
		     (COND ((NULL Y) () )			;??
			   ((EQ (CAR Y) 'UNSAFEP))		;Unsafe GENSYM
			   ((EQ (CAR Y) 'OHOME)			;AHA! Local var
			    (COND ((MEMQ X UNSFLST))		;LLTV unsafe
				  ((VARMODE X))))		;NUMVAR unsafe
			   ('T () )))				;Specs are safe
	         (GETL X '(SPECIAL OHOME UNSAFEP))))))


(DEFUN VARBP (X)
    (COND ((NULL X) () )
	  ((NOT (SYMBOLP X)) (BARF X |Not a SYMBOL - VARBP|))
	  (((LAMBDA (Y)
		    (COND ((NULL Y) (COND ((ASSQ X SPECVARS) 'SPECIAL)))
			  ((EQ (CAR Y) 'SPECIAL) 'SPECIAL)
			  ('T)))
	    (GETL X '(SPECIAL OHOME))) )))

(DEFUN VARMODE (VAR) 
    (COND ((NULL VAR) () )
	  ((CDR (COND ((ASSQ VAR MODELIST)) ('( () ) ))))
	  ((GET VAR 'NUMVAR))))


;;; End of PHASE2 auxilliary functions


(COMMENT FUNCTIONS TO RUN DECLARATIONS)



;;; Switch Declarations functions

(DEFUN ASSEMBLE (X) (SETQ ASSEMBLE X))			;;; A switch
(DEFUN CLOSED (X) (SETQ CLOSED X))			;;; C switch
(DEFUN DISOWNED (X) (SETQ DISOWNED X))			;;; D switch
(DEFUN EXPR-HASH (X) (SETQ EXPR-HASH X))		;;; E switch
(DEFUN FASL (X) (SETQ FASL X))				;;; F switch
(DEFUN FIXSW (X) (SETQ FIXSW X))			;;; + switch
(DEFUN FLOSW (X) (SETQ FLOSW X))			;;; $ switch
(DEFUN GAG-ERRBREAKS (X) (SETQ GAG-ERRBREAKS X))	;;; G switch
(DEFUN HUNK2-TO-CONS (X) (SETQ HUNK2-TO-CONS X))	;;; 2 switch
(DEFUN EXPAND-OUT-MACROS (X) (SETQ EXPAND-OUT-MACROS X));;; H switch
(DEFUN MACROS (X) (SETQ MACROS X))			;;; M switch
(DEFUN MAPEX (X) (SETQ MAPEX X))			;;; X switch 
(DEFUN MUZZLED (X) (SETQ MUZZLED X))			;;; W switch
(DEFUN NOLAP (X) (SETQ NOLAP X))			;;; K switch 
(DEFUN ARRAYOPEN (X) (SETQ ARRAYOPEN X))		;;; O switch
(DEFUN SPECIALS (X) (SETQ SPECIALS X))			;;; S switch
(DEFUN SYMBOLS (X) (SETQ SYMBOLS X))			;;; Z switch 
(DEFUN UNFASLCOMMENTS (X) (SETQ UNFASLCOMMENTS X))	;;; U switch 


;;; Standard Declarations defined as FEXPRs

(DEFUN *EXPR FEXPR (X) (*DECLARE X '*EXPR))
(DEFUN *FEXPR FEXPR (X) (*DECLARE X '*FEXPR))
(DEFUN *LEXPR FEXPR (X) (*DECLARE X '*LEXPR))
(DEFUN **LEXPR FEXPR (X) (*DECLARE X '*LEXPR) (*DECLARE X '**LEXPR))
(DEFUN /@DEFINE FEXPR (X) X 'T)
(DEFUN EOC-EVAL FEXPR (X) (SETQ EOC-EVAL (APPEND EOC-EVAL X () )))
(DEFUN FIXNUM FEXPR (X) (NUMPROP X 'FIXNUM))
(DEFUN FLONUM FEXPR (X) (NUMPROP X 'FLONUM))
(DEFUN GENPREFIX FEXPR (X) (SETQ GENPREFIX (EXPLODEC (CAR X))))
(DEFUN IGNORE FEXPR (X) (*DECLARE X 'IGNORE))
(DEFUN NOTYPE FEXPR (DECLS) (NUMPROP DECLS () ))
(DEFUN OWN-SYMBOL FEXPR (L)
      (COND ((NOT (MEMQ COMPILER-STATE '(MAKLAP DECLARE))) 
	     (PDERR (CONS 'OWN-SYMBOL L) 
		    |OWN-SYMBOL can only be done in top level declarations|))
	    (((LAMBDA (OBARRAY)
		      (MAPCAN '(LAMBDA (X)
				   (COND ((NOT (SYMBOLP X)) () )
					 ('T (REMOB X)
					     (PUTPROP (INTERN (COPYSYMBOL X () ))
						      'T 
						      'OWN-SYMBOL)
					     (LIST X))))
			      L))
	      COBARRAY))))
(DEFUN RECOMPL FEXPR (X) (SETQ RECOMPL (APPEND X RECOMPL)))
(DEFUN SPECIAL FEXPR (X) (*DECLARE X 'SPECIAL))
(DEFUN UNSPECIAL FEXPR (L) 
      (COND ((EQ COMPILER-STATE 'COMPILE) 
	     (PDERR (CONS 'UNSPECIAL L) |Cant locally unspecialize|))
	    ('T (REMPROPL 'SPECIAL L))))



(DEFUN *DECLARE (L PROP)
    (MAPC 
      '(LAMBDA (X) 
	   (COND ((AND (NOT (MEMQ PROP '(SPECIAL IGNORE))) (SYSP X))
		  (COND ((OR (|carcdrp/|| X)
			     (AND (GET X 'FSUBR) (NOT (EQ X 'EDIT)) (NOT (EQ PROP '*FEXPR)))
			     (AND (GET X 'ACS)		;First char is * or .
				  ((LAMBDA (N) (OR (= N 52) (= N 56)))
				   (GETCHARN X 1)))
			     (GET X 'JSP)
			     (MEMQ X '(LIST RPLACA RPLACD SET EQ EQUAL NULL NOT 
					    ZEROP PROG2 PROGN ASSQ MEMQ BOOLE PRINC PRIN1 PRINT 
					    READ READCH TYI TYO PLIST PUTPROP REMPROP)))
			 (DBARF (CONS PROP L) |This declaration wont work|))
			('T (LREMPROP X '(ACS ARITHP CONTAGIOUS
					      FUNTYP-INFO NOTNUMP NUMBERP
					      P1BOOL1ABLE ))
			    (PUTPROP X 'T PROP))))
		 ((EQ PROP 'SPECIAL) 
		   (AND (EQ COMPILER-STATE 'COMPILE)
			(ASSQ X RNL) (SETQ X (CDR (ASSQ X RNL))))
		   #%(let ((newprop `(SPECIAL ,x)))
		       (or (equal (get x 'SPECIAL) newprop)
			   (putprop x newprop 'SPECIAL))))
		 ('T (PUTPROP X 'T PROP)))
	   () )
	 L))

(DEFUN NUMPROP (DECLS TYP)
  (PROG (TEMP PROP TOPFN)
	(MAPC '(LAMBDA (DECL)
		     (COND ((ATOM DECL)
			    (AND (EQ COMPILER-STATE 'COMPILE) 
				 (SETQ TEMP (ASSQ DECL RNL))
				 (SETQ DECL (CDR TEMP)))
			    (COND ((NULL TYP) (REMPROP DECL 'NUMVAR))
				  ((AND (SETQ TEMP (GET DECL 'NUMVAR))
					(NOT (EQUAL TEMP TYP)))
				    (WARN DECL |Variable being redeclared|))
				  ('T (PUTPROP DECL TYP 'NUMVAR))))
			   ('T (SETQ PROP (NMPSUBST (CDR DECL) TYP))
			       (AND (SETQ TEMP (GET (CAR DECL) 'NUMFUN))
				    (NOT (EQUAL PROP TEMP))
				    (WARN DECL |Function being redeclared|))
			       (PUTPROP (CAR DECL) PROP 'NUMFUN))))
	    DECLS)))

(DEFUN NMPSUBST (LIST TYP)
   (AND (DO X LIST (CDR X) (NULL X)
	    (AND (NOT (MEMQ (CAR X) '(() FIXNUM FLONUM))) (RETURN 'T)))
	(SETQ LIST 
	      (MAPCAR '(LAMBDA (X)
			(COND ((MEMQ X '(FIXNUM FLONUM)) X)
			      ((MEMQ X '(() NOTYPE T ?)) () )
			      (((LAMBDA (TYP) 
					(COND ((MEMQ TYP '(FIXNUM FLONUM)) TYP)
					      ('T (PDERR (LIST X '-IN- LIST)
							|Incorrect arg for number declaration|)
						 () )))
				   (TYPEP X)))))
		      LIST)))
   (CONS (REVERSE LIST) (CONS (COND ((NOT (MEMQ TYP '(FIXNUM FLONUM))) () )
				    (TYP))
			      LIST)))



(DEFUN ARRAY* FEXPR (LIST) (MAPC 'AR*1 LIST))

(DEFUN AR*1 (X)
 (PROG (TYPE NAME TEM PROP N Y)
     (AND (OR (ATOM X) 
	      (NOT (MEMQ (CAR X) '(FIXNUM FLONUM NOTYPE T ? () ))))
	 (GO BF))
     (SETQ TYPE (COND ((MEMQ (CAR X) '(FIXNUM FLONUM)) (CAR X))
		      ('NOTYPE))
	   Y (CDR X))
  A  (AND (NULL Y) (RETURN () ))
     (COND ((NOT (ATOM (CAR Y)))
	    (SETQ PROP (CAR Y) NAME (CAR PROP) N (LENGTH (CDR PROP)))
	    (AND (DO Z (CDR PROP) (CDR Z) (NULL Z) 
		     (AND (NOT (FIXP (CAR Z))) (RETURN T)))
		 (DO Z (CDR (SETQ PROP (APPEND PROP () ))) (CDR Z) (NULL Z)
		   (COND ((FIXP (CAR Z)))
			 ((AND (QNP (CAR Z)) (FIXP (CADAR Z)))
			  (RPLACA Z (CADAR Z)))
			 ('T (RPLACA Z () ))))))
	   ((NOT (NUMBERP (CADR Y))) (GO BF))
	   ('T (SETQ NAME (CAR Y) N (CADR Y) PROP (LIST NAME) Y (CDR Y))))
     (AND (OR (LREMPROP NAME '(*EXPR *LEXPR *FEXPR))
	      (AND (REMPROP NAME 'NUMFUN) (NOT (GETL NAME '(*ARRAY)))))
	  (WARN NAME |Function being re-declared as an array|))
     (COND ((AND (SETQ TEM (GET NAME '*ARRAY)) (NOT (EQUAL TEM PROP))) 
	    #%(WARN NAME |array re-declared|)
	    (REMPROP NAME 'NUMFUN)))
     (PUTPROP NAME PROP '*ARRAY)
     (PUTPROP NAME
	      (CONS () (CONS (COND ((NOT (EQ TYPE 'NOTYPE)) TYPE))
			     #%(NCDR '(FIXNUM FIXNUM FIXNUM FIXNUM FIXNUM FIXNUM FIXNUM)
				    (- 7 N))))
	     'NUMFUN)
     (SETQ Y (CDR Y))
     (GO A)
   BF (PDERR X |Bad array declaration|)))




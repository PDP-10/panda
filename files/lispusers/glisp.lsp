(FILECREATED " 2-DEC-82 14:39:50" {DSK}GLISP.LSP;110 208089 

      changes to:  (FNS GLCOMPOPEN GLCONST? GLDOFOR GLPREDICATE GLTHE GLMACLISPTRANSFM GLCOMPPROP 
			GLCOMPPROPL GLINIT GLDESCENDANTP GLDOMSG GLGETSUPERS)
		   (VARS GLISPCOMS)

      previous date: "18-NOV-82 16:55:12" {DSK}GLISP.LSP;105)


(PRETTYCOMPRINT GLISPCOMS)

(RPAQQ GLISPCOMS [(FNS A AN GL-A-AN? GLABSTRACTFN? GLADDINSTANCEFN GLADDRESULTTYPE GLADDSTR GLADJ 
		       GLAINTERPRETER GLAMBDATRAN GLANALYZEGLISP GLANDFN GLANYCARCDR? GLATOMSTRFN 
		       GLATMSTR? GLBUILDALIST GLBUILDCONS GLBUILDLIST GLBUILDNOT GLBUILDPROPLIST 
		       GLBUILDRECORD GLBUILDSTR GLCARCDRRESULTTYPE GLCARCDRRESULTTYPEB GLCARCDR? GLCC 
		       GLCLASS GLCLASSMEMP GLCLASSP GLCLASSSEND GLCOMP GLCOMPABSTRACT GLCOMPCOMS 
		       GLCOMPILE GLCOMPILE? GLCOMPMSG GLCOMPOPEN GLCOMPPROP GLCOMPPROPL GLCONST? 
		       GLCONSTSTR? GLCONSTVAL GLCP GLDECL GLDECLDS GLDEFFNRESULTTYPES 
		       GLDEFFNRESULTTYPEFNS GLDEFPROP GLDEFSTR GLDEFSTRNAMES GLDEFSTRQ GLDEFUNITPKG 
		       GLDELDEF GLDESCENDANTP GLDOA GLDOCASE GLDOCOND GLDOEXPR GLDOFOR GLDOIF 
		       GLDOLAMBDA GLDOMAIN GLDOMSG GLDOPROG GLDOPROGN GLDOPROG1 GLDOREPEAT GLDORETURN 
		       GLDOSELECTQ GLDOSEND GLDOSETQ GLDOTHE GLDOTHOSE GLDOVARSETQ GLDOWHILE GLED 
		       GLEDS GLEQUALFN GLERR GLERROR GLEXPANDPROGN GLEXPENSIVE? GLFINDVARINCTX 
		       GLFRANZLISPTRANSFM GLGENCODE GLGETASSOC GLGETCONSTDEF GLGETD GLGETDB GLGETDEF 
		       GLGETFIELD GLGETFROMUNIT GLGETGLOBALDEF GLGETPAIRS GLGETPROP GLGETSTR 
		       GLGETSUPERS GLIDNAME GLIDTYPE GLINIT GLINSTANCEFN GLINTERLISPTRANSFM 
		       GLISPCONSTANTS GLISPGLOBALS GLISPOBJECTS GLLISPADJ GLLISPISA 
		       GLLISTRESULTTYPEFN GLLISTSTRFN GLMACLISPTRANSFM GLMAKEFORLOOP 
		       GLMAKEGLISPVERSION GLMAKESTR GLMAKEVTYPE GLMINUSFN GLMKATOM GLMKLABEL GLMKVAR 
		       GLMKVTYPE GLNCONCFN GLNEQUALFN GLNOTFN GLNTHRESULTTYPEFN GLOCCURS GLOKSTR? 
		       GLOPERAND GLOPERATOR? GLORFN GLP GLPARSEXPR GLPARSFLD GLPARSNFLD GLPLURAL 
		       GLPOPFN GLPREC GLPREDICATE GLPRETTYPRINTCONST GLPRETTYPRINTGLOBALS 
		       GLPRETTYPRINTSTRS GLPROGN GLPROPSTRFN GLPSLTRANSFM GLPURE GLPUSHEXPR GLPUSHFN 
		       GLPUTARITH GLPUTFN GLPUTPROPS GLPUTUPFN GLREDUCE GLREDUCEARITH GLREDUCEOP 
		       GLREMOVEFN GLRESGLOBAL GLRESULTTYPE GLSENDB GLSEPCLR GLSEPINIT GLSEPNXT 
		       GLSKIPCOMMENTS GLSTRFN GLSTRPROP GLSTRVAL GLSTRVALB GLSUBATOM GLSUBSTTYPE 
		       GLSUPERS GLTHE GLTHESPECS GLTRANSPARENTTYPES GLTRANSPB GLTRANSPROG 
		       GLUCILISPTRANSFM GLUNITOP GLUNIT? GLUNWRAP GLUNWRAPCOND GLUNWRAPLOG 
		       GLUNWRAPMAP GLUNWRAPPROG GLUNWRAPSELECTQ GLUPDATEVARTYPE GLUSERFN GLUSERFNB 
		       GLUSERGETARGS GLUSERSTROP GLVALUE GLVARTYPE GLXTRFN GLXTRTYPE GLXTRTYPEB 
		       GLXTRTYPEC SEND SENDPROP)
	(P (SETQ GLLISPDIALECT (QUOTE INTERLISP))
	   (GLINIT))
	(GLISPOBJECTS GLTYPE GLPROPENTRY)
	(ADDVARS (LAMBDASPLST GLAMBDA)
		 (LAMBDATRANFNS (GLAMBDA GLAMBDATRAN EXPR NIL)))
	(GLOBALVARS GLQUIETFLG GLSEPBITTBL GLUNITPKGS GLSEPMINUS GLTYPENAMES GLBREAKONERROR 
		    GLUSERSTRNAMES GLLASTFNCOMPILED GLLASTSTREDITED GLCAUTIOUSFLG GLLISPDIALECT 
		    GLBASICTYPES)
	(SPECVARS CONTEXT EXPR VALBUSY FAULTFN GLSEPATOM GLSEPPTR GLTOPCTX RESULTTYPE RESULT GLNATOM 
		  FIRST OPNDS OPERS GLEXPR DESLIST EXPRSTACK GLTYPESUBS GLPROGLST ADDISATYPE)
	(VARS GLTYPENAMES GLSPECIALFNS GLBASICTYPES)
	(FILES (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES)
	       LAMBDATRAN)
	(FILEPKGCOMS GLISPCONSTANTS GLISPGLOBALS GLISPOBJECTS)
	(DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS
		  (ADDVARS (NLAMA SENDPROP SEND GLISPOBJECTS GLISPGLOBALS GLISPCONSTANTS GLERR 
				  GLDEFSTRQ GLDEFSTRNAMES AN A)
			   (NLAML)
			   (LAMA])
(DEFINEQ

(A
  [NLAMBDA L                                                 (* edited: "18-NOV-82 11:47")
    (GLAINTERPRETER L])

(AN
  [NLAMBDA L                                                 (* edited: "18-NOV-82 11:47")
    (GLAINTERPRETER L])

(GL-A-AN?
  [LAMBDA (X)                                                (* edited: "29-OCT-81 14:25")
                                                             (* "GSN: " "20-Mar-81 10:34")
    (FMEMB X (QUOTE (A AN a an An])

(GLABSTRACTFN?
  [LAMBDA (FNNAME)                                           (* edited: "26-JUL-82 14:15")
                                                             (* Test whether FNNAME is an abstract function.)
    (PROG (DEFN)
          (RETURN (AND (SETQ DEFN (GETD FNNAME))
		       (LISTP DEFN)
		       (EQ (CAR DEFN)
			   (QUOTE MLAMBDA])

(GLADDINSTANCEFN
  [LAMBDA (FN ENTRY)                                         (* edited: "26-JUL-82 14:59")
                                                             (* Add an instance function entry for the abstract 
							     function whose name is FN.)
    (ADDPROP FN (QUOTE GLINSTANCEFNS)
	     ENTRY])

(GLADDRESULTTYPE
  [LAMBDA (SDES)                                             (* "GSN: " "25-Jan-81 18:17")
                                                             (* Add the type SDES to RESULTTYPE in GLCOMP)
    (COND
      ((NULL RESULTTYPE)
	(SETQ RESULTTYPE SDES))
      [(AND (LISTP RESULTTYPE)
	    (EQ (CAR RESULTTYPE)
		(QUOTE OR)))
	(COND
	  ((NOT (MEMBER SDES (CDR RESULTTYPE)))
	    (NCONC1 RESULTTYPE SDES]
      ((NOT (EQUAL SDES RESULTTYPE))
	(SETQ RESULTTYPE (LIST (QUOTE OR)
			       RESULTTYPE SDES])

(GLADDSTR
  [LAMBDA (ATM NAME STR CONTEXT)                             (* "GSN: " " 2-Jan-81 13:37")

          (* Add an entry to the current context for a variable ATM, whose NAME in context is given, and which has structure
	  STR. The entry is pushed onto the front of the list at the head of the context.)

                                                             (* edited: "30-Sep-80 18:04")
    (RPLACA CONTEXT (CONS (LIST ATM NAME STR)
			  (CAR CONTEXT])

(GLADJ
  [LAMBDA (SOURCE PROPERTY ADJWD)                            (* edited: "24-AUG-82 17:16")
                                                             (* edited: "17-Sep-81 13:58")
                                                             (* Compile code to test if SOURCE is PROPERTY.)
    (PROG (ADJL TRANS TMP FETCHCODE)
          (COND
	    [(EQ ADJWD (QUOTE ISASELF))
	      (COND
		((SETQ ADJL (GLSTRPROP PROPERTY (QUOTE ISA)
				       (QUOTE self)))
		  (GO A))
		(T (RETURN]
	    ((SETQ ADJL (GLSTRPROP (CADR SOURCE)
				   ADJWD PROPERTY))
	      (GO A)))                                       (* See if the adjective can be found in a TRANSPARENT 
							     substructure.)
          (SETQ TRANS (GLTRANSPARENTTYPES (CADR SOURCE)))
      B   (COND
	    ((NULL TRANS)
	      (RETURN))
	    ((SETQ TMP (GLADJ (LIST (QUOTE *GL*)
				    (GLXTRTYPE (CAR TRANS)))
			      PROPERTY ADJWD))
	      (SETQ FETCHCODE (GLSTRFN (CAR TRANS)
				       (CADR SOURCE)
				       NIL))
	      (GLSTRVAL TMP (CAR FETCHCODE))
	      (GLSTRVAL TMP (CAR SOURCE))
	      (RETURN TMP))
	    (T (SETQ TRANS (CDR TRANS))
	       (GO B)))
      A   (COND
	    ([AND (LISTP (CADR ADJL))
		  (MEMB (CAADR ADJL)
			(QUOTE (NOT Not not)))
		  (ATOM (CADADR ADJL))
		  (NULL (CDDADR ADJL))
		  (SETQ TMP (GLSTRPROP (CADR SOURCE)
				       ADJWD
				       (CADADR ADJL]
	      (SETQ ADJL TMP)
	      (SETQ NOTFLG (NOT NOTFLG))
	      (GO A)))
          (RETURN (GLCOMPMSG SOURCE ADJL NIL CONTEXT])

(GLAINTERPRETER
  [LAMBDA (L)                                                (* edited: "18-NOV-82 11:51")
    (PROG (CODE GLNATOM FAULTFN CONTEXT VALBUSY GLSEPATOM GLSEPPTR EXPRSTACK GLTOPCTX GLGLOBALVARS)
          (SETQ GLNATOM 0)
          (SETQ FAULTFN (QUOTE GLAINTERPRETER))
          (SETQ VALBUSY T)
          (SETQ GLSEPPTR 0)
          (SETQ CONTEXT (SETQ GLTOPCTX (LIST NIL)))
          (SETQ CODE (GLDOA (CONS (QUOTE A)
				  L)))
          (RETURN (EVAL (CAR CODE])

(GLAMBDATRAN
  [LAMBDA (GLEXPR)                                           (* edited: "26-JUL-82 15:13")
                                                             (* "GSN: " "21-Sep-81 16:19")
                                                             (* "GSN: " "30-Dec-80 14:36")

          (* This function is called when a GLAMBDA function is found by the interpreter. If the function definition is 
	  available on the property GLCOMPILED, that definition is returned; otherwise, GLCOMP is called to compile the 
	  function.)


    (PROG (NEWEXPR)
          (SETQ GLLASTFNCOMPILED FAULTFN)
          (SAVEDEF FAULTFN)
          (PUTPROP FAULTFN (QUOTE GLCOMPILED)
		   (SETQ NEWEXPR (GLCOMP FAULTFN GLEXPR NIL)))
          (PUTHASH (GETD FAULTFN)
		   NEWEXPR CLISPARRAY)
          (RETURN NEWEXPR])

(GLANALYZEGLISP
  [LAMBDA NIL                                                (* edited: " 2-JUN-82 15:33")
                                                             (* Analyze GLISP itself for use in converting to other 
							     LISP dialects.)
    (PROG (CALLEDFNS GLFNS GLALLFNS)
          (SETQ GLFNS (LDIFFERENCE (SETQ GLALLFNS (CDAR GLISPCOMS))
				   GLSPECIALFNS))
          [SETQ CALLEDFNS
	    (SORT (LDIFFERENCE (MASTERSCOPE (QUOTE (WHAT FNS NOT IN GLALLFNS ARE CALLED BY FNS IN 
							 GLFNS)))
			       (QUOTE (ATOM apply RPLACD CDDR SET SOME EQUAL NUMBERP CAR CADR CONS 
					    RPLACA LIST DECLARE NCONC]
          (MAPC CALLEDFNS (FUNCTION (LAMBDA (X)
		    (TERPRI)
		    (PRINT X)
		    (PRINT (MASTERSCOPE (SUBST X (QUOTE FN)
					       (QUOTE (WHAT FNS IN GLFNS CALL FN])

(GLANDFN
  [LAMBDA (LHS RHS)                                          (* edited: "30-APR-82 10:44")
                                                             (* "GSN: " " 8-Jan-81 17:04")
                                                             (* AND operator)
    (COND
      ((NULL LHS)
	RHS)
      ((NULL RHS)
	LHS)
      ((AND (LISTP (CAR LHS))
	    (EQ (CAAR LHS)
		(QUOTE AND))
	    (LISTP (CAR RHS))
	    (EQ (CAAR RHS)
		(QUOTE AND)))
	(LIST (APPEND (CAR LHS)
		      (CDAR RHS))
	      (CADR LHS)))
      ((AND (LISTP (CAR LHS))
	    (EQ (CAAR LHS)
		(QUOTE AND)))
	(LIST (APPEND (CAR LHS)
		      (LIST (CAR RHS)))
	      (CADR LHS)))
      ((AND (LISTP (CAR RHS))
	    (EQ (CAAR RHS)
		(QUOTE AND)))
	(LIST (CONS (QUOTE AND)
		    (CONS (CAR LHS)
			  (CDAR RHS)))
	      (CADR LHS)))
      ((GLDOMSG LHS (QUOTE AND)
		(LIST RHS)))
      ((GLUSERSTROP LHS (QUOTE AND)
		    RHS))
      (T (LIST (LIST (QUOTE AND)
		     (CAR LHS)
		     (CAR RHS))
	       (CADR RHS])

(GLANYCARCDR?
  [LAMBDA (ATM)                                              (* edited: "19-MAY-82 13:54")

          (* Test if ATM is the name of any CAR/CDR combination. If so, the value is a list of the intervening letters in 
	  reverse order.)


    (PROG (RES N NMAX TMP)
          (OR (AND (EQ (NTHCHAR ATM 1)
		       (QUOTE C))
		   (EQ (NTHCHAR ATM -1)
		       (QUOTE R)))
	      (RETURN))
          (SETQ NMAX (SUB1 (NCHARS ATM)))
          (SETQ N 2)
      A   (COND
	    ((IGREATERP N NMAX)
	      (RETURN RES))
	    ((OR (EQ (SETQ TMP (NTHCHAR ATM N))
		     (QUOTE D))
		 (EQ TMP (QUOTE A)))
	      (SETQ RES (CONS TMP RES))
	      (SETQ N (ADD1 N))
	      (GO A))
	    (T (RETURN])

(GLATOMSTRFN
  [LAMBDA (IND DES DESLIST)                                  (* edited: "26-OCT-82 15:26")
                                                             (* Try to get indicator IND from an ATOM structure.)
    (PROG (TMP)
          (RETURN (OR (AND (SETQ TMP (ASSOC (QUOTE PROPLIST)
					    (CDR DES)))
			   (GLPROPSTRFN IND TMP DESLIST T))
		      (AND (SETQ TMP (ASSOC (QUOTE BINDING)
					    (CDR DES)))
			   (GLSTRVALB IND (CADR TMP)
				      (QUOTE (EVAL *GL*])

(GLATMSTR?
  [LAMBDA (STR)                                              (* edited: "16-DEC-81 18:08")
                                                             (* "GSN: " "14-Sep-81 12:45")
    (PROG (TMP)
          (COND
	    ((OR (AND (CDR STR)
		      (NLISTP (CADR STR)))
		 (AND (CDDR STR)
		      (NLISTP (CADDR STR)))
		 (CDDDR STR))
	      (RETURN)))
          [COND
	    ((SETQ TMP (ASSOC (QUOTE BINDING)
			      (CDR STR)))
	      (COND
		([OR (CDDR TMP)
		     (NULL (GLOKSTR? (CADR TMP]
		  (RETURN]
          [COND
	    ((SETQ TMP (ASSOC (QUOTE PROPLIST)
			      (CDR STR)))
	      (RETURN (EVERY (CDR TMP)
			     (FUNCTION (LAMBDA (X)
				 (AND (ATOM (CAR X))
				      (GLOKSTR? (CADR X]
          (RETURN T])

(GLBUILDALIST
  [LAMBDA (ALIST PREVLST)                                    (* edited: "24-AUG-82 17:21")
                                                             (* edited: "15-Sep-81 13:24")
                                                             (* edited: "14-Sep-81 12:25")
                                                             (* edited: "13-Aug-81 13:34")
    (PROG (LIS TMP1 TMP2)
      A   [COND
	    ((NULL ALIST)
	      (RETURN (AND LIS (GLBUILDLIST LIS NIL]
          (SETQ TMP1 (pop ALIST))
          [COND
	    ((SETQ TMP2 (GLBUILDSTR TMP1 PAIRLIST PREVLST))
	      (SETQ LIS (NCONC1 LIS (GLBUILDCONS (KWOTE (CAR TMP1))
						 TMP2 T]
          (GO A])

(GLBUILDCONS
  [LAMBDA (X Y OPTFLG)                                       (* edited: "10-JUN-82 14:41")
                                                             (* edited: "15-Sep-81 13:09")
                                                             (* Generate code to build a CONS structure.)
    (COND
      ((NULL Y)
	(GLBUILDLIST (LIST X)
		     OPTFLG))
      ((AND (LISTP Y)
	    (EQ (CAR Y)
		(QUOTE LIST)))
	(GLBUILDLIST (CONS X (CDR Y))
		     OPTFLG))
      [(AND OPTFLG (GLCONST? X)
	    (GLCONST? Y))
	(LIST (QUOTE QUOTE)
	      (CONS (GLCONSTVAL X)
		    (GLCONSTVAL Y]
      [(AND OPTFLG (GLCONSTSTR? X)
	    (GLCONSTSTR? Y))
	(LIST (QUOTE COPY)
	      (LIST (QUOTE QUOTE)
		    (CONS (GLCONSTVAL X)
			  (GLCONSTVAL Y]
      (T (LIST (QUOTE CONS)
	       X Y])

(GLBUILDLIST
  [LAMBDA (LST OPTFLG)                                       (* edited: " 4-JUN-82 13:22")
                                                             (* Build a LIST structure, possibly doing compile-time 
							     constant folding.)
    (COND
      [(EVERY LST (FUNCTION GLCONST?))
	(COND
	  [OPTFLG (LIST (QUOTE QUOTE)
			(MAPCAR LST (FUNCTION GLCONSTVAL]
	  (T (GLGENCODE (LIST (QUOTE APPEND)
			      (LIST (QUOTE QUOTE)
				    (MAPCAR LST (FUNCTION GLCONSTVAL]
      [(EVERY LST (FUNCTION GLCONSTSTR?))
	(GLGENCODE (LIST (QUOTE COPY)
			 (LIST (QUOTE QUOTE)
			       (MAPCAR LST (FUNCTION GLCONSTVAL]
      (T (CONS (QUOTE LIST)
	       LST])

(GLBUILDNOT
  [LAMBDA (CODE)                                             (* edited: "19-OCT-82 15:05")
                                                             (* Build code to do (NOT CODE), doing compile-time 
							     folding if possible.)
    (PROG (TMP)
          (COND
	    [(GLCONST? CODE)
	      (RETURN (NOT (GLCONSTVAL CODE]
	    ((NLISTP CODE)
	      (RETURN (LIST (QUOTE NOT)
			    CODE)))
	    ((EQ (CAR CODE)
		 (QUOTE NOT))
	      (RETURN (CADR CODE)))
	    ((NOT (ATOM (CAR CODE)))
	      (RETURN))
	    [(SETQ TMP (FASSOC (CAR CODE)
			       (SELECTQ GLLISPDIALECT
					[INTERLISP (QUOTE ((LISTP NLISTP)
							    (EQ NEQ)
							    (NEQ EQ)
							    (IGREATERP ILEQ)
							    (ILEQ IGREATERP)
							    (ILESSP IGEQ)
							    (IGEQ ILESSP)
							    (GREATERP LEQ)
							    (LEQ GREATERP)
							    (LESSP GEQ)
							    (GEQ LESSP]
					[(MACLISP FRANZLISP)
					  (QUOTE ((> <=)
						   (< >=)
						   (<= >)
						   (>= <]
					[PSL (QUOTE ((EQ NE)
						      (NE EQ)
						      (LEQ GREATERP)
						      (GEQ LESSP]
					NIL)))
	      (RETURN (CONS (CADR TMP)
			    (CDR CODE]
	    (T (RETURN (LIST (QUOTE NOT)
			     CODE])

(GLBUILDPROPLIST
  [LAMBDA (PLIST PREVLST)                                    (* edited: "26-OCT-82 16:02")
    (PROG (LIS TMP1 TMP2)
      A   [COND
	    ((NULL PLIST)
	      (RETURN (AND LIS (GLBUILDLIST LIS NIL]
          (SETQ TMP1 (pop PLIST))
          [COND
	    ((SETQ TMP2 (GLBUILDSTR TMP1 PAIRLIST PREVLST))
	      (SETQ LIS (NCONC LIS (LIST (KWOTE (CAR TMP1))
					 TMP2]
          (GO A])

(GLBUILDRECORD
  [LAMBDA (STR PAIRLIST PREVLST)                             (* edited: "12-NOV-82 11:26")
                                                             (* Build a RECORD structure.)
    (PROG (TEMP ITEMS RECORDNAME)
          [COND
	    ((ATOM (CADR STR))
	      (SETQ RECORDNAME (CADR STR))
	      (SETQ ITEMS (CDDR STR)))
	    (T (SETQ ITEMS (CDR STR]
          [COND
	    ((EQ (CAR STR)
		 (QUOTE OBJECT))
	      (SETQ ITEMS (CONS (QUOTE (CLASS ATOM))
				ITEMS]
          (RETURN (SELECTQ GLLISPDIALECT
			   [INTERLISP (COND
					[RECORDNAME
					  (CONS (QUOTE create)
						(CONS RECORDNAME
						      (MAPCONC ITEMS
							       (FUNCTION (LAMBDA (X)
								   (AND (SETQ TEMP
									  (GLBUILDSTR X PAIRLIST 
										      PREVLST))
									(LIST (CAR X)
									      (QUOTE _)
									      TEMP]
					(T (GLBUILDLIST [MAPCAR ITEMS (FUNCTION (LAMBDA (X)
								    (GLBUILDSTR X PAIRLIST PREVLST]
							NIL]
			   (FRANZLISP (LIST (QUOTE MAKHUNK)
					    (GLBUILDLIST [MAPCAR ITEMS (FUNCTION (LAMBDA (X)
								     (GLBUILDSTR X PAIRLIST PREVLST]
							 T)))
			   (MACLISP [SETQ TEMP (MAPCAR ITEMS (FUNCTION (LAMBDA (X)
							   (GLBUILDSTR X PAIRLIST PREVLST]
				    (LIST (QUOTE MAKHUNK)
					  (GLBUILDLIST (NCONC1 (CDR TEMP)
							       (CAR TEMP))
						       T)))
			   [PSL (CONS (QUOTE Vector)
				      (MAPCAR ITEMS (FUNCTION (LAMBDA (X)
						  (GLBUILDSTR X PAIRLIST PREVLST]
			   (GLBUILDLIST [MAPCAR ITEMS (FUNCTION (LAMBDA (X)
						    (GLBUILDSTR X PAIRLIST PREVLST]
					NIL])

(GLBUILDSTR
  [LAMBDA (STR PAIRLIST PREVLST)                             (* edited: "11-NOV-82 12:01")
                                                             (* edited: " 5-Oct-81 13:23")
                                                             (* edited: "15-Sep-81 13:36")
                                                             (* edited: "14-Sep-81 13:00")
                                                             (* edited: "13-Aug-81 14:06")

          (* Generate code to build a structure according to the structure description STR. PAIRLIST is a list of elements 
	  of the form (SLOTNAME CODE TYPE) for each named slot to be filled in in the structure. (PREVLST is a list of 
	  structures of which this is a substructure, to prevent loops.))


    (DECLARE (SPECVARS PAIRLIST PROGG))
    (PROG (PROPLIS TEMP PROGG TMPCODE ATMSTR)
          [SETQ ATMSTR (QUOTE ((ATOM)
				(INTEGER . 0)
				(REAL . 0.0)
				(NUMBER . 0)
				(BOOLEAN)
				(NIL)
				(ANYTHING]
          (COND
	    ((NULL STR)
	      (RETURN))
	    [(ATOM STR)
	      (COND
		((SETQ TEMP (ASSOC STR ATMSTR))
		  (RETURN (CDR TEMP)))
		((MEMB STR PREVLST)
		  (RETURN))
		[(SETQ TEMP (GLGETSTR STR))
		  (RETURN (GLBUILDSTR TEMP NIL (CONS STR PREVLST]
		(T (RETURN]
	    ((NLISTP STR)
	      (GLERROR (QUOTE GLBUILDSTR)
		       (LIST "Illegal structure type encountered:" STR))
	      (RETURN)))
          (RETURN (SELECTQ (CAR STR)
			   (CONS (GLBUILDCONS (GLBUILDSTR (CADR STR)
							  PAIRLIST PREVLST)
					      (GLBUILDSTR (CADDR STR)
							  PAIRLIST PREVLST)
					      NIL))
			   (LIST (GLBUILDLIST [MAPCAR (CDR STR)
						      (FUNCTION (LAMBDA (X)
							  (GLBUILDSTR X PAIRLIST PREVLST]
					      NIL))
			   (LISTOBJECT (GLBUILDLIST [CONS (KWOTE (CAR PREVLST))
							  (MAPCAR (CDR STR)
								  (FUNCTION (LAMBDA (X)
								      (GLBUILDSTR X PAIRLIST PREVLST]
						    NIL))
			   (ALIST (GLBUILDALIST (CDR STR)
						PREVLST))
			   (PROPLIST (GLBUILDPROPLIST (CDR STR)
						      PREVLST))
			   (ATOM [SETQ PROGG (LIST (QUOTE PROG)
						   (LIST (QUOTE ATOMNAME))
						   (LIST (QUOTE SETQ)
							 (QUOTE ATOMNAME)
							 (COND
							   [(AND PREVLST (ATOM (CAR PREVLST)))
							     (LIST (QUOTE GLMKATOM)
								   (KWOTE (CAR PREVLST]
							   (T (LIST (QUOTE GENSYM]
				 [COND
				   ((SETQ TEMP (ASSOC (QUOTE BINDING)
						      STR))
				     (SETQ TMPCODE (GLBUILDSTR (CADR TEMP)
							       PAIRLIST PREVLST))
				     (NCONC1 PROGG (LIST (QUOTE SET)
							 (QUOTE ATOMNAME)
							 TMPCODE]
				 (COND
				   ((SETQ TEMP (ASSOC (QUOTE PROPLIST)
						      STR))
				     (SETQ PROPLIS (CDR TEMP))
				     (GLPUTPROPS PROPLIS PREVLST)))
				 [NCONC1 PROGG (COPY (QUOTE (RETURN ATOMNAME]
				 PROGG)
			   [ATOMOBJECT [SETQ PROGG (LIST (QUOTE PROG)
							 (LIST (QUOTE ATOMNAME))
							 (LIST (QUOTE SETQ)
							       (QUOTE ATOMNAME)
							       (COND
								 [(AND PREVLST (ATOM (CAR PREVLST)))
								   (LIST (QUOTE GLMKATOM)
									 (KWOTE (CAR PREVLST]
								 (T (LIST (QUOTE GENSYM]
				       [NCONC1 PROGG (GLGENCODE (LIST (QUOTE PUTPROP)
								      (QUOTE ATOMNAME)
								      (LIST (QUOTE QUOTE)
									    (QUOTE CLASS))
								      (KWOTE (CAR PREVLST]
				       (GLPUTPROPS (CDR STR)
						   PREVLST)
				       (NCONC1 PROGG (COPY (QUOTE (RETURN ATOMNAME]
			   [TRANSPARENT (AND (NOT (MEMB (CADR STR)
							PREVLST))
					     (SETQ TEMP (GLGETSTR (CADR STR)))
					     (GLBUILDSTR TEMP PAIRLIST (CONS (CADR STR)
									     PREVLST]
			   (LISTOF NIL)
			   (RECORD (GLBUILDRECORD STR PAIRLIST PREVLST))
			   (OBJECT (GLBUILDRECORD STR (CONS (LIST (QUOTE CLASS)
								  (KWOTE (CAR PREVLST))
								  (QUOTE ATOM))
							    PAIRLIST)
						  PREVLST))
			   (COND
			     [(ATOM (CAR STR))
			       (COND
				 ((SETQ TEMP (ASSOC (CAR STR)
						    PAIRLIST))
				   (CADR TEMP))
				 ((AND (ATOM (CADR STR))
				       (NOT (ASSOC (CADR STR)
						   ATMSTR)))
				   (GLBUILDSTR (CADR STR)
					       NIL PREVLST))
				 (T (GLBUILDSTR (CADR STR)
						PAIRLIST PREVLST]
			     (T NIL])

(GLCARCDRRESULTTYPE
  [LAMBDA (LST STR)                                          (* edited: "19-MAY-82 14:27")

          (* Find the result type for a CAR/CDR function applied to a structure whose description is STR.
	  LST is a list of A and D in application order.)


    (COND
      ((NULL LST)
	STR)
      ((NULL STR)
	NIL)
      ((ATOM STR)
	(GLCARCDRRESULTTYPE LST (GLGETSTR STR)))
      ((NLISTP STR)
	(ERROR))
      (T (GLCARCDRRESULTTYPEB LST (GLXTRTYPE STR])

(GLCARCDRRESULTTYPEB
  [LAMBDA (LST STR)                                          (* edited: "19-MAY-82 14:41")

          (* Find the result type for a CAR/CDR function applied to a structure whose description is STR.
	  LST is a list of A and D in application order.)


    (COND
      ((NULL STR)
	NIL)
      ((ATOM STR)
	(GLCARCDRRESULTTYPE LST STR))
      ((NLISTP STR)
	(ERROR))
      ((AND (ATOM (CAR STR))
	    (NOT (MEMB (CAR STR)
		       GLTYPENAMES))
	    (CDR STR)
	    (NULL (CDDR STR)))
	(GLCARCDRRESULTTYPE LST (CADR STR)))
      ((EQ (CAR LST)
	   (QUOTE A))
	(COND
	  ((OR (EQ (CAR STR)
		   (QUOTE LISTOF))
	       (EQ (CAR STR)
		   (QUOTE CONS))
	       (EQ (CAR STR)
		   (QUOTE LIST)))
	    (GLCARCDRRESULTTYPE (CDR LST)
				(CADR STR)))
	  (T NIL)))
      [(EQ (CAR LST)
	   (QUOTE D))
	(COND
	  ((EQ (CAR STR)
	       (QUOTE CONS))
	    (GLCARCDRRESULTTYPE (CDR LST)
				(CADDR STR)))
	  ((EQ (CAR STR)
	       (QUOTE LIST))
	    (COND
	      [(CDDR STR)
		(GLCARCDRRESULTTYPE (CDR LST)
				    (CONS (QUOTE LIST)
					  (CDDR STR]
	      (T NIL)))
	  ((EQ (CAR STR)
	       (QUOTE LISTOF))
	    (GLCARCDRRESULTTYPE (CDR LST)
				STR]
      (T (ERROR])

(GLCARCDR?
  [LAMBDA (X)                                                (* edited: "13-JAN-82 13:45")
                                                             (* Test if X is a CAR or CDR combination up to 3 long.)
    (FMEMB X (QUOTE (CAR CDR CAAR CADR CDAR CDDR CAAAR CAADR CADAR CDAAR CADDR CDADR CDDAR CDDDR])

(GLCC
  [LAMBDA (FN)                                               (* edited: " 5-OCT-82 15:24")
    (SETQ FN (OR FN GLLASTFNCOMPILED))
    (COND
      ((NOT (GLGETD FN))
	(PRIN1 FN)
	(PRIN1 " ?")
	(TERPRI))
      (T (GLCOMPILE FN])

(GLCLASS
  [LAMBDA (OBJ)                                              (* edited: "11-NOV-82 14:13")
                                                             (* Get the Class of object OBJ.)
    (PROG (CLASS)
          (RETURN (AND (SETQ CLASS (COND
			   ((ATOM OBJ)
			     (GETPROP OBJ (QUOTE CLASS)))
			   ((LISTP OBJ)
			     (CAR OBJ))
			   (T NIL)))
		       (GLCLASSP CLASS)
		       CLASS])

(GLCLASSMEMP
  [LAMBDA (OBJ CLASS)                                        (* edited: "11-NOV-82 11:23")
                                                             (* Test whether the object OBJ is a member of class 
							     CLASS.)
    (GLDESCENDANTP (GLCLASS OBJ)
		   CLASS])

(GLCLASSP
  [LAMBDA (CLASS)                                            (* edited: "11-NOV-82 11:45")
                                                             (* See if CLASS is a Class name.)
    (PROG (TMP)
          (RETURN (AND (ATOM CLASS)
		       (SETQ TMP (GETPROP CLASS (QUOTE GLSTRUCTURE)))
		       (MEMB (CAR (GLXTRTYPE (CAR TMP)))
			     (QUOTE (OBJECT ATOMOBJECT LISTOBJECT])

(GLCLASSSEND
  [LAMBDA (CLASS SELECTOR ARGS PROPNAME)                     (* edited: "11-NOV-82 14:24")
                                                             (* Execute a message to CLASS with selector SELECTOR and
							     arguments ARGS. PROPNAME is one of MSG, ADJ, ISA, PROP.)
    (PROG (FNCODE)
          [COND
	    ((SETQ FNCODE (GLCOMPPROP CLASS SELECTOR PROPNAME))
	      (RETURN (APPLY FNCODE ARGS]
          (RETURN (QUOTE GLSENDFAILURE])

(GLCOMP
  [LAMBDA (GLAMBDAFN GLEXPR GLTYPESUBS)                      (* edited: "24-AUG-82 17:24")

          (* GLISP compiler function. GLAMBDAFN is the atom whose function definition is being compiled;
	  GLEXPR is the GLAMBDA expression to be compiled. The compiled function is saved on the property list of GLAMBDAFN 
	  under the indicator GLCOMPILED. The property GLRESULTTYPE is the RESULT declaration, if specified;
	  GLGLOBALS is a list of global variables referenced and their types.)


    (DECLARE (SPECVARS GLAMBDAFN GLGLOBALVARS))
    (PROG (NEWARGS NEWEXPR GLNATOM GLTOPCTX RESULTTYPE GLGLOBALVARS RESULT GLSEPATOM GLSEPPTR VALBUSY 
		   EXPRSTACK)
          (SETQ GLSEPPTR 0)
          [COND
	    ((NOT GLQUIETFLG)
	      (PRINT (LIST (QUOTE GLCOMP)
			   GLAMBDAFN]
          (SETQ EXPRSTACK (LIST GLEXPR))
          (SETQ GLNATOM 0)
          (SETQ GLTOPCTX (LIST NIL))                         (* Process the argument list of the GLAMBDA.)
          (SETQ NEWARGS (GLDECL (CADR GLEXPR)
				T NIL GLTOPCTX GLAMBDAFN))   (* See if there is a RESULT declaration.)
          (SETQ GLEXPR (CDDR GLEXPR))
          (GLSKIPCOMMENTS)
          (GLRESGLOBAL)
          (GLSKIPCOMMENTS)
          (GLRESGLOBAL)
          (SETQ VALBUSY (NULL (CDR GLEXPR)))
          (SETQ NEWEXPR (GLPROGN GLEXPR (CONS NIL GLTOPCTX)))
          (PUTPROP GLAMBDAFN (QUOTE GLRESULTTYPE)
		   (OR RESULTTYPE (CADR NEWEXPR)))
          [SETQ RESULT (CONS (QUOTE LAMBDA)
			     (CONS NEWARGS (CAR NEWEXPR]
          (RETURN (GLUNWRAP RESULT T])

(GLCOMPABSTRACT
  [LAMBDA (FN TYPESUBS)                                      (* edited: "29-JUL-82 11:49")
                                                             (* Compile an abstract function into an instance 
							     function given the specified set of type substitutions.)
    (PROG (INSTFN N INSTENT)
          (SETQ N (ADD1 (OR (GETPROP FN (QUOTE GLINSTANCEFNNO))
			    0)))
          (PUTPROP FN (QUOTE GLINSTANCEFNNO)
		   N)
          [SETQ INSTFN (PACK (NCONC (UNPACK FN)
				    (CONS (QUOTE -)
					  (UNPACK N]
          (GLADDINSTANCEFN FN (SETQ INSTENT (LIST INSTFN)))
                                                             (* Now compile the abstract function with the specified 
							     type substitutions.)
          (PUTD INSTFN (GLCOMP INSTFN (GETD FN)
			       TYPESUBS))
          (RETURN INSTFN])

(GLCOMPCOMS
  [LAMBDA (COMSLIST PRINTFLG)                                (* edited: "11-OCT-82 09:54")
                                                             (* Compile all the GLAMBDA funtions on a COMS list.)
    (PROG (FNS)
      LP  [COND
	    ((NULL COMSLIST)
	      (RETURN))
	    ((NLISTP (CAR COMSLIST)))
	    ((EQ (CAAR COMSLIST)
		 (QUOTE FNS))
	      [SETQ FNS (COND
		  ((EQ (CADAR COMSLIST)
		       (QUOTE *))
		    (EVAL (CADDAR COMSLIST)))
		  (T (CDAR COMSLIST]
	      (MAPC FNS (FUNCTION (LAMBDA (X)
			(COND
			  ((EQ (CAR (GLGETD X))
			       (QUOTE GLAMBDA))
			    (GLCOMPILE X)
			    (COND
			      (PRINTFLG (TERPRI)
					(TERPRI)
					(TERPRI)
					(PRINT X)
					(PRINTDEF (GLGETD X))
					(TERPRI)
					(PRINTDEF (GETPROP X (QUOTE GLCOMPILED]
          (SETQ COMSLIST (CDR COMSLIST))
          (GO LP])

(GLCOMPILE
  [LAMBDA (FAULTFN)                                          (* edited: "27-MAY-82 12:58")
                                                             (* "GSN: " "26-Jun-81 11:00")
                                                             (* Compile the function definition stored for the atom 
							     FAULTFN using the GLISP compiler.)
    (GLAMBDATRAN (GLGETD FAULTFN))
    FAULTFN])

(GLCOMPILE?
  [LAMBDA (FN)                                               (* edited: " 4-MAY-82 11:13")
                                                             (* Compile FN if not already compiled.)
    (OR (GETPROP FN (QUOTE GLCOMPILED))
	(GLCOMPILE FN])

(GLCOMPMSG
  [LAMBDA (OBJECT MSGLST ARGLIST CONTEXT)                    (* edited: "18-NOV-82 11:55")
                                                             (* Compile a Message. MSGLST is the Message list, 
							     consisting of message selector, code, and properties 
							     defined with the message.)
    (DECLARE (SPECVARS GLPROGLST))
    (PROG (GLPROGLST RESULTTYPE METHOD RESULT VTYPE)
          (SETQ RESULTTYPE (LISTGET (CDDR MSGLST)
				    (QUOTE RESULT)))
          (SETQ METHOD (CADR MSGLST))
          [COND
	    [(ATOM METHOD)                                   (* Function name is specified.)
	      (COND
		[(LISTGET (CDDR MSGLST)
			  (QUOTE OPEN))
		  (RETURN (GLCOMPOPEN METHOD (CONS OBJECT ARGLIST)
				      (CONS (CADR OBJECT)
					    (LISTGET (CDDR MSGLST)
						     (QUOTE ARGTYPES)))
				      RESULTTYPE
				      (LISTGET (CDDR MSGLST)
					       (QUOTE SPECVARS]
		(T (RETURN (LIST [CONS METHOD (CONS (CAR OBJECT)
						    (MAPCAR ARGLIST (FUNCTION CAR]
				 (OR [GLRESULTTYPE METHOD (CONS (CADR OBJECT)
								(MAPCAR ARGLIST
									(FUNCTION CADR]
				     (LISTGET (CDDR MSGLST)
					      (QUOTE RESULT]
	    [(NLISTP METHOD)
	      (RETURN (GLERROR (QUOTE GLCOMPMSG)
			       (LIST "The form of Response is illegal for message" (CAR MSGLST]
	    ([AND (LISTP (CAR METHOD))
		  (MEMB (CAAR METHOD)
			(QUOTE (virtual Virtual VIRTUAL]
	      [OR (SETQ VTYPE (LISTGET (CDDR MSGLST)
				       (QUOTE VTYPE)))
		  (PROGN (SETQ VTYPE (GLMAKEVTYPE (CADR OBJECT)
						  (CAR METHOD)))
			 (NCONC MSGLST (LIST (QUOTE VTYPE)
					     VTYPE]
	      (RETURN (LIST (CAR OBJECT)
			    VTYPE]                           (* The Method is a list of stuff to be compiled open.)
          (SETQ CONTEXT (LIST NIL))
          (COND
	    ((ATOM (CAR OBJECT))
	      (GLADDSTR (LIST (QUOTE PROG1)
			      (CAR OBJECT))
			(QUOTE self)
			(CADR OBJECT)
			CONTEXT))
	    ((AND (LISTP (CAR OBJECT))
		  (EQ (CAAR OBJECT)
		      (QUOTE PROG1))
		  (ATOM (CADAR OBJECT))
		  (NULL (CDDAR OBJECT)))
	      (GLADDSTR (CAR OBJECT)
			(QUOTE self)
			(CADR OBJECT)
			CONTEXT))
	    (T (SETQ GLPROGLST (CONS (LIST (QUOTE self)
					   (CAR OBJECT))
				     GLPROGLST))
	       (GLADDSTR (QUOTE self)
			 NIL
			 (CADR OBJECT)
			 CONTEXT)))
          (SETQ RESULT (GLPROGN METHOD CONTEXT))             (* If more than one expression resulted, embed in a 
							     PROGN.)
          [RPLACA RESULT (COND
		    ((CDAR RESULT)
		      (CONS (QUOTE PROGN)
			    (CAR RESULT)))
		    (T (CAAR RESULT]
          (RETURN (LIST (COND
			  [GLPROGLST (GLGENCODE (LIST (QUOTE PROG)
						      GLPROGLST
						      (LIST (QUOTE RETURN)
							    (CAR RESULT]
			  (T (CAR RESULT)))
			(OR RESULTTYPE (CADR RESULT])

(GLCOMPOPEN
  [LAMBDA (FN ARGS ARGTYPES RESULTTYPE SPCVARS)              (* edited: " 2-DEC-82 14:11")

          (* Compile the function FN Open, given as arguments ARGS with argument types ARGTYPES. Types may be defined in the
	  definition of function FN (which may be either a GLAMBDA or LAMBDA function) or by ARGTYPES;
	  ARGTYPES takes precedence.)


    (DECLARE (SPECVARS GLPROGLST))
    (PROG (PTR FNDEF GLPROGLST NEWEXPR CONTEXT NEWARGS)      (* Put a new level on top of CONTEXT.)
          (SETQ CONTEXT (LIST NIL))
          (SETQ FNDEF (GLGETD FN))                           (* Get the parameter declarations and add to CONTEXT.)
          (GLDECL (CADR FNDEF)
		  T NIL CONTEXT NIL)                         (* Make the function parameters into "names" and put in 
							     the values, hiding any which are simple variables.)
          (SETQ PTR (DREVERSE (CAR CONTEXT)))
          (RPLACA CONTEXT NIL)
      LP  (COND
	    ((NULL PTR)
	      (GO B)))
          (COND
	    ((EQ ARGS T)
	      (GLADDSTR (CAAR PTR)
			NIL
			(OR (CAR ARGTYPES)
			    (CADDAR PTR))
			CONTEXT)
	      (SETQ NEWARGS (CONS (CAAR PTR)
				  NEWARGS)))
	    ((AND (ATOM (CAAR ARGS))
		  (NEQ SPCVARS T)
		  (NOT (MEMB (CAAR PTR)
			     SPCVARS)))                      (* Wrap the atom in a PROG1 so it won't match as a name;
							     the PROG1 will generally be stripped later.)
	      (GLADDSTR (LIST (QUOTE PROG1)
			      (CAAR ARGS))
			(CAAR PTR)
			(OR (CADAR ARGS)
			    (CAR ARGTYPES)
			    (CADDAR PTR))
			CONTEXT))
	    ((AND (NEQ SPCVARS T)
		  (NOT (MEMB (CAAR PTR)
			     SPCVARS))
		  (LISTP (CAAR ARGS))
		  (EQ (CAAAR ARGS)
		      (QUOTE PROG1))
		  (ATOM (CADAAR ARGS))
		  (NULL (CDDAAR ARGS)))
	      (GLADDSTR (CAAR ARGS)
			(CAAR PTR)
			(OR (CADAR ARGS)
			    (CAR ARGTYPES)
			    (CADDAR PTR))
			CONTEXT))
	    (T                                               (* Since the actual argument is not atomic, make a PROG 
							     variable for it.)
	       (SETQ GLPROGLST (CONS (LIST (CAAR PTR)
					   (CAAR ARGS))
				     GLPROGLST))
	       (GLADDSTR (CAAR PTR)
			 (CADAR PTR)
			 (OR (CADAR ARGS)
			     (CAR ARGTYPES)
			     (CADDAR PTR))
			 CONTEXT)))
          (SETQ PTR (CDR PTR))
          [COND
	    ((LISTP ARGS)
	      (SETQ ARGS (CDR ARGS]
          (SETQ ARGTYPES (CDR ARGTYPES))
          (GO LP)
      B   (SETQ FNDEF (CDDR FNDEF))                          (* Get rid of comments at start of function.)
      C   (COND
	    ((AND FNDEF (LISTP (CAR FNDEF))
		  (EQ (CAAR FNDEF)
		      (QUOTE *)))
	      (SETQ FNDEF (CDR FNDEF))
	      (GO C)))
          (SETQ NEWEXPR (GLPROGN FNDEF CONTEXT))             (* Get rid of atomic result if it isnt busy outside.)
          (COND
	    ([AND (NOT VALBUSY)
		  (CDAR EXPR)
		  (OR [ATOM (CADR (SETQ PTR (NLEFT (CAR NEWEXPR)
						   2]
		      (AND (LISTP (CADR PTR))
			   (EQ (CAADR PTR)
			       (QUOTE PROG1))
			   (ATOM (CADADR PTR))
			   (NULL (CDDADR PTR]
	      (RPLACD PTR NIL)))
          [SETQ RESULT (LIST (COND
			       [GLPROGLST (SETQ PTR (LAST (CAR NEWEXPR)))
					  (RPLACA PTR (LIST (QUOTE RETURN)
							    (CAR PTR)))
					  (GLGENCODE (CONS (QUOTE PROG)
							   (CONS (DREVERSE GLPROGLST)
								 (CAR NEWEXPR]
			       ((CDAR NEWEXPR)
				 (CONS (QUOTE PROGN)
				       (CAR NEWEXPR)))
			       (T (CAAR NEWEXPR)))
			     (OR RESULTTYPE (GLRESULTTYPE FN NIL)
				 (CADR NEWEXPR]
          [COND
	    ((EQ ARGS T)
	      (RPLACA RESULT (LIST (QUOTE LAMBDA)
				   (DREVERSE NEWARGS)
				   (CAR RESULT]
          (RETURN RESULT])

(GLCOMPPROP
  [LAMBDA (STR PROPNAME PROPTYPE)                            (* edited: " 1-DEC-82 09:35")
    (PROG (CODE PL SUBPL PROPENT GLNATOM CONTEXT VALBUSY GLSEPATOM GLSEPPTR EXPRSTACK GLTOPCTX 
		GLGLOBALVARS GLTYPESUBS FAULTFN)
          (SETQ FAULTFN (QUOTE GLCOMPPROP))
          (COND
	    ([NOT (MEMB PROPTYPE (QUOTE (ADJ ISA PROP MSG]
	      (ERROR)))                                      (* If the property is implemented by a named function, 
							     return the function name.)
          [COND
	    ((AND (SETQ PROPENT (GLGETPROP STR PROPNAME PROPTYPE))
		  (ATOM (CADR PROPENT)))
	      (RETURN (CADR PROPENT]                         (* See if the property has already been compiled.)
          [COND
	    ([AND (SETQ PL (GETPROP STR (QUOTE GLPROPFNS)))
		  (SETQ SUBPL (ASSOC PROPTYPE PL))
		  (SETQ PROPENT (ASSOC PROPNAME (CDR SUBPL]
	      (RETURN (CADR PROPENT]                         (* Compile code for this property and save it.)
          (SETQ GLNATOM 0)
          (SETQ VALBUSY T)
          (SETQ GLSEPPTR 0)
          (SETQ CONTEXT (SETQ GLTOPCTX (LIST NIL)))
          (OR (SETQ CODE (GLCOMPPROPL STR PROPNAME PROPTYPE))
	      (RETURN))
          [COND
	    ((NOT PL)
	      [PUTPROP STR (QUOTE GLPROPFNS)
		       (SETQ PL (COPY (QUOTE ((PROP)
					       (ADJ)
					       (ISA)
					       (MSG]
	      (SETQ SUBPL (ASSOC PROPTYPE PL]
          (RPLACD SUBPL (CONS (CONS PROPNAME CODE)
			      (CDR SUBPL)))
          (RETURN (CAR CODE])

(GLCOMPPROPL
  [LAMBDA (STR PROPNAME PROPTYPE)                            (* edited: " 1-DEC-82 11:07")
                                                             (* Compile a message as a closed form, i.e., function 
							     name or LAMBDA form.)
    (PROG (CODE MSGL TRANS TMP FETCHCODE NEWVAR)
          (COND
	    [(SETQ MSGL (GLSTRPROP STR PROPTYPE PROPNAME))
	      (COND
		[(ATOM (CADR MSGL))
		  (COND
		    ((LISTGET (CDDR MSGL)
			      (QUOTE OPEN))
		      (SETQ CODE (GLCOMPOPEN (CADR MSGL)
					     T
					     (LIST STR)
					     NIL NIL)))
		    (T (SETQ CODE (LIST (CADR MSGL)
					(GLRESULTTYPE (CADR MSGL)
						      NIL]
		((SETQ CODE (GLADJ (LIST (QUOTE self)
					 STR)
				   PROPNAME PROPTYPE))
		  (SETQ CODE (LIST (LIST (QUOTE LAMBDA)
					 (LIST (QUOTE self))
					 (GLUNWRAP (CAR CODE)
						   T))
				   (CADR CODE]
	    ((SETQ TRANS (GLTRANSPARENTTYPES STR))
	      (GO B))
	    (T (RETURN)))
          [RETURN (LIST (GLUNWRAP (CAR CODE)
				  T)
			(OR (CADR CODE)
			    (LISTGET (CDDR MSGL)
				     (QUOTE RESULT]          (* Look for the message in a contained TRANSPARENT 
							     type.)
      B   (COND
	    ((NULL TRANS)
	      (RETURN))
	    [(SETQ TMP (GLCOMPPROPL (CAR TRANS)
				    PROPNAME PROPTYPE))
	      (COND
		((ATOM (CAR TMP))
		  (GLERROR (QUOTE GLCOMPPROPL)
			   (LIST "GLISP cannot currently
handle inheritance of the property" PROPNAME 
			"which is specified as a function name
in a TRANSPARENT subtype.  Sorry."))
		  (RETURN)))
	      (SETQ FETCHCODE (GLSTRFN (CAR TRANS)
				       STR NIL))
	      (SETQ NEWVAR (GLMKVAR))
	      (GLSTRVAL FETCHCODE NEWVAR)
	      (RETURN (LIST (GLUNWRAP [LIST (QUOTE LAMBDA)
					    (CONS NEWVAR (CDADAR TMP))
					    (LIST (QUOTE PROG)
						  (LIST (LIST (CAADAR TMP)
							      (CAR FETCHCODE)))
						  (LIST (QUOTE RETURN)
							(CADDAR TMP]
				      T)
			    (CADR TMP]
	    (T (SETQ TRANS (CDR TRANS))
	       (GO B])

(GLCONST?
  [LAMBDA (X)                                                (* edited: "31-AUG-82 15:38")
                                                             (* Test X to see if it represents a compile-time 
							     constant value.)
    (OR (NULL X)
	(EQ X T)
	(NUMBERP X)
	(AND (LISTP X)
	     (EQ (CAR X)
		 (QUOTE QUOTE))
	     (ATOM (CADR X)))
	(AND (ATOM X)
	     (GETPROP X (QUOTE GLISPCONSTANTFLG])

(GLCONSTSTR?
  [LAMBDA (X)                                                (* edited: "26-MAY-82 14:50")
                                                             (* Test to see if X is a constant structure.)
    (OR (GLCONST? X)
	(AND (LISTP X)
	     (OR (EQ (CAR X)
		     (QUOTE QUOTE))
		 (AND (MEMB (CAR X)
			    (QUOTE (COPY APPEND)))
		      (LISTP (CADR X))
		      (EQ (CAADR X)
			  (QUOTE QUOTE))
		      (OR (NEQ (CAR X)
			       (QUOTE APPEND))
			  (NULL (CDDR X))
			  (NULL (CADDR X])

(GLCONSTVAL
  [LAMBDA (X)                                                (* edited: "30-AUG-82 10:21")
                                                             (* "Get the value of a compile-time constant")
    (COND
      ((OR (NULL X)
	   (EQ X T)
	   (NUMBERP X))
	X)
      ((AND (LISTP X)
	    (EQ (CAR X)
		(QUOTE QUOTE)))
	(CADR X))
      ([AND (LISTP X)
	    (MEMB (CAR X)
		  (QUOTE (COPY APPEND)))
	    (LISTP (CADR X))
	    (EQ (CAADR X)
		(QUOTE QUOTE))
	    (OR (NULL (CDDR X))
		(NULL (CADDR X]
	(CADADR X))
      ((AND (ATOM X)
	    (GETPROP X (QUOTE GLISPCONSTANTFLG)))
	(GETPROP X (QUOTE GLISPCONSTANTVAL)))
      (T (ERROR])

(GLCP
  [LAMBDA (FN)                                               (* edited: " 5-OCT-82 15:23")
    (SETQ FN (OR FN GLLASTFNCOMPILED))
    (COND
      ((NOT (GLGETD FN))
	(PRIN1 FN)
	(PRIN1 " ?")
	(TERPRI))
      (T (GLCOMPILE FN)
	 (GLP FN])

(GLDECL
  [LAMBDA (LST NOVAROK VALOK GLTOPCTX FN)                    (* edited: "24-AUG-82 13:08")
                                                             (* edited: " 1-Jun-81 16:02")
                                                             (* edited: "24-Apr-81 12:02")
                                                             (* edited: "21-Apr-81 11:24")

          (* Process a declaration list from a GLAMBDA expression. Each element of the list is of the form <var>, 
	  <var>:<str-descr>, :<str-descr>, or <var>: (A <str-descr>) or (A <str-descr>). Forms without a variable are 
	  accepted only if NOVAROK is true. If VALOK is true, a PROG form (variable value) is allowed.
	  The result is a list of variable names.)


    (DECLARE (SPECVARS ARGTYPES RESULT))
    (PROG (RESULT FIRST SECOND THIRD TOP TMP EXPR VARS STR ARGTYPES)
      A                                                      (* Get the next variable/description from LST)
          [COND
	    ((NULL LST)
	      [COND
		(FN (PUTPROP FN (QUOTE GLARGUMENTTYPES)
			     (DREVERSE ARGTYPES]
	      (RETURN (DREVERSE RESULT]
          (SETQ TOP (pop LST))
          (COND
	    ((NOT (ATOM TOP))
	      (GO B)))
          (SETQ VARS NIL)
          (SETQ STR NIL)
          (GLSEPINIT TOP)
          (SETQ FIRST (GLSEPNXT))
          (SETQ SECOND (GLSEPNXT))
          [COND
	    ((EQ FIRST (QUOTE :))
	      (COND
		[(NULL SECOND)
		  (COND
		    ((AND NOVAROK LST (GLOKSTR? (CAR LST)))
		      (GLDECLDS (GLMKVAR)
				(pop LST))
		      (GO A))
		    (T (GO E]
		((AND NOVAROK (GLOKSTR? SECOND)
		      (NULL (GLSEPNXT)))
		  (GLDECLDS (GLMKVAR)
			    SECOND)
		  (GO A))
		(T (GO E]
      D                                                      (* At least one variable name has been found.
							     Collect other variable names until a <type> is found.)
          (SETQ VARS (NCONC1 VARS FIRST))
          (COND
	    ((NULL SECOND)
	      (GO C))
	    [(EQ SECOND (QUOTE :))
	      (COND
		((AND (SETQ THIRD (GLSEPNXT))
		      (GLOKSTR? THIRD)
		      (NULL (GLSEPNXT)))
		  (SETQ STR THIRD)
		  (GO C))
		((AND (NULL THIRD)
		      (GLOKSTR? (CAR LST)))
		  (SETQ STR (pop LST))
		  (GO C))
		(T (GO E]
	    [(EQ SECOND (QUOTE ,))
	      (COND
		((SETQ FIRST (GLSEPNXT))
		  (SETQ SECOND (GLSEPNXT))
		  (GO D))
		((ATOM (CAR LST))
		  (GLSEPINIT (pop LST))
		  (SETQ FIRST (GLSEPNXT))
		  (SETQ SECOND (GLSEPNXT))
		  (GO D]
	    (T (GO E)))
      C                                                      (* Define the <type> for each variable on VARS.)
          [MAPC VARS (FUNCTION (LAMBDA (X)
		    (GLDECLDS X STR]
          (GO A)
      B                                                      (* The top of LST is non-atomic.
							     Must be either (A <type>) or 
							     (<var> <value>).)
          (COND
	    ((AND (GL-A-AN? (CAR TOP))
		  NOVAROK
		  (GLOKSTR? TOP))
	      (GLDECLDS (GLMKVAR)
			TOP))
	    ((AND VALOK (NOT (GL-A-AN? (CAR TOP)))
		  (ATOM (CAR TOP))
		  (CDR TOP))
	      (SETQ EXPR (CDR TOP))
	      (SETQ TMP (GLDOEXPR NIL GLTOPCTX T))
	      (COND
		(EXPR (GO E)))
	      (GLADDSTR (CAR TOP)
			NIL
			(CADR TMP)
			GLTOPCTX)
	      (SETQ RESULT (CONS (LIST (CAR TOP)
				       (CAR TMP))
				 RESULT)))
	    (T (GO E)))
          (GO A)
      E   (GLERROR (QUOTE GLDECL)
		   (LIST "Bad argument structure" LST))
          (RETURN])

(GLDECLDS
  [LAMBDA (ATM STR)                                          (* edited: "26-JUL-82 17:25")
                                                             (* "GSN: " " 2-Jan-81 13:39")
                                                             (* Add ATM to the RESULT list of GLDECL, and declare its
							     structure.)
    (PROG NIL                                                (* If a substitution exists for this type, use it.)
          [COND
	    (GLTYPESUBS (SETQ STR (GLSUBSTTYPE STR GLTYPESUBS]
          (SETQ RESULT (CONS ATM RESULT))
          (SETQ ARGTYPES (CONS STR ARGTYPES))
          (GLADDSTR ATM NIL STR GLTOPCTX])

(GLDEFFNRESULTTYPES
  [LAMBDA (LST)                                              (* edited: "19-MAY-82 13:33")
                                                             (* Define the result types for a list of functions.
							     The format of the argument is a list of dotted pairs, 
							     (FN . TYPE))
    (MAPC LST (FUNCTION (LAMBDA (X)
	      (MAPC (CADR X)
		    (FUNCTION (LAMBDA (Y)
			(PUTPROP Y (QUOTE GLRESULTTYPE)
				 (CAR X])

(GLDEFFNRESULTTYPEFNS
  [LAMBDA (LST)                                              (* edited: "19-MAY-82 13:05")
                                                             (* Define the result type functions for a list of 
							     functions. The format of the argument is a list of 
							     dotted pairs, (FN . TYPEFN))
    (MAPC LST (FUNCTION (LAMBDA (X)
	      (PUTPROP (CAR X)
		       (QUOTE GLRESULTTYPEFN)
		       (CDR X])

(GLDEFPROP
  [LAMBDA (OBJECT PROP LST)                                  (* edited: "26-OCT-82 12:18")
                                                             (* Define properties for an object type.
							     Each property is of the form 
							     (<propname> (<definition>) <properties>))
    (PROG (LSTP)
          [MAPC LST (FUNCTION (LAMBDA (X)
		    (COND
		      ([NOT (OR (AND (EQ PROP (QUOTE SUPERS))
				     (ATOM X))
				(AND (LISTP X)
				     (ATOM (CAR X))
				     (CDR X]
			(PRIN1 "GLDEFPROP: For object ")
			(PRIN1 OBJECT)
			(PRIN1 " the ")
			(PRIN1 PROP)
			(PRIN1 " property ")
			(PRIN1 X)
			(PRIN1 " has bad form.")
			(TERPRI)
			(PRIN1 "This property was ignored.")
			(TERPRI))
		      (T (SETQ LSTP (CONS X LSTP]
          (NCONC (GETPROP OBJECT (QUOTE GLSTRUCTURE))
		 (LIST PROP (DREVERSE LSTP])

(GLDEFSTR
  [LAMBDA (LST)                                              (* edited: "27-MAY-82 12:59")
                                                             (* "GSN: " "23-Sep-81 19:20")
                                                             (* "GSN: " "17-Sep-81 12:21")

          (* Process a Structure Description. The format of the argument is the name of the structure followed by its 
	  structure description, followed by other optional arguments.)


    (PROG (STRNAME STR)
          (SETQ STRNAME (pop LST))
          (SETQ STR (pop LST))
          (PUTPROP STRNAME (QUOTE GLSTRUCTURE)
		   (LIST STR))
          (COND
	    ((NOT (GLOKSTR? STR))
	      (PRIN1 STRNAME)
	      (PRIN1 " has faulty structure specification.")
	      (TERPRI)))                                     (* Process the remaining specifications, if any.
							     Each additional specification is a list beginning with a
							     keyword.)
      LP  (COND
	    ((NULL LST)
	      (RETURN)))
          (SELECTQ (CAR LST)
		   ((ADJ Adj adj)
		     (GLDEFPROP STRNAME (QUOTE ADJ)
				(CADR LST)))
		   ((PROP Prop prop)
		     (GLDEFPROP STRNAME (QUOTE PROP)
				(CADR LST)))
		   ((ISA Isa IsA isA isa)
		     (GLDEFPROP STRNAME (QUOTE ISA)
				(CADR LST)))
		   ((MSG Msg msg)
		     (GLDEFPROP STRNAME (QUOTE MSG)
				(CADR LST)))
		   (GLDEFPROP STRNAME (CAR LST)
			      (CADR LST)))
          (SETQ LST (CDDR LST))
          (GO LP])

(GLDEFSTRNAMES
  [NLAMBDA LST                                               (* edited: "27-APR-82 11:01")
    (MAPC LST (FUNCTION (LAMBDA (X)
	      (PROG (TMP)
		    (COND
		      ((SETQ TMP (ASSOC (CAR X)
					GLUSERSTRNAMES))
			(RPLACD TMP (CDR X)))
		      (T (SETQ GLUSERSTRNAMES (NCONC1 GLUSERSTRNAMES X])

(GLDEFSTRQ
  [NLAMBDA ARGS                                              (* edited: "26-MAY-82 14:53")

          (* Define named structure descriptions. The descriptions are of the form (<name> <description>). Each description 
	  is put on the property list of <name> as GLSTRUCTURE)


    (MAPC ARGS (FUNCTION (LAMBDA (ARG)
	      (GLDEFSTR ARG])

(GLDEFUNITPKG
  [LAMBDA (UNITREC)                                          (* edited: "27-MAY-82 13:00")
                                                             (* "GSN: " " 2-Jun-81 13:31")

          (* This function is called by the user to define a unit package to the GLISP system. The argument, a unit record, 
	  is a list consisting of the name of a function to test an entity to see if it is a unit of the units package, the 
	  name of the unit package's runtime GET function, and an ALIST of operations on units and the functions to perform 
	  those operations. Operations include GET, PUT, ISA, ISADJ, NCONC, REMOVE, PUSH, and POP.)


    (PROG (LST)
          (SETQ LST GLUNITPKGS)
      A   (COND
	    ((NULL LST)
	      (SETQ GLUNITPKGS (NCONC1 GLUNITPKGS UNITREC))
	      (RETURN))
	    ((EQ (CAAR LST)
		 (CAR UNITREC))
	      (RPLACA LST UNITREC)))
          (SETQ LST (CDR LST))
          (GO A])

(GLDELDEF
  [LAMBDA (NAME TYPE)                                        (* edited: "30-OCT-81 12:23")
                                                             (* Remove the GLISP structure definition for NAME.)
    (REMPROP NAME (QUOTE GLSTRUCTURE])

(GLDESCENDANTP
  [LAMBDA (SUBCLASS CLASS)                                   (* edited: "28-NOV-82 15:18")
    (PROG (SUPERS)
          (COND
	    ((EQ SUBCLASS CLASS)
	      (RETURN T)))
          (SETQ SUPERS (GLGETSUPERS SUBCLASS))
      LP  (COND
	    ((NULL SUPERS)
	      (RETURN))
	    ((GLDESCENDANTP (CAR SUPERS)
			    CLASS)
	      (RETURN T)))
          (SETQ SUPERS (CDR SUPERS))
          (GO LP])

(GLDOA
  [LAMBDA (EXPR)                                             (* edited: "27-MAY-82 13:00")
                                                             (* "GSN: " "13-Aug-81 13:39")
                                                             (* "GSN: " "25-Jun-81 15:26")
                                                             (* Function to compile an expression of the form 
							     (A <type> ...))
    (PROG (TYPE UNITREC TMP)
          (SETQ TYPE (CADR EXPR))
          (COND
	    [(GLGETSTR TYPE)
	      (RETURN (GLMAKESTR TYPE (CDDR EXPR]
	    ([AND (SETQ UNITREC (GLUNIT? TYPE))
		  (SETQ TMP (ASSOC (QUOTE A)
				   (CADDR UNITREC]
	      (RETURN (APPLY* (CDR TMP)
			      EXPR)))
	    (T (GLERROR (QUOTE GLDOA)
			(LIST "The type" TYPE "is not defined."])

(GLDOCASE
  [LAMBDA (EXPR)                                             (* edited: "12-NOV-82 11:10")
                                                             (* Compile code for Case statement.)
    (PROG (SELECTOR SELECTORTYPE RESULT TMP RESULTTYPE TYPEOK ELSECLAUSE TMPB)
          (SETQ TYPEOK T)
          (SETQ TMP (GLPUSHEXPR (LIST (CADR EXPR))
				NIL CONTEXT T))
          (SETQ SELECTOR (CAR TMP))
          (SETQ SELECTORTYPE (CADR TMP))
          (SETQ EXPR (CDDR EXPR))                            (* Get rid of "of" if present)
          [COND
	    ((MEMB (CAR EXPR)
		   (QUOTE (OF Of of)))
	      (SETQ EXPR (CDR EXPR]
      A   [COND
	    ((NULL EXPR)
	      (RETURN (LIST [GLGENCODE (CONS (QUOTE SELECTQ)
					     (CONS SELECTOR (NCONC1 RESULT ELSECLAUSE]
			    RESULTTYPE)))
	    ((MEMB (CAR EXPR)
		   (QUOTE (ELSE Else else)))
	      (SETQ TMP (GLPROGN (CDR EXPR)
				 CONTEXT))
	      [SETQ ELSECLAUSE (COND
		  ((CDAR TMP)
		    (CONS (QUOTE PROGN)
			  (CAR TMP)))
		  (T (CAAR TMP]
	      (SETQ EXPR NIL))
	    (T (SETQ TMP (GLPROGN (CDAR EXPR)
				  CONTEXT))
	       (SETQ RESULT (NCONC1 RESULT
				    (CONS [COND
					    ((ATOM (CAAR EXPR))
					      (OR (AND (SETQ TMPB (GLSTRPROP SELECTORTYPE
									     (QUOTE VALUES)
									     (CAAR EXPR)))
						       (CADR TMPB))
						  (CAAR EXPR)))
					    (T (MAPCAR (CAAR EXPR)
						       (FUNCTION (LAMBDA (X)
							   (OR (AND (SETQ TMPB (GLSTRPROP
									SELECTORTYPE
									(QUOTE VALUES)
									X))
								    (CADR TMPB))
							       X]
					  (CAR TMP]          (* If all the result types are the same, then we know 
							     the result of the Case statement.)
          [COND
	    (TYPEOK (COND
		      ((NULL RESULTTYPE)
			(SETQ RESULTTYPE (CADR TMP)))
		      ((EQUAL RESULTTYPE (CADR TMP)))
		      (T (SETQ TYPEOK NIL)
			 (SETQ RESULTTYPE NIL]
          (SETQ EXPR (CDR EXPR))
          (GO A])

(GLDOCOND
  [LAMBDA (CONDEXPR)                                         (* edited: "23-APR-82 14:38")
                                                             (* "GSN: " "21-Apr-81 11:24")
                                                             (* Compile a COND expression.)
    (PROG (RESULT TMP TYPEOK RESULTTYPE)
          (SETQ TYPEOK T)
      A   (COND
	    ((NULL (SETQ CONDEXPR (CDR CONDEXPR)))
	      (GO B)))
          (SETQ TMP (GLPROGN (CAR CONDEXPR)
			     CONTEXT))
          [COND
	    ((NEQ (CAAR TMP)
		  NIL)
	      (SETQ RESULT (NCONC1 RESULT (CAR TMP)))
	      (COND
		(TYPEOK (COND
			  ((NULL RESULTTYPE)
			    (SETQ RESULTTYPE (CADR TMP)))
			  ((EQUAL RESULTTYPE (CADR TMP)))
			  (T (SETQ RESULTTYPE NIL)
			     (SETQ TYPEOK NIL]
          (COND
	    ((NEQ (CAAR TMP)
		  T)
	      (GO A)))
      B   (RETURN (LIST (COND
			  ((AND (NULL (CDR RESULT))
				(EQ (CAAR RESULT)
				    T))
			    (CONS (QUOTE PROGN)
				  (CDAR RESULT)))
			  (T (CONS (QUOTE COND)
				   RESULT)))
			(AND TYPEOK RESULTTYPE])

(GLDOEXPR
  [LAMBDA (START CONTEXT VALBUSY)                            (* edited: "26-AUG-82 09:28")
                                                             (* "GSN: " "23-Sep-81 17:08")
                                                             (* "GSN: " "24-Aug-81 13:25")
                                                             (* "GSN: " "19-Jun-81 17:03")
                                                             (* "GSN: " "23-Apr-81 10:53")

          (* Compile a single expression. START is set if EXPR is the start of a new expression, i.e., if EXPR might be a 
	  function call. The global variable EXPR is the expression, CONTEXT the context in which it is compiled.
	  VALBUSY is T if the value of the expression is needed outside the expression. The value is a list of the new 
	  expression and its value-description.)


    (PROG (FIRST TMP RESULT)
          (SETQ EXPRSTACK (CONS EXPR EXPRSTACK))
          (COND
	    ((NLISTP EXPR)
	      (GLERROR (QUOTE GLDOEXPR)
		       (LIST "Expression is not a list."))
	      (GO OUT))
	    ((AND (NOT START)
		  (STRINGP (CAR EXPR)))
	      (SETQ RESULT (LIST (PROG1 (CAR EXPR)
					(SETQ EXPR (CDR EXPR)))
				 (QUOTE STRING)))
	      (GO OUT))
	    ((OR (NOT (LITATOM (CAR EXPR)))
		 (NOT START))
	      (GO A)))

          (* Test the initial atom to see if it is a function name. It is assumed to be a function name if it doesnt contain
	  any GLISP operators and the following atom doesnt start with a GLISP binary operator.)


          (COND
	    ((AND (EQ GLLISPDIALECT (QUOTE INTERLISP))
		  (EQ (CAR EXPR)
		      (QUOTE *)))
	      (SETQ RESULT (LIST EXPR NIL))
	      (GO OUT))
	    ((MEMB (CAR EXPR)
		   (QUOTE (QUOTE Quote quote)))
	      (SETQ FIRST (CAR EXPR))
	      (GO B)))
          (GLSEPINIT (CAR EXPR))                             (* See if the initial atom contains an expression 
							     operator.)
          (COND
	    [(NEQ (SETQ FIRST (GLSEPNXT))
		  (CAR EXPR))
	      (COND
		((OR (MEMB (CAR EXPR)
			   (QUOTE (APPLY* BLKAPPLY* PACK* PP*)))
		     (GETD (CAR EXPR))
		     (GETPROP (CAR EXPR)
			      (QUOTE MACRO))
		     (AND (NEQ FIRST (QUOTE ~))
			  (GLOPERATOR? FIRST)))
		  (GLSEPCLR)
		  (SETQ FIRST (CAR EXPR))
		  (GO B))
		(T (GLSEPCLR)
		   (GO A]
	    ((OR (EQ FIRST (QUOTE ~))
		 (EQ FIRST (QUOTE -)))
	      (GLSEPCLR)
	      (GO A))
	    ([OR (NLISTP (CDR EXPR))
		 (NOT (LITATOM (CADR EXPR]
	      (GO B)))                                       (* See if the initial atom is followed by an expression 
							     operator.)
          (GLSEPINIT (CADR EXPR))
          (SETQ TMP (GLSEPNXT))
          (GLSEPCLR)
          (COND
	    ((GLOPERATOR? TMP)
	      (GO A)))                                       (* The EXPR is a function reference.
							     Test for system functions.)
      B   (SETQ RESULT (SELECTQ FIRST
				[(QUOTE Quote quote GO Go go)
				  (LIST EXPR (COND
					  ((ATOM (CADR EXPR))
					    (QUOTE ATOM))
					  ((STRINGP (CADR EXPR))
					    (QUOTE STRING))
					  (T NIL]
				((PROG Prog
				   prog)
				  (GLDOPROG EXPR CONTEXT))
				((FUNCTION Function function)
                                                             (* To be implemented *****)
				  (LIST EXPR (QUOTE LISP)))
				((SETQ Setq setq)
				  (GLDOSETQ EXPR))
				((COND
				    Cond cond)
				  (GLDOCOND EXPR))
				((RETURN Return return)
				  (GLDORETURN EXPR))
				((FOR For for)
				  (GLDOFOR EXPR))
				((THE The the)
				  (GLDOTHE EXPR))
				((THOSE Those those)
				  (GLDOTHOSE EXPR))
				((IF If if)
				  (GLDOIF EXPR CONTEXT))
				((A a AN An an)
				  (GLDOA EXPR))
				((_ SEND Send send)
				  (GLDOSEND EXPR))
				((PROGN PROG2)
				  (GLDOPROGN EXPR))
				(PROG1 (GLDOPROG1 EXPR CONTEXT))
				((SELECTQ CASEQ)
				  (GLDOSELECTQ EXPR CONTEXT))
				((WHILE While while)
				  (GLDOWHILE EXPR CONTEXT))
				((REPEAT Repeat repeat)
				  (GLDOREPEAT EXPR))
				((CASE Case case)
				  (GLDOCASE EXPR))
				(GLUSERFN EXPR)))
          (GO OUT)
      A                                                      (* The current EXPR is possibly a GLISP expression.
							     Parse the next subexpression using GLPARSEXPR.)
          (SETQ RESULT (GLPARSEXPR))
      OUT (SETQ EXPRSTACK (CDR EXPRSTACK))
          (RETURN RESULT])

(GLDOFOR
  [LAMBDA (EXPR)                                             (* edited: " 2-DEC-82 13:35")
                                                             (* edited: "21-Apr-81 11:25")
                                                             (* Compile code for a FOR loop.)
    (DECLARE (SPECVARS DOMAINNAME))
    (PROG (DOMAIN DOMAINNAME DTYPE ORIGEXPR LOOPVAR NEWCONTEXT LOOPCONTENTS SINGFLAG LOOPCOND 
		  COLLECTCODE)
          (SETQ ORIGEXPR EXPR)
          (pop EXPR)                                         (* Parse the forms (FOR EACH <set> ...) and 
							     (FOR <var> IN <set> ...))
          (COND
	    ((MEMB (CAR EXPR)
		   (QUOTE (EACH Each each)))
	      (SETQ SINGFLAG T)
	      (pop EXPR))
	    ([AND (ATOM (CAR EXPR))
		  (MEMB (CADR EXPR)
			(QUOTE (IN In in]
	      (SETQ LOOPVAR (pop EXPR))
	      (pop EXPR))
	    (T (GO X)))                                      (* Now get the <set>)
          (COND
	    ((NULL (SETQ DOMAIN (GLDOMAIN SINGFLAG)))
	      (GO X)))
          (SETQ DTYPE (GLXTRTYPE (CADR DOMAIN)))
          [COND
	    [(OR (NULL DTYPE)
		 (EQ DTYPE (QUOTE ANYTHING)))
	      (SETQ DTYPE (QUOTE (LISTOF ANYTHING]
	    ((NEQ (CAR DTYPE)
		  (QUOTE LISTOF))
	      (OR (EQ [CAR (SETQ DTYPE (GLXTRTYPE (GLGETSTR DTYPE]
		      (QUOTE LISTOF))
		  (GO X]                                     (* Add a level onto the context for the inside of the 
							     loop.)
          (SETQ NEWCONTEXT (CONS NIL CONTEXT))               (* If a loop variable wasnt specified, make one.)
          (OR LOOPVAR (SETQ LOOPVAR (GLMKVAR)))
          (GLADDSTR LOOPVAR (AND SINGFLAG DOMAINNAME)
		    (CADR DTYPE)
		    NEWCONTEXT)                              (* See if a condition is specified.
							     If so, add it to LOOPCOND.)
          [COND
	    ((MEMB (CAR EXPR)
		   (QUOTE (WITH With with)))
	      (pop EXPR)
	      (SETQ LOOPCOND (GLPREDICATE (LIST LOOPVAR (CADR DTYPE))
					  NEWCONTEXT NIL NIL)))
	    ((MEMB (CAR EXPR)
		   (QUOTE (WHICH Which which WHO Who who THAT That that)))
	      (pop EXPR)
	      (SETQ LOOPCOND (GLPREDICATE (LIST LOOPVAR (CADR DTYPE))
					  NEWCONTEXT T T]
          [COND
	    ([AND EXPR (MEMB (CAR EXPR)
			     (QUOTE (when When WHEN]
	      (pop EXPR)
	      (SETQ LOOPCOND (GLANDFN LOOPCOND (GLDOEXPR NIL NEWCONTEXT T]
          [COND
	    ((MEMB (CAR EXPR)
		   (QUOTE (collect Collect COLLECT)))
	      (pop EXPR)
	      (SETQ COLLECTCODE (GLDOEXPR NIL NEWCONTEXT T)))
	    (T (COND
		 ((MEMB (CAR EXPR)
			(QUOTE (DO Do do)))
		   (pop EXPR)))
	       (SETQ LOOPCONTENTS (CAR (GLPROGN EXPR NEWCONTEXT]
          (RETURN (GLMAKEFORLOOP LOOPVAR DOMAIN LOOPCONTENTS LOOPCOND COLLECTCODE))
      X   (RETURN (GLUSERFN ORIGEXPR])

(GLDOIF
  [LAMBDA (EXPR CONTEXT)                                     (* edited: " 4-MAY-82 10:46")
                                                             (* "GSN: " "14-Aug-81 16:47")
                                                             (* "GSN: " "20-Apr-81 11:07")
                                                             (* Process an IF ... THEN expression.)
    (PROG (PRED ACTIONS CONDLIST TYPE TMP OLDCONTEXT)
          (SETQ OLDCONTEXT CONTEXT)
          (pop EXPR)
      A   [COND
	    ((NULL EXPR)
	      (RETURN (LIST (CONS (QUOTE COND)
				  CONDLIST)
			    TYPE]
          (SETQ CONTEXT (CONS NIL OLDCONTEXT))
          (SETQ PRED (GLPREDICATE NIL CONTEXT NIL T))
          (COND
	    ((MEMB (CAR EXPR)
		   (QUOTE (THEN Then then)))
	      (pop EXPR)))
          (SETQ ACTIONS (CONS (CAR PRED)
			      NIL))
          (SETQ TYPE (CADR PRED))
      C   (SETQ CONDLIST (NCONC1 CONDLIST ACTIONS))
      B   (COND
	    ((NULL EXPR)
	      (GO A))
	    ((MEMB (CAR EXPR)
		   (QUOTE (ELSEIF ElseIf Elseif elseIf elseif)))
	      (pop EXPR)
	      (GO A))
	    ((MEMB (CAR EXPR)
		   (QUOTE (ELSE Else else)))
	      (pop EXPR)
	      (SETQ ACTIONS (CONS T NIL))
	      (SETQ TYPE (QUOTE BOOLEAN))
	      (GO C))
	    ((SETQ TMP (GLDOEXPR NIL CONTEXT T))
	      (NCONC1 ACTIONS (CAR TMP))
	      (SETQ TYPE (CADR TMP))
	      (GO B))
	    (T (GLERROR (QUOTE GLDOIF)
			(LIST "IF statement contains bad code."])

(GLDOLAMBDA
  [LAMBDA (EXPR ARGTYPES CONTEXT)                            (* edited: "16-DEC-81 15:47")
                                                             (* Compile a LAMBDA expression for which the ARGTYPES 
							     are given.)
    (PROG (ARGS NEWEXPR VALBUSY)
          (SETQ ARGS (CADR EXPR))
          (SETQ CONTEXT (CONS NIL CONTEXT))
      LP  (COND
	    (ARGS (GLADDSTR (CAR ARGS)
			    NIL
			    (CAR ARGTYPES)
			    CONTEXT)
		  (SETQ ARGS (CDR ARGS))
		  (SETQ ARGTYPES (CDR ARGTYPES))
		  (GO LP)))
          (SETQ VALBUSY T)
          (SETQ NEWEXPR (GLPROGN (CDDR EXPR)
				 CONTEXT))
          (RETURN (LIST (CONS (QUOTE LAMBDA)
			      (CONS (CADR EXPR)
				    (CAR NEWEXPR)))
			(CADR NEWEXPR])

(GLDOMAIN
  [LAMBDA (SINGFLAG)                                         (* edited: "30-MAY-82 16:12")
                                                             (* edited: "17-Apr-81 16:51")

          (* Get a domain specification from the EXPR. If SINGFLAG is set and the top of EXPR is a simple atom, the atom is 
	  made plural and used as a variable or field name.)


    (PROG (NAME FIRST)
          (COND
	    ((FMEMB (CAR EXPR)
		    (QUOTE (THE The the)))
	      (SETQ FIRST (CAR EXPR))
	      (RETURN (GLPARSFLD NIL)))
	    [(ATOM (CAR EXPR))
	      (GLSEPINIT (CAR EXPR))
	      (COND
		[(EQ (SETQ NAME (GLSEPNXT))
		     (CAR EXPR))
		  (pop EXPR)
		  (SETQ DOMAINNAME NAME)
		  (RETURN (COND
			    [SINGFLAG (COND
					((FMEMB (CAR EXPR)
						(QUOTE (OF Of of)))
					  (SETQ FIRST (QUOTE THE))
					  (SETQ EXPR (CONS (GLPLURAL NAME)
							   EXPR))
					  (GLPARSFLD NIL))
					(T (GLIDNAME (GLPLURAL NAME)
						     NIL]
			    (T (GLIDNAME NAME NIL]
		(T (GLSEPCLR)
		   (RETURN (GLDOEXPR NIL CONTEXT T]
	    (T (RETURN (GLDOEXPR NIL CONTEXT T])

(GLDOMSG
  [LAMBDA (OBJECT SELECTOR ARGS)                             (* edited: "28-NOV-82 15:20")

          (* Attempt to compile code for the sending of a message to an object. OBJECT is the destination, in the form 
	  (<code> <type>), SELECTOR is the message selector, and ARGS is a list of arguments of the form 
	  (<code> <type>). The result is of this form, or NIL if failure.)


    (PROG (UNITREC TYPE TMP METHOD TRANS FETCHCODE)
          (SETQ TYPE (GLXTRTYPE (CADR OBJECT)))
          (COND
	    [(SETQ METHOD (GLSTRPROP TYPE (QUOTE MSG)
				     SELECTOR))
	      (RETURN (COND
			[(LISTGET (CDDR METHOD)
				  (QUOTE MESSAGE))
			  (LIST [CONS (QUOTE SEND)
				      (CONS (CAR OBJECT)
					    (CONS SELECTOR (MAPCAR ARGS (FUNCTION CAR]
				(LISTGET (CDDR METHOD)
					 (QUOTE RESULT]
			(T (GLCOMPMSG OBJECT METHOD ARGS CONTEXT]
	    ([AND (SETQ UNITREC (GLUNIT? TYPE))
		  (SETQ TMP (ASSOC (QUOTE MSG)
				   (CADDR UNITREC]
	      (RETURN (APPLY* (CDR TMP)
			      OBJECT SELECTOR ARGS)))
	    [(SETQ TRANS (GLTRANSPARENTTYPES (CADR OBJECT]
	    [[AND (FMEMB TYPE (QUOTE (NUMBER REAL INTEGER)))
		  (FMEMB SELECTOR (QUOTE (+ - * / ^ > < >= <=)))
		  ARGS
		  (NULL (CDR ARGS))
		  (FMEMB (GLXTRTYPE (CADAR ARGS))
			 (QUOTE (NUMBER REAL INTEGER]
	      (RETURN (GLREDUCEARITH SELECTOR OBJECT (CAR ARGS]
	    (T (RETURN)))                                    (* See if the message can be handled by a TRANSPARENT 
							     subobject.)
      B   (COND
	    ((NULL TRANS)
	      (RETURN))
	    ((SETQ TMP (GLDOMSG (LIST (QUOTE *GL*)
				      (GLXTRTYPE (CAR TRANS)))
				SELECTOR ARGS))
	      (SETQ FETCHCODE (GLSTRFN (CAR TRANS)
				       (CADR OBJECT)
				       NIL))
	      (GLSTRVAL TMP (CAR FETCHCODE))
	      (GLSTRVAL TMP (CAR OBJECT))
	      (RETURN TMP))
	    ((SETQ TMP (CDR TMP))
	      (GO B])

(GLDOPROG
  [LAMBDA (EXPR CONTEXT)                                     (* edited: "19-MAY-82 11:36")
                                                             (* "GSN: " "17-Sep-81 14:01")
                                                             (* "GSN: " "13-Aug-81 14:17")
                                                             (* "GSN: " "21-Apr-81 11:23")
                                                             (* Compile a PROG expression.)
    (PROG (PROGLST NEWEXPR RESULT NEXTEXPR TMP RESULTTYPE)
          (pop EXPR)
          (SETQ CONTEXT (CONS NIL CONTEXT))
          (SETQ PROGLST (GLDECL (pop EXPR)
				NIL T CONTEXT NIL))
          (SETQ CONTEXT (CONS NIL CONTEXT))                  (* Compile the contents of the PROG onto NEWEXPR)
                                                             (* Compile the next expression in a PROG.)
      L   (COND
	    ((NULL EXPR)
	      (GO X)))
          (SETQ NEXTEXPR (pop EXPR))
          (COND
	    ((ATOM NEXTEXPR)
	      (SETQ NEWEXPR (CONS NEXTEXPR NEWEXPR))         (* *****)
                                                             (* Set up the context for the label we just found.)
	      (GO L))
	    ((NLISTP NEXTEXPR)
	      (GLERROR (QUOTE GLDOPROG)
		       (LIST "PROG contains bad stuff:" NEXTEXPR))
	      (GO L))
	    ((EQ (CAR NEXTEXPR)
		 (QUOTE *))
	      (SETQ NEWEXPR (CONS NEXTEXPR NEWEXPR))
	      (GO L)))
          [COND
	    ((SETQ TMP (GLPUSHEXPR NEXTEXPR T CONTEXT NIL))
	      (SETQ NEWEXPR (CONS (CAR TMP)
				  NEWEXPR]
          (GO L)
      X   [SETQ RESULT (CONS (QUOTE PROG)
			     (CONS PROGLST (DREVERSE NEWEXPR]
          (RETURN (LIST RESULT RESULTTYPE])

(GLDOPROGN
  [LAMBDA (EXPR)                                             (* edited: " 5-NOV-81 14:31")
                                                             (* Compile a PROGN in the source program.)
    (PROG (RES)
          (SETQ RES (GLPROGN (CDR EXPR)
			     CONTEXT))
          (RETURN (LIST (CONS (CAR EXPR)
			      (CAR RES))
			(CADR RES])

(GLDOPROG1
  [LAMBDA (EXPR CONTEXT)                                     (* edited: "25-JAN-82 17:34")
                                                             (* "GSN: " "13-Aug-81 14:23")
                                                             (* "GSN: " "21-Apr-81 11:28")
                                                             (* Compile a PROG1, whose result is the value of its 
							     first argument.)
    (PROG (RESULT TMP TYPE TYPEFLG)
          (SETQ EXPR (CDR EXPR))
      A   (COND
	    ((NULL EXPR)
	      (RETURN (LIST (CONS (QUOTE PROG1)
				  (DREVERSE RESULT))
			    TYPE)))
	    ((SETQ TMP (GLDOEXPR NIL CONTEXT (NOT TYPEFLG)))
	      (SETQ RESULT (CONS (CAR TMP)
				 RESULT))                    (* Get the result type from the first item of the 
							     PROG1.)
	      (COND
		((NOT TYPEFLG)
		  (SETQ TYPE (CADR TMP))
		  (SETQ TYPEFLG T)))
	      (GO A))
	    (T (GLERROR (QUOTE GLDOPROG1)
			(LIST "PROG1 contains bad subexpression."))
	       (pop EXPR)
	       (GO A])

(GLDOREPEAT
  [LAMBDA (EXPR)                                             (* edited: "26-MAY-82 15:12")
    (PROG (ACTIONS TMP LABEL)
          (pop EXPR)
      A   [COND
	    ((MEMB (CAR EXPR)
		   (QUOTE (UNTIL Until until)))
	      (pop EXPR))
	    ((AND EXPR (SETQ TMP (GLDOEXPR NIL CONTEXT T)))
	      (SETQ ACTIONS (NCONC1 ACTIONS (CAR TMP)))
	      (GO A))
	    (EXPR (RETURN (GLERROR (QUOTE GLDOREPEAT)
				   (LIST "REPEAT contains bad subexpression."]
          [COND
	    ((OR (NULL EXPR)
		 (NULL (SETQ TMP (GLPREDICATE NIL CONTEXT NIL NIL)))
		 EXPR)
	      (GLERROR (QUOTE GLDOREPEAT)
		       (LIST "REPEAT contains no UNTIL or bad UNTIL clause"))
	      (SETQ TMP (LIST T (QUOTE BOOLEAN]
          (SETQ LABEL (GLMKLABEL))
          (RETURN (LIST [CONS (QUOTE PROG)
			      (CONS NIL (CONS LABEL (NCONC1 ACTIONS
							    (LIST (QUOTE COND)
								  (LIST (GLBUILDNOT (CAR TMP))
									(LIST (QUOTE GO)
									      LABEL]
			NIL])

(GLDORETURN
  [LAMBDA (EXPR)                                             (* "GSN: " " 7-Apr-81 11:49")
                                                             (* "GSN: " "25-Jan-81 20:29")
                                                             (* Compile a RETURN, capturing the type of the result as
							     a type of the function result.)
    (PROG (TMP)
          (pop EXPR)
          (COND
	    [(NULL EXPR)
	      (GLADDRESULTTYPE NIL)
	      (RETURN (QUOTE ((RETURN)
			       NIL]
	    (T (SETQ TMP (GLDOEXPR NIL CONTEXT T))
	       (GLADDRESULTTYPE (CADR TMP))
	       (RETURN (LIST (LIST (QUOTE RETURN)
				   (CAR TMP))
			     (CADR TMP])

(GLDOSELECTQ
  [LAMBDA (EXPR CONTEXT)                                     (* edited: "26-AUG-82 09:30")
                                                             (* Compile a SELECTQ. Special treatment is necessary in 
							     order to quote the selectors implicitly.)
    (PROG (RESULT RESULTTYPE TYPEOK KEY TMP TMPB FN)
          (SETQ FN (CAR EXPR))
          [SETQ RESULT (LIST (CAR (GLPUSHEXPR (LIST (CADR EXPR))
					      NIL CONTEXT T]
          (SETQ TYPEOK T)
          (SETQ EXPR (CDDR EXPR))                            (* If the selection criterion is constant, do it 
							     directly.)
          [COND
	    ([OR (SETQ KEY (NUMBERP (CAR RESULT)))
		 (AND (LISTP (CAR RESULT))
		      (EQ (CAAR RESULT)
			  (QUOTE QUOTE))
		      (SETQ KEY (CADAR RESULT]
	      [SETQ TMP (SOME EXPR (FUNCTION (LAMBDA (X)
				  (COND
				    ((ATOM (CAR X))
				      (EQUAL KEY (CAR X)))
				    ((LISTP (CAR X))
				      (MEMBER KEY (CAR X)))
				    (T NIL]
	      [COND
		((OR (NULL TMP)
		     (NULL (CDR TMP)))
		  (SETQ TMPB (GLPROGN (LAST EXPR)
				      CONTEXT)))
		(T (SETQ TMPB (GLPROGN (CDAR TMP)
				       CONTEXT]
	      (RETURN (LIST (CONS (QUOTE PROGN)
				  (CAR TMPB))
			    (CADR TMPB]
      A   [COND
	    ((NULL EXPR)
	      (RETURN (LIST (GLGENCODE (CONS FN RESULT))
			    RESULTTYPE]
          [SETQ RESULT (NCONC1 RESULT (COND
				 ((OR (CDR EXPR)
				      (EQ FN (QUOTE CASEQ)))
				   (SETQ TMP (GLPROGN (CDAR EXPR)
						      CONTEXT))
				   (CONS (CAAR EXPR)
					 (CAR TMP)))
				 (T (SETQ TMP (GLDOEXPR NIL CONTEXT T))
				    (CAR TMP]
          [COND
	    (TYPEOK (COND
		      ((NULL RESULTTYPE)
			(SETQ RESULTTYPE (CADR TMP)))
		      ((EQUAL RESULTTYPE (CADR TMP)))
		      (T (SETQ TYPEOK NIL)
			 (SETQ RESULTTYPE NIL]
          (SETQ EXPR (CDR EXPR))
          (GO A])

(GLDOSEND
  [LAMBDA (EXPRR)                                            (* edited: " 4-JUN-82 15:35")

          (* Compile code for the sending of a message to an object. The syntax of the message expression is 
	  (_ <object> <selector> <arg1>...<argn>), where the _ may optionally be SEND, Send, or send.)


    (PROG (EXPR OBJECT SELECTOR ARGS TMP FNNAME)
          (SETQ FNNAME (CAR EXPRR))
          (SETQ EXPR (CDR EXPRR))
          (SETQ OBJECT (GLPUSHEXPR (LIST (pop EXPR))
				   NIL CONTEXT T))
          (SETQ SELECTOR (pop EXPR))
          [COND
	    ((OR (NULL SELECTOR)
		 (NOT (LITATOM SELECTOR)))
	      (RETURN (GLERROR (QUOTE GLDOSEND)
			       (LIST SELECTOR "is an illegal message Selector."]
                                                             (* Collect arguments of the message, if any.)
      A   (COND
	    [(NULL EXPR)
	      (COND
		((SETQ TMP (GLDOMSG OBJECT SELECTOR ARGS))
		  (RETURN TMP))
		(T                                           (* No message was defined, so just pass it through and 
							     hope one will be defined by runtime.)
		   (RETURN (LIST [GLGENCODE (CONS FNNAME (CONS (CAR OBJECT)
							       (CONS SELECTOR
								     (MAPCAR ARGS
									     (FUNCTION CAR]
				 (CADR OBJECT]
	    ((SETQ TMP (GLDOEXPR NIL CONTEXT T))
	      (SETQ ARGS (NCONC1 ARGS TMP))
	      (GO A))
	    (T (GLERROR (QUOTE GLDOSEND)
			(LIST "A message argument is bad."])

(GLDOSETQ
  [LAMBDA (EXPR)                                             (* "GSN: " " 7-Apr-81 11:52")
                                                             (* "GSN: " "25-Jan-81 17:50")
                                                             (* Compile a SETQ expression)
    (PROG (VAR)
          (pop EXPR)
          (SETQ VAR (pop EXPR))
          (RETURN (GLDOVARSETQ VAR (GLDOEXPR NIL CONTEXT T])

(GLDOTHE
  [LAMBDA (EXPR)                                             (* edited: "20-MAY-82 15:13")
                                                             (* "GSN: " "17-Apr-81 14:53")
                                                             (* Process a THE expression in a list.)
    (PROG (RESULT)
          (SETQ RESULT (GLTHE NIL))
          [COND
	    (EXPR (GLERROR (QUOTE GLDOTHE)
			   (LIST "Stuff left over at end of The expression." EXPR]
          (RETURN RESULT])

(GLDOTHOSE
  [LAMBDA (EXPR)                                             (* edited: "20-MAY-82 15:16")
                                                             (* "GSN: " "17-Apr-81 14:53")
                                                             (* Process a THE expression in a list.)
    (PROG (RESULT)
          (SETQ EXPR (CDR EXPR))
          (SETQ RESULT (GLTHE T))
          [COND
	    (EXPR (GLERROR (QUOTE GLDOTHOSE)
			   (LIST "Stuff left over at end of The expression." EXPR]
          (RETURN RESULT])

(GLDOVARSETQ
  [LAMBDA (VAR RHS)                                          (* edited: " 5-MAY-82 15:51")
                                                             (* "GSN: " "25-Jan-81 18:00")

          (* Compile code to do a SETQ of VAR to the RHS. If the type of VAR is unknown, it is set to the type of RHS.)


    (PROG NIL
          (GLUPDATEVARTYPE VAR (CADR RHS))
          (RETURN (LIST (LIST (QUOTE SETQ)
			      VAR
			      (CAR RHS))
			(CADR RHS])

(GLDOWHILE
  [LAMBDA (EXPR CONTEXT)                                     (* edited: " 4-MAY-82 10:46")
    (PROG (ACTIONS TMP LABEL)
          (SETQ CONTEXT (CONS NIL CONTEXT))
          (pop EXPR)
          [SETQ ACTIONS (LIST (CAR (GLPREDICATE NIL CONTEXT NIL T]
          (COND
	    ((MEMB (CAR EXPR)
		   (QUOTE (DO Do do)))
	      (pop EXPR)))
      A   (COND
	    ((AND EXPR (SETQ TMP (GLDOEXPR NIL CONTEXT T)))
	      (SETQ ACTIONS (NCONC1 ACTIONS (CAR TMP)))
	      (GO A))
	    (EXPR (GLERROR (QUOTE GLDOWHILE)
			   (LIST "Bad stuff in While statement:" EXPR))
		  (pop EXPR)
		  (GO A)))
          (SETQ LABEL (GLMKLABEL))
          (RETURN (LIST [LIST (QUOTE PROG)
			      NIL LABEL (LIST (QUOTE COND)
					      (NCONC1 ACTIONS (LIST (QUOTE GO)
								    LABEL]
			NIL])

(GLED
  [LAMBDA (FN)                                               (* edited: "20-MAY-82 12:48")
                                                             (* "GSN: " "15-Apr-81 16:51")
                                                             (* Edit the compiled version of a GLISP function.)
    (EDITV (GETPROPLIST (OR FN GLLASTFNCOMPILED)))
    FN])

(GLEDS
  [LAMBDA (STR)                                              (* edited: "21-MAY-82 10:20")
                                                             (* "GSN: " "15-Apr-81 16:51")
                                                             (* Edit a GLISP structure description.)
    (EDITV (GETPROP (SETQ GLLASTSTREDITED (OR STR GLLASTSTREDITED))
		    (QUOTE GLSTRUCTURE)))
    STR])

(GLEQUALFN
  [LAMBDA (LHS RHS)                                          (* edited: "16-JUL-82 12:41")
                                                             (* edited: " 7-Jan-81 17:28")
                                                             (* edited: " 6-Jan-81 16:11")
                                                             (* Produce code to test the two sides for equality.)
    (PROG (TMP)
          (RETURN (COND
		    ((SETQ TMP (GLDOMSG LHS (QUOTE =)
					(LIST RHS)))
		      TMP)
		    ((SETQ TMP (GLUSERSTROP LHS (QUOTE =)
					    RHS))
		      TMP)
		    (T (LIST [COND
			       ((NULL (CAR RHS))
				 (LIST (QUOTE NULL)
				       (CAR LHS)))
			       ((NULL (CAR LHS))
				 (LIST (QUOTE NULL)
				       (CAR RHS)))
			       (T (GLGENCODE (LIST (COND
						     ((OR (EQ (CADR LHS)
							      (QUOTE INTEGER))
							  (EQ (CADR RHS)
							      (QUOTE INTEGER)))
						       (QUOTE EQP))
						     ((OR (EQ (CADR LHS)
							      (QUOTE ATOM))
							  (EQ (CADR RHS)
							      (QUOTE ATOM)))
						       (QUOTE EQ))
						     ((AND (EQ (CADR LHS)
							       (QUOTE STRING))
							   (EQ (CADR RHS)
							       (QUOTE STRING)))
						       (QUOTE STREQUAL))
						     (T (QUOTE EQUAL)))
						   (CAR LHS)
						   (CAR RHS]
			     (QUOTE BOOLEAN])

(GLERR
  [NLAMBDA ERREXP                                            (* edited: "23-SEP-82 11:52")
    (PRIN1 "Execution of GLISP error expression: ")
    (PRINT ERREXP)
    (ERROR])

(GLERROR
  [LAMBDA (FN MSGLST)                                        (* edited: "23-SEP-82 11:44")
                                                             (* Print a GLISP error message.
							     The global stack EXPRSTACK is used to help the user 
							     locate the error.)
    (PROG NIL
          (PRIN1 "GLISP error detected by ")
          (PRIN1 FN)
          (PRIN1 " in function ")
          (PRINT FAULTFN)
          [MAPC MSGLST (FUNCTION (LAMBDA (X)
		    (PRIN1 X)
		    (SPACES 1]
          (TERPRI)
          (PRIN1 "in expression: ")
          (RESETFORM (PRINTLEVEL (QUOTE (2 . 20)))
		     (PRINTDEF (CAR EXPRSTACK)
			       15 T T)
		     (TERPRI)
		     (PRIN1 "within expr. ")
		     (PRINTDEF (CADR EXPRSTACK)
			       15 T NIL))
          (TERPRI)
          (COND
	    (GLBREAKONERROR (ERROR)))
          (RETURN (LIST (LIST (QUOTE GLERR)
			      (LIST (QUOTE QUOTE)
				    (CAR EXPRSTACK)))
			NIL])

(GLEXPANDPROGN
  [LAMBDA (LST)                                              (* edited: "23-JUN-82 14:14")
                                                             (* If a PROGN occurs within a PROGN, expand it by 
							     splicing its contents into the top-level list.)
    (MAP LST (FUNCTION (LAMBDA (X)
	     (COND
	       ((NLISTP (CAR X)))
	       ((FMEMB (CAAR X)
		       (QUOTE (PROGN PROG2)))
		 [COND
		   ((CDDAR X)
		     (RPLACD (LAST (CAR X))
			     (CDR X))
		     (RPLACD X (CDDAR X]
		 (RPLACA X (CADAR X)))
	       ([AND (EQ (CAAR X)
			 (QUOTE PROG))
		     (NULL (CADAR X))
		     (EVERY (CDDAR X)
			    (FUNCTION (LAMBDA (Y)
				(NOT (ATOM Y]
		 [COND
		   ((CDDDAR X)
		     (RPLACD (LAST (CAR X))
			     (CDR X))
		     (RPLACD X (CDDDAR X]
		 (RPLACA X (CADDAR X])

(GLEXPENSIVE?
  [LAMBDA (EXPR)                                             (* edited: " 9-JUN-82 12:55")
                                                             (* Test if EXPR is expensive to compute.)
    (COND
      ((ATOM EXPR)
	NIL)
      ((NLISTP EXPR)
	(ERROR))
      ((FMEMB (CAR EXPR)
	      (QUOTE (CDR CDDR CDDDR CDDDDR CAR CAAR CADR CAADR CADDR CADDDR)))
	(GLEXPENSIVE? (CADR EXPR)))
      ((AND (EQ (CAR EXPR)
		(QUOTE PROG1))
	    (NULL (CDDR EXPR)))
	(GLEXPENSIVE? (CADR EXPR)))
      (T T])

(GLFINDVARINCTX
  [LAMBDA (VAR CONTEXT)                                      (* "GSN: " " 2-Jan-81 14:26")
                                                             (* Find the first entry for variable VAR in the CONTEXT 
							     structure.)
    (AND CONTEXT (OR (ASSOC VAR (CAR CONTEXT))
		     (GLFINDVARINCTX VAR (CDR CONTEXT])

(GLFRANZLISPTRANSFM
  [LAMBDA (X)                                                (* edited: "17-NOV-82 11:40")
                                                             (* Transform an expression X for FRANZ LISP dialect.)
    (PROG (TMP NOTFLG)                                       (* First do argument reversals.)
          [COND
	    ((NLISTP X)
	      (RETURN X))
	    [(FMEMB (CAR X)
		    (QUOTE (MAP MAPC MAPCAR MAPCONC MAPLIST MAPCON push PUSH GLSTRGREATERP ALPHORDER))
		    )
	      (SETQ X (LIST (CAR X)
			    (CADDR X)
			    (CADR X]
	    ((FMEMB (CAR X)
		    (QUOTE (PUTPROP)))
	      (SETQ X (LIST (CAR X)
			    (CADR X)
			    (CADDDR X)
			    (CADDR X]                        (* Now see if the result should be negated.)
          [SETQ NOTFLG (FMEMB (CAR X)
			      (QUOTE (ALPHORDER GLSTRGEP NLISTP]
          (COND
	    [[SETQ TMP (FASSOC (CAR X)
			       (QUOTE ((MEMB MEMQ)
					(FMEMB MEMQ)
					(FASSOC ASSQ)
					(LITATOM SYMBOLP)
					(GETPROP GET)
					(GETPROPLIST PLIST)
					(IGREATERP >)
					(IGEQ >=)
					(GEQ >=)
					(ILESSP <)
					(ILEQ <=)
					(LEQ <=)
					(IPLUS +)
					(IDIFFERENCE -)
					(ITIMES *)
					(IQUOTIENT /)
					(ADD1 1+)
					(SUB1 1-)
					(EQP =)              (* COMMENT)
					(MAPCONC MAPCAN)
					(APPLY* FUNCALL)
					(DECLARE COMMENT)
					(NCHARS FLATC)
					(LISTP DTPR)
					(NLISTP DTPR)
					(UNPACK EXPLODE)
					(PACK READLIST)
					(STREQUAL EQUAL)
					(GLSTRLESSP ALPHALESSP)
					(ALPHORDER ALPHALESSP)
					(GLSTRGREATERP ALPHALESSP)
					(GLSTRGEP ALPHALESSP)
					(DREVERSE NREVERSE]
	      (SETQ X (CONS (CADR TMP)
			    (CDR X]
	    ((AND (FMEMB (CAR X)
			 (QUOTE (SOME EVERY)))
		  (NULL (CDDDR X)))
	      (SETQ X (LIST (CAR X)
			    (CADR X)
			    (CADDR X)
			    NIL)))
	    ((AND (FMEMB (CAR X)
			 (QUOTE (APPEND)))
		  (NULL (CDDR X)))
	      (SETQ X (LIST (CAR X)
			    (CADR X)
			    NIL)))
	    [(EQ (CAR X)
		 (QUOTE NTH))
	      (SETQ X (LIST (QUOTE NTHCDR)
			    [COND
			      ((FIXP (CADDR X))
				(SUB1 (CADDR X)))
			      (T (LIST (QUOTE 1-)
				       (CADDR X]
			    (CADR X]
	    [(EQ (CAR X)
		 (QUOTE SELECTQ))
	      (RPLACA X (QUOTE CASEQ))
	      (SETQ TMP (NLEFT X 2))
	      (COND
		((NULL (CADR TMP))
		  (RPLACD TMP NIL))
		(T (RPLACD TMP (LIST (LIST T (CADR TMP]
	    ((EQ (CAR X)
		 (QUOTE PROG))
	      (GLTRANSPROG X)))
          (RETURN (COND
		    (NOTFLG (LIST (QUOTE not)
				  X))
		    (T X])

(GLGENCODE
  [LAMBDA (X)                                                (* edited: "19-OCT-82 15:19")
                                                             (* Generate code of the form X.
							     The code generated by the compiler is transformed, if 
							     necessary, for the output dialect.)
    (SELECTQ GLLISPDIALECT
	     (INTERLISP (GLINTERLISPTRANSFM X))
	     (MACLISP (GLMACLISPTRANSFM X))
	     (FRANZLISP (GLFRANZLISPTRANSFM X))
	     (UCILISP (GLUCILISPTRANSFM X))
	     (PSL (GLPSLTRANSFM X))
	     (ERROR])

(GLGETASSOC
  [LAMBDA (KEY ALST)                                         (* "GSN: " "20-Mar-81 15:52")

          (* Get the value for the entry KEY from the a-list ALST. GETASSOC is used so that the corresponding PUTASSOC can 
	  be generated by GLPUTFN.)


    (PROG (TMP)
          (RETURN (AND (SETQ TMP (ASSOC KEY ALST))
		       (CDR TMP])

(GLGETCONSTDEF
  [LAMBDA (ATM)                                              (* edited: "30-AUG-82 10:25")
    (COND
      [(GETPROP ATM (QUOTE GLISPCONSTANTFLG))
	(LIST (KWOTE (GETPROP ATM (QUOTE GLISPCONSTANTVAL)))
	      (GETPROP ATM (QUOTE GLISPCONSTANTTYPE]
      (T NIL])

(GLGETD
  [LAMBDA (FN)                                               (* edited: "13-JAN-82 16:00")
                                                             (* Get the EXPR definition of FN, if available.)
    (COND
      ((AND (CCODEP FN)
	    (EQ (UNSAVEDEF FN (QUOTE EXPR))
		(QUOTE EXPR)))
	(PRIN1 FN)
	(SPACES 1)
	(PRIN1 "unsaved.")
	(TERPRI)))
    (GETD FN])

(GLGETDB
  [LAMBDA (FN)                                               (* edited: "19-MAY-82 16:11")
                                                             (* Get the function definition of FN, if easily 
							     available, so it can be examined.)
    (OR (AND (EQ (FNTYP FN)
		 (QUOTE EXPR))
	     (GETD FN))
	(GETPROP FN (QUOTE EXPR])

(GLGETDEF
  [LAMBDA (NAME TYPE)                                        (* edited: "30-OCT-81 12:20")
                                                             (* Get the GLISP object description for NAME for the 
							     file package.)
    (LIST (QUOTE GLDEFSTRQ)
	  (CONS NAME (GETPROP NAME (QUOTE GLSTRUCTURE])

(GLGETFIELD
  [LAMBDA (SOURCE FIELD CONTEXT)                             (* edited: " 5-OCT-82 15:06")
                                                             (* edited: "18-Sep-81 13:48")
                                                             (* edited: "13-Aug-81 16:40")
                                                             (* edited: "21-Apr-81 11:26")

          (* Find a way to retrieve the FIELD from the structure pointed to by SOURCE (which may be a variable name, NIL, or
	  a list (CODE DESCR)) relative to CONTEXT. The result is a list of code to get the field and the structure 
	  description of the resulting field.)


    (PROG (TMP CTXENTRY CTXLIST)
          [COND
	    ((NULL SOURCE)
	      (GO B))
	    ((ATOM SOURCE)
	      (COND
		[(SETQ CTXENTRY (GLFINDVARINCTX SOURCE CONTEXT))
		  (COND
		    ((SETQ TMP (GLVALUE SOURCE FIELD (CADDR CTXENTRY)
					NIL))
		      (RETURN TMP))
		    (T (GLERROR (QUOTE GLGETFIELD)
				(LIST "The property" FIELD "cannot be found for" SOURCE 
				      "whose type is"
				      (CADDR CTXENTRY]
		((SETQ TMP (GLGETFIELD NIL SOURCE CONTEXT))
		  (SETQ SOURCE TMP))
		((SETQ TMP (GLGETGLOBALDEF SOURCE))
		  (RETURN (GLGETFIELD TMP FIELD NIL)))
		((SETQ TMP (GLGETCONSTDEF SOURCE))
		  (RETURN (GLGETFIELD TMP FIELD NIL)))
		(T (RETURN (GLERROR (QUOTE GLGETFIELD)
				    (LIST "The name" SOURCE "cannot be found."]
          [COND
	    ((LISTP SOURCE)
	      (COND
		((SETQ TMP (GLVALUE (CAR SOURCE)
				    FIELD
				    (CADR SOURCE)
				    NIL))
		  (RETURN TMP))
		(T (RETURN (GLERROR (QUOTE GLGETFIELD)
				    (LIST "The property" FIELD "cannot be found for type"
					  (CADR SOURCE)
					  "in"
					  (CAR SOURCE]
      B                                                      (* No source is specified. Look for a source in the 
							     context.)
          (COND
	    ((NULL CONTEXT)
	      (RETURN)))
          (SETQ CTXLIST (pop CONTEXT))
      C   (COND
	    ((NULL CTXLIST)
	      (GO B)))
          (SETQ CTXENTRY (pop CTXLIST))
          (COND
	    [(EQ FIELD (CADR CTXENTRY))
	      (RETURN (LIST (CAR CTXENTRY)
			    (CADDR CTXENTRY]
	    ((NULL (SETQ TMP (GLVALUE (CAR CTXENTRY)
				      FIELD
				      (CADDR CTXENTRY)
				      NIL)))
	      (GO C)))
          (RETURN TMP])

(GLGETFROMUNIT
  [LAMBDA (UNITREC IND DES)                                  (* edited: "27-MAY-82 13:01")
                                                             (* "GSN: " " 2-Jun-81 13:46")

          (* Call the appropriate function to compile code to get the indicator (QUOTE IND') from the item whose description
	  is DES, where DES describes a unit in a unit package whose record is UNITREC.)


    (PROG (TMP)
          (COND
	    ((SETQ TMP (ASSOC (QUOTE GET)
			      (CADDR UNITREC)))
	      (RETURN (APPLY* (CDR TMP)
			      IND DES)))
	    (T (RETURN])

(GLGETGLOBALDEF
  [LAMBDA (ATM)                                              (* edited: "23-APR-82 16:58")
    (COND
      [(GETPROP ATM (QUOTE GLISPGLOBALVAR))
	(LIST ATM (GETPROP ATM (QUOTE GLISPGLOBALVARTYPE]
      (T NIL])

(GLGETPAIRS
  [LAMBDA (EXPR)                                             (* edited: " 4-JUN-82 15:36")
                                                             (* edited: "13-Aug-81 12:36")
                                                             (* Get pairs of <field> = <value>, where the = and , are
							     optional.)
    (PROG (PROP VAL PAIRLIST)
      A   (COND
	    ((NULL EXPR)
	      (RETURN PAIRLIST))
	    ([NOT (ATOM (SETQ PROP (pop EXPR]
	      (GLERROR (QUOTE GLGETPAIRS)
		       (LIST PROP "is not a legal property name.")))
	    ((EQ PROP (QUOTE ,))
	      (GO A)))
          (COND
	    ((MEMB (CAR EXPR)
		   (QUOTE (= _ :=)))
	      (pop EXPR)))
          (SETQ VAL (GLDOEXPR NIL CONTEXT T))
          (SETQ PAIRLIST (NCONC1 PAIRLIST (CONS PROP VAL)))
          (GO A])

(GLGETPROP
  [LAMBDA (STR PROPNAME PROPTYPE)                            (* edited: "10-NOV-82 10:11")

          (* Retrieve a GLISP property whose name is PROPNAME and whose property type (ADJ, ISA, PROP, MSG) is PROPTYPE for 
	  the object type STR.)


    (PROG (PL SUBPL PROPENT)
          (RETURN (AND (SETQ PL (GETPROP STR (QUOTE GLSTRUCTURE)))
		       (SETQ SUBPL (LISTGET (CDR PL)
					    PROPTYPE))
		       (SETQ PROPENT (ASSOC PROPNAME SUBPL])

(GLGETSTR
  [LAMBDA (DES)                                              (* edited: "23-DEC-81 12:52")
                                                             (* "GSN: " " 5-Oct-81 13:27")
                                                             (* "GSN: " "24-Apr-81 12:07")
                                                             (* "GSN: " " 7-Jan-81 16:38")
    (PROG (TYPE TMP)
          (RETURN (AND (SETQ TYPE (GLXTRTYPE DES))
		       (ATOM TYPE)
		       (SETQ TMP (GETPROP TYPE (QUOTE GLSTRUCTURE)))
		       (CAR TMP])

(GLGETSUPERS
  [LAMBDA (CLASS)                                            (* edited: "28-NOV-82 15:10")
                                                             (* Get the superclasses of CLASS.)
    (LISTGET (CDR (GETPROP CLASS (QUOTE GLSTRUCTURE)))
	     (QUOTE SUPERS])

(GLIDNAME
  [LAMBDA (NAME DEFAULTFLG)                                  (* edited: "21-MAY-82 17:01")
                                                             (* "GSN: " "13-Aug-81 15:00")
                                                             (* "GSN: " "14-Apr-81 17:04")
                                                             (* Identify a given name as either a known variable name
							     of as an implicit field reference.)
    (PROG (TMP)
          (RETURN (COND
		    [(ATOM NAME)
		      (COND
			((NULL NAME)
			  (LIST NIL NIL))
			[(LITATOM NAME)
			  (COND
			    ((EQ NAME T)
			      (LIST NAME (QUOTE BOOLEAN)))
			    [(SETQ TMP (GLVARTYPE NAME CONTEXT))
			      (LIST NAME (COND
				      ((EQ TMP (QUOTE *NIL*))
					NIL)
				      (T TMP]
			    ((GLGETFIELD NIL NAME CONTEXT))
			    ((SETQ TMP (GLIDTYPE NAME CONTEXT))
			      (LIST (CAR TMP)
				    (CADDR TMP)))
			    ((GLGETCONSTDEF NAME))
			    ((GLGETGLOBALDEF NAME))
			    (T [COND
				 ((OR (NOT DEFAULTFLG)
				      GLCAUTIOUSFLG)
				   (GLERROR (QUOTE GLIDNAME)
					    (LIST "The name" NAME "cannot be found in this context."]
			       (LIST NAME NIL]
			((FIXP NAME)
			  (LIST NAME (QUOTE INTEGER)))
			((FLOATP NAME)
			  (LIST NAME (QUOTE REAL)))
			(T (GLERROR (QUOTE GLIDNAME)
				    (LIST NAME "is an illegal name."]
		    (T NAME])

(GLIDTYPE
  [LAMBDA (NAME CONTEXT)                                     (* edited: "27-MAY-82 13:02")
                                                             (* Try to identify a name by either its referenced name 
							     or its type.)
    (PROG (CTXLEVELS CTXLEVEL CTXENTRY)
          (SETQ CTXLEVELS CONTEXT)
      LPA (COND
	    ((NULL CTXLEVELS)
	      (RETURN)))
          (SETQ CTXLEVEL (pop CTXLEVELS))
      LPB (COND
	    ((NULL CTXLEVEL)
	      (GO LPA)))
          (SETQ CTXENTRY (CAR CTXLEVEL))
          (SETQ CTXLEVEL (CDR CTXLEVEL))
          (COND
	    ([OR (EQ (CADR CTXENTRY)
		     NAME)
		 (EQ (CADDR CTXENTRY)
		     NAME)
		 (AND (LISTP (CADDR CTXENTRY))
		      (GL-A-AN? (CAADDR CTXENTRY))
		      (EQ NAME (CADR (CADDR CTXENTRY]
	      (RETURN CTXENTRY)))
          (GO LPB])

(GLINIT
  [LAMBDA NIL                                                (* edited: " 1-DEC-82 11:10")
                                                             (* Initialize things for GLISP)
    (PROG NIL
          [SETQ GLSEPBITTBL
	    (MAKEBITTABLE (QUOTE (: _ + - ' = ~ < > * / , ^]
          (SETQ GLUNITPKGS NIL)
          (SETQ GLSEPMINUS NIL)
          (SETQ GLQUIETFLG NIL)
          (SETQ GLSEPATOM NIL)
          (SETQ GLSEPPTR 0)
          (SETQ GLBREAKONERROR NIL)
          (SETQ GLUSERSTRNAMES NIL)
          (SETQ GLLASTFNCOMPILED NIL)
          (SETQ GLLASTSTREDITED NIL)
          (SETQ GLCAUTIOUSFLG NIL)
          [MAPC (SELECTQ GLLISPDIALECT
			 (INTERLISP (QUOTE (EQ EQP NEQ EQUAL MEMB AND OR NOT ZEROP NULL NUMBERP FIXP 
					       FLOATP ATOM LITATOM LISTP MINUSP STRINGP FASSOC ASSOC 
					       IGREATERP IGEQ ILESSP ILEQ IPLUS ITIMES IDIFFERENCE 
					       IQUOTIENT ADD1 SUB1 PLUS MINUS IMINUS TIMES SQRT EXPT 
					       DIFFERENCE QUOTIENT GREATERP GEQ LESSP LEQ CAR CDR 
					       CAAR CADR)))
			 (MACLISP (QUOTE (EQ EQP AND OR NOT EQUAL ZEROP NULL NULL NUMBERP FIXP FLOATP 
					     ATOM SYMBOLP PAIRP BIGP HUNKP ASCII PLUSP MINUSP ODDP 
					     GREATERP LESSP MEMQ ASSQ > = MAX MIN ABS FIX FLOAT 
					     REMAINDER GCD \ \\ ^ LOG EXP SIN COS ATAN BOOLE ASH LSH 
					     ROT < + * / - 1+ 1- ADD1 SUB1 PLUS MINUS TIMES SQRT EXPT 
					     DIFFERENCE QUOTIENT CAR CDR CAAR CADR)))
			 (FRANZLISP (QUOTE (EQ NEQ AND OR NOT EQUAL ATOM NULL DTPR SYMBOLP STRINGP 
					       HUNKP MEMQ > = < + * / - 1+ 1- ADD1 SUB1 PLUS MINUS 
					       TIMES SQRT EXPT DIFFERENCE QUOTIENT ABS BOOLE COS 
					       EVENP EXP FIX FIXP FLOAT FLOATP GREATERP LESSP LOG LSH 
					       MAX MIN MINUSP MOD NUMBERP ODDP ONEP REMAINDER ROT SIN 
					       SQRT ZEROP CAR CDR CAAR CADR)))
			 (UCILISP (QUOTE (EQ EQUAL AND OR NOT MEMQ > GE = LE < + * / - ADD1 SUB1 PLUS 
					     MINUS TIMES DIFFERENCE QUOTIENT CAR CDR CAAR CADR)))
			 (PSL (QUOTE (EQ NE EQUAL AND OR NOT MEMQ ADD1 SUB1 EQN ASSOC PLUS MINUS 
					 TIMES SQRT EXPT DIFFERENCE QUOTIENT GREATERP GEQ LESSP LEQ 
					 CAR CDR CAAR CADR)))
			 NIL)
		(FUNCTION (LAMBDA (X)
		    (PUTPROP X (QUOTE GLEVALWHENCONST)
			     T]
          [MAPC (SELECTQ GLLISPDIALECT
			 (INTERLISP (QUOTE (IGREATERP IGEQ ILESSP ILEQ IPLUS ITIMES IDIFFERENCE 
						      IQUOTIENT ADD1 SUB1 PLUS MINUS IMINUS TIMES 
						      SQRT EXPT DIFFERENCE QUOTIENT GREATERP GEQ 
						      LESSP LEQ)))
			 (MACLISP (QUOTE (> = < + * / - 1+ 1- ADD1 SUB1 PLUS MINUS IMINUS TIMES SQRT 
					    EXPT DIFFERENCE QUOTIENT GREATERP LESSP)))
			 (FRANZLISP (QUOTE (> = < + * / - 1+ 1- ADD1 SUB1 PLUS MINUS IMINUS TIMES 
					      SQRT EXPT DIFFERENCE QUOTIENT GREATERP LESSP)))
			 (UCILISP (QUOTE (> GE = LE < + * / - ADD1 SUB1 PLUS MINUS IMINUS TIMES SQRT 
					    EXPT DIFFERENCE QUOTIENT GREATERP LESSP)))
			 (PSL (QUOTE (ADD1 SUB1 EQN PLUS MINUS TIMES SQRT EXPT DIFFERENCE QUOTIENT 
					   GREATERP GEQ LESSP LEQ)))
			 NIL)
		(FUNCTION (LAMBDA (X)
		    (PUTPROP X (QUOTE GLARGSNUMBERP)
			     T]
          [GLDEFFNRESULTTYPES (QUOTE ((NUMBER (PLUS MINUS DIFFERENCE TIMES EXPT QUOTIENT REMAINDER 
						    MIN MAX ABS))
				       (INTEGER (LENGTH FIX ADD1 SUB1))
				       (REAL (SQRT LOG EXP SIN COS ATAN ARCSIN ARCCOS ARCTAN ARCTAN2 
						   FLOAT))
				       (BOOLEAN (ATOM NULL EQUAL MINUSP ZEROP GREATERP LESSP NUMBERP 
						      FIXP FLOATP STRINGP ARRAYP EQ NOT NULL BOUNDP]
          (SELECTQ GLLISPDIALECT
		   [INTERLISP (GLDEFFNRESULTTYPES (QUOTE ((INTEGER (FLENGTH IPLUS NCHARS IMINUS 
									    IDIFFERENCE ITIMES 
									    IQUOTIENT IREMAINDER IMIN 
									    IMAX LOGAND LOGOR LOGXOR 
									    LSH RSH LRSH LLSH GCD 
									    COUNT COUNTDOWN NARGS))
							   (BOOLEAN (LISTP IGREATERP SMALLP FGREATERP 
									   FLESSP GEQ LEQ LITATOM 
									   NLISTP NEQ ILESSP IGEQ 
									   ILEQ IEQP CCODEP SCODEP 
									   SUBRP EVERY EQUALALL 
									   EQLENGTH EQUALN EXPRP EQP))
							   (REAL (RAND RANDSET]
		   [MACLISP (GLDEFFNRESULTTYPES (QUOTE ((INTEGER (+ - * / 1+ 1- FLATC))
							 (BOOLEAN (> PAIRP HUNKP BIGP EQP
								     < = SYMBOLP]
		   [FRANZLISP (GLDEFFNRESULTTYPES (QUOTE ((INTEGER (+ - * / 1+ 1- FLATC))
							   (BOOLEAN (> BIGP HUNKP
								       < = DTPR SYMBOLP]
		   [UCILISP (GLDEFFNRESULTTYPES (QUOTE ((INTEGER (+ - * / ADD1 SUB1 FLATSIZE 
								    FLATSIZEC))
							 (BOOLEAN (CONSP GE LE INUMP]
		   [PSL (GLDEFFNRESULTTYPES (QUOTE ((INTEGER (FLATSIZE FLATSIZE2))
						     (BOOLEAN (EQN NE PAIRP IDP UNBOUNDP]
		   NIL)
          (GLDEFFNRESULTTYPEFNS (QUOTE ((NTH . GLNTHRESULTTYPEFN)
					 (CONS . GLLISTRESULTTYPEFN)
					 (LIST . GLLISTRESULTTYPEFN)
					 (NCONC . GLLISTRESULTTYPEFN])

(GLINSTANCEFN
  [LAMBDA (FNNAME ARGTYPES)                                  (* edited: "26-JUL-82 17:07")
                                                             (* Look up an instance function of an abstract function 
							     name which takes arguments of the specified types.)
    (PROG (INSTANCES IARGS TMP)
          (OR (SETQ INSTANCES (GETPROP FNNAME (QUOTE GLINSTANCEFNS)))
	      (RETURN))                                      (* Get ultimate data types for arguments.)
      LP  (COND
	    ((NULL INSTANCES)
	      (RETURN)))
          (SETQ IARGS (GETPROP (CAAR INSTANCES)
			       (QUOTE GLARGUMENTTYPES)))
          (SETQ TMP ARGTYPES)                                (* Match the ultimate types of each argument.)
      LPB (COND
	    ((NULL IARGS)
	      (RETURN (CAR INSTANCES)))
	    ((EQUAL (GLXTRTYPEB (CAR IARGS))
		    (GLXTRTYPEB (CAR TMP)))
	      (SETQ IARGS (CDR IARGS))
	      (SETQ TMP (CDR TMP))
	      (GO LPB)))
          (SETQ INSTANCES (CDR INSTANCES))
          (GO LP])

(GLINTERLISPTRANSFM
  [LAMBDA (X)                                                (* edited: "12-NOV-82 11:46")
                                                             (* Transform an expression X for INTERLISP dialect.)
    (PROG (TMP NOTFLG)                                       (* First do argument reversals.)
          [COND
	    ((NLISTP X)
	      (RETURN X))
	    ((FMEMB (CAR X)
		    (QUOTE (GLSTRLESSP GLSTRGEP)))
	      (SETQ X (LIST (CAR X)
			    (CADDR X)
			    (CADR X]                         (* Now see if the result should be negated.)
          [SETQ NOTFLG (FMEMB (CAR X)
			      (QUOTE (GLSTRGREATERP GLSTRLESSP]
          [COND
	    [[SETQ TMP (FASSOC (CAR X)
			       (QUOTE ((GLSTRLESSP ALPHORDER)
					(GLSTRGREATERP ALPHORDER)
					(GLSTRGEP ALPHORDER]
	      (SETQ X (CONS (CADR TMP)
			    (CDR X]
	    ((AND (EQ (CAR X)
		      (QUOTE NTH))
		  (NUMBERP (CADDR X)))
	      (COND
		((ZEROP (CADDR X))
		  (SETQ X (CADR X)))
		((ILESSP (CADDR X)
			 5)
		  (SETQ X (LIST [CAR (NTH (QUOTE (CDR CDDR CDDDR CDDDDR))
					  (SUB1 (CADDR X]
				(CADR X]
          (RETURN (COND
		    (NOTFLG (LIST (QUOTE NOT)
				  X))
		    (T X])

(GLISPCONSTANTS
  [NLAMBDA ARGS                                              (* edited: "30-AUG-82 10:28")
                                                             (* Define compile-time constants.)
    (PROG (TMP EXPR EXPRSTACK FAULTFN)
          (MAPC ARGS (FUNCTION (LAMBDA (ARG)
		    (PUTPROP (CAR ARG)
			     (QUOTE GLISPCONSTANTFLG)
			     T)
		    (PUTPROP (CAR ARG)
			     (QUOTE GLISPORIGCONSTVAL)
			     (CADR ARG))
		    [PUTPROP (CAR ARG)
			     (QUOTE GLISPCONSTANTVAL)
			     (PROGN (SETQ EXPR (LIST (CADR ARG)))
				    (SETQ TMP (GLDOEXPR NIL NIL T))
				    (SET (CAR ARG)
					 (EVAL (CAR TMP]
		    (PUTPROP (CAR ARG)
			     (QUOTE GLISPCONSTANTTYPE)
			     (OR (CADDR ARG)
				 (CADR TMP])

(GLISPGLOBALS
  [NLAMBDA ARGS                                              (* edited: "26-MAY-82 15:30")
                                                             (* Define compile-time constants.)
    (MAPC ARGS (FUNCTION (LAMBDA (ARG)
	      (PUTPROP (CAR ARG)
		       (QUOTE GLISPGLOBALVAR)
		       T)
	      (PUTPROP (CAR ARG)
		       (QUOTE GLISPGLOBALVARTYPE)
		       (CADR ARG])

(GLISPOBJECTS
  [NLAMBDA ARGS                                              (* edited: "26-MAY-82 15:30")
                                                             (* "GSN: " "17-Sep-81 11:44")
                                                             (* "GSN: " "24-Apr-81 12:09")
                                                             (* "GSN: " " 7-Jan-81 10:48")

          (* Define named structure descriptions. The descriptions are of the form (<name> <description>). Each description 
	  is put on the property list of <name> as GLSTRUCTURE)


    (MAPC ARGS (FUNCTION (LAMBDA (ARG)
	      (GLDEFSTR ARG])

(GLLISPADJ
  [LAMBDA (ADJ)                                              (* edited: " 2-NOV-82 11:24")
                                                             (* Test the word ADJ to see if it is a LISP adjective.
							     If so, return the name of the function to test it.)
    (PROG (TMP)
          (RETURN (AND [SETQ TMP (FASSOC (U-CASE ADJ)
					 (QUOTE ((ATOMIC . ATOM)
						  (NULL . NULL)
						  (NIL . NULL)
						  (INTEGER . FIXP)
						  (REAL . FLOATP)
						  (BOUND . BOUNDP)
						  (ZERO . ZEROP)
						  (NUMERIC . NUMBERP)
						  (NEGATIVE . MINUSP)
						  (MINUS . MINUSP]
		       (CDR TMP])

(GLLISPISA
  [LAMBDA (ISAWORD)                                          (* edited: " 2-NOV-82 11:23")
                                                             (* Test to see if ISAWORD is a LISP ISA word.
							     If so, return the name of the function to test for it.)
    (PROG (TMP)
          (RETURN (AND [SETQ TMP (FASSOC (U-CASE ISAWORD)
					 (QUOTE ((ATOM . ATOM)
						  (LIST . LISTP)
						  (NUMBER . NUMBERP)
						  (INTEGER . FIXP)
						  (SYMBOL . LITATOM)
						  (ARRAY . ARRAYP)
						  (STRING . STRINGP)
						  (BIGNUM . BIGP)
						  (LITATOM . LITATOM]
		       (CDR TMP])

(GLLISTRESULTTYPEFN
  [LAMBDA (FN ARGTYPES)                                      (* edited: "12-NOV-82 10:53")
                                                             (* Compute result types for Lisp functions.)
    (PROG (ARG1 ARG2)
          (SETQ ARG1 (GLXTRTYPE (CAR ARGTYPES)))
          [COND
	    ((CDR ARGTYPES)
	      (SETQ ARG2 (GLXTRTYPE (CADR ARGTYPES]
          (RETURN (SELECTQ FN
			   (CONS (OR (AND (LISTP ARG2)
					  (COND
					    [(EQ (CAR ARG2)
						 (QUOTE LIST))
					      (CONS (QUOTE LIST)
						    (CONS ARG1 (CDR ARG2]
					    ((AND (EQ (CAR ARG2)
						      (QUOTE LISTOF))
						  (EQUAL ARG1 (CADR ARG2)))
					      ARG2)))
				     (LIST FN ARGTYPES)))
			   [NCONC (COND
				    ((EQUAL ARG1 ARG2)
				      ARG1)
				    ((AND (LISTP ARG1)
					  (LISTP ARG2)
					  (EQ (CAR ARG1)
					      (QUOTE LISTOF))
					  (EQ (CAR ARG2)
					      (QUOTE LIST))
					  (NULL (CDDR ARG2))
					  (EQUAL (CADR ARG1)
						 (CADR ARG2)))
				      ARG1)
				    (T (OR ARG1 ARG2]
			   [LIST (CONS FN (MAPCAR ARGTYPES (FUNCTION GLXTRTYPE]
			   (ERROR])

(GLLISTSTRFN
  [LAMBDA (IND DES DESLIST)                                  (* edited: "10-NOV-82 11:17")
                                                             (* Create a function call to retrieve the field IND from
							     a LIST structure.)
    (PROG (TMP N FNLST)
          (SETQ N 1)
          [SETQ FNLST (QUOTE ((CAR *GL*)
			       (CADR *GL*)
			       (CADDR *GL*)
			       (CADDDR *GL*]
          [COND
	    ((EQ (CAR DES)
		 (QUOTE LISTOBJECT))
	      (SETQ N (ADD1 N))
	      (SETQ FNLST (CDR FNLST]
      C   (pop DES)
          [COND
	    ((NULL DES)
	      (RETURN))
	    ((NLISTP (CAR DES)))
	    ((SETQ TMP (GLSTRFN IND (CAR DES)
				DESLIST))
	      (RETURN (GLSTRVAL TMP (COND
				  (FNLST (CAR FNLST))
				  (T (LIST (QUOTE CAR)
					   (GLGENCODE (LIST (QUOTE NTH)
							    (QUOTE *GL*)
							    N]
          (SETQ N (ADD1 N))
          (AND FNLST (SETQ FNLST (CDR FNLST)))
          (GO C])

(GLMACLISPTRANSFM
  [LAMBDA (X)                                                (* edited: " 1-DEC-82 14:46")
                                                             (* Transform an expression X for MACLISP dialect.)
    (PROG (TMP NOTFLG)                                       (* First do argument reversals.)
          [COND
	    ((NLISTP X)
	      (RETURN X))
	    [(FMEMB (CAR X)
		    (QUOTE (MAP MAPC MAPCAR MAPCONC MAPLIST MAPCON push PUSH SOME EVERY SUBSET 
				GLSTRGREATERP ALPHORDER)))
	      (SETQ X (LIST (CAR X)
			    (CADDR X)
			    (CADR X]
	    ((FMEMB (CAR X)
		    (QUOTE (PUTPROP)))
	      (SETQ X (LIST (CAR X)
			    (CADR X)
			    (CADDDR X)
			    (CADDR X]                        (* Now see if the result will be negated.)
          [SETQ NOTFLG (FMEMB (CAR X)
			      (QUOTE (ALPHORDER GLSTRGEP NEQ NLISTP]
          (COND
	    [[SETQ TMP (FASSOC (CAR X)
			       (QUOTE ((MEMB MEMQ)
					(FMEMB MEMQ)
					(FASSOC ASSQ)
					(LITATOM SYMBOLP)
					(GETPROP GET)
					(GETPROPLIST PLIST)
					(LISTP PAIRP)
					(NLISTP PAIRP)
					(NEQ EQ)
					(IGREATERP >)
					(IGEQ >=)
					(GEQ >=)
					(ILESSP <)
					(ILEQ <=)
					(LEQ <=)
					(IPLUS +)
					(IDIFFERENCE -)
					(ITIMES *)
					(IQUOTIENT //)
					(ADD1 1+)
					(SUB1 1-)            (* COMMENT)
					(MAPCONC MAPCAN)
					(APPLY* FUNCALL)
					(DECLARE COMMENT)
					(NCHARS FLATC)
					(UNPACK EXPLODE)
					(PACK READLIST)
					(DREVERSE NREVERSE)
					(STREQUAL EQUAL)
					(ALPHORDER ALPHALESSP)
					(GLSTRGREATERP ALPHALESSP)
					(GLSTRGEP ALPHALESSP)
					(GLSTRLESSP ALPHALESSP]
	      (SETQ X (CONS (CADR TMP)
			    (CDR X]
	    ((AND (EQ (CAR X)
		      (QUOTE RETURN))
		  (NULL (CDR X)))
	      (SETQ X (LIST (CAR X)
			    NIL)))
	    ((AND (EQ (CAR X)
		      (QUOTE APPEND))
		  (NULL (CDDR X)))
	      (SETQ X (LIST (CAR X)
			    (CADR X)
			    NIL)))
	    [(EQ (CAR X)
		 (QUOTE SELECTQ))
	      (RPLACA X (QUOTE CASEQ))
	      (SETQ TMP (NLEFT X 2))
	      (COND
		((NULL (CADR TMP))
		  (RPLACD TMP NIL))
		(T (RPLACD TMP (LIST (LIST T (CADR TMP]
	    [(EQ (CAR X)
		 (QUOTE NTH))
	      (SETQ X (LIST (QUOTE NTHCDR)
			    [COND
			      ((FIXP (CADDR X))
				(SUB1 (CADDR X)))
			      (T (LIST (QUOTE 1-)
				       (CADDR X]
			    (CADR X]
	    ((EQ (CAR X)
		 (QUOTE PROG))
	      (GLTRANSPROG X)))
          (RETURN (COND
		    (NOTFLG (LIST (QUOTE NOT)
				  X))
		    (T X])

(GLMAKEFORLOOP
  [LAMBDA (LOOPVAR DOMAIN LOOPCONTENTS LOOPCOND COLLECTCODE)
                                                             (* edited: "24-AUG-82 17:36")
                                                             (* edited: "21-Apr-81 11:25")
                                                             (* Compile code for a FOR loop.)
    (COND
      ((NULL COLLECTCODE)
	(LIST [GLGENCODE (LIST (QUOTE MAPC)
			       (CAR DOMAIN)
			       (LIST (QUOTE FUNCTION)
				     (LIST (QUOTE LAMBDA)
					   (LIST LOOPVAR)
					   (COND
					     (LOOPCOND (LIST (QUOTE COND)
							     (CONS (CAR LOOPCOND)
								   LOOPCONTENTS)))
					     ((NULL (CDR LOOPCONTENTS))
					       (CAR LOOPCONTENTS))
					     (T (CONS (QUOTE PROGN)
						      LOOPCONTENTS]
	      NIL))
      (T (LIST [COND
		 [LOOPCOND (GLGENCODE (LIST (QUOTE MAPCONC)
					    (CAR DOMAIN)
					    (LIST (QUOTE FUNCTION)
						  (LIST (QUOTE LAMBDA)
							(LIST LOOPVAR)
							(LIST (QUOTE AND)
							      (CAR LOOPCOND)
							      (LIST (QUOTE CONS)
								    (CAR COLLECTCODE)
								    NIL]
		 [(AND (LISTP (CAR COLLECTCODE))
		       (ATOM (CAAR COLLECTCODE))
		       (CDAR COLLECTCODE)
		       (EQ (CADAR COLLECTCODE)
			   LOOPVAR)
		       (NULL (CDDAR COLLECTCODE)))
		   (GLGENCODE (LIST (QUOTE MAPCAR)
				    (CAR DOMAIN)
				    (LIST (QUOTE FUNCTION)
					  (CAAR COLLECTCODE]
		 (T (GLGENCODE (LIST (QUOTE MAPCAR)
				     (CAR DOMAIN)
				     (LIST (QUOTE FUNCTION)
					   (LIST (QUOTE LAMBDA)
						 (LIST LOOPVAR)
						 (CAR COLLECTCODE]
	       (LIST (QUOTE LISTOF)
		     (CADR COLLECTCODE])

(GLMAKEGLISPVERSION
  [LAMBDA (OUTPUTDIALECT FILE)                               (* edited: "19-OCT-82 15:35")
                                                             (* Make a version of GLISP for another LISP dialect.)
    (PROG (FNS DIALECTS)
          (SETQ DIALECTS (QUOTE (MACLISP FRANZLISP UCILISP PSL)))
          (COND
	    ((NOT (MEMB OUTPUTDIALECT DIALECTS))
	      (ERROR "Dialect must be a member of " DIALECTS)))
          (LOAD? (QUOTE LISPTRANS.LSP))                      (* Make a list of the functions to be translated.)
          (SETQ FNS (LDIFFERENCE (CDAR GLISPCOMS)
				 GLSPECIALFNS))              (* Count arguments of each function for error checking.)
          (MAPC FNS (FUNCTION COUNTARGS))                    (* Unbreak everything so we don't print broken 
							     definitions.)
          (UNBREAK)
          (RETURN (LTRANFNS FNS FILE])

(GLMAKESTR
  [LAMBDA (TYPE EXPR)                                        (* edited: "10-NOV-82 17:14")
                                                             (* Compile code to create a structure in response to a 
							     statement "(A <structure> WITH <field> = <value> ...)")
    (PROG (PAIRLIST STRDES)
          (COND
	    ((MEMB (CAR EXPR)
		   (QUOTE (WITH With with)))
	      (pop EXPR)))
          [COND
	    ((NULL (SETQ STRDES (GLGETSTR TYPE)))
	      (GLERROR (QUOTE GLMAKESTR)
		       (LIST "The type name" TYPE "is not defined."]
          [COND
	    ((EQ (CAR STRDES)
		 (QUOTE LISTOF))
	      (RETURN (CONS (QUOTE LIST)
			    (MAPCAR EXPR (FUNCTION (LAMBDA (EXPR)
					(GLDOEXPR NIL CONTEXT T]
          (SETQ PAIRLIST (GLGETPAIRS EXPR))
          (RETURN (LIST (GLBUILDSTR STRDES PAIRLIST (LIST TYPE))
			TYPE])

(GLMAKEVTYPE
  [LAMBDA (ORIGTYPE VLIST)                                   (* edited: "26-OCT-82 09:54")
                                                             (* Make a virtual type for a view of the original type.)
    (PROG (SUPER PL PNAME TMP VTYPE)
          (SETQ SUPER (CADR VLIST))
          (SETQ VLIST (CDDR VLIST))
          [COND
	    ((MEMB (CAR VLIST)
		   (QUOTE (with With WITH)))
	      (SETQ VLIST (CDR VLIST]
      LP  (COND
	    ((NULL VLIST)
	      (GO OUT)))
          (SETQ PNAME (CAR VLIST))
          (SETQ VLIST (CDR VLIST))
          [COND
	    ((EQ (CAR VLIST)
		 (QUOTE =))
	      (SETQ VLIST (CDR VLIST]
          (SETQ TMP NIL)
      LPB (COND
	    ((OR (NULL VLIST)
		 (EQ (CAR VLIST)
		     (QUOTE ,)))
	      (SETQ VLIST (CDR VLIST))
	      (SETQ PL (CONS (LIST PNAME (DREVERSE TMP))
			     PL))
	      (GO LP)))
          (SETQ TMP (CONS (CAR VLIST)
			  TMP))
          (SETQ VLIST (CDR VLIST))
          (GO LPB)
      OUT (SETQ VTYPE (GLMKVTYPE))
          (PUTPROP VTYPE (QUOTE GLSTRUCTURE)
		   (LIST (LIST (QUOTE TRANSPARENT)
			       ORIGTYPE)
			 (QUOTE PROP)
			 PL
			 (QUOTE SUPERS)
			 (LIST SUPER)))
          (RETURN VTYPE])

(GLMINUSFN
  [LAMBDA (LHS)                                              (* edited: "26-MAY-82 15:33")
                                                             (* Construct the NOT of the argument LHS.)
    (OR (GLDOMSG LHS (QUOTE MINUS)
		 NIL)
	(GLUSERSTROP LHS (QUOTE MINUS)
		     NIL)
	(LIST [GLGENCODE (COND
			   ((NUMBERP (CAR LHS))
			     (MINUS (CAR LHS)))
			   ((EQ (GLXTRTYPE (CADR LHS))
				(QUOTE INTEGER))
			     (LIST (QUOTE IMINUS)
				   (CAR LHS)))
			   (T (LIST (QUOTE MINUS)
				    (CAR LHS]
	      (CADR LHS])

(GLMKATOM
  [LAMBDA (NAME)                                             (* edited: "11-NOV-82 11:54")
                                                             (* Make a variable name for GLCOMP functions.)
    (PROG (N NEWATOM)
      LP  [PUTPROP NAME (QUOTE GLISPATOMNUMBER)
		   (SETQ N (ADD1 (OR (GETPROP NAME (QUOTE GLISPATOMNUMBER))
				     0]
          [SETQ NEWATOM (PACK (APPEND (UNPACK NAME)
				      (UNPACK N]             (* If an atom with this name has something on its 
							     proplist, try again.)
          (COND
	    ((GETPROPLIST NEWATOM)
	      (GO LP))
	    (T (RETURN NEWATOM])

(GLMKLABEL
  [LAMBDA NIL                                                (* edited: "27-MAY-82 11:02")
                                                             (* Make a variable name for GLCOMP functions.)
    (PROG NIL
          (SETQ GLNATOM (ADD1 GLNATOM))
          (RETURN (PACK (APPEND (QUOTE (G L L A B E L))
				(UNPACK GLNATOM])

(GLMKVAR
  [LAMBDA NIL                                                (* edited: "27-MAY-82 11:04")
                                                             (* Make a variable name for GLCOMP functions.)
    (PROG NIL
          (SETQ GLNATOM (ADD1 GLNATOM))
          (RETURN (PACK (APPEND (QUOTE (G L V A R))
				(UNPACK GLNATOM])

(GLMKVTYPE
  [LAMBDA NIL                                                (* edited: "18-NOV-82 11:58")
                                                             (* Make a virtual type name for GLCOMP functions.)
    (GLMKATOM (QUOTE GLVIRTUALTYPE])

(GLNCONCFN
  [LAMBDA (LHS RHS)                                          (* edited: " 1-JUN-82 14:26")
                                                             (* edited: " 2-Jun-81 14:18")
                                                             (* edited: "21-Apr-81 11:26")

          (* Produce a function to implement the _+ operator. Code is produced to append the right-hand side to the 
	  left-hand side. Note: parts of the structure provided are used multiple times.)


    (PROG (LHSCODE LHSDES NCCODE TMP STR)
          (SETQ LHSCODE (CAR LHS))
          (SETQ LHSDES (GLXTRTYPE (CADR LHS)))
          (COND
	    [(EQ LHSDES (QUOTE INTEGER))
	      (COND
		((EQP (CAR RHS)
		      1)
		  (SETQ NCCODE (LIST (QUOTE ADD1)
				     LHSCODE)))
		[(OR (FIXP (CAR RHS))
		     (EQ (CADR RHS)
			 (QUOTE INTEGER)))
		  (SETQ NCCODE (LIST (QUOTE IPLUS)
				     LHSCODE
				     (CAR RHS]
		(T (SETQ NCCODE (LIST (QUOTE PLUS)
				      LHSCODE
				      (CAR RHS]
	    [(OR (EQ LHSDES (QUOTE NUMBER))
		 (EQ LHSDES (QUOTE REAL)))
	      (SETQ NCCODE (LIST (QUOTE PLUS)
				 LHSCODE
				 (CAR RHS]
	    [(EQ LHSDES (QUOTE BOOLEAN))
	      (SETQ NCCODE (LIST (QUOTE OR)
				 LHSCODE
				 (CAR RHS]
	    [(NULL LHSDES)
	      (SETQ NCCODE (LIST (QUOTE NCONC1)
				 LHSCODE
				 (CAR RHS)))
	      (COND
		((AND (ATOM LHSCODE)
		      (CADR RHS))
		  (GLADDSTR LHSCODE NIL (LIST (QUOTE LISTOF)
					      (CADR RHS))
			    CONTEXT]
	    [(AND (LISTP LHSDES)
		  (EQ (CAR LHSDES)
		      (QUOTE LISTOF)))
	      (SETQ NCCODE (LIST (QUOTE NCONC1)
				 LHSCODE
				 (CAR RHS]
	    ((SETQ TMP (GLUNITOP LHS RHS (QUOTE NCONC)))
	      (RETURN TMP))
	    ((SETQ TMP (GLDOMSG LHS (QUOTE _+)
				(LIST RHS)))
	      (RETURN TMP))
	    ((SETQ TMP (GLDOMSG LHS (QUOTE +)
				(LIST RHS)))
	      (SETQ NCCODE (CAR TMP)))
	    ((AND (SETQ STR (GLGETSTR LHSDES))
		  (SETQ TMP (GLNCONCFN (LIST (CAR LHS)
					     STR)
				       RHS)))
	      (RETURN TMP))
	    ((SETQ TMP (GLUSERSTROP LHS (QUOTE _+)
				    RHS))
	      (RETURN TMP))
	    (T (RETURN)))
          (RETURN (GLPUTFN LHS (LIST (GLGENCODE NCCODE)
				     LHSDES)
			   T])

(GLNEQUALFN
  [LAMBDA (LHS RHS)                                          (* edited: "16-JUL-82 12:48")
                                                             (* edited: " 6-Jan-81 16:11")
                                                             (* Produce code to test the two sides for inequality.)
    (PROG (TMP)
          (COND
	    ((SETQ TMP (GLDOMSG LHS (QUOTE ~=)
				(LIST RHS)))
	      (RETURN TMP))
	    ((SETQ TMP (GLUSERSTROP LHS (QUOTE ~=)
				    RHS))
	      (RETURN TMP))
	    [(OR (EQ (CADR LHS)
		     (QUOTE ATOM))
		 (EQ (CADR RHS)
		     (QUOTE ATOM)))
	      (RETURN (LIST (GLGENCODE (LIST (QUOTE NEQ)
					     (CAR LHS)
					     (CAR RHS)))
			    (QUOTE BOOLEAN]
	    (T (RETURN (LIST [GLGENCODE (LIST (QUOTE NOT)
					      (CAR (GLEQUALFN LHS RHS]
			     (QUOTE BOOLEAN])

(GLNOTFN
  [LAMBDA (LHS)                                              (* edited: " 3-MAY-82 14:35")
                                                             (* Construct the NOT of the argument LHS.)
    (OR (GLDOMSG LHS (QUOTE ~)
		 NIL)
	(GLUSERSTROP LHS (QUOTE ~)
		     NIL)
	(LIST (GLBUILDNOT (CAR LHS))
	      (QUOTE BOOLEAN])

(GLNTHRESULTTYPEFN
  [LAMBDA (FN ARGTYPES)                                      (* edited: "23-JUN-82 14:31")
                                                             (* Compute the result type for the function NTH.)
    (PROG (TMP)
          (RETURN (COND
		    ((AND [LISTP (SETQ TMP (GLXTRTYPE (CAR ARGTYPES]
			  (EQ (CAR TMP)
			      (QUOTE LISTOF)))
		      (CAR ARGTYPES))
		    (T NIL])

(GLOCCURS
  [LAMBDA (X STR)                                            (* edited: " 3-JUN-82 11:02")
                                                             (* See if X occurs in STR, using EQ.)
    (COND
      ((EQ X STR)
	T)
      ((NLISTP STR)
	NIL)
      (T (OR (GLOCCURS X (CAR STR))
	     (GLOCCURS X (CDR STR])

(GLOKSTR?
  [LAMBDA (STR)                                              (* edited: "10-NOV-82 11:05")
                                                             (* Check a structure description for legality.)
    (COND
      ((NULL STR)
	NIL)
      ((ATOM STR)
	T)
      [(AND (LISTP STR)
	    (ATOM (CAR STR)))
	(SELECTQ (CAR STR)
		 [(A AN a an An)
		   (COND
		     ((CDDR STR)
		       NIL)
		     ((OR (GLGETSTR (CADR STR))
			  (GLUNIT? (CADR STR))
			  (COND
			    (GLCAUTIOUSFLG (PRIN1 "The structure ")
					   (PRIN1 (CADR STR))
					   (PRIN1 " is not currently defined.  Accepted.")
					   (TERPRI)
					   T)
			    (T T]
		 [CONS (AND (CDR STR)
			    (CDDR STR)
			    (NULL (CDDDR STR))
			    (GLOKSTR? (CADR STR))
			    (GLOKSTR? (CADDR STR]
		 [(LIST OBJECT ATOMOBJECT LISTOBJECT)
		   (AND (CDR STR)
			(EVERY (CDR STR)
			       (FUNCTION GLOKSTR?]
		 [RECORD (COND
			   ((AND (CDR STR)
				 (ATOM (CADR STR)))
			     (pop STR)))
			 (AND (CDR STR)
			      (EVERY (CDR STR)
				     (FUNCTION (LAMBDA (X)
					 (AND (ATOM (CAR X))
					      (GLOKSTR? (CADR X]
		 [LISTOF (AND (CDR STR)
			      (NULL (CDDR STR))
			      (GLOKSTR? (CADR STR]
		 [(ALIST PROPLIST)
		   (AND (CDR STR)
			(EVERY (CDR STR)
			       (FUNCTION (LAMBDA (X)
				   (AND (ATOM (CAR X))
					(GLOKSTR? (CADR X]
		 (ATOM (GLATMSTR? STR))
		 (COND
		   ((AND (CDR STR)
			 (NULL (CDDR STR)))
		     (GLOKSTR? (CADR STR)))
		   ((ASSOC (CAR STR)
			   GLUSERSTRNAMES))
		   (T NIL]
      (T NIL])

(GLOPERAND
  [LAMBDA NIL                                                (* edited: "30-DEC-81 16:41")
                                                             (* "GSN: " "17-Sep-81 14:00")
                                                             (* "GSN: " " 9-Apr-81 12:12")

          (* Get the next operand from the input list, EXPR (global). The operand may be an atom (possibly containing 
	  operators) or a list.)


    (PROG NIL
          (COND
	    ((SETQ FIRST (GLSEPNXT))
	      (RETURN (GLPARSNFLD)))
	    ((NULL EXPR)
	      (RETURN))
	    [(STRINGP (CAR EXPR))
	      (RETURN (LIST (pop EXPR)
			    (QUOTE STRING]
	    ((ATOM (CAR EXPR))
	      (GLSEPINIT (pop EXPR))
	      (SETQ FIRST (GLSEPNXT))
	      (RETURN (GLPARSNFLD)))
	    (T (RETURN (GLPUSHEXPR (pop EXPR)
				   T CONTEXT T])

(GLOPERATOR?
  [LAMBDA (ATM)                                              (* edited: "30-OCT-82 14:35")
                                                             (* Test if an atom is a GLISP operator)
    (FMEMB ATM
	   (QUOTE (_ := __ + - * / > < >= <= ^ _+ +_ _- -_ = ~= <> AND And and OR Or or __+ __- _+_])

(GLORFN
  [LAMBDA (LHS RHS)                                          (* edited: "30-APR-82 10:46")
                                                             (* "GSN: " " 8-Jan-81 17:05")
                                                             (* OR operator)
    (COND
      ((GLDOMSG LHS (QUOTE OR)
		(LIST RHS)))
      ((GLUSERSTROP LHS (QUOTE OR)
		    RHS))
      (T (LIST (LIST (QUOTE OR)
		     (CAR LHS)
		     (CAR RHS))
	       (COND
		 ((EQUAL (GLXTRTYPE (CADR LHS))
			 (GLXTRTYPE (CADR RHS)))
		   (CADR LHS))
		 (T NIL])

(GLP
  [LAMBDA (FUN)                                              (* edited: "29-APR-82 09:42")
                                                             (* Prettyprint the compiled version of a function)
    (PROG (FN)
          (SETQ FN (OR FUN GLLASTFNCOMPILED))
          (PRIN1 "GLRESULTTYPE: ")
          (PRINT (GETPROP FN (QUOTE GLRESULTTYPE)))
          (PRINTDEF (GETPROP FN (QUOTE GLCOMPILED)))
          (TERPRI)
          (RETURN FN])

(GLPARSEXPR
  [LAMBDA NIL                                                (* edited: "22-SEP-82 17:16")
                                                             (* edited: "23-Jun-81 14:35")
                                                             (* edited: "14-Apr-81 12:25")
                                                             (* edited: " 9-Apr-81 11:32")

          (* Subroutine of GLDOEXPR to parse a GLISP expression containing field specifications and/or operators.
	  The global variable EXPR is used, and is modified to reflect the amount of the expression which has been parsed.)


    (PROG (OPNDS OPERS FIRST LHSP RHSP)                      (* Get the initial part of the expression, i.e., 
							     variable or field specification.)
      L   (SETQ OPNDS (CONS (GLOPERAND)
			    OPNDS))
      M   [COND
	    [(NULL FIRST)
	      (COND
		([OR (NULL EXPR)
		     (NOT (ATOM (CAR EXPR]
		  (GO B)))
	      (GLSEPINIT (CAR EXPR))
	      (COND
		((GLOPERATOR? (SETQ FIRST (GLSEPNXT)))
		  (pop EXPR)
		  (GO A))
		[(MEMB FIRST (QUOTE (IS Is is HAS Has has)))
		  (COND
		    ((AND OPERS (IGREATERP (GLPREC (CAR OPERS))
					   5))
		      (GLREDUCE)
		      (SETQ FIRST NIL)
		      (GO M))
		    (T (SETQ OPNDS (CONS (GLPREDICATE (pop OPNDS)
						      CONTEXT T (AND (BOUNDP (QUOTE ADDISATYPE))
								     ADDISATYPE))
					 OPNDS))
		       (SETQ FIRST NIL)
		       (GO M]
		(T (GLSEPCLR)
		   (GO B]
	    ((GLOPERATOR? FIRST)
	      (GO A))
	    (T (GLERROR (QUOTE GLPARSEXPR)
			(LIST FIRST "appears illegally or cannot be interpreted."]
                                                             (* FIRST now contains an operator)
      A                                                      (* While top operator < top of stack in precedence, 
							     reduce.)
          (COND
	    ([NOT (OR (NULL OPERS)
		      (ILESSP (SETQ LHSP (GLPREC (CAR OPERS)))
			      (SETQ RHSP (GLPREC FIRST)))
		      (AND (EQP LHSP RHSP)
			   (MEMB FIRST (QUOTE (_ ^ :=]
	      (GLREDUCE)
	      (GO A)))                                       (* Push new operator onto the operator stack.)
          (SETQ OPERS (CONS FIRST OPERS))
          (GO L)
      B   (COND
	    (OPERS (GLREDUCE)
		   (GO B)))
          (RETURN (CAR OPNDS])

(GLPARSFLD
  [LAMBDA (PREV)                                             (* edited: "20-MAY-82 15:13")
                                                             (* "GSN: " "23-Jun-81 15:28")
                                                             (* "GSN: " "21-Apr-81 11:26")

          (* Parse a field specification of the form var:field:field... Var may be missing, and there may be zero or more 
	  fields. The variable FIRST is used globally; it contains the first atom of the group on entry, and the next atom 
	  on exit.)


    (PROG (FIELD TMP)
          [COND
	    ((NULL PREV)
	      (COND
		[(EQ FIRST (QUOTE '))
		  (COND
		    [(SETQ TMP (GLSEPNXT))
		      (SETQ FIRST (GLSEPNXT))
		      (RETURN (LIST (KWOTE TMP)
				    (QUOTE ATOM]
		    (EXPR (SETQ FIRST NIL)
			  (RETURN (LIST (KWOTE (pop EXPR))
					NIL)))
		    (T (RETURN]
		((MEMB FIRST (QUOTE (THE The the)))
		  (SETQ TMP (GLTHE NIL))
		  (SETQ FIRST NIL)
		  (RETURN TMP))
		((NEQ FIRST (QUOTE :))
		  (SETQ PREV FIRST)
		  (SETQ FIRST (GLSEPNXT]
      A   (COND
	    [(EQ FIRST (QUOTE :))
	      (COND
		((SETQ FIELD (GLSEPNXT))
		  (SETQ PREV (GLGETFIELD PREV FIELD CONTEXT))
		  (SETQ FIRST (GLSEPNXT))
		  (GO A]
	    (T (RETURN (COND
			 ((EQ PREV (QUOTE *NIL*))
			   (LIST NIL NIL))
			 (T (GLIDNAME PREV T])

(GLPARSNFLD
  [LAMBDA NIL                                                (* edited: "20-MAY-82 11:30")
                                                             (* "GSN: " " 8-Jan-81 13:45")
                                                             (* Parse a field specification which may be preceded by 
							     a ~.)
    (PROG (TMP UOP)
          (COND
	    [(OR (EQ FIRST (QUOTE ~))
		 (EQ FIRST (QUOTE -)))
	      (SETQ UOP FIRST)
	      [COND
		((SETQ FIRST (GLSEPNXT))
		  (SETQ TMP (GLPARSFLD NIL)))
		((AND EXPR (ATOM (CAR EXPR)))
		  (GLSEPINIT (pop EXPR))
		  (SETQ FIRST (GLSEPNXT))
		  (SETQ TMP (GLPARSFLD NIL)))
		((AND EXPR (LISTP (CAR EXPR)))
		  (SETQ TMP (GLPUSHEXPR (pop EXPR)
					T CONTEXT T)))
		(T (RETURN (LIST UOP NIL]
	      (RETURN (COND
			((EQ UOP (QUOTE ~))
			  (GLNOTFN TMP))
			(T (GLMINUSFN TMP]
	    (T (RETURN (GLPARSFLD NIL])

(GLPLURAL
  [LAMBDA (WORD)                                             (* edited: "27-MAY-82 10:42")
                                                             (* Form the plural of a given word.)
    (PROG (TMP LST UCASE ENDING)
          (COND
	    ((SETQ TMP (GETPROP WORD (QUOTE PLURAL)))
	      (RETURN TMP)))
          (SETQ LST (DREVERSE (UNPACK WORD)))
          (SETQ UCASE (U-CASEP (CAR LST)))
          [COND
	    [[AND (MEMB (CAR LST)
			(QUOTE (Y y)))
		  (NOT (MEMB (CADR LST)
			     (QUOTE (A a E e O o U u]
	      (SETQ LST (CDR LST))
	      (SETQ ENDING (OR (AND UCASE (QUOTE (S E I)))
			       (QUOTE (s e i]
	    [(MEMB (CAR LST)
		   (QUOTE (S s X x)))
	      (SETQ ENDING (OR (AND UCASE (QUOTE (S E)))
			       (QUOTE (s e]
	    (T (SETQ ENDING (OR (AND UCASE (QUOTE (S)))
				(QUOTE (s]
          (RETURN (PACK (DREVERSE (APPEND ENDING LST])

(GLPOPFN
  [LAMBDA (LHS RHS)                                          (* edited: "11-OCT-82 15:13")
                                                             (* "GSN: " "20-Mar-81 14:44")

          (* Produce a function to implement the -_ (pop) operator. Code is produced to remove one element from the 
	  right-hand side and assign it to the left-hand side.)


    (PROG (RHSCODE RHSDES POPCODE GETCODE TMP STR)
          (SETQ RHSCODE (CAR RHS))
          (SETQ RHSDES (GLXTRTYPE (CADR RHS)))
          [COND
	    ((AND (LISTP RHSDES)
		  (EQ (CAR RHSDES)
		      (QUOTE LISTOF)))
	      (SETQ POPCODE (GLPUTFN RHS (LIST (LIST (QUOTE CDR)
						     RHSCODE)
					       RHSDES)
				     T))
	      (SETQ GETCODE (GLPUTFN LHS (LIST (LIST (QUOTE CAR)
						     (CAR RHS))
					       (CADR RHSDES))
				     NIL)))
	    ((EQ RHSDES (QUOTE BOOLEAN))
	      (SETQ POPCODE (GLPUTFN RHS (QUOTE (NIL NIL))
				     NIL))
	      (SETQ GETCODE (GLPUTFN LHS RHS NIL)))
	    ((SETQ TMP (GLDOMSG RHS (QUOTE -_)
				(LIST LHS)))
	      (RETURN TMP))
	    ([AND (SETQ STR (GLGETSTR RHSDES))
		  (SETQ TMP (GLPOPFN LHS (LIST (CAR RHS)
					       STR]
	      (RETURN TMP))
	    ((SETQ TMP (GLUSERSTROP RHS (QUOTE -_)
				    LHS))
	      (RETURN TMP))
	    (T                                               (* If all else fails, assume a list.)
	       (SETQ POPCODE (GLPUTFN RHS (LIST (LIST (QUOTE CDR)
						      RHSCODE)
						RHSDES)
				      T))
	       (SETQ GETCODE (GLPUTFN LHS (LIST (LIST (QUOTE CAR)
						      (CAR RHS))
						(CADR RHSDES))
				      NIL]
          (RETURN (LIST (LIST (QUOTE PROG1)
			      (CAR GETCODE)
			      (CAR POPCODE))
			(CADR GETCODE])

(GLPREC
  [LAMBDA (OP)                                               (* edited: "30-OCT-82 14:36")
                                                             (* edited: "17-Sep-81 13:29")
                                                             (* edited: "14-Aug-81 14:22")
                                                             (* edited: "21-Apr-81 11:27")
                                                             (* Precedence numbers for operators)
    (PROG (TMP)
          (COND
	    ([SETQ TMP (FASSOC OP (QUOTE ((_ . 1)
					   (:= . 1)
					   (__ . 1)
					   (_+ . 2)
					   (__+ . 2)
					   (+_ . 2)
					   (_+_ . 2)
					   (_- . 2)
					   (__- . 2)
					   (-_ . 2)
					   (= . 5)
					   (~= . 5)
					   (<> . 5)
					   (AND . 4)
					   (And . 4)
					   (and . 4)
					   (OR . 3)
					   (Or . 3)
					   (or . 3)
					   (/ . 7)
					   (+ . 6)
					   (- . 6)
					   (> . 5)
					   (< . 5)
					   (>= . 5)
					   (<= . 5)
					   (^ . 8]
	      (RETURN (CDR TMP)))
	    ((EQ OP (QUOTE *))
	      (RETURN 7))
	    (T (RETURN 10])

(GLPREDICATE
  [LAMBDA (SOURCE CONTEXT VERBFLG ADDISATYPE)                (* edited: " 2-DEC-82 14:16")

          (* Get a predicate specification from the EXPR (referenced globally) and return code to test the SOURCE for that 
	  predicate. VERBFLG is true if a verb is expected as the top of EXPR.)


    (DECLARE (SPECVARS NOTFLG ADDISATYPE))
    (PROG (NEWPRED SETNAME PROPERTY TMP NOTFLG)
          [COND
	    ((NULL VERBFLG)
	      (SETQ NEWPRED (GLDOEXPR NIL CONTEXT T)))
	    ((NULL SOURCE)
	      (GLERROR (QUOTE GLPREDICATE)
		       (LIST "The object to be tested was not found.  EXPR =" EXPR)))
	    ((MEMB (CAR EXPR)
		   (QUOTE (HAS Has has)))
	      (pop EXPR)
	      (COND
		((MEMB (CAR EXPR)
		       (QUOTE (NO No no)))
		  (SETQ NOTFLG T)
		  (pop EXPR)))
	      (SETQ NEWPRED (GLDOEXPR NIL CONTEXT T)))
	    ((MEMB (CAR EXPR)
		   (QUOTE (IS Is is ARE Are are)))
	      (pop EXPR)
	      (COND
		((MEMB (CAR EXPR)
		       (QUOTE (NOT Not not)))
		  (SETQ NOTFLG T)
		  (pop EXPR)))
	      (COND
		[(GL-A-AN? (CAR EXPR))
		  (pop EXPR)
		  (SETQ SETNAME (pop EXPR))                  (* The condition is to test whether SOURCE IS A 
							     SETNAME.)
		  (COND
		    [(SETQ NEWPRED (GLADJ SOURCE SETNAME (QUOTE ISA]
		    [(SETQ NEWPRED (GLADJ SOURCE SETNAME (QUOTE ISASELF)))
		      (COND
			(ADDISATYPE (COND
				      ((ATOM (CAR SOURCE))
					(GLADDSTR (CAR SOURCE)
						  NIL SETNAME CONTEXT))
				      ((AND (LISTP (CAR SOURCE))
					    (MEMB (CAAR SOURCE)
						  (QUOTE (SETQ PROG1)))
					    (ATOM (CADAR SOURCE)))
					(GLADDSTR (CADAR SOURCE)
						  (COND
						    ((SETQ TMP (GLFINDVARINCTX (CAR SOURCE)
									       CONTEXT))
						      (CADR TMP)))
						  SETNAME CONTEXT]
		    [(GLCLASSP SETNAME)
		      (SETQ NEWPRED (LIST (LIST (QUOTE GLCLASSMEMP)
						(CAR SOURCE)
						(KWOTE SETNAME))
					  (QUOTE BOOLEAN]
		    [(SETQ TMP (GLLISPISA SETNAME))
		      (SETQ NEWPRED (LIST (LIST TMP (CAR SOURCE))
					  (QUOTE BOOLEAN]
		    (T (GLERROR (QUOTE GLPREDICATE)
				(LIST "IS A adjective" SETNAME "could not be found for" (CAR SOURCE)
				      "whose type is"
				      (CADR SOURCE)))
		       (SETQ NEWPRED (LIST (LIST (QUOTE GLERR)
						 (CAR SOURCE)
						 (QUOTE IS)
						 (QUOTE A)
						 SETNAME)
					   (QUOTE BOOLEAN]
		(T (SETQ PROPERTY (CAR EXPR))                (* The condition to test is whether SOURCE is PROPERTY.)
		   (COND
		     ((SETQ NEWPRED (GLADJ SOURCE PROPERTY (QUOTE ADJ)))
		       (pop EXPR))
		     [(SETQ TMP (GLLISPADJ PROPERTY))
		       (pop EXPR)
		       (SETQ NEWPRED (LIST (LIST TMP (CAR SOURCE))
					   (QUOTE BOOLEAN]
		     (T (GLERROR (QUOTE GLPREDICATE)
				 (LIST "The adjective" PROPERTY "could not be found for"
				       (CAR SOURCE)
				       "whose type is"
				       (CADR SOURCE)))
			(pop EXPR)
			(SETQ NEWPRED (LIST (LIST (QUOTE GLERR)
						  (CAR SOURCE)
						  (QUOTE IS)
						  PROPERTY)
					    (QUOTE BOOLEAN]
          (RETURN (COND
		    (NOTFLG (LIST (GLBUILDNOT (CAR NEWPRED))
				  (QUOTE BOOLEAN)))
		    (T NEWPRED])

(GLPRETTYPRINTCONST
  [LAMBDA (LST)                                              (* edited: "21-APR-82 16:06")
    (PROG NIL
          (TERPRI)
          (TERPRI)
          (PRIN1 (QUOTE %[))
          (PRIN1 (QUOTE GLISPCONSTANTS))
          [MAPC LST (FUNCTION (LAMBDA (X)
		    (printout NIL T T "(" .FONT LAMBDAFONT X .FONT DEFAULTFONT .SP 3 .PPV
			      (GETPROP X (QUOTE GLISPORIGCONSTVAL))
			      .SP 3 .PPV (GETPROP X (QUOTE GLISPCONSTANTTYPE))
			      "  )"]
          (TERPRI)
          (PRIN1 (QUOTE %]))
          (TERPRI)
          (TERPRI])

(GLPRETTYPRINTGLOBALS
  [LAMBDA (LST)                                              (* edited: "23-APR-82 16:53")
    (PROG NIL
          (TERPRI)
          (TERPRI)
          (PRIN1 (QUOTE %[))
          (PRIN1 (QUOTE GLISPGLOBALS))
          [MAPC LST (FUNCTION (LAMBDA (X)
		    (printout NIL T T "(" .FONT LAMBDAFONT X .FONT DEFAULTFONT .SP 3 .PPV
			      (GETPROP X (QUOTE GLISPGLOBALVARTYPE))
			      "  )"]
          (TERPRI)
          (PRIN1 (QUOTE %]))
          (TERPRI)
          (TERPRI])

(GLPRETTYPRINTSTRS
  [LAMBDA (LST)                                              (* edited: "23-APR-82 16:46")
                                                             (* Pretty-print GLISP structure definitions for file 
							     package output.)
    (PROG (TMP OBJ)
          (TERPRI)
          (TERPRI)
          (PRIN1 (QUOTE %[))
          (PRINT (QUOTE GLISPOBJECTS))
      LP  (COND
	    ((NULL LST)
	      (TERPRI)
	      (PRIN1 (QUOTE %]))
	      (TERPRI)
	      (TERPRI)
	      (RETURN)))
          (SETQ OBJ (pop LST))
          (COND
	    ((SETQ TMP (GETPROP OBJ (QUOTE GLSTRUCTURE)))
	      (printout NIL T T "(" .FONT LAMBDAFONT OBJ .FONT DEFAULTFONT T T 3 .PPV (CAR TMP))
	      (MAP (CDR TMP)
		   [FUNCTION (LAMBDA (REST)
		       (printout NIL T T 3 (CAR REST)
				 10 .PPV (CADR REST]
		   (FUNCTION CDDR))
	      (printout NIL "  )")))
          (GO LP])

(GLPROGN
  [LAMBDA (EXPR CONTEXT)                                     (* edited: "25-MAY-82 16:09")
                                                             (* "GSN: " "13-Aug-81 14:23")
                                                             (* "GSN: " "21-Apr-81 11:28")
                                                             (* Compile an implicit PROGN, that is, a list of items.)
    (PROG (RESULT TMP TYPE GLSEPATOM GLSEPPTR)
          (SETQ GLSEPPTR 0)
      A   (COND
	    ((NULL EXPR)
	      (RETURN (LIST (DREVERSE RESULT)
			    TYPE)))
	    ((SETQ TMP (GLDOEXPR NIL CONTEXT VALBUSY))
	      (SETQ RESULT (CONS (CAR TMP)
				 RESULT))
	      (SETQ TYPE (CADR TMP))
	      (GO A))
	    (T (GLERROR (QUOTE GLPROGN)
			(LIST "Illegal item appears in implicit PROGN.  EXPR =" EXPR])

(GLPROPSTRFN
  [LAMBDA (IND DES DESLIST FLG)                              (* edited: "12-NOV-82 11:35")

          (* Create a function call to retrieve the field IND from a property-list type structure. FLG is true if a PROPLIST
	  is inside an ATOM structure.)


    (PROG (DESIND TMP RECNAME N)                             (* Handle a PROPLIST by looking inside each property for
							     IND.)
          [COND
	    ((AND (EQ (SETQ DESIND (pop DES))
		      (QUOTE RECORD))
		  (ATOM (CAR DES)))
	      (SETQ RECNAME (pop DES]
          (SETQ N 0)
      P   (COND
	    ((NULL DES)
	      (RETURN))
	    ((AND (LISTP (CAR DES))
		  (ATOM (CAAR DES))
		  (CDAR DES)
		  (SETQ TMP (GLSTRFN IND (CAR DES)
				     DESLIST)))
	      (SETQ TMP
		(GLSTRVAL
		  TMP
		  (SELECTQ DESIND
			   (ALIST (LIST (QUOTE GLGETASSOC)
					(KWOTE (CAAR DES))
					(QUOTE *GL*)))
			   [(RECORD OBJECT)
			     (SELECTQ GLLISPDIALECT
				      [INTERLISP
					(COND
					  (RECNAME (LIST (QUOTE fetch)
							 (LIST RECNAME (CAAR DES))
							 (QUOTE of)
							 (QUOTE *GL*)))
					  (T (LIST (QUOTE CAR)
						   (GLGENCODE (LIST (QUOTE NTH)
								    (QUOTE *GL*)
								    (COND
								      ((EQ DESIND (QUOTE OBJECT))
									(ADD1 (ADD1 N)))
								      (T (ADD1 N]
				      ((MACLISP FRANZLISP)
					(LIST (QUOTE CXR)
					      N
					      (QUOTE *GL*)))
				      (PSL (LIST (QUOTE GetV)
						 (QUOTE *GL*)
						 N))
				      (LIST (QUOTE CAR)
					    (GLGENCODE (LIST (QUOTE NTH)
							     (QUOTE *GL*)
							     (ADD1 N]
			   [(PROPLIST ATOMOBJECT)
			     (LIST (COND
				     ((OR FLG (EQ DESIND (QUOTE ATOMOBJECT)))
				       (QUOTE GETPROP))
				     (T (QUOTE LISTGET)))
				   (QUOTE *GL*)
				   (KWOTE (CAAR DES]
			   NIL)))
	      (RPLACA TMP (GLGENCODE (CAR TMP)))
	      (RETURN TMP))
	    (T (pop DES)
	       (SETQ N (ADD1 N))
	       (GO P])

(GLPSLTRANSFM
  [LAMBDA (X)                                                (* edited: "17-NOV-82 11:23")
                                                             (* Transform an expression X for Portable Standard Lisp 
							     dialect.)
    (PROG (TMP NOTFLG)                                       (* First do argument reversals.)
          [COND
	    ((NLISTP X)
	      (RETURN X))
	    [(FMEMB (CAR X)
		    (QUOTE (push PUSH)))
	      (SETQ X (LIST (CAR X)
			    (CADDR X)
			    (CADR X]
	    [(FMEMB (CAR X)
		    NIL)
	      (SETQ X (LIST (CAR X)
			    (CADR X)
			    (CADDDR X)
			    (CADDR X]
	    ((EQ (CAR X)
		 (QUOTE APPLY*))
	      (SETQ X (LIST (QUOTE APPLY)
			    (CADR X)
			    (CONS (QUOTE LIST)
				  (CDDR X]                   (* Now see if the result will be negated.)
          [SETQ NOTFLG (FMEMB (CAR X)
			      (QUOTE (NLISTP BOUNDP GEQ LEQ IGEQ ILEQ]
          (COND
	    [[SETQ TMP (FASSOC (CAR X)
			       (QUOTE ((MEMB MEMQ)
					(FMEMB MEMQ)
					(FASSOC ASSOC)
					(LITATOM IDP)
					(GETPROP GET)
					(GETPROPLIST PROP)
					(PUTPROP PUT)
					(LISTP PAIRP)
					(NLISTP PAIRP)
					(NEQ NE)
					(IGREATERP GREATERP)
					(IGEQ LESSP)
					(GEQ LESSP)
					(ILESSP LESSP)
					(ILEQ GREATERP)
					(LEQ GREATERP)
					(IPLUS PLUS)
					(IDIFFERENCE DIFFERENCE)
					(ITIMES TIMES)
					(IQUOTIENT QUOTIENT)
                                                             (* CommentOutCode)
					(MAPCONC MAPCAN)
					(DECLARE CommentOutCode)
					(NCHARS FlatSize2)
					(DREVERSE REVERSIP)
					(STREQUAL String!=)
					(ALPHORDER String!<!=)
					(GLSTRGREATERP String!>)
					(GLSTRGEP String!>!=)
					(GLSTRLESSP String!<)
					(EQP EQN)
					(LAST LASTPAIR)
					(NTH PNth)
					(NCONC1 ACONC)
					(U-CASE String!-UpCase)
					(DSUBST SUBSTIP)
					(BOUNDP UNBOUNDP)
					(KWOTE MKQUOTE)
					(UNPACK EXPLODE)
					(PACK IMPLODE]
	      (SETQ X (CONS (CADR TMP)
			    (CDR X]
	    ((AND (EQ (CAR X)
		      (QUOTE RETURN))
		  (NULL (CDR X)))
	      (SETQ X (LIST (CAR X)
			    NIL)))
	    ((AND (EQ (CAR X)
		      (QUOTE APPEND))
		  (NULL (CDDR X)))
	      (SETQ X (LIST (CAR X)
			    (CADR X)
			    NIL)))
	    [(EQ (CAR X)
		 (QUOTE ERROR))
	      (SETQ X (LIST (CAR X)
			    0
			    (COND
			      ((NULL (CDR X))
				NIL)
			      ((NULL (CDDR X))
				(CADR X))
			      (T (CONS (QUOTE LIST)
				       (CDR X]
	    [(EQ (CAR X)
		 (QUOTE SELECTQ))
	      (RPLACA X (QUOTE CASEQ))
	      (SETQ TMP (NLEFT X 2))
	      (COND
		((NULL (CADR TMP))
		  (RPLACD TMP NIL))
		(T (RPLACD TMP (LIST (LIST T (CADR TMP]
	    ((EQ (CAR X)
		 (QUOTE PROG))
	      (GLTRANSPROG X)))
          (RETURN (COND
		    (NOTFLG (LIST (QUOTE NOT)
				  X))
		    (T X])

(GLPURE
  [LAMBDA (X)                                                (* edited: " 4-JUN-82 13:37")
                                                             (* Test if the function X is a pure computation, i.e., 
							     can be eliminated if the result is not used.)
    (FMEMB X (QUOTE (CAR CDR CXR CAAR CADR CDAR CDDR ADD1 SUB1 CADDR CADDDR])

(GLPUSHEXPR
  [LAMBDA (EXPR START CONTEXT VALBUSY)                       (* edited: "25-MAY-82 16:10")
                                                             (* "GSN: " "17-Sep-81 13:59")
                                                             (* "GSN: " " 7-Apr-81 10:33")
                                                             (* This function serves to call GLDOEXPR with a new 
							     expression, rebinding the global variable EXPR.)
    (PROG (GLSEPATOM GLSEPPTR)
          (SETQ GLSEPPTR 0)
          (RETURN (GLDOEXPR START CONTEXT VALBUSY])

(GLPUSHFN
  [LAMBDA (LHS RHS)                                          (* edited: " 5-NOV-82 10:44")
                                                             (* edited: " 2-Jun-81 14:19")
                                                             (* edited: "21-Apr-81 11:28")

          (* Produce a function to implement the +_ operator. Code is produced to push the right-hand side onto the 
	  left-hand side. Note: parts of the structure provided are used multiple times.)


    (PROG (LHSCODE LHSDES NCCODE TMP STR)
          (SETQ LHSCODE (CAR LHS))
          (SETQ LHSDES (GLXTRTYPE (CADR LHS)))
          (COND
	    [(EQ LHSDES (QUOTE INTEGER))
	      (COND
		((EQP (CAR RHS)
		      1)
		  (SETQ NCCODE (LIST (QUOTE ADD1)
				     LHSCODE)))
		[(OR (FIXP (CAR RHS))
		     (EQ (CADR RHS)
			 (QUOTE INTEGER)))
		  (SETQ NCCODE (LIST (QUOTE IPLUS)
				     LHSCODE
				     (CAR RHS]
		(T (SETQ NCCODE (LIST (QUOTE PLUS)
				      LHSCODE
				      (CAR RHS]
	    [(OR (EQ LHSDES (QUOTE NUMBER))
		 (EQ LHSDES (QUOTE REAL)))
	      (SETQ NCCODE (LIST (QUOTE PLUS)
				 LHSCODE
				 (CAR RHS]
	    [(EQ LHSDES (QUOTE BOOLEAN))
	      (SETQ NCCODE (LIST (QUOTE OR)
				 LHSCODE
				 (CAR RHS]
	    [(NULL LHSDES)
	      (SETQ NCCODE (LIST (QUOTE CONS)
				 (CAR RHS)
				 LHSCODE))
	      (COND
		((AND (ATOM LHSCODE)
		      (CADR RHS))
		  (GLADDSTR LHSCODE NIL (LIST (QUOTE LISTOF)
					      (CADR RHS))
			    CONTEXT]
	    ([AND (LISTP LHSDES)
		  (MEMB (CAR LHSDES)
			(QUOTE (LIST CONS LISTOF]
	      (SETQ NCCODE (LIST (QUOTE CONS)
				 (CAR RHS)
				 LHSCODE)))
	    ((SETQ TMP (GLUNITOP LHS RHS (QUOTE PUSH)))
	      (RETURN TMP))
	    ((SETQ TMP (GLDOMSG LHS (QUOTE +_)
				(LIST RHS)))
	      (RETURN TMP))
	    ((SETQ TMP (GLDOMSG LHS (QUOTE +)
				(LIST RHS)))
	      (SETQ NCCODE (CAR TMP)))
	    ((AND (SETQ STR (GLGETSTR LHSDES))
		  (SETQ TMP (GLPUSHFN (LIST (CAR LHS)
					    STR)
				      RHS)))
	      (RETURN TMP))
	    ((SETQ TMP (GLUSERSTROP LHS (QUOTE +_)
				    RHS))
	      (RETURN TMP))
	    (T (RETURN)))
          (RETURN (GLPUTFN LHS (LIST (GLGENCODE NCCODE)
				     LHSDES)
			   T])

(GLPUTARITH
  [LAMBDA (LHS RHS)                                          (* edited: "18-NOV-82 11:59")
                                                             (* Process a "store" into a value which is computed by 
							     an arithmetic expression.)
    (PROG (LHSC OP TMP NEWLHS NEWRHS)
          (SETQ LHSC (CAR LHS))
          (SETQ OP (CAR LHSC))
          (COND
	    ([NOT (SETQ TMP (FASSOC OP (QUOTE ((PLUS DIFFERENCE)
						(MINUS MINUS)
						(DIFFERENCE PLUS)
						(TIMES QUOTIENT)
						(QUOTIENT TIMES)
						(IPLUS IDIFFERENCE)
						(IMINUS IMINUS)
						(IDIFFERENCE IPLUS)
						(ITIMES IQUOTIENT)
						(IQUOTIENT ITIMES)
						(ADD1 SUB1)
						(SUB1 ADD1)
						(EXPT SQRT]
	      (RETURN)))
          (SELECTQ OP
		   ((ADD1 SUB1 MINUS IMINUS)
		     (SETQ NEWRHS (LIST (CADR TMP)
					(CAR RHS)))
		     (SETQ NEWLHS (CADR LHSC)))
		   [(PLUS DIFFERENCE TIMES QUOTIENT IPLUS IDIFFERENCE ITIMES IQUOTIENT)
		     (COND
		       ((NUMBERP (CADDR LHSC))
			 (SETQ NEWRHS (LIST (CADR TMP)
					    (CAR RHS)
					    (CADDR LHSC)))
			 (SETQ NEWLHS (CADR LHSC)))
		       ((NUMBERP (CADR LHSC))
			 (SELECTQ OP
				  ((DIFFERENCE IDIFFERENCE QUOTIENT IQUOTIENT)
				    (SETQ NEWRHS (LIST OP (CADR LHSC)
						       (CAR RHS)))
				    (SETQ NEWLHS (CADDR LHSC)))
				  (PROGN (SETQ NEWRHS (LIST (CADR TMP)
							    (CAR RHS)
							    (CADR LHSC)))
					 (SETQ NEWLHS (CADDR LHSC]
		   [EXPT (COND
			   ((EQUAL (CADDR LHSC)
				   2)
			     (SETQ NEWRHS (LIST (CADR TMP)
						(CAR RHS)))
			     (SETQ NEWLHS (CADR LHSC]
		   NIL)
          (RETURN (AND NEWLHS NEWRHS (GLPUTFN (LIST NEWLHS (CADR LHS))
					      (LIST NEWRHS (CADR RHS))
					      NIL])

(GLPUTFN
  [LAMBDA (LHS RHS OPTFLG)                                   (* edited: "17-NOV-82 11:28")
                                                             (* edited: " 2-Jun-81 14:16")
                                                             (* edited: "24-Apr-81 12:05")
                                                             (* edited: "21-Apr-81 11:28")
                                                             (* Create code to put the right-hand side datum RHS into
							     the left-hand side, whose access function and type are 
							     given by LHS.)
    (PROG (LHSD LNAME TMP RESULT TMPVAR)
          (SETQ LHSD (CAR LHS))
          [COND
	    ((ATOM LHSD)
	      (RETURN (OR (GLDOMSG LHS (QUOTE _)
				   (LIST RHS))
			  (GLUSERSTROP LHS (QUOTE _)
				       RHS)
			  (AND (NULL (CADR LHS))
			       (CADR RHS)
			       (GLUSERSTROP (LIST (CAR LHS)
						  (CADR RHS))
					    (QUOTE _)
					    RHS))
			  (GLDOVARSETQ LHSD RHS]
          (SETQ LNAME (CAR LHSD))
          [COND
	    [(EQ LNAME (QUOTE CAR))
	      (SETQ RESULT (COND
		  [(AND OPTFLG (GLEXPENSIVE? (CADR LHSD)))
		    (LIST (QUOTE PROG)
			  (LIST (LIST (SETQ TMPVAR (GLMKVAR))
				      (CADR LHSD)))
			  (LIST (QUOTE RETURN)
				(LIST (QUOTE CAR)
				      (LIST (QUOTE RPLACA)
					    TMPVAR
					    (SUBST TMPVAR (CADR LHSD)
						   (CAR RHS]
		  (T (LIST (QUOTE CAR)
			   (LIST (QUOTE RPLACA)
				 (CADR LHSD)
				 (CAR RHS]
	    [(EQ LNAME (QUOTE CDR))
	      (SETQ RESULT (COND
		  [(AND OPTFLG (GLEXPENSIVE? (CADR LHSD)))
		    (LIST (QUOTE PROG)
			  (LIST (LIST (SETQ TMPVAR (GLMKVAR))
				      (CADR LHSD)))
			  (LIST (QUOTE RETURN)
				(LIST (QUOTE CDR)
				      (LIST (QUOTE RPLACD)
					    TMPVAR
					    (SUBST TMPVAR (CADR LHSD)
						   (CAR RHS]
		  (T (LIST (QUOTE CDR)
			   (LIST (QUOTE RPLACD)
				 (CADR LHSD)
				 (CAR RHS]
	    [[SETQ TMP (FASSOC LNAME (QUOTE ((CADR . CDR)
					      (CADDR . CDDR)
					      (CADDDR . CDDDR]
	      (SETQ RESULT (COND
		  [(AND OPTFLG (GLEXPENSIVE? (CADR LHSD)))
		    (LIST (QUOTE PROG)
			  [LIST (LIST (SETQ TMPVAR (GLMKVAR))
				      (LIST (CDR TMP)
					    (CADR LHSD]
			  (LIST (QUOTE RETURN)
				(LIST (QUOTE CAR)
				      (LIST (QUOTE RPLACA)
					    TMPVAR
					    (SUBST (LIST (QUOTE CAR)
							 TMPVAR)
						   LHSD
						   (CAR RHS]
		  (T (LIST (QUOTE CAR)
			   (LIST (QUOTE RPLACA)
				 (LIST (CDR TMP)
				       (CADR LHSD))
				 (CAR RHS]
	    [(EQ LNAME (QUOTE CXR))
	      (SETQ RESULT (LIST (QUOTE CXR)
				 (LIST (QUOTE RPLACX)
				       (CADR LHSD)
				       (CADDR LHSD)
				       (CAR RHS]
	    [(EQ LNAME (QUOTE GetV))
	      (SETQ RESULT (LIST (QUOTE PutV)
				 (CADR LHSD)
				 (CADDR LHSD)
				 (CAR RHS]
	    [(MEMB LNAME (QUOTE (GET GETPROP)))
	      (SETQ RESULT (LIST (QUOTE PUTPROP)
				 (CADR LHSD)
				 (CADDR LHSD)
				 (CAR RHS]
	    [(EQ LNAME (QUOTE LISTGET))
	      (SETQ RESULT (LIST (QUOTE LISTPUT)
				 (CADR LHSD)
				 (CADDR LHSD)
				 (CAR RHS]
	    [(EQ LNAME (QUOTE GLGETASSOC))
	      (SETQ RESULT (LIST (QUOTE PUTASSOC)
				 (CADR LHSD)
				 (CAR RHS)
				 (CADDR LHSD]
	    [(EQ LNAME (QUOTE EVAL))
	      (SETQ RESULT (LIST (QUOTE SET)
				 (CADR LHSD)
				 (CAR RHS]
	    [(EQ LNAME (QUOTE fetch))
	      (SETQ RESULT (LIST (QUOTE replace)
				 (CADR LHSD)
				 (QUOTE of)
				 (CADDDR LHSD)
				 (QUOTE with)
				 (CAR RHS]
	    ((SETQ TMP (GLUNITOP LHS RHS (QUOTE PUT)))
	      (RETURN TMP))
	    ((SETQ TMP (GLDOMSG LHS (QUOTE _)
				(LIST RHS)))
	      (RETURN TMP))
	    ((SETQ TMP (GLUSERSTROP LHS (QUOTE _)
				    RHS))
	      (RETURN TMP))
	    ((SETQ TMP (GLPUTARITH LHS RHS))
	      (RETURN TMP))
	    (T (RETURN (GLERROR (QUOTE GLPUTFN)
				(LIST "Illegal assignment.  LHS =" LHS "RHS =" RHS]
      X   (RETURN (LIST (GLGENCODE RESULT)
			(OR (CADR LHS)
			    (CADR RHS])

(GLPUTPROPS
  [LAMBDA (PROPLIS PREVLST)                                  (* edited: "27-MAY-82 13:07")
                                                             (* This function appends PUTPROP calls to the list PROGG
							     (global) so that ATOMNAME has its property list built.)
    (PROG (TMP TMPCODE)
      A   (COND
	    ((NULL PROPLIS)
	      (RETURN)))
          (SETQ TMP (pop PROPLIS))
          [COND
	    ((SETQ TMPCODE (GLBUILDSTR TMP PAIRLIST PREVLST))
	      (NCONC1 PROGG (GLGENCODE (LIST (QUOTE PUTPROP)
					     (QUOTE ATOMNAME)
					     (KWOTE (CAR TMP))
					     TMPCODE]
          (GO A])

(GLPUTUPFN
  [LAMBDA (OP LHS RHS)                                       (* edited: "26-JAN-82 10:29")

          (* This function implements the __ operator, which is interpreted as assignment to the source of a variable 
	  (usually "self") outside an open-compiled function. Any other use of __ is illegal.)


    (PROG (TMP TMPOP)
          (OR [SETQ TMPOP (ASSOC OP (QUOTE ((__ . _)
					     (__+ . _+)
					     (__- . _-)
					     (_+_ . +_]
	      (ERROR (LIST (QUOTE GLPUTUPFN)
			   OP)
		     " Illegal operator."))
          (COND
	    ((AND (ATOM (CAR LHS))
		  (BOUNDP (QUOTE GLPROGLST))
		  (SETQ TMP (ASSOC (CAR LHS)
				   GLPROGLST)))
	      (RETURN (GLREDUCEOP (CDR TMPOP)
				  (LIST (CADR TMP)
					(CADR LHS))
				  RHS)))
	    ((AND (LISTP (CAR LHS))
		  (EQ (CAAR LHS)
		      (QUOTE PROG1))
		  (ATOM (CADAR LHS)))
	      (RETURN (GLREDUCEOP (CDR TMPOP)
				  (LIST (CADAR LHS)
					(CADR LHS))
				  RHS)))
	    (T (RETURN (GLERROR (QUOTE GLPUTUPFN)
				(LIST "A self-assignment __ operator is used improperly.  LHS =" LHS])

(GLREDUCE
  [LAMBDA NIL                                                (* edited: "30-OCT-82 14:38")
                                                             (* edited: "14-Aug-81 12:25")
                                                             (* edited: "21-Apr-81 11:28")
                                                             (* Reduce the operator on OPERS and the operands on 
							     OPNDS (in GLPARSEXPR) and put the result back on OPNDS)
    (PROG (RHS OPER)
          (SETQ RHS (pop OPNDS))
          (SETQ OPNDS
	    (CONS (COND
		    ((MEMB (SETQ OPER (pop OPERS))
			   (QUOTE (_ := _+ +_ _- -_ = ~= <> AND And and OR Or or __+ __ _+_ __-)))
		      (GLREDUCEOP OPER (pop OPNDS)
				  RHS))
		    ((FMEMB OPER (QUOTE (+ - * / > < >= <= ^)))
		      (GLREDUCEARITH OPER (pop OPNDS)
				     RHS))
		    ((EQ OPER (QUOTE MINUS))
		      (GLMINUSFN RHS))
		    ((EQ OPER (QUOTE ~))
		      (GLNOTFN RHS))
		    (T (LIST (GLGENCODE (LIST OPER (CAR (pop OPNDS))
					      (CAR RHS)))
			     NIL)))
		  OPNDS])

(GLREDUCEARITH
  [LAMBDA (OP LHS RHS)                                       (* edited: "17-NOV-82 11:56")
                                                             (* edited: "14-Aug-81 12:38")
                                                             (* "Reduce an arithmetic operator in an expression.")
    (PROG (TMP OPLIST IOPLIST PREDLIST NUMBERTYPES LHSTP RHSTP)
          [SETQ OPLIST (QUOTE ((+ . PLUS)
				(- . DIFFERENCE)             (* . TIMES)
				(/ . QUOTIENT)
				(> . GREATERP)
				(< . LESSP)
				(>= . GEQ)
				(<= . LEQ)
				(^ . EXPT]
          [SETQ IOPLIST (QUOTE ((+ . IPLUS)
				 (- . IDIFFERENCE)           (* . ITIMES)
				 (/ . IQUOTIENT)
				 (> . IGREATERP)
				 (< . ILESSP)
				 (>= . IGEQ)
				 (<= . ILEQ]
          (SETQ PREDLIST (QUOTE (GREATERP LESSP GEQ LEQ IGREATERP ILESSP IGEQ ILEQ)))
          (SETQ NUMBERTYPES (QUOTE (INTEGER REAL NUMBER)))
          (SETQ LHSTP (GLXTRTYPE (CADR LHS)))
          (SETQ RHSTP (GLXTRTYPE (CADR RHS)))
          [COND
	    ([OR (AND (EQ LHSTP (QUOTE INTEGER))
		      (EQ RHSTP (QUOTE INTEGER))
		      (SETQ TMP (FASSOC OP IOPLIST)))
		 (AND (MEMB LHSTP NUMBERTYPES)
		      (MEMB RHSTP NUMBERTYPES)
		      (SETQ TMP (FASSOC OP OPLIST]
	      (RETURN (LIST [COND
			      [(AND (NUMBERP (CAR LHS))
				    (NUMBERP (CAR RHS)))
				(EVAL (GLGENCODE (LIST (CDR TMP)
						       (CAR LHS)
						       (CAR RHS]
			      (T (GLGENCODE (COND
					      ((AND (EQ (CDR TMP)
							(QUOTE IPLUS))
						    (EQP (CAR RHS)
							 1))
						(LIST (QUOTE ADD1)
						      (CAR LHS)))
					      ((AND (EQ (CDR TMP)
							(QUOTE IDIFFERENCE))
						    (EQP (CAR RHS)
							 1))
						(LIST (QUOTE SUB1)
						      (CAR LHS)))
					      (T (LIST (CDR TMP)
						       (CAR LHS)
						       (CAR RHS]
			    (COND
			      ((MEMB (CDR TMP)
				     PREDLIST)
				(QUOTE BOOLEAN))
			      (T LHSTP]
          (COND
	    [(EQ LHSTP (QUOTE STRING))
	      (COND
		[(NEQ RHSTP (QUOTE STRING))
		  (RETURN (GLERROR (QUOTE GLREDUCEARITH)
				   (LIST "operation on string and non-string"]
		[[SETQ TMP (FASSOC OP (QUOTE ((+ CONCAT STRING)
					       (> GLSTRGREATERP BOOLEAN)
					       (>= GLSTRGEP BOOLEAN)
					       (< GLSTRLESSP BOOLEAN)
					       (<= ALPHORDER BOOLEAN]
		  (RETURN (LIST (GLGENCODE (LIST (CADR TMP)
						 (CAR LHS)
						 (CAR RHS)))
				(CADDR TMP]
		(T (RETURN (GLERROR (QUOTE GLREDUCEARITH)
				    (LIST OP "is an illegal operation for strings."]
	    [(AND (LISTP LHSTP)
		  (EQ (CAR LHSTP)
		      (QUOTE LISTOF)))
	      (COND
		[(AND (LISTP RHSTP)
		      (EQ (CAR RHSTP)
			  (QUOTE LISTOF)))
		  [COND
		    ((NOT (EQUAL (CADR LHSTP)
				 (CADR RHSTP)))
		      (RETURN (GLERROR (QUOTE GLREDUCEARITH)
				       (LIST "Operations on lists of different types" (CADR LHSTP)
					     (CADR RHSTP]
		  (COND
		    ([SETQ TMP (FASSOC OP (QUOTE ((+ UNION)
						   (- LDIFFERENCE)
                                                             (* INTERSECTION)
						   ]
		      (RETURN (LIST (GLGENCODE (LIST (CADR TMP)
						     (CAR LHS)
						     (CAR RHS)))
				    LHSTP)))
		    (T (RETURN (GLERROR (QUOTE GLREDUCEARITH)
					(LIST "Illegal operation" OP "on lists."]
		([AND (EQUAL (CADR LHSTP)
			     RHSTP)
		      (FMEMB OP (QUOTE (+ - >=]
		  (RETURN (LIST (GLGENCODE (LIST [COND
						   ((EQ OP (QUOTE +))
						     (QUOTE CONS))
						   ((EQ OP (QUOTE -))
						     (QUOTE REMOVE))
						   ((EQ OP (QUOTE >=))
						     (COND
						       ((EQ RHSTP (QUOTE ATOM))
							 (QUOTE MEMB))
						       (T (QUOTE MEMBER]
						 (CAR RHS)
						 (CAR LHS)))
				LHSTP)))
		(T (RETURN (GLERROR (QUOTE GLREDUCEARITH)
				    (LIST "Illegal operation on list."]
	    ([AND (LISTP RHSTP)
		  (EQ (CAR RHSTP)
		      (QUOTE LISTOF))
		  (EQUAL (CADR RHSTP)
			 LHSTP)
		  (FMEMB OP (QUOTE (+ <=]
	      (RETURN (LIST (GLGENCODE (LIST [COND
					       ((EQ OP (QUOTE +))
						 (QUOTE CONS))
					       ((EQ OP (QUOTE <=))
						 (COND
						   ((EQ LHSTP (QUOTE ATOM))
						     (QUOTE MEMB))
						   (T (QUOTE MEMBER]
					     (CAR LHS)
					     (CAR RHS)))
			    RHSTP)))
	    ((SETQ TMP (GLDOMSG LHS OP (LIST RHS)))
	      (RETURN TMP))
	    ((SETQ TMP (GLUSERSTROP LHS OP RHS))
	      (RETURN TMP))
	    [(SETQ TMP (GLXTRTYPEC LHSTP))
	      (RETURN (GLREDUCEARITH OP (LIST (CAR LHS)
					      TMP)
				     (LIST (CAR RHS)
					   (OR (GLXTRTYPEC RHSTP)
					       RHSTP]
	    [(SETQ TMP (FASSOC OP OPLIST))
	      (AND LHSTP RHSTP (GLERROR (QUOTE GLREDUCEARITH)
					(LIST 
			       "Warning: Arithmetic operation on non-numeric arguments of types:"
					      LHSTP RHSTP)))
	      (RETURN (LIST (GLGENCODE (LIST (CDR TMP)
					     (CAR LHS)
					     (CAR RHS)))
			    (COND
			      ((MEMB (CDR TMP)
				     PREDLIST)
				(QUOTE BOOLEAN))
			      (T (QUOTE NUMBER]
	    (T (ERROR (LIST (QUOTE GLREDUCEARITH)
			    OP LHS RHS])

(GLREDUCEOP
  [LAMBDA (OP LHS RHS)                                       (* edited: "30-OCT-82 14:38")
                                                             (* Reduce the operator OP with operands LHS and RHS.)
    (PROG (TMP)
          (COND
	    ((FMEMB OP (QUOTE (_ :=)))
	      (RETURN (GLPUTFN LHS RHS NIL)))
	    ([SETQ TMP (FASSOC OP (QUOTE ((_+ . GLNCONCFN)
					   (+_ . GLPUSHFN)
					   (_- . GLREMOVEFN)
					   (-_ . GLPOPFN)
					   (= . GLEQUALFN)
					   (~= . GLNEQUALFN)
					   (<> . GLNEQUALFN)
					   (AND . GLANDFN)
					   (And . GLANDFN)
					   (and . GLANDFN)
					   (OR . GLORFN)
					   (Or . GLORFN)
					   (or . GLORFN]
	      (RETURN (APPLY* (CDR TMP)
			      LHS RHS)))
	    ((MEMB OP (QUOTE (__ __+ __- _+_)))
	      (RETURN (GLPUTUPFN OP LHS RHS)))
	    (T (ERROR (LIST (QUOTE GLREDUCEOP)
			    OP LHS RHS])

(GLREMOVEFN
  [LAMBDA (LHS RHS)                                          (* edited: " 1-JUN-82 14:29")
                                                             (* edited: " 2-Jun-81 14:20")
                                                             (* edited: "21-Apr-81 11:29")

          (* Produce a function to implement the _- operator. Code is produced to remove the right-hand side from the 
	  left-hand side. Note: parts of the structure provided are used multiple times.)


    (PROG (LHSCODE LHSDES NCCODE TMP STR)
          (SETQ LHSCODE (CAR LHS))
          (SETQ LHSDES (GLXTRTYPE (CADR LHS)))
          (COND
	    [(EQ LHSDES (QUOTE INTEGER))
	      (COND
		((EQP (CAR RHS)
		      1)
		  (SETQ NCCODE (LIST (QUOTE SUB1)
				     LHSCODE)))
		(T (SETQ NCCODE (LIST (QUOTE IDIFFERENCE)
				      LHSCODE
				      (CAR RHS]
	    [(OR (EQ LHSDES (QUOTE NUMBER))
		 (EQ LHSDES (QUOTE REAL)))
	      (SETQ NCCODE (LIST (QUOTE DIFFERENCE)
				 LHSCODE
				 (CAR RHS]
	    [(EQ LHSDES (QUOTE BOOLEAN))
	      (SETQ NCCODE (LIST (QUOTE AND)
				 LHSCODE
				 (LIST (QUOTE NOT)
				       (CAR RHS]
	    ([OR (NULL LHSDES)
		 (AND (LISTP LHSDES)
		      (EQ (CAR LHSDES)
			  (QUOTE LISTOF]
	      (SETQ NCCODE (LIST (QUOTE REMOVE)
				 (CAR RHS)
				 LHSCODE)))
	    ((SETQ TMP (GLUNITOP LHS RHS (QUOTE REMOVE)))
	      (RETURN TMP))
	    ((SETQ TMP (GLDOMSG LHS (QUOTE _-)
				(LIST RHS)))
	      (RETURN TMP))
	    ((SETQ TMP (GLDOMSG LHS (QUOTE -)
				(LIST RHS)))
	      (SETQ NCCODE (CAR TMP)))
	    ((AND (SETQ STR (GLGETSTR LHSDES))
		  (SETQ TMP (GLREMOVEFN (LIST (CAR LHS)
					      STR)
					RHS)))
	      (RETURN TMP))
	    ((SETQ TMP (GLUSERSTROP LHS (QUOTE _-)
				    RHS))
	      (RETURN TMP))
	    (T (RETURN)))
          (RETURN (GLPUTFN LHS (LIST (GLGENCODE NCCODE)
				     LHSDES)
			   T])

(GLRESGLOBAL
  [LAMBDA NIL                                                (* edited: "26-JUL-82 17:30")

          (* Get GLOBAL and RESULT declarations for the GLISP compiler. The property GLRESULTTYPE is the RESULT declaration,
	  if specified; GLGLOBALS is a list of global variables referenced and their types.)


    (COND
      ((LISTP (CAR GLEXPR))
	(COND
	  [(MEMB (CAAR GLEXPR)
		 (QUOTE (RESULT Result result)))
	    (COND
	      ((AND (GLOKSTR? (CADAR GLEXPR))
		    (NULL (CDDAR GLEXPR)))
		(PUTPROP GLAMBDAFN (QUOTE GLRESULTTYPE)
			 (SETQ RESULTTYPE (GLSUBSTTYPE (CADAR GLEXPR)
						       GLTYPESUBS)))
		(pop GLEXPR))
	      (T (GLERROR (QUOTE GLCOMP)
			  (LIST "Bad RESULT structure declaration:" (CAR GLEXPR)))
		 (pop GLEXPR]
	  ((MEMB (CAAR GLEXPR)
		 (QUOTE (GLOBAL Global global)))
	    (SETQ GLGLOBALVARS (GLDECL (CDAR GLEXPR)
				       NIL NIL GLTOPCTX NIL))
	    (PUTPROP GLAMBDAFN (QUOTE GLGLOBALS)
		     GLGLOBALVARS)
	    (pop GLEXPR])

(GLRESULTTYPE
  [LAMBDA (ATM ARGTYPES)                                     (* edited: "26-MAY-82 16:14")
                                                             (* "GSN: " " 1-Jun-81 16:03")
                                                             (* Get the result type for a function which has a 
							     GLAMBDA definition. ATM is the function name.)
    (PROG (TYPE FNDEF STR TMP)                               (* See if this function has a known result type.)
          (COND
	    ((SETQ TYPE (GETPROP ATM (QUOTE GLRESULTTYPE)))
	      (RETURN TYPE)))                                (* If there exists a function to compute the result 
							     type, let it do so.)
          [COND
	    ((SETQ TMP (GETPROP ATM (QUOTE GLRESULTTYPEFN)))
	      (RETURN (APPLY* TMP ATM ARGTYPES)))
	    ((SETQ TMP (GLANYCARCDR? ATM))
	      (RETURN (GLCARCDRRESULTTYPE TMP (CAR ARGTYPES]
          (SETQ FNDEF (GLGETDB ATM))
          (COND
	    ([OR (NLISTP FNDEF)
		 (NOT (FMEMB (CAR FNDEF)
			     (QUOTE (LAMBDA GLAMBDA]
	      (RETURN)))
          (SETQ FNDEF (CDDR FNDEF))
      A   (COND
	    ((OR (NULL FNDEF)
		 (NLISTP (CAR FNDEF)))
	      (RETURN))
	    ([OR (AND (EQ GLLISPDIALECT (QUOTE INTERLISP))
		      (EQ (CAAR FNDEF)
			  (QUOTE *)))
		 (MEMB (CAAR FNDEF)
		       (QUOTE (GLOBAL Global global]
	      (pop FNDEF)
	      (GO A))
	    ([AND (MEMB (CAAR FNDEF)
			(QUOTE (RESULT Result result)))
		  (GLOKSTR? (SETQ STR (CADAR FNDEF]
	      (RETURN STR))
	    (T (RETURN])

(GLSENDB
  [LAMBDA (OBJ SELECTOR PROPTYPE ARGS)                       (* edited: "11-NOV-82 14:44")
                                                             (* Send a runtime message to OBJ.)
    (PROG (CLASS RESULT)
          (OR (SETQ CLASS (GLCLASS OBJ))
	      (ERROR (LIST "Object" OBJ "has no Class.")))
          (COND
	    ((NEQ (SETQ RESULT (GLCLASSSEND CLASS SELECTOR (CONS OBJ ARGS)
					    PROPTYPE))
		  (QUOTE GLSENDFAILURE))
	      (RETURN RESULT)))
          (ERROR (LIST "Message" SELECTOR "to object" OBJ "of class" CLASS "not understood."])

(GLSEPCLR
  [LAMBDA NIL                                                (* edited: "30-DEC-81 16:34")
    (SETQ GLSEPPTR 0])

(GLSEPINIT
  [LAMBDA (ATM)                                              (* "GSN: " "30-Dec-80 10:05")
                                                             (* Initialize the scanning function which breaks apart 
							     atoms containing embedded operators.)
    (PROG NIL
          (SETQ GLSEPATOM ATM)
          (SETQ GLSEPPTR 1])

(GLSEPNXT
  [LAMBDA NIL                                                (* edited: "30-OCT-82 14:40")

          (* Get the next sub-atom from the atom which was previously given to GLSEPINIT. Sub-atoms are defined by splitting
	  the given atom at the occurrence of operators. Operators which are defined are : _ _+ __ +_ _- -_ ' = ~= <> > <)


    (PROG (END TMP)
          (COND
	    ((ZEROP GLSEPPTR)
	      (RETURN))
	    ((NULL GLSEPATOM)
	      (SETQ GLSEPPTR 0)
	      (RETURN (QUOTE *NIL*)))
	    ((NUMBERP GLSEPATOM)
	      (SETQ TMP GLSEPATOM)
	      (SETQ GLSEPPTR 0)
	      (RETURN TMP)))
          (SETQ END (STRPOSL GLSEPBITTBL GLSEPATOM GLSEPPTR))
      A   (COND
	    [(NULL END)
	      (RETURN (PROG1 [COND
			       ((EQP GLSEPPTR 1)
				 GLSEPATOM)
			       ((IGREATERP GLSEPPTR (NCHARS GLSEPATOM))
				 NIL)
			       (T (GLSUBATOM GLSEPATOM GLSEPPTR (NCHARS GLSEPATOM]
			     (SETQ GLSEPPTR 0]
	    ((MEMB (SETQ TMP (GLSUBATOM GLSEPATOM GLSEPPTR (IPLUS GLSEPPTR 2)))
		   (QUOTE (__+ __- _+_)))
	      (SETQ GLSEPPTR (IPLUS GLSEPPTR 3))
	      (RETURN TMP))
	    ((MEMB (SETQ TMP (GLSUBATOM GLSEPATOM GLSEPPTR (ADD1 GLSEPPTR)))
		   (QUOTE (:= __ _+ +_ _- -_ ~= <> >= <=)))
	      (SETQ GLSEPPTR (IPLUS GLSEPPTR 2))
	      (RETURN TMP))
	    ([AND (NOT GLSEPMINUS)
		  (EQ (NTHCHAR GLSEPATOM END)
		      (QUOTE -))
		  (NOT (EQ (NTHCHAR GLSEPATOM (ADD1 END))
			   (QUOTE _]
	      (SETQ END (STRPOSL GLSEPBITTBL GLSEPATOM (ADD1 END)))
	      (GO A))
	    [(IGREATERP END GLSEPPTR)
	      (RETURN (PROG1 (GLSUBATOM GLSEPATOM GLSEPPTR (SUB1 END))
			     (SETQ GLSEPPTR END]
	    (T (RETURN (PROG1 (GLSUBATOM GLSEPATOM GLSEPPTR GLSEPPTR)
			      (SETQ GLSEPPTR (ADD1 GLSEPPTR])

(GLSKIPCOMMENTS
  [LAMBDA NIL                                                (* edited: "26-MAY-82 16:17")
                                                             (* "GSN: " " 7-Jan-81 16:36")
                                                             (* Skip comments in GLEXPR.)
    (PROG NIL
      A   (COND
	    ([AND (LISTP GLEXPR)
		  (LISTP (CAR GLEXPR))
		  (OR (AND (EQ GLLISPDIALECT (QUOTE INTERLISP))
			   (EQ (CAAR GLEXPR)
			       (QUOTE *)))
		      (EQ (CAAR GLEXPR)
			  (QUOTE COMMENT]
	      (pop GLEXPR)
	      (GO A])

(GLSTRFN
  [LAMBDA (IND DES DESLIST)                                  (* edited: "10-NOV-82 11:16")

          (* Create a function call to retrieve the field IND from a structure described by the structure description DES.
	  The value is NIL if failure, (NIL DESCR) if DES equals IND, or (FNSTR DESCR) if IND can be gotten from within DES.
	  In the latter case, FNSTR is a function to get the IND from the atom *GL*. GLSTRFN only does retrieval from a 
	  structure, and does not get properties of an object unless they are part of a TRANSPARENT substructure.
	  DESLIST is a list of structure descriptions which have been tried already; this prevents a compiler loop in case 
	  the user specifies circular TRANSPARENT structures.)


    (PROG (DESIND TMP STR UNITREC)                           (* If this structure has already been tried, quit to 
							     avoid a loop.)
          (COND
	    ((FMEMB DES DESLIST)
	      (RETURN)))
          (SETQ DESLIST (CONS DES DESLIST))
          [COND
	    ((OR (NULL DES)
		 (NULL IND))
	      (RETURN))
	    [[OR (ATOM DES)
		 (AND (LISTP DES)
		      (ATOM (CADR DES))
		      (GL-A-AN? (CAR DES))
		      (SETQ DES (CADR DES]
	      (RETURN (COND
			((SETQ STR (GLGETSTR DES))
			  (GLSTRFN IND STR DESLIST))
			((SETQ UNITREC (GLUNIT? DES))
			  (GLGETFROMUNIT UNITREC IND DES))
			((EQ IND DES)
			  (LIST NIL (CADR DES)))
			(T NIL]
	    ((NLISTP DES)
	      (GLERROR (QUOTE GLSTRFN)
		       (LIST "Bad structure specification" DES]
          (SETQ DESIND (CAR DES))
          [COND
	    ((OR (EQ IND DES)
		 (EQ DESIND IND))
	      (RETURN (LIST NIL (CADR DES]
          (RETURN (SELECTQ DESIND
			   [CONS (OR (GLSTRVALB IND (CADR DES)
						(QUOTE (CAR *GL*)))
				     (GLSTRVALB IND (CADDR DES)
						(QUOTE (CDR *GL*]
			   ((LIST LISTOBJECT)
			     (GLLISTSTRFN IND DES DESLIST))
			   ((PROPLIST ALIST RECORD ATOMOBJECT OBJECT)
			     (GLPROPSTRFN IND DES DESLIST NIL))
			   (ATOM (GLATOMSTRFN IND DES DESLIST))
			   (TRANSPARENT (GLSTRFN IND (CADR DES)
						 DESLIST))
			   (COND
			     ((AND (SETQ TMP (ASSOC DESIND GLUSERSTRNAMES))
				   (CADR TMP))
			       (APPLY* (CADR TMP)
				       IND DES DESLIST))
			     ([OR (NULL (CDR DES))
				  (ATOM (CADR DES))
				  (AND (LISTP (CADR DES))
				       (GL-A-AN? (CAADR DES]
			       NIL)
			     (T (GLSTRFN IND (CADR DES)
					 DESLIST])

(GLSTRPROP
  [LAMBDA (STR GLPROP PROP)                                  (* edited: "18-NOV-82 16:54")

          (* If STR is a structured object, i.e., either a declared GLISP structure or a Class of Units, get the property 
	  PROP from the GLISP class of properties GLPROP.)


    (PROG (STRB UNITREC GLPROPS PROPL TMP SUPERS)
          (OR (SETQ STRB (GLXTRTYPE STR))
	      (RETURN))
          (COND
	    ((AND (SETQ GLPROPS (GETPROP STRB (QUOTE GLSTRUCTURE)))
		  (SETQ PROPL (LISTGET (CDR GLPROPS)
				       GLPROP))
		  (SETQ TMP (ASSOC PROP PROPL)))
	      (RETURN TMP)))
          (SETQ SUPERS (LISTGET (CDR GLPROPS)
				(QUOTE SUPERS)))
      LP  (COND
	    [SUPERS (COND
		      ((SETQ TMP (GLSTRPROP (CAR SUPERS)
					    GLPROP PROP))
			(RETURN TMP))
		      (T (SETQ SUPERS (CDR SUPERS))
			 (GO LP]
	    ((AND (SETQ UNITREC (GLUNIT? STRB))
		  (SETQ TMP (APPLY* (CADDDR UNITREC)
				    STRB GLPROP PROP)))
	      (RETURN TMP])

(GLSTRVAL
  [LAMBDA (OLDFN NEW)                                        (* edited: "11-JAN-82 14:58")
                                                             (* "GSN: " "19-Mar-81 12:27")

          (* GLSTRVAL is a subroutine of GLSTRFN. Given an old partial retrieval function, in which the item from which the 
	  retrieval is made is specified by *GL*, and a new function to compute *GL*, a composite function is made.)


    (PROG NIL
          (COND
	    [(CAR OLDFN)
	      (RPLACA OLDFN (SUBST NEW (QUOTE *GL*)
				   (CAR OLDFN]
	    (T (RPLACA OLDFN NEW)))
          (RETURN OLDFN])

(GLSTRVALB
  [LAMBDA (IND DES NEW)                                      (* "GSN: " "13-Aug-81 16:13")
                                                             (* "GSN: " "19-Mar-81 12:28")

          (* If the indicator IND can be found within the description DES, make a composite retrieval function using a copy 
	  of the function pattern NEW.)


    (PROG (TMP)
          (COND
	    [(SETQ TMP (GLSTRFN IND DES DESLIST))
	      (RETURN (GLSTRVAL TMP (COPY NEW]
	    (T (RETURN])

(GLSUBATOM
  [LAMBDA (X Y Z)                                            (* edited: "30-DEC-81 16:35")
    (OR (SUBATOM X Y Z)
	(QUOTE *NIL*])

(GLSUBSTTYPE
  [LAMBDA (TYPE SUBS)                                        (* edited: "30-AUG-82 10:29")
                                                             (* Make subtype substitutions within TYPE according to 
							     GLTYPESUBS.)
    (SUBLIS SUBS TYPE])

(GLSUPERS
  [LAMBDA (CLASS)                                            (* edited: "11-NOV-82 14:02")
                                                             (* Get the list of superclasses for CLASS.)
    (PROG (TMP)
          (RETURN (AND (SETQ TMP (GETPROP CLASS (QUOTE GLSTRUCTURE)))
		       (LISTGET (CDR TMP)
				(QUOTE SUPERS])

(GLTHE
  [LAMBDA (PLURALFLG)                                        (* edited: " 2-DEC-82 14:18")
                                                             (* edited: "17-Apr-81 14:23")
                                                             (* EXPR begins with THE. Parse the expression and return
							     code.)
    (DECLARE (SPECVARS SOURCE SPECS))
    (PROG (SOURCE SPECS NAME QUALFLG DTYPE NEWCONTEXT LOOPVAR LOOPCOND TMP)
                                                             (* Now trace the path specification.)
          (GLTHESPECS)
          [SETQ QUALFLG
	    (AND EXPR (MEMB (CAR EXPR)
			    (QUOTE (with With WITH who Who WHO which Which WHICH that That THAT]
      B   [COND
	    [(NULL SPECS)
	      (COND
		((MEMB (CAR EXPR)
		       (QUOTE (IS Is is HAS Has has ARE Are are)))
		  (RETURN (GLPREDICATE SOURCE CONTEXT T NIL)))
		(QUALFLG (GO C))
		(T (RETURN SOURCE]
	    ((AND QUALFLG (NOT PLURALFLG)
		  (NULL (CDR SPECS)))                        (* If this is a definite reference to a qualified 
							     entity, make the name of the entity plural.)
	      (SETQ NAME (CAR SPECS))
	      (RPLACA SPECS (GLPLURAL (CAR SPECS]            (* Try to find the next name on the list of SPECS from 
							     SOURCE.)
          [COND
	    [(NULL SOURCE)
	      (OR (SETQ SOURCE (GLIDNAME (SETQ NAME (pop SPECS))
					 NIL))
		  (RETURN (GLERROR (QUOTE GLTHE)
				   (LIST "The definite reference to" NAME "could not be found."]
	    (SPECS (SETQ SOURCE (GLGETFIELD SOURCE (pop SPECS)
					    CONTEXT]
          (GO B)
      C   [COND
	    ((NEQ [CAR (SETQ DTYPE (GLXTRTYPE (CADR SOURCE]
		  (QUOTE LISTOF))
	      (OR (EQ [CAR (SETQ DTYPE (GLXTRTYPE (GLGETSTR DTYPE]
		      (QUOTE LISTOF))
		  (GLERROR (QUOTE GLTHE)
			   (LIST "The group name" NAME "has type" DTYPE 
				 "which is not a legal group type."]
          (SETQ NEWCONTEXT (CONS NIL CONTEXT))
          (GLADDSTR (SETQ LOOPVAR (GLMKVAR))
		    NAME
		    (CADR DTYPE)
		    NEWCONTEXT)
          (SETQ LOOPCOND (GLPREDICATE (LIST LOOPVAR (CADR DTYPE))
				      NEWCONTEXT
				      (MEMB (pop EXPR)
					    (QUOTE (who Who WHO which Which WHICH that That THAT)))
				      NIL))
          [SETQ TMP (GLGENCODE (LIST (COND
				       (PLURALFLG (QUOTE SUBSET))
				       (T (QUOTE SOME)))
				     (CAR SOURCE)
				     (LIST (QUOTE FUNCTION)
					   (LIST (QUOTE LAMBDA)
						 (LIST LOOPVAR)
						 (CAR LOOPCOND]
          (RETURN (COND
		    (PLURALFLG (LIST TMP DTYPE))
		    (T (LIST (LIST (QUOTE CAR)
				   TMP)
			     (CADR DTYPE])

(GLTHESPECS
  [LAMBDA NIL                                                (* edited: "20-MAY-82 17:19")
                                                             (* "GSN: " "17-Apr-81 14:23")
                                                             (* EXPR begins with THE. Parse the expression and return
							     code in SOURCE and path names in SPECS.)
    (PROG NIL
      A   [COND
	    ((NULL EXPR)
	      (RETURN))
	    ((MEMB (CAR EXPR)
		   (QUOTE (THE The the)))
	      (pop EXPR)
	      (COND
		((NULL EXPR)
		  (RETURN (GLERROR (QUOTE GLTHE)
				   (LIST "Nothing following THE"]
          (COND
	    [(ATOM (CAR EXPR))
	      (GLSEPINIT (CAR EXPR))
	      (COND
		((EQ (GLSEPNXT)
		     (CAR EXPR))
		  (SETQ SPECS (CONS (pop EXPR)
				    SPECS)))
		(T (GLSEPCLR)
		   (SETQ SOURCE (GLDOEXPR NIL CONTEXT T))
		   (RETURN]
	    (T (SETQ SOURCE (GLDOEXPR NIL CONTEXT T))
	       (RETURN)))                                    (* SPECS contains a path specification.
							     See if there is any more.)
          (COND
	    ((MEMB (CAR EXPR)
		   (QUOTE (OF Of of)))
	      (pop EXPR)
	      (GO A])

(GLTRANSPARENTTYPES
  [LAMBDA (STR)                                              (* edited: "14-DEC-81 10:51")
                                                             (* Return a list of all transparent types defined for 
							     STR)
    (DECLARE (SPECVARS TTLIST))
    (PROG (TTLIST)
          [COND
	    ((ATOM STR)
	      (SETQ STR (GLGETSTR STR]
          (GLTRANSPB STR)
          (RETURN (DREVERSE TTLIST])

(GLTRANSPB
  [LAMBDA (STR)                                              (* edited: "13-NOV-81 15:37")
                                                             (* Look for TRANSPARENT substructures for 
							     GLTRANSPARENTTYPES.)
    (COND
      ((NLISTP STR))
      ((EQ (CAR STR)
	   (QUOTE TRANSPARENT))
	(SETQ TTLIST (CONS STR TTLIST)))
      [(MEMB (CAR STR)
	     (QUOTE (LISTOF ALIST PROPLIST]
      (T (MAPC (CDR STR)
	       (FUNCTION GLTRANSPB])

(GLTRANSPROG
  [LAMBDA (X)                                                (* edited: " 4-JUN-82 11:18")

          (* Translate places where a PROG variable is initialized to a value as allowed by Interlisp.
	  This is done by adding a SETQ to set the value of each PROG variable which is initialized.
	  In some cases, a change of variable name is required to preserve the same semantics.)


    (PROG (TMP ARGVALS SETVARS)
          [MAP (CADR X)
	       (FUNCTION (LAMBDA (Y)
		   (COND
		     ((LISTP (CAR Y))                        (* If possible, use the same variable;
							     otherwise, make a new one.)
		       [SETQ TMP (COND
			   ([OR [SOME (CADR X)
				      (FUNCTION (LAMBDA (Z)
					  (AND (LISTP Z)
					       (GLOCCURS (CAR Z)
							 (CADAR Y]
				(SOME ARGVALS (FUNCTION (LAMBDA (Z)
					  (GLOCCURS (CAAR Y)
						    Z]
			     (GLMKVAR))
			   (T (CAAR Y]
		       [SETQ SETVARS (NCONC1 SETVARS (LIST (QUOTE SETQ)
							   TMP
							   (CADAR Y]
		       (DSUBST TMP (CAAR Y)
			       (CDDR X))
		       (SETQ ARGVALS (CONS (CADAR Y)
					   ARGVALS))
		       (RPLACA Y TMP]
          [COND
	    (SETVARS (RPLACD (CDR X)
			     (NCONC SETVARS (CDDR X]
          (RETURN X])

(GLUCILISPTRANSFM
  [LAMBDA (X)                                                (* edited: "17-NOV-82 11:22")
                                                             (* Transform an expression X for MACLISP dialect.)
    (PROG (TMP NOTFLG)                                       (* First do argument reversals.)
          [COND
	    ((NLISTP X)
	      (RETURN X))
	    [(FMEMB (CAR X)
		    (QUOTE (MAP MAPC MAPCAR MAPCONC MAPLIST MAPCON SOME EVERY SUBSET GLSTRGEP 
				GLSTRLESSP)))
	      (SETQ X (LIST (CAR X)
			    (CADDR X)
			    (CADR X]
	    ((FMEMB (CAR X)
		    (QUOTE (PUTPROP)))
	      (SETQ X (LIST (CAR X)
			    (CADR X)
			    (CADDDR X)
			    (CADDR X]                        (* Next see if the result should be negated.)
          [SETQ NOTFLG (FMEMB (CAR X)
			      (QUOTE (GLSTRGREATERP GLSTRLESSP]
                                                             (* Now do function renamings.)
          [COND
	    [[SETQ TMP (FASSOC (CAR X)
			       (QUOTE ((MEMB MEMQ)
					(FMEMB MEMQ)
					(FASSOC ASSOC)
					(GETPROP GET)
					(GETPROPLIST CDR)
					(EQP =)
					(IGREATERP >)
					(IGEQ GE)
					(GEQ GE)
					(ILESSP <)
					(ILEQ LE)
					(LEQ LE)
					(IPLUS +)
					(IDIFFERENCE -)
					(ITIMES *)
					(IQUOTIENT //)
					(MAPLIST MAPL)
					(MAPCAR MAPCL)
					(DECLARE COMMENT)
					(NCHARS FLATSIZEC)   (* COMMENT)
					(PACK READLIST)
					(UNPACK EXPLODE)
					(FIXP INUMP)
					(pop POP)
					(push PUSH)
					(LISTP CONSP)
					(ALPHORDER LEXORDER)
					(GLSTRGREATERP LEXORDER)
					(GLSTRLESSP LEXORDER)
					(STREQUAL EQSTR)
					(GLSTRGEP LEXORDER]
	      (SETQ X (CONS (CADR TMP)
			    (CDR X]
	    ((AND (EQ (CAR X)
		      (QUOTE RETURN))
		  (NULL (CDR X)))
	      (SETQ X (LIST (CAR X)
			    NIL)))
	    ((AND (EQ (CAR X)
		      (QUOTE APPEND))
		  (NULL (CDDR X)))
	      (SETQ X (LIST (CAR X)
			    (CADR X)
			    NIL)))
	    ((EQ (CAR X)
		 (QUOTE PROG))
	      (GLTRANSPROG X))
	    [(EQ (CAR X)
		 (QUOTE APPLY*))                             (* Change APPLY* into APPLY.)
	      (SETQ X (LIST (QUOTE APPLY)
			    (CADR X)
			    (CONS (QUOTE LIST)
				  (CDDR X]
	    ((EQ (CAR X)
		 (QUOTE ERROR))                              (* Make ERROR have only a single argument.)
	      (SETQ X (LIST (CAR X)
			    (CONS (QUOTE LIST)
				  (CDR X]
          (RETURN (COND
		    (NOTFLG (LIST (QUOTE NOT)
				  X))
		    (T X])

(GLUNITOP
  [LAMBDA (LHS RHS OP)                                       (* edited: "27-MAY-82 13:08")

          (* GLUNITOP calls a function to generate code for an operation on a unit in a units package.
	  UNITREC is the unit record for the units package, LHS and RHS the code for the left-hand side and right-hand side 
	  of the operation (in general, the (QUOTE GET') code for each side), and OP is the operation to be performed.)


    (PROG (TMP LST UNITREC)                                  (* 
							     
"See if the LHS code matches the GET function of a unit package.")
          (SETQ LST GLUNITPKGS)
      A   (COND
	    ((NULL LST)
	      (RETURN))
	    ((NOT (MEMB (CAAR LHS)
			(CADAR LST)))
	      (SETQ LST (CDR LST))
	      (GO A)))
          (SETQ UNITREC (CAR LST))
          [COND
	    ((SETQ TMP (ASSOC OP (CADDR UNITREC)))
	      (RETURN (APPLY* (CDR TMP)
			      LHS RHS]
          (RETURN])

(GLUNIT?
  [LAMBDA (STR)                                              (* edited: "27-MAY-82 13:08")

          (* GLUNIT? tests a given structure to see if it is a unit of one of the unit packages on GLUNITPKGS.
	  If so, the value is the unit package record for the unit package which matched.)


    (PROG (UPS)
          (SETQ UPS GLUNITPKGS)
      LP  [COND
	    ((NULL UPS)
	      (RETURN))
	    ((APPLY* (CAAR UPS)
		     STR)
	      (RETURN (CAR UPS]
          (SETQ UPS (CDR UPS))
          (GO LP])

(GLUNWRAP
  [LAMBDA (X BUSY)                                           (* edited: "19-OCT-82 16:00")
                                                             (* Unwrap an expression X by removing extra stuff 
							     inserted during compilation.)
    (COND
      ((NLISTP X)
	X)
      ((NOT (ATOM (CAR X)))
	(ERROR (QUOTE GLUNWRAP)
	       X))
      ((SELECTQ (CAR X)
		((QUOTE GO)
		  X)
		((PROG2 PROGN)
		  (COND
		    ((NULL (CDDR X))
		      (GLUNWRAP (CADR X)
				BUSY))
		    (T [MAP (CDR X)
			    (FUNCTION (LAMBDA (Y)
				(RPLACA Y (GLUNWRAP (CAR Y)
						    (AND BUSY (NULL (CDR Y]
		       (GLEXPANDPROGN X)
		       X)))
		(PROG1 (COND
			 ((NULL (CDDR X))
			   (GLUNWRAP (CADR X)
				     BUSY))
			 (T [MAP (CDR X)
				 (FUNCTION (LAMBDA (Y)
				     (RPLACA Y (GLUNWRAP (CAR Y)
							 (AND BUSY (EQ Y (CADR X]
			    (COND
			      (BUSY (GLEXPANDPROGN (CDDR X)))
			      (T (RPLACA X (QUOTE PROGN))
				 (GLEXPANDPROGN X)))
			    X)))
		(FUNCTION (RPLACA (CDR X)
				  (GLUNWRAP (CADR X)
					    BUSY))
			  [MAP (CDDR X)
			       (FUNCTION (LAMBDA (Y)
				   (RPLACA Y (GLUNWRAP (CAR Y)
						       T]
			  X)
		((MAP MAPC MAPCAR MAPCONC SUBSET SOME EVERY)
		  (GLUNWRAPMAP X BUSY))
		[LAMBDA [MAP (CDDR X)
			     (FUNCTION (LAMBDA (Y)
				 (RPLACA Y (GLUNWRAP (CAR Y)
						     (AND BUSY (NULL (CDR Y]
			(GLEXPANDPROGN (CDDR X))
			X]
		(PROG (GLUNWRAPPROG X BUSY))
		(COND (GLUNWRAPCOND X BUSY))
		((SELECTQ CASEQ)
		  (GLUNWRAPSELECTQ X BUSY))
		(COND
		  ((AND (EQ (CAR X)
			    (QUOTE *))
			(EQ GLLISPDIALECT (QUOTE INTERLISP)))
		    X)
		  ((AND (NOT BUSY)
			(CDR X)
			(NULL (CDDR X))
			(GLPURE (CAR X)))
		    (GLUNWRAP (CADR X)
			      NIL))
		  (T [MAP (CDR X)
			  (FUNCTION (LAMBDA (Y)
			      (RPLACA Y (GLUNWRAP (CAR Y)
						  T]
		     (COND
		       ((AND (CDR X)
			     (NULL (CDDR X))
			     (LISTP (CADR X))
			     (GLCARCDR? (CAR X))
			     (GLCARCDR? (CAADR X))
			     (ILESSP (IPLUS (NCHARS (CAR X))
					    (NCHARS (CAADR X)))
				     9))
			 [RPLACA X (PACK (CONS (QUOTE C)
					       (DREVERSE (CONS (QUOTE R)
							       (NCONC (GLANYCARCDR? (CAADR X))
								      (GLANYCARCDR? (CAR X]
			 (RPLACA (CDR X)
				 (CADADR X))
			 (GLUNWRAP X BUSY))
		       ([AND (GETPROP (CAR X)
				      (QUOTE GLEVALWHENCONST))
			     (EVERY (CDR X)
				    (FUNCTION GLCONST?))
			     (OR (NOT (GETPROP (CAR X)
					       (QUOTE GLARGSNUMBERP)))
				 (EVERY (CDR X)
					(FUNCTION NUMBERP]
			 (EVAL X))
		       ((FMEMB (CAR X)
			       (QUOTE (AND OR)))
			 (GLUNWRAPLOG X))
		       (T X])

(GLUNWRAPCOND
  [LAMBDA (X BUSY)                                           (* edited: "23-APR-82 15:10")
                                                             (* Unwrap a COND expression.)
    (PROG (RESULT)
          (SETQ RESULT X)
      A   (COND
	    ((NULL (CDR RESULT))
	      (GO B)))
          (RPLACA (CADR RESULT)
		  (GLUNWRAP (CAADR RESULT)
			    T))
          [COND
	    ((EQ (CAADR RESULT)
		 NIL)
	      (RPLACD RESULT (CDDR RESULT))
	      (GO A))
	    (T [MAP (CDADR RESULT)
		    (FUNCTION (LAMBDA (Y)
			(RPLACA Y (GLUNWRAP (CAR Y)
					    (AND BUSY (NULL (CDR Y]
	       (GLEXPANDPROGN (CDADR RESULT]
          (COND
	    ((EQ (CAADR RESULT)
		 T)
	      (RPLACD (CDR RESULT)
		      NIL)))
          (SETQ RESULT (CDR RESULT))
          (GO A)
      B   (COND
	    [(AND (NULL (CDDR X))
		  (EQ (CAADR X)
		      T))
	      (RETURN (CONS (QUOTE PROGN)
			    (CDADR X]
	    (T (RETURN X])

(GLUNWRAPLOG
  [LAMBDA (X)                                                (* edited: "22-AUG-82 14:51")

          (* Unwrap a logical expression by performing constant transformations and splicing in sublists of the same type, 
	  e.g., (AND X (AND Y Z)) -> (AND X Y Z).)


    (PROG (Y)                                                (* First look for constant transformations which can 
							     simplify the expression.)
          [COND
	    [(EQ (CAR X)
		 (QUOTE AND))
	      (COND
		((NULL (CDDR X))
		  (RETURN (CADR X)))
		((EQ (CADR X)
		     NIL)
		  (RETURN NIL))
		((EQ (CADR X)
		     T)
		  (RETURN (CADDR X]
	    ((EQ (CAR X)
		 (QUOTE OR))
	      (COND
		((NULL (CDDR X))
		  (RETURN (CADR X)))
		((EQ (CADR X)
		     NIL)
		  (RETURN (CADDR X)))
		((EQ (CADR X)
		     T)
		  (RETURN T]                                 (* Now splice together logical expressions with same 
							     operator.)
          (SETQ Y (CDR X))
      LP  [COND
	    ((NULL Y)
	      (RETURN X))
	    ((AND (LISTP (CAR Y))
		  (EQ (CAAR Y)
		      (CAR X)))
	      (RPLACD (LAST (CAR Y))
		      (CDR Y))
	      (RPLACD Y (CDDAR Y))
	      (RPLACA Y (CADAR Y]
          (SETQ Y (CDR Y))
          (GO LP])

(GLUNWRAPMAP
  [LAMBDA (X BUSY)                                           (* edited: "19-OCT-82 16:03")
                                                             (* Unwrap and optimize mapping-type functions.)
    (PROG (LST FN OUTSIDE INSIDE OUTFN INFN NEWFN NEWMAP TMPVAR NEWLST)
          (SELECTQ GLLISPDIALECT
		   [(INTERLISP UTLISP PSL)
		     (SETQ LST (GLUNWRAP (CADR X)
					 T))
		     (SETQ FN (GLUNWRAP (CADDR X)
					(NOT (MEMB (CAR X)
						   (QUOTE (MAPC MAP]
		   [(MACLISP FRANZLISP UCILISP)
		     (SETQ LST (GLUNWRAP (CADDR X)
					 T))
		     (SETQ FN (GLUNWRAP (CADR X)
					(NOT (MEMB (CAR X)
						   (QUOTE (MAPC MAP]
		   (ERROR))
          (COND
	    ([OR [NOT (MEMB (SETQ OUTFN (CAR X))
			    (QUOTE (SUBSET MAPCAR MAPC MAPCONC]
		 (NOT (AND (LISTP LST)
			   (MEMB (SETQ INFN (CAR LST))
				 (QUOTE (SUBSET MAPCAR]
	      (GO OUT)))                                     (* Optimize compositions of mapping functions to avoid 
							     construction of lists of intermediate results.)

          (* These optimizations are not correct if the mapping functions have interdependent side-effects.
	  However, these are likely to be very rare, so we do it anyway.)


          (SETQ OUTSIDE (GLXTRFN FN))
          [SETQ INSIDE (GLXTRFN (SELECTQ GLLISPDIALECT
					 ((INTERLISP PSL)
					   (SETQ NEWLST (CADR LST))
					   (CADDR LST))
					 ((MACLISP FRANZLISP UCILISP)
					   (SETQ NEWLST (CADDR LST))
					   (CADR LST))
					 (ERROR]
          (SELECTQ INFN
		   (SUBSET (SELECTQ OUTFN
				    [(SUBSET MAPCONC)
				      (SETQ NEWMAP OUTFN)
				      (SETQ NEWFN (LIST (QUOTE AND)
							(CADR INSIDE)
							(SUBST (CAR INSIDE)
							       (CAR OUTSIDE)
							       (CADR OUTSIDE]
				    [MAPCAR (SETQ NEWMAP (QUOTE MAPCONC))
					    (SETQ NEWFN (LIST (QUOTE AND)
							      (CADR INSIDE)
							      (LIST (QUOTE CONS)
								    (SUBST (CAR INSIDE)
									   (CAR OUTSIDE)
									   (CADR OUTSIDE))
								    NIL]
				    [MAPC (SETQ NEWMAP (QUOTE MAPC))
					  (SETQ NEWFN (LIST (QUOTE AND)
							    (CADR INSIDE)
							    (SUBST (CAR INSIDE)
								   (CAR OUTSIDE)
								   (CADR OUTSIDE]
				    (ERROR)))
		   (MAPCAR [SETQ NEWFN (LIST (QUOTE PROG)
					     (LIST (SETQ TMPVAR (GLMKVAR)))
					     (LIST (QUOTE SETQ)
						   TMPVAR
						   (CADR INSIDE))
					     (LIST (QUOTE RETURN)
						   (QUOTE *GLCODE*]
			   (SELECTQ OUTFN
				    (SUBSET (SETQ NEWMAP (QUOTE MAPCONC))
					    (SETQ NEWFN (SUBST (LIST (QUOTE AND)
								     (SUBST TMPVAR (CAR OUTSIDE)
									    (CADR OUTSIDE))
								     (LIST (QUOTE CONS)
									   TMPVAR NIL))
							       (QUOTE *GLCODE*)
							       NEWFN)))
				    (MAPCAR (SETQ NEWMAP (QUOTE MAPCAR))
					    (SETQ NEWFN (SUBST (SUBST TMPVAR (CAR OUTSIDE)
								      (CADR OUTSIDE))
							       (QUOTE *GLCODE*)
							       NEWFN)))
				    (MAPC (SETQ NEWMAP (QUOTE MAPC))
					  (SETQ NEWFN (SUBST (SUBST TMPVAR (CAR OUTSIDE)
								    (CADR OUTSIDE))
							     (QUOTE *GLCODE*)
							     NEWFN)))
				    (ERROR)))
		   (ERROR))
          (RETURN (GLUNWRAP [GLGENCODE (LIST NEWMAP NEWLST (LIST (QUOTE FUNCTION)
								 (LIST (QUOTE LAMBDA)
								       (LIST (CAR INSIDE))
								       NEWFN]
			    BUSY))
      OUT (RETURN (GLGENCODE (LIST OUTFN LST FN])

(GLUNWRAPPROG
  [LAMBDA (X BUSY)                                           (* edited: "18-NOV-82 12:18")
                                                             (* Unwrap a PROG expression.)
    (PROG (LAST)
          (COND
	    ((NEQ GLLISPDIALECT (QUOTE INTERLISP))
	      (GLTRANSPROG X)))                              (* First see if the PROG is not busy and ends with a 
							     RETURN.)
          [COND
	    ((AND (NOT BUSY)
		  (SETQ LAST (LAST X))
		  (LISTP (CAR LAST))
		  (EQ (CAAR LAST)
		      (QUOTE RETURN)))                       (* Remove the RETURN. If atomic, remove the atom also.)
	      (COND
		((ATOM (CADAR LAST))
		  (RPLACD (NLEFT X 2)
			  NIL))
		(T (RPLACA LAST (CADAR LAST]                 (* Do any initializations of PROG variables.)
          [MAPC (CADR X)
		(FUNCTION (LAMBDA (Y)
		    (COND
		      ((LISTP Y)
			(RPLACA (CDR Y)
				(GLUNWRAP (CADR Y)
					  T]
          [MAP (CDDR X)
	       (FUNCTION (LAMBDA (Y)
		   (RPLACA Y (GLUNWRAP (CAR Y)
				       NIL]
          (GLEXPANDPROGN (CDDR X))
          (RETURN X])

(GLUNWRAPSELECTQ
  [LAMBDA (X BUSY)                                           (* edited: "22-AUG-82 16:07")
                                                             (* Unwrap a SELECTQ or CASEQ expression.)
    (PROG (L SELECTOR)                                       (* First unwrap the component expressions.)
          (RPLACA (CDR X)
		  (GLUNWRAP (CADR X)
			    T))
          [MAP (CDDR X)
	       (FUNCTION (LAMBDA (Y)
		   (COND
		     ((OR (CDR Y)
			  (EQ (CAR X)
			      (QUOTE CASEQ)))
		       [MAP (CDAR Y)
			    (FUNCTION (LAMBDA (Z)
				(RPLACA Z (GLUNWRAP (CAR Z)
						    (AND BUSY (NULL (CDR Z]
		       (GLEXPANDPROGN (CDAR Y)))
		     (T (RPLACA Y (GLUNWRAP (CAR Y)
					    BUSY]            (* Test if the selector is a compile-time constant.)
          (COND
	    ((NOT (GLCONST? (CADR X)))
	      (RETURN X)))                                   (* Evaluate the selection at compile time.)
          (SETQ SELECTOR (GLCONSTVAL (CADR X)))
          (SETQ L (CDDR X))
      LP  [COND
	    ((NULL L)
	      (RETURN NIL))
	    ((AND (NULL (CDR L))
		  (EQ (CAR X)
		      (QUOTE SELECTQ)))
	      (RETURN (CAR L)))
	    ((AND (EQ (CAR X)
		      (QUOTE CASEQ))
		  (EQ (CAAR L)
		      T))
	      (RETURN (GLUNWRAP (CONS (QUOTE PROGN)
				      (CDAR L))
				BUSY)))
	    ([OR (EQ SELECTOR (CAAR L))
		 (AND (LISTP (CAAR L))
		      (MEMB SELECTOR (CAAR L]
	      (RETURN (GLUNWRAP (CONS (QUOTE PROGN)
				      (CDAR L))
				BUSY]
          (SETQ L (CDR L))
          (GO LP])

(GLUPDATEVARTYPE
  [LAMBDA (VAR TYPE)                                         (* edited: " 5-MAY-82 15:49")
                                                             (* "GSN: " "25-Jan-81 18:00")
                                                             (* Update the type of VAR to be TYPE.)
    (PROG (CTXENT)
          (COND
	    ((NULL TYPE))
	    [(SETQ CTXENT (GLFINDVARINCTX VAR CONTEXT))
	      (COND
		((NULL (CADDR CTXENT))
		  (RPLACA (CDDR CTXENT)
			  TYPE]
	    (T (GLADDSTR VAR NIL TYPE CONTEXT])

(GLUSERFN
  [LAMBDA (EXPR)                                             (* edited: " 6-MAY-82 11:17")
                                                             (* "GSN: " " 7-Apr-81 10:44")

          (* Process a user-function, i.e., any function which is not specially compiled by GLISP. The function is tested to
	  see if it is one which a unit package wants to compile specially; if not, the function is compiled by GLUSERFNB.)


    (PROG (FNNAME TMP UPS)
          (SETQ FNNAME (CAR EXPR))                           (* First see if a user structure-name package wants to 
							     intercept this function call.)
          (SETQ UPS GLUSERSTRNAMES)
      LPA [COND
	    ((NULL UPS)
	      (GO B))
	    ([SETQ TMP (ASSOC FNNAME (CAR (CDDDDR (CAR UPS]
	      (RETURN (APPLY* (CDR TMP)
			      EXPR CONTEXT]
          (SETQ UPS (CDR UPS))
          (GO LPA)
      B                                                      (* Test the function name to see if it is a function 
							     which some unit package would like to intercept and 
							     compile specially.)
          (SETQ UPS GLUNITPKGS)
      LP  [COND
	    ((NULL UPS)
	      (RETURN (GLUSERFNB EXPR)))
	    ([AND [MEMB FNNAME (CAR (CDDDDR (CAR UPS]
		  (SETQ TMP (ASSOC (QUOTE UNITFN)
				   (CADDR (CAR UPS]
	      (RETURN (APPLY* (CDR TMP)
			      EXPR CONTEXT]
          (SETQ UPS (CDR UPS))
          (GO LP])

(GLUSERFNB
  [LAMBDA (EXPR)                                             (* edited: "26-JUL-82 16:01")
                                                             (* "GSN: " " 7-Apr-81 10:44")
                                                             (* Parse an arbitrary function by getting the function 
							     name and then calling GLDOEXPR to get the arguments.)
    (PROG (ARGS ARGTYPES FNNAME TMP)
          (SETQ FNNAME (pop EXPR))
      A   (COND
	    [(NULL EXPR)
	      (SETQ ARGS (DREVERSE ARGS))
	      (SETQ ARGTYPES (DREVERSE ARGTYPES))
	      (RETURN (COND
			((AND (GETPROP FNNAME (QUOTE GLEVALWHENCONST))
			      (EVERY ARGS (FUNCTION GLCONST?)))
			  (LIST (EVAL (CONS FNNAME ARGS))
				(GLRESULTTYPE FNNAME ARGTYPES)))
			[(AND (GLABSTRACTFN? FNNAME)
			      (SETQ TMP (GLINSTANCEFN FNNAME ARGTYPES)))
			  (LIST (CONS (CAR TMP)
				      ARGS)
				(GETPROP (CAR TMP)
					 (QUOTE GLRESULTTYPE]
			(T (LIST (CONS FNNAME ARGS)
				 (GLRESULTTYPE FNNAME ARGTYPES]
	    ([SETQ TMP (OR (GLDOEXPR NIL CONTEXT T)
			   (PROG1 (GLERROR (QUOTE GLUSERFNB)
					   (LIST "Function call contains illegal item.  EXPR =" EXPR))
				  (SETQ EXPR NIL]
	      (SETQ ARGS (CONS (CAR TMP)
			       ARGS))
	      (SETQ ARGTYPES (CONS (CADR TMP)
				   ARGTYPES))
	      (GO A])

(GLUSERGETARGS
  [LAMBDA (EXPR CONTEXT)                                     (* edited: "24-AUG-82 17:40")
                                                             (* edited: " 7-Apr-81 10:44")
                                                             (* Get the arguments to an function call for use by a 
							     user compilation function.)
    (PROG (ARGS TMP)
          (pop EXPR)
      A   (COND
	    ((NULL EXPR)
	      (RETURN (DREVERSE ARGS)))
	    ([SETQ TMP (OR (GLDOEXPR NIL CONTEXT T)
			   (PROG1 (GLERROR (QUOTE GLUSERFNB)
					   (LIST "Function call contains illegal item.  EXPR =" EXPR))
				  (SETQ EXPR NIL]
	      (SETQ ARGS (CONS TMP ARGS))
	      (GO A])

(GLUSERSTROP
  [LAMBDA (LHS OP RHS)                                       (* edited: " 5-MAY-82 13:20")

          (* Try to perform an operation on a user-defined structure, which is LHS. The type of LHS is looked up on 
	  GLUSERSTRNAMES, and if found, the appropriate user function is called.)


    (PROG (TMP DES TMPB)
          (SETQ DES (CADR LHS))
          (COND
	    ((NULL DES)
	      (RETURN))
	    ((ATOM DES)
	      (RETURN (GLUSERSTROP (LIST (CAR LHS)
					 (GLGETSTR DES))
				   OP RHS)))
	    ((NLISTP DES)
	      (RETURN))
	    ([AND (SETQ TMP (ASSOC (CAR DES)
				   GLUSERSTRNAMES))
		  (SETQ TMPB (ASSOC OP (CADDDR TMP]
	      (RETURN (APPLY* (CDR TMPB)
			      LHS RHS)))
	    (T (RETURN])

(GLVALUE
  [LAMBDA (SOURCE PROP TYPE DESLIST)                         (* edited: "26-MAY-82 12:55")

          (* Get the value of the property PROP from SOURCE, whose type is given by TYPE. The property may be a field in the
	  structure, or may be a PROP virtual field.)

                                                             (* DESLIST is a list of object types which have 
							     previously been tried, so that a compiler loop can be 
							     prevented.)
    (PROG (TMP PROPL TRANS FETCHCODE)
          (COND
	    ((FMEMB TYPE DESLIST)
	      (RETURN))
	    ((SETQ TMP (GLSTRFN PROP TYPE DESLIST))
	      (RETURN (GLSTRVAL TMP SOURCE)))
	    ((SETQ PROPL (GLSTRPROP TYPE (QUOTE PROP)
				    PROP))
	      (SETQ TMP (GLCOMPMSG (LIST SOURCE TYPE)
				   PROPL NIL CONTEXT))
	      (RETURN TMP)))                                 (* See if the value can be found in a TRANSPARENT 
							     subobject.)
          (SETQ TRANS (GLTRANSPARENTTYPES TYPE))
      B   (COND
	    ((NULL TRANS)
	      (RETURN))
	    ((SETQ TMP (GLVALUE (QUOTE *GL*)
				PROP
				(GLXTRTYPE (CAR TRANS))
				(CONS (CAR TRANS)
				      DESLIST)))
	      (SETQ FETCHCODE (GLSTRFN (CAR TRANS)
				       TYPE NIL))
	      (GLSTRVAL TMP (CAR FETCHCODE))
	      (GLSTRVAL TMP SOURCE)
	      (RETURN TMP))
	    ((SETQ TMP (CDR TMP))
	      (GO B])

(GLVARTYPE
  [LAMBDA (VAR CONTEXT)                                      (* edited: "16-DEC-81 12:00")
                                                             (* "GSN: " "21-Apr-81 11:30")
                                                             (* Get the structure-description for a variable in the 
							     specified context.)
    (PROG (TMP)
          (RETURN (COND
		    ((SETQ TMP (GLFINDVARINCTX VAR CONTEXT))
		      (OR (CADDR TMP)
			  (QUOTE *NIL*)))
		    (T NIL])

(GLXTRFN
  [LAMBDA (FNLST)                                            (* edited: "28-MAY-82 14:12")

          (* Extract the code and variable from a FUNCTION list. If there is no variable, a new one is created.
	  The result is a list of the variable and code.)


    (PROG (TMP)                                              (* If only the function name is specified, make a LAMBDA
							     form.)
          [COND
	    ((ATOM (CADR FNLST))
	      (RPLACA (CDR FNLST)
		      (LIST (QUOTE LAMBDA)
			    (LIST (SETQ TMP (GLMKVAR)))
			    (LIST (CADR FNLST)
				  TMP]
          (RETURN (LIST (CAADR (CADR FNLST))
			(CADDR (CADR FNLST])

(GLXTRTYPE
  [LAMBDA (TYPE)                                             (* edited: "26-JUL-82 14:03")
                                                             (* Extract an atomic type name from a type spec which 
							     may be either <type> or (A <type>).)
    (COND
      ((ATOM TYPE)
	TYPE)
      ((NLISTP TYPE)
	NIL)
      ((AND (OR (GL-A-AN? (CAR TYPE))
		(EQ (CAR TYPE)
		    (QUOTE TRANSPARENT)))
	    (CDR TYPE)
	    (ATOM (CADR TYPE)))
	(CADR TYPE))
      ((MEMB (CAR TYPE)
	     GLTYPENAMES)
	TYPE)
      ((ASSOC (CAR TYPE)
	      GLUSERSTRNAMES)
	TYPE)
      ((AND (ATOM (CAR TYPE))
	    (CDR TYPE))
	(GLXTRTYPE (CADR TYPE)))
      (T (GLERROR (QUOTE GLXTRTYPE)
		  (LIST TYPE "is an illegal type specification."))
	 NIL])

(GLXTRTYPEB
  [LAMBDA (TYPE)                                             (* edited: "26-JUL-82 14:02")
                                                             (* Extract a -real- type from a type spec.)
    (COND
      ((NULL TYPE)
	NIL)
      [(ATOM TYPE)
	(COND
	  ((MEMB TYPE GLBASICTYPES)
	    TYPE)
	  (T (GLXTRTYPEB (GLGETSTR TYPE]
      ((NLISTP TYPE)
	NIL)
      ((MEMB (CAR TYPE)
	     GLTYPENAMES)
	TYPE)
      ((ASSOC (CAR TYPE)
	      GLUSERSTRNAMES)
	TYPE)
      ((AND (ATOM (CAR TYPE))
	    (CDR TYPE))
	(GLXTRTYPEB (CADR TYPE)))
      (T (GLERROR (QUOTE GLXTRTYPE)
		  (LIST TYPE "is an illegal type specification."))
	 NIL])

(GLXTRTYPEC
  [LAMBDA (TYPE)                                             (* edited: " 1-NOV-82 16:38")
                                                             (* Extract a -real- type from a type spec.)
    (AND (ATOM TYPE)
	 (NOT (MEMB TYPE GLBASICTYPES))
	 (GLXTRTYPE (GLGETSTR TYPE])

(SEND
  [NLAMBDA GLISPSENDARGS                                     (* edited: "17-NOV-82 11:25")
    (GLSENDB (EVAL (CAR GLISPSENDARGS))
	     (CADR GLISPSENDARGS)
	     (QUOTE MSG)
	     (MAPCAR (CDDR GLISPSENDARGS)
		     (FUNCTION EVAL])

(SENDPROP
  [NLAMBDA GLISPSENDPROPARGS                                 (* edited: "17-NOV-82 11:25")
    (GLSENDB (EVAL (CAR GLISPSENDPROPARGS))
	     (CADR GLISPSENDPROPARGS)
	     (CADDR GLISPSENDPROPARGS)
	     (MAPCAR (CDDDR GLISPSENDPROPARGS)
		     (FUNCTION EVAL])
)
(SETQ GLLISPDIALECT (QUOTE INTERLISP))
(GLINIT)


[GLISPOBJECTS


(GLTYPE

   [ATOM (PROPLIST (GLSTRUCTURE (CONS (STRDES ANYTHING)
				      (PROPLIST (PROP (PROPS (LISTOF GLPROPENTRY)))
						(ADJ (ADJS (LISTOF GLPROPENTRY)))
						(ISA (ISAS (LISTOF GLPROPENTRY)))
						(MSG (MSGS (LISTOF GLPROPENTRY)))
						(SUPERS (LISTOF GLTYPE]  )

(GLPROPENTRY

   [CONS (NAME ATOM)
	 (CONS (CODE ANYTHING)
	       (PROPLIST (RESULT GLTYPE)
			 (OPEN BOOLEAN]

   PROP   ((SHORTVALUE (NAME)))  )
]


(ADDTOVAR LAMBDASPLST GLAMBDA)
(LOAD (QUOTE LAMBDATRAN.COM))
[FILEPKGCOM 'GLISPCONSTANTS 'MACRO
 (QUOTE	(GLISPCONSTANTS
			  (E (GLPRETTYPRINTCONST
			       (QUOTE GLISPCONSTANTS]
(FILEPKGTYPE 'GLISPCONSTANTS 'DESCRIPTION 
			 "GLISP compile-time constants"
			 'GETDEF 'GLGETCONSTDEF)
[FILEPKGCOM 'GLISPGLOBALS 'MACRO
 (QUOTE	(GLISPGLOBALS
			  (E (GLPRETTYPRINTGLOBALS
			       (QUOTE GLISPGLOBALS]
(FILEPKGTYPE 'GLISPGLOBALS 'DESCRIPTION 
			 "GLISP global variables"
			 'GETDEF 'GLGETGLOBALDEF)
[FILEPKGCOM 'GLISPOBJECTS 'MACRO
 (QUOTE	(GLISPOBJECTS
			  (E (GLPRETTYPRINTSTRS
			       (QUOTE GLISPOBJECTS]
(FILEPKGTYPE 'GLISPOBJECTS 'DESCRIPTION 
			 "GLISP Object Definitions"
			 'GETDEF 'GLGETDEF 'DELDEF 'GLDELDEF)

(ADDTOVAR LAMBDATRANFNS (GLAMBDA GLAMBDATRAN EXPR NIL))
(DECLARE: DOEVAL@COMPILE DONTCOPY

(ADDTOVAR GLOBALVARS GLQUIETFLG GLSEPBITTBL GLUNITPKGS GLSEPMINUS GLTYPENAMES GLBREAKONERROR 
	  GLUSERSTRNAMES GLLASTFNCOMPILED GLLASTSTREDITED GLCAUTIOUSFLG GLLISPDIALECT GLBASICTYPES)
)
(DECLARE: DOEVAL@COMPILE DONTCOPY

(SPECVARS CONTEXT EXPR VALBUSY FAULTFN GLSEPATOM GLSEPPTR GLTOPCTX RESULTTYPE RESULT GLNATOM FIRST 
	  OPNDS OPERS GLEXPR DESLIST EXPRSTACK GLTYPESUBS GLPROGLST ADDISATYPE)
)

(RPAQQ GLTYPENAMES (CONS LIST RECORD LISTOF ALIST ATOM OBJECT LISTOBJECT ATOMOBJECT))

(RPAQQ GLSPECIALFNS (GLAMBDATRAN GLANALYZEGLISP GLCOMPCOMS GLED GLEDS GLERROR GLGETD GLGETDB 
				 GLMAKEGLISPVERSION GLP GLPRETTYPRINTCONST GLPRETTYPRINTGLOBALS 
				 GLPRETTYPRINTSTRS))

(RPAQQ GLBASICTYPES (ATOM INTEGER REAL NUMBER STRING BOOLEAN ANYTHING))
(DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS 

(ADDTOVAR NLAMA SENDPROP SEND GLISPOBJECTS GLISPGLOBALS GLISPCONSTANTS GLERR GLDEFSTRQ GLDEFSTRNAMES 
			 AN A)

(ADDTOVAR NLAML )

(ADDTOVAR LAMA )
)
(DECLARE: DONTCOPY
  (FILEMAP(NIL (3757 205711 (A 3769 . 3888) (AN 3892 . 4012) (GL-A-AN? 4016 . 4246) (
GLABSTRACTFN? 4250 . 4607) (GLADDINSTANCEFN 4611 . 4928) (GLADDRESULTTYPE 4932 .
 5470) (GLADDSTR 5474 . 5950) (GLADJ 5954 . 7489) (GLAINTERPRETER 7493 . 7982) (
GLAMBDATRAN 7986 . 8812) (GLANALYZEGLISP 8816 . 9633) (GLANDFN 9637 . 10661) (
GLANYCARCDR? 10665 . 11386) (GLATOMSTRFN 11390 . 11883) (GLATMSTR? 11887 . 12642
) (GLBUILDALIST 12646 . 13341) (GLBUILDCONS 13345 . 14152) (GLBUILDLIST 14156 . 
14840) (GLBUILDNOT 14844 . 16063) (GLBUILDPROPLIST 16067 . 16478) (GLBUILDRECORD
 16482 . 18070) (GLBUILDSTR 18074 . 22285) (GLCARCDRRESULTTYPE 22289 . 22774) (
GLCARCDRRESULTTYPEB 22778 . 24006) (GLCARCDR? 24010 . 24330) (GLCC 24334 . 24574
) (GLCLASS 24578 . 24993) (GLCLASSMEMP 24997 . 25285) (GLCLASSP 25289 . 25689) (
GLCLASSSEND 25693 . 26159) (GLCOMP 26163 . 27729) (GLCOMPABSTRACT 27733 . 28591)
 (GLCOMPCOMS 28595 . 29461) (GLCOMPILE 29465 . 29876) (GLCOMPILE? 29880 . 30144)
 (GLCOMPMSG 30148 . 32969) (GLCOMPOPEN 32973 . 36639) (GLCOMPPROP 36643 . 38151)
 (GLCOMPPROPL 38155 . 40158) (GLCONST? 40162 . 40587) (GLCONSTSTR? 40591 . 41110
) (GLCONSTVAL 41114 . 41783) (GLCP 41787 . 42039) (GLDECL 42043 . 45510) (
GLDECLDS 45514 . 46173) (GLDEFFNRESULTTYPES 46177 . 46636) (GLDEFFNRESULTTYPEFNS
 46640 . 47087) (GLDEFPROP 47091 . 47953) (GLDEFSTR 47957 . 49433) (
GLDEFSTRNAMES 49437 . 49757) (GLDEFSTRQ 49761 . 50117) (GLDEFUNITPKG 50121 . 
51062) (GLDELDEF 51066 . 51321) (GLDESCENDANTP 51325 . 51749) (GLDOA 51753 . 
52553) (GLDOCASE 52557 . 54526) (GLDOCOND 54530 . 55606) (GLDOEXPR 55610 . 60005
) (GLDOFOR 60009 . 62788) (GLDOIF 62792 . 64271) (GLDOLAMBDA 64275 . 65024) (
GLDOMAIN 65028 . 66129) (GLDOMSG 66133 . 68013) (GLDOPROG 68017 . 69733) (
GLDOPROGN 69737 . 70100) (GLDOPROG1 70104 . 71146) (GLDOREPEAT 71150 . 72130) (
GLDORETURN 72134 . 72814) (GLDOSELECTQ 72818 . 74695) (GLDOSEND 74699 . 76150) (
GLDOSETQ 76154 . 76573) (GLDOTHE 76577 . 77073) (GLDOTHOSE 77077 . 77609) (
GLDOVARSETQ 77613 . 78090) (GLDOWHILE 78094 . 78902) (GLED 78906 . 79270) (GLEDS
 79274 . 79675) (GLEQUALFN 79679 . 81024) (GLERR 81028 . 81213) (GLERROR 81217 .
 82184) (GLEXPANDPROGN 82188 . 83012) (GLEXPENSIVE? 83016 . 83542) (
GLFINDVARINCTX 83546 . 83888) (GLFRANZLISPTRANSFM 83892 . 86417) (GLGENCODE 
86421 . 86968) (GLGETASSOC 86972 . 87326) (GLGETCONSTDEF 87330 . 87612) (GLGETD 
87616 . 87994) (GLGETDB 87998 . 88350) (GLGETDEF 88354 . 88678) (GLGETFIELD 
88682 . 91025) (GLGETFROMUNIT 91029 . 91614) (GLGETGLOBALDEF 91618 . 91849) (
GLGETPAIRS 91853 . 92674) (GLGETPROP 92678 . 93145) (GLGETSTR 93149 . 93699) (
GLGETSUPERS 93703 . 93983) (GLIDNAME 93987 . 95377) (GLIDTYPE 95381 . 96214) (
GLINIT 96218 . 101063) (GLINSTANCEFN 101067 . 102099) (GLINTERLISPTRANSFM 102103
 . 103300) (GLISPCONSTANTS 103304 . 104046) (GLISPGLOBALS 104050 . 104451) (
GLISPOBJECTS 104455 . 105090) (GLLISPADJ 105094 . 105732) (GLLISPISA 105736 . 
106355) (GLLISTRESULTTYPEFN 106359 . 107483) (GLLISTSTRFN 107487 . 108444) (
GLMACLISPTRANSFM 108448 . 110945) (GLMAKEFORLOOP 110949 . 112611) (
GLMAKEGLISPVERSION 112615 . 113506) (GLMAKESTR 113510 . 114369) (GLMAKEVTYPE 
114373 . 115593) (GLMINUSFN 115597 . 116152) (GLMKATOM 116156 . 116777) (
GLMKLABEL 116781 . 117128) (GLMKVAR 117132 . 117473) (GLMKVTYPE 117477 . 117730)
 (GLNCONCFN 117734 . 119939) (GLNEQUALFN 119943 . 120776) (GLNOTFN 120780 . 
121124) (GLNTHRESULTTYPEFN 121128 . 121536) (GLOCCURS 121540 . 121871) (GLOKSTR?
 121875 . 123432) (GLOPERAND 123436 . 124271) (GLOPERATOR? 124275 . 124593) (
GLORFN 124597 . 125154) (GLP 125158 . 125617) (GLPARSEXPR 125621 . 127943) (
GLPARSFLD 127947 . 129290) (GLPARSNFLD 129294 . 130192) (GLPLURAL 130196 . 
131087) (GLPOPFN 131091 . 132814) (GLPREC 132818 . 133932) (GLPREDICATE 133936 .
 137082) (GLPRETTYPRINTCONST 137086 . 137659) (GLPRETTYPRINTGLOBALS 137663 . 
138178) (GLPRETTYPRINTSTRS 138182 . 139088) (GLPROGN 139092 . 139913) (
GLPROPSTRFN 139917 . 141859) (GLPSLTRANSFM 141863 . 144685) (GLPURE 144689 . 
145044) (GLPUSHEXPR 145048 . 145626) (GLPUSHFN 145630 . 147835) (GLPUTARITH 
147839 . 149580) (GLPUTFN 149584 . 153545) (GLPUTPROPS 153549 . 154183) (
GLPUTUPFN 154187 . 155271) (GLREDUCE 155275 . 156336) (GLREDUCEARITH 156340 . 
161370) (GLREDUCEOP 161374 . 162252) (GLREMOVEFN 162256 . 164139) (GLRESGLOBAL 
164143 . 165138) (GLRESULTTYPE 165142 . 166671) (GLSENDB 166675 . 167250) (
GLSEPCLR 167254 . 167379) (GLSEPINIT 167383 . 167731) (GLSEPNXT 167735 . 169483)
 (GLSKIPCOMMENTS 169487 . 170047) (GLSTRFN 170051 . 172481) (GLSTRPROP 172485 . 
173458) (GLSTRVAL 173462 . 174072) (GLSTRVALB 174076 . 174574) (GLSUBATOM 174578
 . 174722) (GLSUBSTTYPE 174726 . 174999) (GLSUPERS 175003 . 175348) (GLTHE 
175352 . 177964) (GLTHESPECS 177968 . 179122) (GLTRANSPARENTTYPES 179126 . 
179558) (GLTRANSPB 179562 . 180038) (GLTRANSPROG 180042 . 181285) (
GLUCILISPTRANSFM 181289 . 183756) (GLUNITOP 183760 . 184703) (GLUNIT? 184707 . 
185230) (GLUNWRAP 185234 . 187900) (GLUNWRAPCOND 187904 . 188856) (GLUNWRAPLOG 
188860 . 190108) (GLUNWRAPMAP 190112 . 193509) (GLUNWRAPPROG 193513 . 194610) (
GLUNWRAPSELECTQ 194614 . 196162) (GLUPDATEVARTYPE 196166 . 196695) (GLUSERFN 
196699 . 198122) (GLUSERFNB 198126 . 199447) (GLUSERGETARGS 199451 . 200152) (
GLUSERSTROP 200156 . 200892) (GLVALUE 200896 . 202268) (GLVARTYPE 202272 . 
202770) (GLXTRFN 202774 . 203432) (GLXTRTYPE 203436 . 204204) (GLXTRTYPEB 204208
 . 204877) (GLXTRTYPEC 204881 . 205177) (SEND 205181 . 205427) (SENDPROP 205431 
. 205708)))))
STOP

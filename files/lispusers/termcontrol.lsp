(FILECREATED "30-Sep-86 11:33:56" <LISPUSERS>TERMCONTROL.LSP.40522 6357   

      changes to:  (VARS TERMCONTROLCOMS TERMCONTROLFNS)
		   (FNS TerminalType TerminalSetup DISPLAYTERMP))


(* Copyright (c)  by NIL. All rights reserved.)

(PRETTYCOMPRINT TERMCONTROLCOMS)

(RPAQQ TERMCONTROLCOMS ((FNS * TERMCONTROLFNS)
	(P (OR (BOUNDP 'TERMINALS)
	       (RPAQQ TERMINALS
		      (33 35 37 EXECUPORT ADM-3A DATAMEDIA-2500 VT132 
			  CONCEPT-100 TERMINET IDEAL VT05 VT50 LA30 GT40 LA36 
			  VT52 VT100 LA38 LA120 HAZELTINE-1500 CONCEPT-108 
			  CONCEPT-GRAPHICS-108 DATAMEDIA-1520 SOROC-120 HP2640 
			  VC404 WICAT ANSI ADM-6 SELANAR V1 V2 ADDS 
			  TEKTRONIX-4025 TELEVIDEO-912 VT125 VK100 VT102 H19 
			  VT131 VT200 GLASS TEKTRONIX-4014))))))

(RPAQQ TERMCONTROLFNS (TerminalType TerminalSetup DISPLAYTERMP))
(DEFINEQ

(TerminalType
  (LAMBDA (term)                                (* edited: "30-Sep-86 11:30")

          (* This procedure will always return the current terminal 
	  type. If term is not NIL, then the terminal type is set to 
	  that type of terminal)


    (PROG (oldType tnum (spellingList (CONSTANT (APPEND TERMINALS))))
          (SETQ oldType (CAR (NTH TERMINALS
				  (ADD1 (JS GTTYP 777777Q NIL NIL 2)))))
          (COND
	    ((NOT term)
	      (RETURN oldType))
	    ((FMEMB term TERMINALS)
	      (GO DOIT)))                       (* Try spelling correction)
          (SETQ term (FIXSPELL term NIL spellingList T))
          (COND
	    (term (GO DOIT))
	    (T (printout T "Strange terminal type - " term T)
	       (RETURN NIL)))
      DOIT(SETQ tnum (for t in TERMINALS bind (count _ 0)
			do (COND
			     ((EQ t term)
			       (RETURN count))
			     (T (add count 1)))))
          (JS STTYP 777777Q tnum)
          (RETURN oldType))))

(TerminalSetup
  (LAMBDA (termType)                            (* edited: "30-Sep-86 11:30")

          (* Does the right thing to echo mode and delete mode to 
	  cause the terminal to do the right thing for echoing and 
	  line deletion)


    (PROG (ttbl)
          (SETQ ttbl (GETTERMTABLE))
          (SELECTQ termType
		   ((VT100 VK100 VT102 VT125 VT131 VT132 VT200 SELANAR V1 V2)
		     (INTERRUPTCHAR 8)
		     (ECHOCONTROL 27 'REAL ttbl)
		     (DELETECONTROL 'LINEDELETE
				    (MKSTRING (PACKC (LIST 13 27 91 75)))
				    ttbl)
		     (DELETECONTROL '1STCHDEL (MKSTRING (PACKC (LIST 27 91 68)))
				    ttbl)
		     (DELETECONTROL 'NTHCHDEL (MKSTRING (PACKC (LIST 27 91 68)))
				    ttbl)
		     (DELETECONTROL 'POSTCHDEL "" ttbl)
		     (DELETECONTROL 'EMPTYCHDEL "" ttbl)
		     (DELETECONTROL 'NOECHO "" ttbl))
		   (VT52 (ECHOCONTROL 27 'REAL ttbl)
			 (DELETECONTROL 'LINEDELETE (MKSTRING
					  (PACKC (LIST 27 77)))
					ttbl)
			 (DELETECONTROL '1STCHDEL
					(MKSTRING (PACKC (LIST 27 68 27 75)))
					ttbl)
			 (DELETECONTROL 'NTHCHDEL
					(MKSTRING (PACKC (LIST 27 68 27 75)))
					ttbl)
			 (DELETECONTROL 'POSTCHDEL "" ttbl)
			 (DELETECONTROL 'EMPTYCHDEL "" ttbl)
			 (DELETECONTROL 'NOECHO "" ttbl))
		   (TELEVIDEO-912 (ECHOCONTROL 27 'REAL ttbl)
				  (ECHOCONTROL 8 'REAL ttbl)
				  (DELETECONTROL 'LINEDELETE
						 (MKSTRING (PACKC (LIST 13 27 
									84)))
						 ttbl)
				  (DELETECONTROL '1STCHDEL
						 (MKSTRING (PACKC (LIST 8 32 8))
							   )
						 ttbl)
				  (DELETECONTROL 'NTHCHDEL
						 (MKSTRING (PACKC (LIST 8 32 8))
							   )
						 ttbl)
				  (DELETECONTROL 'POSTCHDEL "" ttbl)
				  (DELETECONTROL 'EMPTYCHDEL "" ttbl)
				  (DELETECONTROL 'NOECHO "" ttbl))
		   (HAZELTINE-1500 (ECHOCONTROL 19 'REAL ttbl)
				   (ECHOCONTROL 8 'REAL ttbl)
				   (DELETECONTROL 'LINEDELETE
						  (MKSTRING (PACKC (LIST 126 19)
								   ))
						  ttbl)
				   (DELETECONTROL '1STCHDEL
						  (MKSTRING (PACKC (LIST 8 32 8)
								   ))
						  ttbl)
				   (DELETECONTROL 'NTHCHDEL
						  (MKSTRING (PACKC (LIST 8 32 8)
								   ))
						  ttbl)
				   (DELETECONTROL 'POSTCHDEL "" ttbl)
				   (DELETECONTROL 'EMPTYCHDEL "" ttbl)
				   (DELETECONTROL 'NOECHO "" ttbl))
		   ((DATAMEDIA-2500 DATAMEDIA-1520 CONCEPT-100)
		     (ECHOCONTROL 8 'REAL ttbl)
		     (ECHOCONTROL 23 'REAL ttbl)
		     (ECHOCONTROL 27 'REAL ttbl)
		     (ECHOCONTROL 30 'UPARROW ttbl)
		     (DELETECONTROL 'LINEDELETE (MKSTRING (PACKC (LIST 13 23)))
				    ttbl)
		     (DELETECONTROL '1STCHDEL (MKSTRING (PACKC (LIST 8 32 8)))
				    ttbl)
		     (DELETECONTROL 'NTHCHDEL (MKSTRING (PACKC (LIST 8 32 8)))
				    ttbl)
		     (DELETECONTROL 'POSTCHDEL "" ttbl)
		     (DELETECONTROL 'EMPTYCHDEL "" ttbl)
		     (DELETECONTROL 'NOECHO "" ttbl))
		   (H19 (ECHOCONTROL 8 'REAL ttbl)
			(ECHOCONTROL 27 'REAL ttbl)
			(ECHOCONTROL 30 'UPARROW ttbl)
			(DELETECONTROL 'LINEDELETE
				       (MKSTRING (CONCAT (PACKC (LIST 13 27))
							 'K))
				       ttbl)
			(DELETECONTROL '1STCHDEL (MKSTRING (PACKC (LIST 8 32 8))
							   )
				       ttbl)
			(DELETECONTROL 'NTHCHDEL (MKSTRING (PACKC (LIST 8 32 8))
							   )
				       ttbl)
			(DELETECONTROL 'POSTCHDEL "" ttbl)
			(DELETECONTROL 'NOECHO "" ttbl))
		   (PROGN (ECHOCONTROL 27 'SIMULATE ttbl)
			  (ECHOCONTROL 8 'UPARROW ttbl)
			  (ECHOCONTROL 23 'UPARROW ttbl)
			  (ECHOCONTROL 30 'UPARROW ttbl)
			  (DELETECONTROL 'LINEDELETE "##
" ttbl)
			  (DELETECONTROL '1STCHDEL "\" ttbl)
			  (DELETECONTROL 'NTHCHDEL "" ttbl)
			  (DELETECONTROL 'POSTCHDEL "\" ttbl)
			  (DELETECONTROL 'ECHO "" ttbl))))))

(DISPLAYTERMP
  (LAMBDA NIL                                   (* edited: "30-Sep-86 11:31")

          (* Redefinition of this function, so it knows what kind of 
	  display terminals we REALLY have on this system)


    (COND
      ((FMEMB (TerminalType)
	      '(33 35 37 EXECUPORT TERMINET IDEAL LA30 LA36 LA38 LA120))
	NIL)
      (T T))))
)
(OR (BOUNDP 'TERMINALS)
    (RPAQQ TERMINALS
	   (33 35 37 EXECUPORT ADM-3A DATAMEDIA-2500 VT132 CONCEPT-100 TERMINET 
	       IDEAL VT05 VT50 LA30 GT40 LA36 VT52 VT100 LA38 LA120 
	       HAZELTINE-1500 CONCEPT-108 CONCEPT-GRAPHICS-108 DATAMEDIA-1520 
	       SOROC-120 HP2640 VC404 WICAT ANSI ADM-6 SELANAR V1 V2 ADDS 
	       TEKTRONIX-4025 TELEVIDEO-912 VT125 VK100 VT102 H19 VT131 VT200 
	       GLASS TEKTRONIX-4014)))
(DECLARE: DONTCOPY
  (FILEMAP (NIL (836 5900 (TerminalType 848 . 1825) (TerminalSetup 1829 . 5540) (
DISPLAYTERMP 5544 . 5897)))))
STOP

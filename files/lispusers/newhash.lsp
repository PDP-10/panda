(FILECREATED " 9-Mar-84 09:33:45" <ONCOCIN.FORMS>NEWHASH.LSP.6 24117  

      previous date: " 9-Mar-84 09:18:04" <ONCOCIN.FORMS>NEWHASH.LSP.5)


(PRETTYCOMPRINT NEWHASHCOMS)

(RPAQQ NEWHASHCOMS ((FNS * NEWHASHFNS)
		    (FNS * NEWHASHSYSFNS)
		    (FNS TESTHASH)
		    (MACROS * NEWHASHMACROS)
		    (CONSTANTS HASH.ENTRY.BYTES HASH.ENTRY.SKIP)
		    (RECORDS HashFile)
		    (VARS PROBELST)
		    (INITVARS SYSHASHFILE SYSHASHFILELST REHASHGAG
			      (HASHLOADFACTOR .875)
			      (HASHFILEDEFAULTSIZE 512)
			      (HFGROWTHFACTOR 2)
			      (HASHSCRATCHLST (CONSTANT (for I to 30 collect 
							     NIL)))
			      (HASHFILERDTBL (COPYREADTABLE 'ORIG))
			      (HASHTEXTCHAR (CHARACTER (CHARCODE ^A)))
			      (HASHBITTABLE (MAKEBITTABLE (LIST HASHTEXTCHAR)))
			      (HASHSCRATCHCONSCELL (CONS)))
		    (ADDVARS (AFTERSYSOUTFORMS (CLEARHASHFILES)))
		    (GLOBALVARS * NEWHASHGLOBALS)
		    (SPECVARS REHASHGAG HASHFILERDTBL)
		    (BLOCKS * NEWHASHBLOCKS)
		    (P (SELECTQ (SYSTEMTYPE)
				((TENEX TOPS20)
				 (LOAD? '<LISPUSERS>DFOR10.COM 'SYSLOAD))
				NIL))))

(RPAQQ NEWHASHFNS (CLEARHASHFILES CLOSEHASHFILE COLLECTKEYS COPYHASHFILE 
				  COPYHASHITEM CREATEHASHFILE GETHASHFILE 
				  HASHBEFORECLOSE HASHFILEDATA HASHFILENAME 
				  HASHFILEP HASHFILEPROP HASHFILESPLST 
				  LOOKUPHASHFILE MAPHASHFILE OPENHASHFILE 
				  PUTHASHFILE REHASHFILE))
(DEFINEQ

(CLEARHASHFILES
  [LAMBDA (CLOSE RELEASE)                         (* cdl " 8-Nov-83 08:45")
                                                  (* Called after SYSOUT 
						  returns, to clean up any 
						  spurious items. Can also be 
						  called to close all 
						  hashfiles.)
    (COND
      (CLOSE (while SYSHASHFILELST bind PAIR
		do (SETQ PAIR (CAR SYSHASHFILELST)) 
                                                  (* Do it this way, so the 
						  DREMOVE in HASHBEFORECLOSE 
						  doesn%'t screw up this 
						  iteration)
		   (CLOSEF? (CAR PAIR))
		   (replace Valid? of (CDR PAIR) with NIL)
		   (SETQ SYSHASHFILELST (CDR SYSHASHFILELST)))
                                                  (* Invalidate anything that 
						  was open before the sysout)
	     (SETQ SYSHASHFILE NIL])

(CLOSEHASHFILE
  [LAMBDA (HASHFILE REOPEN)                       (* cdl " 8-Mar-84 11:12")
    (COND
      ((SETQ HASHFILE (HASHFILEP (OR HASHFILE SYSHASHFILE)))
	(with HashFile HASHFILE (CLOSEF? File)
	      (COND
		(REOPEN                           (* This flag forces contents 
						  of file to exist on disk if we
						  crash)
			(OPENHASHFILE File REOPEN NIL NIL HASHFILE))
		(T File])

(COLLECTKEYS
  [LAMBDA (HASHFILE DOUBLE MKSTRING?)             (* cdl "24-Aug-83 16:07")
    (DECLARE (SPECVARS MKSTRING?))
    (PROG (KEYLST)
          (DECLARE (SPECVARS KEYLST))
          [COND
	    (DOUBLE (MAPHASHFILE HASHFILE
				 [FUNCTION (LAMBDA (KEY1 KEY2)
				     (push KEYLST (CONS (COND
							  (MKSTRING?
							    (MKSTRING KEY1))
							  (T KEY1))
							(COND
							  (MKSTRING?
							    (MKSTRING KEY2))
							  (T KEY2]
				 T))
	    (T (MAPHASHFILE HASHFILE (FUNCTION (LAMBDA (KEY)
				(push KEYLST (COND
					(MKSTRING? (MKSTRING KEY))
					(T KEY]
          (RETURN KEYLST])

(COPYHASHFILE
  [LAMBDA (HFILE NEWNAME FN VTYPE LEAVEOPEN)      (* cdl " 8-Nov-83 08:19")
    (DECLARE (SPECVARS HFILE FN))                 (* Copy HashFile by mapping 
						  over file hashing items into 
						  new file, very slow but lisp 
						  independent)
    (with HashFile (SETQ HFILE (GTHASHFILE HFILE))
	  (PROG ((NEWHASHFILE (CREATEHASHFILE NEWNAME NIL NIL #Entries)))
	        (DECLARE (SPECVARS NEWHASHFILE))
	        [MAPHASHFILE HFILE (FUNCTION (LAMBDA (KEY)
				 (COPYHASHITEM KEY HFILE NEWHASHFILE FN]
	        (COND
		  ((NOT LEAVEOPEN)
		    (CLOSEHASHFILE NEWHASHFILE)))
	        (RETURN NEWHASHFILE])

(COPYHASHITEM
  [LAMBDA (KEY HASHFILE NEWHASHFILE USERFN)       (* cdl " 8-Sep-83 15:11")
                                                  (* Copy single hash item from 
						  old to new hashfile, applying 
						  userfn if supplied)
    (COND
      (USERFN (LOOKUPHASHFILE KEY (APPLY* USERFN (GETHASHFILE KEY HASHFILE)
					  HASHFILE NEWHASHFILE)
			      NEWHASHFILE
			      'INSERT))
      (T (LOOKUPHASHFILE KEY (GETHASHFILE KEY HASHFILE)
			 NEWHASHFILE
			 'INSERT])

(CREATEHASHFILE
  [LAMBDA (FILE VALUETYPE ITEMLENGTH #ENTRIES SMASH)
                                                  (* cdl " 7-Nov-83 19:43")
    (PROG ([SIZE (FIND1STPRIME (FIX (FTIMES (OR #ENTRIES HASHFILEDEFAULTSIZE)
					    HFGROWTHFACTOR]
	   HASHFILE HFILE)
          [SETQ HFILE (OPENFILE FILE 'BOTH 'NEW 8 '((TYPE BINARY]
          (PRINTPTR HFILE 0)
          (PRINTPTR HFILE SIZE)
          (SETFILEPTR HFILE (ITIMES (IPLUS SIZE HASH.ENTRY.SKIP)
				    HASH.ENTRY.BYTES))
                                                  (* Mark end of KEYS, start of 
						  DATA)
          (BOUT HFILE 0)
          [SETQ HASHFILE (COND
	      ((type? HashFile SMASH)
		SMASH)
	      (T (create HashFile]
          (replace Size of HASHFILE with SIZE)
          (replace #Entries of HASHFILE with 0)
          (CLOSEF HFILE)                          (* Close file and reopen to 
						  ensure existance)
          [SETQ HFILE (OPENFILE FILE 'BOTH 'OLD 8 '((TYPE BINARY]
          (replace File of HASHFILE with HFILE)
          (replace Write? of HASHFILE with T)
          (SETHASHSTATUS HASHFILE)
          (RETURN HASHFILE])

(GETHASHFILE
  [LAMBDA (KEY HASHFILE KEY2)                     (* cdl " 3-Aug-83 15:04")
    (LOOKUPHASHFILE (CREATEKEY KEY KEY2)
		    NIL HASHFILE 'RETRIEVE])

(HASHBEFORECLOSE
  [LAMBDA (FILE)                                  (* cdl "22-Aug-83 09:03")
                                                  (* called before a hashfile is
						  actually closed)
    (PROG ((HASHENTRY (ASSOC FILE SYSHASHFILELST))
	   HASHFILE)
          (COND
	    ((SETQ HASHFILE (CDR HASHENTRY))
	      (AND (EQ HASHFILE SYSHASHFILE)
		   (SETQ SYSHASHFILE))
	      (SETQ SYSHASHFILELST (DREMOVE HASHENTRY SYSHASHFILELST))
                                                  (* Remove from table of open 
						  hash files, and mark this 
						  datum defunct)
	      (replace Valid? of HASHFILE with NIL])

(HASHFILEDATA
  [LAMBDA (HASHFILE)                              (* cdl "22-Aug-83 12:12")
    (with HashFile (GTHASHFILE HASHFILE)
	  (LIST File ValueType ItemLength #Entries])

(HASHFILENAME
  [LAMBDA (HASHFILE)                              (* cdl " 2-Aug-83 10:48")
    (HASHFILEPROP HASHFILE 'NAME])

(HASHFILEP
  [LAMBDA (HASHFILE WRITE)                        (* cdl "23-Aug-83 08:36")
    (AND [OR (type? HashFile HASHFILE)
	     (PROGN                               (* if atom is name of open 
						  file, get the associated 
						  HashFile)
		    (AND HASHFILE (LITATOM HASHFILE)
			 (SETQ HASHFILE (CDR (OR (ASSOC HASHFILE SYSHASHFILELST)
						 (AND (SETQ HASHFILE
							(OPENP HASHFILE))
						      (ASSOC HASHFILE 
							     SYSHASHFILELST]
	 (fetch Valid? of HASHFILE)
	 (OR (NOT WRITE)
	     (fetch Write? of HASHFILE))
	 HASHFILE])

(HASHFILEPROP
  [LAMBDA (HASHFILE PROP)                         (* cdl "15-Aug-83 09:37")
    (with HashFile (GTHASHFILE HASHFILE)
	  (SELECTQ PROP
		   (VALUETYPE ValueType)
		   (ACCESS (GETFILEINFO File 'ACCESS))
		   (NAME File)
		   (PROGN NIL])

(HASHFILESPLST
  [LAMBDA (HASHFILE XWORD)                        (* cdl " 8-Sep-83 15:13")
    (DECLARE (SPECVARS . T))                      (* Just create an Interlisp 
						  generator that returns each 
						  hash key)
    (COND
      ((SETQ HASHFILE (GTHASHFILE HASHFILE))
	(GENERATOR (HASHFILESPLST1 HASHFILE XWORD])

(LOOKUPHASHFILE
  [LAMBDA (KEY VALUE HASHFILE CALLTYPE KEY2)      (* cdl " 9-Mar-84 09:00")
    (PROG ((INDEX (CREATEKEY KEY KEY2))
	   (KEYVAL MAX.INTEGER)
	   RETVAL RETFLG)
          (SETQ HASHFILE (GTHASHFILE HASHFILE (ANYEQ '(REPLACE DELETE INSERT)
						     CALLTYPE)))
          (SETN KEYVAL (GETHASHKEY INDEX HASHFILE (EQMEMB 'INSERT CALLTYPE)
				   KEYVAL))
          (COND
	    ((MINUSP KEYVAL)
	      (COND
		((EQMEMB 'INSERT CALLTYPE)
		  (INSERTHASHKEY (SETN KEYVAL (IMINUS KEYVAL))
				 INDEX VALUE HASHFILE)))
	      (RETURN))
	    (T [COND
		 ((EQMEMB 'RETRIEVE CALLTYPE)
		   (SETQ RETFLG T)
		   (SETQ RETVAL (READ (fetch File of HASHFILE)
				      HASHFILERDTBL]
	       (COND
		 ((EQMEMB 'REPLACE CALLTYPE)
		   (REPLACEHASHKEY KEYVAL INDEX VALUE HASHFILE))
		 ((EQMEMB 'DELETE CALLTYPE)
		   (DELETEHASHKEY KEYVAL HASHFILE)))
	       (RETURN (COND
			 (RETFLG RETVAL)
			 (KEYVAL T])

(MAPHASHFILE
  [LAMBDA (HASHFILE MAPFN DOUBLE)                 (* cdl " 9-Mar-84 09:16")
    (with HashFile (SETQ HASHFILE (GTHASHFILE HASHFILE))
	  (PROG ([BOTH (IGREATERP (OR (NARGS MAPFN)
				      0)
				  (COND
				    (DOUBLE 2)
				    (T 1]
		 INDEX KEY HASHKEY)
	        (for I from (CONSTANT (ITIMES HASH.ENTRY.BYTES HASH.ENTRY.SKIP))
		   to (ITIMES (ADD1 Size)
			      HASH.ENTRY.BYTES)
		   by HASH.ENTRY.BYTES when (PROGN (SETFILEPTR File I)
						   (READSTBYTE Stream USED))
		   do (SETN HASHKEY (READPTR Stream))
		      (SETFILEPTR File HASHKEY)
		      (SETQ KEY (READ File HASHFILERDTBL))
		      (COND
			[DOUBLE                   (* Two key hashing so split up
						  key, userfn takes two key 
						  arguments)
				(SETQ INDEX (SPLITKEY KEY))
				(APPLY* MAPFN (CAR INDEX)
					(CDR INDEX)
					(COND
					  (BOTH (READ File HASHFILERDTBL]
			(T (APPLY* MAPFN KEY (COND
				     (BOTH (READ File HASHFILERDTBL])

(OPENHASHFILE
  [LAMBDA (FILE ACCESS ITEMLENGTH #ENTRIES SMASH)
                                                  (* cdl " 8-Mar-84 11:12")
    (COND
      ([OR ITEMLENGTH #ENTRIES (MEMB ACCESS
				     '(TEXT DOUBLE NUMBER STRING PRINT 
					    FULLPRINT]
                                                  (* This is really a 
						  createhashfile call, the 
						  original hash package used 
						  openhashfile for both)
	(CREATEHASHFILE FILE ACCESS ITEMLENGTH #ENTRIES SMASH))
      (T (PROG (SIZE HASHFILE)
	       (SETQ ACCESS (SELECTQ ACCESS
				     ((READ INPUT OLD NIL RETRIEVE)
				       'INPUT)
				     ((WRITE OUTPUT BOTH T INSERT DELETE 
					     REPLACE)
				       'BOTH)
				     (PROGN NIL)))
	       (SETQ HASHFILE (CDR (ASSOC (OPENP FILE)
					  SYSHASHFILELST)))
	       (COND
		 ([AND HASHFILE (EQUAL ACCESS (GETFILEINFO (fetch File
							      of HASHFILE)
							   'ACCESS]
                                                  (* This is the NO-OP case)
		   (RETURN HASHFILE)))
	       (CLOSEF? FILE)
	       [SETQ FILE (OPENFILE FILE ACCESS 'OLD 8 '((TYPE BINARY]
	       (SETQ #ENTRIES (READPTR FILE))
	       (SETQ SIZE (READPTR FILE))
	       [SETQ HASHFILE (COND
		   ((type? HashFile SMASH)
		     SMASH)
		   (T (create HashFile]
	       (replace Size of HASHFILE with SIZE)
	       (replace #Entries of HASHFILE with #ENTRIES)
	       (replace File of HASHFILE with FILE)
	       (replace Write? of HASHFILE with (EQ ACCESS 'BOTH))
	       (SETHASHSTATUS HASHFILE)
	       (RETURN HASHFILE])

(PUTHASHFILE
  [LAMBDA (KEY VALUE HASHFILE KEY2)               (* cdl "22-Aug-83 09:49")
    [LOOKUPHASHFILE (CREATEKEY KEY KEY2)
		    VALUE HASHFILE (COND
		      (VALUE '(REPLACE INSERT))
		      (T 'DELETE]
    VALUE])

(REHASHFILE
  [LAMBDA (HASHFILE NEWNAME VALUETYPE)            (* cdl " 8-Nov-83 08:24")
    (with HashFile (SETQ HASHFILE (OR (HASHFILEP (OR HASHFILE SYSHASHFILE))
				      (GTHASHFILE HASHFILE)))
	  (PROG [(NAME (NAMEFIELD (OR NEWNAME (HASHFILENAME HASHFILE))
				  T))
		 (ACCESS (HASHFILEPROP HASHFILE 'ACCESS]
	        (COND
		  (REHASHGAG                      (* If rehashgag = T then print
						  out old and new file name)
			     (printout T "Rehashing" , File , "...")))
	        (COPYHASHFILE HASHFILE NAME)
	        (CLOSEHASHFILE HASHFILE)
	        (OPENHASHFILE NAME ACCESS NIL NIL HASHFILE)
	        (COND
		  (REHASHGAG (printout T , File T)))
	        (RETURN HASHFILE])
)

(RPAQQ NEWHASHSYSFNS (DELETEHASHKEY FIND1STPRIME GETHASHKEY GETPROBE GTHASHFILE 
				    HASHFILESPLST1 INSERTHASHKEY MAKEHASHKEY 
				    REPLACEHASHKEY SETHASHSTATUS SPLITKEY))
(DEFINEQ

(DELETEHASHKEY
  [LAMBDA (HASHKEY HASHFILE)                      (* cdl "24-Oct-83 09:27")
    (with HashFile HASHFILE (SETFILEPTR File HASHKEY)
	  (PRINTSTBYTE Stream DELETED)
	  (SETQ #Entries (SUB1 #Entries))
	  (SETFILEPTR File 0)
	  (PRINTPTR Stream #Entries])

(FIND1STPRIME
  [LAMBDA (N)                                     (* cdl "11-Aug-83 08:12")
    (find P from (LOGOR N 1) by 2 suchthat (for I from 3 by 2
					      never (AND (ILESSP I P)
							 (ZEROP (IREMAINDER
								  P I)))
					      repeatuntil (ILESSP P
								  (ITIMES
								    I I])

(GETHASHKEY
  [LAMBDA (INDEX HASHFILE DELOK HASHKEY)          (* cdl " 9-Mar-84 08:57")
    (with HashFile HASHFILE (bind PROBE
			       first (SETN HASHKEY (MAKEHASHKEY INDEX Size))
				     (SETFILEPTR File HASHKEY)
			       until (COND
				       (DELOK (READSTBYTE Stream (FREE DELETED))
					      )
				       (T (READSTBYTE Stream FREE)))
			       do (SETFILEPTR File (READPTR Stream))
				  (COND
				    ((EQUAL INDEX (READ File HASHFILERDTBL))
				      (RETURN HASHKEY)))
				  [COND
				    ((NULL PROBE)
				      (SETQ PROBE (GETPROBE INDEX]
				  (SETN HASHKEY (REHASHKEY HASHKEY PROBE Size))
				  (SETFILEPTR File HASHKEY)
			       finally (RETURN (SETN HASHKEY (IMINUS HASHKEY])

(GETPROBE
  [LAMBDA (KEY)                                   (* lmm "21-OCT-83 23:20")
                                                  (* Get the value to probe by.
						  Probelst contains all the 
						  probe primes.)
    (CAR (FNTH PROBELST (ADD1 (LOGAND 31 (NTHCHARCODE
					KEY
					(ADD1 (LRSH (NCHARS KEY)
						    1])

(GTHASHFILE
  [LAMBDA (HASHFILE WRITE)                        (* cdl "22-Aug-83 08:29")
    (PROG (X)
          (OR HASHFILE (SETQ HASHFILE SYSHASHFILE))

          (* Return hashfile datum for HF, which is a filename or a hashfile 
	  datum. Special cases: if HASHFILE is a filename which is not open, it 
	  is opened; if HASHFILE is an invalidated hashfile datum 
	  (because it was closed), it is reopened; if HASHFILE is already open 
	  for read, but WRITE is set, will attempt to close and then open for 
	  write)


          (RETURN (COND
		    ((HASHFILEP HASHFILE WRITE))
		    ((AND HASHFILE
			  [OR (LITATOM (SETQ X HASHFILE))
			      (AND (type? HashFile HASHFILE)
				   (LITATOM (SETQ X (fetch File of HASHFILE]
			  (OPENHASHFILE X WRITE NIL NIL HASHFILE)))
		    (T (SETQ X)
		       (HELP HASHFILE "NOT A HASHFILE"])

(HASHFILESPLST1
  [LAMBDA (HASHFILE XWORD)                        (* cdl "24-Aug-83 16:04")
    (DECLARE (SPECVARS XWORD))
    (MAPHASHFILE HASHFILE (FUNCTION (LAMBDA (KEY)
		     (COND
		       [XWORD (COND
				((EQ (NTHCHAR KEY 1)
				     XWORD)
				  (PRODUCE KEY]
		       (T (PRODUCE KEY])

(INSERTHASHKEY
  [LAMBDA (HASHKEY INDEX VALUE HASHFILE)          (* cdl "24-Oct-83 09:28")
    (REPLACEHASHKEY HASHKEY INDEX VALUE HASHFILE)
    (with HashFile HASHFILE (SETQ #Entries (ADD1 #Entries))
	  (SETFILEPTR File 0)
	  (PRINTPTR Stream #Entries)
	  (COND
	    ((FGREATERP #Entries (FTIMES Size HASHLOADFACTOR))
	      (REHASHFILE HASHFILE])

(MAKEHASHKEY
  [LAMBDA (KEY RANGE)                             (* cdl " 7-Nov-83 19:46")
    (LLSH (IPLUS (MODTIMES (DCHCON KEY HASHSCRATCHLST)
			   RANGE)
		 HASH.ENTRY.SKIP)
	  2])

(REPLACEHASHKEY
  [LAMBDA (HASHKEY INDEX VALUE HASHFILE)          (* cdl "30-Aug-83 10:00")
    (with HashFile HASHFILE (SETFILEPTR File HASHKEY)
	  (PRINTSTBYTE Stream USED)
	  (PRINTPTR Stream (GETEOFPTR File))
	  (SETFILEPTR File -1)
	  (printout File .P2 INDEX , .P2 VALUE T])

(SETHASHSTATUS
  [LAMBDA (HASHFILE)                              (* cdl "29-Aug-83 14:18")
    (with HashFile HASHFILE                       (* Fix data structures to know
						  about this file so they get 
						  updated when it closes)
	  (WHENCLOSE File 'BEFORE (FUNCTION HASHBEFORECLOSE))
	  (SETQ Valid? T)
	  (SETQ ValueType 'EXPR)
	  [SETQ Stream (GETSTREAM File (GETFILEINFO File 'ACCESS]
	  (SETQ SYSHASHFILELST (CONS (CONS File HASHFILE)
				     SYSHASHFILELST))
	  (SETQ SYSHASHFILE HASHFILE])

(SPLITKEY
  [LAMBDA (KEY)                                   (* cdl " 7-Mar-84 12:03")
    (PROG ((PTR (STRPOSL HASHBITTABLE KEY)))
          (RETURN (COND
		    [PTR (FRPLNODE HASHSCRATCHCONSCELL (SUBATOM KEY 1
								(SUB1 PTR))
				   (SUBATOM KEY (ADD1 PTR]
		    (T (FRPLNODE HASHSCRATCHCONSCELL KEY NIL])
)
(DEFINEQ

(TESTHASH
  [LAMBDA (HASHFILE)                              (* cdl " 9-Mar-84 08:45")
    (PROG ((OLDGC (GCGAG NIL)))
          (printout T "Inserting ..." T)
          (TIME (for I to 1000 do (PUTHASHFILE I (GENSYM)
					       HASHFILE))
		1 3)
          (printout T "Replacing ..." T)
          (TIME (for I to 1000 do (PUTHASHFILE I (GENSYM)
					       HASHFILE))
		1 3)
          (printout T "Retrieving ..." T)
          (TIME (for I to 1000 do (GETHASHFILE I HASHFILE))
		1 3)
          (printout T "Deleting ..." T)
          (TIME (for I to 1000 do (PUTHASHFILE I NIL HASHFILE))
		1 3)
          (GCGAG OLDGC])
)

(RPAQQ NEWHASHMACROS (ANYEQ CREATEKEY GETHASHFILE HASHFILENAME MODTIMES 
			    PRINTPTR PRINTSTBYTE READPTR READSTBYTE REHASHKEY))
(DECLARE: EVAL@COMPILE 

(PUTPROPS ANYEQ MACRO [LAMBDA (X Y)               (* cdl "22-Aug-83 08:39")
			(for Z in X thereis (EQMEMB Z Y])

(PUTPROPS CREATEKEY MACRO [LAMBDA (KEY1 KEY2)
			    (COND
			      ((NULL KEY2)
				KEY1)
			      (T (PACK* KEY1 HASHTEXTCHAR KEY2])

(PUTPROPS GETHASHFILE MACRO [LAMBDA (KEY HASHFILE KEY2)
                                                  (* cdl " 3-Aug-83 15:04")
			      (LOOKUPHASHFILE (CREATEKEY KEY KEY2)
					      NIL HASHFILE 'RETRIEVE])

(PUTPROPS HASHFILENAME MACRO [LAMBDA (HASHFILE)   (* cdl " 2-Aug-83 10:48")
			       (HASHFILEPROP HASHFILE 'NAME])

(PUTPROPS MODTIMES MACRO [LAMBDA (N RANGE)        (* cdl "12-Aug-83 08:54")
			   (for I in N bind (VAL _ 1)
			      do (SETQ VAL (IMOD (ITIMES VAL I)
						 RANGE))
			      finally (RETURN VAL])

(PUTPROPS PRINTPTR MACRO [X
	    (CONS 'PROGN (for I from 2 to 0 by -1
			    collect (LIST 'BOUT (CAR X)
					  (LIST 'LOGAND 255
						(COND
						  ((ZEROP I)
						    (CADR X))
						  (T (LIST 'RSH (CADR X)
							   (ITIMES 8 I])

(PUTPROPS PRINTSTBYTE MACRO [X (LIST 'BOUT (CAR X)
				     (SELECTQ (CADR X)
					      ((U USED)
						(CONSTANT (CHARCODE U)))
					      ((D DELETED)
						(CONSTANT (CHARCODE D)))
					      ((F FREE)
						(CONSTANT (CHARCODE F)))
					      (NILL])

(PUTPROPS READPTR MACRO [X (CONS 'IPLUS
				 (for I from 2 to 0 by -1
				    collect
				     (COND
				       ((ZEROP I)
					 (LIST 'BIN (CAR X)))
				       (T (LIST 'LLSH (LIST 'BIN (CAR X))
						(ITIMES 8 I])

(PUTPROPS READSTBYTE MACRO [X
	    (COND
	      [(ATOM (CADR X))
		(LIST 'EQ (LIST 'BIN (CAR X))
		      (LIST 'CHARCODE (SELECTQ (CADR X)
					       (FREE 'NULL)
					       (USED 'U)
					       (DELETED 'D)
					       NIL]
	      (T (CONS 'SELCHARQ
		       (CONS (LIST 'BIN (CAR X))
			     (APPEND (for Y in (MKLIST (CADR X))
					collect
					 (SELECTQ Y
						  (FREE '(NULL T))
						  (USED '(U T))
						  (DELETED '(D T))
						  NIL))
				     (LIST NIL])

(PUTPROPS REHASHKEY MACRO [LAMBDA (HKEY PROBE RANGE)
                                                  (* cdl "12-Aug-83 09:08")
			    (LLSH (IPLUS (IMOD (IPLUS PROBE (LRSH HKEY 2))
					       RANGE)
					 HASH.ENTRY.SKIP)
				  2])
)
(DECLARE: EVAL@COMPILE 

(RPAQQ HASH.ENTRY.BYTES 4)

(RPAQQ HASH.ENTRY.SKIP 2)

(CONSTANTS HASH.ENTRY.BYTES HASH.ENTRY.SKIP)
)
[DECLARE: EVAL@COMPILE 

(ARRAYRECORD HashFile (File Stream Size #Entries ValueType ItemLength Valid? 
			    Write?))
]

(RPAQQ PROBELST (1 3 5 7 11 11 13 17 17 19 23 23 29 29 29 31 37 37 37 41 41 43 
		   47 47 53 53 53 59 59 59 61 67))

(RPAQ? SYSHASHFILE NIL)

(RPAQ? SYSHASHFILELST NIL)

(RPAQ? REHASHGAG NIL)

(RPAQ? HASHLOADFACTOR .875)

(RPAQ? HASHFILEDEFAULTSIZE 512)

(RPAQ? HFGROWTHFACTOR 2)

(RPAQ? HASHSCRATCHLST (CONSTANT (for I to 30 collect NIL)))

(RPAQ? HASHFILERDTBL (COPYREADTABLE 'ORIG))

(RPAQ? HASHTEXTCHAR (CHARACTER (CHARCODE ^A)))

(RPAQ? HASHBITTABLE (MAKEBITTABLE (LIST HASHTEXTCHAR)))

(RPAQ? HASHSCRATCHCONSCELL (CONS))

(ADDTOVAR AFTERSYSOUTFORMS (CLEARHASHFILES))

(RPAQQ NEWHASHGLOBALS (HASHBITTABLE HASHFILEARRAYSIZE HASHFILEDEFAULTSIZE 
				    HASHLOADFACTOR HASHSCRATCHLST HASHTEXTCHAR 
				    HFGROWTHFACTOR PROBELST SYSHASHFILE 
				    SYSHASHFILELST))
(DECLARE: DOEVAL@COMPILE DONTCOPY

(ADDTOVAR GLOBALVARS HASHBITTABLE HASHFILEARRAYSIZE HASHFILEDEFAULTSIZE 
	  HASHLOADFACTOR HASHSCRATCHLST HASHTEXTCHAR HFGROWTHFACTOR PROBELST 
	  SYSHASHFILE SYSHASHFILELST)
)
(DECLARE: DOEVAL@COMPILE DONTCOPY

(SPECVARS REHASHGAG HASHFILERDTBL)
)

(RPAQQ NEWHASHBLOCKS ((HASHFILEBLOCK (SPECVARS REHASHGAG HASHFILERDTBL)
				     (GLOBALVARS * NEWHASHGLOBALS)
				     (ENTRIES * NEWHASHFNS)
				     CLEARHASHFILES CLOSEHASHFILE COLLECTKEYS 
				     COPYHASHFILE COPYHASHITEM CREATEHASHFILE 
				     DELETEHASHKEY FIND1STPRIME GETHASHFILE 
				     GETHASHKEY GETPROBE GTHASHFILE 
				     HASHBEFORECLOSE HASHFILEDATA HASHFILENAME 
				     HASHFILEP HASHFILEPROP HASHFILESPLST 
				     HASHFILESPLST1 INSERTHASHKEY 
				     LOOKUPHASHFILE MAKEHASHKEY MAPHASHFILE 
				     OPENHASHFILE PUTHASHFILE REHASHFILE 
				     REPLACEHASHKEY SETHASHSTATUS SPLITKEY)))
[DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY
(BLOCK: HASHFILEBLOCK (SPECVARS REHASHGAG HASHFILERDTBL)
	(GLOBALVARS * NEWHASHGLOBALS)
	(ENTRIES * NEWHASHFNS)
	CLEARHASHFILES CLOSEHASHFILE COLLECTKEYS COPYHASHFILE COPYHASHITEM 
	CREATEHASHFILE DELETEHASHKEY FIND1STPRIME GETHASHFILE GETHASHKEY 
	GETPROBE GTHASHFILE HASHBEFORECLOSE HASHFILEDATA HASHFILENAME HASHFILEP 
	HASHFILEPROP HASHFILESPLST HASHFILESPLST1 INSERTHASHKEY LOOKUPHASHFILE 
	MAKEHASHKEY MAPHASHFILE OPENHASHFILE PUTHASHFILE REHASHFILE 
	REPLACEHASHKEY SETHASHSTATUS SPLITKEY)
]
(SELECTQ (SYSTEMTYPE)
	 ((TENEX TOPS20)
	  (LOAD? '<LISPUSERS>DFOR10.COM 'SYSLOAD))
	 NIL)
(DECLARE: DONTCOPY
  (FILEMAP (NIL (1426 13074 (CLEARHASHFILES 1438 . 2341) (CLOSEHASHFILE 2345 . 
2781) (COLLECTKEYS 2785 . 3442) (COPYHASHFILE 3446 . 4141) (COPYHASHITEM 4145 . 
4671) (CREATEHASHFILE 4675 . 5918) (GETHASHFILE 5922 . 6097) (HASHBEFORECLOSE 
6101 . 6783) (HASHFILEDATA 6787 . 6982) (HASHFILENAME 6986 . 7124) (HASHFILEP 
7128 . 7733) (HASHFILEPROP 7737 . 8010) (HASHFILESPLST 8014 . 8377) (
LOOKUPHASHFILE 8381 . 9356) (MAPHASHFILE 9360 . 10382) (OPENHASHFILE 10386 . 
12059) (PUTHASHFILE 12063 . 12307) (REHASHFILE 12311 . 13071)) (13264 18041 (
DELETEHASHKEY 13276 . 13559) (FIND1STPRIME 13563 . 13914) (GETHASHKEY 13918 . 
14676) (GETPROBE 14680 . 15038) (GTHASHFILE 15042 . 15952) (HASHFILESPLST1 15956
 . 16276) (INSERTHASHKEY 16280 . 16656) (MAKEHASHKEY 16660 . 16856) (
REPLACEHASHKEY 16860 . 17162) (SETHASHSTATUS 17166 . 17709) (SPLITKEY 17713 . 
18038)) (18043 18783 (TESTHASH 18055 . 18780)))))
STOP

(FILECREATED "18-Apr-83 13:51:35" <LISPUSERS>SYSALL.LSP.21117 1735   

      changes to:  (VARS SYSALLCOMS)

      previous date: "16-NOV-82 12:35:13" <LISPUSERS>SYSALL.LSP.21116
)


(PRETTYCOMPRINT SYSALLCOMS)

(RPAQQ SYSALLCOMS ((FILES (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES)
			  CJSYS)
		   (FNS CHECKSYSOUT PRINTSYSOUTS SYSALL)
		   (VARS (FILELINELENGTH 132))))
(FILESLOAD (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES)
	   CJSYS)
(DEFINEQ

(CHECKSYSOUT
  (LAMBDA (JFN)                                 (* lmm "16-NOV-82 12:14"
)
    (PROG (INFO)
          (COND
	    ((NOT (NLSETQ (SETQ INFO (SYSOUTP JFN))))
                                                (* error)
	      (push SYSOUTS (LIST 0 (JFNS JFN))))
	    (INFO                               (* sysout)
		  (push SYSOUTS (LIST (CADR INFO)
				      (JFNS JFN)
				      (CAR INFO))))))))

(PRINTSYSOUTS
  (LAMBDA (SYSOUTS LOGFILE)                     (* lmm "16-NOV-82 12:23"
)
    (bind (LASTDATE _ -1) for INFO in (SORT SYSOUTS T)
       do (printout LOGFILE (COND
		      ((EQUAL (CAR INFO)
			      LASTDATE)
			"")
		      (T (SETQ LASTDATE (CAR INFO))
			 (COND
			   ((NEQ LASTDATE 0)
			     (GDATE LASTDATE)))))
		    20
		    (CADR INFO)
		    56
		    (OR (CADDR INFO)
			"makesys")
		    T))))

(SYSALL
  (LAMBDA (SUBTREE LOGFILE)                     (* lmm "16-NOV-82 12:35"
)
    (PROG (SYSOUTS)
          (DIRECTORY SUBTREE '(@ CHECKSYSOUT))
          (SETQ LOGFILE (OPENFILE (OR LOGFILE 'SYSOUT.OWNERS)
				  'OUTPUT))
          (PRINTSYSOUTS SYSOUTS LOGFILE)
          (RETURN (CLOSEF LOGFILE)))))
)

(RPAQQ FILELINELENGTH 132)
(PUTPROPS SYSALL.LSP COPYRIGHT (NONE))
(DECLARE: DONTCOPY
  (FILEMAP (NIL (454 1641 (CHECKSYSOUT 466 . 882) (PRINTSYSOUTS 886 . 1319
) (SYSALL 1323 . 1638)))))
STOP
  
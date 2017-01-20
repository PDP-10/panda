(FILECREATED " 5-Aug-83 14:23:38" <SCHMIDT>AUTOUPDATE.LSP.2 13347  

      changes to:  (VARS AUTOUPDATECOMS)

      previous date: " 5-Aug-83 09:14:22" <SCHMIDT>AUTOUPDATE.LSP.1)


(PRETTYCOMPRINT AUTOUPDATECOMS)

(RPAQQ AUTOUPDATECOMS ((FNS ANALYZE.DATED.FILE ANALYZE.PACKAGE 
			    ANALYZE.UNDATED.FILE AUTOUPDATE 
			    DECIDE.PACKAGE.FATE DELETE.FILE 
			    DISPLAY.PACKAGE EXTRACT.NAMES 
			    GETFILECREATED MAKE-CMD-FILE 
			    MAKE-GENERATION-NUMBER MAKE-ROSTER 
			    PRINTFILECREATED READ-ROSTER RETRIEVE.FILE)
	(VARS DAY10S-SCRATCH DAY1S-SCRATCH MONTH-SCRATCH SHORT-DATE 
	      YEAR-SCRATCH)
	(RECORDS DATEDFILE PACKAGE UNDATEDFILE)
	(ADDVARS (FUNNYATOMLST MAKE-CMD-FILE MAKE-GENERATION-NUMBER 
			       MAKE-ROSTER READ-ROSTER DAY10S-SCRATCH 
			       DAY1S-SCRATCH MONTH-SCRATCH SHORT-DATE 
			       YEAR-SCRATCH))))
(DEFINEQ

(ANALYZE.DATED.FILE
  (LAMBDA (FILE)                                (* cvs "26-Jul-83 12:04"
)
    (PROG (THEIR.DATE (MY.DATE (GETFILECREATED (fetch (DATEDFILE NAME)
						  of FILE))))
          (COND
	    (MY.DATE (SETQ MY.DATE (IDATE MY.DATE))
		     (SETQ THEIR.DATE (fetch IDATE of FILE))
		     (COND
		       ((IEQP THEIR.DATE MY.DATE)
			 (push THEIR.OLD.FILES FILE)
			 (push OUR.OLD.FILES FILE))
		       ((IGREATERP THEIR.DATE MY.DATE)
			 (push THEIR.NEWER.FILES FILE)
			 (push OUR.OBSOLETE.FILES FILE))
		       (T (push THEIR.OBSOLETE.FILES FILE)
			  (push OUR.NEWER.FILES FILE))))
	    (T (push THEIR.UNIQUE.FILES FILE))))))

(ANALYZE.PACKAGE
  (LAMBDA (PACKAGE)                             (* cvs " 4-Aug-83 12:05"
)
    (PROG (THEIR.UNIQUE.FILES THEIR.NEWER.FILES THEIR.OLD.FILES 
			      THEIR.OBSOLETE.FILES OUR.UNIQUE.FILES 
			      OUR.NEWER.FILES OUR.OLD.FILES 
			      OUR.OBSOLETE.FILES)
          (for FILE in (fetch DATEDFILES of PACKAGE)
	     do (ANALYZE.DATED.FILE FILE))
          (for FILE in (fetch UNDATEDFILES of PACKAGE)
	     do (ANALYZE.UNDATED.FILE FILE))
          (SETQ PACKAGE.FATE (DECIDE.PACKAGE.FATE))
          (printout T T "*** Package " (fetch (PACKAGE NAME)
					  of PACKAGE))
          (SELECTQ PACKAGE.FATE
		   (RETRIEVE (printout T " will be retrieved" T)
			     (for FILE
				in (APPEND THEIR.UNIQUE.FILES 
					   THEIR.NEWER.FILES)
				do (RETRIEVE.FILE FILE)
				   (COND
				     (DELETE.DUPLICATES.FLAG
				       (DELETE.FILE FILE))))
			     (COND
			       (DELETE.DUPLICATES.FLAG
				 (for FILE
				    in (APPEND THEIR.OLD.FILES 
					       THEIR.OBSOLETE.FILES)
				    do (DELETE.FILE FILE)))))
		   (DELETE (printout T " will be deleted" T)
			   (for FILE in (APPEND THEIR.UNIQUE.FILES 
						THEIR.NEWER.FILES 
						THEIR.OLD.FILES 
					       THEIR.OBSOLETE.FILES)
			      do (DELETE.FILE FILE)))
		   (IGNORE (printout T " will be ignored" T))
		   (SHOULDNT)))))

(ANALYZE.UNDATED.FILE
  (LAMBDA (FILE)                                (* cvs "26-Jul-83 15:12"
)
    (PROG (THEIR.LENGTH MY.LENGTH (FILE.NAME (fetch (UNDATEDFILE NAME)
						of FILE)))
          (SETQ MY.LENGTH (AND (INFILEP FILE.NAME)
			       (GETFILEINFO FILE.NAME 'LENGTH)))
          (COND
	    (MY.LENGTH (SETQ THEIR.LENGTH (fetch LENGTH of FILE))
		       (COND
			 ((IEQP THEIR.LENGTH MY.LENGTH)
			   (push THEIR.OLD.FILES FILE)
			   (push OUR.OLD.FILES FILE))
			 ((OR (IGREATERP THEIR.LENGTH MY.LENGTH)
			      (AND THEIR.NEWER.FILES
				   (NULL OUR.NEWER.FILES)
				   (printout T "Assuming " FILE.NAME 
" is newer even though it is shorter because they have newer dated files."
					     T)))
			   (push THEIR.NEWER.FILES FILE)
			   (push OUR.OBSOLETE.FILES FILE))
			 (T (push THEIR.OBSOLETE.FILES FILE)
			    (push OUR.NEWER.FILES FILE))))
	    (T (push THEIR.UNIQUE.FILES FILE))))))

(AUTOUPDATE
  (LAMBDA NIL                                   (* cvs " 4-Aug-83 15:04"
)
    (PROG ((RESPONSE NIL)
	   (RETRIEVE.PREFIX NIL)
	   DELETE.DUPLICATES.FLAG
	   (DELETE.PREFIX NIL))
          (until (MEMBER RESPONSE '(1 2 3 4))
	     do (printout T T "Do you want to" T 
	"  1. Make a 'roster file' (i.e. You are a 'source' site),"
			  T 
   "  2. Read a 'roster file' (i.e. You are a site being updated),"
			  T 
"  3. Make a CMD file from an already read roster (for DO or TAKE), or"
			  T "  4. Stop." T "Enter 1, 2, 3, or 4: ")
		(SETQ RESPONSE (READ)))
          (COND
	    ((EQ 1 RESPONSE)
	      (until (ERRORSET '(OUTFILEP RESPONSE)
			       'NOBREAK)
		 do (printout T T 
		  "Name (including directory) for 'roster file' ? ")
		    (SETQ RESPONSE (READ)))
	      (MAKE-ROSTER RESPONSE))
	    ((EQ 2 RESPONSE)
	      (until (ERRORSET '(INFILEP RESPONSE)
			       'NOBREAK)
		 do (printout T T 
		   "Name (including directory) of 'roster file' ? ")
		    (SETQ RESPONSE (READ)))
	      (SETQ ROSTER (READ-ROSTER RESPONSE)))
	    ((EQ 3 RESPONSE)
	      (until (ERRORSET '(OUTFILEP RESPONSE)
			       'NOBREAK)
		 do (printout T T 
		       "Name (including directory) for CMD file ? ")
		    (SETQ RESPONSE (READ)))
	      (until (STRINGP RETRIEVE.PREFIX)
		 do (printout T T 
		  "Prefix string (something like %"GET <XEOS>%")? ")
		    (SETQ RETRIEVE.PREFIX (READ)))
	      (SETQ IGNORE.NOVEL.PACKAGES
		(EQ 'Y (ASKUSER NIL NIL 
			       "Should novel packages be ignored? ")))
	      (printout T T "Should duplicates be deleted? ")
	      (COND
		((SETQ DELETE.DUPLICATES.FLAG (EQ 'Y (ASKUSER)))
		  (until (STRINGP DELETE.PREFIX)
		     do (printout T T 
      "Delete prefix (something like %"DELETE <DOLPHIN.FUGUE>%")? ")
			(SETQ DELETE.PREFIX (READ)))))
	      (MAKE-CMD-FILE RESPONSE))))))

(DECIDE.PACKAGE.FATE
  (LAMBDA NIL                                   (* cvs " 4-Aug-83 16:09"
)
    (COND
      (THEIR.NEWER.FILES 'RETRIEVE)
      ((AND (SETQ OUR.UNIQUE.FILES (DIRECTORY
		(PACK* (fetch (PACKAGE NAME) of PACKAGE)
		       ".*")
		'(COLLECT)))
	    NIL)
	(SHOULDNT))
      ((AND (NOT (OR OUR.UNIQUE.FILES OUR.NEWER.FILES OUR.OLD.FILES 
		     OUR.OBSOLETE.FILES))
	    IGNORE.NOVEL.PACKAGES)
	'IGNORE)
      ((AND THEIR.UNIQUE.FILES (OR OUR.OLD.FILES OUR.NEWER.FILES 
				   OUR.UNIQUE.FILES))
	'RETRIEVE)
      (THEIR.UNIQUE.FILES (printout T T "The situation is this:" T)
			  (DISPLAY.PACKAGE)
			  (ASKUSER NIL NIL 
			     "What should I do with this package? "
				   (COND
				     (DELETE.DUPLICATES.FLAG
				       '(RETRIEVE DELETE IGNORE))
				     (T '(RETRIEVE IGNORE)))))
      (T (COND
	   (DELETE.DUPLICATES.FLAG 'DELETE)
	   (T 'IGNORE))))))

(DELETE.FILE
  (LAMBDA (FILE)                                (* cvs "28-Jul-83 16:47"
)
    (COND
      ((type? DATEDFILE FILE)
	(printout COMMANDFILE DELETE.PREFIX (fetch (DATEDFILE NAME)
					       of FILE)
		  T))
      (T (printout COMMANDFILE DELETE.PREFIX (fetch (UNDATEDFILE NAME)
						of FILE)
		   T)))))

(DISPLAY.PACKAGE
  (LAMBDA NIL                                   (* cvs "28-Jul-83 14:22"
)
    (printout T T "==  Package " (fetch (PACKAGE NAME) of PACKAGE)
	      ,, "=================================" T 
	      "Their Unique Files:"
	      ,,
	      (EXTRACT.NAMES THEIR.UNIQUE.FILES)
	      T "Their Newer Files:" ,, (EXTRACT.NAMES 
						  THEIR.NEWER.FILES)
	      T "Their Old Files:" ,, (EXTRACT.NAMES THEIR.OLD.FILES)
	      T "Their Obsolete Files:" ,, (EXTRACT.NAMES 
					       THEIR.OBSOLETE.FILES)
	      T "--------------------------------------" T 
	      "Our Unique Files:"
	      ,, OUR.UNIQUE.FILES T "Our Newer Files:" ,,
	      (EXTRACT.NAMES OUR.NEWER.FILES)
	      T "Our Old Files:" ,, (EXTRACT.NAMES OUR.OLD.FILES)
	      T "Our Obsolete Files:" ,, (EXTRACT.NAMES 
						 OUR.OBSOLETE.FILES)
	      T)))

(EXTRACT.NAMES
  (LAMBDA (L)                                   (* cvs "26-Jul-83 15:03"
)
    (for X in L collect (COND
			  ((type? DATEDFILE X)
			    (fetch (DATEDFILE NAME) of X))
			  (T (fetch (UNDATEDFILE NAME) of X))))))

(GETFILECREATED
  (LAMBDA (NAME TEMP)                           (* cvs "17-Feb-83 09:05"
)
    (SETQ TEMP
      (ERRORSET '(AND (INFILEP NAME)
		      (SETQ BYTESIZE (GETFILEINFO NAME 'BYTESIZE))
		      (COND
			((EQUAL 36 BYTESIZE)
			  (SETQ BYTESIZE 7))
			(T T))
		      (SETQ NAME (OPENFILE NAME 'INPUT NIL BYTESIZE
					   '(DON%'T.CHANGE.DATE)))
		      (OR (EQUAL '%( (SETQ FIRSTCHAR (READC NAME)))
			  (AND (EQUAL (CHCON1 FIRSTCHAR)
				      6)
			       (READC NAME)
			       (EQUAL '%( (READC NAME))))
		      (EQUAL 'FILECREATED (READ NAME))
		      (SETQ DATE (READ NAME))
		      (CLOSEF NAME)
		      DATE)
		'NOBREAK))
    (CLOSEF? NAME)
    (CAR TEMP)))

(MAKE-CMD-FILE
  (LAMBDA (NAME)                                (* cvs "26-Jul-83 15:15"
)
    (COND
      ((EQUAL T NAME)
	(SETQ NAME NIL)))
    (SETQ COMMANDFILE (COND
	(NAME (OPENFILE NAME 'OUTPUT))
	(T T)))
    (MAPCAR ROSTER 'ANALYZE.PACKAGE)
    (AND NAME (CLOSEF COMMANDFILE))))

(MAKE-GENERATION-NUMBER
  (LAMBDA (IDATE)                               (* cvs " 4-Apr-83 15:51"
)
    (SETQ SHORT-DATE (GDATE IDATE 4362076160 SHORT-DATE))
    (CONCAT (SUBSTRING SHORT-DATE 8 8 YEAR-SCRATCH)
	    (SUBSTRING SHORT-DATE 4 5 MONTH-SCRATCH)
	    (COND
	      ((EQUAL " " (SUBSTRING SHORT-DATE 1 1 DAY1S-SCRATCH))
		"0")
	      (T DAY1S-SCRATCH))
	    (SUBSTRING SHORT-DATE 2 2 DAY10S-SCRATCH))))

(MAKE-ROSTER
  (LAMBDA (LOGFILENAME)                         (* cvs " 4-Aug-83 16:49"
)
    (AND (EQUAL T LOGFILENAME)
	 (SETQ LOGFILENAME NIL))
    (SETQ LOGFILE (COND
	(LOGFILENAME (OPENFILE LOGFILENAME 'OUTPUT))
	(T T)))
    (SETQ MILESTONE (IPLUS (IDATE)
			   50))
    (DIRECTORY NIL '(@ PRINTFILECREATED))
    (PRINT 'STOP LOGFILE)
    (AND LOGFILENAME (CLOSEF LOGFILE))))

(PRINTFILECREATED
  (LAMBDA (JFN NAME)                            (* cvs " 4-Aug-83 16:53"
)
    (PROG ((CHRISTIAN (FILENAMEFIELD NAME 'NAME)))
          (COND
	    ((IGREATERP (IDATE)
			MILESTONE)
	      (SETQ MILESTONE (IPLUS (IDATE)
				     50))
	      (printout T "[" CHRISTIAN "] ")))
          (printout LOGFILE CHRISTIAN -1 (FILENAMEFIELD NAME
							'NAME)
		    "."
		    (OR (FILENAMEFIELD NAME 'EXTENSION)
			"")
		    -1 "(" (FILENAMEFIELD NAME 'VERSION)
		    ")" 35)
          (COND
	    ((SETQ DATE (GETFILECREATED NAME))
	      (SETQ IDATE (IDATE DATE))
	      (printout LOGFILE (MAKE-GENERATION-NUMBER IDATE)
			-1 .P2 DATE -1 IDATE T))
	    (T (printout LOGFILE "NIL length" -1 (GETFILEINFO
			   NAME
			   'LENGTH)
			 T))))))

(READ-ROSTER
  (LAMBDA (ROSTER-FILE)                         (* cvs " 5-Aug-83 09:12"
)
    (SETQ FP (OPENFILE ROSTER-FILE 'INPUT))
    (PROG (PACKAGE PACKAGENAME NAME VERSION DATECODE DATE LENGTH FILE1 
		   FILE2 (ROSTER NIL))
      LABEL
          (SETQ PACKAGENAME (READ FP))
          (COND
	    ((EQUAL 'STOP PACKAGENAME)
	      (PROGN (CLOSEF FP)
		     (RETURN ROSTER))))
          (COND
	    ((NOT (SETQ PACKAGE (FASSOC PACKAGENAME ROSTER)))
	      (push ROSTER (SETQ PACKAGE (create PACKAGE
						 NAME _ PACKAGENAME)))))
          (SETQ NAME (READ FP))
          (SETQ VERSION (READ FP))
          (SETQ DATECODE (READ FP))
          (READ FP)                             (* Throw away text date 
						or "length")
          (COND
	    (DATECODE (SETQ FILE1 (create DATEDFILE
					  NAME _ NAME
					  IDATE _(READ FP)
					  DATECODE _ DATECODE))
		      (SETQ FLIST (fetch DATEDFILES of PACKAGE))
		      (COND
			((SETQ FILE2
			    (SOME FLIST
				  (FUNCTION (LAMBDA (X)
				      (EQ NAME (fetch (DATEDFILE NAME)
						  of X))))))
			  (COND
			    ((IGEQ (fetch IDATE of FILE1)
				   (fetch IDATE of (CAR FILE2)))
			      (RPLACA FILE2 FILE1))))
			(T (push (fetch DATEDFILES of PACKAGE)
				 FILE1))))
	    (T (SETQ FILE1 (create UNDATEDFILE
				   NAME _ NAME
				   VERSION _(CAR VERSION)
				   LENGTH _(READ FP)))
	       (SETQ FLIST (fetch UNDATEDFILES of PACKAGE))
	       (COND
		 ((SETQ FILE2
		     (SOME FLIST (FUNCTION (LAMBDA (X)
			       (EQ NAME (fetch (UNDATEDFILE NAME)
					   of X))))))
		   (COND
		     ((IGEQ (CAR VERSION)
			    (fetch VERSION of (CAR FILE2)))
		       (RPLACA FILE2 FILE1))))
		 (T (push (fetch UNDATEDFILES of PACKAGE)
			  FILE1)))))
          (GO LABEL))))

(RETRIEVE.FILE
  (LAMBDA (FILE)                                (* cvs "28-Jul-83 16:40"
)
    (COND
      ((type? DATEDFILE FILE)
	(printout COMMANDFILE RETRIEVE.PREFIX (fetch (DATEDFILE NAME)
						 of FILE)
		  ,
		  (fetch (DATEDFILE NAME) of FILE)
		  "."
		  (fetch DATECODE of FILE)
		  T))
      (T (printout COMMANDFILE RETRIEVE.PREFIX
		   (fetch (UNDATEDFILE NAME) of FILE)
		   T)))))
)

(RPAQQ DAY10S-SCRATCH "6")

(RPAQQ DAY1S-SCRATCH "1")

(RPAQQ MONTH-SCRATCH "11")

(RPAQQ SHORT-DATE "16-11-82")

(RPAQQ YEAR-SCRATCH "2")
[DECLARE: EVAL@COMPILE 

(TYPERECORD DATEDFILE (NAME IDATE . DATECODE))

(RECORD PACKAGE (NAME DATEDFILES . UNDATEDFILES))

(RECORD UNDATEDFILE (NAME VERSION . LENGTH))
]

(ADDTOVAR FUNNYATOMLST MAKE-CMD-FILE MAKE-GENERATION-NUMBER MAKE-ROSTER 
				     READ-ROSTER DAY10S-SCRATCH 
				     DAY1S-SCRATCH MONTH-SCRATCH 
				     SHORT-DATE YEAR-SCRATCH)
(DECLARE: DONTCOPY
  (FILEMAP (NIL (864 12806 (ANALYZE.DATED.FILE 876 . 1534) (
ANALYZE.PACKAGE 1538 . 2876) (ANALYZE.UNDATED.FILE 2880 . 3808) (
AUTOUPDATE 3812 . 5686) (DECIDE.PACKAGE.FATE 5690 . 6593) (DELETE.FILE 
6597 . 6922) (DISPLAY.PACKAGE 6926 . 7777) (EXTRACT.NAMES 7781 . 8015) (
GETFILECREATED 8019 . 8716) (MAKE-CMD-FILE 8720 . 9014) (
MAKE-GENERATION-NUMBER 9018 . 9437) (MAKE-ROSTER 9441 . 9831) (
PRINTFILECREATED 9835 . 10608) (READ-ROSTER 10612 . 12390) (
RETRIEVE.FILE 12394 . 12803)))))
STOP

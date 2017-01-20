;;;  STRING    				-*-Mode:Lisp;Package:SI;Lowercase:T-*-
;;;  *************************************************************************
;;;  *** NIL ***** Functions for STRINGs and CHARACTERs **********************
;;;  *************************************************************************
;;;  ** (c) Copyright 1981 Massachusetts Institute of Technology *************
;;;  *************************************************************************

;;; Provides support for NIL string operations under maclisp, with
;;;   most LISPM STRING functions added for compatibility.
;;; To read this file in on LISPM, do (PACKAGE-DECLARE * SYSTEM 100)

(herald STRING /177)

(eval-when (eval compile)
  (or (get 'SUBLOAD 'VERSION)
      (load '((lisp) subload)))
  (subload SHARPCONDITIONALS)
  )


;;; CHARACTER support:
;;; m	CHARACTERP, *:CHARACTER-TO-FIXNUM, *:FIXNUM-TO-CHARACTER
;;; m 	TO-CHARACTER, TO-CHARACTER-N, 
;;;     DIGITP, DIGIT-WEIGHT 
;;; +m	CHARACTER, 
;;; +*  CHAR-EQUAL, CHAR-LESSP,
;;; &	|+internal-tilde-macro/||  (can be set onto ~ as readmacro)
;;; &   USERATOMS-HOOK->CHARACTER-CLASS  FLATSIZE->CHARACTER-CLASS 
;;; STRING support:
;;; m   STRINGP, CHAR, RPLACHAR
;;; m   STRING-LENGTH, STRING-SEARCHQ, STRING-BSEARCHQ
;;; 	SET-STRING-LENGTH, STRING-REMQ 
;;; 	MAKE-STRING, STRING-SUBSEQ, STRING-MISMATCHQ, STRING-HASH
;;; *	CHAR-N, RPLACHAR-N, STRING-FILL, STRING-FILL-N, STRING-REPLACE
;;; * 	STRING-POSQ, STRING-BPOSQ, STRING-POSQ-N, STRING-BPOSQ-N
;;; * 	STRING-SKIPQ, STRING-BSKIPQ, STRING-SKIPQ-N, STRING-BSKIPQ-N
;;; +m 	STRING-EQUAL, STRING-LESSP, STRING-SEARCH, STRING-REVERSE-SEARCH
;;; +m 	STRING-DOWNCASE, STRING-UPCASE
;;; +	GET-PNAME, SUBSTRING, STRING-APPEND, STRING-REVERSE, STRING-NREVERSE
;;; +   STRING-TRIM, STRING-LEFT-TRIM, STRING-RIGHT-TRIM
;;; +*  CHAR-DOWNCASE, CHAR-UPCASE,
;;; +*  STRING-SEARCH-CHAR, STRING-SEARCH-NOT-CHAR, 
;;; +*  STRING-SEARCH-SET, STRING-SEARCH-NOT-SET
;;; +*  STRING-REVERSE-SEARCH-CHAR, STRING-REVERSE-SEARCH-NOT-CHAR, 
;;; +*  STRING-REVERSE-SEARCH-SET, STRING-REVERSE-SEARCH-NOT-SET
;;; &	STRING-PNGET,  STRING-PNPUT,  |+internal-doublequote-macro/||  
;;; & 	USERATOMS-HOOK->STRING-CLASS 	EQUAL->STRING-CLASS  
;;; &   FLATSIZE->STRING-CLASS 		PURCOPY->STRING-CLASS  
;;; & 	NAMESTRING->STRING-CLASS 	SXHASH->STRING-CLASS 
;;; &   EXPLODE->STRING-CLASS 		SAMEPNAMEP->STRING-CLASS
;;; &   ALPHALESSP->STRING-CLASS	LESSP->STRING-CLASS
;;; &   GREATERP->STRING-CLASS
;;; &*  +INTERNAL-CHAR-N,  +INTERNAL-RPLACHAR-N,  +INTERNAL-STRING-WORD-N 
;;; &* 	STR/:CLEAR-WORDS,  STR/:COMPARE-WORDS,  STR/:GRAB-PURSEG, 

;;;   (a "m" is for lines whose routines are implemnted as both macros and
;;; 	subrs - macro definition is active only in the compiler)

;;;   (a + is for lines whose routines are directly LISPM compatible - 
;;; 	many other such routines can be written using the NIL primitives)

;;;   (an * is for lines whose routines have been written in MIDAS - 
;;; 	primarily for speed - and are in the file STRAUX >)

;;;   (a & is for lines whose routines are PDP10-specific, and are 
;;; 	 primarily for internal support)

;;;   (the functions named "...-N" use ascii numerical values for their 
;;; 	arguments which are interpreted as "CHARACTER"s, instead of the
;;; 	new datatype "CHARACTER"  - thus while STRING-POSQ scans for a 
;;; 	particular character in a string, STRING-POSQ-N wants its character
;;; 	as a fixnum.)

;				  ---------
;A  "STRING" is a 4-hunk, with    | 1 | 0 | 
;  indices as indicated in the	  ---------
;  diagram.			  | 3 | 2 |
;				  ---------
;  (cxr 0 s) 	;ptr to class object for STRINGs
;  (cxr 1 s) 	;"**SELF-EVAL**" 
;  (cxr 2 s) 	;word-index in STR:ARRAY of first word of packed ascii
;  (cxr 3 s) 	;length of string, in characters



;;;; Out-of-core loading, and DECLAREs

#+(or LISPM (and NIL (not MacLISP)))
(progn (globalize "STRINGP")
	;; well, hundreds more! (globalize )
       )


#+(local MacLISP)
(declare (own-symbol MAKE-STRING  STRINGP  *:FIXNUM-TO-CHARACTER 
		     |+internal-doublequote-macro/||  STRING-PNPUT))

#-NIL 
(eval-when (eval compile)
    ;; SUBSEQ also downloads EXTEND
   (subload SUBSEQ)
   (subload EXTMAC)
   (subload EXTBAS)
   (subload SETF)
   (subload DEFSETF)
   (subload EVONCE)
   (subload LOOP)
   #M (cond ((status feature COMPLR)
	     (*lexpr NIL-INTERN SYMBOLCONC TO-STRING)
	     (*expr STRINGP *:FIXNUM-TO-CHARACTER )
     #+PDP10 (*expr STRING-PNGET STRING-PNPUT)
	     (setq STRT7 'T)))
   (setq-if-unbound *:bits-per-character #Q 8 #-Lispm 7)
   (setq-if-unbound *:bytes-per-word #+Multics 4 #M 5 #Q 4)
)



#-NIL 
(eval-when (eval load compile)
    (let ((n (get 'ERRCK 'VERSION)))
      (cond ((null n))
	    ((alphalessp n "29")
	      (remprop 'ERRCK 'VERSION)
	      (let (FASLOAD) #%(subload ERRCK)))))
     ;; Need CLASS-OF, SEND etc, for things to work
    (subload EXTEND)
     ;; Following is basically a bunch of DEF-OR-AUTOLOADABLE's
    (or (get 'SUBSEQ 'VERSION)
	(mapc #'(lambda (x) 
		   (or (getl x '(SUBR LSUBR AUTOLOAD))
		       (putprop x #%(autoload-filename SUBSEQ) 'AUTOLOAD)))
	      '(TO-CHARACTER  TO-CHARACTER-N? TO-STRING  TO-UPCASE 
		TO-SYMBOL  SUBSEQ  REPLACE  SI/:REPLACER )))
    (cond (#M (status feature COMPLR) #Q 'T 
	    (special CHARACTER-CLASS 
		     |+internal-CHARACTER-table/||
		     STRING-CLASS 
		     STR/:NULL-STRING)
	 #M (progn (fixnum (STRING-LENGTH)
			   (CHAR-N () fixnum) 
			   (CHAR-DOWNCASE fixnum) 
			   (CHAR-UPCASE fixnum))
		   (notype (RPLACHAR-N () fixnum fixnum))
	   #+PDP10 (progn (fixnum (+INTERNAL-CHAR-N () fixnum)
				  (+INTERNAL-STRING-WORD-N () fixnum))
			  (notype (+INTERNAL-RPLACHAR-N () fixnum fixnum)
				  (+INTERNAL-SET-STRING-WORD-N () fixnum fixnum)
				  (SET-STRING-LENGTH () fixnum))
			  (fixnum STR/:GRAB-PURSEG))
		   (*lexpr MAKE-STRING 
			   STRING-SKIPQ STRING-BSKIPQ STRING-SKIPQ-N 
			   STRING-BSKIPQ-N  STRING-POSQ STRING-BPOSQ 
			   STRING-POSQ-N STRING-BPOSQ-N  STRING-FILL 
			   STRING-FILL-N  STRING-SEARCH-SET 
			   STRING-REVERSE-SEARCH-SET STRING-SEARCH-NOT-SET 
			   STRING-REVERSE-SEARCH-NOT-SET  STRING-SEARCH-CHAR 
			   STRING-REVERSE-SEARCH-CHAR STRING-SEARCH-NOT-CHAR 
			   STRING-REVERSE-SEARCH-NOT-CHAR   STRING-REPLACE 
			   STRING-SUBSEQ STRING-MISMATCHQ  STRING-REMQ 
			   SUBSTRING STRING-APPEND )
		   (array* (FIXNUM (STR/:ARRAY ()))))
	 ))
    )

#-NIL 
(eval-when (eval load)
    (and (status feature COMPLR)
 #+PDP10 (memq COMPILER-STATE '(() TOPLEVEL))
	 (notype (MAKE-STRING fixnum)))
)

#-LISPM 
(eval-when (eval load compile)
    (cond ((status feature COMPLR)
 	    (special |STR/:STRING-SEARCHer| 
		     |STR/:STRING-POSQ-Ner| 
		     |STR/:STRING-POSQer| 
		     STR/:STRING-EQUAL-LESSP 
		     STR/:STRING-UP-DOWN-CASE)
      #M    (*lexpr |STR/:STRING-SEARCHer| 
		    STR/:STRING-EQUAL-LESSP 
		    STR/:STRING-UP-DOWN-CASE)
  #-Multics (*expr GET-PNAME) ))
    )




#M
(declare 
    (ARRAY* (NOTYPE (STR/:GCMARRAY)))
    (*EXPR STR/:GC-DAEMON)
    (SPECIAL STRINGS-GCSIZE STRINGS-GCMAX STRINGS-GCMIN)
    (SPECIAL 
      STR/:ARRAY 	;fixnum array, holding packed ascii for strings
      STR/:ARYSIZE 	;current size of above array, in words
      STR/:FREESLOT 	;slot in array above which no strings stored 
      STR/:GCMARRAY 	;non-GC-marked s-exp array - holds all strings
      STR/:GCMSIZE 	;current size of above array, in "entries"
      STR/:NO/.STRS 	;number of strings currently entered in arrays
      STR/:DUMMY 	;dummy header used during string relocations
      ) 
    (SPECIAL STR/:PURE-ADDR 
	     STR/:NO/.PWDSF 
	     STR/:STRING-HUNK-PATTERN 
	     STR/:CHARACTER-HUNK-PATTERN 
	     STR/:CHARACTER-EXTEND-PATTERN )
  )


#-NIL (progn 'compile 
(eval-when (eval compile) 
  (setq-if-unbound STRING-CLASS () )	
)
(DEFCLASS* STRING STRING-CLASS SEQUENCE-CLASS)
(DEFCLASS* CHARACTER CHARACTER-CLASS OBJECT-CLASS)
)


(define-loop-path (characters character)
		  si:loop-sequence-elements-path
		  (of from to below above downto in by)
		  char string-length string character)



;;;; Temporary macros

(eval-when (compile)
   (setq defmacro-for-compiling () defmacro-displace-call () )
)

(defmacro EXCH (x y) `(PSETQ ,x ,y ,y ,x))

;; For getting and setting stack args
(defmacro S-ARG (w i) 
   #N 	 	`(VREF ,w ,i)
   #M 	 	`(ARG (1+ ,i))
   #Q 		`(NTH ,i ,w)
   )
(defmacro S-SETARG (w i val)
   #N 		`(VSET ,w ,i ,val)
   #M 		`(SETARG (1+ ,i) ,val)
   #Q 		`(RPLACA (NTHCDR ,i ,w) ,val)
   )

#M (progn 'compile 

(defmacro AR-1 (&rest w) `(ARRAYCALL T ,. w)) 
(defmacro /" (x) 
   (if (not (symbolp x)) (error '|Uluz - /" pseudo-string maker|))
#+PDP10 
   (progn (setq x (copysymbol x () ))
	  (set x x)
	  (putprop x `(SPECIAL ,x) 'SPECIAL)
	  (putprop x 'T '+INTERNAL-STRING-MARKER))
   x)



#+PDP10 (progn 'compile 
(defmacro NEW-CHARACTER (i &optional purep)
   `(LET ((I ,i)
	  (C ,(cond (purep `(PURCOPY STR/:CHARACTER-HUNK-PATTERN))
		    ('T    `(SUBST () () STR/:CHARACTER-HUNK-PATTERN)))))
      (SETF (SI:EXTEND-CLASS-OF C) 
	    (SI:EXTEND-CLASS-OF STR/:CHARACTER-EXTEND-PATTERN))
      (SETF (SI:EXTEND-MARKER-OF C) 
	    (SI:EXTEND-MARKER-OF STR/:CHARACTER-EXTEND-PATTERN))
      (SI:XSET C 0 (MUNKAM I))))
(defmacro NEW-STRING (wordno len) 
   `(SI:EXTEND STRING-CLASS ,wordno ,len))
  )

#-PDP10 (progn 'compile 
  (defmacro NEW-CHARACTER (i &optional purep) `(SI:EXTEND CHARACTER-CLASS ,i))
  (defmacro +INTERNAL-CHAR-N (&rest w) `(CHAR-N ,.w))
  (defmacro +INTERNAL-RPLACHAR-N (&rest w) `(RPLACHAR-N ,.w))
  )

)	;end of #M


(defmacro SUBSTRINGIFY (str i cnt)
   #+Multics  `(SUBSTR ,str ,i ,cnt)
   #-Multics  `(STRING-REPLACE (MAKE-STRING ,cnt) ,str 0 ,i ,cnt)
   )


#M (progn 'compile 

(defmacro DEFLEXPRMACRO (name fun first-arg args-prop &aux (g (gensym)))
   `(PROGN 'COMPILE 
	   (AND (STATUS FEATURE COMPLR) 
		(EVAL '(DEFMACRO ,name (&REST W)
			  `(,',fun ,',first-arg ,. W)))) 
	   (DEFUN ,name ,g 
		  ,g 
		  (|*lexpr-funcall-1| ',name ,fun ,first-arg ,args-prop))))
)	;end of #M 

#-MacLISP 
(defmacro DEFLEXPRMACRO (name fun first-arg args-prop &aux g)
     (si:gen-local-var g)
    `(DEFUN ,name (&REST ,g)
	    (LEXPR-FUNCALL ,fun ,first-arg ,g)))

#-NIL 
(defmacro DEFMUMBLE (&rest w) `(DEFLEXPRMACRO ,.w))

;;; In real NIL, defmumble generates a DEFUN which "passes along" a call
;;;  to a specific sequence function, as a mini-subr call either with or
;;;  without the optional "CNT" argument, depending on whether it was 
;;;  provided by the source code caller.  This strategy allows defaulting
;;;  any other optional argument to 0, but permits the mini-subr to 
;;;  calculate the default for the "count" argument.
#+NIL 
  (defmacro (DEFMUMBLE defmacro-for-compiling () )  
	    (name () () args 
		&aux (cntp (si:gen-local-var () "Cntp")) 
		     (opt-args (list (si:gen-local-var () "&opt")))
		     (req-args (mapcar #'(lambda (x) (si:gen-local-var () "Req-Var"))
				       (make-list (car args)))) )
    (do ((i (1- (cdr args)) (1- i))
	 (opt-argsl `(,(car opt-args) 0 ,cntp)))
	((<= i (car args))
	 `(DEFUN ,name (,@req-args &OPTIONAL ,@opt-argsl)
		 (COND (,cntp (,name ,@req-args ,opt-args))
		       (#T (,name ,@req-args 
				  ,(nreverse (cdr (reverse opt-args))))))))
      (push (si:gen-local-var () "&opt") opt-args)
      (push `(,(car opt-args) 0) opt-argsl)))





(eval-when (compile)
   (setq defmacro-for-compiling 'T defmacro-displace-call MACROEXPANDED )
)


;;;; Initial setups

#+PDP10
  (cond ((and (get 'STRAUX 'VERSION)
	      (eq (array-type 'STR/:ARRAY) 'FIXNUM)
	      (fixp (array-/#-dims 'STR/:GCMARRAY))))
	('T (mapc '(lambda (x y) (and (not (boundp x)) (set x y)))
		  '(STRINGS-GCSIZE STRINGS-GCMAX STRINGS-GCMIN)
		  '(2048.         20480.        .2))
	    (setq STR/:ARYSIZE STRINGS-GCSIZE 
		  STR/:GCMSIZE  256. 
		  STR/:FREESLOT   0 
		  STR/:NO/.STRS   0  
		  STR/:NO/.PWDSF  0
		  STR/:PURE-ADDR  -1 )
	    (setq STR/:STRING-HUNK-PATTERN (new-string -1 0))
	    (setf (SI:extend-marker-of STR/:STRING-HUNK-PATTERN) () )
	    (setf (SI:extend-class-of STR/:STRING-HUNK-PATTERN) () )
	    (setq STR/:CHARACTER-EXTEND-PATTERN 
		  (SI:EXTEND CHARACTER-CLASS (MUNKAM #O777777))
		  STR/:CHARACTER-HUNK-PATTERN 
		  (SI:EXTEND CHARACTER-CLASS (MUNKAM #O777777)))
	    (setf (si:extend-marker-of STR/:CHARACTER-HUNK-PATTERN) () )
	    (setf (si:extend-class-of STR/:CHARACTER-HUNK-PATTERN) () )
	    (array STR/:ARRAY FIXNUM STR/:ARYSIZE)
	    (array STR/:GCMARRAY () STR/:GCMSIZE)
	    (mapc '(lambda (x) (set x (get x 'ARRAY))) 
		  '(STR/:ARRAY STR/:GCMARRAY))
	    ;; (setq STR/:NULL-STRING (make-string 0))
	    ((lambda (x y)
		     (store (STR/:GCMARRAY 0) y)
		     (setq STR/:FREESLOT 1 
			   STR/:NO/.STRS  1 
			   STR/:NULL-STRING y)
		     (setq STR/:DUMMY (new-string 0 0))
		     (nointerrupt x))
	     (nointerrupt 'T) 
	     (new-string 0 0))
	    (cond ((getddtsym 'GRBPSG))
		  ((status feature ITS)
		   (cond ((eq (status lispv) '/1914) 
			  (defprop GRBPSG 19042. SYM))
			 ((valret '|:symlod/:vp |))))
		  ;; On non-ITS systems, make the PURE_STRING loader bomb
		  ;;   out by doing a THROW
		  ('T (putprop 'GRBPSG (1- (getddtsym 'ERUNDO)) 'SYM)))
	    (subload STRAUX)))


;;;; Bothmacros and lexprmacros

#-NIL (progn 'COMPILE 

(defbothmacro CHARACTERP (x) `(EQ (PTR-TYPEP ,x) 'CHARACTER))
#M 
(defbothmacro STRINGP (x) `(EQ (PTR-TYPEP ,x) 'STRING))
#+Multics 
(defbothmacro STRING-LENGTH (x) `(STRINGLENGTH ,x))
(defcomplrmac CHAR (str i) 
   `(*:FIXNUM-TO-CHARACTER (+INTERNAL-CHAR-N  ,str ,i)))
(defun CHAR (str i)
   (if *RSET 
       (let ((cnt 1))
	 (check-subsequence (str i cnt) 'STRING 'CHAR)))
   (char str i))
(defcomplrmac RPLACHAR (str i c) 
   `(+INTERNAL-RPLACHAR-N ,str ,i (*:CHARACTER-TO-FIXNUM ,c)))
(defun RPLACHAR (str i c)
   (cond ((or *RSET 
	      (not (stringp str)) 
	      (not (fixnump i))
	      (< i 0)
	      (>= i (string-length str))) 
	   (let ((cnt 1))
	     (check-subsequence (str i cnt) 'STRING 'RPLACHAR))
	   (check-type c #'CHARACTERP 'RPLACHAR)))
   (rplachar str i c))

)

(defbothmacro CHARACTER (c) `(TO-CHARACTER-N? ,c () ))

#M
  (progn 'compile 
    (defbothmacro *:CHARACTER-TO-FIXNUM (c) `(MAKNUM (SI:XREF ,c 0)))
    (defbothmacro STRING-LENGTH (x) `(SI:XREF ,x 1))
;;  (defbothmacro SET-STRING-LENGTH  (x n) `(SI:XSET ,x 1 ,n))
;;   SET-STRING-LENGTH has been re-written as a subr -- see near MAKE-STRING
    (defsetf STRING-LENGTH ((() str) len) () 
	     `(SI:XSET ,str 1 ,len))
    )	;end of #M 

#+(or LISPM MULTICS) 
  (progn 'compile 
      (defbothmacro *:CHARACTER-TO-FIXNUM (VAL) `(AR-1 ,val 1))
      (defbothmacro CHAR-N (H N) `(AR-1 ,h ,n))
      (defbothmacro RPLACHAR-N (H N VAL)
	 (cond ((or (|side-effectsp/|| h) 
		    (|side-effectsp/|| n) 
		    (|side-effectsp/|| val))
		(let (htem tmp)
		     (si:gen-local-var htem "Char")
		     (si:gen-local-var tmp "I")
		     `((LAMBDA (,htem ,tmp) (AS-1 ,val ,htem ,tmp))
		          ,h ,n)))
	       (`(AS-1 ,val ,h ,n))))
      (defbothmacro SET-STRING-LENGTH  (x n) `(ADJUST-ARRAY-SIZE ,x ,n))
      (defsetf STRING-LENGTH ((() str) len) () 
	       `(SET-STRING-LENGTH ,str ,len))
      )	;end of #+(or LISPM MULTICS) 


;; STRING-SEARCHQ AND STRING-EQUAL are already mini-subr'd in real NIL

#-NIL 
(defmumble STRING-SEARCHQ  |STR/:STRING-SEARCHer| 
	  '(() T STRING-SEARCHQ)   '(2 . 4))

(defmumble STRING-BSEARCHQ |STR/:STRING-SEARCHer| 
	  '(() () STRING-BSEARCHQ) '(2 . 4))


#-LISPM (progn 'compile 
     ;;; STRING-EQUAL and STRING-LESSP should be rewritten in machine lang?
(deflexprmacro STRING-LESSP STR/:STRING-EQUAL-LESSP '(() . () ) '(2 . 6))
 #-NIL
(deflexprmacro STRING-EQUAL STR/:STRING-EQUAL-LESSP '(() . T) '(2 . 6))
(deflexprmacro STRING-SEARCH |STR/:STRING-SEARCHer| 
	      '(T T STRING-SEARCH) '(2 . 4))
(deflexprmacro STRING-REVERSE-SEARCH |STR/:STRING-SEARCHer| 
	       '(T () STRING-REVERSE-SEARCH) '(2 . 4))
(deflexprmacro STRING-DOWNCASE STR/:STRING-UP-DOWN-CASE () '(1 . 3))
(deflexprmacro STRING-UPCASE STR/:STRING-UP-DOWN-CASE #T '(1 . 3))
)	;end of #-LISPM 


#-PDP10 		;These come in from the STRAUX file for maclisp
  (progn 'compile 
     #-NIL
     (defmumble STRING-POSQ |STR/:STRING-POSQer| '(POSQ . T) '(2 . 4))
     (defmumble STRING-BPOSQ |STR/:STRING-POSQer| '(POSQ . () ) '(2 . 4))
     #-NIL
     (defmumble STRING-SKIPQ |STR/:STRING-POSQer| '(SKIPQ . T) '(2 . 4))
     (defmumble STRING-BSKIPQ |STR/:STRING-POSQer| '(SKIPQ . () ) '(2 . 4))
     #-NIL
     (defmumble STRING-POSQ-N |STR/:STRING-POSQ-Ner| '(POSQ . T) '(2 . 4))
     (defmumble STRING-BPOSQ-N |STR/:STRING-POSQ-Ner| '(POSQ . () ) '(2 . 4))
     #-NIL
     (defmumble STRING-SKIPQ-N |STR/:STRING-POSQ-Ner| '(SKIPQ . T) '(2 . 4))
     (defmumble STRING-BSKIPQ-N |STR/:STRING-POSQ-Ner| '(SKIPQ . () ) '(2 . 4))
     #-NIL
     (defmumble STRING-FILL |STR/:STRING-POSQer| '(FILL . () ) '(2 . 4))
     #-NIL
     (defmumble STRING-FILL-N |STR/:STRING-POSQ-Ner| '(FILL . () ) '(2 . 4))
	)	;end of #-PDP10



(defsetf CHAR ((() frob index) value) () 
   `(RPLACHAR ,frob ,index ,value))

(defsetf CHAR-N ((() frob index) value) () 
   `(RPLACHAR-N ,frob ,index ,value))


;;;; Maclisp MAKE-STRING and gc support, and buck-passing |*lexpr-funcall-1|

#+PDP10
(progn 'compile 

(eval-when (eval compile)
(defmacro WORD-NO  (str)  `(SI:XREF ,str 0))
    ;; Warning!  Discontinuity at 0:  (// -1 5) => -1, instead of 0
(defsimplemac NO-WORDS-USED (x) 
   `(IF (<= ,x 0)  1  (1+ (// (1- ,x) #.*:bytes-per-word))))
(defsimplemac WORDNO-OF-NEXT-FREESLOT (str)
   `(+ (WORD-NO (STR/:GCMARRAY ,str))
       (NO-WORDS-USED (FIXNUM-IDENTITY (STRING-LENGTH ,str)))))
(defmacro TRIMWORD (word no-odd-chrs)
   `(DEPOSIT-BYTE ,word 
		  0 
		  (1+ (* (- #.*:bytes-per-word ,no-odd-chrs) 
			 #.*:bits-per-character)) 
		  0))
  )



(defconst STR/:GC-DAEMON () 
  "Flag used to communicate the fact that the gc-daemon has been run.")

(defun MAKE-STRING (x &optional (filler 0 fillerp))
   (if *RSET (check-type x #'SI:NON-NEG-FIXNUMP 'MAKE-STRING))
   (prog (wds-required maxslot n no-strings str oni cfl gfl *RSET)
	 (declare (fixnum n wds-required no-strings maxslot))
	 (setq oni (nointerrupt 'T) 
	       n x 
	       wds-required (no-words-used n))
      A  (setq maxslot (+ wds-required STR/:FREESLOT))
	 (cond 
	   ((>= maxslot STR/:ARYSIZE)
	      ;;Do we need GC or COMPRESSION attention?
	     (cond ((< maxslot STRINGS-GCSIZE)
		      ;;Maybe we could just grow the array without GC'ing?
		     (str/:grow-array maxslot))
		   ((null cfl)
		      ;;Try compressing without GC at least once.
		     (STR/:COMPRESS-SPACE)
		     (setq cfl 'T)
		     (go A))
		   ((null gfl)
		      ;;Well, try Gc'ing once, and (maybe) permit interrupts
		     (nointerrupt oni)
		     (setq STR/:GC-DAEMON () )
		     (gc)		
		      ;;Must have GC-DAEMON run, to mark STR/:GCMARRAY 
		     (if (null STR/:GC-DAEMON) (str/:gc-daemon () ))
		     (nointerrupt 'T)
		     (STR/:COMPRESS-SPACE)
		     (str/:grow-array maxslot)
		     (setq gfl 'T cfl 'T)
		     (go A))
		   ('T (error (/" |Can't get enough STRING space|)
			      wds-required 
			      'FAIL-ACT)
		       (setq gfl () cfl () )
		       (go A)))))
          ;; Here is the basic consification of strings!
	 (setq no-strings (setq STR/:NO/.STRS (1+ STR/:NO/.STRS)))
	 (cond ((> no-strings STR/:GCMSIZE )
		(nointerrupt oni)
		(let ((newsize (+ STR/:GCMSIZE 512.)))
		  (*rearray 'STR/:GCMARRAY () newsize)
		  (setq STR/:GCMSIZE newsize)) 
		(nointerrupt 'T)))
	 (setq str (new-string STR/:FREESLOT n)
	       STR/:FREESLOT (+ STR/:FREESLOT wds-required))
	 (store (STR/:GCMARRAY (1- no-strings)) str)
	 (nointerrupt oni)
	 (if (or (null fillerp) (= filler 0))
	     (str/:clear-words str wds-required)
	     (string-fill-n str (character filler)))
	 (return str)))


(defun STR/:GROW-ARRAY (maxslot)
    ;; Calculate a size to which the array ought to be grown.
  (setq maxslot 
	(+ maxslot
	   (cond ((fixnump STRINGS-GCMIN) STRINGS-GCMIN)
		 ((flonump STRINGS-GCMIN) 
		   (ifix (*$ STRINGS-GCMIN (float STR/:ARYSIZE))))
		 ('T 1024.))))
  (*rearray 'STR/:ARRAY 'FIXNUM maxslot)
  (setq STR/:ARYSIZE (array-dimension-n 1 'STR/:ARRAY))
  (if (< STRINGS-GCSIZE STR/:ARYSIZE)
      (setq STRINGS-GCSIZE STR/:ARYSIZE))
  (if ^D 
      (let ((OUTFILES (if (memq 'T msgfiles) 
			  (cons tyo msgfiles) 
			  msgfiles)) 
	    (^R 'T) (^W 'T) 
	    (BASE 10.) (*NOPOINT))
	(terpri)
	(princ '|;Adding a new STRING chunk -- space is now |)
	(prin1 STR/:ARYSIZE)
	(princ '| words.|)))
  'T)


(eval-when (eval compile)
  (defmacro GCDAEMON-LOST? (str)
    `(OR (NOT (EQ (TYPEP ,str) ',(typep (new-string -1 0))))
	 (AND (CAR ,str)			    ;GC nullifies LH of hunk
	      (NOT (EQ (SI:EXTEND-CLASS-OF ,str) STRING-CLASS))
	      (NOT (EQ (TYPE-OF ,str) 'STRING)))))
)

(defvar STR/:GC-CHECK? () )
;;; If non-null, causes the weird condition of non-string-found-in-string-array
;;;  to breakpoint.  Whether breaking or not, the conditions is proceedable
;;;  merely by nullifying the offending slot.


(defun STR/:GC-CHECK? (msg fun i)
  (cond (STR/:GC-CHECK? 
	  (format msgfiles 
		  (/" |;Possible STRING bug: ~A~%;  Discovered in ~A -- Returning will merely flush (STR/:GCMARRAY ~d)|)
		  (or msg (/" |Non-string in GCMARRAY|))
		  fun 
		  i)
	  (break STR/:GC-CHECK?)))
  (store (STR/:GCMARRAY i) () ))


(defun STR/:COMPRESS-SPACE () 
    ;; *RSET is () when MAKE-STRING  calls this function, but most 
    ;;  importantly, (NOINTERRUPT 'T) has been done, so there can't be
    ;;  any re-entrant calls!!!
  (do ((i 1 (1+ i))
       (lui 0) 					;last used index
       (free-loc 1) (str-ln 0) 
       (current-loc 0) (old-loc 0)
       (byte-parity 0) (lowest-i-certified-safe 0)
       (str) 
       (str-free STR/:DUMMY))
      ((> i STR/:NO/.STRS)	 		;Loop thru the GCMARRAY
        (if ^D 
	    (let ((OUTFILES (if (memq 'T msgfiles) 
				(cons tyo msgfiles) 
				msgfiles)) 
		  (n (1+ lui))
		  (^R 'T) (^W 'T) 
		  (BASE 10.) (*NOPOINT))
	      (declare (fixnum n))
	      (terpri) 
	      (princ '|;Compression of STRING space: |)
	      (prin1 n)
	      (princ '| live Strings, using |)
	      (prin1 free-loc)
	      (princ '| words.|)
	      (terpri)
	      (cond ((not (= 0 (setq n (- STR/:NO/.STRS n))))
		     (princ '|;   (Reclaimed |)
		     (prin1 n)
		     (princ '| strings using |)
		     (prin1 (- STR/:FREESLOT free-loc))
		     (princ '| words.)|))
		    ('T (print '|; (Nothing reclaimed).|)))))
        (setq STR/:NO/.STRS (1+ lui) 		; # strs still alive
	      STR/:FREESLOT free-loc)		;lowest free in STR:ARRAY
	() )
    (declare (fixnum i lui free-loc str-ln current-loc old-loc 
		     byte-parity lowest-i-certified-safe))
    (setq str (STR/:GCMARRAY i))
    (cond ((null str) () )			;String already proven dead
	  ((and str (gcdaemon-lost? str)) 
	    (str/:gc-check? () 'STR/:COMPRESS-SPACE i))
	  ((cond ((or (< (setq str-ln (string-length str)) 0) 
		      (> str-ln 1_14.)
		      (< (setq current-loc (word-no str)) 0)
		      (> current-loc 12._14.))
		   (let ((STR/:GC-CHECK? 'T))
		     (str/:gc-check? (/" |STRING length or location bad!|) 
				     'STR/:COMPRESS-SPACE 
				     i))
		   () )
		 ('T))
	     ;;Aha! STRING is alive!
	   (if 
	     (cond ((> current-loc old-loc) 		    ;Close gap, if any,
		     (setf (string-length str-free) str-ln) ; moving string to 
		     (setf (word-no str-free) free-loc)	    ; the lower slot
		     (cond ((not (= str-ln 0)) 
			     (string-replace str-free str) 
			       ;;After string movement, we have have to insure
			       ;; that final word is padded with 0's
			     (if (not (= (setq byte-parity (\ str-ln 5)) 0))
				  ;;Byte-parity is 0,1,2,3,4 counting from left
				 (let ((ha (1- (no-words-used str-ln))))
				   (+internal-set-string-word-n 
				     str-free 
				     ha  
				     (trimword (+internal-string-word-n 
						 str-free 
						 ha)
					       byte-parity))))))
		     (setf (word-no str) free-loc)
		     'T)
		   ((= current-loc old-loc)
		    (str/:gc-check? '|Failure to increment STR/:FREESLOT| 
				     'STR/:COMPRESS-SPACE 
				     i))
		   ('T ;; means that (< current-loc old-loc)
		       ;;Looks like some loser "sneaked" in here.
		     (let* ((loseri (1- i))
			    (ha (str/:gcmarray loseri)))
		       (declare (fixnum loseri))
		       (str/:gc-check? (/" |Re-cons'd String found|) 
				       'STR/:COMPRESS-SPACE 
				       loseri)
		        ;;Ok, just try to certify that all strings in the array
		        ;; from 0 up to here are "unique"
		       (do ((k (1+ lowest-i-certified-safe) (1+ k))
			    (sk))
			   ((>= k loseri))
			 (declare (fixnum k j))
			 (setq sk (str/:gcmarray k))
			 (do ((j (1+ k) (1+ j)))
			     ((> j STR/:NO/.STRS))
			   (if (eq sk (str/:gcmarray j))
			       (str/:gc-check? (/" |Re-cons'd String no our of order?|) 
					       'STR/:COMPRESS-SPACE 
					       k))))
		        ;;And check out this loser -- it had better be a twice-
		        ;; cons'd hunk used as a string again.
		       (do ((j i (1+ j)))
			   ((> j STR/:NO/.STRS)
			    (str/:gc-check? (/" |Can't find 2nd of Re-cons'd String|)
					    'STR/:COMPRESS-SPACE 
					    loseri))
			 (declare (fixnum j))
			 (if (eq ha (str/:gcmarray j))
			     (return () )))
		       (setq lowest-i-certified-safe loseri))
		     () ))
	      ;; Update running counters for FREE-SLOTLOC and NO.STRS
	     (progn (setq old-loc current-loc  
			  free-loc (+ free-loc (no-words-used str-ln)))
		    (cond ((not (= (setq lui (1+ lui)) i))
			   (store (STR/:GCMARRAY lui) str)
			   (store (STR/:GCMARRAY i) () )))))))))




(defun STR/:GC-DAEMON  (() ) 
   ;; *RSET is () when MAKE-STRING  calls the GC
  (cond ((not (eq STR/:NULL-STRING (STR/:GCMARRAY 0)))
	  (str/:gc-check? (/" |(STR/:GCMARRAY 0) clobbered|) 
			  'STR/:GC-DAEMON 
			  0)
	  (store (STR/:GCMARRAY 0) STR/:NULL-STRING)))
  (do ((i 1 (1+ i))		;index which cycles thru gcmarray
       (ns 0)			;number of non-"nullified" slots
       (nn 0)			; amount of space consumed
       (str) )
      ((> i STR/:NO/.STRS)
        (if ^D 
	    (let ((OUTFILES (if (memq 'T msgfiles) 
				(cons tyo msgfiles) 
				msgfiles)) 
		  (^R 'T) (^W 'T) 
		  (BASE 10.) (*NOPOINT))
	      (terpri) 
	      (princ '|;STRING space:  |)
	      (prin1 ns)
	      (princ '| live strings, using |)
	      (prin1 nn)
	      (princ '| words.|))))
    (declare (fixnum i ns nn))
    (cond ((null (setq str (STR/:GCMARRAY i))) () )  ;Already flushed this one?
	  ((null (car str))
	     ;;GC nullifies LH of hunk, so if string is dead, then nullify 
	     ;;  gcmarray slot, for it is garbage!
	    (store (STR/:GCMARRAY i) () ))
	  ((gcdaemon-lost? str) 
	    (str/:gc-check? () 'STR/:GC-DAEMON i))
	  (^D (setq ns (1+ ns) 
		    nn (+ nn (no-words-used (string-length str)))))))
  (setq STR/:GC-DAEMON 'T))	    


(eval-when (compile)
  (notype (SET-STRING-LENGTH () () )))

(defun SET-STRING-LENGTH (str n &aux (lstr 0) (no-odd-chrs 0))
    (declare (fixnum lstr no-odd-chrs))
    (if *RSET (check-type str #'STRINGP 'SET-STRING-LENGTH))
    (setq lstr (string-length str))
    (do () 
	((and (fixnump n) (<= 0 n lstr)))
      (setq n (error (/" |Can't set length of string to this|)
		     `(STRING str n)
		     'FAIL-ACT)))
    (setq no-odd-chrs (\ n #.*:bytes-per-word))
    (or (= no-odd-chrs 0)
	(let* ((lstwd-i (1- (no-words-used n)))
	       (lastword (+internal-string-word-n str lstwd-i)))
	  (declare (fixnum lstwd-i))
	  (+internal-set-string-word-n 
	     str 
	     lstwd-i 
	     (trimword lastword no-odd-chrs))))
      (setf (string-length str) n)
      str)



(eval-when (eval compile)
(defmacro LEXPR-FCL-HELPER (n) 
   (or (fixnump n) (error 'lexpr-fcl-helper n))
   (do ((i 1 (1+ i)) (w () ))
       ((> i n) `(LSUBRCALL T FUN FIRST-ARG ,. (nreverse w)))
     (push `(ARG ,i) w)))
)

(defun |*lexpr-funcall-1| (name fun first-arg args-prop) 
    ;; Function for passing the buck
   (let ((n (arg () )))
	(and (or (< n (car args-prop)) (> n (cdr args-prop)))
		  (error (/" |Wrong number args to function|) name))
	(caseq n 
	       (1  (lexpr-fcl-helper 1))
	       (2  (lexpr-fcl-helper 2))
	       (3  (lexpr-fcl-helper 3))
	       (4  (lexpr-fcl-helper 4))
	       (5  (lexpr-fcl-helper 5))
	       (6  (lexpr-fcl-helper 6)))))


)		;end of moby #+PDP10


;;;; Some funs primitive in real NIL:   *:FIXNUM-TO-CHARACTER, DIGITP, DIGITP-N
;;;; STRING-SUBSEQ,  STRING-MISMATCHQ

#-NIL (progn 'compile 

(defun STR/:CHARACTER-VALUEP (x) (and (fixnump x) (<= 0 x #O7777)))

(defun *:FIXNUM-TO-CHARACTER (x &aux (n 0))
   (declare (fixnum n))
   (and *RSET (check-type x #'STR/:CHARACTER-VALUEP '*:FIXNUM-TO-CHARACTER))
   (cond ((cond ((< (setq n x) #.(^ 2 *:bits-per-character)))
		('T (and (bit-test n #O4000) 		;IOR the %TXTOP bit to 
			 (setq n (bit-set #O1000 n)))	; %TXSFT position, and
		    (setq n (logand #O1777 n)) 		; fold down to 10. bits
		    (< (setq n x) #.(^ 2 *:bits-per-character))))
	  (ar-1 |+internal-CHARACTER-table/|| n))
	 ('T (setq x (munkam n))
	     (cdr (cond ((assq x (ar-1 |+internal-CHARACTER-table/|| 
				       #.(^ 2 *:bits-per-character))))
			('T (setq x (cons x (new-character n)))
			    (push x (ar-1 |+internal-CHARACTER-table/|| 
					  #.(^ 2 *:bits-per-character)))
			    x))))))


(defun STRING-SUBSEQ (str i &optional (cnt () cntp))
   (cond (*RSET (check-subsequence (str i cnt) 'STRING 'STRING-SUBSEQ #T cntp))
	 ((not cntp) (setq cnt (- (string-length str) i))))
   (substringify str i cnt))

;;; Someday, STRING-MISMATCHQ should be rewritten in MIDAS.
(defun STRING-MISMATCHQ (s1 s2  &optional (i1 0) (i2 0) (cnt () ocntp))
  (let	((n 0) (cntp ocntp))
   (declare (fixnum n))
   (cond (*RSET 
	   (let ((foo1 cnt) (foo2 cnt))
	     (check-subsequence (s1 i1 foo1) 'STRING 'STRING-MISMATCHQ #T cntp)
	     (check-subsequence (s1 i2 foo2) 'STRING 'STRING-MISMATCHQ #T cntp)
	     (setq n (if (< foo1 foo2) foo1 foo2) 
		   cntp #T)))
	 (cntp (setq n cnt)))
   (let ((ls1 (- (string-length s1) i1)) 
	 (ls2 (- (string-length s2) i2)))
     (declare (fixnum ls1 ls2))
     (if (not cntp) (setq n (if (< ls1 ls2) ls1 ls2)))
     (cond  #+PDP10 
	   ((and (= i1 0)
		 (= i2 0)
		 (= ls1 ls2)
		 (= n ls1)
		 (str/:compare-words s1 s2))
	      () )
	   (#T (do ((i 0 (1+ i)))
		   ((>= i n) 
		    (if (or ocntp (and (= n ls1) (= n ls2))) 
			() 
			n))
		 (declare (fixnum i))
		 (if (not (= (+internal-char-n s1 (+ i1 i))
			     (+internal-char-n s2 (+ i2 i))))
		     (return (+ i1 i)))))))))

)	;end of #-NIL 


;;;; STRING-PNGET and STRING-PNPUT

#+PDP10 (progn 'COMPILE 

(defun STRING-PNGET (string seven)
   (cond (*RSET
	  (if (not (and (fixnump seven) (= seven 7)))
	      (error (/" |Uluz - need 7|) seven))
	  (check-type string #'STRINGP 'STRING-PNGET)))
   (let* ((str-ln (string-length string))
	  (lstwd-i (1- (no-words-used str-ln)))
	  (no-odd-chrs (\ str-ln #.*:bytes-per-word))
	  (lastword (+internal-string-word-n string lstwd-i))
	  (wdsl `(,(if (= no-odd-chrs 0) 
		       lastword 
		       (trimword lastword no-odd-chrs)))))
     (declare (fixnum str-ln lstwd-i no-odd-chrs lastword))
     (do ((i 0 (1+ i)))
	 ((>= i lstwd-i))
       (declare (fixnum i))
	(push (+internal-string-word-n string (- lstwd-i i 1)) wdsl))
     wdsl))

(defun STRING-PNPUT (l () )
   (if *RSET
       (and l (check-type l #'PAIRP 'STRING-PNPUT)))
   (if (and l (null (cdr l)) (= (car l) 0)) (setq l () )) ;Let | | ==> ""
   (let* ((no/.wds (length l))
	  (str-ln (* no/.wds #.*:bytes-per-word))
	  (str (make-string str-ln)))
     (declare (fixnum no/.wds str-ln))
     (if l (progn 
	     (do ((ll l (cdr ll))
		  (i 0 (1+ i)))
		 ((null ll))
	       (declare (fixnum i))
	       (+internal-set-string-word-n str i (car ll)))
	     (let ((*RSET)
		   (where (string-bskipq-n 0 str (1- str-ln) #.*:bytes-per-word)))
	       (if where (setf (string-length str) (1+ where))))))
     str))


;;;;  STRING-HASH and  |*lexpr-funcall-1|

(defun STRING-HASH (str &optional (start-i 0) (cnt () cntp))
   (cond (*RSET 
	  (check-subsequence (str start-i cnt) 'STRING 'STRING-HASH #T cntp)
	  (setq cntp #T)))
   (let ((str-ln (string-length str)))
     (declare (fixnum str-ln))
     (if (not cntp) (setq cnt (- str-ln start-i)))
     (cond 
       ((= cnt 0) 12345.)
       (#T (if (not (= (\ start-i #.*:bytes-per-word) 0))
	       (setq str (string-subseq str start-i cnt) start-i 0))
	   (let* ((1stwd-i (// start-i #.*:bytes-per-word))
		  (lstwd-i (1- (no-words-used cnt)))
		  (no-odd-chars (\ cnt #.*:bytes-per-word))
		  (hash (+internal-string-word-n str (+ 1stwd-i lstwd-i))))
	     (declare (fixnum 1stwd-i lstwd-i no-odd-chars hash))
	     (or (= no-odd-chars 0)
		 (setq hash (trimword hash no-odd-chars)))
	     (do ((i (- lstwd-i 1stwd-i 1) (1- i)))
		 ((< i 1stwd-i))
	       (declare (fixnum i))
	       (setq hash (logxor (+internal-string-word-n str i) hash)))
	     (lsh hash -1))))))

)	;end of #+PDP10 


;;;; DIGITP, DIGIT-WEIGHT, and  |STR/:STRING-SEARCHer| 


(defun DIGITP (c)  
   (and (setq c (to-character-n? c #T))
	(<= #/0 c #/9)))

(defun DIGIT-WEIGHT (c)
   (setq c (to-character-n? c () ))
   (cond ((<= #/0 c #/9) (- c #/0))
	 ((<= #/A c #/Z)  (- c #.(- #/A 10.)))
	 ((<= #/a c #/z)  (- c #.(- #/a 10.)))))




(defun |STR/:STRING-SEARCHer| (foo s1 s2 &optional (i2 () i2p) (cnt () cntp) 
					 &aux (lispmp (car foo))
					      (fwp (cadr foo)) 
					      (fun (caddr foo)))
  (cond (*RSET 
	  (check-type s1 #'STRINGP 'STRING-SEARCH)
	  (check-subsequence (s2 i2 cnt) 'STRING fun i2p cntp fwp lispmp)
	  (setq i2p #T cntp #T)))
   (prog (ls1 ls2 mpsi ss-i)
     (declare (fixnum ls1 ls2 mpsi ss-i))
     (setq ls1 (string-length s1) 
	   ls2 (string-length s2) 
	   mpsi (- ls2 ls1))
     (cond ((or (not i2p) (null i2)) 
	    (setq i2 (if fwp 0 (if lispmp ls2 (1- ls2))))
	    (setq i2p () )))
     (setq ss-i i2)			;search start index
     (cond ((not fwp) 
	     (setq ss-i (- ss-i ls1))
	     (if (not lispmp) (setq ss-i (1+ ss-i)))))
     (return 
      (cond 
       ((< mpsi 0) () )
       ((= ls1 0)  
	(if (not fwp) (setq ss-i (1- ss-i)))
	ss-i)
       ((let ((haumany 0)
	      (1st-p-c (+internal-char-n s1 0)) ;First pattern char
	      (mnpsi 0))
	  (declare (fixnum haumany 1st-p-c mnpsi))
	  (setq haumany (1+ (if fwp (- mpsi ss-i) ss-i)))
	  (cond ((and cntp (< cnt haumany)) 
		 (setq haumany cnt)
		 (if fwp (setq mpsi (+ ss-i haumany -1))))) 
	  (setq mnpsi (- ss-i haumany))  ;Minimum possible start index
	  (do ((j ss-i)
	       #-NIL (*RSET)
	       #-NIL (nxt-i) )
	      ((cond ((null j))			;Iterate while "next" search-
		     (fwp (> j mpsi))		; start index will be within 
		     (#T  (< j mnpsi)))		; bounds.
	       () )
	    (if lispmp 
		(cond 
		 ((setq j
		    (if fwp 
			(string-search-char 1st-p-c s2 j)
			(string-reverse-search-char 1st-p-c s2 (1+ j))))
		   (and (<= mnpsi j mpsi)
			(string-equal s1 s2 0 j ls1 (+ j ls1))
			(return j))))
		#-NIL 
	         (cond 
		   ((setq nxt-i 
		      (cond (fwp (string-posq-n 1st-p-c s2 j haumany))
			    (#T  (string-bposq-n 1st-p-c s2 j haumany))))
		     (and (<= mnpsi nxt-i mpsi)
			  (not (string-mismatchq s1 s2 0 nxt-i ls1)) 
			  (return nxt-i))
		     (setq haumany (- haumany (if fwp 
						  (1+ (- nxt-i j))
						  (- j nxt-i)))))
		   ('T (setq j () )))))
	  ))))))





;;;;  SUBSTRING,  STRING-APPEND,  STRING-REVERSE,  STRING-NREVERSE,

;; LISPM compatibility stuff

#-LISPM
(progn 'compile 

(defun SUBSTRING (str i &optional (lmi () lmip))
   (cond (*RSET 
	    ;; Check as if "end-index" were a start for backwards searching
	   (check-subsequence (str lmi () ) 'STRING 'SUBSTRING lmip () () #T)
	   (check-type i #'SI:NON-NEG-FIXNUMP 'SUBSTRING))
	 ((null lmip) (string-length str)))
   (substringify str i (- lmi i)))


(defun STRING-APPEND #-NIL n #+NIL (&rest w &aux (n (vector-length w)))
   (let ((new-len 0) str)
     (declare (fixnum new-len))
     (do ((i 0 (1+ i)))
	 ((>= i n))
       (declare (fixnum i))
       (setq str (s-arg w i))	;Calculate total length of resultant string
       (cond  ((not (stringp str)) 
	       (cond ((not (symbolp str))
		       (check-type str #'STRINGP 'STRING-APPEND))
		     (#T (setq str (get-pname str))))
	       (s-setarg w i str)))
       (setq new-len (+ new-len (string-length str))))
    #+Multics
     (apply 'CATENATE (listify n))
    #-Multics
     (let ((newstr (make-string new-len))
	   (ii 0)				;"ii" is a running start index
	   *RSET)
       (do ((i 0 (1+ i)))
	   ((>= i n))
	 (declare (fixnum i))
	 (setq str (s-arg w i))
	 (cond ((not (= (string-length str) 0))  ;Fill in parts of new string
		 (string-replace newstr str ii)
		 (setq ii (+ ii (string-length str))))))
       newstr)))


(defun STRING-REVERSE  (str &optional start (cnt () cntp))
       (str/:string-reverser str #T start cnt cntp))
(defun STRING-NREVERSE (str &optional start (cnt () cntp))
       (str/:string-reverser str () start cnt cntp))


;;;;  STR/:STRING-REVERSER  STR/:STRING-EQUAL-LESSP
;;; Remember, still within a #-LISPM conditional

(defun STR/:STRING-REVERSER 
	    (str newp start cnt cntp &aux (newstr str) (lstr 0))
   (declare (fixnum lstr))
   (if (null start) (setq start 0))
   (cond ((or *RSET (not newp))
	   (check-subsequence (str start cnt)
			      'STRING
			      (if newp 'STRING-REVERSE 'STRING-NREVERSE) 
			      #T 
			      cntp)
	   (setq cntp #T lstr (string-length str))
	   (if newp (let (*RSET) (setq newstr (string-subseq str start cnt)))))
	 (#T (setq lstr (string-length str))
	     (cond ((not cntp) (setq cnt (- lstr start)))
		   ((not (<= (+ start cnt) lstr))
		    (setq cnt (- lstr start))))
	     (if newp (setq newstr (string-subseq str start cnt)))))
   (if newp (setq start 0))
   (do ((i start (1+ i))
	(ii (+ start cnt -1) (1- ii))
	chii)
       ((> i ii) )
     (declare (fixnum i ii chii))
     (setq chii (+internal-char-n newstr ii))	    ;Save an interchange char,
     (+internal-rplachar-n newstr ii (+internal-char-n newstr i))
     (+internal-rplachar-n newstr i chii))	    ; and pairwise-interchange
   newstr)

(defun STR/:STRING-EQUAL-LESSP 
       (foo s1 s2 
	&optional (i1 0 i1p) (i2 0 i2p) (lm1 () lm1p) (lm2 () lm2p))
  (let (((nocasep . equalp) foo) 
	 (ls1 0) (ls2 0) (c1 0) (c2 0))
    (declare (fixnum ls1 ls2 c1 c2))
    (cond 
      (*RSET 
         ;; Check as if "end-index" were a start for backwards searching
        (check-subsequence 
	   (s1 lm1 () )  'STRING  'STR/:STRING-EQUAL-LESSP  lm1p  ()  () #T)
	(check-subsequence 
	   (s2 lm2 () )  'STRING  'STR/:STRING-EQUAL-LESSP  lm2p  ()  () #T)
	(setq lm1p #T lm2p #T)
	(if i1p (check-type i1 #'SI:NON-NEG-FIXNUMP 'STR/:STRING-EQUAL-LESSP))
	(if i2p (check-type i2 #'SI:NON-NEG-FIXNUMP 'STR/:STRING-EQUAL-LESSP))
	(setq c1 (- lm1 i1) c2 (- lm2 i2))
	(check-subsequence (s1 i1 c1) 'STRING 'STR/:STRING-EQUAL-LESSP)
	(check-subsequence (s2 i2 c2) 'STRING 'STR/:STRING-EQUAL-LESSP)
	(setq ls1 (string-length s1) ls2 (string-length s2)) )
      (#T (setq ls1 (string-length s1) ls2 (string-length s2)
		c1 (- (if lm1p lm1 ls1) i1) 
		c2 (- (if lm2p lm2 ls2) i2))))
    (cond 
      ((and equalp (not (= c1 c2)))  () )
      ((and (not equalp) (= c1 0))  (not (= c2 0)))
      ((do ((i1* i1 (1+ i1*))				;Iterate over the two
	    (i2* i2 (1+ i2*))				; strings, looking for
	    (i (if (< c1 c2) c1 c2) (1- i)))		; a place of discord
	   ((<= i 0)
	    (if (or equalp (> (- lm2 i2*) (- lm1 i1*))) 
		#T))
	 (declare (fixnum i i1* i2*))
	 (setq c1 (+internal-char-n s1 i1*)
	       c2 (+internal-char-n s2 i2*))
	 (if (not (if nocasep (= c1 c2) (char-equal c1 c2)))
	       ;;No decision possible when chars are "equal"
	     (return (cond (equalp () )
			   (nocasep (< c1 c2))
			   (#T (char-lessp c1 c2)))))) )) ))



;;; Remember, still within a #-LISPM conditional
(comment  GET-PNAME  STR/:STRING-UP-DOWN-CASE  TRIMers)
;LISPM compatibility stuff

#+PDP10 
(defun GET-PNAME (x) 
   (setq x (pnget x 7))
   (and (null (cdr x))	;Foo! || has (0) as pname list.
	(= (car x) 0)
	(setq x () ))
   (string-pnput x 7))

(defun STR/:STRING-UP-DOWN-CASE (up s1 &optional i1 (cnt () cntp))
   (if (null i1) (setq i1 0))
   (cond (*RSET   
	   (check-subsequence (s1 i1 cnt) 
			      'STRING 
			      (if up 'STRING-UPCASE 'STRING-DOWNCASE)
			      #T 
			      cntp)
	   (setq cntp #T)))
   (let ((ls1 (string-length s1))
	 (ch 0)
	 newstr)
     (declare (fixnum ls1 ch))
     (if (not cntp) (setq cnt (- ls1 i1)))
     (setq newstr (make-string cnt))
     (do ((i 0 (1+ i)))
	 ((>= i cnt))
       (declare (fixnum i))
	(setq ch (+internal-char-n s1 (+ i i1)) 		;get this char
	      ch (if up (char-upcase ch) (char-downcase ch))) 	;case-ify it
	(+internal-rplachar-n newstr i ch))
     newstr))

(defun STRING-LEFT-TRIM (cl str)
  (if *RSET (check-type str #'STRINGP 'STRING-LEFT-TRIM))
  (let ((i1* (string-search-not-set cl str)))
    (cond ((null i1*) STR/:NULL-STRING)
	  ((string-subseq str i1*)))))
(defun STRING-RIGHT-TRIM (cl str)
  (if *RSET (check-type str #'STRINGP 'STRING-RIGHT-TRIM))
  (let ((i1* (string-reverse-search-not-set cl str)))
    (cond ((null i1*) STR/:NULL-STRING)
	  ((let ((len (string-length str)))
	     (if (>= i1* len) (setq i1* (1- len)))
	     (string-subseq str 0 (1+ i1*)))))))
(defun STRING-TRIM (cl str)
  (if *RSET (check-type str #'STRINGP 'STRING-TRIM))
  (let ((i1* (string-search-not-set cl str))
	i2*)
    (cond ((null i1*) STR/:NULL-STRING)
	  ((null (setq i2* (string-reverse-search-not-set cl str)))
	   STR/:NULL-STRING)
	  ((let ((len (string-length str)))
	     (if (>= i2* len) (setq i2* (1- len)))
	     (string-subseq str i1* (- i2* i1* -1)))))))
    
)	;end of moby #-LISPM conditional


;;;; STRING-REMQ 

(setq si:STRING-REMQ-buffer () )

#+(or NIL MacLISP)
(push 'si:STRING-REMQ-buffer #N SI:BREAK-BOUND-VARIABLES
			     #M +INTERNAL-INTERRUPT-BOUND-VARIABLES )

(defun STRING-REMQ (c str &optional (starti 0 ip) (cnt () cntp) 
			  &aux (n 0) (cn 0))
  (declare (fixnum ln i j cn cc maxln)
	   (special si:STRING-REMQ-buffer))
  (or si:STRING-REMQ-buffer (setq si:STRING-REMQ-buffer (make-string 100.)))
  (if *RSET 
      (check-subsequence (str starti cnt) 'STRING 'STRING-SUBSEQ ip cntp))
  (setq n (or cnt (- (string-length str) starti))
	cn (to-character-n c))
  (do ((i starti (1+ i)) 
       (j 0)
       (cc 0)
       (maxln (string-length si:STRING-REMQ-buffer)))
      ((< (setq n (1- n)) 0) (substringify si:STRING-REMQ-buffer 0 j))
    (cond ((not (= cn (setq cc (+internal-char-n str i))))
	    (if (> j maxln)
		(setq si:STRING-REMQ-buffer 
		      (string-replace 
		        (make-string (setq maxln (+ maxln 100.))) 
			si:STRING-REMQ-buffer)))
	    (+internal-rplachar-n si:STRING-REMQ-buffer j cc)
	    (setq j (1+ j))))))
  


;;;; Fill-in primitives


#+Multics
(defun MAKE-STRING (n) 
   (do ((s "" (catenate s "    "))
	(i n (- n 4))) 
       ((< i 4) 
	(cond ((= i 0) s)
	      ((catenate (cond ((= i 1) " ")
			       ((= i 2) "  ")
			       ((= i 3) "   "))
			 s))))))

#Q 
(defun MAKE-STRING (n) 
       (let ((s (make-array () 'ART-16B n)))
	    (as-1 s STRING-CLASS 0)
	    s))
     

#-PDP10 (progn 'compile 

(defun |STR/:STRING-POSQer| (foo char str &OPTIONAL  (i* 0) (cnt 0 cntp))
       (setq char (*:character-to-fixnum char))
       (cond (cntp (|STR/:STRING-POSQ-Ner| foo char str i* cnt))
	     (#T (|STR/:STRING-POSQ-Ner| foo char str i*))))

(defun |STR/:STRING-POSQ-Ner| (foo char str &OPTIONAL (i* () i*p) (cnt () cntp)
					    &AUX      (op (car foo))
						      (fwp (cdr foo)) )
   (if (eq op 'FILL) (exch char str))
   (cond (*RSET 
	   (check-type char #'STR/:CHARACTER-VALUEP op)
	   (check-subsequence (str i* cnt) 'STRING op i*p cntp fwp)
	   (setq cntp #T i*p #T))
	 (#T (if (not i*p) (setq i* 0)) ))
   (do ((n (cond (cntp cnt) 
		 (fwp (- (string-length str) i*))
		 ((1+ i*)))
	   (1- n))
	(i i* (cond (fwp (1+ i)) ((1- i)))))
       ((= n 0) () )
     (declare (fixnum n i))
     (if (eq op 'FILL) (+internal-rplachar-n str i char)
	 (if (eq op (if (= char (+internal-char-n str i)) 'POSQ 'SKIPQ))
	     (return i)))))
     
)	;end of  #-PDP10


;;;; PDP10 hooks -  Methods for PRINT, EXPLODE, SXHASH, NAMESTRING, SAMEPNAMEP,
;;;;  ALPHALESSP, LESSP, GREATERP, EQUAL, FLATSIZE, PURCOPY, USERATOMS

	     
#+PDP10 (progn 'compile 

(defmethod* (:PRINT-SELF STRING-CLASS) (str ofile () slashifyp)
   (if *RSET (check-type str #'STRINGP ':PRINT-SELF->STRING-CLASS))
   (setq ofile (si:normalize-stream ofile))
   (if slashifyp (tyo #/" ofile))
   (do ((len (string-length str))
	(i 0 (1+ i)) 
	(c 0))
       ((>= i len) )
     (declare (fixnum len i c))
     (setq c (+internal-char-n str i))
     (and slashifyp (or (= c #/") (= c #//)) (tyo #// ofile))
     (tyo c ofile))
   (and slashifyp (tyo #/" ofile)))

(defmethod* (:PRINT-SELF CHARACTER-CLASS) (chr ofile () slashifyp)
   (if *RSET (check-type chr #'CHARACTERP ':PRINT-SELF->CHARACTER-CLASS))
   (setq ofile (si:normalize-stream ofile))
   (cond (slashifyp (princ '|~//| ofile)))
   (tyo (*:character-to-fixnum chr) ofile))

(defmethod* (EXPLODE STRING-CLASS) (str slashifyp number-p)
   (if *RSET (check-type str #'STRINGP 'EXPLODE->STRING-CLASS))
   (do ((strlist (and slashifyp
		      (if number-p (ncons #/") (ncons '/")))
		 (cons c strlist))
	(len (string-length str))
	(i 0 (1+ i))
	(c 0))
       ((>= i len)
	(if slashifyp (push (if number-p #/" '/") strlist))
	(nreverse strlist))
     (declare (fixnum len i))
     (setq c (+internal-char-n str i))
     (if (not number-p) (setq c (ascii c)))
     (and slashifyp 
	  (or (= c #/") (= c #//))
	  (push (if number-p #// '//) strlist))))

 (defmethod* (EXPLODE CHARACTER-CLASS) (object slashify-p number-p)
    (let ((result (cons #/~
			(if slashify-p
			    (cons #//
				  (ncons (*:character-to-fixnum object)))
			    (ncons (*:character-to-fixnum object))))))
	 (if (not number-p) (mapcar 'ascii result) result)))

(defmethod* (SXHASH STRING-CLASS) (string) (string-hash string))

(defmethod* (NAMESTRING STRING-CLASS) (string) 
   (pnput (string-pnget string 7) () ))


(defmethod* (SAMEPNAMEP STRING-CLASS) (x y) 
  (si:alpha-test x y '(T . T) () )) 
(defmethod* (ALPHALESSP STRING-CLASS) (x y) 
  (si:alpha-test x y '(T . () ) #T))
(defmethod* (LESSP STRING-CLASS) (x y) 
  (si:alpha-test x y '(T . () ) () ))
(defmethod* (GREATERP STRING-CLASS) (x y) 
  (si:alpha-test y x '(T . () ) () ))


(defun SI:ALPHA-TEST (x y foo alphalesspp)
  (and (cond ((stringp x) (if (not (stringp y)) (setq y (to-string y))))
	     ((stringp y) (setq x (to-string x)) #T)
	     (#T (+internal-lossage 'STRINGP 'ALPHALESSP->STRING-CLASS (list x y))))
       alphalesspp 
       (error (/" |Mixed mode ALPHALESSP tests don't work in old lisps|) (list x y)))
   (str/:string-equal-lessp foo x y)) 


(defmethod* (EQUAL STRING-CLASS) (obj other-obj)
   (and (stringp other-obj) (str/:compare-words obj other-obj)))

(DEFMETHOD* (FLATSIZE STRING-CLASS) (OBJ () () SLASHIFYP)
   (DECLARE (FIXNUM MAX CNT))
   (COND (SLASHIFYP
	  (DO ((MAX (1- (STRING-LENGTH OBJ)))
	       (I -1 (STRING-SEARCH-SET '(#/" #//) OBJ (1+ I)))
	       (CNT 2 (1+ CNT)))
	      ((OR (NULL I) (= I MAX))
	       (+ CNT (COND (I (1+ MAX)) (MAX))))	;Fix fencepost
	      ))
	 (#T (STRING-LENGTH OBJ))))


(defmethod* (FLATSIZE CHARACTER-CLASS) (() () () slashifyp)
   (if slashifyp 3 1))

(defmethod* (PURCOPY STRING-CLASS) (x) 
   (let ((nx (purcopy STR/:STRING-HUNK-PATTERN))
	 (nwds 1)
	 (str-len 0))
      (declare (fixnum nwds str-len))
      (and (cond ((not (stringp x)))
		 ((< (setq str-len (string-length x)) 0))
		 ((> (setq nwds (no-words-used str-len)) 512.))) 
		  (error (/" |Can't PURCOPY a string this long|) x))
      (let ((oni (nointerrupt #T)))
	(if (< STR/:NO/.PWDSF nwds) 
	    (setq STR/:PURE-ADDR (STR/:GRAB-PURSEG) 
		  STR/:NO/.PWDSF 512.))
	(setf (word-no nx) (purcopy (logior 1_35. (- (+ STR/:PURE-ADDR 512.)
						     STR/:NO/.PWDSF))))
	(setq STR/:NO/.PWDSF (- STR/:NO/.PWDSF nwds))
	(nointerrupt oni))
      (setf (si:extend-class-of nx) (si:extend-class-of x))
      (setf (si:extend-marker-of nx) (si:extend-marker-of x))
      (setf (string-length nx) (purcopy str-len))
      (if (> str-len 0) (string-replace nx x 0 0 str-len))
      nx))


(defmethod* (USERATOMS-HOOK STRING-CLASS) (x)
   (list `(STRING-PNPUT ',(string-pnget x 7) #T)))

(defmethod* (USERATOMS-HOOK CHARACTER-CLASS) (x)    ;; Don't macroexpand this - need the use of autoload properties
   (list `(*:FIXNUM-TO-CHARACTER ,(*:character-to-fixnum x))))

)	;end of #+PDP10


;;;; Set up tables and constants


#M 
(mapc #'(lambda (x) (set x (get x 'LSUBR)))
      '(|STR/:STRING-SEARCHer| STR/:STRING-EQUAL-LESSP STR/:STRING-UP-DOWN-CASE 
	#-PDP10 |STR/:STRING-POSQ-Ner| #-PDP10 |STR/:STRING-POSQer| ))
#Q 
(mapc '(lambda (x) (set x (fsymeval x)))
      '(|STR/:STRING-POSQ-Ner| |STR/:STRING-POSQer|))

#+PDP10 
(setq *FORMAT-STRING-GENERATOR 'TO-STRING)

#-NIL (progn 'compile 

(setq |+internal-CHARACTER-table/|| 
      (*array () 'T #.(1+ (^ 2 *:bits-per-character))))
	  ;;Fill in this table with the full 128. character objects,
	  ;; for the ASCII alphabet, leaving a 129.th slot for a list 
	  ;; of folded-down 12-bit characters seen.
(do ((i #.(1- (^ 2 *:bits-per-character)) (1- i)) 
     (*RSET)
     (z (and (status feature PDP10) (status nofeature ONESEGMENT))))
    ((< i 0))
  (store (arraycall T |+internal-CHARACTER-table/|| i)
	 (if z 
	     (new-character i T)
	     (new-character i))))

(defun |+internal-tilde-macro/|| #-LISPM () #Q (ignore ignore) 
   (let ((c (tyi)))
      (declare (fixnum c))
      (cond ((= c #//) (setq c (tyi)))		;Check for slash
	    ((= c #/\) (setq c (/#-/\-parse))))
      (*:fixnum-to-character c)))


#-LISPM  (setsyntax '/~ 'MACRO '|+internal-tilde-macro/||)
#Q 	 (set-syntax-macro-char #/~ '|+internal-tilde-macro/||)

#+PDP10  (progn 'compile

(def-or-autoloadable /#-/\-parse SHARPM) 

(defun |+internal-doublequote-macro/|| ()
     (declare (fixnum ln i c))
     (do ((c (tyi) (tyi))
	  (charsl))
	 ((= c #/")
	  (let* ((ln (length charsl))
		 (str (make-string ln))) 
	    (declare (fixnum ln))
	    (do ((i 0 (1+ i)))
		((>= i ln))
	      (declare (fixnum i))
	      (+internal-rplachar-n str (- ln i 1) (pop charsl)))
	    str))
       (push (if (= c #//) (tyi) c) charsl)))
(setsyntax '/" 'MACRO '|+internal-doublequote-macro/||)
  )	  ;end of #+PDP10
)	;end of #-NIL



(mapc '(lambda (x) (putprop x '|mmcdrside/|| '|side-effectsp/||))
      '(CHAR CHAR-N +INTERNAL-CHAR-N CHARACTERP 
	*:CHARACTER-TO-FIXNUM  *:FIXNUM-TO-CHARACTER
	TO-CHARACTER TO-CHARACTER-N TO-CHARACTER-N? 
	TO-STRING DIGITP DIGIT-WEIGHT 
	CHARACTER CHAR-EQUAL CHAR-LESSP GET-PNAME  STRING-REMQ 
	MAKE-STRING  STRING-SEARCHQ  STRING-BSEARCHQ  STRING-MISMATCHQ 
 	STRING-POSQ  STRING-BPOSQ  STRING-POSQ-N  STRING-BPOSQ-N
 	STRING-SKIPQ STRING-BSKIPQ STRING-SKIPQ-N STRING-BSKIPQ-N
 	STRING-EQUAL STRING-LESSP STRING-SEARCH STRING-REVERSE-SEARCH
 	STRING-DOWNCASE  STRING-UPCASE CHAR-DOWNCASE CHAR-UPCASE
	STRING-REVERSE  SUBSTRING STRING-APPEND  STRING-SUBSEQ 
	STRING-SEARCH-CHAR 		STRING-SEARCH-NOT-CHAR 
	STRING-SEARCH-SET 		STRING-SEARCH-NOT-SET
	STRING-REVERSE-SEARCH-CHAR 	STRING-REVERSE-SEARCH-NOT-CHAR 
	STRING-REVERSE-SEARCH-SET 	STRING-REVERSE-SEARCH-NOT-SET
	STRING-PNGET  STRING-PNPUT  STRING-HASH
	) )



#+PDP10
  (setq GC-DAEMON 
	(cond ((null GC-DAEMON)  'STR/:GC-DAEMON)
	      ((let ((g (gensym)) 
		     (h (cond ((or (symbolp gc-daemon)
				   (and (not (atom gc-daemon))
					(eq (car gc-daemon) 'LAMBDA)))
			       `(,gc-daemon))
			      (`(FUNCALL ',gc-daemon)))))
		    `(LAMBDA (,g) 
			     (STR/:GC-DAEMON ,g)
			     (,.H ,g))))))


(sstatus feature STRING)


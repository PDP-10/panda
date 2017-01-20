;;;  SHARPM 	   -*-mode:lisp;package:si-*-			    -*-LISP-*-
;;;  *************************************************************************
;;;  ***** NIL ****** NIL/MACLISP/LISPM Compatible # Macro  ******************
;;;  *************************************************************************
;;;  ******** (c) Copyright 1981 Massachusetts Institute of Technology *******
;;;  ************ this is a read-only file! (all writes reserved) ************
;;;  *************************************************************************


(herald SHARPM /78)


; Note well:  FORMAT versions > 700 use this list to invert character
; names.  For any given character value, the first entry is used, so
; that should be the preferred full name of the character.
; (The ordering by character code is gratuitous.)
(defvar  /#-SYMBOLIC-CHARACTERS-TABLE 
	  '((NULL . 0)
	    (ALPHA . 2)
	    (BETA . 3)
	    (EPSILON . 6)
	    (BELL . 7.)
	    (BACKSPACE . 8.) (BS . 8)
	    (TAB . 9)
	    (LINEFEED . 10.) (LF . 10.)
	    (VT . 11.)
	    (FORM . 12.) (FORMFEED . 12.) (FF . 12.)
	    (RETURN . 13.) (NEWLINE . 13.) (CR . 13.) (NL . 13.)
	    (ALTMODE . 27.) (ALT . 27.)
	    (BACK-NEXT . 31.) 
	    (SPACE . 32.) (SP . 32.)  
	    (DELETE . 127.) (RUBOUT . 127.)
	    (HELP . 2120.)
	    ))


(defvar |#-C-M-bits| '(128.  256. 384.)
  "List of control and meta bits	;2^7, 2^8, 2^7+2^8 ")


(defvar TARGET-FEATURES 'LOCAL  
  "To allow for smooth interface to SHARPCONDITIONALS package.")
(defvar SI:FEATUREP? () 
  "Used to communicate caller's function name to function SI:FEATUREP?")

#-NIL   (defvar /#-MACRO-DATALIST () )


(eval-when (eval compile)
    (if (fboundp '*expr) (*expr SI:FEATUREP? SI:GET-FEATURE-SET))
    (setq defmacro-for-compiling ()  defmacro-displace-call () )
 #M (setq USE-STRT7 'T)
 )



;;;; Temporary MACROS and "Scotch-tape"

#M (include ((lisp) subload lsp))

#-NIL 
(eval-when (eval compile)

(subload MACAID)
(subload UMLMAC)

(defsimplemac CHARACTER (c)
	`(CASEQ (TYPEP ,c)
		(FIXNUM ,c)
		(SYMBOL (GETCHARN ,c 1))
		(T (ERROR "Not a character - CHARACTER" ,c))))
    
(defmacro *:FIXNUM-TO-CHARACTER (x) x)
(defmacro CHARACTERIFY (x) x)
(defmacro CHARACTERIZE (x) `(ASCII ,x))
(defmacro /#SUB-READ (&rest x) x '(READ))
(defmacro READ-TOKEN (simplep ttt b () ) 
	  `(*read-token ,simplep ,(and (eq ttt '~*) ''*) ,b () ))
(defmacro READTABLE-sharp-macro-list (x) `/#-MACRO-DATALIST)
(defmacro /#TYI (&rest ()) `(TYI))
(defmacro /#TYIPEEK (&rest ()) `(TYIPEEK))

)


#+NIL 
(eval-when (eval compile)

(defvar NON-DECDIGIT-TABLE () 
  "Should be set up by READER.")

(defmacro /#SUB-READ (&rest x) 
	;;In order to "bootstrap"-read this file, we must start out using
	;;   maclisp's old reader - when it is fully in, then the definition
	;;   of /#SUB-READ is changed to be SUB-READ
    #+FOR-NIL  `(SUB-READ ,.x) 		;standard NIL case
    #-FOR-NIL  `(OLD-READ)		;bootstrap case, with NILAID
    )
(defmacro CHARACTERIFY (x) `(*:FIXNUM-TO-CHARACTER ,x))
(defmacro CHARACTERIZE (x) `(*:FIXNUM-TO-CHARACTER ,x))
(defmacro /#TYIPEEK (&rest w) 
	  `(*:CHARACTER-TO-FIXNUM (READER-INCHPEEK ,.w)))
(defmacro /#TYI (&rest w) `(*:CHARACTER-TO-FIXNUM (READER-INCH ,.w)))

)



;;;; DEFSHARP and SETSYNTAX-SHARP-MACRO

#M (DECLARE (OWN-SYMBOL  SETSYNTAX-SHARP-MACRO  DEFSHARP))

(defmacro (DEFSHARP defmacro-for-compiling 'T defmacro-displace-call () )
	  (C &REST BODY)
      (LET ((NAME (IMPLODE (APPEND '(/# - M A C R O -) (LIST C)))) 
	    (IND (COND ((MEMQ (CAR BODY) 
			      '(MACRO SPLICING PEEK PEEK-MACRO PEEK-SPLICING))
			(PROG2 () (CAR BODY) (SETQ BODY (CDR BODY))))
		       ('MACRO))))
	     ;Standardize on character representation as fixnum
	   `(PROGN 'COMPILE
		   (DEFUN ,name ,. body)
		   (SETSYNTAX-SHARP-MACRO ',c ',ind ',name))))


(defun SETSYNTAX-SHARP-MACRO (C IND FUN &OPTIONAL (RT READTABLE RTP) )
   (LET ((SPLICEP (COND ((MEMQ IND '(SPLICING PEEK-SPLICING)) 'SPLICING)
			('T 'MACRO)))
	 (PEEKP (AND (MEMQ IND '(PEEK PEEK-MACRO PEEK-SPLICING)) 'T))
	 (MDL  (READTABLE-sharp-macro-list (COND (RTP RT) ('T READTABLE))) )
	 )
	(SETQ C (CHARACTER C))
	(AND (NOT (< C #/a))
	     (NOT (> C #/z))
	     (SETQ C (- C (- #/a #/A))))	 	;Upper-casify
	(SETQ C (CHARACTERIFY C))
	(DO ((Y (ASSOC C MDL) (ASSOC C MDL)))
	    ((NULL Y))
	  (SETQ MDL (DELQ Y MDL)))
	(AND FUN (PUSH `(,c ,peekp ,splicep . ,fun) MDL))
  	(SETF (READTABLE-sharp-macro-list RT) MDL)
	FUN))


;;;; +INTERNAL-/#-MACRO and helpers

#M (DECLARE (OWN-SYMBOL  +INTERNAL-/#-MACRO  /#+--TEST-FOR-FEATURE 
			 /#-CNTRL-META-IFY  /#-FLUSH-CHARS-NOT-SET ))


 ;The # macro works by keying off a second character, with possibly an
 ;  argument in between.  Currently, the permissible arguments are
 ;   (1) digits, for a numeric argument
 ;   (2) ^B, ^C, or ^F   to signify "add control, meta, or control-meta"
 ;The alist /#-MACRO-DATALIST, which is stored in the readtable,  holds 
 ;  for each valid "second" character a 4-list:
 ;  	(<char-code>  <peekp>  <type>  <function>)
 ;   <function>   takes one argument, as described above [or () if none]
 ;   <type>  	  is either MACRO or SPLICING
 ;   <peekp>      is a flag which, if non-null, means don't flush the "second"
 ;		  character from the input stream before running <function>.
 ;   <char-code>  is the numeric encodeing of the character


(DEFUN +INTERNAL-/#-MACRO  #-NIL () #N (C S)
    ;N accumulates an "infix" argument, like a number in the #16R... case
    ;  the argument is the item between the "#" and the dispatchable character.
#N (AND (OR (NOT (EQ C ~/#)) (NOT (EQ S READ-STREAM)))
	(READER-ERROR S))
   (LET ((C (/#TYIPEEK S)) 
	 (MDL (READTABLE-sharp-macro-list READTABLE) )
	 ARG PEEKP MACRO-TYPE MACRO-FUN UC TMP)
	(DECLARE (FIXNUM C))
	(SETQ ARG (COND ((AND (NOT (< C #/0)) (NOT (> C #/9)))
			 (READ-TOKEN 'FIXNUMP   
				     NON-DECDIGIT-TABLE 
				     10. 
				     READ-STREAM))
			((CASEQ C
			   (2 (/#TYI S) 'CONTROL)		;#/ (alpha)
			   (3 (/#TYI S) 'META)			;#/ (beta)
			   (6 (/#TYI S) 'CONTROL-META)		;#/ (epsilon)
			   (T ())))))
	(AND ARG (SETQ C (/#TYIPEEK S)))
	  ;Find flags/function for this character
	(SETQ UC (COND ((AND (NOT (< C #/a)) (NOT (> C #/z)))
			(- C (- #/a #/A)))		 	;Upper-casify
		       ('T C)))
	(SETQ UC (CHARACTERIFY UC))
	(COND ((SETQ TMP (ASSOC UC MDL)))
	      ('T (/#TYI S) 			;flush the character
		  (ERROR "Unknown dispatch character after #" 
			 (CHARACTERIZE C))))
	(DESETQ ( ()  PEEKP  MACRO-TYPE . MACRO-FUN ) TMP)
	(AND (OR (NULL MACRO-FUN) 
		 (NOT (MEMQ MACRO-TYPE '(MACRO SPLICING))))
	     (ERROR "Garbage format in #-MACRO-DATALIST" (CHARACTERIZE C)))
	(AND (NOT PEEKP) (/#TYI S)) 
	(SETQ ARG (FUNCALL MACRO-FUN ARG))
	(CASEQ MACRO-TYPE 
	       (MACRO     (LIST ARG))
	       (SPLICING  ARG))))


;;;; Helper funs

(DEFUN /#+--TEST-FOR-FEATURE (F)
   (COND ((ATOM F) 
	   (MEMQ F (STATUS FEATURES)))
	 ((EQ (CAR F) 'NOT) 
	   (IF (OR (NULL (CDR F))		; Disallow #+(NOT)
		   (CDDR F))			; Disallow #+(NOT f1 f2 ...)
	       (ERROR '|Can't parse features request list - #+--TEST-FOR-FEATURE| F))
	   (NOT (/#+--TEST-FOR-FEATURE (CADR F))))
	 ((EQ (CAR F) 'AND)	
	   (loop for F in (CDR F) always (/#+--TEST-FOR-FEATURE F)))
	 ((EQ (CAR F) 'OR)
	   (loop for F in (CDR F) thereis (/#+--TEST-FOR-FEATURE F)))
	  ;If we ever decide to make #+(MACLISP BIBOP) default
	  ; to anything, here is the place to do it
	 ('T (ERROR '|Can't parse features request list - #+--TEST-FOR-FEATURE| F))))


(DEFUN /#-CNTRL-META-IFY (MACRO-ARG N CHAR)
   (COND ((NULL MACRO-ARG) N)
	 ((EQ MACRO-ARG 'CONTROL) (+ N (CAR |#-C-M-bits|)))	   ;Cntrl bit
	 ((EQ MACRO-ARG 'META) (+ N (CADR |#-C-M-bits|)))	   ;Meta bit
	 ((EQ MACRO-ARG 'CONTROL-META) (+ N (CADDR |#-C-M-bits|)))  ;Both bits
	 ('T (ERROR '|Bad argument to a # function|
		    (LIST MACRO-ARG CHAR)))))


#-NIL (progn 'compile 

(defun *read-token (simplep gobble-terminatorp b () )
   (declare (fixnum n c b*))
   (and (or (not (eq (typep b) 'FIXNUM))
	    (< b 1)
	    (> b 36.)
	    (not (memq simplep '(FIXNUMP NUMBERP))))
	(error "Bad radix to token-reader for #" (list simplep b)))
   (caseq simplep 
	  (FIXNUMP
	   (do ((c (tyipeek) (tyipeek)) 
		(b* (+ b #/0))
		(n 0 (+ (- c #/0) (cond ((eq gobble-terminatorp '*)
					  ;; losing #*...* format is octal
					 (lsh n 3))
					((* n b))))))
	       ((or (< c #/0) (not (< c b*)))
		(and gobble-terminatorp (tyi))
		n)
	     (tyi)))
	  (NUMBERP 
	   (let ((save (status /+)) (ibase b) ans)
		(setq ans (cond (save (read))
				((unwind-protect 
				  (prog2 (sstatus /+ 'T ) (read))
				  (sstatus /+ save)))))
		(or (numberp ans) 
		    (error "Numeric token expected by some #-function" ans))
		ans))))


(defsharp /: splicing (() )  (/#-flush-chars-not-set #/: 'T) () )

(defun /#-flush-chars-not-set (s finalp)
       (do ((c (tyipeek) (tyipeek)) 
	    (fixp (eq (typep s) 'fixnum)))
	   ((cond (fixp (= c s))
		  ((member c s)))
	    (and finalp (tyi))
	    (list () ))
	 (and (= c #//) (tyi))
	 (tyi)))


(defun /#-bs-reader (x lbb char)
    ;; "lbb" is Log-Binary-Base; e.g. 1 for binary, 3 for octal, and 4 for hex
   (and x (error '|Bad argument to a # function| (list '/#  char x)))
   (cond ((not (= (tyipeek) #/")) 
	   (read-token 'NUMBERP 
		       token-terminator-table  
		       (^ 2 lbb) 
		       read-stream))
	 ('T (/#-/#B-reader lbb))))

#M (or (getl '/#-/#B-reader '(SUBR AUTOLOAD))
       (defprop /#-/#B-reader ((LISP) BITS FASL) AUTOLOAD))

)	;end of #-NIL 


;;;; Lesser used sharps


;;; "controlify", which for 7-bit ascii means just to complement the 100 bit.
(defsharp /^  (() )
   (let ((c (tyi)))
	(or (< c #/a)		;lower case "a"
	    (> c #/z)		;lower case "z"
	    (setq c (- c (- #/a #/A))))
	(boole 6 1_6 c)))


(defsharp /* (() ) (read-token 'FIXNUMP ~* 8 read-stream))

(defsharp /R (macro-arg)
   (cond ((not (eq (typep macro-arg) 'FIXNUM)) 
	  (error "Numeric base required for #nR" macro-arg))
	 ((or (< macro-arg 1) (> macro-arg 36.))
	  (error "Numeric base out of range for #nR" macro-arg))
	 ('T (read-token 'NUMBERP
			 token-terminator-table 
			 macro-arg 
			 read-stream))))

(defsharp /B (c) 		;#B"..."  for BITS's in binary form
    (/#-bs-reader c 1 'B))


;;;; Common /# macros - definitions

(defsharp /'  (() ) `(FUNCTION ,(/#sub-read () READ-STREAM)))

(defsharp // (macro-arg)  (/#-cntrl-meta-ify macro-arg (tyi) '//))

(defsharp /% (() ) (macroexpand (/#sub-read () READ-STREAM)))

(defsharp /.  (() ) (eval (/#sub-read () READ-STREAM)))

(defsharp /,  (() ) 
   (let ((form (/#sub-read () READ-STREAM)))
	(declare (special squid))
	(cond ((memq COMPILER-STATE '(NIL () TOPLEVEL))
	       (eval form))
	      ('T `(,squid ,form)))))

(defsharp /\  (macro-arg)
   (let ((n (/#-/\-parse)))
	(/#-cntrl-meta-ify macro-arg n '/\)))

(defun /#-/\-parse () 
   (let* ((ob (/#sub-read () READ-STREAM))
	  (n (do ((l (and (symbolp ob) /#-SYMBOLIC-CHARACTERS-TABLE) (cdr l)))
		 ((null l) () )
	       (and (samepnamep ob (caar l)) (return (cdar l))))))
     (and (null n) (error "Unknown symbolic name to #\" ob))
     n))



(defsharp /+ SPLICING (())
  (si:/#+or-read (/#sub-read () READ-STREAM) 'T))

(defsharp /- SPLICING (())
  (si:/#+or-read (/#sub-read () READ-STREAM) () ))

(defun SI:/#+OR-READ (test polarity)
   (let ((form (/#sub-read () READ-STREAM)))
     (if (cond ((get 'SHARPCONDITIONALS 'VERSION) 
		(let ((SI:FEATUREP? 'SI:/#+OR-READ))
		  (si:featurep? 
		      test 
		      (si:get-feature-set TARGET-FEATURES 'SI:/#+OR-READ) 
		      polarity)))
	       ((/#+--test-for-feature test) polarity)
	       ('T (not polarity)))
	 (list form))))


(defsharp /M SPLICING (()) (SI:/#+OR-READ 'MacLISP 'T))
(defsharp /N SPLICING (()) (SI:/#+OR-READ 'NIL 'T))
(defsharp /Q SPLICING (()) (SI:/#+OR-READ 'LISPM 'T))


(defsharp /O (c) 
   (/#-bs-reader c 3 'O))

(defsharp /X (c) 
   (/#-bs-reader c 4 'X))

#M (progn 'compile 
(defprop function (lambda () (readmacroinverse |#'|)) grindmacro)
(defprop function readmacroinverse-predict grindpredict)
(or (status macro /#)
    (setsyntax '/# 'SPLICING '+INTERNAL-/#-MACRO))
)

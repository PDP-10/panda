;;; -*- Mode:LISP; IBase:10.; -*-
;;; TTY: Macros for turning echoing of input on/off
;;; For transportability of FASL files, these macros produce
;;; code which is RUNTIME conditionalized
;;; for proper operation on both ITS and TOPS-20.

;;; KMP    ---------	Implementation for ITS
;;; GJC    03-May-81	Added TOPS-20 conditionals
;;; KMP    30-May-81	Made DO-WITH-ECHO-DEFERRED call +INTERNAL-LOSSAGE
;;;			 when tried on a Twenex.
;;; JONL   30-Jun-81    Used SI:GEN-LOCAL-VAR instead of GENSYM
;;; JONL   15-Aug-81    Added def-or-autoloadable for GENTEMP

(HERALD TTY /17)

;;; Normally, when one types characters in full-duplex mode, they are
;;; automatically echoed (printed back on the user's tty) by the 
;;; operating system so that the user can tell what he is typing.
;;; This macro package is designed to allow a person to turn the 
;;; echo on or off in certain contexts by binding the feature.
;;;
;;; Usage:
;;;
;;; (DO-WITH-TTY-ON <body>)  or  (DO-WITH-TTY-OFF <body>)
;;;
;;; <body> is an implicit-PROGN (ie, may be any number of statements)
;;;        which will be executed with the TTY in the requested mode.
;;;
;;; The value returned by the expression is the value returned by the
;;; last form evaluated in <body>.
;;;
;;; Example:
;;;
;;; (DO-WITH-TTY-OFF (TERPRI) (PRINC '|Type a character: |) (TYI))
;;; 
;;; DO-WITH-ECHO-DEFERRED is for when you wish echoing to not happen
;;; until done with a display operation, but don't wish to turn it off
;;; entirely.  The characters typed will be echoed when the form is exited.
;;; (Works only on ITS.)

(include ((lisp) subload lsp))

(EVAL-WHEN (COMPILE)
  (IF (STATUS FEATURE TOPS-20)
      (*LEXPR SYSCALL)))



;;; DO-WITH-TTY-ON
;;;  An implicit-PROGN that runs in TTY-ON mode but restores the tty
;;;  to its original state when done executing.

(DEFUN (DO-WITH-TTY-ON MACRO) (X)
  (LET ((TEMP-VAR (SI:GEN-LOCAL-VAR () "TTY-on")))
    `((LAMBDA (,TEMP-VAR)
	(UNWIND-PROTECT
	 (PROGN
	  (COND ((STATUS FEATURE ITS)
		 (SYSCALL 0. 'TTYSET TYI
			  #%(LOGIOR (CAR ,TEMP-VAR)
				    #o202020202020)
			  #%(LOGIOR (CADR ,TEMP-VAR)
				    #o202020200020)))
		((STATUS FEATURE TOPS-20)
		 (SSTATUS TTY
			  (CAR ,TEMP-VAR)
			  (CADR ,TEMP-VAR)
			  (dpb 1. #o1301 (CADDR ,TEMP-VAR))))) 
	  ,@(CDR X))
	 (COND ((STATUS FEATURE ITS)
		(SYSCALL 0. 'TTYSET TYI
			 (CAR  ,TEMP-VAR)
			 (CADR ,TEMP-VAR)))
	       ((STATUS FEATURE TOPS-20)
		(SSTATUS TTY (CAR ,TEMP-VAR)
			     (CADR ,TEMP-VAR)
			     (CADDR ,TEMP-VAR))))))
      (COND ((STATUS FEATURE ITS)
	     (SYSCALL 3. 'TTYGET TYI))
	    ((STATUS FEATURE TOPS-20)
	     (STATUS TTY))))))

;;; DO-WITH-TTY-OFF
;;;  An implicit-PROGN that runs in TTY-OFF mode but restores the tty
;;;  to its original state when done executing.

(DEFUN (DO-WITH-TTY-OFF MACRO) (X)
  (LET ((TEMP-VAR (SI:GEN-LOCAL-VAR () "TTY-off")))
    `((LAMBDA (,TEMP-VAR)
	(UNWIND-PROTECT
	 (PROGN (COND ((STATUS FEATURE ITS)
		       (SYSCALL 0. 'TTYSET TYI
				#%(LOGAND (CAR ,TEMP-VAR)
					  #o070707070707)
				#%(LOGAND (CADR ,TEMP-VAR)
					  #o070707070707)))
		      ((STATUS FEATURE TOPS-20)
		       (SSTATUS TTY
				(CAR ,TEMP-VAR)
				(CADR ,TEMP-VAR)
				(DPB 0. #o1301 (CADDR ,TEMP-VAR)))))
		,@(CDR X))
	 (COND ((STATUS FEATURE ITS)
		(SYSCALL 0. 'TTYSET TYI
			 (CAR  ,TEMP-VAR)
			 (CADR ,TEMP-VAR)))
	       ((STATUS FEATURE TOPS-20)
		(SSTATUS TTY (CAR ,TEMP-VAR)
			     (CADR ,TEMP-VAR)
			     (CADDR ,TEMP-VAR))))))
      (COND ((STATUS FEATURE ITS) 
	     (SYSCALL 3. 'TTYGET TYI))
	    ((STATUS FEATURE TOPS-20)
	     (STATUS TTY))))))

;;; DO-WITH-ECHO-DEFERRED
;;;  An implicit-PROGN that causes echoing of typeahead to be deferred until
;;;  the form exits.  Any characters not echoed and not read at exit will
;;;  be echoed then.

(DEFUN (DO-WITH-ECHO-DEFERRED MACRO) (X)
  (LET ((TEMP-VAR (SI:GEN-LOCAL-VAR () "TTY-defer")))
    `((LAMBDA (,TEMP-VAR)
	(UNWIND-PROTECT
	 (PROGN
	  (COND ((STATUS FEATURE ITS)
		 (SYSCALL 0. 'TTYSET TYI
			  (CAR ,TEMP-VAR)
			  (CADR ,TEMP-VAR)
			  #%(LOGIOR (CADDR ,TEMP-VAR)
				    #o10000000))))	;%TSNOE,,0
	  ,@(CDR X))
	 (COND ((STATUS FEATURE ITS)
		(SYSCALL 0. 'TTYSET TYI
			 (CAR  ,TEMP-VAR)
			 (CADR ,TEMP-VAR)
			 (CADDR ,TEMP-VAR))))))
      (COND ((STATUS FEATURE ITS)
	     (SYSCALL 3. 'TTYGET TYI))
	    ((STATUS FEATURE TOPS-20)
	     (+INTERNAL-LOSSAGE NIL 'DO-WITH-ECHO-DEFERRED NIL))))))

(def-or-autoloadable GENTEMP MACAID)

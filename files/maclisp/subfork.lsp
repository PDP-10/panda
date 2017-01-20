;;;  SUBFOR    				-*-Mode:Lisp;Package:SI;Lowercase:T-*-
;;; **************************************************************************
;;; ***** MacLISP ****** SUBFORK Manipulation in Twenex **********************
;;; **************************************************************************
;;; ******** (c) Copyright 1982 Massachusetts Institute of Technology ********
;;; **************************************************************************

(herald SUBFORK /58)


(eval-when (eval compile)
  (setq defmacro-for-compiling () defmacro-displace-call () )
  (or (status feature ITS) (defprop LISP20 (LISP) PPN))
  (load '((LISP20) JSYS-TABLE))
  )
 
(declare (fixnum (si:givup-ttyints fixnum fixnum)
		 (tnx-gtjfn notype fixnum)
		 (openf notype fixnum fixnum)
		 (tnx-openf fixnum fixnum)
		 (jsys fixnum fixnum fixnum fixnum fixnum))
	 (*expr tnx-gtjfn tnx-openf)
	 (special SI:TENEXP))

(setq SI:TENEXP (status feature TENEX))
(if (null (getddtsym 'TENEXP))
    (putprop 'TENEXP 
	     (value-cell-location 'SI:TENEXP)
	     'SYM))

(defmacro GET-WORD-LH (x) `(LSH ,x -18.))
(defmacro PUT-WORD-LH (x) `(LSH ,x 18.))
(defmacro XWD (lh rh) `(LOGIOR (PUT-WORD-LH ,lh) ,rh))

(defvst FORK					;Describes a fork
	fname					;Fork's name
	handle					;Fork's handle
	ftiw					;Fork's TIW
	tiw					;Job's TIW
	mode					;Fork's JFNS mode
	cap1					;Fork's capabilities
	cap2 
	ccoc1					;Fork's CCOC
	ccoc2 
	pc 					;program counter
	sourcefile 				;file that loaded fork
	name6 					;fork name in sixbit
	)

;; Fork hacking macros

(defmacro FORKP (file-fork) `(EQ (STRUCT-TYPEP ,file-fork) 'FORK))
(defmacro FORK-GET (fork slotname)
   `(,(implode (append '(F O R K /-) (explode slotname))) ,fork)) 
(defmacro FORK-SET (fork slotname value)
   `(SETVST (,(implode (append '(F O R K /-) (explode slotname))) ,fork) 
	    ,value))


;;;; SUBSYS function

(defun SUBSYS (file-fork ooperation 
		&optional entvec-index (name () namep) quickthaw)
  (let ((handle 0)
	(cap-possible (jsys #.RPCAP #o400000 0 0 2))
	(cap-enabled (jsys #.RPCAP #o400000 0 0 3))
	(operation ooperation))
    (declare (fixnum handle cap-possible cap-enabled))
    (cond ((not (forkp file-fork))
	   (let* ((nms (if (symbolp file-fork)
			   file-fork
			   (namestring file-fork)))
		  (jfn (TNX-GTJFN nms #o100001)))	;Get a JFN
	     (cond ((or (not (eq operation 'START)) (< jfn 1))	;We lose!
		     (setq operation () ))
		   ('T  ;;Create a fork
		      (setq handle (jsys #.CFORK 1_34. 0 0 1)
			    file-fork (cons-a-FORK 
				         HANDLE handle 
					 SOURCEFILE nms 
					 FNAME (or name 
						   (if namep 
						       (copysymbol 'NIL () )))
					 NAME6 (car (pnget name 6))
					 CAP1 cap-possible 
					 CAP2 cap-enabled 
					 PC 0))
		      (jsys #.GET (xwd handle jfn) 0 0 1))))))
    (cond 
       ((null operation)
         (princ '"Can't do " msgfiles)
	 (princ ooperation msgfiles)
	 (princ '" for fork from file" msgfiles)
	 (princ (if (forkp file-fork) 
		    (fork-get file-fork SOURCEFILE)
		    file-fork)
		msgfiles))
       ((let ((ftiw (jsys #.RTIW #o400000 0 0 2))
	      (tiw (jsys #.RTIW -5 0 0 2))
	      (mode (jsys #.RFMOD #o101 0 0 2))
	      (ccoc1 (jsys #.RFCOC #o101 0 0 2))
	      (ccoc2 (jsys #.RFCOC #o101 0 0 3))
	      (tcap-enabled cap-enabled)
	      (my-6bit-name 0)
	      restorep)	    
	  (declare (fixnum ftiw tiw mode ccoc1 ccoc2 jfn tcap-enabled my-6bit-name))
	  (cond ((fork-get file-fork FNAME)  
		  (setq my-6bit-name (jsys #.GETNM 0 0 0 1))
		  (jsys #.SETNM (fork-get file-fork NAME6) 0 0 1)))
	  (setq handle (fork-get file-fork HANDLE))
	  (unwind-protect 
	    (caseq operation
	      (START (setq restorep 'T)
		     (cond (entvec-index 
			     (if (or (not (fixnump entvec-index)) 
				     (< entvec-index 0)
				     (> entvec-index #o77))
				 (error '"Bad entry-vector index" entvec-index))
			     (if (and SI:TENEXP (> entvec-index 1))
				 (setq entvec-index '0)))
			   ('T (setq entvec-index '0)))
		     (setq tcap-enabled (si:givup-ttyints cap-possible 
							  cap-enabled 
							  file-fork 
							  entvec-index)))
	      (CONTINUE (let ((code (get-word-lh (jsys #.RFSTS handle 0 0 1))))
			  (declare (fixnum code))
			  (cond 
			    ((and (not (= 0 (boole 1 code #o400000)))
				   ;; Ha, the 'frozen' bit!
				  (or quickthaw
				      (y-or-n-p '"Frozen subfork -- CONTINUE it?")))
			      (setq code (boole 1 code #o377777))
			       ;;First, be sure fork is stopped, 
			      (jsys #.HFORK handle 0 0 1)
			       ;; and then resume it.
			      (jsys #.RFORK handle 0 0 1)))
			  (cond ((<= code 2)
				  (setq restorep 'T)
				  (setq tcap-enabled (si:givup-ttyints 
						         cap-possible 
							 cap-enabled 
							 file-fork
							 () )))
				('T (error '"Bad RFSTS - SUBSYS" code)
				    (setq file-fork () )))))
	      (KILL  ;Flush the fork
	            (jsys #.KFORK handle 0 0 1))
	      (T (error '"Not a SUBSYS operation" operation)))
	    (if (not (= my-6bit-name 0)) (jsys #.SETNM my-6bit-name 0 0 1))
	    (cond 
	      (restorep 
	         ;; Clean up the process
	        (fork-set file-fork FTIW (jsys #.RTIW #o400000 0 0 2))
		(fork-set file-fork TIW (jsys #.RTIW -5 0 0 2))
		(fork-set file-fork MODE (jsys #.RFMOD #o101 0 0 2))
		(fork-set file-fork CCOC1 (jsys #.RFCOC #o101 0 0 2))
		(fork-set file-fork CCOC2 (jsys #.RFCOC #o101 0 0 3))
		(fork-set file-fork CAP1 (jsys #.RPCAP handle 0 0 2))
		(fork-set file-fork CAP2 (jsys #.RPCAP handle 0 0 3))
		(if (or (= 0 (logand tcap-enabled 1_35.)) 	;SC%CTC
			(= 0 (logand tcap-enabled 1_29.)))	;SC%SCT
		    (jsys #.EPCAP #o400000 
			  cap-possible    
			  (logior tcap-enabled (+ 1_35. 1_29.))
			  1))
		(jsys #.STIW #o400000 ftiw 0 1)
		(jsys #.STIW -5 tiw 0 1)
		(jsys #.EPCAP #o400000 cap-possible cap-enabled 1)
		(jsys #.SFMOD #o101 mode 0 1)
		(jsys #.STPAR #o101 mode 0 1)
		(jsys #.SFCOC #o101 ccoc1 ccoc2 1)
		(fork-set file-fork PC (jsys #.RFSTS handle 0 0 2))
		(let ((status (jsys #.RFSTS handle 0 0 1)))
		  (declare (fixnum status))
		  (if (not (<= (get-word-lh status) 2))
		      (let ((BASE 8.))
			(terpri msgfiles)
			(princ '"Subprocess " msgfiles)
			(princ (fork-get file-fork FNAME) msgfiles)
			(princ '" from file /"" msgfiles)
			(princ (fork-get file-fork SOURCEFILE) msgfiles)
			(princ '"/" terminated abnormally [PC = #o" msgfiles)
			(princ (fork-get file-fork PC) msgfiles)
			(princ '", RFSTS = #o" msgfiles)
			(princ status msgfiles)
			(princ '"]/" msgfiles)
			(if (y-or-n-p '"Try resuming it?")
			    (subsys file-fork ooperation entvec-index name 'T)))))
		)))))))
  file-fork)


;;;; SI:GIVUP-TTYINTS, EXEC, OPENF

(defun SI:GIVUP-TTYINTS (cap-poss-sup cap-superior file-fork startp)
   ;;Make sure we can give up TTY
  (let ((tcap-enabled cap-superior)
	(cap-poss-inf (fork-get file-fork CAP1))
	(cap-inferior (fork-get file-fork CAP2))
	(handle (fork-get file-fork HANDLE)))
    (declare (fixnum tcap-enabled cap-inferior cap-poss-inf))
    (if (or (= 0 (logand tcap-enabled 1_35.)) 	  	;SC%CTC
	    (= 0 (logand tcap-enabled 1_29.)))	  	;SC%SCT
	(jsys #.EPCAP #o400000 
	      (logior cap-poss-sup (+ 1_35. 1_29.))  
	      (setq tcap-enabled (logior cap-superior (+ 1_35. 1_29.)))
	      1))
    (jsys #.STIW #o400000 0 0 1)			;Keep nothing of TTY
    (jsys #.STIW -5 -1 0 1)				;Give everything
     ;;Be sure loser traps back to here 'frozen'.
    (jsys #.EPCAP handle 
	  (boole 2 1_18. cap-poss-inf)  		;SC%FRZ turned off so
	  (boole 2 1_18. cap-inferior)			; i/o errors terminate
	  1)
    (cond (startp 	;;Start fork at position from entry vector
	    (jsys #.SFRKV handle startp 0 1))
	  ('T 		;; or else continue it
	    (jsys #.SFMOD #o101
		  (fork-get file-fork MODE) 0 1)
	    (jsys #.STPAR #o101
		  (fork-get file-fork MODE) 0 1)
	    (jsys #.SFCOC #o101
		  (fork-get file-fork CCOC1)
		  (fork-get file-fork CCOC2)
		  1)
	     ;; (fork-get file-fork PC) should be same as the RFSTS
	     ;; here, since it is the 'PC'.
	    (jsys #.SFORK handle (jsys #.RFSTS handle 0 0 2) 0 1)))
    (jsys #.WFORK handle 0 0 1)
    tcap-enabled))


(defconst *EXEC-FILE* (if (status feature TENEX) 
			  '|<SYSTEM>EXEC.SAV| 
			  (if (status feature TOPS-20) '|<SYSTEM>EXEC.EXE|)))
(defvar *EXEC-FORK* () )

(defun EXEC ()
   ;; Inferior EXEC hack
  (cond (*EXEC-FORK* (subsys *EXEC-FORK* 'CONTINUE))
	('T (setq *EXEC-FORK* (subsys *EXEC-FILE* 'START))))
  () )


(defun OPENF (file openf-mode gtjfn-mode)
  (declare (fixnum openf-mode gtjfn-mode jfn code))
  (let ((jfn 0))
    (do ((code 0 0))
	((and (symbolp file)
	      (>= (setq jfn (TNX-GTJFN file gtjfn-mode)) 1)
	      (>= (setq code (TNX-OPENF jfn openf-mode)) 0)))
      (setq file (error '"Operation failed on file" 
			(list (if (= code 0) 'GTJFN 'OPENF) file)
			'WRNG-TYPE-ARG)))
    jfn))

;;;; LAP code for JSYS calls

(lap-a-list '(
	      (lap JSYS subr)
	      (args JSYS (() . 5))
	      (defsym JSYS #o104000000000)
		      (push p (% 0 0 fix1))
		      (hrrz tt 0 1)		;JSYS number
		      (move t 0 5)		;addr where result will be left
		      (push fxp inhibit)
		      (setom 0 inhibit)
		      (move 1 0 2)		;up to three arguments
		      (move 2 0 3)
		      (move 3 0 4)
		      (tlo tt 0 (jsys 0 0))
		      (xct 0 tt)
		       (move tt tt) 		;noop?******
		      (move tt 0 t)		;get result
		      (setzb 1 2)		;clean up registers used by
		      (movei 3 0)		; JSYS call
		      (jrst 0 intrel)

	      (entry TNX-OPENF subr)
	      (args tnx-openf (() . 2))
		      (push p (% 0 0 fix1))
		      (push fxp inhibit)
		      (setom 0 inhibit)
		      (move 1 0 1)
		      (move 2 0 2)
		      (jsys 0 #.OPENF)
		       (skipa tt 1 0)
		      (setz tt)
		      (setzb 1 2)	;clean up registers of JSYS call
		      (jrst 0 intrel)

	      
	      (entry TNX-GTJFN subr)
	      (args tnx-gtjfn (() . 2))
		      (push p (% 0 0 fix1))
		      (push p a)
		      (push p b)
		      (movei b '7)
		      (call 2 'PNGET)
		      (hrroi 2 1 flp)
		      (movei t 1)	;will always push at least a 0 word
		 tg4   (hlrz tt 0 a)	;Stack up the pname as an asciz 
		       (push flp 0 tt)	; string onto the FLPdl
		       (addi t 1)
		       (hrrz a 0 a)
		       (jumpn a tg4)
		       (push flp (% 0))	;Make sure a zero word, like ASCIZ
		      (push fxp inhibit)
		      (setom 0 inhibit)
		      (movs 1 @ 0 p)	;mode
		      (jsys 0 #.GTJFN)
		       (setz 1)
		      (move tt 1)
		      (setzb 1 2)	;clean up registers of JSYS call
		      (hrl t t)		;pull stacks back to entry level
		      (sub flp t)
		      (sub p (% 0 0 2 2))
		      (jrst 0 intrel)
;;;	RESCAN is a subr of one argument that places the print name
;;;	 of its argument into the TOPS-20 ReScan Buffer.  
;;;	As of 5/26/81, this does nothing on TENEX systems
	      (entry RESCAN subr)
	      (args RESCAN (() . 1))
		      (skipe 0 TENEXP)
		       (jrst 0 rsxit)
	              (movei b '7)
		      (call 2 'PNGET)
		      (setz t)
		 loop   (hlrz tt 0 a)
		        (push fxp 0 tt)
		        (addi t 1)
		        (hrrz a 0 a)
		        (jumpn a loop)
		      (setz tt)
		      (push fxp tt)
		      (addi t 1)
		      (move 1 fxp)
		      (sub 1 t)
		      (addi 1 1)
		      (hrro 1 1)
		      (jsys 0 #.RSCAN)
		       (setz 1)
;;Ryland suggested this mod, which would "activate" the RESCAN line
;;  but for now (8/19/81) this isn't the desired behaviour.
;;		      (setz 1)   ;Do an .RSINI RSCAN now
;;		      (jsys 0 #.RSCAN)
;;		       (setz 1)
;;
		      (move tt 1)
		      (hrl t t)
		      (sub fxp t)
		 RSXIT (movei a '() )
		      (popj p)
		      () 
))

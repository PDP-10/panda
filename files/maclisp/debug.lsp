; -*- Mode:LISP;Lowercase:T-*-

;;; DEBUG ==> Allows user to inspect LISP stack
;;; BT ==> Prints out an indented list of the user functions called
;;; Debugging function for examining stack.
;;; (DEBUG ARG) sets *RSET and NOUUO to arg, thus typical usage is:
;;;	(DEBUG T)
;;;	  T
;;;	(FOO BAR BAZ)
;;;	  ;BKPT *RSET-TRAP
;;;	(DEBUG)
;;;	  ( ...) ==> Top of stack
;;;	D	 ==> Command to debug
;;;	  ( ...) ==> Next to last expression evaluated
;;;	Q	 ==> Back to lisp
;;;	  NIL	 ==> Remember you are still inside breakloop
;;;  Since having *RSET on is innefficient you might want it off, so
;;;	(DEBUG NIL)
;;;  DEBUG of no arguments prints (with the PRINLEVEL set to 4. and
;;; 	PRINDEPTH to 3.)  Last S-Expression evaluated and 
;;;     waits for character input (no need to type SPACE after characters).
;;; Options are:
;;; D -- Down stack
;;; U -- Up stack
;;; B -- Enter break loop
;;; T -- Go to top of stack
;;; Z -- Go to bottom of stack
;;; P -- Print current level.  If given arg, always print.
;;; S -- Sprinter current level.  If given non-zero arg, always sprinter.
;;; > -- Sets debug-prinlength to arg
;;; ^ -- Sets debug-prinlevel to arg
;;; A -- Print indented list of all user calls, compiled or no.  Uses BAKLIST
;;; V -- Print indented list of all visible calls. (from current loc down).
;;; E -- Evaluate and print an S-expression.
;;; C -- Continue execution from current level (asks for verification)
;;; R -- return value (asks for verification)
;;; Q -- Quit
;;; ^S -- Flush output at interrupt level, turn it on at top-level
;;; ? -- Type this stuff
;;; <number> -- argument for following command.
;;;
;;; The form under evaluation is the value of the special variable
;;; *CURSOR*, and may be modified in a break loop to cause the continue
;;; command to continue with it, or may be output to be edited, etc...
;;; The entire EVALFRAME is the value of the variable *FRAME*
;;;
;;; There are a few options which can be controlled, say in your init file:
;;; DEBUG-PRINLEVEL	default 3	-- Initial value for PRINLEVEL
;;; DEBUG-PRINLENGTH	default 4	-- Initial value for PRINLENGTH
;;; DEBUG-PRIN1		default ()	-- If non-null, alternate printer
;;; DEBUG-SPRINTER-MODE default ()	-- If non-null, GRIND sexpressions
;;; DEBUG-INDENT-MAX	default 50.	-- Max depth for A, V options
;;; DEBUG-PROMPT	default DBG>	-- What to prompt with
;;; DEBUG-FRAME-SUPPRESSION-ALIST
;;;			default ()	-- An alist of functions-names and
;;;					   functions of one argument.  The
;;;					   one argument will be an internal
;;;					   frame-object, which can be given
;;;					   a SUPPRESSED property if it is to
;;;					   be suppressed.  Any number of frames
;;;					   can be suppressed by this mechanism.
;;;					   The function should return the last
;;;					   frame suppressed.

(herald DEBUG /69)

(eval-when (eval load)			;We need GRINDEF now
  (or (get 'grindef 'version)
      (funcall autoload `(grindef . ,(get 'grindef 'autoload))))
  (or (get 'FORMAT 'version)
      (funcall autoload `(FORMAT . ,(get 'FORMAT 'AUTOLOAD))))
)

(eval-when (eval compile)
  (setsyntax '/# 'splicing '+internal-/#-macro))

(declare (genprefix debug)) 

(defvar *CURSOR*)
(defvar *FRAME*)
(defvar *TOP-FRAME*)
(defvar *BOTTOM-FRAME*)

(declare (own-symbol debug back-trace	;We load DEBUG into the compiler
		     bt debug-printer *readch2 back-trace print-frame))

(declare (*lexpr debug back-trace bt sprin1 debug-printer debug-print-frame
		 debug-frame-printer
		 y-or-n-p))

(eval-when (eval compile)
   (or (get 'umlmac 'version)
       (load '((LISP) umlmac))))

(declare (special **arg** back-pointers pointer))
(declare (fixnum (*readch2)))

(defvar debug-prinlevel 3)
(defvar debug-prinlength 4)
(defvar debug-prin1 ())
(defvar debug-sprinter-mode ())
(defvar debug-indent-max 50.)
(defvar debug-prompt '|DBG>|)

(defvar debug-frame-suppression-alist ())

(defvar debug-suppression-reasons
	'(LET GARBAGE DEBUG-INTERNAL))

(defvar si:ignored-error-funs ())

(or (get 'yesnop 'version)
    (load '((LISP) YESNOP)))


(defvst debug-frame
  next
  previous
  next-interesting
  previous-interesting
  type
  form
  function
  arguments
  bindstk
  callstk
  frame-list
  plist)

(defvst debug-command-spec
  chars
  fun
  doc)

(defprop debug-frame (next previous) suppressed-component-names)

(defvar query-io 't)				;should be set up by YESNOP

(defvar error-io query-io)

(defvar debug-command-list ())

(eval-when (eval compile load)
  (defun debug-name-char (ch)
    (caseq ch
      (#\HELP "Help")
      (#\RETURN "Return")
      (#\TAB "Tab")
      (#\SPACE "Space")
      (#\LINEFEED "Linefeed")
      (#\BACKSPACE "Backspace")
      (#\RUBOUT "Rubout")
      (#\FORM "Form")
      (T (if (> ch #\SPACE)
	     (format () "~C" ch)
	     (format () "^~C" (+ ch #o100))))))
)

(defmacro def-debug-command (chars doc &body fun)
  (if (atom chars)
      (setq chars (ncons chars)))
  (let ((command-fun-sym (symbolconc 'DEBUG-COMMAND-
				     (debug-name-char (car chars)))))
    `(progn 'compile
	    (defun ,command-fun-sym ()
		   ,@fun)
	    (push (cons-a-debug-command-spec
		    CHARS ',chars
		    FUN ',command-fun-sym
		    DOC ',doc)
		  debug-command-list))))

(defun debug-find-command-spec (char)
  (dolist (spec debug-command-list)
    (if (member char (debug-command-spec-chars spec))
	(return spec))))

(defun debug-next-valid-frame (frame)
  (do ((frame (debug-frame-next frame) (debug-frame-next frame)))
      ((null frame))
    (if (not (memq (get (debug-frame-plist frame) 'SUPPRESSED)
		   debug-suppression-reasons))
	(return frame))))

(defun debug-previous-valid-frame (frame)
  (do ((frame (debug-frame-previous frame) (debug-frame-previous frame)))
      ((null frame))
    (if (not (memq (get (debug-frame-plist frame) 'SUPPRESSED)
		   debug-suppression-reasons))
	(return frame))))

(def-debug-command #/D			;Move down (backwards in time)
  "Down to next frame."
  (do ((i (or **arg** 1) (1- i))
       (frame *frame* next)
       (next (debug-next-valid-frame *frame*) (debug-next-valid-frame *frame*)))
      ((or (= i 0) (null next)))
    (declare (fixnum i))
    (setq *frame* next))
  (debug-print-frame *frame* debug-sprinter-mode))

(def-debug-command #/U		;Move up 
  "Up to previous frame."
  (do ((i (or **arg** 1) (1- i))
       (frame *frame* previous)
       (previous (debug-previous-valid-frame *frame*) (debug-previous-valid-frame *frame*)))
      ((or (= i 0) (null previous)))
    (declare (fixnum i))
    (setq *frame* previous))
  (debug-print-frame *frame* debug-sprinter-mode))

(def-debug-command #/T			;Jump back to the top of stack
  "Go to the top of the stack."
  (setq *frame* *top-frame*)
  (debug-print-frame *frame* debug-sprinter-mode))

(def-debug-command #/Z			;Bottom of the stack
  "Go to the bottom of the stack."
  (setq *frame* *bottom-frame*)
  (debug-print-frame *frame* debug-sprinter-mode))

(def-debug-command #/B			;Break in current environment 
  "Enter break loop in the environment of the current frame."
  (eval '(break debug t)
	(debug-frame-bindstk *frame*))
  (debug-print-frame *frame* debug-sprinter-mode))

(def-debug-command #/E			;EVAL!
  "Evaluate and print an S-expression."
  (princ '|valuate:  | error-io)
  (let* ((infile t)
	 (form (errset (eval (read t)
			     (debug-frame-bindstk *frame*))
		       t)))
    (when form
	  (format error-io "~&==>  ")
	  (debug-printer (car form) () ())
	  (terpri error-io))
    (cond ((not (zerop (listen error-io)))
	   (let ((character (tyipeek () error-io)))
	     (if (or (= character #\SPACE)
		     (= character #\RETURN))
		 (tyi error-io)))))))

(def-debug-command #/R			;Force a return from this point
  "Return a value from the current frame."
  (cond ((and (y-or-n-p error-io '|~&>>>RETURN ??|)
	      (progn
		(format error-io
			"~&>>>What should this S-Expression return?  ")
		'T)
	      (errset
		(let* ((infile t)
		       (ret (read T))
		       (ERRSET 'CAR))
		  (freturn (debug-frame-callstk *frame*)
			   (eval ret (debug-frame-bindstk *frame*))))
		T)))
	(t (format error-io "Try again!~%"))))

(def-debug-command #/C			;Just re-evaluates the current S-Exp
  "Continue execution by re-evaluating current frame."
  (cond ((and (y-or-n-p error-io '|~&>>>Continue ??|)
	      (let ((ERRSET 'CAR))
		(fretry (debug-frame-callstk *frame*)
			(debug-frame-frame-list *frame*)))))
	(t  (format error-io '|~&Try again~%|))))

(def-debug-command #/A
  "Print indented list of all user calls, compiled or no."
  (BT 'DEBUG))

(def-debug-command #/V
  "Print indented list of all visible calls, from current frame down"
  (back-trace *frame*))

(def-debug-command #/P
  "Print current level.  If given arg, print without abbreviation."
  (debug-printer (debug-frame-form *frame*)
		 (if (null **arg**) 'long ())))

(def-debug-command #/S
  "SPRINT (grind) current level.  If given non-zero arg, always SPRINT."
  (if (null **arg**) (debug-printer (debug-frame-form *frame*) t)
      (cond ((zerop **arg**)
	     (setq debug-sprinter-mode ())
	     (format error-io "  SPRINT mode OFF~%"))
	    (t (setq debug-sprinter-mode t)
	       (format error-io "  SPRINT mode ON~%")))))

(def-debug-command (#\SPACE #\RETURN #\RUBOUT #^S #^X #^W #^V #^D #^C)	;Let's win!)
  "No-ops."
  (setq ^W ()))  ;No-ops

(def-debug-command #\FORM
  "Clear screen."
  (cursorpos 'c error-io))

(def-debug-command #/^
  "Set DEBUG-PRINLEVEL to argument (or () if no argument)."
  (setq debug-prinlevel **arg**)
  (format error-io "  DEBUG-PRINLEVEL set to ~S~%" **arg**))

(def-debug-command #/>
  "Set DEBUG-PRINLEVEL to argument (or () if no argument)."
  (setq debug-prinlength **arg**)
  (format error-io "  DEBUG-PRINLENGTH set to ~S~%" **arg**))

(def-debug-command #/=
  "Display status of DEBUG-PRINLEVEL, DEBUG-PRINLENGTH, DEBUG-GRIND."
  (format error-io
	  "  ~5TSPRINT mode is ~:[OFF~;ON~]~@
			      ~5TDEBUG-PRINLEVEL = ~S~@
			      ~5TDEBUG-PRINLENGTH = ~S~%"
	  debug-sprinter-mode debug-prinlevel debug-prinlength))

(def-debug-command #/Q
  "Quit DEBUG."
  (*throw 'END-DEBUG 'END-DEBUG))

(def-debug-command (#/? #\HELP)
  "Document DEBUG."
  (cursorpos 'A error-io)
  (princ "Type a character to document, * for all, or ? for general help." error-io)
  (let ((char (debug-upcase (tyi error-io))))
    (caseq char
      (#/* (cursorpos 'C error-io)
	   (debug-print-all-help))
      ((#/? #\HELP)
       (cursorpos 'C error-io)
       (princ "The DEBUG package is entered by calling the DEBUG function with
no arguments, or automatically on error if the SIGNAL package is loaded.
It takes single-character commands to examine the environment of an error.
With it you can determine what functions have called what functions with
what arguments, and what the values of special variables were when those
functions were on the stack.

To use DEBUG, *RSET must be set to T.  In addition, NOUUO should be set
to T and (SSTATUS UUOLINKS) should be done, or many calls to compiled
functions will not be seen by DEBUG.

The basic commands are:
  U -- Up, D -- Down, T -- Top, Z -- Bottom, P -- Print, S -- SPRINT
  Q -- Quit DEBUG
The following operate in the context of the current frame:
  R -- Return a value from the current frame
  C -- Continue (reexecute current frame),
  B -- Break loop, E -- Evaluate
The following control how frames are printed:
  ^ -- set PRINLEVEL, > -- set PRINLENGTH, S -- set use of SPRINTER,
  = -- show switches.
The following provide a brief backtrace listing:
  V -- Calls visible to DEBUG
  A -- All calls, including those not seen due to NOUUO.
The X command works only with SIGNAL to continue or restart from errors.
"
	      error-io))
      (T (cursorpos 'A error-io)
	 (princ (debug-name-char char) error-io)
	 (princ " -- " error-io)
	 (if (debug-digitp char)
	     (princ "Numerical argument to a command" error-io)
	     (let ((cmd (debug-find-command-spec char)))
	       (if cmd
		   (princ (debug-command-spec-doc cmd)
			  error-io)
		   (princ "Not a defined command." error-io))))))))


(defun debug-print-all-help ()
  (dolist (spec (reverse debug-command-list))
    (lexpr-funcall #'format error-io
	"~&~A~@{, ~A~}:"
	(mapcar #'debug-name-char
		(debug-command-spec-chars spec)))
    (if (> (charpos error-io) 7.) (terpri error-io))
    (format error-io "~5T  ~A~%" (debug-command-spec-doc spec))))

(defun debug (&optional (*rset-new () *RSET-p) (ignore-funs '(debug) ignore-funs-p)
			&aux pointer **arg** *top-frame* *bottom-frame*
			(debug-prinlevel debug-prinlevel)
			(debug-prinlength debug-prinlength))
  (cond ((and *rset-p (null ignore-funs-p))	;hack for call from NIL
	 (*rset (nouuo *rset-new))
	 (if *rset-new (sstatus uuolinks)))
	((null (evalframe () )) 'try-setting-*rset)
	('T
	 (setq *top-frame* (debug-parse-all-frames))
	 (debug-analyze-stack *top-frame* ignore-funs)
	 (setq *frame* (or (debug-next-valid-frame *top-frame*) *top-frame*))
	 (do ((frame *top-frame* (debug-frame-next frame)))	;Find bottom frame
	     ((null frame))
	   (setq *bottom-frame* frame))
	 (debug-print-frame *frame* () 'T)	;don't say at top or bottom of stack
	 (*catch 'END-DEBUG
	   (errset
	     (do ((char (*readch2) (*readch2))
		  (spec))
		 (())
	       (declare (fixnum (char)))
	       (if (setq spec (debug-find-command-spec char))
		   (funcall (debug-command-spec-fun spec))
		   (princ '|???| error-io)))
	     T)))))

;;; Reads a character and returns that character as either a 
;;;	number or a symbol.
;;;	It also converts small letters into capitals

(defun *readch2 (&aux help-p)
  (let ((debug-infile infile)
	(infile error-io))			;LISP bug
    (cursorpos 'A error-io)
    (format error-io debug-prompt)
    (do ((char (tyipeek () error-io) (tyipeek () error-io)))
	((not (= char #/())
	 (when (= char #\HELP)  ;Get around LISP bug, TYPEEK forgets HELP
	       (tyi error-io)
	       (setq help-p T)))
	(declare (fixnum char))
      (cursorpos 'x error-io)		;try to erase it
      (cursorpos 'a error-io)
      (tyo #/( error-io)
      (errset
	(let* ((errset 'CAR)
	       (form (read error-io))	;READ with INFILE rebound
	       (infile debug-infile)	;but undo that for the eval (SMURF)
	       (val (eval form (debug-frame-bindstk *frame*))))
	  (when val
		(format error-io "~&==> ")
		(debug-printer val t)))
	T)
      (format error-io debug-prompt))
    (setq **arg** ())
    (do ((char (if help-p #\HELP	;Get around LISP bug, TYIPEEK sucks.
		   (tyi error-io))
	       (tyi error-io)))
	((not (debug-digitp char))  ;Return first non-digit
	 (debug-upcase char))
	(declare (fixnum char))
      (setq **arg** (+ (* (or **arg** 0) 10.) (- char #/0))))))

(defun debug-upcase (char)
  (declare (fixnum char))
  (if (lessp #.(1- #/a) char #.(1+ #/z))
      (- char #.(- #/a #/A))
      char))

(defun debug-digitp (char)
  (declare (fixnum char))
  (lessp #.(1- #/0) char #.(1+ #/9)))


;;;TO GET AROUND JONL'S WEIRD SPELLING

(defprop backtrace baktrace expr) 

;;; This function prints an indented list of functions from the frame
;;; provided

(defun back-trace (&optional (frame (debug-parse-all-frames)))
  (cursorpos 'a error-io)
  (do ((spaces 0 (1+ spaces))
       (frame frame (debug-frame-next frame)))
      ((null frame) 'end)
      (declare (fixnum spaces))
    (debug-frame-printer frame () t spaces)))

;;; THIS FUNCTION PRINTS THE BAKLIST, A LIST OF THE USER FUNCTIONS
;;; CALLED, IN A NICE FORMAT I.E. INDENTED

(defun bt (&optional (until 'BT) &aux (btlist (baklist)))
  (do nil
      ((or (null btlist) (eq (caar btlist) until)))
    (setq btlist (cdr btlist)))
  (cursorpos 'A error-io)
  (do ((btlist (cdr btlist) (cdr btlist))
       (spaces 0 (1+ spaces)))
      ((null btlist) 'END)
      (declare (fixnum spaces))
      (debug-n-spaces spaces)
    (debug-printer (caar btlist) t () )
    (cursorpos 'a error-io)))

;;; This just prints using the user's special print function if
;;; he has one.

(defun debug-printer (X sprinter-mode &optional (terpri-p t) (n-spaces 0))
  (let ((prinlevel (if (eq sprinter-mode 'long) () debug-prinlevel))
	(prinlength (if (eq sprinter-mode 'long) () debug-prinlength)))
     (errset (progn (when terpri-p
			  (cursorpos 'a error-io)
			  (debug-n-spaces n-spaces))
		    (cond ((eq sprinter-mode T) (sprin1 x error-io))
			  (debug-prin1 (funcall debug-prin1 x error-io))
			  (prin1 (funcall prin1 x error-io))
			  (T (prin1 x error-io))))
	     t)
     (if terpri-p (terpri error-io))))

;; Takes a frame pointer, and prints it.

(defun debug-print-frame (frame sprinter-p &optional suppress)
  (when (and (not suppress)
	     (or (null frame) (null (debug-next-valid-frame frame))))
	(format error-io "~&You are at the bottom of the stack.~%"))
  (when (and (not suppress)
	     (or (null frame) (null (debug-previous-valid-frame frame))))
	(format error-io "~&You are at the top of the stack.~%"))
  (setq *frame* frame)
  (setq *cursor* (debug-frame-form frame))
  (debug-frame-printer frame sprinter-p))

(defun debug-n-spaces (n)
  (dotimes (\\ n debug-indent-max)
    (tyo #\SPACE error-io)))


(defun debug-frame-printer (frame sprinter-p
				  &optional (terpri-p 'T) (n-spaces 0)
				  &aux (form (debug-frame-form frame)))
  (if (and (not (atom form))
	   (eq (car form) 'apply)		;APPLY form
	   (not (atom (cdr form)))		;of constant
	   (not (atom (cadr form)))		;#'function format
	   (eq (caadr form) 'FUNCTION)	;prints nicely
	   (not (atom (cddr form)))		;but be sure it is a legal
	   (null (cdddr form)))			;APPLY call
      (let (( ( () (() function) arguments third) form))
	(if terpri-p (cursorpos 'A error-io))
	(debug-n-spaces n-spaces)
	(princ "(APPLY #'" error-io)
	(debug-printer function sprinter-p () (+ 9. n-spaces))
	(terpri error-io)
	(debug-n-spaces (+ 7 n-spaces))
	(when (and (not (atom arguments))
		   (eq (car arguments) 'QUOTE)
		   (not (atom (cdr arguments)))
		   (null (cddr arguments)))
	      (tyo #/' error-io)
	      (setq arguments (cadr arguments)))
	(debug-printer arguments sprinter-p () (+ 8. n-spaces))
	(when third
	      (terpri error-io)
	      (debug-n-spaces (+ 7 n-spaces))
	      (debug-printer third sprinter-p () (+ 7 n-spaces)))
	(tyo #/) error-io)
	(if terpri-p (terpri error-io)))
      (debug-printer form sprinter-p terpri-p n-spaces)))

(defun debug-parse-frame (frame)
  (let (( (type callstk form bindstk) frame)
	(plist (ncons 'DEBUG-FRAME-PLIST)))
    (caseq (car frame)
      (APPLY (let (( (function arguments) form))
	       (cons-a-debug-frame
		 TYPE type
		 FUNCTION function
		 ARGUMENTS arguments
		 FORM `(apply #',function
			      ',arguments)
		 CALLSTK callstk
		 BINDSTK bindstk
		 PLIST plist
		 FRAME-LIST frame)))
      (EVAL (if (eq (car form) 'MACROEXPANDED)
		(setq form (cadddr form)))
	    (cons-a-debug-frame
	      TYPE type
	      FORM form
	      CALLSTK callstk
	      BINDSTK bindstk
	      PLIST plist
	      FRAME-LIST frame)))))

(defun debug-parse-all-frames ()
  (do ((frame (evalframe ()) (evalframe (cadr frame)))
       (previous-frame () bottom-frame)
       (top-frame)
       (bottom-frame))
      ((null frame) top-frame)
    (setq bottom-frame (debug-parse-frame frame))
    (setf (debug-frame-previous bottom-frame) previous-frame)
    (if (null top-frame)
	(setq top-frame bottom-frame))
    (if previous-frame
	(setf (debug-frame-next previous-frame) bottom-frame))))


(defun debug-analyze-stack (top-frame ignore-frames)
  (do ((frame top-frame (debug-frame-next frame))
       (prev top-frame frame))
      ((null frame)				;start at bottom
       (do ((frame prev (debug-frame-previous frame))
	    (fun) (suppressor-fun))
	   ((null frame))
	 (caseq (debug-frame-type frame)
	   (EVAL (setq fun (if (not (atom (debug-frame-form frame)))
			       (car (debug-frame-form frame)))))
	   (APPLY (setq fun (debug-frame-function frame))))
	 (if (or (memq fun ignore-frames)
		 (memq fun SI:IGNORED-ERROR-FUNS)
		 (eq fun 'debug-parse-all-frames))
	     (putprop (debug-frame-plist frame) 'DEBUG-INTERNAL 'SUPPRESSED)
	     (if (setq suppressor-fun (cdr (assq fun DEBUG-FRAME-SUPPRESSION-ALIST)))
		 (setq frame (funcall suppressor-fun frame))))))))


(defun debug-let-suppressor (frame)
  (let ((previous (debug-frame-previous frame)))
    (if (not (and (eq (debug-frame-type frame) 'EVAL)
		  (eq (debug-frame-type previous) 'EVAL)
		  (not (atom (debug-frame-form previous)))
		  (not (atom (car (debug-frame-form previous))))
		  (eq (caar (debug-frame-form previous)) 'LAMBDA)))
	frame
	(putprop (debug-frame-plist previous) 'LET 'SUPPRESSED)
	previous)))

(push '(LET . debug-let-suppressor) DEBUG-FRAME-SUPPRESSION-ALIST)

(defun debug-garbage-suppressor (frame)
  (putprop (debug-frame-plist frame) 'GARBAGE 'SUPPRESSED)
  frame)

(push '(+INTERNAL-TTYSCAN-SUBR . DEBUG-GARBAGE-SUPPRESSOR)
      DEBUG-FRAME-SUPPRESSION-ALIST)

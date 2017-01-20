;;; RUBOUT    				-*-Mode:Lisp;Package:SI;Lowercase:T-*-
;;; **************************************************************************
;;; ***** MACLISP ****** A Rubout Handler Using SFA'a and CURSORPOS **********
;;; **************************************************************************
;;; ******** (c) Copyright 1981 Massachusetts Institute of Technology ********
;;; **************************************************************************

(herald RUBOUT /27)

#-NIL (include ((lisp) subload lsp))

#-NIL 
(eval-when (eval compile)
  (subload SHARPCONDITIONALS)
)

#+(local MacLISP)
(eval-when (eval compile)
  (subload MACAID)
  (subload UMLMAC)
  (subload TTY)
  )

#+(or LISPM (and NIL (not MacLISP)))
(progn (globalize "RUBOUT-STREAM")
       (globalize "READ")
       (globalize "RUBOUT-HANDLER")
       (globalize "RUBOUT-EDITOR")
       (globalize "DEF-RUBOUT-ACTION")
       (globalize "DEF-LINED-ACTION")
       )



;;;; Documentation 


;;; This file provides several macros and functions useful for 'rubout' service
;;;  when typing input from a CRT terminal; it will also create one such stream
;;;  as the value of the variable RUBOUT-STREAM, which is suitable for passing
;;;  to READ, READLINE, etc.
;;; The base level TTY is obtained by (STATUS TTYIFA) in MacLISP, and
;;;  from TERMINAL-IO in NIL/LISPM.  Other rubout-handling streams may
;;;  be cons'd up with the call
;;;	(cons-a-RUBOUT-STREAM TTIS <tty-stream>)
;;;  where <tty-stream> is any input stream with a bi-directional correspondent
;;;  [i.e., the (status ttycons <tty-stream>) ] for output, and which can
;;;  handle at least the operations of reading cursor position, setting
;;;  cursor postion, advancing to a fresh line, and clearing to end of line.

;;; If the system-supplied function CURSORPOS cannot handle the minimal tasks
;;;  	1) of reading the cursor position, 
;;; 	2) of moving to an arbitrary location on the screen, 
;;; 	3) of advancing to a 'fresh' line,  
;;; 	4) of erasing the current position,  
;;; 	5) of clearing from current position to end of current line,  and
;;; 	6) of clearing the whole screen;
;;;  then the user must supply a suitable such function as the value of the 
;;;  global variable CURSORPOS.


;;; A rubout stream, such as to be found in RUBOUT-STREAM, will be a 'sfa' 
;;;  which services both a READ msg and a RUBOUT-HANDLER msg.  This means that
;;;  typing a rubout will not only 'efface' the character off the screen,
;;;  but will ultimately cause a re-READ (or re-WHATEVER).
;;; This RUBOUT-STREAM will have a component called a TTY-RUB-STREAM,
;;;  which handles the buffering-up, editing, and rubbing-out (and consequent
;;;  *throw'ing to cause re-scanning).

;;; A macro, DEF-RUBOUT-ACTION, is provided to help in extending the 
;;;  actions taken during input.   This macro is much like DEFUN, except 
;;;  that in place of the name of the function, you put the "character".   
;;;  Also, an appropriate entry is pushed onto the RUBOUT-ACTIONS list, which 
;;;  is understood to be "actions to be taken when certain characters are
;;;  typed at a rubout-stream".  
;;; A  macro, DEF-LINED-ACTION, pushes an appropriate entry onto the list
;;;  LINED-ACTIONS, so that during a 'line-editing' certain characters cause
;;;  special action.  The 'line-editor' is similar in spirit to the "E" of
;;;  SAIL;  typical actions are:
;;;   		<control-F>	move cursor forward one space
;;;   		<control-H>	move cursor back one space
;;; 		<control-D> 	delete character currently under cursor
;;;		<delete> 	do a 'backspace' and 'control-D' deletion
;;;		<Alt-mode> 	exit the line editor, and re-scan the line
;;;		any-other       character is inserted at that spot

;;; Three returned values are required from the functions defined by 
;;;  DEF-RUBOUT-ACTION:  the first is a list of characters which will be 
;;;  stuffed into the input stream; the second, if non-(), is a function 
;;;  (taking exactly the same arguments) to be run after the main handler 
;;;  has 'straightenend-up' the re-scan sequencing; the third is non-() iff
;;;  some action is taken which necessitates a 're-scanning' of the input
;;;  by the calling reader (such as deleting, adding, or altering some
;;;  already inputted character).  Typically, screen re-positioning must wait 
;;;  until after the characters which were to be rubbed out are actually 
;;;  removed from the input buffer, and the main caller of handler has 
;;;  re-scanned the remaining input.
;;; For examples, see the actual code at the end of this file for the
;;;   lined-actions of #//, #\FF, and #\RUBOUT.


;;;; Structures, Vars, etc.


;;; Most of the components of a TTY-RUB-STREAM are stored in
;;;  a structure called a 'RUBOUTBAG'.


(eval-when (eval compile)
  (setq rub-operations 
	(append '(TYI UNTYI TYIPEEK TYO INIT)
	      #+(or NIL (not Minimal))
		'(INCH OUCH)
	      #-Minimal 
	        '(CLEAR-INPUT LISTEN RUBOUT TTY TTYSCAN TTYINT TTYTYPE TTYSIZE 
		  OSPEED TERPRI LINMOD FILEMODE)))
  (if (featurep 'Minimal) (setq defmacro-for-compiling () ))
  (if (or (featurep 'Minimal) 
	  (and (fboundp 'DEFSTRUCT) (not (get 'DEFVST 'VERSION))))
      (set-feature 'Using-DEFVST)
      (progn (defmacro DEFSTRUCT (&rest w) `(DEFVST ,.w))
	     (set-nofeature 'Using-DEFVST)))

)

;; DEFVST will just ignore the ":type" option in the namelist

;; A "Two-WAy List" structure, for moving forwards and backwards on it
(defstruct (TWAL (:type :tree) :named)
   DATA 	
   CDR 
   UNCDR)

;; A bag of all items needed for rubout processing in a stream
(defstruct (RUBOUTBAG (:type :tree) :named)
  (TTIS () )		;Actually, filled in explicitly at creation time
  (TTOS () ) 		;Ditto. Will be the TTYCONS of the TTIS slot.
  BUFFER  		;A TCONC of character items typed.
  PUTBACKLIST 		;For helping with UNTYI
  RESCANLIST 		;After finishing rubbing, we scan down the buffer
  KILLEDCHARS 		;Save a list of chars 'rubbed-out' in one sequence
  NEEDSRESCANP 		;One or more rubouts in a row necessitate a rescanning.
  RUBBERS 		;Two-way reversal of bufferlist, to help rubbing out.
  (PROMPTFUN #'si:TTY-RUB-PROMPT)
  (STREAM () )		;Back-ptr to stream using this bag.
  )

(defmacro SI:BUFFER-LIST (cell) `(CAR ,cell))
(defmacro SI:BUFFER-LAST (cell) `(CDR ,cell))
(defmacro RUBOUTBAG-bufferlist (bag) `(SI:BUFFER-LIST (RUBOUTBAG-buffer ,bag)))
(defmacro RUBOUTBAG-bufferlast (bag) `(SI:BUFFER-LAST (RUBOUTBAG-buffer ,bag)))



(defvar RUBOUT-ACTIONS () 
  "A-List of characters and functions-to-run, for characters with
   special meaning to the input phase of the rubout handler.")

(defvar LINED-ACTIONS () 
  "A-List of characters and functions-to-run, for characters with
   special meaning to the 'line-editor' in the rubout handler.")


;;; RUBOUT-ACTIONS and LINED-ACTIONS will be extended by calls 
;;;  to DEF-RUBOUT-ACTION and DEF-LINED-ACTION below.


(defvar SI:TTY-RUB-WOP-LIST  '#.rub-operations 
  "These are the operations implemented by the lower-level stream.")

(defvar SI:RUBOUT-NOTTOPLEVELP ()  
  "So that RUBOUT-STREAM-HANDLER can know re-entrant calls to READ.")



;;;; Macros and Emulations -- How to do these in real NIL ??


(eval-when (eval compile) 
  (setq defmacro-for-compiling () ) 
)


#-NIL (progn 'COMPILE 

;; LISPM and MacLISP use small fixnums as 'characters'
(defmacro INCH (&rest w) `(TYI ,.w))
(defmacro OUCH (&rest w) `(TYO ,.w))
(defmacro CHAR-EQ (x y) `(= ,x ,y))

;; So what will the real NIL do for creating these objects?
(defmacro SI:MAKE-TTY-RUB-STREAM (fun size)
  `(SFA-CREATE ,fun ,size 'TTY-RUB-STREAM))
(defmacro TTY-RUB-STREAM-ruboutbag (x) `(SFA-GET ,x 0))

(defmacro SI:MAKE-RUBOUT-STREAM (fun size)
  `(SFA-CREATE ,fun ,size 'RUBOUT-STREAM))
(defmacro RUBOUT-STREAM-real-tty (x) `(SFA-GET ,x 0))

)

#+NIL (progn 'COMPILE 

(defmacro CHAR-EQ (x y) `(EQ ,x ,y))

)


(defmacro cons-a-TTY-RUB-STREAM 
	  (&whole form 
	   &optional keyword (tyichannel (if (status status ttyifa) 
					     '(STATUS TTYIFA)
					     'TYI)))
  (or (memq keyword '(() TTIS)) (error '|Bad args| form))
  (let ((var (si:gen-local-var () "TTYRUB"))
	(bag (si:gen-local-var () "Rub-Bag")))
    `(LET* ((,var (SI:MAKE-TTY-RUB-STREAM #'TTY-RUB-STREAM-HANDLER 1))
	    (,bag (cons-a-RUBOUTBAG TTIS ,tyichannel)))
       (SETF (RUBOUTBAG-ttos ,bag) (STATUS TTYCONS (RUBOUTBAG-ttis ,bag)))
       (SETF (RUBOUTBAG-stream ,bag) ,var)
       (SETF (TTY-RUB-STREAM-ruboutbag ,var) ,bag)
       ,var)))



#-Minimal 
(eval-when (eval compile) 
  (setq defmacro-for-compiling 'T) 
)


(defmacro STREAM-SEND (&rest w) 
  #M `(SFA-CALL ,.w)
  #Q `(FUNCALL ,.w)
  #N `(SFA-CALL ,.w)
    ;;Someday, the NIL case should do  `(SEND ,.w) 
  )



(defmacro cons-a-RUBOUT-STREAM (&whole form &optional keyword tyichannel)
  (or (memq keyword '(() TTIS)) (error '|Bad args| form))
  (if tyichannel (setq tyichannel `(TTIS ,tyichannel)))
  (let ((var (si:gen-local-var () "Rubout-Stream")))
    `(LET ((,var (SI:MAKE-RUBOUT-STREAM #'RUBOUT-STREAM-HANDLER 1)))
       (SETF (RUBOUT-STREAM-real-tty ,var) 
	     (cons-a-TTY-RUB-STREAM ,.tyichannel))
       ,var)))



;;;; TTY-RUB-STREAM-HANDLER

(defun TTY-RUB-STREAM-HANDLER 
	   (stream op data &aux (bag (TTY-RUB-STREAM-ruboutbag stream)))
   (caseq op 
      ((TYI #+(or NIL (not Minimal)) INCH) 
          (setq data (si:trsh-tyi stream data bag))
	#+(or NIL (not Minimal))
	  (and (eq op 'TYI)
	       (not (fixnump data))
	       (setq data (cond #N ((characterp data)
				     (*:character-to-fixnum data))
				   ('T (to-character-n data)))))
	  data)
      (UNTYI 
         (push (cons data () ) (RUBOUTBAG-putbacklist bag))
	 data )
      (TYIPEEK  
         (or (caar (RUBOUTBAG-putbacklist bag))
	     (caar (RUBOUTBAG-rescanlist bag))
	     (let* ((char (inch stream data))
		    (buf (RUBOUTBAG-buffer bag))
		    (last-cell (si:buffer-last buf)))
	       (if (and last-cell (char-eq char (caar last-cell)))
		      ;;Just to be sure that this wasn't a non-echo
		      ;;  action character, that didn't get added.
		   (progn 
		       ;;Move the char from the buffer to the putbacklist
		      (if (null (cdr (si:buffer-list buf)))
			  (si:reset-buffer bag () )
			  (do ((nxt-2-last (si:buffer-list buf) 
					   (cdr nxt-2-last)))
			      ((null (cddr nxt-2-last))
			        (rplacd nxt-2-last () ))))
		      (setf (RUBOUTBAG-putbacklist bag) last-cell)))
	       char)))
      (INIT  (struct-setf (RUBOUTBAG bag) 
		   (needsrescanp () )
		   (putbacklist () )
		   (rescanlist () )
		   (killedchars () )
		   (buffer () ))
	     (funcall (RUBOUTBAG-promptfun bag) (RUBOUTBAG-ttos bag)))
      (WHICH-OPERATIONS SI:TTY-RUB-WOP-LIST)
      ((TYO OUCH) #N (if (and (eq op 'TYO) (not (characterp data)))
			 (setq data (to-character data)))
		  (ouch data (RUBOUTBAG-ttos bag))
		  *:TRUTH)
    #-Minimal
      (RUBOUT  (si:rub-1-out stream () ))
    #-Minimal
      ((CLEAR-INPUT LISTEN)  
        (cond ((eq op 'CLEAR-INPUT)
	        (struct-setf (RUBOUTBAG bag)
		     (putbacklist () )
		     (rescanlist () ))
		(clear-input (RUBOUTBAG-ttis bag))
		(si:redisplay-buffer bag))
	      ((+ (length (RUBOUTBAG-putbacklist bag))
		  (listen (RUBOUTBAG-ttis bag))))))
    #-Minimal
      ((TTY TTYSCAN TTYINT TTYTYPE TTYSIZE OSPEED TERPRI LINMOD FILEMODE)
	   ;; Wow, look at all these [S]STATUS options!
        (si:trsh-status bag op data)
	 ;(TTYCONS ...)	Is a system slot in the SFA, the "XCONS" slot and thus
	 ;  		this status call does not send a message.
	)
      ))




(defun SI:TRSH-TYI (stream char bag)
    "Handle TYI msg for TTY-RUB-STREAM."
   (struct-let (RUBOUTBAG bag)
	       ((pbl  putbacklist)
		(rsl  rescanlist)) 
      (cond (rsl ;;While we are in the state of 're-scanning' a line, 
		 ;; no changes will be made to the buffer list
	         ;;But note that READ'ing may call UNTYI, and thus be
	         ;; putting things on the putbacklist
	     (cond (pbl (pop pbl char)
			(setq char (car char))
			(setf (RUBOUTBAG-putbacklist bag) pbl))
		   ('T  (pop rsl char)
			(setf (RUBOUTBAG-rescanlist bag) rsl)
			(setq char (car char))))
	     char)
	    ((let (action-caused-needrescanp first-after-rubbing inserted-chars  
		   action delayed-action-fun insert-1-char? no-echo)
	        ;;Normal chars, and those from the putbacklist, are 'return'd
	        ;; without any other 'action'.
	       (if (cond 
		     (pbl (pop pbl no-echo)
			  (setq char (car no-echo))
			  (setf (RUBOUTBAG-putbacklist bag) pbl)
			  'T)
		     ('T  ;;At this point, 'char' is the eof-value.
		         (setq char 	(inch (RUBOUTBAG-ttis bag) char)
			       action 	(assoc char RUBOUT-ACTIONS))
			  ;;Chars with 'action' might produce a list of chars
			  ;; to be returned. Or maybe none.
			 (cond ((null action))
			       ('T (multiple-value 
				      (inserted-chars delayed-action-fun action-caused-needrescanp)
				      (funcall (cdr action) stream char))
				   () ))))
		   (setq insert-1-char? 'T))
	         ;;RUBOUTBAG's variable 'needsrescanp' remembers if the 
	         ;; previous char typed caused a 'rescan' request.
	       (cond (action-caused-needrescanp 
		        ;;Announce this fact to the bag asap, in case some
		        ;; lisp error occurs in the subsequent code
		       (setf (RUBOUTBAG-needsrescanp bag) 'T))
		     ((RUBOUTBAG-needsrescanp bag)
		       (setq first-after-rubbing 'T)
		       (si:reset-buffer bag (si:listify-rubbers bag)))
		     ('T ;;(setf (RUBOUTBAG-needsrescanp bag) () )
		         ))
	        ;;Are there any characters to be 'return'd by the stream?
	       (when (cond (insert-1-char?) 
			   (inserted-chars 
			     (pop inserted-chars char)
			     'T))
		     (si:echo-and-tconc char bag no-echo)
		     (when inserted-chars 
			   (setq inserted-chars (mapcar #'LIST inserted-chars))
			    ;; 'putbacklist' really should be null now.
			   (setf (RUBOUTBAG-putbacklist bag) 
				 inserted-chars) ))
	       (if delayed-action-fun (funcall delayed-action-fun stream char))
	       (if first-after-rubbing 
		     ;;Ha! This is the first non-rubout, non-trivial 
		     ;;  character after a sequence of rubouts.  So 
		     ;;   first update the buffer.
		   (force-rescan stream 'T))
	       char)))))




(defun SI:RESET-BUFFER (bag bufl &aux new-buffer)
  "Reset the buffer to the input buffer-list arg."
  (if bufl (setq new-buffer (cons bufl (last bufl))))
  (setf (RUBOUTBAG-buffer bag) new-buffer)
  () )



(defun FORCE-RESCAN (stream hairp &aux (bag (TTY-RUB-STREAM-ruboutbag stream)))
  (setf (RUBOUTBAG-needsrescanp bag) () )
  (if hairp (do ()
		((null (RUBOUTBAG-putbacklist bag)))
	        ;;Cause putbacklist to be transferred to buffer.
	      (inch stream)))
  (struct-setf (RUBOUTBAG bag)
       (rescanlist (RUBOUTBAG-bufferlist bag))
       (rubbers () ))
  (if hairp (si:redisplay-buffer bag))
  (*throw 'RUBOUT-STREAM () ))


;;Car of BUFFER is like ((C1 . (V-POS1 . H-POS1)) (C2 . (V-POS2 . H-POS2)) ...)
;; where the cursorpos (V- and H- positions) are taken before echoing.
;;Cdr of BUFFER points to the last cell in the list, to help TCONCing.


(defun SI:ECHO-AND-TCONC (char bag item &aux (pos (cdr item)))
   "Echo the character just typed, and tack another <char,pos> pair onto the 
     end of the bag's bufferlist.  If 'item' is not (), then the char has 
     already been echo'd.
    Return (<char> <h-pos> <v-pos>)."
  (struct-let (RUBOUTBAG bag)
	      ( (tyoc ttos)  
	        buffer )
     (if (null pos)
	 (progn (setq pos (find-cursor-position tyoc)
		      item (cons char pos))
		(ouch char tyoc) ))
     (if buffer (si:wrap?-check (car (si:buffer-last buffer)) item))
     (setq item (list item))
     (if buffer 
	 (progn  ;;This tacks the item onto the end of the list
		(setf (cdr (si:buffer-last buffer)) item)
		  ;;This updates the 'last-cell' pointer of the buffer.
		(setf (si:buffer-last buffer) item))
	   ;;Ha, create a fresh tconc buffer
	 (setf (RUBOUTBAG-buffer bag) (cons item item)))
    (car item)))


(defun SI:WRAP?-CHECK (oitem item)
  (let (((ochar olineno . ocolno)  oitem)
	((()     lineno .  colno)   item))
    (if (and (not (char-eq ochar #\CR))
	     (not (char-eq ochar #\LF))
	     (> colno 0) 
	     (< colno 12.) 
	     (or (= (1+ olineno) lineno)
		 (and (> olineno 0)
		      (=  lineno 0))))
	  ;;Looks like previous character was typed as a 'wrap-
	  ;; around' at end of line.  So correct its position.
	(rplaca (cdr buffer) `(,ochar ,lineno . 0)))))




(defun si:TTY-RUB-PROMPT (tyoc)
  (cursor-control () 'A tyoc)
  (princ "==>" tyoc))


#-Minimal
(defun SI:TRSH-status (bag op data &aux sstatusp operation-list)
    "Handle various [S]STATUS msgs for TTY-RUB-STREAM."
     ;; Remember, 'data' = () means STATUS, otherwise a list of args 
     ;;  for SSTATUS to use.
  (struct-let (RUBOUTBAG bag)
	      ((in ttis)
	       (out ttos))
      (cond ((eq op 'FILEMODE)
	       ;;(status FILEMODE ...) sends () as "data", so we get the file 
	       ;;  mode of the "output" side of the SFA.
	       ;;(SFA-CALL <foo> 'FILEMODE 'IN) gets input mode, and 
	       ;;  (SFA-CALL <foo> 'FILEMODE 'OUT) gets the output mode.
	      (setq operation-list '(FILEMODE)
		    in (cond ((memq data '(() OUT))  out)
			     ((eq data 'IN)          in)
			     ('T (+internal-lossage 'FILEMODE 
						    'SI:TRSH-status   
						    data)))))
	    ((eq op 'TTYINT)  
	      (desetq (operation-list . sstatusp) data)
	      (let (((char-no . fun?) operation-list)
		    quotifyp)
		(if fun? (setq fun? `(',(car fun?)) quotifyp 'T))
		(if (not (numberp char-no))
		    (setq char-no `',char-no quotifyp 'T))
		(if quotifyp (setq operation-list `(,char-no . ,fun?)))))
	    ('T  ;;For: TTY TTYSCAN TTYTYPE TTYSIZE OSPEED TERPRI LINMOD
	        (cond ((eq op 'TERPRI) (setq in out))
		      ((not (memq op '(TTY TTYSCAN LINMOD)))
		        (if data  
			     ;; Can't SSTATUS on TTYTYPE, TTYSIZE, OSPEED
			    (+internal-lossage 'SSTATUS 
					       'SI:TRSH-status   
					       data))
			(setq in out)))
		(setq operation-list data 
		      sstatusp data)
		(push op operation-list)))
        ;; Note that "in" and the items in the list "data" should be
        ;;  evaluative constants by now -- probably fixnums, or T or ().
      (setq operation-list `(,op ,@operation-list ,in))
      (if sstatusp
	  (apply #'SSTATUS operation-list)
	  (apply #'STATUS operation-list))))






;;;; RUBOUT-STREAM-HANDLER

(defun RUBOUT-STREAM-HANDLER (stream op data)
  (let ((rub-s (RUBOUT-STREAM-real-tty stream)))
    (caseq op 
      ((READ READLINE RUBOUT-HANDLER) 
        (cond ((null SI:RUBOUT-NOTTOPLEVELP) (stream-send rub-s 'INIT () ))
	      ((not (eq SI:RUBOUT-NOTTOPLEVELP stream))
	       (+internal-lossage 'SI:RUBOUT-NOTTOPLEVELP 
				  'RUBOUT-STREAM-HANDLER 
				  stream)))
	(si:do-a-rubout-read stream data))
      (WHICH-OPERATIONS '#,(append '(RUBOUT-HANDLER READ) SI:TTY-RUB-WOP-LIST))
      (T ;; All other msgs are deferred to the sub-stream handler
         (stream-send rub-s op data)))))

(defun SI:DO-A-RUBOUT-READ (stream reader)
  (do-with-tty-off 
      (do ((SI:RUBOUT-NOTTOPLEVELP stream)
	   (ERRSET))
	  (() )
	(*catch 'RUBOUT-STREAM 
		(progn 
		  (errset (return 
			    (if (eq op 'READ)
				(read rub-s)
				(funcall reader rub-s))))
		    ;;If the return didn't happen, then probably the calling
		    ;; reader barfed; so enter the line-editor, and then rescan
		  (si:rubout-editor-1 rub-s))))))



;;; Holds a stream which can be fed to READ.
(defvar RUBOUT-STREAM (cons-a-RUBOUT-STREAM)
  "A SFA which will accept the READ msg, and do the appropriate buffering 
   of characters as they are read.")




;;These two functions may be re-written for NIL.  They check for the user
;; having provided his own 'cursorpos' function as the value of CURSORPOS

(defvar CURSORPOS () 
  "If non-(), the funcall that instead of using system-supplied CURSORPOS.")

(defun CURSOR-CONTROL (pos op stream) 
  (cond (CURSORPOS 
	    (if pos (funcall CURSORPOS (car pos) (cdr pos) stream))
	    (if op  (funcall CURSORPOS op stream)) )
	('T (if pos (cursorpos (car pos) (cdr pos) stream))
	    (if op  (cursorpos op stream)))))

(defun FIND-CURSOR-POSITION (stream)
  (if CURSORPOS 
      (funcall CURSORPOS stream)
      (cursorpos stream)))




;;;; Help for Two-WAy-Lists

#+Using-DEFVST (progn 'COMPILE 

(defmethod* (:PRINT-SELF TWAL-CLASS) (ob stream depth slashifyp)
  (declare (fixnum depth))
  (setq depth (1+ depth))
  (if (and PRINLEVEL (not (< depth PRINLEVEL)))
      (princ SI:PRINLEVEL-EXCESS stream)
      (let ((printer (if slashifyp #'PRIN1 #'PRINC))
	    prev next)
	(princ "#{TWAL:" stream)
	(do ((curr (do ((x (setq prev ob) (TWAL-uncdr (setq prev x))))
		       ((null x) (TWAL-cdr prev)))
		   next)
	     (n (or PRINLENGTH 100000.) (1- n)))
	    ((cond ((or (eq curr ob) (null (setq next (TWAL-cdr curr)))))
		   ((<= n 0) 
		     (princ " " stream)
		     (princ SI:PRINLENGTH-EXCESS stream)
		     'T)) )
	  (declare (fixnum n))
	  (princ " " stream)
	  (funcall printer (TWAL-data curr) stream))
	(princ " $$" stream)
	(do ((curr ob next)
	     (n (or PRINLENGTH 100000.) (1- n)))
	    ((cond ((null (setq next (TWAL-cdr curr))))
		   ((<= n 0) 
		     (princ " " stream)
		     (princ SI:PRINLENGTH-EXCESS stream)
		     'T)) )
	  (declare (fixnum n))
	  (princ " " stream)
	  (funcall printer (TWAL-data curr) stream))
	(princ "}" stream))))

(defmethod* (:PRINT-SELF RUBOUTBAG-CLASS) (ob stream depth slashifyp)
  (declare (fixnum depth))
  (setq depth (1+ depth))
  (if (and PRINLEVEL (not (< depth PRINLEVEL)))
      (princ SI:PRINLEVEL-EXCESS stream)
      (let ((printer (if slashifyp #'PRIN1 #'PRINC))
	    any?)
	(princ "#{RUBOUTBAG:" stream)
	(if (setq tem (RUBOUTBAG-putbacklist ob))
	    (progn (princ " PUTBACKLIST = " stream)
		   (if (null tem) 
		       (princ "()" stream)
		       (funcall printer tem stream))
		   (setq any? 'T)))
	(if (setq tem (RUBOUTBAG-killedchars ob))
	    (progn (if any? (princ "," stream))
		   (princ " KILLEDCHARS = " stream)
		   (if (null tem) 
		       (princ "()" stream)
		       (funcall printer tem stream))
		   (setq any? 'T)))
	(if any? (princ "," stream))
	(princ " NEEDSRESCANP = " stream)
	(if (null (setq tem (RUBOUTBAG-needsrescanp ob))) 
	    (princ "()" stream)
	    (funcall printer tem stream))
	(princ ", BUFFERlist = " stream)
	(if (null (setq tem (RUBOUTBAG-bufferlist ob))) 
	    (princ "()" stream)
	    (funcall printer tem stream))
	(if (setq tem (RUBOUTBAG-rubbers ob))
	    (progn (princ ", RUBBERS = " stream)
		   (if (null tem) 
		       (princ "()" stream)
		       (funcall printer tem stream))))
	(princ " }" stream))))

)


(defun SI:SETUP-RUBBERS (bag &aux curr (prev (cons-a-TWAL DATA () )))
   "Turn the bufferlist of a bag into a TWAL, in reverse order."
  (mapc #'(lambda (x)
	    (setq curr (cons-a-TWAL DATA x UNCDR prev))
	    (setf (TWAL-cdr prev) curr)
	    (setq prev curr))
	(RUBOUTBAG-bufferlist bag))
  (setf (TWAL-cdr prev) (cons-a-TWAL DATA () UNCDR prev))
  curr )

(defun SI:LISTIFY-RUBBERS (bag &aux (rubbers (RUBOUTBAG-rubbers bag)))
   "Listify the TWAL, in reverse order, from the 'rubbers' of the bag."
  (if (null rubbers)
      () 
      (let (l prev)
	  ;;Be sure that the TWAL is at its 'right' end.
	(do ((tem))
	    ((null (setq tem (TWAL-cdr rubbers))))
	  (setq rubbers tem))
	;;Working backwards, listify the data elements
	(do ((curr (TWAL-uncdr rubbers) prev)) 
	    ((null (setq prev (TWAL-uncdr curr))))
	  (push (TWAL-data curr) l))
	l)))


;;;; DEF-RUBOUT-ACTION 

(defmacro DEF-RUBOUT-ACTION (char &rest var-list-body 
				  &aux (fun (gentemp "Rubout-Action")))
  #N (setq char (to-character char))
   `(PROGN 
      'COMPILE 
      (DEFUN ,fun ,.var-list-body)
      (SETQ RUBOUT-ACTIONS (CONS (CONS ,char ',fun) 
				 (DELASSQ ',char RUBOUT-ACTIONS)))))


(def-or-autoloadable GENTEMP MACAID)


(def-rubout-action #\RUBOUT (stream char)
  (si:rub-1-out stream char)
  (values () () 'T))


;; ###### Chech out the TWAL-frobs here for endposts

(defun SI:RUB-1-OUT (stream char &aux (bag (TTY-RUB-STREAM-ruboutbag stream))
				      item)
     ;;Initialize the bag, if this is the first rubout after some
     ;;  non-rubout characters
  (when (not (RUBOUTBAG-needsrescanp bag))
	(if (setq item (si:setup-rubbers bag)) 
	    (si:wrap?-check 
	        (TWAL-data item) 
		(cons () (find-cursor-position (RUBOUTBAG-ttos bag)))))
	(struct-setf (RUBOUTBAG bag)
	     (killedchars () )
	     (rubbers item)
	     (needsrescanp 'T)))
    (struct-let (RUBOUTBAG bag)
		( rubbers
		  (kl killedchars) )
      (when rubbers 
	    (setq item (TWAL-data rubbers)
		  rubbers (TWAL-uncdr rubbers))
	    (when item 
		  (comment ;; This feature may not be all that desirable
			 ;; First, check to see if the rubbed-out char was 
			 ;;  slash'd by an unslashified slash.  If so, the 
			 ;;  two chars must be rubbed out.
		    (when (do ((l rvl (cdr l))
			       (i 0 (1+ i)))
			      ((or (null (caar l)) (not (= (caar l) #//))) 
			       (oddp i)))
			  (push (car item) kl)
			  (pop rvl item))
		    )
		   ;;Set the cursor position back to what it was before, and   
		   ;; then erase that character.
		  (cursor-control (cdr item) 'E (RUBOUTBAG-ttos bag))
		  (push (car item) kl)))
      (cond (rubbers
	        (setf (TWAL-cdr rubbers) () )
		(struct-setf (RUBOUTBAG bag)
		     (rubbers rubbers)
		     (killedchars kl)))
	    ('T (si:reset-buffer bag () )
		(force-rescan stream () )))))





(def-rubout-action #^E (stream char)
  (si:rubout-editor-1 stream)
  (values () #'(lambda (stream ignore) (force-rescan stream 'T)) 'T))


(def-rubout-action #\FF (stream char)
   ;; Hafta wait until needsrescanp is cleaned up before retyping
  (values () #'SI:RBA-FF () ))

(defun SI:RBA-FF (stream char &aux (bag (TTY-RUB-STREAM-ruboutbag stream)))
  (si:rba-ed-ff bag (RUBOUTBAG-bufferlist bag)  () ))

(defun SI:RBA-ED-FF (bag l two-way-listener &aux (tyoc (RUBOUTBAG-ttos bag)))
  (cursor-control () 'C tyoc)
  (funcall (RUBOUTBAG-promptfun bag) tyoc)
  (si:re-echo-buffer l tyoc two-way-listener))



(def-rubout-action #^Q (stream char)
  (let* ((bag (TTY-RUB-STREAM-ruboutbag stream))
	 (tyoc (RUBOUTBAG-ttos bag))
	 (pos (find-cursor-position tyoc))
	 (next-char (prog2 (ouch char tyoc) (inch (RUBOUTBAG-ttis bag) () ))))
    (cursor-control pos 'E tyoc)
    (values (list next-char) () () )))


(def-rubout-action #^R (stream char)
   ;; Hafta wait until needsrescanp is cleaned up before retyping
  (values () #'SI:RBA-^R () ))

(defun SI:RBA-^R (stream char)
  (si:redisplay-buffer (TTY-RUB-STREAM-ruboutbag stream)))


(def-rubout-action #^U (stream char)
  (stream-send stream 'INIT () )
  (*throw 'RUBOUT-STREAM () ))


(def-rubout-action #^Y (stream char)
  (let* ((bag (TTY-RUB-STREAM-ruboutbag stream))
	 (kl (RUBOUTBAG-killedchars bag)))
      ;;Notice that the ^y wasn't echoed
      ;;Enters the most recently killed block of chars into input stream
    (values kl () () )))

		     


(defun SI:REDISPLAY-BUFFER (bag)
   "Goes to an initial spot, and re-echos the current input 'line'."
  (struct-let (RUBOUTBAG bag)
	      ((tyoc ttos) 
	       (buf-l bufferlist))
    (let ((first-item (car buf-l)))
      (if (cdr first-item) 
	  (cursor-control (cdr first-item) () tyoc)
	  (funcall (RUBOUTBAG-promptfun bag) tyoc))
      (si:re-echo-buffer buf-l tyoc () ))))



(defun SI:RE-ECHO-BUFFER (buf-list tyoc two-way-listener &aux item oitem)
   "Echos out the 'buffered-up' characters, and re-sets the saved cursor 
    positions in the buffer-list."
  (do ((l buf-list))
      ((null l) )
    (setq item (if two-way-listener (TWAL-data l) (car l)))
      ;;Set the current cursorposition into the item
    (setf (cdr item) (find-cursor-position tyoc))
       ;;Re-echo the character of the current item
    (ouch (car item) tyoc)
    (if oitem (si:wrap?-check oitem item))
    (setq oitem item)
    (setq l (if two-way-listener 
		(progn (if (not (= (listen two-way-listener) 0))
			   (*throw 'RUBOUT-EDITOR () ))
		       (TWAL-cdr l) )
		(cdr l))))
  () )



;;;; RUBOUT-EDITOR and DEF-LINED-ACTION 


(defun RUBOUT-EDITOR (stream)
  (do () 
      ((and #M (sfap stream) 
	       (memq 'RUBOUT-HANDLER 
		     (stream-send stream 'WHICH-OPERATIONS () ))))
    (setq stream (error "Not a RUBOUT-HANDLER SFA" stream 'WRNG-TYPE-ARG)))
  (setq stream (RUBOUT-STREAM-real-tty stream))
  (si:rubout-editor-1 stream)
  (si:do-a-rubout-read stream () ))


(defun SI:RUBOUT-EDITOR-1 (stream &aux (bag (TTY-RUB-STREAM-ruboutbag stream))
				       saved-^B spot)
   "Assumed that TTY echoing is off."
  (struct-let (RUBOUTBAG bag)
	      ((tyic ttis)
	       (tyoc ttos))
    (cursor-control () 'L tyoc)
    (cursor-control () 'A tyoc)
    (princ "Entering rubout line editor ..." tyoc)
    (tyo #\BELL tyoc)
    (unwind-protect 
      (do-with-tty-off 
        (setq saved-^B (status ttyint 2))
	(sstatus ttyint 2 () )
	 ;;Just incase we 'quit', and then start to rubout.
        (setf (RUBOUTBAG-needsrescanp bag) () )
	(setf (RUBOUTBAG-rubbers bag) (setq spot (si:setup-rubbers bag)))
	(cursor-control (cdr (TWAL-data spot)) () tyoc)
	(do ((ERRSET) (char) (action))
	    (() )
	  (if (*catch 
	        'RUBOUT-EDITOR 
	        (progn 
		   (setq spot () )
		   (errset 
		      (if (setq char (inch tyic)
				action (assoc char LINED-ACTIONS))
			  (if (funcall (cdr action) stream char)
			      (setq spot (RUBOUTBAG-rubbers bag)))
			  (let* ((rubbers (RUBOUTBAG-rubbers bag))
				 (new (cons-a-TWAL 
					   DATA (cons char (find-cursor-position tyoc)) 
					   CDR rubbers
					   UNCDR (and rubbers (TWAL-uncdr rubbers)))))
			    (setf (TWAL-uncdr rubbers) new)
			    (setf (RUBOUTBAG-rubbers bag) new) 
			    (setq spot new))))
		   (if spot 
		       (progn 
			 (cursor-control (cdr (TWAL-data spot)) () tyoc)
			 (si:re-echo-buffer spot tyoc tyic)
			 (cursor-control () 'L tyoc)
			 (cursor-control (cdr (TWAL-data spot)) () tyoc)))
		   () ))
	      (return () ))))
      (if saved-^B (sstatus ttyint 2 saved-^B)))
    () ))




(defmacro DEF-LINED-ACTION (char &rest var-list-body 
				  &aux (fun (gentemp "Lined-Action")))
  #N (setq char (to-character char))
   `(PROGN 
      'COMPILE 
      (DEFUN ,fun ,.var-list-body)
      (SETQ LINED-ACTIONS (CONS (CONS ,char ',fun) 
				 (DELASSQ ',char LINED-ACTIONS)))))

(defvar SI:FETCH-REPEAT-COUNT 1 
  "For upping the repetition count, like ^U in EMACS.")

#+Minimal (eval-when (eval compile) (setq defmacro-for-compiling () ))

(defmacro SI:FETCH-REPEAT-COUNT ()
  `(PROG1 SI:FETCH-REPEAT-COUNT (SETQ SI:FETCH-REPEAT-COUNT 1)))


(defun SI:LINED-MOTION (stream forwardp &aux )
  (let ((bag (TTY-RUB-STREAM-ruboutbag stream)))
    (let ((rubbers (RUBOUTBAG-rubbers bag))
	  (tyoc (RUBOUTBAG-ttos bag))
	  (exit-how (SI:FETCH-REPEAT-COUNT))
	  prev)
      (do ((n exit-how (1- n)))
	  ((cond ((<= n 0))
		 ((null rubbers) (setq exit-how (- exit-how n)) 'T)) )
	(declare (fixnum n))
	(setq prev rubbers 
	      rubbers (if forwardp (TWAL-cdr rubbers) (TWAL-uncdr rubbers))))
      (setf (RUBOUTBAG-rubbers bag) rubbers)
      (if (setq prev (or rubbers prev))
	  (cursor-control (cdr (TWAL-data prev)) () tyoc))
      exit-how)))

(defun SI:LINED-DELETE-NEXT (stream count)
  (declare (fixnum count))
  (let* ((bag (TTY-RUB-STREAM-ruboutbag stream))
	 (rubbers (RUBOUTBAG-rubbers bag))
	 (this-cdr (TWAL-cdr rubbers)))
    (do ((next-cdr))
	((or (null this-cdr) (<= count 0)) )
      (setq next-cdr (TWAL-cdr this-cdr))
      (setf (TWAL-cdr rubbers) next-cdr)
      (setq rubbers this-cdr this-cdr next-cdr ))))


(def-lined-action #^B (stream char)
  (si:lined-motion stream () )
  () )

(def-lined-action #^F (stream char)
  (si:lined-motion stream 'T)
  () )

(def-lined-action #^H (stream char)
  (si:lined-motion stream () )
  () )

(def-lined-action #^D (stream char)
  (si:lined-delete-next stream (SI:FETCH-REPEAT-COUNT))
  'T)


(def-lined-action #^R (stream char)
  'T )

(def-lined-action #\FF (stream char &aux (bag (TTY-RUB-STREAM-ruboutbag stream)))
  (si:rba-ed-ff bag  
		(do ((curr (RUBOUTBAG-rubbers bag) (TWAL-uncdr curr))
		     (ocurr)) 
		    ((null curr) ocurr)
		  (setq ocurr curr))
		(RUBOUTBAG-ttis bag))
  'T )

(def-lined-action #^U (stream char)
  (setq SI:FETCH-REPEAT-COUNT (* SI:FETCH-REPEAT-COUNT 4))
  () )


(def-lined-action #\RUBOUT (stream char)
  (let ((n (si:lined-motion stream () )))
    (si:lined-delete-next stream n))
  'T)

(def-lined-action #\ALT (stream char)
  (*throw 'RUBOUT-EDITOR 'T))
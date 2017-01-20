;;;   EXTHUK			-*-Mode:Lisp;Package:SI;Lowercase:T-*-
;;;   ****************************************************************
;;;   *** MACLISP **** EXTended datatype scheme, compiler helper *****
;;;   ****************************************************************
;;;   ** (c) Copyright 1981 Massachusetts Institute of Technology ****
;;;   ****************************************************************

(herald EXTHUK /28)

(include ((lisp) subload lsp))

(eval-when (eval compile)
 (subload EXTMAC)
 )

(eval-when (eval compile load)
  (if (fboundp 'SPECIAL)
      #.`(SPECIAL ,.si:extstr-setup-classes))
)


(defvar SI:SKELETAL-CLASSES () "At least it wont be unbound in Old lisps")

(declare (own-symbol SI:XREF SI:XSET SI:EXTEND-LENGTH 
		     SI:EXTEND SI:MAKE-EXTEND))



(eval-when (eval compile load)
   ;;COMPLR should alread have MACAID pre-loaded
(defun SI:INDEX+2-EXAMINE (h n)
    ;;A helper function for running the SI:XREF/SI:XSET macroexpansions
   (cond ((|constant-p/|| n)
	   (cond ((fixp n) (+ #.si:extend-q-overhead n))
		 ((and (not (atom n))
		       (eq (car n) 'QUOTE)
		       (fixp (cadr n)))
		  (+ #.si:extend-q-overhead (cadr n)))
		 (`(+ #.si:extend-q-overhead ,n))))
	 ((or (|constant-p/|| h) 
	      (and (not (|side-effectsp/|| n)) 
		   (not (|side-effectsp/|| h))))
	  `(+ #.si:extend-q-overhead ,n))))
)

(defun (SI:XREF  MACRO) (x)
   (let* (((() h n) x)
	  (tmp (si:index+2-examine h n)))
     (cond (tmp `(CXR ,tmp ,h))
	   ((let (htmp ntmp)
	      (si:gen-local-var htmp "EX")
	      (si:gen-local-var ntmp "I")
	      `((LAMBDA (,htmp ,ntmp) 
			(DECLARE (FIXNUM ,ntmp))
			(CXR (+ #.si:extend-q-overhead ,ntmp) ,htmp))
		   ,h ,n))))))

(defun (SI:XSET  MACRO) (x)
   (let* (((() h n val) x)
	  (tmp (si:index+2-examine h n)))
     (cond (tmp `(RPLACX ,tmp ,h ,val))
	   ((let (htmp ntmp)
	      (si:gen-local-var htmp "EX")
	      (si:gen-local-var ntmp "I")
	      `((LAMBDA (,htmp ,ntmp) 
			(DECLARE (FIXNUM ,ntmp))
			(RPLACX (+ #.si:extend-q-overhead ,ntmp) ,htmp ,val))
		   ,h ,n))))))

(defun (SI:EXTEND-LENGTH  MACRO) (x)
   `(- (HUNKSIZE ,(cadr x)) #.si:extend-q-overhead))
(putprop 'EXTEND-LENGTH (get 'SI:EXTEND-LENGTH 'MACRO) 'MACRO) 

(defun (SI:EXTEND  MACRO) (x) 
   `(HUNK '**SELF-EVAL** ,@(cddr x) ,(cadr x)))
(defun (SI:MAKE-EXTEND  MACRO) (x)
    ;; This function MUST be available as a macro, so that the 
    ;;  output of DEFVST doesn't require the whole world!
   (let (((() size class) x) 
	 v)
     (si:gen-local-var v "EX")
     `(LET ((,v (MAKHUNK (+ ,size #.si:extend-q-overhead))))
	(SETF #%(SI:EXTEND-CLASS-OF ,v) ,class)
	(SETF #%(SI:EXTEND-MARKER-OF ,v) '**SELF-EVAL**) 
	,v)))



;;Watch out for bootstrapping problems if SI:CLASS-INSTANCE-SIZE should 
;;  ever change, or if ever EXTSTR-USERATOMS-HOOK is to be applicable
;;  to objects other than hunks

(defun EXTSTR-USERATOMS-HOOK (obj &aux (hnp (hunkp obj)))
  (declare (special SI:SKELETAL-CLASSES))
  (cond ((not hnp) () )		;all EXTENDs are hunks!!
	((and (= (hunksize obj) 
		 #.(+ si:class-instance-size si:extend-q-overhead))
	      (eq (si:extend-marker-of obj) SI:CLASS-MARKER)
	      (if (fboundp 'CLASSP) 
		  (and (classp obj)
		       (memq (si:class-name obj) '#.si:extstr-setup-classes))
		  #.`(OR ,.(mapcar #'(lambda (x) `(EQ OBJ ,x)) 
				   si:extstr-setup-classes))))
	 `((GET ',(si:class-name obj) 'CLASS)))
	((and SI:SKELETAL-CLASSES (assq obj SI:SKELETAL-CLASSES))
	   ;; Do we ever really want to get ourselves in this predicament?
	  (let ((frob (assq obj SI:SKELETAL-CLASSES)))
	    `((OR (GET ',(si:class-name obj) 'CLASS)
		  (AND (GET 'EXTSTR 'VERSION)
		       (SI:DEFCLASS*-2 ',(si:class-name obj)
				       ',(si:class-typep obj)
				       ',(si:class-var obj)
				       ',(cadr frob)))))))
	((and (fboundp 'EXTENDP) (extendp obj)) (send obj 'USERATOMS-HOOK))))

(and (boundp 'USERATOMS-HOOKS)
     (or (memq 'EXTSTR-USERATOMS-HOOK USERATOMS-HOOKS)
	 (push 'EXTSTR-USERATOMS-HOOK USERATOMS-HOOKS)))


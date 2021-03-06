;;;   DESCRI			 	  		  -*-LISP-*-
;;;   ***************************************************************
;;;   *** MACLISP ******** DECRIBE Function *************************
;;;   ***************************************************************
;;;   ** (C) COPYRIGHT 1981 MASSACHUSETTS INSTITUTE OF TECHNOLOGY ***
;;;   ****** THIS IS A READ-ONLY FILE! (ALL WRITES REVERSED) ********
;;;   ***************************************************************


(herald DESCRIBE /3)

(declare (setq USE-STRT7 'T MACROS () ))

(defun LISPDIR macro (x)
     `(QUOTE ((LISP) ,(cadr x) #+Pdp10 FASL)))

(defun SUBLOAD macro (x)
   (setq x (cadr x))
   `(OR (GET ',x 'VERSION) (LOAD #%(lispdir ,x))))


(eval-when (eval compile)
  (subload UMLMAC)
   ;; Remember, EXTMAC down-loads CERROR
  (subload EXTMAC)
 )


(eval-when (eval load compile)
  (subload EXTEND)
)


;;;; DESCRIBE -- Function and methods

(defun DESCRIBE (x &optional (stream STANDARD-OUTPUT))
  (send x 'DESCRIBE stream 0)
  '*)

(defmethod* (DESCRIBE object-class)  (object &optional (stream STANDARD-OUTPUT)
					     (level 0))
  (if (extendp object)
      (si:describe-extend object stream level)
      (si:describe-maclisp-object object stream level)))

(defun SI:describe-extend (object stream level)
  (format stream '|~&~vTThe object at #~O of class ~S~:[ (type ~S),
~vT~;~*~*, ~]and is ~D Q's long.~%|
	  level (maknum object) (si:class-name-careful (class-of object))
		(eq (si:class-name-careful (class-of object)) (type-of object))
		(type-of object)
	  level (hunksize object)))


(defun SI:describe-maclisp-object (object stream level)
  (let ((prinlevel 3) (prinlength 4))
    (format stream '|~&~vT~S is a ~S~%|
	    level object (type-of object))))

(defvar SI:DESCRIBE-MAX-LEVEL 6)	;Describe up to 3 levels deep

(defvar SI:DESCRIBE-IGNORED-PROPS '(SUBR FSUBR LSUBR EXPR FEXPR MACRO))

(defmethod* (DESCRIBE symbol-class) (sym &optional (stream STANDARD-OUTPUT)
					 (level 0))
  (unless (not (= level 0))      
    (unless (> level si:describe-max-level) 
      (cond ((boundp sym)
	     (let ((prinlevel 2) (prinlength 3))
	       (format STANDARD-OUTPUT 
		       '|~&~vTThe value of ~S is ~S| level sym (symeval sym)))
	     (send (symeval sym) 'describe stream (+ 2 level))))
      (cond ((getl sym '(SUBR FSUBR LSUBR EXPR FEXPR MACRO))
	     (let ((prinlevel 2) (prinlength 3))
	       (format STANDARD-OUTPUT 
		       '|~&~vT~S is defined as a ~S; Args: ~S|
		       level sym (car (getl sym '(EXPR FEXPR LSUBR SUBR FSUBR
						       MACRO AUTOLOAD)))
		       (args sym)))))
      (do ((pl (plist sym) (cddr pl))
	   (prinlevel 2)
	   (prinlength 3))
	  ((null pl))
	(unless (memq (car pl) si:describe-ignored-props)
		(format STANDARD-OUTPUT '|~&~vT~S has property ~S: ~S|
			level sym (car pl) (cadr pl))
		(send (cadr pl) 'DESCRIBE stream (+ 2 level)))))))




(defmethod* (DESCRIBE class-class)  (class &optional (stream STANDARD-OUTPUT)
					  (level 0))
  (format stream '|~&~vTThe class ~S has TYPEP of ~S
~vTDocumentation:  ~:[[Missing]~;~4G~A~]
~vTSuperiors: ~S
~vTClass-var:  ~S
~vTPlist:  ~S|
	  level class (si:class-typep class)
	  level (si:class-documentation class)
	  level (si:class-superiors class)
	  level (si:class-var class)
	  level (cdr (si:class-plist class)))
  (format stream '|
~vTMethods:  ~:[[None]~;~1G~{~S ~}~]|
	  level (do ((methods (si:class-methods class)
			      (method-next methods))
		     (ll () (cons (method-symbol methods) ll)))
		    ((null methods) (nreverse ll))))
  (mapc #'(lambda (class)
		  (send class 'describe stream (+ 2 level)))
	(si:class-superiors class)))



;;;; WHICH-OPERATIONS function


(defun WHICH-OPERATIONS (class &aux methods-seen (object class))
  (declare (special methods-seen))
  (unless (classp object)
	  (setq class (class-of object))
	  (format STANDARD-OUTPUT 
		  '|~&[~S is of class ~S]~%| object class))
  (mapc #'(lambda (meth)
	      (unless (memq (car meth) methods-seen)
		      (push (car meth) methods-seen)
		      (format STANDARD-OUTPUT 
			      '|~&~S~18T ==> ~S~52T in ~S~%|
			      (car meth) (cadr meth)
			      (si:class-name-careful (caddr meth)))))
	(si:operations-list class))
  () )

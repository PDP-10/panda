;;;  UMLMAC    				-*-Mode:Lisp;Package:SI;Lowercase:T-*-
;;;  *************************************************************************
;;;  ***** MacLISP ******* Utility MacLisp MACros ****************************
;;;  *************************************************************************
;;;  ** (c) Copyright 1981 Massachusetts Institute of Technology *************
;;;  *************************************************************************

(herald UMLMAC /35)

(include ((lisp) subload lsp))


(eval-when (eval compile)
    (setq defmacro-for-compiling 'T defmacro-displace-call MACROEXPANDED)
    (mapc #'(lambda (x) (putprop x 'T 'SKIP-WARNING))
	  '(SELECTQ STRUCT-LET STRUCT-SETF))
    (subload LOOP)
)

;;;; MSETQ-..., for backwards compatibility
;;;; BIT-<TEST,SET,CLEAR>,  WHEN, UNLESS, 


(defmacro MSETQ-CALL (&rest w) 	  `(MULTIPLE-VALUE ,.w))
(defmacro MSETQ-RETURN (&rest w)  `(VALUES ,.w))


(DEFBOTHMACRO BIT-TEST (X Y) `(NOT (= (BOOLE 1 ,X ,Y) 0)))
(DEFBOTHMACRO BIT-SET (X Y) `(BOOLE 7 ,X ,Y))
(DEFBOTHMACRO BIT-CLEAR (X Y) `(BOOLE 2 ,X ,Y))


(DEFMACRO WHEN (P . C) `(COND (,P . ,C)))
(DEFMACRO UNLESS (P . C) `(COND ((NOT ,P) . ,C)))

(def-or-autoloadable GENTEMP MACAID)
(def-or-autoloadable SYMBOLCONC MACAID)


;;;; SELECTQ

(defvar SI:SELECTQ-TYPE-TESTERS '((FIXNUM . =) (BIGNUM . EQUAL)) )

(defvar SI:SELECTQ-PREDICATES '((FIXNUM . FIXNUMP) (BIGNUM . BIGP) ))

;;; We could all (FLONUM . =$) to SI:SELECTQ-TYPE-TESTERS, and
;;;  (FLONUM . FLONUMP) to SI:SELECTQ-PREDICATES

(defvar SI:SELECTQ-OTHERWISE-KEYWORDS '(T OTHERWISE :OTHERWISE))

(defvar SI:SELECTQ-TYPEP-ALIST)

(defvar SI:SELECTQ-VAR)


(defmacro SELECTQ (key-form &rest clauses &aux types-used tem newclauses)
  (cond 
    ((or (null clauses) (memq (caar clauses) si:selectq-otherwise-keywords))
      `(PROGN ,key-form () ,@(cdar clauses)))
    ('T (loop as clause = (car clauses)
	      as test = (car clause)
	      until (memq test si:selectq-otherwise-keywords)
	      as typed-alist = ()
	      do (loop for key in (cond ((atom test) (list test)) (test))
		       as type = (car (assq (typep key) 
					    si:selectq-type-testers))
		       unless (memq type types-used)
		         do (push type types-used)
		       unless (setq tem (assq type typed-alist))
		         do (push (setq tem (ncons type)) typed-alist)
		       do (nconc tem (list key)))
	         (push (cons typed-alist (cdr clause)) newclauses)
	      while (setq clauses (cdr clauses)))
	(let* ((si:selectq-var (cond ((atom key-form) key-form) 
				     ('T (si:gen-local-var () "Selector"))))
	       (q (selectq-compile-1 newclauses types-used (cdar clauses))))
	  (cond ((eq key-form si:selectq-var) q)
		('T `((LAMBDA (,si:selectq-var) ,q) ,key-form)))))))

(defun SELECTQ-COMPILE-1 (clauses types-used otherwisep)
  (and (equal otherwisep '(())) (setq otherwisep ()))
  (let ((si:selectq-typep-alist ())
	(pre-test ())
	(final-form ())
	(type-vars ())
	(type-vals ())
	(type-inits ()))
    (cond ((and (null (cdr types-used))
		(or (null (car types-used)) (not otherwisep)))
	     (or (null (car types-used))
		 (setq pre-test `(,(cdr (assq (car types-used)
					      si:selectq-predicates))
				  ,si:selectq-var))))
	  ('T (loop with var = ()
		    for type in types-used
		    when type
		      do (si:gen-local-var var type)
		         (push (cons type var) si:selectq-typep-alist)
			 (push () type-vals)
			 (push var type-vars)
			 (push `(SETQ ,var 
				      (,(cdr (assq type si:selectq-predicates))
				       ,si:selectq-var))
			       type-inits))))
   (loop with nclauses = ()
	 for xclause in clauses
	 do (push (cons (cond ((not si:selectq-typep-alist)
			         (selectq-one-hairy-predicate (caar xclause)))
			      ('T (selectq-hairy-predicate (car xclause))))
			(or (cdr xclause) '(())))
		  nclauses)
	 finally (and otherwisep (nconc nclauses (list `('T ,@otherwisep))))
		 (setq final-form (cons 'cond nclauses)))
    (and pre-test (setq final-form `(and ,pre-test ,final-form)))
    (cond ((not (null (cdr type-inits))) (push 'OR type-inits))
	  ('T (setq type-inits (car type-inits))))
    `((LAMBDA ,type-vars ,type-inits ,final-form) ,@type-vals)))


(defun SELECTQ-HAIRY-PREDICATE (type-alist &aux untyped)
  (loop with clauses = ()
	for entry in type-alist
	do (cond ((not (null (car entry)))
		    (push `(,(cdr (assq (car entry) si:selectq-typep-alist))
			    ,(selectq-one-hairy-predicate entry))
			  clauses))
		 ('T (setq untyped entry)))
	finally (and untyped
		     (push (ncons (selectq-one-hairy-predicate untyped))
			   clauses))
		(return (cond ((cdr clauses)  `(COND ,.(nreverse clauses)))
			      ((cdar clauses) `(AND ,.(car clauses)))
			      ('T             (caar clauses))))))

(defun SELECTQ-ONE-HAIRY-PREDICATE (entry)
  ; Consider optimizing MEMQ.
  (loop with fn = (or (cdr (assq (car entry) si:selectq-type-testers)) 'eq)
	for k in (cdr entry)
	collect `(,fn ,si:selectq-var ',k) into preds
	finally (return (cond ((cdr preds) `(OR ,.preds))
			      ('T (car preds))))))


;;;; DOLIST, DOTIMES

(defmacro DOLIST ((var form index) &rest body &aux dummy decls)
   (setq decls (cond ((and body 
			   (not (atom (car body)))
			   (eq (caar body) 'DECLARE))
		      (prog2 () (cdar body) (pop body)))))
   (cond (index (push `(FIXNUM ,INDEX) decls)
		(setq index (ncons `(,INDEX 0 (1+ ,INDEX)) ))))
   (and decls (setq decls  (ncons `(DECLARE ,.decls))))
   (si:gen-local-var dummy)
   `(DO ((,DUMMY ,FORM (CDR ,DUMMY)) (,VAR) ,.index )
	((NULL ,DUMMY))
      ,@decls
      (SETQ ,VAR (CAR ,DUMMY))  ,.BODY))

(eval-when (eval compile)
    (setq defmacro-for-compiling 'T defmacro-displace-call 'T)
)


;Repeat a number of times.  <count> evaluates to the number of times,
;and <body> is executed with <var> bound to 0, 1, ...
;Don't generate dummy variable if <count> is an integer.  We could also do this
;if <count> were a symbol, but the symbol may get clobbered inside the body,
;so the behavior of the macro would change.

(defmacro DOTIMES ((var count) &rest body &aux dummy decls)
   (or var (si:gen-local-var var))
   (and *RSET 
	(do () 
	    ((symbolp var))
	  (setq var (error '|Must be a variable -- DOTIMES| 
			   var  
			   'WRNG-TYPE-ARG))))
   (setq count (macroexpand count))
   (cond ((|constant-p/|| count) 
	   (do ()
	       ((fixnump count)) 
	     (setq count (error '|Must be FIXNUM -- DOTIMES| 
				count 
				'WRNG-TYPE-ARG))))
	 ('T (si:gen-local-var dummy)
	     (psetq dummy `((,dummy ,count))
		    count dummy)))
   (setq decls `(DECLARE 
		   (FIXNUM ,var ,.(and dummy (list count)))
		   ,.(cond ((and body 
				 (not (atom (car body)))
				 (eq (caar body) 'DECLARE))
			     (prog2 () (cdar body) (pop body))))))
   `(DO ((,var 0 (1+ ,var)) ,.dummy)
	((NOT (< ,var ,count)))
	,decls
	,.body))


;;;; STRUCT-LET and STRUCT-SETF 


(eval-when (eval compile)
  (setq defmacro-displace-call '|defvst-construction/||)
)


;;; E.g. (STRUCT-LET (<structure-name> <struct-object-to-be-destructured>)
;;		     ((var slot-name)			; or,
;;		      (var-named-same-as-slot)		; or,
;;		      var-named-same-as-slot 
;;		      ...)
;;		    . body)

(defmacro STRUCT-LET ((struct-name str-obj) bvl &rest body)
   (let (var slot-name accessor)
	(setq bvl (mapcar 
		   #'(lambda (e)
		       (if (atom e) (setq e `(,e ,e)))
		       (desetq (var slot-name) e)
		       (or slot-name (setq slot-name var))
		       (setq accessor (symbolconc struct-name '/- slot-name))
		       `(,var (,accessor ,str-obj)))
		   bvl))
	`(LET ,bvl ,.body)))


;;; E.g. (STRUCT-SETF (structure-name object) (slot-name value) ...)
(defmacro STRUCT-SETF ((str-name str-obj) &rest l &aux slot-name accessor val)
   `(PROGN ,. (mapcar 
	       #'(lambda (x)
		   (if (atom x) (setq x `(,x ,x)))
		   (desetq (slot-name val) x)
		   (setq accessor (symbolconc str-name '/- slot-name))
		   `(SETF (,accessor ,str-obj) ,val))
	       l)))




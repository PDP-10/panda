;;;   SRCTRN 						 -*-LISP-*-
;;;   **************************************************************
;;;   ***** MACLISP *****  (Initialization for COMPLR) *************
;;;   **************************************************************
;;;   ** (C) Copyright 1981 Massachusetts Institute of Technology **
;;;   ****** This is a Read-Only file! (All writes reserved) *******
;;;   **************************************************************


(setq SRCTRNVERNO '#.(let* ((file (caddr (truename infile)))
			   (x (readlist (exploden file))))
			  (setq |verno| (cond ((fixp x) file)  ('/10)))))

;;; Following could be gotten from SUBLOAD 
(EVAL-WHEN (EVAL COMPILE) 
  (defun LISPDIR macro (x)
    `(QUOTE ((LISP) ,(cadr x) FASL)))
)


(EVAL-WHEN (COMPILE) 
     (AND (OR (NOT (GET 'COMPDECLARE 'MACRO))
	      (NOT (GET 'OUTFS 'MACRO)))
	  (LOAD `(,(cond ((status feature ITS) '(DSK COMLAP))
			 ('(LISP)))
		  CDMACS
		  FASL)))
)


(EVAL-WHEN (COMPILE) (COMPDECLARE) (FASLDECLARE) (GENPREFIX |/|st|) )




;;;; SOURCE-TRANS for LISTP, < and >, and bitwise logical operations.


(defun LISTP-FERROR-expander (x &aux (arg (cadr x)))
  (setq x (cond ((eq (car x) 'FERROR) `(CERROR () () ,.(cdr x)))
		((not (eq (car x) 'LISTP)) (barf x LISTP-FERROR-expander))
		((|no-funp/|| (setq arg (macroexpand arg)))
		  `(OR (NULL ,arg) (EQ (TYPEP ,arg) 'LIST)))
		('T (|non-simple-x/|| (car x) arg))))
  (values x 'T))


(defun ML-<>-expander  (form &aux op ex? nargs)
   (cond 
     ((setq op (assq (car form) '((<  . () ) 
				  (>  . () )
				  (>= . <) 
				  (<= . >))))
      (if (or (< (setq nargs (length (cdr form))) 2) (> nargs 510.))
	  (error '|WNA during SOURCE-TRANS expansion| form))
        ;; << is the name of the function -- >> is name of its inversion,
        ;;  if an inversion must be used instead of the name directly.
      (let (((<<  . >>) op)
	    ((a b) (cdr form))
	    c)
	(cond ((= nargs 2)
	         ;; Simple case -- 2 args only
	        (if >> (setq form `(NOT (,>> ,a ,b)) ex? 'T)))	
	      ((and (= nargs 3)
		    (not (|side-effectsp/|| a)) 
		    (not (|side-effectsp/|| b)) 
		    (not (|side-effectsp/|| (setq c (cadddr form)))))
	         ;; Remember |side-effectsp/|| may macroexpand. "between-p",
	        (let* ((bb (if (+INTERNAL-DUP-P b) b (si:gen-local-var)))
		       (body `(AND (,<< ,a ,bb) (,<< ,bb ,c))))
		     ;; Maybe a 'lambda' wrapper?
		   (if (not (eq bb b)) 
		       (setq body `((LAMBDA (,bb) ,body) ,b)))
		   (setq form body ex? 'T)))
	      ('T ;; Must bind all args, even though each one appears only 
		     ;; once; otherwise its code will not get run when a>b.  
		     ;;  "a" must be EVAL'd first!
	       (let ((arglist (cdr form)) ga gb letlist body)
		    (si:gen-local-var ga)
		    (setq letlist `((,ga ,(car arglist))))
		    (mapc #'(lambda (ll) 
			      (si:gen-local-var gb)
			      (push `(,gb ,ll) letlist)
			      (push (cond (>> `(NOT (,>> ,ga ,gb)))
					  ('T `(,<< ,ga ,gb)))
				    body)
			      (setq ga gb))
			  (cdr arglist))
		    (setq form `(LET ,(nreverse letlist)
				     (AND ,.(nreverse body)))
			  ex? 'T)))))))
   (values form ex?))



(defun ML-trans-expander (form &aux (ex? 'T))
   (let ((fun (car form)) 
	 (nargs (length (cdr form)))
	 (oform form)
	 (interval '(1 . 1)) 
	 op)
     (cond ((eq fun 'LOGNOT) 
	    (setq form `(BOOLE 10. ,(cadr form) -1)))
	   ((setq op (cdr (assq fun '((LOGAND . 1) 
				      (LOGIOR . 7) 
				      (LOGXOR . 6)))))
	    (setq interval '(2 . 510.)
		  form `(BOOLE ,op ,.(cdr form))))
	   ((setq op (cdr (assq fun '((FLONUMP . (FLOATP X))
				      (EVENP . (NOT (ODDP X)))))))
	    (setq form (subst (cadr form) 'X op)))
	   ('T (setq ex? () )))
     (and ex? 
	  (or (< nargs (car interval)) (> nargs (cdr interval)))
	  (error '|WNA during SOURCE-TRANS expansion| oform)))
   (values form ex?))


;;;; LOAD-BYTE, LDB, etc

(defmacro SI:PICK-A-MASK (size)  `(LSH -1 (- ,size 36.)))

;; LOAD-BYTE is similar to PDP-10 LDB, but "position" and "size" are separate

(defun FOO-BYTE-EXPANDER  (l)
  (let (((name word position size val) l)
	byte-len byte-mask nval dp)
    (setq word (macroexpand word)  
	  position (macroexpand position)
	  size (macroexpand size))
    (if val (setq val (macroexpand val)))
    (setq dp (eq name 'DEPOSIT-BYTE))
    (cond 
      ((|constant-p/|| size)
       (setq byte-len (eval size))
       (or (and (fixnump byte-len) 
		(not (< byte-len 0))
		(not (> byte-len 36.)))
	   (dbarf l |Bad 'byte-length' specifier|))
       (setq byte-mask (si:pick-a-mask byte-len))
       (setq l 
	  (cond ((= byte-len 0) (if dp `(PROG2 () ,word ,val) ''0))
		((= byte-len 36.) (if dp `(PROG2 ,word ,val) `,word))
		((|constant-p/|| position)
		 (setq position (eval position))
		 (or (and (fixnump position)
			  (not (< position 0)) 
			  (not (> (+ position byte-len) 36.)))
		     (dbarf l |Bad 'position' specifier|))
		 (cond 
		   ((not dp) `(LDB ,(+ (lsh position 6) byte-len) ,word))
		   ('T (setq nval (cond ((|constant-p/|| val) 
					 (logand val byte-mask))
					(`(LOGAND ,val ,byte-mask))))
		       (cond 
			 ((or (fixnump nval)
			      (and (not (|side-effectsp/|| val)) 
				   (not (|side-effectsp/|| word))))
			   `(DPB ,nval ,(+ (lsh position 6) byte-len) ,word))
			 (`(LOGIOR (BOOLE 4 ,word ,(lsh byte-mask position))
				   ,(cond ((fixnump nval) (lsh nval position))
					  (`(LSH ,nval ,position)))))))))
		((not dp) `(LOGAND (LSH ,word (- ,position)) ,byte-mask))
		('T (setq nval (cond ((|constant-p/|| val) 
				      (boole 1 val byte-mask))
				     (`(BOOLE 1 ,val ,byte-mask))))
		    (let ((byte-displ position) 
			  (byte-pos position)
			  (fl (or (not (symbolp position)) 
				  (|side-effectsp/|| nval)))
			  z) 
		      (cond (fl (si:gen-local-var byte-displ)
				(setq byte-pos `(SETQ ,BYTE-DISPL ,position))))
		      (setq z `(LOGIOR (BOOLE 4 ,word (LSH ,BYTE-MASK ,byte-pos))
				       (LSH ,nval ,byte-displ)))
		      (and fl (setq z `(LET ((,BYTE-DISPL 0))
					    (DECLARE (FIXNUM ,BYTE-DISPL))
					    ,z)))
		      z)))))
      ((not (+internal-permutible-p (list word position size val)))
        (setq l (cond (dp `(*DEPOSIT-BYTE ,word ,position ,size ,val))
		      ('T `(*LOAD-BYTE ,word ,position ,size)))))
      ((not dp) 
        (setq l `(LOGAND (LSH ,word (- ,position)) (SI:PICK-A-MASK ,size))))
      ((prog (byte-mask byte-displ bindings more-decls 
	      shifted-mask shifted-byte deposit-zero? action)
	 (si:gen-local-var byte-mask)
	 (setq byte-displ position 
	       deposit-zero? (zero-bytep val)
	       bindings `((,byte-mask (SI:PICK-A-MASK ,size)))
	       shifted-byte (if deposit-zero? 0 `(LOGAND ,val ,byte-mask))
	       shifted-mask byte-mask )
	 (cond ((not (atom byte-displ))
		 (si:gen-local-var byte-displ)
		 (setq more-decls (list byte-displ))
		 (push `(,BYTE-DISPL ,position) bindings)))
	 (cond ((zero-bytep byte-displ))
	       ('T (setq shifted-mask `(LSH ,shifted-mask ,BYTE-DISPL))
		   (if (not deposit-zero?) 
		       (setq shifted-byte `(LSH ,shifted-byte ,BYTE-DISPL)))))
	 (setq action `(BOOLE 4 ,word ,shifted-mask))
	 (if (not deposit-zero?) 
	     (setq action `(LOGIOR ,action ,shifted-byte)))
	 (setq l `(LET ,bindings  
		    (DECLARE (FIXNUM ,BYTE-MASK ,.more-decls))
		    ,action)))))
    (values l 'T)))

(defun ZERO-BYTEP (byte-displ)
  (cond ((not (atom byte-displ)) 
	 (and (eq (car byte-displ) 'QUOTE)
	      (fixnump (cadr byte-displ))
	      (= (cadr byte-displ) 0)))
	((fixnump byte-displ) (= byte-displ 0))))

(defun LDB-expander (l)
  (let* ((dp (eq (car l) 'DPB))
	 val 
	 ((bp word) (cond (dp (setq val (macroexpand (cadr l)))
			      (cddr l))
			  ('T (cdr l)))))
    (setq bp (macroexpand bp))
    (values 
      (cond ((and (not dp) (|constant-p/|| bp)) 
	       ;; Try to optimize LDB with a constant bp
	      (setq bp (eval bp))
	      (let ((byte-len (boole 1 bp #o77)) 
		    (position (boole 1 (ash bp -6) #o77)))
		(or (< position 36.) 
		    (dbarf l |Bad 'position' specifier|))
		(setq word (macroexpand word))
		(cond ((|constant-p/|| word) 
		       `(QUOTE ,(*ldb (lsh bp 24.) (eval word))))
		      ('T (and (not (= 0 position))
			       (setq word `(LSH ,word ,(- position))))
			  `(BOOLE 1 ,word ,(si:pick-a-mask byte-len))))))
	    ((not dp) `(*LDB (LSH ,bp 24.) ,word))
	    ((and (cond ((|constant-p/|| bp) (setq bp (lsh (eval bp) 24.)) 'T)
			('T (setq bp `(LSH ,bp 24.)) () ))
		  (|constant-p/|| val)
		  (or (= (setq val (eval val)) 0)		      ;all 0's
		      (= (*ldb bp -1) (boole 1 (*ldb bp -1) val))))   ;all 1's
	      `(BOOLE ,(if (= val 0) 4 7) 
		      ,word 
		      ,(*dpb -1 bp 0)))
	    (`(*DPB ,val ,bp ,word)))
      'T)))


(mapc 
  #'(lambda (y) 
      (let (((fun . l) y) z)
	(mapc #'(lambda (x)
		  (or (memq fun (setq z (get x 'SOURCE-TRANS)))
		      (putprop x (cons fun z) 'SOURCE-TRANS))
		  (or (getl x '(SUBR LSUBR))
		      (equal (get x 'AUTOLOAD) #%(lispdir MLSUB))
		      (putprop x #%(lispdir MLSUB) 'AUTOLOAD)))
	      l)))
  '((ML-trans-expander LOGAND LOGIOR LOGXOR LOGNOT  FLONUMP EVENP)
    (ML-<>-expander < > <= >= )
    (LISTP-FERROR-expander LISTP FERROR)
    (foo-byte-expander LOAD-BYTE DEPOSIT-BYTE)
    (LDB-expander LDB DPB)))

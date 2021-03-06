;;;  MLSUB    				-*-Mode:Lisp;Package:SI;Lowercase:T-*-
;;;  *************************************************************************
;;;  ***** MACLISP ******* MACLISP-ONLY SUBR's used by MACROS ****************
;;;  *************************************************************************
;;;  ** (c) Copyright 1981 Massachusetts Institute of Technology *************
;;;  *************************************************************************

(herald MLSUB /17)

;;;Contains the open-codings, as SUBRs, of some common MacLISP
;;; macros.  Also has some "helper" functions needed by macro output.

(include ((lisp) subload lsp))

(eval-when (compile)
  (let ((OBARRAY COBARRAY) 
	(x 'SI:ARRAY-HEADERP)
	(y 'P1BOOL1ABLE))
    (unwind-protect 
      (progn (remob 'SI:ARRAY-HEADERP)
	     (remob 'P1BOOL1ABLE)
	     (setq OBARRAY SOBARRAY
		   x (intern 'SI:ARRAY-HEADERP)
		   y (intern 'P1BOOL1ABLE)))
      (setq OBARRAY COBARRAY)
      (intern x)
      (intern y))
    (putprop x (get 'TYPEP 'SUBR) 'SUBR))
)

(eval-when (compile)
   (mapc '(lambda (x) (putprop x 'T 'SKIP-WARNING))
	 '(<= >=  FIXNUMP FLONUMP EVENP LISTP ARRAYP 
	   LOGAND LOGIOR LOGXOR LOGNOT 
	   SI:CHECK-MULTIPLICITIES  MULTIPLE-VALUE-LIST/|  VALUES-LIST ))
   (setq MUZZLED 'T STRT7 'T MACROS () )
   (and (alphalessp (symeval ((lambda (OBARRAY) (intern 'INITIAVERNO))
			       SOBARRAY))
		    "112")
	(+internal-lossage 'INITIAVERNO 'COMPILE INITIAVERNO))
)


(declare (own-symbol HERALD) (mapex () ))
(declare (genprefix |mlsb|) )


;;;; Simple open-coded preds like LOGAND etc as LEXPR's, 

(eval-when (compile)
(defmacro GEN-OPENS (&rest l)
  `(PROGN 
    'COMPILE 
     ,.(mapcar #'(lambda (x) 
		   (or (getl x '(MACRO SOURCE-TRANS)) 
		       (get x 'P1BOOL1ABLE)
		       (+internal-lossage '|Not open-codeable| 'gen-opens x))
		   `(DEFUN ,x (Y) (AND (,x Y) *:TRUTH)))
	       l)))
(defmacro GEN-LOGS (&rest l &aux i n nargs)
   (si:gen-local-var i "i")
   (si:gen-local-var n "n")
   (si:gen-local-var nargs "Nargs")
   `(PROGN 
     'COMPILE 
      ,.(mapcan #'(lambda (x) 
		    (or (getl x '(MACRO SOURCE-TRANS)) 
			(+internal-lossage '|Not open-codeable| 'gen-logs x))
		    `(PROGN 'COMPILE 
			    (DEFUN ,x ,NARGS 
				   (DO ((,I 2 (1+ ,I)) (,N (ARG 1)))
				       ((> ,I ,NARGS) ,N)
				       (DECLARE (FIXNUM ,I ,N))
				       (SETQ ,N (,x (ARG ,I) ,N))))
			    (ARGS ',x '(2 . 510.))))
		l)))
() 
)

(eval-when (eval)
(defun lose-opens (l) 
       (princ '|/Warning! | msgfiles)
       (princ (car l) msgfiles)
       (princ '| can't do these functions interpretively://	| msgfiles)
       (prin1 (cdr l) msgfiles)
       (terpri msgfiles))
(defprop gen-opens lose-opens macro)
(defprop gen-logs lose-opens macro)
() 
)


(gen-opens FIXNUMP FLONUMP EVENP LISTP)

(defun ARRAYP (x)
  (and (si:array-headerp x)
       (memq (array-type x) '(NIL T FIXNUM FLONUM))
       *:TRUTH))


(gen-logs LOGAND LOGIOR LOGXOR)

(defun LOGNOT (x) (boole 10. x -1))




;;;; Multi-arg <= and <=,  and  SI:CHECK-MULTIPLICITIES

(defun <= nargs  (si:<=>-aux nargs '<=))
(defun >= nargs  (si:<=>-aux nargs '>=))


(defun SI:<=>-AUX (nargs fun &aux inverter x y type-tester)
   (or (> nargs 1) (error '|Too few args| (cons fun (listify nargs))))
   (or (setq inverter (cond ((eq fun '<=) '>)
			    ((eq fun '>=) '<)))
       (memq fun '(< >))
       (error 'SI:<=>-AUX fun))
   (setq x (arg 1))
   (do ()
       ((memq (setq type-tester (typep x)) '(FIXNUM FLONUM)))
     (check-type x #'NUMBERP fun))
   (do ((i 2 (1+ i)) )
       ((> i nargs) *:TRUTH)
     (declare (fixnum i))
     (setq y (arg i) )
     (if (or *RSET (not (eq type-tester (typep y))))
	 (check-type y (if (eq type-tester 'FIXNUM) #'FIXNUMP #'FLONUMP) fun))
     (and (cond (inverter (if (eq inverter '>) (> x y) (< x y)))
		((eq fun '>) (not (> x y)))
		('T   (not (< x y))))
	  (return () ))
     (setq x y)))





(eval-when (eval compile)
  (setq retvec-vars '(*:AR2 *:AR3 *:AR4 *:AR5 *:AR6 *:AR7 *:AR8)
	max-retvec (length retvec-vars))
)


(let ((x '#.`(*:ARlist *:ARn ,.retvec-vars)))
  (if (boundp '+INTERNAL-INTERRUPT-BOUND-VARIABLES) 
      (if (and (not (memq '*:AR2 +INTERNAL-INTERRUPT-BOUND-VARIABLES)) 
	       (not (memq '*:ARlist +INTERNAL-INTERRUPT-BOUND-VARIABLES)))
	  (setq +INTERNAL-INTERRUPT-BOUND-VARIABLES 
		(append x +INTERNAL-INTERRUPT-BOUND-VARIABLES)))
      (setq +INTERNAL-INTERRUPT-BOUND-VARIABLES x)))


(defvar SI:CHECK-MULTIPLICITIES () 
   " () means pad out unsupplied multiple-return-values with nulls;
     CERROR means run an error if not enough values supplied;
     any thing else means to funcall that function.")

(defun SI:CHECK-MULTIPLICITIES (n)
    ;; What if the desired number of extra-return-values is greater than the
    ;;  actual number (of "extra-return-values")?  Well, then get some more!
   (cond ((not (> n *:ARn)) () ) 
	 ((null SI:CHECK-MULTIPLICITIES) 
	    ;; Just supply ()'s for the missing return values
	   (do ((x (nthcdr *:ARn '#.retvec-vars) (cdr x))
		(i *:ARn (1+ i)))
	       ((not (< i n)) )
	     (set (car x) () )))
	 ((eq SI:CHECK-MULTIPLICITIES 'CERROR)
	   (prog (l)
		 (setq l (cdr (multiple-value-list/| () )))
		  ;; Here, "l" is a list of the values actually returned, 
		  ;;  except for the first. 
	     B	(setq l (error '|Too few (extra) values returned for MULTIPLE-VALUE|
			       l
			       'WRNG-TYPE-ARG))
		(if (< (length l) n) (go B))
		 ;; Get some more, and spread them out.
		(values-list (cons () l))))
	 ('T (funcall SI:CHECK-MULTIPLICITIES n)))
   () )



;;;; VALUES-LIST, MULTIPLE-VALUE-LIST/| 


(defun VALUES-LIST (l)
    "Set up the multiple-values vector from a list."
   (let (first-val (n 0)) 
     (declare (fixnum n))
     (do () 
	 ((and (not (atom l)) (not (< (setq n (1- (length l))) 0))))
       (setq l (error "Atomic arg to VALUES-LIST?" l 'WRNG-TYPE-ARG))) 
     (pop l first-val)
     (setq *:ARlist () )
     (cond 
       ((< n 4)
	   ;; Do the case of 1 to 4 ret vals quickly!
	 (cond ((< n 2) (if (= n 1) (setq *:AR2 (car l))))
	       ('T (pop l *:AR2) 
		   (pop l *:AR3)
		   (if (= n 3) (setq *:AR4 (car l))))))
       ('T (mapc #'SET '#.retvec-vars l)
	   (if (> n #.max-retvec) (setq *:ARlist (nthcdr #.max-retvec l)))))
     (setq *:ARn n)
     first-val))



(defun MULTIPLE-VALUE-LIST/| (x)
    "Listify the elements of the multiple-values vector.  *:ARn holds the 
     number of 'extra' return values, and the arg to this fun is first val."
   (let ((n *:ARN))
     (declare (fixnum n))
     (prog1 
       (cons x 
	(and (> n 0)
	 (cons *:AR2
	  (and (> n 1)
	   (cons *:AR3
	    (and (> n 2)
	     (cons *:AR4
	      (and (> n 3)
	       (cons *:AR5
		(and (> n 4)
		 (cons *:AR6
		  (and (> n 5)
		   (cons *:AR7
		    (and (> n 6)
		     (cons *:AR8
		      (and (> n 7) 
			   (append *:ARLIST () )))))))))))))))))
       (setq *:ARn 0))))

(or (fboundp 'MULTIPLE-VALUE-LIST)
    (equal (get 'MULTIPLE-VALUE-LIST 'AUTOLOAD)
	   #%(autoload-filename MLMAC))
    (defun MULTIPLE-VALUE-LIST macro (X)
	   (remprop 'MULTIPLE-VALUE-LIST 'MACRO)
	   #%(subload MLMAC)
	   (eval x)))

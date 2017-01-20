;;;   LODBYT	-*-MODE:LISP;PACKAGE:SI-*-		  -*-LISP-*-
;;;   **************************************************************
;;;   ***** MACLISP ******* BYTE-manipulation Macros ***************
;;;   **************************************************************
;;;   ** (C) COPYRIGHT 1980 MASSACHUSETTS INSTITUTE OF TECHNOLOGY **
;;;   ****** THIS IS A READ-ONLY FILE! (ALL WRITES RESERVED) *******
;;;   **************************************************************


(eval-when (eval compile)
	   (or (status feature LISPM) 
	       (status macro /#)
	       (setsyntax '/# 'SPLICING '+INTERNAL-/#-MACRO)) 
	   (and (status feature MACLISP)
		(status nofeature MULTICS)
		(sstatus feature PDP10))
	   )


#-MACLISP 
(globalize "LDB" "DPB" "LOAD-BYTE" "DEPOSIT-BYTE" "*LOAD-BYTE" "*DEPOSIT-BYTE")

(herald LODBYT /24)



(comment LDB DPB and LOAD-BYTE)

#M (progn 'compile 
    (declare (fixnum (*LDB fixnum fixnum) (*DPB fixnum fixnum fixnum)))
    (defmacro LDB (bp word)
	(and (not (atom bp)) (setq bp (macroexpand bp)))
	(cond ((|constant-p/|| bp) 
	       (setq bp (eval bp))
	       (let ((byte-len (boole 1 bp 63.)) 
		     (position (boole 1 (lsh bp -6) 63.)))
		    (and (not (< position 36.)) 
			 (error '|Bad "position" - LDB|))
		    (and (not (= 0 position))
			 (setq word `(LSH ,word ,(- position))))
		    `(BOOLE 1 ,word ,(lsh -1 (- byte-len 36.)))))
	      (`(*LDB (LSH ,bp 24.) ,word))))
    (defmacro DPB (val bp word)
	      (and (not (atom bp)) (setq bp (macroexpand bp)))
	      (setq bp (cond ((|constant-p/|| bp) (lsh (eval bp) 24.))
			     (`(LSH ,bp 24.))))
	      `(*DPB ,val ,bp ,word))
   )

#N (progn 'compile 
	(defun LDB (bp word) (LDB bp word))
	(defun DPB (val bp word) (DPB val bp word))
   )


(defmacro LOAD-BYTE  (word position size &AUX byte-len)
    ;Similar to PDP-10 LDB, but "position" and "size" are separate
   (and (not (atom size)) (setq size (macroexpand size)))
   (and (not (atom position)) (setq position (macroexpand position)))
   (cond ((|constant-p/|| size)
	  (setq byte-len (eval size))
	  (or (and (eq (typep byte-len) 'FIXNUM) 
	  	   (> byte-len 0) 
		   (< byte-len 37.))
	      (error '|Bad byte-length - LOAD-BYTE| size))
	  (cond ((= byte-len 0) ''0)
		((= byte-len 36.) `,word)
		((|constant-p/|| position)
		 (setq position (eval position))
		 (or (and (eq (typep position) 'FIXNUM) 
			  (not (< position 0)) 
			  (< (+ position byte-len) 37.))
		     (error '|Bad position - LOAD-BYTE| position))
		 `(LDB ,(+ (lsh position 6) byte-len) ,word))
		('t `(BOOLE 1 ,(lsh -1 (- byte-len 36.))
			      (ROT ,word (- ,position))))))
	 ((or (|side-effectsp/|| position)
	      (|side-effectsp/|| size)
	      (|side-effectsp/|| (setq word (macroexpand word))))
	  `(*LOAD-BYTE ,word ,position ,size))
	 (`(BOOLE 1 (ROT ,word (- ,position)) (LSH -1 (- ,size 36.))))))


(comment DEPOSIT-BYTE)

(defmacro DEPOSIT-BYTE 
	  (word position size val &AUX byte-len byte-mask nval)
   (setq word (macroexpand word)  position (macroexpand position)
	 size (macroexpand size)  val (macroexpand val))
   (cond ((|constant-p/|| size)
	  (setq byte-len (eval size))
	  (or (and (eq (typep byte-len) 'FIXNUM) 
		   (not (< byte-len 0)) 
		   (< byte-len 37.))
	      (error '|Bad byte-length - DEPOSIT-BYTE| size))
	  (setq byte-mask (lsh -1 (- byte-len 36.)))
	  (setq nval (cond ((|constant-p/|| val) 
			     (boole 1 val byte-mask))
			   (`(BOOLE 1 ,val ,byte-mask))))
	  (cond ((= byte-len 0) `(PROG2 () ,word ,val))
		((= byte-len 36.) `(PROG2 ,word ,val))
		((|constant-p/|| position)
		 (setq position (eval position))
		 (or (and (eq (typep position) 'FIXNUM) 
			  (not (< position 0)) 
			  (< (+ position byte-len) 37.))
		     (error '|Bad position - DEPOSIT-BYTE| position))
		 (cond ((and (not (|side-effectsp/|| val)) 
			     (not (|side-effectsp/|| word)))
			`(DPB ,nval ,(+ (lsh position 6) byte-len) ,word))
		       ('t (setq nval (cond ((|constant-p/|| nval) 
					      (lsh nval position))
					    (`(LSH ,nval ,position))))
			   `(BOOLE 7 (BOOLE 4 ,word ,(lsh byte-mask position))
				     ,nval))))
		((let ((byte-displ position) 
		       (byte-pos position)
		       (fl (or (not (symbolp position)) 
			       (|side-effectsp/|| nval)))
		       z) 
		      (and fl (setq byte-displ (gensym)
				    byte-pos `(SETQ ,BYTE-DISPL ,position)))
		      (setq z `(BOOLE 7 (BOOLE 4 ,word (LSH ,BYTE-MASK ,byte-pos))
					(LSH ,nval ,byte-displ)))
		      (and fl (setq z `(LET ((,BYTE-DISPL 0))
					    (DECLARE (FIXNUM ,BYTE-DISPL))
					    ,z)))
		      z))))
	 ((or (|side-effectsp/|| word) (|side-effectsp/|| position) 
	      (|side-effectsp/|| size) (|side-effectsp/|| val))
	  `(*DEPOSIT-BYTE ,word ,position ,size ,val))
	 ((let ((byte-mask (gensym)) (byte-displ position) more-decls)
	       `(LET (,.(cond ((not (atom byte-displ))
			       (setq byte-displ (gensym) 
				     more-decls (list byte-displ))
			       `((,BYTE-DISPL ,position)) ))
		      (,BYTE-MASK (LSH -1 (- ,size 36.)))) 
		     (DECLARE (FIXNUM ,BYTE-MASK ,.more-decls))
		     (BOOLE 7 (BOOLE 4 ,word (LSH ,BYTE-MASK ,BYTE-DISPL))
			      (LSH (BOOLE 1 ,val ,BYTE-MASK) ,BYTE-DISPL)))))))

(comment  *LOAD-BYTE *LDB etc)

#Q (progn 'compile 
    (defun *LOAD-BYTE (word pos size) 
	   (ldb (+ (lsh pos 6) size) word))
    (defun *DEPOSIT-BYTE (word pos size byte) 
	   (dpb byte (+ (lsh pos 6) size) word))
   )

#+(or NIL MULTICS)
  (progn 'compile 
	     (defun *LOAD-BYTE (w p s) 
		(boole 1 (lsh w (- p)) (lsh -1 (- 36. s))))
	     (defun *DEPOSIT-BYTE (w p s b)
		(let ((msk (lsh (lsh -1 (- 36. s)) p)))
		     (boole 1 (boole 4 w msk) (lsh b p))))
	     )

#+MULTICS 
  (progn 'compile 
	     (defun *LDB (ppss w)
		(*load-byte w (boole 1 (lsh ppss -30.) 63.)
			      (boole 1 (lsh s -24.) 63.)))
	     (defun *DPB (b ppss w) 
		(*DEPOSIT-BYTE w (boole 1 (lsh ppss -30.) 63.) 
				 (boole 1 (lsh s -24.) 63.) 
				 b))
      )




#+PDP10	(lap-a-list 
	    '((lap *LOAD-BYTE subr)	
		 (args *LOAD-BYTE (() . 3))	;Args = (word position size)
		 (push p (% 0 0 fix1))
		 (move d 0 c)
		 (rot d -6)
		 (hrr d 0 b)
		 (rot d -6)
		 (move tt 0 a)
		 (jrst 0 LD)
	      (entry *LDB subr)	
		 (args *LDB (() . 2))	;Args = ( position_30.+size_24.  word )
		 (push p (% 0 0 fix1))
		 (move d 0 a)
		 (move tt 0 b)
	      LD (hrri d tt)
		 (ldb tt d)
		 (popj p)
	      (entry *DEPOSIT-BYTE subr)
		 (args *DEPOSIT-BYTE (() . 4))  ;Args = (word position size byte)
		 (push p (% 0 0 fix1))
		 (move r 0 4)
		 (move d 0 c)
		 (rot d -6)
		 (hrr d 0 b)
		 (rot d -6)
		 (move tt 0 a)
		 (jrst 0 DP)
	      (entry *DPB subr)
		 (args *DPB (() . 3))	;Args = ( newbyte position_30.+size_24.  word )
		 (push p (% 0 0 fix1))
		 (move r 0 a)
		 (move d 0 b)
		 (move tt 0 c)
	      DP (hrri d tt)
		 (dpb r d)		;puts result in TT
		 (popj p)
		 () ))




(sstatus feature LODBYT)

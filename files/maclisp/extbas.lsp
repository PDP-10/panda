;;;   EXTBAS			-*-Mode:Lisp;Package:SI;Lowercase:T-*-
;;;   ****************************************************************
;;;   *** MacLISP **** EXTended datatype scheme, BASic functions *****
;;;   ****************************************************************
;;;   ** (c) Copyright 1981 Massachusetts Institute of Technology ****
;;;   ****************************************************************

(herald EXTBAS /35)

(include ((lisp) subload lsp))

(eval-when (eval compile)
  (subload EXTMAC)
 )


;; Used by typical NIL-compatibility functions
(defun SI:NON-NEG-FIXNUMP (n) (and (fixnump n) (>= N 0)))
;; Used by extend conser error checking
(defun SI:MAX-EXTEND-SIZEP (n) (and (fixnump n) (>= N 0) (< n 510.)))


;;;; Regular DEFUNitions of XREF, XSET, MAKE-EXTEND, EXTEND-LENGTH etc.

;;; Macro-definings  of XREF, XSET, MAKE-EXTEND, EXTEND-LENGTH etc.
;;;  come in from exthuk
(eval-when (eval compile load)
  (if (status feature complr)
      (subload EXTHUK))
)


;; These MUST come after the MACRO definitions, so that EVAL will
;; "prefer" the SUBR versions over the MACRO versions.


;; Pass the buck to the CXR function on error checking for these guys.
(defun SI:XREF (h n) 
  (subrcall T #,(get 'CXR 'SUBR) (+ #.si:extend-q-overhead n) h))
(defun SI:XSET (h n val) 
  (subrcall T #,(get 'RPLACX 'SUBR) (+ #.si:extend-q-overhead n) h val))

(defun SI:MAKE-EXTEND (n class)
  (cond ((and *RSET (fboundp 'SI:CHECK-TYPER)) 
	  (check-type n #'SI:MAX-EXTEND-SIZEP 'SI:MAKE-EXTEND)
	  (setq class (SI:CHECK-TYPER class #'CLASSP 'SI:MAKE-EXTEND))))
  (si:make-extend n class))

;;Remember that si:extend-length has a macro definition from EXTHUK file
(defun SI:EXTEND-LENGTH (x) (si:extend-length x))
(let ((x (getl 'SI:EXTEND-LENGTH '(EXPR SUBR))))
  (putprop 'EXTEND-LENGTH (cadr x) (car x)))

(defun SI:EXTEND n 
  (let ((size (1- n)) 
	(class (if (>= n 1) (arg 1))))
    (declare (fixnum size))
    (do ((obj (si:make-extend size class))
	 (i 0 (1+ i)))
	((>= i size) obj)
      (declare (fixnum i))
        ;;(ARG 1) is class obj, (ARG 2) is first elt
      (si:xset obj i (arg (+ i 2))))))

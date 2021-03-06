;;; -*- Mode:Lisp; IBase:10.; -*-
;;;
;;; 6BIT: A package for conversions between sixbit or ascii representations
;;;       and lisp symbols.
;;;
;;; This library was created by KMP, 22 Oct 81, and added to by JONL 23 Oct 81.
;;; and CWR 28 Feb 83.
;;;
;;;  (SYMBOL-TO-ASCII sym &optional (n 1)) 
;;; 		Returns the n'th PDP10 word of the ascii representation of 
;;; 		the symbol 'sym', with 1-origin indexing of the words.
;;;  (SYMBOL-TO-SIXBIT sym &optional (n 1)) 
;;; 		Returns the n'th PDP10 word of the sixbit representation.
;;;  (SYMBOL->6BIT sym)  Same as (SYMBOL-TO-ASCII sym 1), but marginally
;;; 		faster calling sequence.
;;; 
;;;  (ASCII-TO-SYMBOL number &optional internp)
;;; 		Returns a symbol [which is interned if 'internp' is non-()],
;;; 		whose pname is designated by the fixnum 'number'.
;;;  (SIXBIT-TO-SYMBOL number &optional internp)
;;; 		Returns a symbol [which is interned if 'internp' is non-()],
;;; 		whose pname is constructed by converting the 'number' from
;;; 		sixbit to ascii representation.
;;;  (6BIT->SYMBOL num)  Same as (SIXBIT-TO-SYMBOL num 'T), but marginally
;;; 		faster calling sequence.
;;; 		

(herald /6BIT 2)


(eval-when (eval compile load)
  (and (status feature COMPLR)
       (fixnum (symbol->6bit) (symbol-to-sixbit) (symbol-to-ascii))))

(declare (fixnum (si:SYMBOL->6BIT-or-ASCII)
		 (1wd/| () fixnum)))

;;;; Conversions from symbols


(defun SYMBOL-TO-ASCII (sym &optional (nth-word 1))
   (si:SYMBOL->6BIT-or-ASCII sym nth-word 'T 'SYMBOL-TO-ASCII))

(defun SYMBOL-TO-SIXBIT (sym &optional (nth-word 1))
   (si:SYMBOL->6BIT-or-ASCII sym nth-word () 'SYMBOL-TO-SIXBIT))

(DEFUN SYMBOL->6BIT (SYM)
   (si:SYMBOL->6BIT-or-ASCII sym 1 () 'SYMBOL->6BIT))


(defun si:SYMBOL->6BIT-or-ASCII (sym nth-word asciip funname)
  (if (not (symbolp sym))
      (check-type sym  #'SYMBOLP funname))
  (if (not (fixnump nth-word))
      (check-type nth-word  #'FIXNUMP funname))
  (if (= nth-word 1)
      (car (pnget sym (if asciip 7 6)))
      (1wd/| sym nth-word (if asciip 'ASCII))))

(or (getl '1WD/| '(SUBR AUTOLOAD))
    (putprop '1WD/| (get 'LAP 'AUTOLOAD) 'AUTOLOAD))


;;;;Conversions to symbol

(defun ASCII-TO-SYMBOL (number &optional internp)
  (if (not (fixnump number))
      (check-type number #'FIXNUMP 'ASCII-TO-SYMBOL))  
  (pnput (list number) internp))

(defun SIXBIT-TO-SYMBOL (number &optional internp)
  (si:SYMBOL-from-6BIT number internp 'SIXBIT-TO-SYMBOL))

(defun 6BIT->SYMBOL (number)
  (si:SYMBOL-from-6BIT number 'T '6BIT->SYMBOL))


(defun si:SYMBOL-from-6BIT (number internp funname)
  (if (not (fixnump number))
      (check-type number #'FIXNUMP funname))  
  (do ((n number (lsh n 6))
       (7byno 29. (- 7byno 7))
       (first-pname-word 0)
       (extra () ))
      ((zerop n)		;Done when no more non-zero bits in number.
       (pnput (cons first-pname-word extra) internp))
    (declare (fixnum n 6byno 7byno first-pname-word))
    (cond ((> 7byno 0)
	    (setq first-pname-word  
		  (deposit-byte first-pname-word
				7byno 
				7 
				(+ (load-byte n 30. 6) #O40))))
	  ('T ;;Ha, must be 6 chars in the number!
	    (setq extra (list (lsh (+ (load-byte n 30. 6) #O40) 29.)))))))


    
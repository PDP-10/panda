;;; -*-LISP-*-

;;; (LIVE-ARRAYS <kind>) returns a list of all allocated arrays (not 
;;;   currently considered "dead" space).  Its argument permits selecting 
;;;   only certain kinds of arrays: OBARRAY, READTABLE, FILE, T, NIL, 
;;;   FIXNUM, or FLONUM.   An argument of ALL gets all non-dead arrays.
;;;   In addition, an argument of OPEN-FILE selects only open files.
;;; (OPEN-FILES) returns a list of all open file objects


(defun (OPEN-FILES macro) (()) `(LIVE-ARRAYS 'OPEN-FILE))

(defun LIVE-ARRAYS (kind) 
  (or kind (setq kind 'T))
  (and (not (memq kind '(OBARRAY READTABLE FILE FIXNUM FLONUM T NIL)))
       (not (eq kind 'OPEN-FILE))
       (setq kind 'ALL))
  (let ((dedsar (getddtsym 'DEDSAR))
        (gcmkl (munkam (examine (getddtsym 'GCMKL))))
	(open-file-flag (cond ((eq kind 'OPEN-FILE)
			       (setq kind 'FILE)
			       'T))))
       (do ((l gcmkl (cddr l)) (z) )
	   ((null l) (nreverse z))
	 (and (not (eq (car l) dedsar)) 
	      (cond ((eq kind 'ALL)) 
		    ((eq kind (car (arraydims (car l))))
		     (or (not open-file-flag)
			 (status filemode (car l)))))
	      (push (car l) z)))))



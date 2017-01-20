;;;  SHARPA 	   -*-mode:lisp;package:si-*-			    -*-LISP-*-
;;;  **************************************************************************
;;;  **** NIL ** NIL/MACLISP/LISPM Compatible # Macro Auxiliary  **************
;;;  **************************************************************************
;;;  ******** (c) Copyright 1980 Massachusetts Institute of Technology ********
;;;  ************ this is a read-only file! (all writes reserved) *************
;;;  **************************************************************************

(herald SHARPAUX /16)

;; This is to get around a DEFVST bug.
(EVAL-WHEN (EVAL LOAD)
  (OR (GET 'EXTEND 'VERSION)
      (load '((LISP) EXTEND))))

(defvst FEATURE-SET target features nofeatures query-mode)

(defprop FEATURE-SET (FEATURES NOFEATURES QUERY-MODE)
	 SUPPRESSED-COMPONENT-NAMES)

(defmacro DEF-FEATURE-SET (target features &optional nofeatures
						     (query-mode ':QUERY))
  (CHECK-ARG query-mode (memq query-mode '(:QUERY :ERROR T () ))
	     "A valid feature query mode")
  `(progn 'COMPILE
     (putprop ',target (cons-a-feature-set TARGET ',target FEATURES ',features
					   NOFEATURES ',nofeatures
					   QUERY-MODE ',query-mode)
	      'FEATURE-SET)
     ',target))

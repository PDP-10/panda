;-*- LISP -*-

;; FEATURE DOUBLE CREATURE

;; FEATUREP and Sharpsign conditionalization.

(HERALD SHARPCONDITIONALS /2)

(declare (*lexpr FEATUREP))

(comment Helper funs)

(eval-when (eval load)
  (or (get 'SHARPM 'VERSION)
      (load '((LISP) SHARPM))))

(eval-when (compile eval)
  (or (get 'ERRCK 'VERSION)
      (load '((LISP) ERRCK)))
  (or (get 'UMLMAC 'VERSION)
      (load '((LISP) UMLMAC)))
  (or (get 'SHARPAUX 'VERSION)
      (load '((LISP) SHARPA))))

(eval-when (load)
  (defprop DEF-FEATURE-SET ((LISP) SHARPA) AUTOLOAD))

(declare (special query-io))

(defvar TARGET-FEATURES 'LOCAL-FEATURES
	"Features to assume objects read are for.")

;; INITIAL-LOCAL-FEATURES is useful for creating other targets which are
;; variations of the default environment.

(defun featurep (feature &optional (feature-set TARGET-FEATURES) (featurep 'T))
  "Return T if the feature is known to be a feature in the feature set.  Return
  () if it is known NOT to be a feature.  Otherwise query, error, or assume,
  depending on the query-mode of the feature-set."
  (CHECK-ARG feature-set (and (symbolp feature-set)
			      (get feature-set 'feature-set))
	     "A feature-set name")
   (cond ((atom feature) (si:featurep-symbol feature feature-set featurep))
	 ((get (car feature) 'feature-set)
	  (SI:FEATURE-AND (cdr feature) (car feature) featurep))
	 ((eq (car feature) 'NOT)
	  (FEATUREP (cadr feature) feature-set (not featurep)))
	 ((eq (car feature) 'AND)
	  (SI:FEATURE-AND (cdr feature) feature-set featurep))
	 ((eq (car feature) 'OR)
	  (SI:FEATURE-OR (cdr feature) feature-set featurep))
	 ('T (ERROR '|Can't parse features request list - #+--TEST-FOR-FEATURE|
		    feature))))

(defun NOFEATUREP (feature &optional (feature-set target-features))
  "Returns T if the feature is known to not be a feature in the feature-set"
  (FEATUREP feature feature-set () ))

(defun SI:FEATURE-AND (feature-list feature-set featurep)
  "FEATUREP for the (AND f1 f2 f3 ... fn) case of a feature-spec"
  (do ((l feature-list (cdr l)))
      ((null l) featurep)
      (or (FEATUREP (car l) feature-set T)
	  (return (not featurep)))))

(defun SI:FEATURE-OR (feature-list feature-set featurep)
  "FEATUREP for the (OR f1 f2 ... fn) case of a feature-spec"
  (do ((l feature-list (cdr l)))
      ((null l) (not featurep) )
      (and (FEATUREP (car l) feature-set 'T)
	   (return featurep))))


(defun SI:FEATUREP-SYMBOL (feature feature-set-name featurep &aux feature-set)
  "FEATUREP for the symbol case of a feature-spec"
  (setq feature-set (get feature-set-name 'feature-set))
  (not (null (or (and featurep
		      (memq feature (feature-set-features feature-set)))
		 (and (not featurep)
		      (memq feature (feature-set-nofeatures feature-set)))
		 (if (and (not (memq feature
				     (feature-set-nofeatures feature-set)))
			  (not (and (not featurep)
				    (memq feature
					 (feature-set-features feature-set)))))
		     (caseq (feature-set-query-mode feature-set)
		       (:QUERY
			(if (or (not (boundp 'query-io))
				(eq query-io 'T))
			    (load '((LISP) YESNOP)))
			(if (y-or-n-p query-io "~&Is ~A a feature in ~A"
				      feature (feature-set-target feature-set))
			    (push feature (feature-set-features feature-set))
			    (push feature
				  (feature-set-nofeatures feature-set)))
			(featurep feature feature-set-name featurep))
		       (:ERROR
			(FERROR ()
				"~S is not a known feature in ~S"
				feature feature-set-name))
		       ((T) featurep)
		       (T (not featurep) )))	;Else assume nofeature
		 ))))


(defun SET-FEATURE (feature &optional (feature-set-name target-features)
			    &aux feature-set)
  "Say that a feature is a feature in the feature-set.  FEATUREP will then
   return T when called with that feature on that feature-set."
  (CHECK-ARG feature-set-name (and (symbolp feature-set-name)
				   (get feature-set-name 'feature-set))
	     "A feature-set name")
  (setq feature-set (get feature-set-name 'feature-set))
  (setf (feature-set-features feature-set)
	(delq feature (feature-set-features feature-set)))
  (push feature (feature-set-features feature-set))
  (setf (feature-set-nofeatures feature-set)
	(delq feature (feature-set-nofeatures feature-set)))
  feature)


(defun SET-NOFEATURE (feature &optional (feature-set-name target-features)
			       &aux feature-set)
  "Say that a feature is NOT a feature in the feature set.  FEATUREP will
  return ()."
  (CHECK-ARG feature-set-name (and (symbolp feature-set-name)
				   (get feature-set-name 'feature-set))
	     "A feature-set name")
  (setq feature-set (get feature-set-name 'feature-set))
  (setf (feature-set-nofeatures feature-set)
	(delq feature (feature-set-nofeatures feature-set)))
  (push feature (feature-set-nofeatures feature-set))
  (setf (feature-set-features feature-set)
	(delq feature (feature-set-features feature-set)))
  feature)

(defun SET-FEATURE-UNKNOWN (feature &optional
				    (feature-set-name target-features)
				    &aux feature-set)
  "Make a feature-name be unknown in a feature set."
  (CHECK-ARG feature-set-name (and (symbolp feature-set-name)
				   (get feature-set-name 'feature-set))
	     "A feature-set name")
  (setq feature-set (get feature-set-name 'feature-set))
  (setf (feature-set-features feature-set)
	(delq feature (feature-set-features feature-set)))
  (setf (feature-set-nofeatures feature-set)
	(delq feature (feature-set-nofeatures feature-set)))
  feature)

(defun SET-FEATURE-QUERY-MODE (feature-set-name mode)
  "Set the feature-set's query-mode.  :QUERY (the mode they're created in
   by DEF-FEATURE-SET) means to ask about unknown features, :ERROR means to
   signal an error, T means assume it's a feature, () means to assum it's not."
  (CHECK-ARG feature-set-name (and (symbolp feature-set-name)
				   (get feature-set-name 'feature-set))
	     "A feature-set name")
  (CHECK-ARG mode (memq mode '(:QUERY :ERROR T () ))
	     "A valid feature query mode")
  (setf (feature-set-query-mode (get feature-set-name 'feature-set)) mode))

(defun COPY-FEATURE-SET (old new)
  "Build a new feature-set from an old one with same features and non-features"
  (check-arg old (and (symbolp old) (get old 'feature-set))
	     "a feature set name")
  (setq old (get old 'feature-set))
  (putprop new (cons-a-feature-set TARGET new
				   FEATURES (feature-set-features old)
				   NOFEATURES (feature-set-nofeatures old)
				   QUERY-MODE (feature-set-query-mode old))
	   'FEATURE-SET)
  new)

; Compatibility with JONLism
(eval-when (eval compile)
  (defmacro /#SUB-READ () '(read)))

;; Now define #+ and #-

(defsharp /+ SPLICING (())
       (let ((test (/#sub-read () READ-STREAM))
	     (form (/#sub-read () READ-STREAM)))
	    (and (featurep test)
		 (list form))))


(defsharp /- SPLICING (())
       (let ((test (/#sub-read () READ-STREAM))
	     (form (/#sub-read () READ-STREAM)))
	    (and (nofeaturep test)
		 (list form))))


;;The following assume the target for this file is MACLISP or NIL simulation.

(def-feature-set MACLISP-FEATURES
		 (MACLISP SENDI BIBOP BIGNUM FASLOAD PAGING ROMAN
			  HUNK FUNARG NEWIO FOR-MACLISP)
		 (ITS TOPS-20 TOPS-10 BOTTOMS-10 MULTICS FRANZ VAX VMS
		      UNIX FOR-NIL LISPM PDP10 FOR-LISPM))
(when (status feature SFA)
      (set-feature 'SFA 'MACLISP-FEATURES))
(def-feature-set NIL-FEATURES
		 (NIL FOR-NIL BIGNUM FASLOAD PAGING ROMAN)
		 (MACLISP SENDI BIBOP HUNK FUNARG NEWIO FOR-MACLISP
			  FRANZ MULTICS LISPM FOR-LISPM))
(copy-feature-set 'MACLISP-FEATURES 'LOCAL-FEATURES)
(when (status feature PDP10)
      (set-feature 'PDP10 'LOCAL-FEATURES))
(set-feature (status opsys))
(set-feature (status filesys))
(COPY-FEATURE-SET 'LOCAL-FEATURES 'INITIAL-LOCAL-FEATURES)



;;; This page contributed by KMP

;;; (WHEN-FEATURE                       ;; (WHEN-FEATURES
;;;   (featurespec1 . clause1)          ;;   (featurespec1 . clause1)
;;;   (featurespec2 . clause2)          ;;   (featurespec2 . clause2)
;;;   (featurespec3 . clause3) ...)     ;;   (featurespec3 . clause3) ...)
;;;					;;
;;;   Executes the first clause which	;;   Executes all clauses which
;;;   corresponds to a feature match.	;;   corresponds to a feature match.
;;;
;;; Feature match specs are designated by the following types of forms:
;;;
;;;  T			    - always
;;;  symbol		    - feature name
;;;  (OR spec1 spec2 ...)   - spec disjunction
;;;  (AND spec1 spec2 ...)  - spec conjunction
;;;  (NOT spec)		    - spec negation

(DEFUN WHEN-FEATURE-SPEC (SPEC)
  (COND ((SYMBOLP SPEC)       `(FEATUREP ',SPEC))
	((EQ (CAR SPEC) 'OR)  `(OR  ,@(MAPCAR #'WHEN-FEATURE-SPEC (CDR SPEC))))
	((EQ (CAR SPEC) 'AND) `(AND ,@(MAPCAR #'WHEN-FEATURE-SPEC (CDR SPEC))))
	((AND (EQ (CAR SPEC) 'NOT)
	      (= (LENGTH SPEC) 2.))
			      `(NOT ,(WHEN-FEATURE-SPEC (CADR SPEC))))
	(T
	 (FERROR NIL "Illegal feature specification: ~S" SPEC))))

(DEFMACRO WHEN-FEATURE (&REST CLAUSES)
  `(COND ,@(MAPCAR #'(LAMBDA (X)
		       `(,(IF (EQ (CAR X) 'T) T
			      (WHEN-FEATURE-SPEC (CAR X)))
			 ,@(CDR X)))
		   CLAUSES)))

(DEFMACRO WHEN-FEATURES (&REST CLAUSES)
  `(PROGN ,@(MAPCAR #'(LAMBDA (X)
			`(COND (,(IF (EQ (CAR X) 'T) T
				     (WHEN-FEATURE-SPEC (CAR X)))
				,@(CDR X))))
		    CLAUSES)))


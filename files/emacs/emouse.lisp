;;; -*- Mode: LISP; Package: USER; Base: 10; Fonts:CPTFONT; -*-
;;;
;;; Everyone should load indirect through this file.
;;;
;;; The real source to the EMOUSE library is OZ:PS:<EMACS>EMOUSE.SOURCE

(LET ((EXT (COND ((STATUS FEATURE SYMBOLICS)
		  (IF (STATUS FEATURE 3600.) "BIN" "QBIN"))
		 (T "QFASL")))
      (REL (COND ((STATUS FEATURE SYMBOLICS)
		  (FORMAT NIL "REL~D-" (SI:GET-RELEASE-VERSION)))
		 (T
		  (FORMAT NIL "SYS~D-" (SI:GET-SYSTEM-VERSION))))))
  (LOAD (FORMAT NIL "OZ:PS:<EMACS>EMOUSE.~A~A" REL EXT)))

;;; date-edit support, by R. Helliwell, Jan 26, 1996
;;; (c) 1996 XKL System Corporation
;;;
;;; Routines:
;;;
;;;	(date-edit)
;;;		Interactive - Inserts edit header line at beginning of buffer
;;;		with optional prefix and suffix strings
;;;
;;;	(date-edit1 include-file include-node)
;;;		Non-interactive - Same as date-edit, but allows selection of
;;;		filename or node and filename to be included or excluded
;;;
;;;	(date-edit1 include-file include-node prefix suffix)
;;;		Non-interactive - Same as date-edit1, but allows selection of
;;;		prefix and suffix strings for header line
;;;
;;; Variables:
;;;
;;;	date-edit-prefix-suffix-alist
;;;		Specify different prefix and suffix strings by filename match
;;;
;;;	date-edit-include-file
;;;		Boolean to control inclusion of filename
;;;
;;;	date-edit-include-node
;;;		Boolean to contorl inclusion of node name in filename
;;;
;;;	auto-date-edit-files
;;;		Pattern to select files for automatic date-edit on write
;;;
;;;	query-date-edit-files
;;;		Pattern to select files to ask about date-edit on write

(defconst date-edit-prefix-suffix-alist '(("\\.mac$" . (";" . ""))
					  ("\\.fai$" . (";" . ""))
					  ("\\.mic$" . (";" . ""))
					  ("\\.c$" . ("/* " . " */"))
					  ("\\.el$" . (";;;" . ""))
					  ("\\.emacs$" . (";;;" . ""))
					  ("\\.b36$" . ("!" . ""))
					  ("\\.for$" . ("C       " . "")))
  "*Alist specifying text pairs to insert before and after the date-edit
header line. This allows the header to be a comment line, if desired.
Elements look like (REGEXP . (PREFIX . SUFFIX)); if the file's name
matches REGEXP, then the corresponding PREFIX and SUFFIX are used.
Note: the header line has a newline added after the SUFFIX.")

(defconst date-edit-include-file t
  "*Non-nil means that the file name is included in the date header")

(defconst date-edit-include-node nil
  "*Non-nil means that the node name is included in the date header")

(defconst auto-date-edit-files nil
  "*Regexp that matches filenames which should have date-edit done
automatically when they are written.")

(defconst query-date-edit-files nil
  "*Regexp that matches filenames which should ask ask if date-edit should
be done when they are written.")

;;; Setup to check for date-edit on file write
(setq write-file-hooks
      (append write-file-hooks '(date-edit-write-file-hook)))

(defun date-edit-write-file-hook ()
  "Hook to match auto/query-date-edit-files against buffer-file-name to see
if date-edit should be done (auto) or asked for (query). Added automatically
to write-file-hooks."
  (if (and buffer-file-name
	   (or (and auto-date-edit-files
		    (string-match auto-date-edit-files buffer-file-name))
	       (and query-date-edit-files
		    (string-match query-date-edit-files buffer-file-name)
		    (y-or-n-p
		     (format "Date-edit file %s? " buffer-file-name)))))
			      
      (date-edit)))

(defun date-edit ()
  "Add a header line at the beginning of the buffer with the date and time,
and user who wrote the file. If date-edit-include-file is not nil, the file
name will appear. If date-edit-include-node is not nil, the node will appear
in the file name (subject to date-edit-include-file). The line is surrounded
with the matching strings found in date-edit-prefix-suffix-alist. If
date-edit-include-node is not nil, the system name is added as well.
A typical line might look like this:

;TOED:<HELLIWELL.MAC>FU.MAC, Fri Jan 19 21:17:03 1996, Edit by HELLIWELL

Uses worker functions date-edit1 and date-edit2."
  (interactive)
  (date-edit1 date-edit-include-file date-edit-include-node))

(defun date-edit1 (include-file include-node)
  "Worker routine for date-edit. If INCLUDE-FILE is not nil, the
buffer-file-name will be included in the header line. If INCLUDE-NODE
is not nil, the current node name will be included in the file name
(subject to INCLUDE-FILE). The prefix and suffix strings are extracted
from the matching entry in date-edit-prefix-suffix-alist."
  (let ((alist date-edit-prefix-suffix-alist)
	(name (file-name-sans-versions buffer-file-name))
	(prefix nil)
	(suffix nil))
    (while (and (not prefix) alist)
      (if (not (string-match (car (car alist)) name))
	  (setq alist (cdr alist))
	(setq prefix (if (and (cdr (car alist)) (car (cdr (car alist))))
			 (car (cdr (car alist)))
		       ""))
	(setq suffix (if (and (cdr (car alist)) (cdr (cdr (car alist))))
			 (cdr (cdr (car alist)))
		       ""))))
    (date-edit2 include-file include-node prefix suffix)))

(defun date-edit2 (include-file include-node prefix suffix)
  "Worker routine for date-edit. If INCLUDE-FILE is not nil, the
buffer-file-name will be included in the header line. If INCLUDE-NODE
is not nil, the current node name will be included in the file name
(subject to INCLUDE-FILE). PREFIX is the string to be placed at the
front of the header line. SUFFIX is the string to be placed at the end
of the header line."
  (save-excursion
    (goto-char (point-min))
    (insert (if prefix prefix "")
	    (if include-file
		(concat (if include-node
			     (concat "[" (upcase (system-name))  "]")
			   "")
			 (upcase buffer-file-name)
			 ", ")
	      "")
	    (current-time-string)
	    ", Edit by " (user-login-name)
	    (if suffix suffix "") "\n")))

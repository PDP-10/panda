;;; Macro code editing commands for Emacs
;;; Copyright (C) 1985, 1986, 1987 Free Software Foundation, Inc.

;;; This file is part of GNU Emacs.

;;; GNU Emacs is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 1, or (at your option)
;;; any later version.

;;; GNU Emacs is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.

;;; You should have received a copy of the GNU General Public License
;;; along with GNU Emacs; see the file COPYING.  If not, write to
;;; the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.


(defvar macro-definition
  "^[\001^]*[A-Za-z.%$][0-9A-Za-z.%$]*[ \t]*[:=_]")
(defvar macro-label
  "^[\001^]*[A-Za-z.%$][0-9A-Za-z.%$]*:+")
(defvar macro-function
  "^[\001^]*[A-Za-z.%$][0-9A-Za-z.%$]*::")
(defvar macro-function-end
  "^\\([\001^]*[A-Za-z.%$][0-9A-Za-z.%$]*::\\|\n\\)")
(defvar macro-mode-abbrev-table nil
  "Abbrev table in use in Macro-mode buffers.")
(define-abbrev-table 'macro-mode-abbrev-table ())

(defvar macro-mode-map ()
  "Keymap used in Macro mode.")
(if macro-mode-map
    ()
  (setq macro-mode-map (make-sparse-keymap))
  (define-key macro-mode-map "\e\C-a" 'macro-beginning-of-function)
  (define-key macro-mode-map "\e\C-e" 'macro-end-of-function)
  (define-key macro-mode-map "\e\C-h" 'mark-macro-function)
  (define-key macro-mode-map "\e\C-q" 'indent-macro-exp)
  (define-key macro-mode-map "\t" 'macro-indent-command))

(defvar macro-mode-syntax-table nil
  "Syntax table in use in Macro-mode buffers.")

(if macro-mode-syntax-table
    ()
  (setq macro-mode-syntax-table (make-syntax-table))
  (modify-syntax-entry ?\n ">" macro-mode-syntax-table)
  (modify-syntax-entry ?; "<" macro-mode-syntax-table)
  (modify-syntax-entry ?. "w" macro-mode-syntax-table)
  (modify-syntax-entry ?_ "." macro-mode-syntax-table)
  (modify-syntax-entry ?- "." macro-mode-syntax-table)
  (modify-syntax-entry ?+ "." macro-mode-syntax-table)
  (modify-syntax-entry ?* "." macro-mode-syntax-table)
  (modify-syntax-entry ?/ "." macro-mode-syntax-table)
  (modify-syntax-entry ?& "." macro-mode-syntax-table)
  (modify-syntax-entry ?| "." macro-mode-syntax-table)
  (modify-syntax-entry ?< "(>" macro-mode-syntax-table)
  (modify-syntax-entry ?> ")>" macro-mode-syntax-table)
  (modify-syntax-entry ?= "." macro-mode-syntax-table)
  (modify-syntax-entry ?\\ "." macro-mode-syntax-table)
  (modify-syntax-entry ?\( "()" macro-mode-syntax-table)
  (modify-syntax-entry ?\) ")(" macro-mode-syntax-table)
  (modify-syntax-entry ?{ "(}" macro-mode-syntax-table)
  (modify-syntax-entry ?} "){" macro-mode-syntax-table)
  (modify-syntax-entry ?\' "\"" macro-mode-syntax-table))

(defvar macro-mode-indent-syntax-table nil
  "Syntax table in use in Macro-mode buffers for indenting.")

(if macro-mode-indent-syntax-table
    ()
  (setq macro-mode-indent-syntax-table (make-syntax-table))
  (modify-syntax-entry ?\n ">" macro-mode-indent-syntax-table)
  (modify-syntax-entry ?; "<" macro-mode-indent-syntax-table)
  (modify-syntax-entry ?. "w" macro-mode-indent-syntax-table)
  (modify-syntax-entry ?_ "." macro-mode-indent-syntax-table)
  (modify-syntax-entry ?- "." macro-mode-indent-syntax-table)
  (modify-syntax-entry ?+ "." macro-mode-indent-syntax-table)
  (modify-syntax-entry ?* "." macro-mode-indent-syntax-table)
  (modify-syntax-entry ?/ "." macro-mode-indent-syntax-table)
  (modify-syntax-entry ?& "." macro-mode-indent-syntax-table)
  (modify-syntax-entry ?| "." macro-mode-indent-syntax-table)
  (modify-syntax-entry ?< "." macro-mode-indent-syntax-table)
  (modify-syntax-entry ?> "." macro-mode-indent-syntax-table)
  (modify-syntax-entry ?= "." macro-mode-indent-syntax-table)
  (modify-syntax-entry ?\\ "." macro-mode-indent-syntax-table)
  (modify-syntax-entry ?\( "." macro-mode-indent-syntax-table)
  (modify-syntax-entry ?\) "." macro-mode-indent-syntax-table)
  (modify-syntax-entry ?{ "." macro-mode-indent-syntax-table)
  (modify-syntax-entry ?} "." macro-mode-indent-syntax-table)
  (modify-syntax-entry ?\' "\"" macro-mode-indent-syntax-table))

(defconst macro-indent-level 8
  "*Indentation of Macro statements with respect to containing block.")

(defconst macro-tab-always-indent nil
  "*Non-nil means TAB in Macro mode should always reindent the current line,
regardless of where in the line point is when the TAB command is used.")

(defun macro-mode ()
  "Major mode for editing Macro code.
Expression and list commands understand all Macro brackets.
Tab indents for Macro code.
Comments begin with ; and continue to end of line.
Paragraphs are separated by blank lines only.
\\{macro-mode-map}
Variables controlling indentation style:
 macro-tab-always-indent
    Non-nil means TAB in Macro mode should always reindent the current line,
    regardless of where in the line point is when the TAB command is used.
 macro-indent-level
    Indentation of Macro statements within surrounding block.
    The surrounding block's indentation is the indentation
    of the line on which the open-bracket appears.

Turning on Macro mode calls the value of the variable macro-mode-hook with
no args, if that value is non-nil."
  (interactive)
  (kill-all-local-variables)
  (use-local-map macro-mode-map)
  (setq major-mode 'macro-mode)
  (setq mode-name "Macro")
  (setq local-abbrev-table macro-mode-abbrev-table)
  (set-syntax-table macro-mode-syntax-table)
  (make-local-variable 'page-delimiter)
  (setq page-delimiter "\014")
  (make-local-variable 'paragraph-start)
  (setq paragraph-start (concat "^$\\|" page-delimiter))
  (make-local-variable 'paragraph-separate)
  (setq paragraph-separate paragraph-start)
  (make-local-variable 'paragraph-ignore-fill-prefix)
  (setq paragraph-ignore-fill-prefix t)
  (make-local-variable 'indent-line-function)
  (setq indent-line-function 'macro-indent-line)
  (make-local-variable 'require-final-newline)
  (setq require-final-newline t)
  (make-local-variable 'comment-start)
  (setq comment-start "; ")
  (make-local-variable 'comment-end)
  (setq comment-end "")
  (make-local-variable 'comment-column)
  (setq comment-column 32)
  (make-local-variable 'comment-start-skip)
  (setq comment-start-skip ";+[ \t]*")
  (make-local-variable 'comment-indent-hook)
  (setq comment-indent-hook 'macro-comment-indent)
  (make-local-variable 'parse-sexp-ignore-comments)
  (setq parse-sexp-ignore-comments nil)
  (run-hooks 'macro-mode-hook))

;;; This is used by indent-for-comment
;;; to decide how much to indent a comment in Macro code
;;; based on its context.
(defun macro-comment-indent ()
  (if (looking-at ";;;")
      0					;Left margin comment
    (if (and (looking-at ";;")
	     (save-excursion 
	       (skip-chars-backward " \t")
	       (bolp)))
	(calculate-macro-indent nil)
      (save-excursion
	(skip-chars-backward " \t")
	(max (1+ (current-column))	;Else indent at comment column
	     comment-column)))))	; except leave at least one space.

;;; Determine indentation of current line.
(defun macro-current-indentation ()
  (save-excursion
    (beginning-of-line)
    (if (not (looking-at macro-label))
	(current-indentation)
      (re-search-forward macro-label)
      (skip-chars-forward " \t")
      (current-column))))

(defun macro-indent-command (&optional whole-exp)
  "Indent current line as Macro code, or in some cases insert a tab character.
If macro-tab-always-indent is non-nil (the default), always indent current
line. Otherwise, indent the current line only if point is at the left margin
or in the line's indentation; otherwise insert a tab.

A numeric argument, regardless of its value,
means indent rigidly all the lines of the expression starting after point
so that this line becomes properly indented.
The relative indentation among the lines of the expression are preserved."
  (interactive "P")
  (if whole-exp
      ;; If arg, always indent this line as Macro
      ;; and shift remaining lines of expression the same amount.
      (let ((shift-amt (macro-indent-line))
	    beg end)
	(save-excursion
	  (if macro-tab-always-indent
	      (beginning-of-line))
	  (setq beg (point))
	  (forward-sexp 1)
	  (setq end (point))
	  (goto-char beg)
	  (forward-line 1)
	  (setq beg (point)))
	(if (> end beg)
	    (indent-code-rigidly beg end shift-amt "#")))
    (if (and (not macro-tab-always-indent)
	     (save-excursion
	       (skip-chars-backward " \t")
	       (not (bolp))))
	(insert-tab)
      (macro-indent-line))))

(defun macro-indent-line ()
  "Indent current line as Macro code.
Return the amount the indentation changed by."
  (let ((indent (calculate-macro-indent nil))
	beg shift-amt
	(case-fold-search nil)
	(pos (- (point-max) (point))))
    (beginning-of-line)
    (setq beg (point))
    (cond ((eq indent nil)
	   (setq indent (macro-current-indentation)))
	  ((eq indent t)
	   (setq indent 2))
	  ((looking-at macro-definition)
	   (setq indent 0))
	  (t
	   (skip-chars-forward " \t")
	   (if (listp indent) (setq indent (car indent)))
	   (cond ((= (following-char) ?\])
		  (setq indent (- indent macro-indent-level))))))
    (skip-chars-forward " \t")
    (setq shift-amt (- indent (current-column)))
    (if (zerop shift-amt)
	(if (> (- (point-max) pos) (point))
	    (goto-char (- (point-max) pos)))
      (delete-region beg (point))
      (indent-to indent)
      ;; If initial point was within line's indentation,
      ;; position after the indentation.  Else stay at same point in text.
      (if (> (- (point-max) pos) (point))
	  (goto-char (- (point-max) pos))))
    shift-amt))

(defun calculate-macro-indent (&optional parse-start)
  "Return appropriate indentation for current line as Macro code.
In usual case returns an integer: the column to indent to.
Returns nil if line starts inside a string."
  (save-excursion
    (beginning-of-line)
    (if (save-excursion
	  (skip-chars-forward " \t")
	  (looking-at macro-definition))
	0
      (let ((stab (syntax-table))
	    (indent-point (point))
	    (case-fold-search nil)
	    state
	    containing-sexp)
	(unwind-protect
	    (progn
	      (set-syntax-table macro-mode-indent-syntax-table)
	      (if parse-start
		  (goto-char parse-start)
		(re-search-backward macro-definition nil 'move))
	      (while (< (point) indent-point)
		(setq parse-start (point))
		(setq state (parse-partial-sexp (point) indent-point 0))
					; state =
					;   (depth_in_parens
					;    innermost_containing_list
					;    last_complete_sexp
					;    string_terminator_or_nil
					;    inside_commentp
					;    following_quotep
					;    minimum_paren-depth_this_scan)
					; Parsing stops if depth in
					; parentheses becomes equal to
					; third arg (0).
		(setq containing-sexp (car (cdr state))))
	      (cond ((or (nth 3 state) (nth 4 state))
					; Inside comment or string?
		     (nth 4 state))	; return nil or t if should
					; not change this line
		    ((and containing-sexp
			  (/= (char-after containing-sexp) ?\[))
		     ;; line is expression, not statement:
		     ;; indent to just after the surrounding open.
		     (goto-char (1+ containing-sexp))
		     (current-column))
		    (t
		     (if (not (null containing-sexp))
			 ;; This line starts a new statement.
			 ;; Position following last unclosed open,
			 ;; or beginning of block.
			 (goto-char
			  (or containing-sexp parse-start (point-min)))
		       ;; Line is at top level.
		       ;; Back to beginning of def.
		       (re-search-backward macro-definition nil 'move)
		       (if (match-end 0) (goto-char (match-end 0))))
		     ;; Is line first statement after an open-bracket?
		     (or
		      ;; If no, find that first statement and indent like it.
		      (save-excursion
			(forward-char 1)
			(let ((colon-line-end 0))
			  (while (progn (skip-chars-forward " \t\n")
					(looking-at ";\\|[a-zA-Z0-9%$.]*:"))
			    ;; Skip over comments and labels following
			    ;; openbracket.
			    (cond ((= (following-char) ?;)
				      (forward-line))
				   ;; label:
				   (t
				    (save-excursion (end-of-line)
						    (setq colon-line-end (point)))
				    (re-search-forward macro-label)))))
			  ;; The first following code counts
			  ;; if it is before the line we want to indent.
			  (and (< (point) indent-point)
			       (not (bolp)) ;Must be indented
			       (current-column)))
			;; No previous statement
			(if (null containing-sexp)
			    ;; At outer level, indent default amount
			    macro-indent-level
			  ;; If inside bracket,
			  ;; indent it relative to line bracket is on.
			  ;; For open bracket in column zero, don't let statement
			  ;; start there too.  If macro-indent-level is zero,
			  ;; use macro-bracket-offset instead.
			  ;; For open-brackets not the first thing in a line,
			  ;; add in macro-bracket-imaginary-offset.
			  (+ macro-indent-level
			     ;; If the openbracket is preceded by a parenthesized exp,
			     ;; move to the beginning of that;
			     ;; possibly a different line
			     (progn
			       (skip-chars-backward " \t")
			       (if (eq (preceding-char) ?\])
				   (forward-sexp -1))
			       ;; Get initial indentation of the line we are on.
			       (macro-current-indentation))))))))
	    (set-syntax-table stab))))))

(defun macro-beginning-of-function (&optional arg)
  "Move backward to next beginning-of-function, or as far as possible.
With argument, repeat that many times; negative args move forward.
Returns new value of point in all cases."
  (interactive "p")
  (or arg (setq arg 0))
  (or (< arg 0) (setq arg (1+ arg)))
  (if (= arg 0) nil
    (forward-line (if (< arg 0) -1 1))
    (re-search-backward macro-function
			nil 'move arg))
  (point))

(defun macro-end-of-function (&optional arg)
  "Move forward to next end-of-function.
The end of a function is found by moving forward from the beginning of one.
With argument, repeat that many times; negative args move backward."
  (interactive "p")
  (or arg (setq arg 1))
  (if (= arg 0) nil
    (forward-line (if (< arg 0) 0 1))
    (re-search-forward macro-function nil 'move arg)
    (beginning-of-line nil))
  (point))

(defun mark-macro-function ()
  "Put mark at end of Macro function, point at beginning."
  (interactive)
  (push-mark (point))
  (macro-end-of-function)
  (push-mark (point))
  (macro-beginning-of-function)
  (backward-paragraph))

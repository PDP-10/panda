
(defvar nroff-mode-abbrev-table nil "\
Abbrev table used while in nroff mode.")

(defvar nroff-mode-map nil "\
Major mode keymap for nroff-mode buffers")

(if (not nroff-mode-map) (progn (setq nroff-mode-map (make-sparse-keymap)) (define-key nroff-mode-map "	" (quote tab-to-tab-stop)) (define-key nroff-mode-map "s" (quote center-line)) (define-key nroff-mode-map "?" (quote count-text-lines)) (define-key nroff-mode-map "
" (quote electric-nroff-newline)) (define-key nroff-mode-map "n" (quote forward-text-line)) (define-key nroff-mode-map "p" (quote backward-text-line))))

(defun nroff-mode nil "\
Major mode for editing text intended for nroff to format.
\\{nroff-mode-map}
Turning on Nroff mode runs text-mode-hook, then nroff-mode-hook.
Also, try nroff-electric-mode, for automatically inserting
closing requests for requests that are used in matched pairs." (interactive) (byte-code "͈� ��!�Љ�щ��!�����!���!�Չ���!��P����!��P����!�׉	���!�؉
���!�ى���!�ډ����\"�" [nroff-mode-map mode-name major-mode text-mode-syntax-table local-abbrev-table nroff-mode-abbrev-table page-delimiter paragraph-start paragraph-separate comment-start comment-start-skip comment-column comment-indent-hook nil kill-all-local-variables use-local-map "Nroff" nroff-mode set-syntax-table make-local-variable nroff-electric-mode "^\\.\\(bp\\|SK\\|OP\\)" "^[.']\\|" "\\\" " "\\\\\"[ 	]*" 24 nroff-comment-indent run-hooks text-mode-hook nroff-mode-hook] 14))

(defun nroff-comment-indent nil "\
Compute indent for an nroff/troff comment.
Puts a full-stop before comments on a line by themselves." (byte-code "`��!�n� T���c�Ƃ3 ���!���!)�( Ƃ3 	���i�\\�\"\"]))�" [pt comment-column ((byte-code "b�" [pt] 1)) skip-chars-backward " 	" 46 1 backward-char looking-at "^[.']" * 8 / 9] 9))

(defun count-text-lines (start end &optional print) "\
Count lines in region, except for nroff request lines.
All lines not starting with a period are counted up.
Interactively, print result in echo area.
Noninteractively, return number of non-request lines from START to END." (interactive "r
p") (byte-code "È� ���	
\"\"�# ���	
\"�eb�� �� !Z))�" [print start end nil message "Region has %d text lines" count-text-lines narrow-to-region buffer-size forward-text-line] 8))

(defun forward-text-line (&optional cnt) "\
Go forward one nroff text line, skipping lines of nroff requests.
An argument is a repeat count; if negative, move backward." (interactive "p") (byte-code "��?�
 ��V� m?�6 ��!�m?�\" ��!�, ��!�� ��Z��� ��W�? o?�b ��!�o?�N ��!�X ��!��F ��\\���7 ��" [cnt nil 1 0 forward-line looking-at "[.']." -1] 9))

(defun backward-text-line (&optional cnt) "\
Go backward one nroff text line, skipping lines of nroff requests.
An argument is a repeat count; negative means move forward." (interactive "p") (byte-code "���[!�" [cnt nil forward-text-line] 2))

(defconst nroff-brace-table (quote ((".(b" . ".)b") (".(l" . ".)l") (".(q" . ".)q") (".(c" . ".)c") (".(x" . ".)x") (".(z" . ".)z") (".(d" . ".)d") (".(f" . ".)f") (".LG" . ".NL") (".SM" . ".NL") (".LD" . ".DE") (".CD" . ".DE") (".BD" . ".DE") (".DS" . ".DE") (".DF" . ".DE") (".FS" . ".FE") (".KS" . ".KE") (".KF" . ".KE") (".LB" . ".LE") (".AL" . ".LE") (".BL" . ".LE") (".DL" . ".LE") (".ML" . ".LE") (".RL" . ".LE") (".VL" . ".LE") (".RS" . ".RE") (".TS" . ".TE") (".EQ" . ".EN") (".PS" . ".PE") (".BS" . ".BE") (".G1" . ".G2") (".na" . ".ad b") (".nf" . ".fi") (".de" . ".."))))

(defun electric-nroff-newline (arg) "\
Insert newline for nroff mode; special if electric-nroff mode.
In electric-nroff-mode, if ending a line containing an nroff opening request,
automatically inserts the matching closing request after point." (interactive "P") (byte-code "ň�� �	?�! 
�! `d�ZX�! ��`�`\\\"\"A)��!??�5 ��	!!�F ���\"��A �c)���!*�" [completion arg nroff-electric-mode nroff-brace-table needs-nl nil beginning-of-line 3 assoc buffer-substring looking-at "[ 	]*$" newline prefix-numeric-value insert "

" "
" forward-char 1] 9))

(defun electric-nroff-mode (&optional arg) "\
Toggle nroff-electric-newline minor mode
Nroff-electric-newline forces emacs to check for an nroff
request at the beginning of the line, and insert the
matching closing request if necessary.  
This command toggles that mode (off->on, on->off), 
with an argument, turns it on iff arg is positive, otherwise off." (interactive "P") (byte-code "ň�=� ��!���	\"� �	�C\"��?�% 
?�* �!�V��" [major-mode minor-mode-alist nroff-electric-mode arg t nil nroff-mode error "Must be in nroff mode" assq append (nroff-electric-mode " Electric") prefix-numeric-value 0] 6))

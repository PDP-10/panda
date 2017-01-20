@define dsk: dsk:, ps:<victor.clisp>
@link
*boot
*sys:forlib/seg:low/s
*/g
@start
*(load "cboot.clisp")
*(lisp::remove-arg-docs)
*(lisp::purify)
*(push :experimental *features*)
*(save "new.exe" (concatenate (quote string) "New Experimental Common Lisp, "
*				     (lisp-implementation-version)))
*(exit)
@vdir new.exe,
@check seq
@
@
midas::
@clisp:midas boot
compil::
@clisp:clisp
*(in-package "LISP")
*(compile-file "array")
*(exit)
@
;@define dsk: dsk:, clisp:
link::
@link
*boot
*sys:forlib/seg:low/s
*/g
start::
@start
*(setq *load-verbose* t)
*(load "cboot.clisp")
*(load "upsala.clisp")
*(make-feature :upsala)
*(lisp::remove-arg-docs)
*(lisp::purify)
*(lisp::gc)
;*(push :experimental *features*)
save::
*(reboot "new.exe" "Uppsala")
@vdir new.exe,
@check seq
@
@
@original logout
%err::
@original logout

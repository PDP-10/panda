;@define dsk: dsk:,ss:<clisp.new.upsala>
;@define clisp: ss:<clisp.new.upsala>
@link
*boot
*sys:forlib/seg:low/s
*/g
@keep
@start
*(setq *load-verbose* t)
*(load "cboot.clisp")
*(load "upsala.clisp")
*(make-feature :upsala)
*(lisp::remove-arg-docs)
*(lisp::purify)
*(lisp::gc)
*(reboot "new.exe" "Uppsala")
@original logout
%err::
@original logout

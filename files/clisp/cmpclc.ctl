;@define dsk: dsk:, ps:<victor.clisp>
@link
*boot
*sys:forlib/seg:low/s
*/g
@operator 1
@start
*(setq *load-verbose* t)
*(load "lclc.clisp")
*(load "cmpclc.clisp")
*(exit)
@modify batch ccomp /dep:-1
@original logout

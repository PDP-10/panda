@link
*boot
*sys:forlib/seg:low/s
*/g
@start
*(setq *load-verbose* t)
*(load "lclc.clisp")
;*(load "cmpclc")
*(load "cmprest")
*(exit)
@logout

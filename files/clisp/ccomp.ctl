;;; Start here (or without /TAG:) to compile everything in 
;;; a freshly booted CLISP
;@define dsk: dsk:, ps:<victor.clisp>
@link
*boot
*sys:forlib/seg:low/s
*/g
@start
@goto clisp
;;; Start here (/TAG:NOBOOT) to compile in an existing CLISP.
noboot::
;@define clisp: ss:<clisp.new.upsala>
@clisp
clisp::
@operator 1
*(setq *load-verbose* t)
*(load "lclc.clisp")
;*(load "cmpclc")
;*(load "cmpall")
*(load "cmpupsala")
*(exit)
@modify batch clisp /dep:-1
@original logout
%err::
@Please get Victor's attention!
@original logout

!*-*-teco-*- IVORY compressor!
!* [BBNG]PS:<EMACS.NEW>COMPLAIN.EMACS.3,  1-Jan-83 03:33:52, Edit by FHSU!
!~filename~:! !For sending mail to last editer of a file!
COMPLAIN

!Bitch at Last Editer of This File:! !C ... just that.
Look for a Date Edit line at beginning of file, then set up Babyl
mail sending template with last editer as primary recipient.!

[0[1[2[3[4
1u4					!* 4: no edit header yet!
.( j l -:s-*-"n 2l'			!* skip over mode line!
   -:sEd: Edit by Edit by: "e	!* look for an edit line!
       @ft
No Date Edit line found. 0fsechoac'"#
   fkc
   0u4					!* say edit header found!
   .u0					!* save beginning of name!
   :l					!* to end of name, maybe host!
   qComment Endf"nu1
    .,q0:fb1w' 			!* back up over comment end!
   q0,.f x1				!* 1: user name, maybe host!
   0l qComment Startf"nu2
    .,q0:fb2w'			!* past comment starter!
   .u0 s, r q0,.f x3			!* 3: file name!
   :l .u0 0l				!* set bounds for search!
   .,q0:fb["n				!* 2: 0 or host name!
     .u2 .,q0:fb]"e :i* Unmatched parens in edit line fg '
     q2,.-1f x2'			!* get host name, BBN style!
     "# 0u2'
   'w)j					!* leave point untouched!

q4"n '				!* nothing more to do!

   1,m.m& Mail Messagef"nu4'"#		!* see if a mail sender library!
					!* is loaded already!
     m(m.mLoad Library)BABYLM		!* if not, load one!
     m.m& Mail Messageu4'w		!* need to load to get right setup!
   m(m.m& My Push to Buffer)*Mail*	!* select right buffer for babylm!
   j iTo:  g1 q2"n i@ g2' i
Re:  g3 i
 gBabyl Header/Text Separator i
 1m4					!* continue editing!
   

!& My Push To Buffer:! !S Push-select buffer STRARG.
When caller returns, the original buffer will be re-selected.!
!* Minor assumption: caller cant use a STRARG with ^]..N (heh heh...)!
!* this taken from Babyl proper but renamed so wont conflict!

 [Previous Buffer			!* save previous buffer!
 qBuffer Name[0			!* 0: Original buffer name.!
 @:i*|m(m.mSelect Buffer)0|(]0)[..n	!* Make cleanup handler that will!
					!* select back to the original buffer.!
					!* Pop Q0 since not needed any more.!
 m(m.mSelect Buffer)		!* Select the buffer that caller wants!
 ff&1"e				!* numarg: dont clear this buffer.!
   0j					!* beginning of buffer!
   b,zdw'				!* get rid of last times!
 0fsModifiedw 0fsXModifiedw		!* but say not modified!
 :					!* Exit without popping ..N etc. so!
					!* that when caller returns, we!
					!* select back.!

!* local modes:
 * compile command: m(m.m1Generate)
 * end:
 *!
   
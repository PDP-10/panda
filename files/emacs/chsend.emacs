!*-*-teco-*-*!
!~filename~:! !Chaos TTY message from an EMACS!
CHSEND

!<ENTRY>:! !ChSend:! !S Do a CHAOSnet TTY send. Given an argument, doesnt
kill previous message contents. Otherwise, start new message.
!
 0FO..QPersonal Name"e			!* does this guy have a name?!
  0FO..QBabyl Personal Name"e		!* Babyl name?!
   fs xunamem.vPersonal Namew'	!* no. use login name!
   "#
   qBabyl Personal Namem.vPersonal Namew''
  
 qPersonal Name[0			!* who am i!
 ff&1"n
   1m(m.m& My Push to Buffer)*CHSend*'
 "# m(m.m& My Push to Buffer)*CHSend*'
   3,m(m.m& Read Line)Send to: [1
   fsMachine[2
   fs xunam[3				!* login ID!
   0fsModifiedw 0fsXModifiedw		!* but say not modified!
   :i*Cfsechodisp
   -(-1,@fzEMACS:ECHSEND.EXE.0 1
3@2 (0)				!* loginID@host (personal name)!
..O					!* message!
)fzw 0fsechoac			!* and end with ^Z!
   ]3 ]2 ]1 ]0 0			!* cleanup!
 m..N					!* exit macro!
 

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
 					!* and let user edit!
 :					!* Exit without popping ..N etc. so!
					!* that when caller returns, we!
					!* select back.!


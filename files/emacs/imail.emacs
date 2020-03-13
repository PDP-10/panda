!*-*-teco-* this file to be compressed with IVORY!
!* <LAMB.LIB>IMAIL.EMACS.2 15-Aug-82 15:38:32, Edit by FHSU!
!~Filename~:! !Send mail with IPCF Mailer!
IMAIL

!& Setup IMAIL Library:! !S Define things needed by IMAIL
Makes a q-vector & RCUSR code containg code that & RCUSR
needs to run.!

!*This is code to do RCUSR, given address of string in ac3, returns user number
  as value (ac1).  Returns 0 on failure (monitor feature: rcusr doesn't change
  ac3 if fails) !

15*5fs q vectorM.V& RCUSR code
q& RCUSR code[0	!* Make code to do the RCUSR!
!* skip !		330000000000.u:0(0)
!* push p,2 !		261740000002.u:0(1)
!* push p,3 !		261740000003.u:0(2)
!* hrro 2,3 !		560100000003.u:0(3)
!* movsi 1,(rc%emo) !	205040000001.u:0(4)
!* setz 3, !		400140000000.u:0(5)
!* RCUSR !		104000000554.u:0(6)
!* move 1,3 !		200040000003.u:0(7)
!* trz 0,1 !		620000000001.u:0(8)
!* pop p,3 !		262740000003.u:0(9)
!* pop p,2 !		262740000002.u:0(10)
!* aos (p) !		350017000000.u:0(11)
!* ret !		263740000000.u:0(12)
			!* End of rcusr code and setup hook!

!& RCUSR:! !S Do RCUSR on string argument
Accepts a user name as string argument and returns the user
number (36 bit style)!
f[bbind		!* Temp buffer!
i			!* insert user name in buffer!
0i			!* tie off with null!
[0			!* Save q0!
q& RCUSR code[..O	!* select code as buffer !
fs real address/5u0	!* addr to execute to 0!
]..O			!* Restore old buffer!
fs real address/5m0
!* Give addr of user name to code, pass on result !

!& Immediate Mail:! !S Send mail using IPCF mailer
Accepts text of message as string numarg and list of recipients in current
buffer.  Recipients are in format USER@SITE, crlf, USER at SITE, crlf.  Local
recipients are delivered locally and deleted from the buffer.!

!* This function works by writing a temporary file called
   MSG.TMP, then invoking a program as an inferior which sends
   to MAILER to get the mail delivered, and returns a message
   by RSCANing a string, and initializing rscan buffer to read!

!* Format of MSG.TMP file:
	word 0:	    FL%MM (bit 0) -- suppresses mailer from generating a header
			(this bit does not exist on all systems)
	word 1-n:   list of user numbers to send to.
	words n+1,n+2:	both 0 -- delimits recipients from text
	rest of file:	message in asciz.    !

[0[1[2[3[4[5[6		!* Save temp regs!
q..ou2			!* 2: recip-list buffer!
f[BBind q..ou3 q2[..o	!* 3: Temp buffer, stay in old one, make unwind win!
q3u..o 5,0i 400000000000.,0fs word
	!* Start with MM flag, this prevents MAILER from changing header !
q2u..obj
fsmachineu0			    !* 0: machine name!
0u5				    !* 5: 1 means seen non-local mail!
j <:s@;
   :x1				    !* host name to q1!
   f~10"n j 1u5 0;'		    !* do queue all!
   fkc .u1 0l .,q1x1 2l		    !* Get local user to q1!
   m(m.m& RCUSR)1u4		    !* User number to 4!
   q4"e				    !* zero = error!
     j 1u5 0;'			    !* tough luck. gotta queue ya!
   q3u..o 5,0i			    !* Output buffer, insert one word!
   q4,.-1fs word		    !* Put Usernumber in!
   q2u..o >			    !* Back to list, go for more!
q5"n 1'			    !* say queue me, please!
q3u..o				    !* Output buffer!
10,0i				    !* Two 0 words for delimiter!
g()				    !* Put message text after header!
fs xunameu1
etps:<1>msg.tmp		    !* write into logged-in directory!
ei h@p ef
fs o fileu1
@ft(Local Mail...
-(1,@fzEMACS:IMMEDIATE-MAIL.EXE 1)fz !* Tell MAILEX to mail it!
f[b bind			    !* Work in temp buffer!
<				    !* loop to read reply from rscan!
  fs listen"E			    !* If run out of input early,!
   :i*Success unknown:..ofs err'
				    !* Complain!
    fiu1 q1-177.@; q1i>		    !* Insert until DEL(end mark from program)!
hf=OK"E			    !* see if program says ok!
    @ftDelivered Sucessfully)0fs echoac'
"#:g..ofserr 1'		    !* Pass (copy) error to error handler!
0				    !* exit with success!


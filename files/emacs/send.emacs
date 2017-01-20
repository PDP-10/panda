!~Filename~:! !Send receive terminal messages on TOPS-20!
SEND

!Send Message:! !Send:! !To:!
!C Send terminal message by invoking SEND program
Usage is MM Tousertext of message.  Because the SEND program
cannot communicate with EMACS, an error message, if any,
will be left on the screen and EMACS will not know about it!
!* Send Message is the official name of this macro, which
   Reply will use.  Send and To are synonyms!
[0[1
:i0			!* Start with null!
:F"G			!* See if from ^R!
    [0 :i0'	!* No, Get STRARG to 0!
fq0"E1,m(m.m & Read Line)Send to user:F"E w'u0'
    !* If arg null, then read from user, abort if he deletes!
:i1:F"G[1 :i1'fq1"E
    1,m(m.m & Read Line)Message:F"Ew'u1'

-(@Fzsys:send.exe 0 1
)FZ

!& Find Previous Send:! !Return NUMARG previous sends as value!
 [0[1[2
 f[b bind				!* Temp buffer!
 fs unameu1
 1:<ERps:<1>SENDS.TXT>"N		!* Get our sends text!
   :i*No SENDS.TXTfserr'		!* Not there!
 @Y					!* Read it all in!
u2 q2"E1u2'				!* Get number of messages, or 1!
!* Look backward from end of buffer for Nth ALT or  on a
 line by itself!
zj -q2:s



"E b+1,z:G..o'"#.+3,z:G..o'
 !* Return copy from buffer of start of Nth previous message
    up through end of buffer.  If this message is the first,
    there is a ESC CRLF before it, otherwise CRLF ESC CRLF !

!What Send:! !C Print messages from SENDS.TXT
Prints last NUMARG messages you received, defaults to 1!
 M(M.M & Find Previous Send)[1 FT1

!Reply to Send:! !C Send to person sending last message
NUMARG = reply to that many messages previous to last one,
default is 1!
[0[1[2[3
 M(M.M & Find Previous Send)u1	!* Get message!
f[b bind g1			!* Into buffer!
j 1a-"E l '			!* Skip blank line!
:sTTY message+1"E		!* If begins with TTY message!
    L'				!* Skip this line!
.u0 s, .-1u1			!* Now destination in range q0...q1!
q0,q1:FB at "l q1+fk+1u1 fkd i@'	!* Replace at with @ and backup q1!
q0,q1x1				!* q1 has destination!
:i2:F"G[2 :i2'fq2"E	!* For explanation see send message!
    1,m(m.m & Read Line)To 1:F"Ew'u2'
M(M.M Send Message)12

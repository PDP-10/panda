!* -*- Teco -*- 		Library created and maintained by KMP@MC !

!~Filename~:! !Pseduo Tags Hack for people who don't like tags tables!
MINI

!& Setup MINI Library:! !& Set things up for our neat library!

m.m^R_Mini-Find_Tagu..,	    !* Put Mini-Find on M-,	!
m.m^R_Mini-Visit_Tagu...,	    !* Put Mini-Visit on C-M-,	!



!& Kill MINI Library:! !& Kill our library !

1,m.m^R_Mini-Find_Tag  - q.., "e 0u.., '
1,m.m^R_Mini-Visit_Tag - q...,"e 0u...,'



!^R Mini-Visit Tag:! !^R Get recursive edit on tag in current buffer.!

1,(f):m(m.m^R_Mini-Find_Tag)


!^R Mini-Find Tag:! !^R Search for tag in current buffer. 
Defaults are kept per-mode. The following modes are permitted:
Lisp, Scheme, Teco, Midas, Schlap !

[0[1[2[3[4[5[6[7[8[9[B		    !* Bind qregs needed	!
qModeu0			    !* Get mode in q0		!
:i*fo..QLast_0_Mini-Tagu1	    !* Get default in q1	!
1:< o0 >			    !* Try to find tag to use	!
				    !* If we get here, we lost  !
:i*USM	Unsupported_Mode:_0 fserr

 !* Note: If q3 does not contain a linefeed, repeated calls to	!
 !*	  C-U M-, and C-U C-M-, will lose by finding same tag	!
 !*	  repeatedly unless user types C-N on his own		!

!Schlap! 
!Midas! >

  :i3 
 			    !* Search from head of line	!
  :i4 :  			    !* Require a : on line	!
  oDo-It			    !* !

!Teco! >
  :i3 
! 	    !* q3: leading text		!
  :i4 :! 		    !* q4: trailing text	!
  oDo-It			    !* Go do the search		!

!Scheme!
!Lisp! >
  :i3 
(DEF
(SET		    !* q3: leading text		!
  :i4 				    !* q4: trailing text	!
  oDo-It			    !* Go do the search		!

				    !* -- The search itself -- *!

!Do-It!				    !* Come here to search	!
  qBuffer_NameuB		    !* Remember this buffer	!
  .u7 .u9			    !* Remember starting point	!
  fn qBm(m.mSelect_Buffer) q7j  !* Come back here when done !
  ff&1"n			    !* If explicit arg,		!
    q1u2			    !*  Use default string	!
    :i*No_more_such_tagsu8	    !*  Set up error message	!
    oArg-Given'		    !*  Skip prompt		!
  "# j				    !* Else, jump to buffer top	!
     :i*No_such_tagu8'		    !*  and set up other errmsg	!
  ff&2"e
    1,fFind_0_Def_(1):_u2'   !* Prompt for tag		!
  "# 
    1,fVisit_0_Def_(1):_u2'
  fq2"l 0'			    !* Overrubout means ignore	!
  fq2"e q1u2 '			    !* Use the default		!
     "# q2m.vLast_0_Mini-Tag '   !* Make new form default	!
!Arg-Given!			    !* Come here if arg given	!
 < :s3"e			    !* Find first string	!
      q7j :i*8:_2 fserr'    !*  Erring if none like it	!
    fq4"e oInside '		    !* Maybe skip next check	!
    :fb4"l !Inside!		    !* Check for 2nd string	!
     0l :fb2"l fkc		    !* Check for stuff user gave!
      fq4@;			    !* Match if no trailer	!
      :fb4:;'' >		    !* Match if trailer follows	!
 0l q7:w .u7			    !* Update the value of here !
 ff&2"n			    !* If an arg,		!
    [Last_0_Mini-Tag	    !* Bind tag default		!
    [Editor_Type		    !* Bind Editor Type		!
    qEditor_Type[0		    !* Get old editor type	!
    fq0"g :i0,_0 '		    !* Maybe add prefix		!
    :iEditor_Type20	    !* Set up new editor type	!
    1fsmodech			    !* Need to change modeline	!
     q9u7 '			    !* Edit and return to start	!
 0				    !* If we go here, Unwind    !

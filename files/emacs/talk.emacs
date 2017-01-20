!* -*-TECO-*-!
!* <EMACS>TALK.EMACS.29,  5-Feb-81 22:40:11, Edit by GERGELY!

!~Filename~:! !Library to simplify TALKING between different terminal Types.!
TALK

!& Setup TALK Library:! !Put ^R TALK on C-X Y and ^R Receive Link on C-X C-Y.!

    0 fo..Q TALK_Setup_Hook [0 Q0"N :M0'   !* Call this if defined!
    m.m^R_TALKu:.x(Y)
    m.m^R_Receive_Linku:.x()
    m.vCRL_List
    m.vCRL_Prefix
    [..o 150 fsBCreate
330000000000.,0*5fsWord   !* S: SKIP                ;TECO Incantation!
511440000000.,1*5fsWord   !*    HLLZI   11,0        ;Clear error flag!
205040000001.,2*5fsWord   !*    MOVSI   1,1         ;Set flags for RCUSR!
205100440700.,3*5fsWord   !*    MOVSI   2,440700    ;Make a Byte pointer!
541105000036.,4*5fsWord   !*    HRRI    2,U-S(5)    ; to user name!
104000000554.,5*5fsWord   !*    RCUSR               ;Get his number!
603040040000.,6*5fsWord   !*    TLNE    1,40000     ;Did that work!
254005000032.,7*5fsWord   !*      JRST    N-S(5)    ; No-No such user!
200340000003.,8*5fsWord   !*    MOVE    7,3         ;Save his number in AC7!
201300000040.,9*5fsWord   !*    MOVEI   6,40        ;Start with terminal 32.!
201046400000.,10*5fsWord  !* L: MOVEI   1,400000(6) ;Make a terminal pointer!
561100000010.,11*5fsWord  !*    HRROI   2,10        ;Put user number here!
551140000002.,12*5fsWord  !*    HRRZI   3,2         ;Get only user number!
104000000507.,13*5fsWord  !*    GETJI               ;Try this terminal!
254005000021.,14*5fsWord  !*      JRST    T-S(5)    ; no good, try next!
316340000010.,15*5fsWord  !*    CAMN    7,10        ;Is it our man!
254005000023.,16*5fsWord  !*      JRST    F-S(5)    ; Yes,we found him!
367305000012.,17*5fsWord  !* T: SOJG    6,L-S(5)    ;Try next terminal!
254005000033.,18*5fsWord  !*      JRST    M-S(5)    ; Not logged in!
525040140000.,19*5fsWord  !* F: HRLOI   1,140000    ;Want a 2 way link!
201106400000.,20*5fsWord  !*    MOVEI   2,400000(6) ;With him!
104000000216.,21*5fsWord  !*    TLINK               ;Try it!
254005000034.,22*5fsWord  !*      JRST    R-S(5)    ; Link refused!
200040000011.,23*5fsWord  !* D: MOVE    1,11        ;Done - set flag!
350017000000.,24*5fsWord  !*    AOS     0(17)       ;Skip return to set value!
263740000000.,25*5fsWord  !*    POPJ    17,         ;And return!
271440000001.,26*5fsWord  !* N: ADDI    11,1        ;No such user = 3!
271440000001.,27*5fsWord  !* M: ADDI    11,1        ;Not logged on = 2!
271440000001.,28*5fsWord  !* R: ADDI    11,1        ;Refused = 1!
254005000027.,29*5fsWord  !*    JRST    D-S(5)      ;Done!
			   !* U:                     ;Where our arg goes!
    Q..o m.v TALK_Code
    


!& Ignore Input:! !S Reads and ignores (but echos most) input to ^Z.!

    0 f[ CLK INTERVAL 0[ ..F	    !* Don't allow interupts!
    0 f[ RGETTY -1 f[ ^R ECHO [0  !* Say that we have a hardcopy!
    1f[ no quit
    :<				    !* Errorset loop!
	FI u0 Q0- "E 0;'	    !* Quit on ^Z!
	Q0- "E :I*
	     fs IMAGE OUT !<!>'   !* If CR, echo CRLF!
	Q0-_ "L !<!>'		    !* Don't echo cntl chars!
	Q0- "E		    !* Rubout is Backspace!
	    :I*_ fs IMAGE OUT !<!>'   !* Space Backspace!
	Q0 fs IMAGE OUT >	    !* All else echos!
    				    !* Return!


!^R TALK:! !^R TALK to user <stringarg>.
If "TALK Usertable" is defined as an (FO type) table of usernames
then recognition and completion are available for those names. In
this case a numeric arg inhibits this.!

    1 f[^R Inhibit 0 f[Mode Change	    !* Don't touch anything!
    FF "E			    !* If no args!
	0 fo..QTALK_Usertable f"N [0	    !* and this is defined!
	    Q0 uCRL_List :I* uCRL_Prefix	    !* Do it this way!
	    2,m(m.m&_Read_Command_Name)TALK_to_user: u0'
	"# 1,FTALK_to_user: [0''
    "# 1,FTALK_to_user: [0'	    !* Else do it this way!
    Q0 "E ' Q0 :FC u0		    !* Quit if rubbed out, uppercase it!
    QTALK_Code[..O		    !* Get the talk function!
    zJ G0 0I			    !* Insert our argument!
    m(fsRealAddress/5) [1	    !* Make the LINK!
    Q1 "N			    !* Was there an ERROR?!
	Q1-1 "E			    !* if yes, then tell him!
	    :I*Link_Refused [2'    !* what the problem was!
	"# Q1-2 "E :I*User_0_Not_Logged_In [2'
	    "# Q1-3 "E :I*No_Such_User:_0 [2'
		"# :I*Error_in_^R_TALK [2'''	    !* Can't happen??!
	FG :I*C2 fsEchoDisplay
	0fsEchoActive 0'
    m(m.m&_Ignore_Input)	    !* Ignore what we do!
    Break
    Cont
     -1 FS PJATY W 		    !* Say screen munged and proceed!



!^R Receive Link:! !^R Accept a link.!

    1 f[^R Inhibit 0 f[Mode Change	    !* Don't touch anything!
    :I*Z fs ECHO DISPLAY
    Rec_L
    Cont
    				    !* Say we want it!
    m(m.m&_Ignore_Input)	    !* Ignore what we do!
    BREAK
    REF_L
    CONT
     -1 FS PJATY W		    !* Say screen munged, then refuse more!



!& Make Table:! !& Makes a table (ala FO) with the name <stringarg>.
Numeric arg (default 1) is the entry size. Leaves QV bound to a macro
to insert entries into the table.!

    :I*[0
    FF "N ' "# 1' [1
    5 fs Q Vector m.v0
    Q1 u:0(0)
    @:IV\ :I*[0 Q0[1
        Q1 [..o @:fo10 [2
        -Q2u2 Q2 "L ' Q2*5J
        Q:1(0)*5,0I Q0u:1(Q2) \
    

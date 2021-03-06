!* -*-TECO-*-!
!~Filename~:! !Hazeltine1510 Support Macros (also works for other hazeltines).!
HAZ1510

!Hazeltine:! !C Set up to take advantage of cursor keys.
It sets up Tilde as a prefix char, and defines the characters which
the keys send to do worthwhile functions.
	Right Arrow = ^H        = ^R Backward Character
	Left Arrow  = ^P        = ^R Forward Character
	Up Arrow    = <tilde>^L = ^R Up Real Line
	Down Arrow  = <tilde>^K = ^R Down Real Line
	D/L	    = <tilde>^S = ^R Kill Line
	I/L	    = <tilde>^Z = ^R Open Line
	Clear	    = <tilde>^\ = ^R New Window (^L)
	Home	    = <tilde>^R = ^R Goto Beginning 
	S-Lft=S-Rght= <tilde>^@ = ^R Kill Word
	S-Clear     = <tilde>^] = ^R Wipe Buffer
	S-Tab       = <tilde>^T = ^R Back To Indentation 

Beware, it does redefine ^P to be forward moving, instead of upward
moving.  To turn this off (your right arrow key will not work, either),
call M-X Hazeltine with any argument.

This also makes <tilde> a special character, so in order to insert
it, you must use ^Q!

!*If you're on a hazeltine, replace the tildes with something you can see and
				            recognize before you read this!

    0U.T			    !* So Make Prefix will work !
    m(m.mMake_Prefix_Character).TU~   !* Set up for <tilde> prefix!

    QPrefix_Char_List[0
    :I*0Tilde__Q.T 
UPrefix_Char_List   !* Put documentation on prefix!

    M.M^R_Up_Real_LineU:.T()   !* Up arrow is <tilde>^L!
    M.M^R_Down_Real_LineU:.T() !* Down arrow is <tilde>^K!
    M.M^R_New_WindowU:.T()	    !* Clear screen to redisplay!
    M.M^R_Back_To_IndentationU:.T()    !* Shift Tab = <tilde>^T!
    ff"E
        FS ^R INITU.P'	    !* Right arrow is Control-P, unless arg.!
     FS ^R INITUH	    !* Left arrow is backspace.!
     FS ^R INIT U:.T()	    !* I/L is <tilde>^Z.  Open a line.!
    M.M^R_Kill_LineU:.T()	    !* D/L is <tilde>^S!
    M.M^R_Goto_BeginningU:.T() !* Home is <tilde>^S!
    M.M^R_Kill_Whole_WordU:.T( )!* Shift-Left = Shift-Right is <tilde>^@!
    

!^R Kill Whole Word:! !^R Kill all of the current or next word.
The word killed is the one the pointer is in or next to,
or the first word to the right of the pointer.
A positive argument is a repetition count.
A negative argument means kill the previous word(s) instead.!

    [9 .[A			    !* Maybe don't append kill!
    0A"C -FWL'			    !* If inside word or at end, back up to start.!
    "L :M(M.M^R_Kill_Word)'    !* Neg arg => kill previous word.!
    1A:"C :FWL'			    !* Else if between words, move up to next word.!
    .[0
    :< FWL > 1:< :FWL> .[1	    !* Find end of nth word.!
    Q0,Q1:M(M.M&_Kill_Text)	    !* Kill & put in the kill ring!

 
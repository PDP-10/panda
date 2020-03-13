!* -*-teco-*- *!
!~FILENAME~:! !Library for defining Concept-100 keys.!
TEACH-C100

!Insert Teach-C100 Teco Commands:! !C String argument is definition filename.
Note that the string argument should be the name of the OBJECT file, the file
    produced by the M-X Make C100 Key Definition File command.
This command inserts into the buffer (which should be your init or VARS file
    -- it asks you which) a couple of lines of Teco commands that will read in
    a C100 key definition file, and type it to the terminal (in image mode) in
    order to define the C100 keys.
The Teco code includes a conditional so that the file is only printed if the
    terminal that you are using is a Concept-100.
See the description of MM Make C100 Key Definition File to find out how to
    create a c100 key definition file.!

    !* Note that we keep the comments so they will appear in init file.!

 ftThe buffer should contain either a VARS file (EVARS on ITS), or an init
file.  Teach-C100 needs to know which it is, so it can use the proper format.
It the buffer a VARS file		!* Prompt.!
 m(m.m& Yes or No)"n			!* Yes, buffer has a VARS file.!
   @i|
	The following lines of Teco code reads in the C100 key definition file
	and blast it out to the terminal in image mode; this is only done if
	the terminal type is C100:
*: fsRGETTY-15"e f[BBind f[DFile er @y hx*fsImageOutw f]DFile f]BBind'

|'					!* Just one long line, to avoid!
					!* problems in EVARS file with quoting!
					!* an n-line value with quotes in it.!

 "#					!* Buffer has an init file.!
   @i|
      !* The following 4 lines of Teco code read in the C100 key definition
	 * file and blast it out to the terminal in image mode.  This is only
	 * done if the terminal type is C100.!
     fsRGETTY-15"e			!* If C100...!
	f[BBind f[DFile er @y	!* then read file,...!
	hx*fsImageOutw		    	!* blast it out...!
	f]DFile f]BBind'		!* and then restore things.!
|'
 

!Make C100 Key Definition File:! !C Asks for source and object filenames.
Asks for a source file, which contains InterLisp-like forms that define what
    keys should be redefined to send.
Asks for the object file, which will contain the exact string to send to
    the terminal to define the keys.  See the Insert Teach-C100 Teco Commands
    function for inserting something into your EMACS init file.
Finally, after compiling, asks if it should redefine the keys now.!

 [1[2[3 f[DFile
 etDSK: fsHSNamefsDSNamew etC100-KEYS >	    !* Default key filename!
 m(m.m& Read Filename)Source filef"e'u1	    !* 1: key filename!
 etC100-KEYS IMAGE		    !* Default compiled file name.!
 m(m.m& Read Filename)Object filef"e'u2 !* 2: Compiled filename.!
 f[BBind			    !* Temporary buffer.!
 e[ e\ fn e^ e]		    !* Push I/O channels.!
 er1 @y			    !* Read in key file.!
 fsIFileu3 :ftCompiling 3...    !* Tell user the full source filename.!

 1f<!OK!
    1f<!Abort Teach-C100!
       1m(m.m& Compile C100 Key Buffer)u1	!* Convert InterLisp macro!
			!* forms in buffer to image mode string to blast.  The!
			!* 1 argument says to print names of keys as compiled.!
			!* 1: Total local memory use.!
       f;OK		!* Returned, so we are ok.!
       >w 		!* It aborted, so we return.!
    >w			!* OK catch.!

 et2 eihpef			    !* Write out to compiled file.!
 fsOFileu3 ft done.
Image file is 3.
Total use of local memory will be  q1:= ft characters.
					!* Tell user full compiled filename!
					!* and how much local memory used.!
 @ft
Should the keys be redefined now	!* Prompt.!
 1m(m.m& Yes or No)"n			!* Yes, redefine now.!
    hx*fsImageOutw'			!* Blast buffer out to terminal.!
 ftDone.
 

!Show C100 Keys:! !C Until user types Control-G.
Prints description of each character of key as user types it, with each
    character separated by a space, e.g. it might print "Altmode X t o p
    Altmode" if you type a key which sends "Xtop".
If nothing is received after a second, it figures the key is done sending
    things, and it prints a carriage-return linefeed.
For example, if you want to see what the F1 and F2 keys send, type F1, look at
    the sequence it prints, wait a second, type F2, look at the sequence, and
    then end by aborting the command by typing Control-G.!

 :ftType a Control-G to quit out of this.

 <  fim(m.m& Charprint)	    !* Print next character of key.!
    ft 			    !* Separate characters in key.!
    30:"e			    !* Nothing for a second.!
      ft
     '				    !* So separate keys.!
    >
 

!& Compile C100 Key Buffer:! !S Convert lispish buffer to image string.
NUMARG non-0 says to type names of keys as they are compiled, so that if an
    error occurs, the user has some idea where.
If first syntax-check fails, we print help and throw to Abort Teach-C100.
Returns total local memory use, i.e. sum of lengths of all redefinition
strngs.!

 [1[2[3[4[5[..d 0f[VB 0f[VZ
 m(m.m& Make C100 Key File ..D)u..d	!* Set dispatch table.!
 m(m.m& Make C100 Key Name Variables)

 !* First a quick check of syntax, to be helpful and spot a common bug or two!
 !* -- especially having to do with % quoting.!

 j :< @f
	 l .-z;			!* Past whitespace.!
      @fll				!* Past an s-expression.!
      >"n				!* S-expressions not balancing.!
	  ft
** Syntax is not a buffer of balanced s-expressions.  Check for any suspicious
   use of %, the quote character.  E.g. if you want a % in your string, you
   need to use %%.  Aborting compilation.	!* ...!
	  f;Abort Teach-C100'		!* Abort.!

 j @i|U$|				!* Start out with programmers mode!
					!* command to C100 and reset function!
					!* keys.!
 0u5					!* 5: Will count total number of!
					!* characters in redefinitions, so!
					!* that user can see if it overflows!
					!* the local memory in the terminal.!
 !* Now map over each form in buffer, translating it into image: !
 !* (Note that CR LF is converted to just CR which may surprise the user!
 !* sometimes but probably so would leaving CR LF. User can always either put!
 !* a quote between the CR and LF or else use CR LF LF.!

 <  0fsVZw @f
	 k .-z;			!* Wide bounds, kill whitespace.!
    1a-("n				!* Next thing better be (.!
      :i*Encountered something other than "(" at top levelfsErr
      !''!'				!* ...!
    @fl fsBoundariesw			!* Bounds around next form.!
    c @flf(x1)l				!* 1: CAR of form, move past.!
    f=1*"e hk !<!>'			!* Kill comment and repeat.!
    f~1Transmit"n f~1Local"n f~1Quote"n	!* Only legals besides *.!
      :i*1 illegal CAR of form -- use *, Transmit, Quote, or LocalfsErr
      '''				!* Error, rather than continue???!
    f~1Quote"e -1u4'			!* 4: -1 is hacky signal that is quote!
    "# f~1Transmit"e 34u4'		!* 4: Character that says to transmit.!
    "# 35u4''				!* 4: Character that says command is!
					!* to be local to the terminal.!
    q4:"l				!* If Local/Transmit pick up keyname.!
      :@fll @flf(x1)l			!* 1: Keyname, move past.!
      "n ft1, '			!* Type keyname if NUMARG non0.!
      0fo..qC100K 1 Xu2		!* 2: Translation for keyname, a!
					!* number.!
      q2"e :i*1 is not a legal C100 key namefsErr''	!* ...!
    :@fll 0,1a-""n :i*String does not begin with a "fsErr!'!
		     ' !'!		!* ...!
    @flx3				!* 3: String.!
    fq3-1:g3-""n :i*String does not end with a "fsErr!'!
		   ' !'!		!* ...!
    hk g3 jd zj-d			!* Insert string, remove dquotes.!
    j <:s
      ; fkd 15.i>			!* CR LF to just CR.!
    j <:s%; -d c >			!* Remove quotes.!
    zj					!* Leave point at bottom if quote.!
    q4:"l				!* If Local or Transmit, make command.!
      hfx3				!* 3: String, converted.!
      fq3-95"g !"!:i*1's string is too long -- max length is 95fsErr'
					!* 95 since length+32 sent.!
      fq3+q5u5				!* 5: Update total local memory use.!
      @i|4|				!* Start C100 command.!
      32+(fq3)i				!* Insert character which tells the!
					!* string length.!
      q2i				!* Insert the key number character.!
      q4i				!* Character that says this string is!
					!* to be transmitted to host or local.!
      g3' >				!* The string.!
 
 q5					!* Return total local memory use.!

!& Make C100 Key File ..D:! !S Return a suitable ..D.!
 :i*                                                                                                                                        A                             A    |    A         /    A    '    (    )    A    A         A         A   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA    A    A    A    A    A    A    A   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA    A    A    A    A    A    A   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA    A    A    A    A         
				    !* CONS and return a ..D.!

!& Make C100 Key Name Variables:! !S Give them number translations.
Set up ..N to kill the variables later when caller returns.!

 @fn|					!* ..N: Set a cleanup handler to get!
					!* rid of these variables when our!
					!* caller returns.! 
     q..q[..o				!* Temporarily select the symbol table!
					!* buffer.!
	:fo..qC100K   *5,(		!* Kill from the first C100K!
	    :fo..qC100K!  *5)k		!* ...through the last one.!
	]..o				!* Back to previous buffer.!
     |

 !* Character for INSRT is 0, i.e. 48 (decimal) ascii.  DEL-CHAR is 1, ... F14
  * is character B, ascii 66.  SHIFT-INSRT is Space, etc. up through F11.
  * SHIFT-F12 is (to skip over 0, the next in sequence) character C, etc.
  * through F14.!

 48 m.vC100K INSRT Xw
 49 m.vC100K DEL-CHAR Xw
 50 m.vC100K DEL-LINE-INS Xw
 51 m.vC100K EOP-CLEAR-EOL Xw
 52 m.vC100K SEND Xw
 53 m.vC100K F1 Xw
 54 m.vC100K F2 Xw
 55 m.vC100K F3 Xw
 56 m.vC100K F4 Xw
 57 m.vC100K F5 Xw
 58 m.vC100K F6 Xw
 59 m.vC100K F7 Xw
 60 m.vC100K F8 Xw
 61 m.vC100K F9 Xw
 62 m.vC100K F10 Xw
 63 m.vC100K F11 Xw
 64 m.vC100K F12 Xw
 65 m.vC100K F13 Xw
 66 m.vC100K F14 Xw


 32 m.vC100K SHIFT-INSRT Xw
 33 m.vC100K SHIFT-DEL-CHAR Xw
 34 m.vC100K SHIFT-DEL-LINE-INS Xw
 35 m.vC100K SHIFT-EOP-CLEAR-EOL Xw
 36 m.vC100K SHIFT-SEND Xw
 37 m.vC100K SHIFT-F1 Xw
 38 m.vC100K SHIFT-F2 Xw
 39 m.vC100K SHIFT-F3 Xw
 40 m.vC100K SHIFT-F4 Xw
 41 m.vC100K SHIFT-F5 Xw
 42 m.vC100K SHIFT-F6 Xw
 43 m.vC100K SHIFT-F7 Xw
 44 m.vC100K SHIFT-F8 Xw
 45 m.vC100K SHIFT-F9 Xw
 46 m.vC100K SHIFT-F10 Xw
 47 m.vC100K SHIFT-F11 Xw
 67 m.vC100K SHIFT-F12 Xw
 68 m.vC100K SHIFT-F13 Xw
 69 m.vC100K SHIFT-F14 Xw

 :				    !* Return without popping the cleanup!
				    !* handler.!

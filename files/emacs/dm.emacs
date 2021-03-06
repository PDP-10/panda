!* -*-TECO-*- !

!~Filename~:! !Commands to activate the Datamedia Keypad.!
DM

!& Setup DM Library:! !S Set up for DM environment.!

    0fo..q DM_setup_hook[0
    fq0"g m0 '		    !* Run users macro if any.!

    m.m^R_Down_Real_Line u..J    !* Go down with M-<LF>.!
    16.fs ^R init u..M	    !* Make M-CRLF do beginning of next line.!
    m.m^R_Up_Real_Line u..^	    !* Up with M-^.!
    m.m^R_Forward_Word u..)	    !* Forward word M-).!
    m.m^R_Backward_Word u..(	    !* Backward word M-(.!
    m.m^R_Previous_Screen u..+   !* Previous screen M-+.!
    m.m^R_Next_Screen u..\	    !* Next screen M-\.!
    m.m^R_Count_Lines_Region u..~	    !* Count lines region M-~.!
    2fs ^R init u..<		    !* Backward character M-<.!
    6fs  init u..>		    !* Forward character M->.!
    q..>, 440.fs ^R c macro
    m.m^R_Goto_Beginning u..{    !* Beginning of buffer M-{.!
    m.m^R_Goto_End u..}	    !* End of buffer.!
    4fs ^R init u..K		    !* Kill forward character.!
    m.m^R_DM_Return_to_superior u:.x() !* Exit and blank screen.!
    q.= u..=
    0

!^R DM Return to Superior:! !^R Clears the screen first.!

    f+				    !* that was easy enough.!
    f m(m.m^R_Return_to_Superior) 

!& Read Filename:! !S Read a filename from the tty.
A non-zero argument means file will be use for output
(for version number defaulting).  The prompt should be
supplied as a string argument, without trailing colon or
space.  Returns a string of the filename read.!

    :I*[1			    !* Read prompt argument.!
    ET:<>FOO..0 ET		    !* Clear all defaults.!

    FN FS RGETTY"N		    !* Set up for when done (in case ^G).!
      0FO..QFlush_Prompts"N	    !* Maybe erase what just happened.!
        FS ECHO DIS
	CFS ECHO DIS '
      "# FS ECHO LINES-1"N	    !* Else at least a crlf.!
         @ FT			    !* Provided it wont erase it.!
''' 

    FS LISTEN"E		    !* Prompt unless user's starting typing.!
      FS RGETTY"N
        FS ECHO DIS CFS ECHO DIS'    !* Clear echo area.!
      ^ FT 1:_'		    !* Give prompt.!

    "N 400000.+' 60000. :ET	    !* Get filename from tty.!
    FS D FILE		    !* And return a string of it.!
    
!* -*-TECO-*- !

!~Filename~:! !LEDIT Package for Scheme.!
SCHEDIT

!& SCHEDIT Library Loaded:! !S Flag!
PUH

!^R SCHEDIT Load Buffer into Lisp:! !^R Send the buffer to Scheme.
Equivalent to a ^R Mark Whole Buffer
followed by a ^R SCHEDIT Zap Region
followed by a ^R SCHEDIT Resume Lisp.!
   M(M.M^R_Mark_Whole_Buffer)
   M(M.M^R_SCHEDIT_Zap_Region)
   :M(M.M^R_SCHEDIT_Resume_Lisp)

!^R SCHEDIT Load Defun into Lisp:! !^R Send a Defun to Scheme.
Equivalent to a ^R SCHEDIT Zap Defun
followed by a ^R SCHEDIT Resume Lisp.!
   M(M.M^R_SCHEDIT_Zap_Defun)
   :M(M.M^R_SCHEDIT_Resume_Lisp)

!^R SCHEDIT Zap Region:! !^R Send the region to Scheme.!
   1:m(m.m^R_SCHEDIT_Zap_Defun)

!^R SCHEDIT Zap Defun:! !^R Send a Defun to Scheme
Appends the defun to buffer *SEDIT*.  ^R SCHEDIT Resume Lisp
will write out the buffer to _SEDIT > on ITS or _SCHEDIT.LSP.0 on Twenex.

With a numeric argument, as in ^R Autoargument1 ^R SCHEDIT Zap Defun,
zaps the region instead.!

  [0				    !* Temporary.!
  [C[L[B[D
  f[dfile [Previous_Buffer
  .:\u0 fn0j			    !* Remember to return here to this point!
  QBuffer_NameuB		    !* in this buffer.!

  FF"N .,:F XC		    !* If given an arg, zap the region.!
  :iLRegion'
  !* Else zap the defun.!
  "# :cw @m(m.m ^R_Beginning_of_Defun) !* Jump to head of defun,!
     :XL			    !* Get first line for information.!
     FLXC'			    !* Get sexp into C.!
  
  m(m.mSelect_Buffer)*SCHEDIT*    !* Append the code to this buffer.!
  gC				    !* Insert the code.!
  2<i				    !* CR in buffer.!
>
  :i*CFsEchoDisp		    !* Clear echo area.!
  @ft Zapping_L...
  0FsEchoActive		    !* Make it stay.!
  qBm(m.mSelect_Buffer)	    !* Go back to original buffer!
0				    !* Return, no change to buffer!

!^R SCHEDIT Resume Lisp:! !^R Go back into Lisp, giving it any zapped defuns.
(See ^R SCHEDIT Zap Defun.)
Saves the current buffer, if changed.!

!* First writes out the *SCHEDIT* buffer into a temporary file
which the Lisp should read back in.!

  [H[B[F
  [Previous_Buffer
  0fo..Q SCHEDIT_Lisp_JNamef"e w 1,fName_of_Lisp:_f((
	  		     )m.v SCHEDIT_Lisp_JNamew) '[0

!* Write out the *SCHEDIT* buffer, and the current buffer.
   The current buffer should be explicitly saved, so it
   will be written even if there is no filename associated
   with it.  The other buffers get query-saved only if
   they have filenames.!

  QBuffer_Filename"E ET DSK:FOO.SCM'	    !* Default if none already.!
  m(m.m^R_Save_File)

  QBuffer_NameuB
  m(m.mSelect_Buffer)*SCHEDIT*
  
  !* On ITS,!
  fsosteco"e
     fsmsname:f6uH		    !*  Get MSNAME in qH as string!
     :iFDSK:H;_SEDIT	    !* Filename, without FN2.!
     1:<ed F_<>!>!		    !* Delete earliest version.!
  Z"N				    !* If there's something to save,!
     !<! m(m.mWrite_File)F_>''  !* write it to the latest version.!

  !* On Twenex,!
  fsosteco"n
     fsmsnameuH		    !* Get MSNAME in qH as string!
     :iFH_SCHEDIT.LSP
     1:<@ed F.-2>		    !* Expunge earliest version.!
     Z"N m(m.mWrite_File)F.0''  !* Save to latest version.!
		    
!* Save the rest of the files.  We have to do this here so
   the user won't get queried about the _SCHEDIT buffer.!
   
   m(m.mSave_All_Files)

!* Now resume the lisp.!
    FS OSTECO"E	  
       0'
    "# 0 
 '	    !* Formatting chars for prettiness.!

!* This happens when they continue the Emacs.!
  HK0fsModified		    !* Delete the old stuff.!
  QBm(m.mSelect_Buffer)	    !* We now return you to your!
				    !* regular buffer!
  @v				    !* Redisplay (just in case)!
0				    !* Return, no change to buffer!
 
  
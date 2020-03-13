!* -*-TECO-*-!
!~Filename~:! !Perform multiple replacements on a file.!
MQREPL

!Multi Query Replace:! !C Performs several query replaces conveniently.
This macro takes as its argument the name of a buffer containing
substitutions, one per line, in the form <old><new>.
It starts applying those substitutions to the current buffer.
It exits when you exit any query replace, leaving C-. set up
as a continuation macro to resume the query replace sequence at
the query replace which was exited.
If given numeric arg, then Replace String without querying.!

    Q:.B(:i* M(m.m &_Find_Buffer)+4)	    !* Remember the control buffer
!   m.v  Multi_Query_Replace_Buffer
    m.m &_Multi_Query_Replace_1u..	    !* Bind C-. to the continuation.!
    qMulti_Query_Replace_Buffer[..o j	    !* Go to beginning of the list so start with 1st one!
    ]..o J FF"N ':m..	    !* Call continuation to start doing it!

!& Multi Query Replace 1:! !S Continue doing a Multi Query Replace.
QMulti Query Replace Buffer is a TECO buffer containing the list
of replacements, with point pointing at the one to be resumed.
If given numeric arg, then Replace String without querying.!

  [1[2 !top!
  QMulti_Query_Replace_Buffer[..o	    !* Select control buffer.!
  .-z"E ^ft_Done_ fg '		    !* Finished with last replacement?!
  1fb  :x2 r 0x1			    !* Q1 = old string, Q2 = new string!
  0L ]..o				    !* Current subst is the one to resume after exit!
  :S1"E
 !EOF!
    QMulti_Query_Replace_Buffer[..o	    !* But if there are no occurrences, skip it.!
    L ]..o BJ otop '
  fkc					    !* Found an occurrence => make Query Replace!
					    !* find it right away.!
  fs Echo Display C fs Echo Display
  ^ft1_==>_2_			    !* Announce which replacement we are now processing.!
  M(FF"E M.M Query_Replace'"# M.M Replace_String')12"L	!* do query or string replace!
     o EOF'				    !* -1 returned means done, go do next!
  0					    !* Otherwise, return to ^R!

!Tags Multi Query Replace:! !C Perform multiple replacements on many files.
Given as an argument the name of a buffer containing
a list of replacements a la Multi Query Replace,
we process the first file in the current tag table
and set C-, to a macro to process the next file.
If this macro or C-, given numeric arg, then Replace String without querying.!

    :I*[0
    ^:i.,`
      m(m.m Next_File)		    !* First select next file.!
      F			    !* Tell ^R buffer completely changed.!
      FF"N ' m(m.m Multi_Query_Replace)0 !* Do multi query replace on buffer whose name!
					    !* is substituted in from our argument.!
      j 0`				    !* Then return.!
    1M(M.M Next_File)		    !* Select first file !
    F
    FF"N ' m(m.m Multi_Query_Replace)0
    J 0

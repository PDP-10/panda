!* -*-teco-*- *!
!* History: Source is on MIT-XX, in <EMACS>OUTLINE-MODE.EMACS.0.
 * This file assumes the compressor/purifier in the <EMACS>IVORY library.
 *
 * 6 Nov 79	Fill Prefix made local, so that leaving the buffer or mode
 *		will not use the local outline version.
 *
 * Originally written by Eugene Ciccarelli in November 1978.
 * Installed in BBND:<EMACS> 14 December 1978.
 * Based on a suggestion by Martin Yonke concerning XED's ability to edit
 * outlines.!
!~FILENAME~:! !Commands to implement XEDish outline mode.
If you use this, contact JPERSHING@BBNA to be put on the mailing list.!
OUTLINE-MODE

!Outline Mode:! !C Redefine C-X Comma and M-Q for editing outlines.
Control-X Comma is defined to run ^R Set Outline Fill Prefix.
Tab runs ^R Tab to Tab Stop.
Meta-Q runs ^R Fill Outline Paragraph, which also calls C-X Comma and therefore
    resets the fill prefix which should be convenient for editing:
    Just go to an outline paragraph, Meta-Q it (even if it doesn't need to be
    filled, it will cause it to recheck what the fill prefix should be).!
!* I think the best way to
 * proceed with outline mode is to not use fill prefix, but instead have
 * Space Indent Flag used, and have TAB be based on the previous line (and
 * back), much like PL1 and M11 modes.  Then there wouldnt be state like fill
 * prefix, one could bounce around the buffer more.!

 m(m.m& Init Buffer Locals)	    !* Clear out stuff.!
 M(M.MText Mode)		    !* Start with Text Mode...!
 1,0M.LSpace Indent Flag	    !* Auto-filling will not cause an indent;!
				    !* ..it will insert Fill Prefix.!
 1,0m.lFill Prefix		    !* Local to buffer/mode.!
 m.m^R Set Outline Fill Prefixu:.x(,)   !*  .  (This unfortunately!
					    !* ..cannot be local -- no!
					    !* ..individual prefixed functions!
					    !* ..can.)!
 m.m^R Fill Outline ParagraphM.Q..Q	!* M-Q, local.!
 1M(M.M& Set Mode Line)Outline
 

!^R Set Outline Fill Prefix:! !^R To be indentation of point.
Fill Prefix becomes enough whitespace to indent (from left margin) to
    the horizontal position of point.
Fill-Prefix Column is set to the horizontal position this indents to.
Thus there can be non-whitespace to the left of point, e.g. a outline
    paragraph start.!

 fsSHPos[0			    !* 0: Current hpos.!
 q0m.vFill-Prefix Columnw
 q0"e				    !* Special case 0 for speed, bug-free.!
    0uFill Prefix'		    !* ...!
 "#				    !* Have some indentation.!
    f[BBind			    !* Temp buffer.!
    q0m(m.m& Indent)w		    !* Create whitespace to hpos.!
    0xFill Prefix'		    !* Set prefix from that.!
 q0:\u0				    !* 0: Convert to string.!
 @ft
(Fill Prefix indents 0) 0fsEchoActivew
 0

!^R Fill Outline Paragraph:! !^R Recognizes indented outline paragraphs.
Finds start of this outline paragraph, resets Fill Prefix from that and
    then fills the paragraph.
Outline paragraphs must be preceded and followed by blank lines (or the
    beginning or end of the buffer).
Outline paragraphs may start with a "marker", with the paragraph indented more
    than the marker.  Here are some examples of two line outline paragraphs to
    illustrate the kinds of markers:

    This paragraph has no marker.  It
    therefore gets filled this way.

    - This one starts with a bullet
      and so gets filled this way.

    (1) Markers can be parenthesized
	like this.

    a) Or markers can just end with a
       parenthesis.

    iv.  This is an example of a
	 marker ending with a period.

    First:  And this is one that ends
	    with a colon.!

 z-.[0[1			    !* 0: Distance from original point to end.!
 :s

:				    !* Find next <blank-line>.!
 -:s"E bj @f
l '				    !* Find previous <blank-line>, and move to!
 "# 2l '			    !* ..just after it.!

 @f 	l			    !* Forward past any <whitespace>.!

 !* Now move past any outline marker on this line.  There may be none, in!
 !* which case we will fill just like indent relative would.  A marker is!
 !* either a hyphen (bullet) or some non-whitespace that ends with a period, a!
 !* right-paren, or a colon.  Maybe the colon is not right?!

 0,1a--"e c'				!* A hyphen marker.!
 "# .u1					!* 1: Point after leading indentation.!
    :@f	 l			!* Forward past non-whitespace.(!
    0,0af:.)"l q1j''			!* If that wasnt a marker, move back.!

 @f 	l			    !* Forward past any <whitespace> after the!
				    !* marker if any.!
 @m(m.m^R Set Outline Fill Prefix)w
 0fx1				    !* 1: Remove <white><marker><white>.!
 .( .:w			    !* Set MARK at paragraph start for filler.!
    m(m.m& Fill Outline Paragraph) !* Fill.!
    )j				    !* Back to paragraph start.!
 0l @f 	k		    !* Kill paragraph indentation.!
 .,(g1).( z-q0j 0a-13"e r'	    !* Dont leave point between CRLF.!
	  )			    !* Replace with <white><marker><white>!

!& Fill Outline Paragraph:! !S Like ^R Fill Paragraph a bit.
Removes any initial indentation of lines.
MARK should be at beginning of paragraph.  End is <blank-line>.!

 [1[2[3
 qFill Prefixu2		    !* 2: Fill Prefix.!
 qFill-Prefix Columnu3	    !* 3: Indentation amount.!
 qFill Columnf"ew'f[AdLine	    !* Use Fill Column if non-0.!
 fsAdLine-q3[Fill Column	    !* Reset Fill Column down by indent.!

 0[Fill Prefix		    !* ^R Fill Region not handle so well.!
 :s

"e zj' z-.u1			    !* 1: Z-Point at end of paragraph.!

 :j				    !* Go to MARK, paragraph start.!
 < @f 	k		    !* Remove any indentation from line.!
   l .-z+q1; >			    !* Do that for each line in paragraph.!

 z-q1j				    !* Point at end of paragraph.!

 @m(m.m^R Fill Region)w z-.u1	    !* 1: Z-Point left at end.!

 :j				    !* Back to MARK, paragraph start.!
 m.m& Indent[I			    !* I: Indenter.!
 .,( < 13,1a-13"n q3mIw'	    !* Indent each line with something on it.!
       l .-z+q1; >		    !* ...!
     ).f 			    !* Tell  and exit.!

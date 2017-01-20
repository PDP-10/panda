@Comment[ Copyright (C) 1979 Brian K. Reid ]
@comment[ modified on 30.10.79 by Maguire for Utah CS dept ]
@Comment{

Document type definition file to define a personal letter
on the Diablo HyType II.
}
@marker(Make,CSLetter,Diablo)
@Style(Spacing 1,Spread 0.3,indentation 0)
@Typewheel(Elite 12)
@string(Phone="(801) 581-8224",Department="Computer Science",room="3160")
@Define(Address,Group,Nofill,LeftMargin 0,Spread 0,Break,Use R,
	Below 0.5inch,Initialize "@Blankspace(0.7inches)")
@Define(Body,Break,Fill,Justification off,Use R,Above 0.3inch,EofOK,LeftMargin 0,
	Below 0.5inch,Spread 0.8,RightMargin 0)
@Define(Ends,Nofill,LeftMargin 3.0inches,Spread 0,Break,Use R,
	RightMargin 0,Blanklines kept)
@Define(Closing=Ends,
	Initialize="@format[Sincerely yours,
@blankspace(3lines)
]")
@Define(Notations,Nofill,LeftMargin 0,Spread 0,Break,BlankLines Kept,
	RightMargin 0,Spaces Kept)
@Define(Initials,Nofill,LeftMargin 0,Spread 0,Break,BlankLines Kept,
	RightMargin 0,Spaces Kept)
@Define(PS=Body,Above 0,Below 0)
@Define(Greeting=Flushleft,Initialize "Dear ")
@Equate(PostScript=PS,PostScripts=PS,Closings=Notations)
@LibraryFile(Math)
@Begin(Text,Justification off,Font CharDef,FaceCode R,LeftMargin 1.0inch,
	LineWidth 6.3inch,BottomMargin 0.5inch,TopMargin 1inch,
	Spacing 1,Spread 0.8lines,indent 0)
@begin(format)
@tabs(3.0inches)
The University of Utah@\Department of @value(department)
@\@value(room) Merrill Engineering Bldg.
@\Salt Lake City, Utah 84112
@\@value(phone)

@\@value(date)
@end(format)
@Begin(Ends,EOFOK)
@style(TopMargin=1inch)
@PageHeading(left "@value(Date)",right "Page @value(Page)")
@marker(Make,CSLetterHead,Diablo)
@Style(Spacing 1,Spread 0.3,indentation 0)
@Typewheel(Elite 12)
@string(Phone="(801) 581-8224",Department="Computer Science",room="3160")
@Define(Address,Group,Nofill,LeftMargin 0,Spread 0,Break,Use R,
	Below 0.5inch,Initialize "@Blankspace(0.7inches)")
@Define(Body,Break,Fill,Justification off,Use R,Above 0.3inch,EofOK,LeftMargin 0,
	Below 0.5inch,Spread 0.8,RightMargin 0)
@Define(Ends,Nofill,LeftMargin 3.5inches,Spread 0,Break,Use R,
	RightMargin 0,Blanklines kept)
@Define(Closing=Ends,
	Initialize="@format[Sincerely yours,
@blankspace(3lines)
]")
@Define(Notations,Nofill,LeftMargin 0,Spread 0,Break,BlankLines Kept,
	RightMargin 0,Spaces Kept)
@Define(Initials,Nofill,LeftMargin 0,Spread 0,Break,BlankLines Kept,
	RightMargin 0,Spaces Kept)
@Define(PS=Body,Above 0,Below 0)
@Define(Greeting=Flushleft,Initialize "Dear ")
@Equate(PostScript=PS,PostScripts=PS,Closings=Notations,Initials=Notations)
@LibraryFile(Math)
@Begin(Text,Justification off,Font CharDef,FaceCode R,LeftMargin 1.3inch,
	LineWidth 6.0inch,BottomMargin 0.5inch,TopMargin 1inch,
	Spacing 1,Spread 0.8lines,indent 0)
@Begin(Ends,EOFOK)
@style(TopMargin=1inch)
@PageHeading(left "@value(Date)",right "Page @value(Page)")
@begin(format)
@tabs(3.0inches)
The University of Utah@\Department of @value(department)
@\@value(room) Merrill Engineering Bldg.
@\Salt Lake City, Utah 84112
@\@value(phone)

@\@value(date)
@marker(Make,CSLetter,LPT)
@string(Phone="(801) 581-8224",Department="Computer Science",room="3160")
@Style(Spacing 1,Spread 1,indentation 0)
@Style(TopMargin 1inch,BottomMargin 1inch,LeftMargin 1inch,
	LineWidth 6.5inches)
@define(Ends,Nofill,LeftMargin 3in,Spread 0,Break,BlankLines Kept,
		RightMargin 0)
@Define(Address=Ends,LeftMargin 0,Above 4)
@Define(Body,Fill,Justification,Use R,LeftMargin 0,EofOK,
	Spacing 1,Spread 1,Spaces Compact,BlankLines Break,
	Above 1,Below 0.5inch,Break)
@Define(Closing=Ends,
	Initialize="@format[Sincerely yours,
@blankspace(3lines)
]")
@Define(Notations,Nofill,LeftMargin 0,Spread 0,Break,BlankLines Kept,
	RightMargin 0,Spaces Kept,Fixed 9.5inches)
@Define(Initials,Nofill,LeftMargin 0,Spread 0,Break,BlankLines Kept,
	RightMargin 0,Spaces Kept)
@Define(PS=Body,Above 0,Below 0)
@Define(Greeting=Flushleft,Initialize "Dear ")
@Equate(PostScript=PS,PostScripts=PS,Closings=Notations)
@LibraryFile(Math)
@Begin(Text,Justification,Font CharDef,FaceCode R)
@PageHeading(Center "@value(page)")
@begin(format)
@tabs(3.0inches)
The University of Utah@\Department of @value(department)
@\@value(room) Merrill Engineering Bldg.
@\Salt Lake City, Utah 84112
@\@value(phone)

@\@value(date)
@end(format)
@Begin(Ends,EofOK)

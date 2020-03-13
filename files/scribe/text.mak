@Comment[ Copyright (C) 1979 Brian K. Reid ]

@Comment{

Document type definition for the basic default document type,
named Text.  Simple unindented paragraphs of justified text
on numbered pages.
}
@marker(Make,Text,XGP)
@Font(News Gothic 10)
@LibraryFile(Math)
@Begin(Text,Justification,Font BodyFont,FaceCode R,Spaces Compact,
	Indent 0,LeftMargin 1inch,TopMargin 1inch,BottomMargin 1inch,
	RightMargin 1inch,Spacing 35raster,Spread 18raster)
@PageHeading(Center "@value(page)")
@Comment{

Document type definition for the basic default document type,
named Text.  Simple unindented paragraphs of justified text
on numbered pages.
}
@marker(Make,Text,Press)
@Font(Times Roman 10)
@LibraryFile(Math)
@Begin(Text,Justification,Font BodyFont,FaceCode R,Spaces Compact,
	Indent 0,LeftMargin 1inch,TopMargin 1inch,BottomMargin 1inch,
	RightMargin 1inch,Spacing 1.3 lines,Spread 0.4lines)
@PageHeading(Center "@value(page)")
@marker(Make,Text,LPT)
@LibraryFile(Math)
@Begin(Text,Justification,Font CharDef,FaceCode R,Spaces Compact,
	Spacing 1,Spread 1,Indent 0,LineWidth 72)
@PageHeading(Center "@value(page)")
@marker(Make,Text,Diablo)
@Typewheel(Elite 12)
@LibraryFile(Math)
@Begin(Text,Justification on,Font CharDef,FaceCode R,Spaces Compact,
	Spacing 1.5,Spread 1,Indent 0,RightMargin 1inch,
	LeftMargin 1inch,TopMargin 1inch,BottomMargin 1inch)
@PageHeading(Center "@value(page)")
@marker(Make,Text,File,CRT,PagedFile)
@LibraryFile(Math)
@Begin(Text,Justification,Font CharDef,FaceCode R,Spaces Compact,
	Spacing 1,Spread 1,Indent 0,LineWidth 79)
@PageHeading(Center "@value(page)")
@Marker(Make,Text,GSI)
@Font(CMU 4)
@LibraryFile(Math)
@Enter(Text,Justification,Font BodyFont,FaceCode R,Spaces Compact,
	LeftMargin 0.62inch,LineWidth 6.5inches,TopMargin 1inch,
	BottomMargin 1inch,Size 10,Spacing 1.4,Spread 1.3,Indent 2)
@PageHeading(Center "@value(page)")
@marker(Make,Text)
@LibraryFile(Math)
@Begin(Text,Justification,Font CharDef,FaceCode R,Spaces Compact,
	Spacing 1,Spread 1,Indent 0,LineWidth 79)
@PageHeading(Center "@value(page)")

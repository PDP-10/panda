@Comment[ Copyright (C) 1979 Brian K. Reid ]

@Comment{

Document type definition for simple two-column output.  Similar to Text
save for the column count.  Simple unindented paragraphs of justified
text on numbered pages.  
}
@marker(Make,TwoColumnText,XGP)
@Font(News Gothic 10)
@LibraryFile(Math)
@Begin(Text,Justification,Font BodyFont,FaceCode R,Spaces Compact,
	Indent 0,LeftMargin 1inch,TopMargin 1inch,BottomMargin 1inch,
	Columns 2,LineWidth 3inches,ColumnMargin 0.5inch,
	RightMargin 1inch,Spacing 35raster,Spread 18raster)
@PageHeading(Center "@value(page)")
@marker(Make,TwoColumnText,LPT)
@LibraryFile(Math)
@Begin(Text,Justification,Font CharDef,FaceCode R,Spaces Compact,
	Columns 2,LineWidth 32,ColumnMargin 6,
	Spacing 1,Spread 1,Indent 0)
@PageHeading(Center "@value(page)")
@marker(Make,TwoColumnText,Diablo)
@Typewheel(Elite 12)
@LibraryFile(Math)
@Begin(Text,Justification on,Font CharDef,FaceCode R,Spaces Compact,
	Spacing 1.5,Spread 1,Indent 0,
	Columns 2,ColumnMargin 0.5inch,LineWidth 3inches,
	LeftMargin 1inch,TopMargin 1inch,BottomMargin 1inch)
@PageHeading(Center "@value(page)")
@marker(Make,TwoColumnText,File,CRT,PagedFile)
@LibraryFile(Math)
@Begin(Text,Justification,Font CharDef,FaceCode R,Spaces Compact,
	Columns 2,LineWidth 32,ColumnMargin 6,
	Spacing 1,Spread 1,Indent 0)
@PageHeading(Center "@value(page)")
@Marker(Make,TwoColumnText,GSI)
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

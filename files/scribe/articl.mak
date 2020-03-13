@Comment[ Copyright (C) 1979 Brian K. Reid ]

@Comment{

Document type definition for "Article".  A sectioned document 
with no chapters.  It has a title page and a table of contents.
}
@Marker(Make,Article,XGP)

@Define(BodyStyle,Font BodyFont,Spacing 1.5,Spread 0.8)
@Define(NoteStyle,Font SmallBodyFont,FaceCode R,Spacing 1)
@font(NewsGothic10)

@Generate(Outline,Contents)
@Send(Contents "@Style(PageNumber <@i>)@NewPage(0)@Set(Page=0)")
@Send(Contents "@NewPage(0)@PrefaceSection(Table of Contents)")

@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 1,Below 0,
	  break,Need 7,Justification Off)
@Define(Hd2,Use HdX,Font TitleFont3,FaceCode R,Above 0.4inch)
@Define(Hd2A=HD2,Centered)
@Define(Hd3,Use HdX,Font TitleFont1,FaceCode R,Above 0.4inch)
@Define(Hd4,Use HdX,Font TitleFont1,FaceCode R,Above 0.3inch)
@Define(TcX,LeftMargin 5,Indent -5,RightMargin 5,Fill,Spaces compact,
	Above 0,Spacing 1,Below 0,Break,Spread 0)
@Define(Tc2=TcX,LeftMargin 8,Font TitleFont0,FaceCode R)
@Define(Tc3=TcX,LeftMargin 12,Font TitleFont0,FaceCode R)
@Define(Tc4=TcX,LeftMargin 16,Font TitleFont0,FaceCode R)
@Counter(Section,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@:.@1.],Referenced [@#@:.@1],IncrementedBy Use,Announced)
@Counter(Appendix,TitleEnv hd2,ContentsEnv TC2,Numbered [@I.],
	  IncrementedBy,Referenced [@I],Announced,Alias Section)
@Counter(UnNumbered,TitleEnv HD2,ContentsEnv TC2,Announced,Alias Section)
@Counter(SubSection,Within Section,TitleEnv HD3,ContentsEnv tc3,
	  Numbered [@#@:.@1.],IncrementedBy Use,Referenced [@#@:.@1])
@Counter(Paragraph,Within SubSection,TitleEnv HD4,ContentsEnv tc4,
	  Numbered [@#@:.@1.],Referenced [@#@:.@1],IncrementedBy Use)

@Counter(PrefaceSection,TitleEnv HD2A,Alias Section)

@Equate(Chapter=Section)
@LibraryFile(Figures)
@LibraryFile(Math)
@LibraryFile(TitlePage)

@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2)

@Equate(Sec=Section,Subsec=SubSection,Para=Paragraph,
	SubSubSec=Paragraph)
@Begin(Text,Indent 1Quad,LeftMargin 1inch,TopMargin 1inch,BottomMargin 1inch,
	LineWidth 6.5inches,Spread 15raster,
	Use BodyStyle,Justification,FaceCode R,Spaces Compact)
@Set(Page=0)
@PageHeading(Center "@value(page)")
@Marker(Make,Article,Diablo)
@Define(BodyStyle,Spacing 1.7,Spread 0.8)
@Define(TitleStyle,Spacing 1,Spread 0)
@Define(NoteStyle,Spacing 1,Spread 0.3)
@Typewheel(Elite 12)

@Generate(Outline,Contents)
@Send(Contents "@Style(PageNumber <@i>)@NewPage(0)@Set(Page=0)")
@Send(Contents "@NewPage(0)@PrefaceSection(Table of Contents)")

@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 1,Below 1,
	  break,Need 7,Justification Off)
@Define(Hd2,Use HdX,Use B,Above 0.4inch)
@Define(Hd2A=HD2,Centered)
@Define(Hd3,Use HdX,Above 0.4inch)
@Define(Hd4,Use HdX,Above 0.3inch)
@Define(TcX,LeftMargin 5,Indent -5,RightMargin 5,Fill,Spaces compact,
	Above 0,Spacing 1,Below 0,Break,Spread 0)
@Define(Tc2=TcX,LeftMargin 5)
@Define(Tc3=TcX,LeftMargin 10)
@Define(Tc4=TcX,LeftMargin 15)
@Counter(Section,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@:.@1.],Referenced [@#@:.@1],IncrementedBy Use,Announced)
@Counter(Appendix,TitleEnv HD2,ContentsEnv TC2,Numbered [@I.],
	  IncrementedBy,Referenced [@I],Announced,Alias Section)
@Counter(UnNumbered,TitleEnv HD2,ContentsEnv TC2,Announced,Alias Section)
@Counter(SubSection,Within Section,TitleEnv HD3,ContentsEnv tc3,
	  Numbered [@#@:.@1.],IncrementedBy Use,Referenced [@#@:.@1])
@Counter(Paragraph,Within SubSection,TitleEnv HD4,ContentsEnv tc4,
	  Numbered [@#@:.@1.],Referenced [@#@:.@1],IncrementedBy Use)

@Counter(PrefaceSection,TitleEnv HD2A,Alias Section)

@Equate(Chapter=Section)
@LibraryFile(Figures)
@LibraryFile(Math)
@LibraryFile(TitlePage)

@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2)

@Equate(Sec=Section,Subsec=SubSection,Para=Paragraph,
	SubSubSec=Paragraph)
@Begin(Text,Indent 3,Use BodyStyle,LeftMargin 1inch,TopMargin 1inch,
	BottomMargin 1inch,LineWidth 6.5inches,Justification,
	Spaces Compact,Font CharDef,FaceCode R)
@set(page=0)
@PageHeading(Center "@value(page)")
@Marker(Make,Article,File,PagedFile,CRT)
@Define(BodyStyle,Spacing 1)
@Define(TitleStyle,Spacing 1)
@Define(NoteStyle,Spacing 1)

@Generate(Outline,Contents)
@Send(Contents "@Style(PageNumber <@i>)@NewPage(0)@Set(Page=0)")
@Send(Contents "@NewPage(0)@PrefaceSection(Table of Contents)")

@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 1,Below 0,
	  break,Need 7,Justification Off)
@Define(Hd2,Use HdX,Above 1)
@Define(Hd2A=HD2,Centered)
@Define(Hd3,Use HdX,Above 3)
@Define(Hd4,Use HdX,Above 2)
@Define(TcX,LeftMargin 5,Indent -5,RightMargin 5,Fill,Spaces compact,
	Above 0,Spacing 1,Below 0,Break,Spread 0)
@Define(Tc2=TcX,LeftMargin 5)
@Define(Tc3=TcX,LeftMargin 10)
@Define(Tc4=TcX,LeftMargin 15)
@Counter(Section,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@:.@1.],Referenced [@#@:.@1],IncrementedBy Use,Announced)
@Counter(Appendix,TitleEnv HD2,ContentsEnv TC2,Numbered [@I.],
	  IncrementedBy,Referenced [@I],Announced,Alias Section)
@Counter(UnNumbered,TitleEnv HD2,ContentsEnv TC2,Announced,Alias Section)
@Counter(SubSection,Within Section,TitleEnv HD3,ContentsEnv tc3,
	  Numbered [@#@:.@1.],IncrementedBy Use,Referenced [@#@:.@1])
@Counter(Paragraph,Within SubSection,TitleEnv HD4,ContentsEnv tc4,
	  Numbered [@#@:.@1.],Referenced [@#@:.@1],IncrementedBy Use)

@Counter(PrefaceSection,TitleEnv HD2A,Alias Section)

@Equate(Chapter=Section)
@LibraryFile(Figures)
@LibraryFile(Math)
@LibraryFile(TitlePage)

@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2)

@Equate(Sec=Section,Subsec=SubSection,Para=Paragraph,
	SubSubSec=Paragraph)
@Begin(Text,Indent 2,Spread 1,Use BodyStyle,LineWidth 7.9inches,
	Spaces Compact,
	Justification,Font CharDef,FaceCode R)
@set(page=0)
@PageHeading(Center "@value(page)")
@Marker(Make,Article,GSI)

@Font(CMU 4)
@Define(BodyStyle,Font BodyFont,Spacing 1.3,Spread 0.8,Size 10,
	Indent 2)
@Define(NoteStyle,Font BodyFont,FaceCode R,Spacing 1,Size 8,
	Indent 2)

@Generate(Outline,Contents)
@Send(Contents "@Style(PageNumber <@i>)@NewPage(0)@Set(Page=0)")
@Send(Contents "@NewPage(0)@PrefaceSection(Table of Contents)")

@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 1,Below 0,
	  break,Need 7,Justification Off)
@Define(Hd2,Use HdX,Font TitleFont,Size +2,FaceCode B,Above 0.4inch)
@Define(Hd2A=HD2,Centered)
@Define(Hd3,Use HdX,Font TitleFont,Size +1,FaceCode B,Above 0.4inch)
@Define(Hd4,Use HdX,Font TitleFont,Size +0,FaceCode B,Above 0.3inch)
@Define(TcX,LeftMargin 5,Indent -5,RightMargin 5,Fill,Spaces compact,
	Above 0,Spacing 1,Below 0,Break,Spread 0)
@Define(Tc2=TcX,LeftMargin 8,Font TitleFont,Size +1,FaceCode R)
@Define(Tc3=TcX,LeftMargin 12,Font TitleFont,Size +0,FaceCode R)
@Define(Tc4=TcX,LeftMargin 16,Font TitleFont,Size +0,FaceCode L)
@Counter(Section,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@:.@1.],Referenced [@#@:.@1],IncrementedBy Use,Announced)
@Counter(Appendix,TitleEnv hd2,ContentsEnv TC2,Numbered [@I.],
	  IncrementedBy,Referenced [@I],Announced,Alias Section)
@Counter(UnNumbered,TitleEnv HD2,ContentsEnv TC2,Announced,Alias Section)
@Counter(SubSection,Within Section,TitleEnv HD3,ContentsEnv tc3,
	  Numbered [@#@:.@1.],IncrementedBy Use,Referenced [@#@:.@1])
@Counter(Paragraph,Within SubSection,TitleEnv HD4,ContentsEnv tc4,
	  Numbered [@#@:.@1.],Referenced [@#@:.@1],IncrementedBy Use)

@Counter(PrefaceSection,TitleEnv HD2A,Alias Section)

@Equate(Chapter=Section)
@LibraryFile(Figures)
@LibraryFile(Math)
@LibraryFile(TitlePage)

@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2)

@Equate(Sec=Section,Subsec=SubSection,Para=Paragraph,
	SubSubSec=Paragraph)
@Begin(Text,Indent 1Quad,LeftMargin 1inch,TopMargin 1inch,BottomMargin 1inch,
	LineWidth 6.5inches,
	Use BodyStyle,Justification,FaceCode R,Spaces Compact)
@Set(Page=0)
@PageHeading(Center "@value(page)")
@Marker(Make,Article)
@Define(BodyStyle,Spacing 2)
@Define(TitleStyle,Spacing 1)
@Define(NoteStyle,Spacing 1)

@Generate(Outline,Contents)
@Send(Contents "@Style(PageNumber <@i>)@NewPage(0)@Set(Page=0)")
@Send(Contents "@NewPage(0)@PrefaceSection(Table of Contents)")

@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 2,Below 1,
	  break,Need 7,Justification Off,Use B)
@Define(Hd2,Use HdX,Above 3)
@Define(Hd2A=HD2,Centered)
@Equate(HD3=HDX,HD4=HDX)
@Define(TcX,LeftMargin 5,Indent -5,RightMargin 5,Fill,Spaces compact,
	Above 0,Spacing 1,Below 0,Break,Spread 0)
@Define(Tc2=TcX,LeftMargin 5)
@Define(Tc3=TcX,LeftMargin 10)
@Define(Tc4=TcX,LeftMargin 15)
@Counter(Section,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@:.@1.],Referenced [@#@:.@1],IncrementedBy Use,Announced)
@Counter(Appendix,TitleEnv HD2,ContentsEnv TC2,Numbered [@I.],
	  IncrementedBy,Referenced [@I],Announced,Alias Section)
@Counter(UnNumbered,TitleEnv HD2,ContentsEnv TC2,Announced,Alias Section)
@Counter(SubSection,Within Section,TitleEnv HD3,ContentsEnv tc3,
	  Numbered [@#@:.@1.],IncrementedBy Use,Referenced [@#@:.@1])
@Counter(Paragraph,Within SubSection,TitleEnv HD4,ContentsEnv tc4,
	  Numbered [@#@:.@1.],Referenced [@#@:.@1],IncrementedBy Use)

@Counter(PrefaceSection,TitleEnv HD2A,Alias Section)

@Equate(Chapter=Section)
@LibraryFile(Figures)
@LibraryFile(Math)
@LibraryFile(TitlePage)

@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2)

@Equate(Sec=Section,Subsec=SubSection,Para=Paragraph,
	SubSubSec=Paragraph)
@Begin(Text,Indent 2,Spread 1,Use BodyStyle,LineWidth 6.5inches,
	Spaces Compact,
	Justification,Font CharDef,FaceCode R)
@set(page=0)
@PageHeading(Center "@value(page)")
@Marker(Make,Article1)
@Message(

Document type "Article1" is now "Article, Form 1"

@Abort
)
 
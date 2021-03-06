@Comment[ Copyright (C) 1979 Joseph M. Newcomer ]

@Marker(Make,ACMModel,XGP)
@style(PaperLength=14inch)

@style(Leftmargin 0.6inch, linewidth 4.00inches)
@Style(TopMargin=4inch,BottomMargin=2.8inch)
@Define(BodyStyle,Font BodyFont,Spacing 1.2,Spread 0.8)
@Define(NoteStyle,Font SmallBodyFont,FaceCode R,Spacing 1)
@font(Nonie12)

@Generate(Outline,Contents)
@Send(Contents "@Style(PageNumber <@i>)@Set(Page=1)")
@Send(Contents "@NewPage(0)@PrefaceSection(Table of Contents)")

@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 1,Below 0,
	  break,Need 7,Justification Off)
@Define(Hd2,Use HdX,Font TitleFont3,FaceCode R,Above 0.4inch)
@Define(Hd2A=HD2,Centered)
@Define(Hd3,Use HdX,Font TitleFont1,FaceCode R,Above 0.4inch)
@Define(Hd4,Use HdX,Font TitleFont1,FaceCode R,Above 0.3inch)
@Define(TcX,LeftMargin 5,Indent -5,RightMargin 5,Fill,Spaces compact,
	Justification off,Above 0,Spacing 1,Below 0,Break,Spread 0)
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

@LibraryFile(Figures)
@LibraryFile(Math)

@Define(TitleBox,Break,centered,blanklines kept,fixed 0.75)
@Define(Abstract=Text,Spacing 1,Indent 0,Fill,Justification,
	Initialize "@heading{Abstract}")
@Define(ResearchCredit,break,Font SmallBodyFont,Fill,Justification,
	Spacing 1)
@TextForm(ArpaCredit="@ResearchCredit{@File{Sys:ArpaTP.}}")
@[[@textform(Column1="@style(DynamicTMarg=4in,DynamicBMarg=2.8in)")]]
@TextForm(Column1={})
@textform(Column2="@style(DynamicBMarg=1in)")
@textform(ColumnN="@style(DynamicTMarg=1in)")
@Define(CopyrightNotice,Fixed 10.25inches,Centered,
	Initialize "Copyright @r[(C)] @value{year} ")

@Define(Example,Use Insert,Nofill,Spaces Kept,Group,BlankLines Kept,FaceCode T,LeftMargin +0.25in,RightMargin +2)
@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2)

@Equate(Sec=Section,Subsec=SubSection,Para=Paragraph,
	SubSubSec=Paragraph)
@Enter(Text,Indent 1Quad,LeftMargin 0.6inch,
	Spread 12raster,
	Use BodyStyle,Justification,FaceCode R,Spaces Compact)
@Set(Page=0)
@Marker(Make,ACMModel,Diablo)
@Define(BodyStyle,Spacing 1.7,Spread 0.8)
@Define(TitleStyle,Spacing 1,Spread 0)
@style(PaperLength=14inch)
@Define(NoteStyle,Spacing 1,Spread 0.3)
@Typewheel(Elite 12)

@Generate(Outline,Contents)
@Send(Contents "@Style(PageNumber <@i>)@Set(Page=1)")
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

@LibraryFile(Figures)
@LibraryFile(Math)

@Define(TitlePage,Break,PageBreak Around,Centered,
	BlankLines Kept,Above 4.4inches)
@Define(TitleBox,Break,centered,blanklines kept)
@Define(Abstract=Text,Spacing 1,Indent 0,Fill,Justification,
	Initialize "@heading{Abstract}")
@Define(ResearchCredit,break,Font SmallBodyFont,Fill,Justification,Spacing 1)
@TextForm(ArpaCredit="@ResearchCredit{@File{Sys:ArpaTP.}}")
@Define(CopyrightNotice,Fixed 10.25inches,Centered,
	Initialize "Copyright -C- @value{year} ")

@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2)

@Equate(Sec=Section,Subsec=SubSection,Para=Paragraph,
	SubSubSec=Paragraph)
@textform(Column1="@blankspace(4.75inches)")
@textform(Column2="@enter(Figure,float)@blankspace(3inches)@leave(figure)")
@Enter(Text,Indent 3,Use BodyStyle,LeftMargin 1inch,TopMargin 1inch,
	BottomMargin 1inch,LineWidth 4.25inches,Justification,
	Spaces Compact,Font CharDef,FaceCode R)
@set(page=0)
@Marker(Make,ACMModel,File,PagedFile)
@Define(BodyStyle,Spacing 1)
@style(paperlength 62)
@Define(TitleStyle,Spacing 1)
@Define(NoteStyle,Spacing 1)

@Generate(Outline,Contents)
@Send(Contents "@Style(PageNumber <@i>)@Set(Page=1)")
@Send(Contents "@NewPage(0)@PrefaceSection(Table of Contents)")

@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 1,Below 0,
	  break,Need 7,Justification Off)
@Define(Hd2,Use HdX,Above 1)
@Define(Hd2A=HD2,Centered)
@Define(Hd3,Use HdX,Above 3)
@Define(Hd4,Use HdX,Above 2)
@Define(TcX,LeftMargin 5,Indent -5,RightMargin 5,Fill,Spaces compact,
	Justification off,Above 0,Spacing 1,Below 0,Break,Spread 0)
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

@LibraryFile(Figures)
@LibraryFile(Math)

@Define(TitlePage,Break,PageBreak Around,Centered,
	BlankLines Kept,Above 4.4inches)
@Define(TitleBox,Break,centered,blanklines kept)
@Define(Abstract=Text,Spacing 1,Indent 0,Fill,Justification,
	Initialize "@heading{Abstract}")
@Define(ResearchCredit,break,Fill,Justification,Spacing 1)
@TextForm(ArpaCredit="@ResearchCredit{@File{Sys:ArpaTP.}}")
@Define(CopyrightNotice,Fixed 8.0inches,Centered,
	Initialize "Copyright -C- @value{year} ")

@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2)

@Equate(Sec=Section,Subsec=SubSection,Para=Paragraph,
	SubSubSec=Paragraph)
@textform(Column1="")
@textform(Column2="")
@Enter(Text,Indent 2,Spread 1,Use BodyStyle,LineWidth 4.2inches,
	Spaces Compact,
	Justification,Font CharDef,FaceCode R)
@set(page=0)
 
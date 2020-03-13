@Marker(Make,Guide,XGP)

@Define(BodyStyle,Font BodyFont,Spacing 1.2,Spread 0.8)
@Define(NoteStyle,Font SmallBodyFont,FaceCode R,Spacing 1)
@font(NewsGothic10)

@Generate(Index,Contents)
@TextForm(ix="@index{@parm(text)}@i{@parm(text)}")
@Send(Contents "@Style(PageNumber <@i>)@Set(Page=0)")
@Send(Contents "@PrefaceSection(Table of Contents)")
@send(#Index	"@UnNumbered(Index)",
      #Index	"@Enter(IndexEnv)")

@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 1,Below 0,
	  break,Need 8,Justification Off)
@Define	(Hd0,Use HdX,Font TitleFont5,FaceCode R,Above 1inch,Below 0.5inch)
@Define(Hd1,Use HdX,Font TitleFont5,FaceCode R,Above .5inch,
	PageBreak UntilOdd)
@Define(HD1A=HD1,Centered)
@Define(Hd2,Use HdX,Centered,Font TitleFont4,FaceCode R,Above 0.4inch,
	Need 2inch)
@Define(Hd3,Use HdX,Font TitleFont1,FaceCode R,Above 0.2inch)
@Define(Hd4,Use HdX,Font TitleFont1,FaceCode R,Above 0.3inch)
@Define(TcX,LeftMargin 5,Indent -5,RightMargin 5,Fill,Spaces compact,
	Above 0,Spacing 1,Below 0,Break,Spread 0)
@Define(Tc0=TcX,Font TitleFont3,FaceCode R)
@Define(Tc1=TcX,Font TitleFont1,FaceCode R,Above 20raster,
	Below 20raster)
@Define(Tc2=TcX,LeftMargin 8,Font TitleFont0,FaceCode R)
@Define(Tc3=TcX,LeftMargin 12,Font TitleFont0,FaceCode R)
@Define(Tc4=TcX,LeftMargin 16,Font TitleFont0,FaceCode R)
@Counter(Chapter,TitleEnv HD1,ContentsEnv tc1,Numbered [@1.],
	  IncrementedBy Use,Referenced [@1],Announced)
@Counter(Appendix,TitleEnv HD1,ContentsEnv tc1,Numbered [@I.],
	  IncrementedBy,Referenced [@I],Announced,Alias Chapter)
@Counter(UnNumbered,TitleEnv HD1,ContentsEnv tc1,Announced,Alias Chapter)
@Counter(Section,TitleEnv HD2,ContentsEnv tc2)
@Counter(AppendixSection,Within Appendix,TitleEnv HD2,ContentsEnv tc2)
@Counter(SubSection,Within Section,TitleEnv HD3,ContentsEnv tc3)
@Counter(Paragraph,Within SubSection,TitleEnv HD4,ContentsEnv tc4)

@Counter(PrefaceSection,TitleEnv HD1A,Alias Chapter)
@Define(IndexEnv,Break,CRBreak,Fill,BlankLines Kept,Font SmallBodyFont,
	FaceCode R,Spread 0,Spacing 1,Spaces Kept,LeftMargin 18,Indent -8)

@Counter(FigureCounter,Within Chapter,Numbered <Figure @#@:-@1: >,
	 Referenced "@#@:-@1",Init 0)
@Define(Figure,Nofill,Spaces Kept,Use R,BlankLines kept,Float,
	Above 1,Below 1,Counter FigureCounter,NumberLocation LFL)
@Define(FullPageFigure,Use Figure,FloatPage)
@Define(CaptionEnv=Center,FaceCode R,Below 0)

@Define(TitlePage,Break,PageBreak Around,Centered,
	BlankLines Kept,Above 0.5inches)
@Define(TitleBox)
@Define(Abstract=Text,Spacing 1,Indent 0,Fill,Justification,
	Initialize "@heading{Abstract}")
@Define(ResearchCredit,Fixed 8.5inches,Fill,Justification,Spacing 1)
@TextForm(ArpaCredit="@ResearchCredit{@File[Sys:ArpaTP.]}")
@Define(CopyrightNotice,Fixed 8.0inches,Centered,
	Initialize "Copyright -C- @value{year} ")

@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2)
@Define(InputExample=Example,FaceCode E)

@Equate(Sec=Section,Subsec=SubSection,Chap=Chapter,Para=Paragraph,
	SubSubSec=Paragraph,AppendixSec=AppendixSection)
@Enter(Text,Indent 1Quad,LeftMargin 1inch,TopMargin 1inch,BottomMargin 1inch,
	LineWidth 6.5inches,Spread 15raster,
	Use BodyStyle,Justification,FaceCode R,Spaces Compact)
@Set(Page=0)
@PageHeading(Center "@value(page)")
@Marker(Make,Guide,Diablo)
@Define(BodyStyle,Spacing 1.7,Spread 0.8)
@Define(TitleStyle,Spacing 1,Spread 0)
@Define(NoteStyle,Spacing 1,Spread 0.3)

@Generate(Index,Contents)
@TextForm(ix="@index{@parm(text)}@i{@parm(text)}")
@Send(Contents "@Style(PageNumber <@i>)@Set(Page=0)")
@Send(Contents "@PrefaceSection(Table of Contents)")
@send(#Index	"@UnNumbered(Index)",
      #Index	"@Enter(IndexEnv)")

@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 1,Below 0,
	  break,Need 5,Justification Off)
@Define	(Hd0,Use HdX,Above 1inch,Below 0.5inch)
@Define(Hd1,Use HdX,,Above .5inch,PageBreak UntilOdd)
@Define(HD1A=HD1,Centered)
@Define(Hd2,Use HdX,Centered,Above 0.4inch)
@Define(Hd3,Use HdX,Above 0.4inch)
@Define(Hd4,Use HdX,Above 0.3inch)
@Define(TcX,LeftMargin 5,Indent -5,RightMargin 5,Fill,Spaces compact,
	Above 0,Spacing 1,Below 0,Break,Spread 0)
@Define(Tc0=TcX)
@Define(Tc1=TcX,Above 0.2,Below 0.2)
@Define(Tc2=TcX,LeftMargin 5)
@Define(Tc3=TcX,LeftMargin 10)
@Define(Tc4=TcX,LeftMargin 15)
@Counter(MajorPart,TitleEnv HD0,ContentsEnv tc0,Numbered [@I],
	  IncrementedBy Use,Announced)
@Counter(Chapter,TitleEnv HD1,ContentsEnv tc1,Numbered [@1.],
	  IncrementedBy Use,Referenced [@1],Announced)
@Counter(Appendix,TitleEnv HD1,ContentsEnv tc1,Numbered [@I.],
	  IncrementedBy,Referenced [@I],Announced,Alias Chapter)
@Counter(UnNumbered,TitleEnv HD1,ContentsEnv tc1,Announced,Alias Chapter)
@Counter(Section,Within Chapter,TitleEnv HD2,ContentsEnv tc2)
@Counter(AppendixSection,Within Appendix,TitleEnv HD2,ContentsEnv tc2)
@Counter(SubSection,Within Section,TitleEnv HD3,ContentsEnv tc3)
@Counter(Paragraph,Within SubSection,TitleEnv HD4,ContentsEnv tc4)

@Counter(PrefaceSection,TitleEnv HD1A,Alias Chapter)
@Define(IndexEnv,Break,CRBreak,Fill,BlankLines Kept,
	Spread 0,Spacing 1,Spaces Kept,LeftMargin 18,Indent -8)

@Counter(FigureCounter,Within Chapter,Numbered <Figure @#@:-@1: >,
	 Referenced "@#@:-@1",Init 0)
@Define(Figure,Nofill,Spaces Kept,Use R,BlankLines kept,Float,
	Above 1,Below 1,Counter FigureCounter,NumberLocation LFL)
@Define(FullPageFigure,Use Figure,FloatPage)
@Define(CaptionEnv=Center,FaceCode R,Below 0)

@Define(TitlePage,Break,PageBreak Around,Centered,
	BlankLines Kept,Above 0.5inches)
@Define(TitleBox)
@Define(Abstract=Text,Spacing 1,Indent 0,Fill,Justification,
	Initialize "@heading{Abstract}")
@Define(ResearchCredit,Fixed 8.5inches,Fill,Justification,Spacing 1)
@TextForm(ArpaCredit="@ResearchCredit{@File[Sys:ArpaTP.]}")
@Define(CopyrightNotice,Fixed 8.0inches,Centered,
	Initialize "Copyright -C- @value{year} ")

@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2)
@Equate(InputExample=OutputExample)

@Equate(Sec=Section,Subsec=SubSection,Chap=Chapter,Para=Paragraph,
	SubSubSec=Paragraph,AppendixSec=AppendixSection)
@Enter(Text,Indent 3,Use BodyStyle,LeftMargin 1inch,TopMargin 1inch,
	BottomMargin 1inch,LineWidth 6.5inches,Justification,
	Spaces Compact,Font CharDef,FaceCode R)
@set(page=0)
@PageHeading(Center "@value(page)")
@Marker(Make,Guide,File,Editor,SOS,TECO)
@Define(BodyStyle,Spacing 1)
@Define(TitleStyle,Spacing 1)
@Define(NoteStyle,Spacing 1)

@Generate(Index,Contents)
@TextForm(ix="@index{@parm(text)}@i{@parm(text)}")
@Send(Contents "@Style(PageNumber <@i>)@Set(Page=0)")
@Send(Contents "@PrefaceSection(Table of Contents)")
@send(#Index	"@UnNumbered(Index)",
      #Index	"@Enter(IndexEnv)")

@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 1,Below 0,
	  break,Need 5,Justification Off)
@Define	(Hd0,Use HdX,Above 1inch,Below 0.5inch)
@Define(Hd1,Use HdX,Above 3,PageBreak Before)
@Define(HD1A=HD1,Centered)
@Define(Hd2,Use HdX,Centered,Above 1)
@Define(Hd3,Use HdX,Above 3)
@Define(Hd4,Use HdX,Above 2)
@Define(TcX,LeftMargin 5,Indent -5,RightMargin 5,Fill,Spaces compact,
	Above 0,Spacing 1,Below 0,Break,Spread 0)
@Define(Tc0=TcX)
@Define(Tc1=TcX,Above 1,Below 1)
@Define(Tc2=TcX,LeftMargin 5)
@Define(Tc3=TcX,LeftMargin 10)
@Define(Tc4=TcX,LeftMargin 15)
@Counter(MajorPart,TitleEnv HD0,ContentsEnv tc0,Numbered [@I],
	  IncrementedBy Use,Announced)
@Counter(Chapter,TitleEnv HD1,ContentsEnv tc1,Numbered [@1.],
	  IncrementedBy Use,Referenced [@1],Announced)
@Counter(Appendix,TitleEnv HD1,ContentsEnv tc1,Numbered [@I.],
	  IncrementedBy,Referenced [@I],Announced,Alias Chapter)
@Counter(UnNumbered,TitleEnv HD1,ContentsEnv tc1,Announced,Alias Chapter)
@Counter(Section,Within Chapter,TitleEnv HD2,ContentsEnv tc2)
@Counter(AppendixSection,Within Appendix,TitleEnv HD2,ContentsEnv tc2)
@Counter(SubSection,Within Section,TitleEnv HD3,ContentsEnv tc3)
@Counter(Paragraph,Within SubSection,TitleEnv HD4,ContentsEnv tc4)

@Counter(PrefaceSection,TitleEnv HD1A,Alias Chapter)
@Define(IndexEnv,Break,CRBreak,Fill,BlankLines Kept,
	Spread 0,Spacing 1,Spaces Kept,LeftMargin 18,Indent -8)

@Counter(FigureCounter,Within Chapter,Numbered <Figure @#@:-@1: >,
	 Referenced "@#@:-@1",Init 0)
@Define(Figure,Nofill,Spaces Kept,Use R,BlankLines kept,Float,
	Above 1,Below 1,Counter FigureCounter,NumberLocation LFL)
@Define(FullPageFigure,Use Figure,FloatPage)
@Define(CaptionEnv=Center,FaceCode R,Below 0)

@Define(TitlePage,Break,PageBreak Around,Centered,
	BlankLines Kept,Above 0.5inches)
@Define(TitleBox)
@Define(Abstract=Text,Spacing 1,Indent 0,Fill,Justification,
	Initialize "@heading{Abstract}")
@Define(ResearchCredit,Fixed 8.5inches,Fill,Justification,Spacing 1)
@TextForm(ArpaCredit="@ResearchCredit{@File[Sys:ArpaTP.]}")
@Define(CopyrightNotice,Fixed 8.0inches,Centered,
	Initialize "Copyright -C- @value{year} ")

@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2)
@Equate(InputExample=OutputExample)

@Equate(Sec=Section,Subsec=SubSection,Chap=Chapter,Para=Paragraph,
	SubSubSec=Paragraph,AppendixSec=AppendixSection)
@Enter(Text,Indent 2,Spread 1,Use BodyStyle,LineWidth 7.9inches,
	Spaces Compact,
	Justification,Font CharDef,FaceCode R)
@set(page=0)
@PageHeading(Center "@value(page)")
@Marker(Make,Guide)
@Define(BodyStyle,Spacing 2)
@Define(TitleStyle,Spacing 1)
@Define(NoteStyle,Spacing 1)

@Generate(Index,Contents)
@TextForm(ix="@index{@parm(text)}@i{@parm(text)}")
@Send(Contents "@Style(PageNumber <@i>)@Set(Page=0)")
@Send(Contents "@PrefaceSection(Table of Contents)")
@send(#Index	"@UnNumbered(Index)",
      #Index	"@Enter(IndexEnv)")

@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 2,Below 0,
	  break,Need 5,Justification Off)
@Define	(Hd0,Use HdX,Above 1inch,Below 0.5inch,Use B)
@Define(Hd1,Use HdX,Below 1,PageBreak UntilOdd,Use B,Centered,Capitalized)
@Define(HD1A=HD1,Capitalized off)
@Define(Hd2,Use HdX,Centered,Above 3,Below 1,Use B)
@Define(Hd3,Use HdX)
@Define(Hd4,Use HdX)
@Define(TcX,LeftMargin 5,Indent -5,RightMargin 5,Fill,Spaces compact,
	Above 0,Spacing 1,Below 0,Break,Spread 0)
@Define(Tc0=TcX,Use B)
@Define(Tc1=TcX,Above 1,Below 1,Use b)
@Define(Tc2=TcX,LeftMargin 10)
@Define(Tc3=TcX,LeftMargin 15)
@Define(Tc4=TcX,LeftMargin 20)
@Counter(MajorPart,TitleEnv HD0,ContentsEnv tc0,Numbered [@I],
	  IncrementedBy Use,Announced)
@Counter(Chapter,TitleEnv HD1,ContentsEnv tc1,Numbered [@1.],
	  IncrementedBy Use,Referenced [@1],Announced)
@Counter(Appendix,TitleEnv HD1,ContentsEnv tc1,Numbered [@I.],
	  IncrementedBy,Referenced [@I],Announced,Alias Chapter)
@Counter(UnNumbered,TitleEnv HD1,ContentsEnv tc1,Announced,Alias Chapter)
@Counter(Section,Within Chapter,TitleEnv HD2,ContentsEnv tc2)
@Counter(AppendixSection,Within Appendix,TitleEnv HD2,ContentsEnv tc2)
@Counter(SubSection,Within Section,TitleEnv HD3,ContentsEnv tc3)
@Counter(Paragraph,Within SubSection,TitleEnv HD4,ContentsEnv tc4)

@Counter(PrefaceSection,TitleEnv HD1A,Alias Chapter)
@Define(IndexEnv,Break,CRBreak,Fill,BlankLines Kept,
	Spread 0,Spacing 1,Spaces Kept,LeftMargin 18,Indent -8)

@Counter(FigureCounter,Within Chapter,Numbered <Figure @#@:-@1: >,
	 Referenced "@#@:-@1",Init 0)
@Define(Figure,Nofill,Spaces Kept,Use R,BlankLines kept,Float,
	Above 1,Below 1,Counter FigureCounter,NumberLocation LFL)
@Define(FullPageFigure,Use Figure,FloatPage)
@Define(CaptionEnv=Center,FaceCode R,Below 0)

@Define(TitlePage,Break,PageBreak Around,Centered,
	BlankLines Kept,Above 0.5inches)
@Define(TitleBox)
@Define(Abstract=Text,Spacing 1,Indent 0,Fill,Justification,
	Initialize "@heading{Abstract}")
@Define(ResearchCredit,Fixed 8.5inches,Fill,Justification,Spacing 1)
@TextForm(ArpaCredit="@ResearchCredit{@File[Sys:ArpaTP.]}")
@Define(CopyrightNotice,Fixed 8.0inches,Centered,
	Initialize "Copyright -C- @value{year} ")

@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2,RightMargin 0)
@Equate(InputExample=OutputExample)

@Equate(Sec=Section,Subsec=SubSection,Chap=Chapter,Para=Paragraph,
	SubSubSec=Paragraph,AppendixSec=AppendixSection)
@Enter(Text,Indent 2,Spread 1,Use BodyStyle,LineWidth 7.5inches,
	Spaces Compact,
	Justification,Font CharDef,FaceCode R)
@set(page=0)
@PageHeading(Center "@value(page)")
  
@Marker(Make,Primer,XGP)

@Define(BodyStyle,Font BodyFont,Spacing 1.3,Spread 0.8)
@Define(NoteStyle,Font SmallBodyFont,FaceCode R,Spacing 1)
@font(Nonie12)

@Generate(Outline,Index,Contents)
@Send(Contents "@Style(PageNumber <@i>)@NewPage(0)@Set(Page=1)",
      Contents "@PageHeading(immediate,center '@value(page)')")
@send(#Index	"@UnNumbered(Index)",
      #Index	"@Enter(IndexEnv)")
@SendEnd(#Index "@Leave(IndexEnv)")

@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 1,Below 0,
	  break,Need 5)
@Define	(Hd0,Use HdX,Font TitleFont5,FaceCode R,Above 1inch,Below 0.5inch)
@Define(Hd1,Use HdX,Centered,Font TitleFont5,FaceCode R,Above .5inch,PageBreak Before)
@Define(HdA,Use HdX,Font TitleFont5,FaceCode R,Above .5inch,PageBreak Before)
@Define(Hd2,Use HdX,Font TitleFont3,FaceCode R,Above 0.4inch,
	PageBreak Before)
@Define(Hd3,Use HdX,Font TitleFont1,FaceCode R,Above 0.4inch)
@Define(Hd4,Use HdX,Font TitleFont0,FaceCode R,Above 0.3inch)
@Define(TcX,LeftMargin 5,Indent -5,RightMargin 5,Fill,Spaces compact,
	Above 0,Spacing 1,Below 0,Break,Spread 0)
@Define(Tc0=TcX,Font TitleFont3,FaceCode R)
@Define(Tc1=TcX,Centered,Font TitleFont1,FaceCode R,Above 20raster,
	Below 20raster)
@Define(TCA=TcX,Font TitleFont1,FaceCode R,Above 20raster,
	Below 20raster)
@Define(Tc2=TcX,LeftMargin 8,Font TitleFont0,FaceCode R)
@Define(Tc3=TcX,LeftMargin 12,Font TitleFont0,FaceCode R)
@Define(Tc4=TcX,LeftMargin 16,Font TitleFont0,FaceCode R)
@Counter(MajorPart,TitleEnv HD0,ContentsEnv tc0,Numbered [@I],
	  IncrementedBy Use,Announced)
@Counter(Chapter,TitleEnv HD1,ContentsEnv tc1,Numbered [@1.],
	  IncrementedBy Use,Referenced [@1],Announced)
@Counter(Appendix,TitleEnv HDA,ContentsEnv TCA,Numbered [@I.],
	  IncrementedBy,Referenced [@I],Announced)
@Counter(UnNumbered,TitleEnv HD1,ContentsEnv tc1,Announced)
@Counter(Section,Within Chapter,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@1.],Referenced [@#.@1],IncrementedBy Use,Announced)
@Counter(AppendixSection,Within Appendix,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@1.],Referenced [@#.@1],IncrementedBy Use,Announced)
@Counter(SubSection,Within Section,TitleEnv HD3,ContentsEnv tc3,
	  Numbered [@#@1.],IncrementedBy Use,Referenced [@#.@1])
@Counter(Paragraph,Within SubSection,TitleEnv HD4,ContentsEnv tc4,
	  Numbered [@#@1.],Referenced [@#.@1],IncrementedBy Use)

@Define(PrefaceSection=HD1,Centered)
@Define(IndexEnv,Break,CRBreak,Fill,BlankLines Kept,Font SmallBodyFont,
	FaceCode R,Spread 0,Spacing 1,Spaces Kept,LeftMargin 18,Indent -8)

@LibraryFile(Figures)
@LibraryFile(Math)
@LibraryFile(TitlePage)

@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Indent -10,Spacing 1,Spread 0)
@Define(OExample=Verbatim,Font SmallBodyFont,LeftMargin 8,
	FaceCode T,Group)
@Modify(Example,FaceCode E,LeftMargin +3,RightMargin -1inch)
@Define(ChapterIntro,Spacing 1.4,LeftMargin 1.5inches,
	RightMargin 1.5inches,Above .8inches)

@Equate(Sec=Section,Subsec=SubSection,Chap=Chapter,Para=Paragraph,
	SubSubSec=Paragraph,AppendixSec=AppendixSection)
@Enter(Text,Indent 1Quad,LeftMargin 1inch,TopMargin 1inch,BottomMargin 1.2inch,
	LineWidth 6.5inches,Spread 15raster,
	Use BodyStyle,Justification,FaceCode R)
@Set(Page=0)
@PageHeading(Center "@value(page)")
@Marker(Make,Primer,Diablo)
@Define(BodyStyle,Spacing 1.4,Spread 0.8)
@Define(TitleStyle,Spacing 1,Spread 0)
@Define(NoteStyle,Spacing 1,Spread 0.3)
@Typewheel(Elite 12)

@Generate(Outline,Index,Contents)
@Send(Contents "@Style(PageNumber <@i>)@NewPage(0)@Set(Page=1)",
      Contents "@PageHeading(immediate,center '@value(page)')")
@send(#Index	"@UnNumbered(Index)",
      #Index	"@Enter(IndexEnv)")
@SendEnd(#Index "@Leave(IndexEnv)")
@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 2.5,Below 1,
	  break,Need 7,Use B,Use TitleStyle)
@Define	(Hd0=hdx,Above 3.5,Below 2)
@Define(Hd1=hdx,PageBreak Before)
@Define(Hd2=hdx,PageBreak Before)
@Define(Hd3=hdx)
@Define(Hd4=hdx)
@Define(TCX,LeftMargin 5,Indent -5,RightMargin 5,Fill,Spaces compact,Above 0,
	  use TitleStyle,Below 0,Break)
@Define(Tc0=tcx)
@Define(Tc1=tcx,Above 1)
@Define(Tc2=tcx,LeftMargin 10)
@Define(Tc3=tcx,LeftMargin 15)
@Define(Tc4=tcx,LeftMargin 20)
@Counter(MajorPart,TitleEnv HD0,ContentsEnv tc0,Numbered [@I],
	  IncrementedBy Use,Announced)
@Counter(Chapter,TitleEnv HD1,ContentsEnv tc1,Numbered [@1.],
	  IncrementedBy Use,Referenced [@1],Announced)
@Counter(Appendix,TitleEnv HD1,ContentsEnv tc1,Numbered [@I.],
	  IncrementedBy,Referenced [@I],Announced)
@Counter(UnNumbered,TitleEnv HD1,ContentsEnv tc1,Announced)
@Counter(Section,Within Chapter,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@1.],Referenced [@#.@1],IncrementedBy Use,Announced)
@Counter(AppendixSection,Within Appendix,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@1.],Referenced [@#.@1],IncrementedBy Use,Announced)
@Counter(SubSection,Within Section,TitleEnv HD3,ContentsEnv tc3,
	  Numbered [@#@1.],IncrementedBy Use,Referenced [@#.@1])
@Counter(Paragraph,Within SubSection,TitleEnv HD4,ContentsEnv tc4,
	  Numbered [@#@1.],Referenced [@#.@1],IncrementedBy Use)

@Define(PrefaceSection=HD1,Centered)
@Define(IndexEnv,CRBreak,Fill,BlankLines Kept,Use NoteStyle,Spacing 1,
	Spaces Kept,LeftMargin 18,Indent -8,Break,Spread 0)

@LibraryFile(Figures)
@LibraryFile(Math)
@LibraryFile(TitlePage)

@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Indent -10,Spacing 1,Spread 0)
@Define(OExample=Verbatim,Font SmallBodyFont,LeftMargin 8,Group)
@Define(ChapterIntro,Spacing 1.4,LeftMargin 1.5inches,
	RightMargin 1.5inches,Above .8inches)
@Define(OutputExample=Verbatim,LeftMargin 2)

@Equate(Sec=Section,Subsec=SubSection,Chap=Chapter,Para=Paragraph,
	SubSubSec=Paragraph,AppendixSec=AppendixSection)
@Enter(Text,Indent 3,Use BodyStyle,LeftMargin 1inch,TopMargin 1inch,
	BottomMargin 1inch,LineWidth 6.5inches,Justification,Font CharDef,FaceCode R)
@set(page=0)
@PageHeading(Center "@value(page)")
@Marker(Make,Primer,File,Editor,SOS,TECO)
@Define(BodyStyle,Spacing 1)
@Define(TitleStyle,Spacing 1)
@Define(NoteStyle,Spacing 1)

@Generate(Outline,Index,Contents)
@Send(Contents "@Style(PageNumber <@i>)@NewPage(0)@Set(Page=1)",
      Contents "@PageHeading(immediate,center '@value(page)')")
@send(#Index	"@UnNumbered(Index)",
      #Index	"@Enter(IndexEnv)")
@SendEnd(#Index "@Leave(IndexEnv)")
@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 2,Below 1,
	  break,Need 5,Use B,Use TitleStyle)
@Define	(Hd0=hdx,Above 3,Below 2)
@Define(Hd1=hdx,PageBreak Before)
@Define(Hd2=hdx,PageBreak Before)
@Define(Hd3=hdx)
@Define(Hd4=hdx)
@Define(TCX,LeftMargin 5,Indent -5,RightMargin 5,Fill,Spaces compact,Above 0,
	  use TitleStyle,Below 0,Break)
@Define(Tc0=tcx)
@Define(Tc1=tcx,Above 1)
@Define(Tc2=tcx,LeftMargin 10)
@Define(Tc3=tcx,LeftMargin 15)
@Define(Tc4=tcx,LeftMargin 20)
@Counter(MajorPart,TitleEnv HD0,ContentsEnv tc0,Numbered [@I],
	  IncrementedBy Use,Announced)
@Counter(Chapter,TitleEnv HD1,ContentsEnv tc1,Numbered [@1.],
	  IncrementedBy Use,Referenced [@1],Announced)
@Counter(Appendix,TitleEnv HD1,ContentsEnv tc1,Numbered [@I.],
	  IncrementedBy,Referenced [@I],Announced)
@Counter(UnNumbered,TitleEnv HD1,ContentsEnv tc1,Announced)
@Counter(Section,Within Chapter,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@1.],Referenced [@#.@1],IncrementedBy Use,Announced)
@Counter(AppendixSection,Within Appendix,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@1.],Referenced [@#.@1],IncrementedBy Use,Announced)
@Counter(SubSection,Within Section,TitleEnv HD3,ContentsEnv tc3,
	  Numbered [@#@1.],IncrementedBy Use,Referenced [@#.@1])
@Counter(Paragraph,Within SubSection,TitleEnv HD4,ContentsEnv tc4,
	  Numbered [@#@1.],Referenced [@#.@1],IncrementedBy Use)

@Define(PrefaceSection=HD1,Centered)
@Define(IndexEnv,CRBreak,Fill,BlankLines Kept,Use NoteStyle,Spacing 1,
	Spaces Kept,LeftMargin 8,Indent -8,Break,Spread 0)


@LibraryFile(Figures)
@LibraryFile(Math)
@LibraryFile(TitlePage)

@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Indent -10,Spacing 1,Spread 0)
@Define(OExample=Verbatim,Font SmallBodyFont,LeftMargin 8,Group)
@Define(ChapterIntro,Spacing 1.4,LeftMargin 1.5inches,
	RightMargin 1.5inches,Above .8inches)
@Define(OutputExample=Verbatim,LeftMargin 2)

@Equate(Sec=Section,Subsec=SubSection,Chap=Chapter,Para=Paragraph,
	SubSubSec=Paragraph,AppendixSec=AppendixSection)
@Enter(Text,Indent 2,Spread 1,Use BodyStyle,LineWidth 7.9inches,
	Justification,Font CharDef,FaceCode R)
@set(page=0)
@PageHeading(Center "@value(page)")
@Marker(Make,Manual)
@Define(BodyStyle,Spacing 2)
@Define(TitleStyle,Spacing 1)
@Define(NoteStyle,Spacing 1)

@Generate(Outline,Index,Contents)
@Send(Contents "@Style(PageNumber <@i>)@NewPage(0)@Set(Page=1)",
      Contents "@PageHeading(immediate,center '@value(page)')")
@send(#Index	"@UnNumbered(Index)",
      #Index	"@Enter(IndexEnv)")
@SendEnd(#Index "@Leave(IndexEnv)")
@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 2,Below 1,
	  break,Need 5,Use B,Use TitleStyle)
@Define	(Hd0=hdx,Above 3,Below 2)
@Define(Hd1=hdx,PageBreak Before)
@Define(Hd2=hdx,PageBreak Before)
@Define(Hd3=hdx)
@Define(Hd4=hdx)
@Define(TCX,LeftMargin 5,Indent -5,RightMargin 5,Fill,Spaces compact,Above 0,
	  use TitleStyle,Below 0,Break)
@Define(Tc0=tcx)
@Define(Tc1=tcx,Above 1)
@Define(Tc2=tcx,LeftMargin 10)
@Define(Tc3=tcx,LeftMargin 15)
@Define(Tc4=tcx,LeftMargin 20)
@Counter(MajorPart,TitleEnv HD0,ContentsEnv tc0,Numbered [@I],
	  IncrementedBy Use,Announced)
@Counter(Chapter,TitleEnv HD1,ContentsEnv tc1,Numbered [@1.],
	  IncrementedBy Use,Referenced [@1],Announced)
@Counter(Appendix,TitleEnv HD1,ContentsEnv tc1,Numbered [@I.],
	  IncrementedBy,Referenced [@I],Announced)
@Counter(UnNumbered,TitleEnv HD1,ContentsEnv tc1,Announced)
@Counter(Section,Within Chapter,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@1.],Referenced [@#.@1],IncrementedBy Use,Announced)
@Counter(AppendixSection,Within Appendix,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@1.],Referenced [@#.@1],IncrementedBy Use,Announced)
@Counter(SubSection,Within Section,TitleEnv HD3,ContentsEnv tc3,
	  Numbered [@#@1.],IncrementedBy Use,Referenced [@#.@1])
@Counter(Paragraph,Within SubSection,TitleEnv HD4,ContentsEnv tc4,
	  Numbered [@#@1.],Referenced [@#.@1],IncrementedBy Use)

@Define(PrefaceSection=HD1,Centered)
@Define(IndexEnv,CRBreak,Fill,BlankLines Kept,Use NoteStyle,Spacing 1,
	Spaces Kept,LeftMargin 18,Indent -8,Break,Spread 0)

@LibraryFile(Figures)
@LibraryFile(Math)
@LibraryFile(TitlePage)

@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Indent -10,Spacing 1,Spread 0)
@Define(OExample=Verbatim,Font SmallBodyFont,LeftMargin 8,Group)
@Define(ChapterIntro,Spacing 1.4,LeftMargin 1.5inches,
	RightMargin 1.5inches,Above .8inches)
@Define(OutputExample=Verbatim,LeftMargin 2)

@Equate(Sec=Section,Subsec=SubSection,Chap=Chapter,Para=Paragraph,
	SubSubSec=Paragraph,AppendixSec=AppendixSection)
@Enter(Text,Indent 2,Spread 1,Use BodyStyle,LineWidth 7.9inches,
	Justification,Font CharDef,FaceCode R)
@set(page=0)
@PageHeading(Center "@value(page)")

@Comment[ Copyright (C) 1979 David Alex Lamb]

@Marker(Make,PublicationOrderForm,XGP)

@Comment{
This is the format definition file for the CMU Publication Announcement
and Order Form, a mailing we send out quarterly.  It will not be of
much direct use to other sites, but it's an interesting example of
a fancy document type.
}
@Define(BodyStyle,Font BodyFont,Spacing 1,Spread 0.8)
@font(CMUNotes)

@Define(L,FaceCode L)
@Generate(order)
@send(order <@PageHeading()@PageFooting()>)
@send(order <@newpage>)
@send(order <@begin(center,facecode L)>)
@send(order <Carnegie-Mellon University>)
@send(order <Computer Science Department>)
@send(order <@end(center)>)
@send(order <@begin(center,facecode B)>)
@send(order <>)
@send(order <Publication Order Form>)
@send(order <@value(Month) @value(Year)>)
@send(order <@end(center)>)
@send(order <>)
@send(order <The Computer Science Department at Carnegie-Mellon University>)
@send(order <is pleased to announce the availability of new Technical Reports.>)
@send(order <An abstract of each is attached.>)
@send(order <>)
@send(order <Use this form to order the announced publications.  Due to limited>)
@send(order <publication quantities, we will fill orders on a first-come, first-served>)
@send(order <basis.>)
@send(order <>)
@send(order <To order, please check the box next to the title of the publication(s)>)
@send(order <in which you are interested.  Then detach this sheet, refold so that>)
@send(order <our address is facing out, attach a first-class stamp, and mail.>)
@send(order <>)
@send(order <@Begin(format,Fill,leftmargin .3inch,indent -.3inch,eofok)>)
@send(order <@tabclear@tabstops(.3inch)>)


@form(entry="@begin(center,need 8)


@parm(title)
@parm(author)
@parm(date)
@end(center)
@send(order <
@l{}@\@parm(title)
@\@parm(author)>)")

@Begin(Text,Indent 1Quad,LeftMargin .6inch,TopMargin .7inch,BottomMargin .5inch,
	LineWidth 7.5inches,Spread 15raster,
	Use BodyStyle,Justification,FaceCode R,Spaces Compact)
@Set(Page=0)
@PageHeading(Left "@value(month) @value(year)", Right "Page @value(page)")
@PageFooting(Center "@l[Carnegie-Mellon University Computer Science Department]")
@marker(Make,PublicationOrderForm)
@Message[
You need to specify @DEVICE(XGP) in your source file.]

# Textclass definition file for LaTeX.
# Author : Martin vermeer <martin.vermeer@hut.fi>
# Inset layouts definition
#
# More detailled format description is available in the customization manual
# FIXME: create the contents in the manual and put the link here.  
#
#InsetLayout <string identifier used by LyX>
#	LabelString           used for the inset decoration (either the inset button
#	                      or the text underneath the inset).
#	LatexType             associated LateX type: command, environment, or none.
#	LatexName             associated LateX command.
#	BgColor               Color of the inset background within LyX.
#                         FIXME: link to a doc file describing the different
#                         color codes as defined in 'ColorCode.h'
#	Font                  Nothing to put here, below are descriptions of the different
#                         allowable adjustments for the font used to draw the text
#                         appearing within the inset text. All these items are optional.
#	  Color               Color of text
#	  Size                Font size of the textallowed value: Small, Smaller, ...
#                         FIXME defined in FontSize in FontEnums.h
#	  Family              FIXME defined in FontFamily in FontEnums.h
#	  Shape               FIXME defined in FontShape in FontEnums.h
#	  Series              FIXME defined in FontSeries in FontEnums.h
#	  Misc                FIXME defined in FontMisc in FontEnums.h
#	EndFont               Nothing to put here, it's just a markup to indicate that we are
#                         finished with the Font definition.
#	LabelFont             Nothing to put here, below are descriptions of the different
#                         allowable adjustments for the font used to draw the text
#                         appearing within the inset decoration. All these items are
#                         optional.
#	  Color               see definition above (in the Font node).
#	  Size                see definition above (in the Font node).
#
#	EndFont               Nothing to put here, it's just a markup to indicate that we are
#                         finished with the LabelFont definition.
#	MultiPar              Indicates that multiple paragraphs are allowed within the inset
#                         or not. Defaults to false. Sets CustomPars, as well, to the same
#                         value, and sets ForcePlain to the opposite value. If you want
#                         those to be different, then, you must set them after you set 
#                         MultiPar.
# CustomPars            Whether to allow the use of the Paragraph Settings dialog. Default is
#                         false.
# ForcePlain            Whether to force the PlainLayout. Default is true.
#	Decoration:           Classic, Minimalistic, Conglomerate. Decoration styles
#	PassThru              Do not do various LaTeX conversions, like the phrases
#	                        LaTeX, LyX, quote commands, etc.
#	KeepEmpty             Do not delete empty paragraphs (?)
#	FreeSpacing           Preserve multiple spaces etc.
#	ForceLTR              Force the "latex" language, leading to Left-to-Right
#	                        (latin) output, e.g., in ERT or URL. A kludge.
#	Requires              Require a given (supported) feature. Multiple features must
#                         be comma-separated.
#End

Format 11

Provides stdinsets 1

InsetLayout Marginal
	LabelString           margin
	LatexType             command
	LatexName             marginpar
	Font
	  Size                Small
	EndFont
	LabelFont
	  Color               marginlabel
	  Size                Small
	EndFont
	MultiPar              true
End

InsetLayout Foot
	LabelString           foot
	LatexType             command
	LatexName             footnote
	Font
	  Size                Small
	EndFont
	LabelFont
	  Color               footlabel
	  Size                Small
	EndFont
	MultiPar              true
End

InsetLayout Note:Comment
	LabelString           comment
	LatexType             environment
	LatexName             comment
	BgColor               commentbg
	LabelFont
	  Color               comment
	  Size                Small
	EndFont
	MultiPar              true
End


InsetLayout Note:Note
	LabelString           note
	LatexType             command
	LatexName             note
	BgColor               notebg
	LabelFont
	  Color               note
	  Size                Small
	EndFont
	MultiPar              true
End

InsetLayout Note:Greyedout
	LabelString           greyedout
	LatexType             environment
	LatexName             lyxgreyedout
	BgColor               greyedoutbg
	LabelFont
	  Color               greyedout
	  Size                Small
	EndFont
	MultiPar              true
End

InsetLayout ERT
	LabelString           ERT
	LatexType             none
	Decoration            minimalistic
	Font
	  Color               latex
	  Family              typewriter
	EndFont
	LabelFont
	  Color               latex
	  Size                Small
	EndFont
	MultiPar              true
	CustomPars            false
	ForcePlain            true
	PassThru              true
	KeepEmpty             true
	FreeSpacing           true
	ForceLTR              true
End

InsetLayout Listings
	LabelString           Listings
	LatexType             none
	Decoration            minimalistic
	Font
	  Color               foreground
	  Family              typewriter
	EndFont
	LabelFont
	  Color               foreground
	  Size                Small
	EndFont
	BgColor               listingsbg
	MultiPar              true
	PassThru              true
	KeepEmpty             true
	FreeSpacing           true
	ForceLTR              true
End

InsetLayout Branch
	Decoration            classic
	LabelFont
	  Color               branchlabel
	  Size                Small
	EndFont
	MultiPar              true
End

InsetLayout Index
	LabelString           Idx
	LatexType             command
	LatexName             index
	Decoration            classic
	Font
	  Size                Small
	EndFont
	LabelFont
	  Color               indexlabel
	  Size                Small
	EndFont
	MultiPar              false
	CustomPars            false
	ForcePlain            true
	NeedProtect           true
End

InsetLayout Box
	LabelFont
	  Color               foreground
	  Size                Small
	EndFont
	MultiPar              true
End

InsetLayout Box:Shaded
	BgColor               shaded
	LabelFont
	  Color               foreground
	  Size                Small
	EndFont
	MultiPar              true
End

InsetLayout Float
	LabelFont
	  Color               collapsable
	  Size                Small
	EndFont
	MultiPar              true
End

InsetLayout Wrap
	LabelFont
	  Color               collapsable
	  Size                Small
	EndFont
	MultiPar              true
End

InsetLayout URL
	LyXType               standard
	LatexName             url
	LatexType             command
	Decoration            classic
	LabelString           URL
	PassThru              true
	ForceLTR              true
	Font
	  Family              Typewriter
	  Color               urltext
	EndFont
	LabelFont
	  Family              Typewriter
	  Color               urllabel
	  Size                Small
	EndFont
	Requires              url
End

InsetLayout OptArg
	LabelString           opt
	LabelFont
	  Color               collapsable
	  Size                Small
	EndFont
	MultiPar              false
End

InsetLayout Info
	Decoration	      conglomerate
End

InsetLayout Info:menu
	LatexType             command
	LatexName             menuitem
	Preamble
	  \providecommand{\menuitem}[1]{\textsf{#1}}
	EndPreamble
	Decoration	      conglomerate
	Font
	  Family              sans
	EndFont
End

InsetLayout Info:shortcut
	LatexType             command
	LatexName             shortcut
	Preamble
	  \providecommand{\shortcut}[1]{\mbox{\textsf{#1}}}
	EndPreamble
	Decoration	      conglomerate
	Font
	  Family              sans
	EndFont
End

InsetLayout Info:shortcuts
	LatexType             command
	LatexName             shortcut
	Preamble
	  \providecommand{\shortcut}[1]{\textsf{#1}}
	EndPreamble
	Decoration	      conglomerate
	Font
	  Family              sans
	EndFont
End

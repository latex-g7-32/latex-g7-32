# Standard textclass definition file. Taken from initial LyX source code
# Author : Matthias Ettrich <ettrich@informatik.uni-tuebingen.de>
# Transposed by Pascal André <andre@via.ecp.fr>
# Heavily modifed and enhanced by several developers.

# This include files contains various standard environments for lists,
# quotations and such.


Format 11
Style Quotation
	Category              MainText
	Margin                Static
	LatexType             Environment
	LatexName             quotation
	NextNoIndent          1
	LeftMargin            MMM
	RightMargin           MMM
	ParIndent             MM
	ParSkip               0
	ItemSep               0
	TopSep                0.5
	BottomSep             0.5
	ParSep                0
	Align                 Block
	AlignPossible         Block, Left, Right, Center
End


Style Quote
	Category              MainText
	Margin                Static
	LatexType             Environment
	LatexName             quote
	NextNoIndent          1
	LeftMargin            MMM
	RightMargin           MMM
	TopSep                0.5
	ParSep                0.5
	BottomSep             0.5
	Align                 Block
	AlignPossible         Block, Left, Right, Center
	LabelType             No_Label
End


Style Verse
	# LaTeX type is first dynamic because of LaTeX implementation.
	# In LyX this does not make sense.
	Category              MainText
	LatexType             Environment
	LatexName             verse
	Margin                First_Dynamic
	NextNoIndent          1
	LeftMargin            MMMM
	LabelIndent           MMMM
	ParSkip               0.4
	TopSep                0.7
	BottomSep             0.7
	ParSep                0.5
	Align                 Block
	AlignPossible         Block, Left
	LabelType             No_Label
End


Style --Separator--
	Category              MainText
	KeepEmpty             1
	Margin                Dynamic
	LatexType             Paragraph
	LatexName             dummy
	ParIndent             MM
	Align                 Block
	LabelType             Static
	LabelString           "--- Separate Environment ---"
	LabelFont
	  Family              Roman
	  Series              Medium
	  Size                Normal
	  Color               Blue
	EndFont
End

# Standard textclass definition file. Taken from initial LyX source code
# Author : Matthias Ettrich <ettrich@informatik.uni-tuebingen.de>
# Transposed by Pascal André <andre@via.ecp.fr>
# Heavily modifed and enhanced by several developers.

# This is a base layout which is designed to be included from other
# ``standard'' layouts, like article and friends.


Format 11
Columns                 1
Sides                   1
SecNumDepth             5
TocDepth                5
DefaultStyle            Standard

# This is just to show how to declare the default font.
# The defaults are exactly those shown here.
DefaultFont
	Family                Roman
	Series                Medium
	Shape                 Up
	Size                  Normal
	Color                 None
EndFont


Style Standard
	Category              MainText
	Margin                Static
	LatexType             Paragraph
	LatexName             dummy
	ParIndent             MM
	ParSkip               0.4
	Align                 Block
	AlignPossible         Block, Left, Right, Center
	LabelType             No_Label
End

#Input stdcharstyles.inc
#Input stdcustom.inc
Input stdfloats.inc
Input g7-32_counters.inc
Input stdinsets.inc
Input g7-32_lists.inc
Input g7-32_sections.inc
Input g7-32_starsections.inc
#Input stdtitle.inc
Input g7-32_struct.inc
Input lyxmacros.inc
Input stdlayouts.inc


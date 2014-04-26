# Author : Lars Gullik Bjønnes <larsbj@lyx.org>

# This include file contains all the counters that are defined as standard
# in most LyX layouts.


Format 11
#Counter part
#	LabelString	      "\Roman{part}"
#End

Counter chapter
End

Counter section
	#Within               chapter
End

Counter subsection
	Within               section
End

Counter point
    Within               subsection
End

Counter subpoint
    Within               point
End

Counter appendix
    Within               chapter
End

Counter enumi
End

Counter enumii
	Within               enumi
End

Counter enumiii
	Within               enumii
End

Counter enumiv
	Within               enumiii
End

Counter bibitem
End

Counter listing
End

Counter equation
End

Counter footnote
End

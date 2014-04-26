# Author : Lars Gullik Bjønnes <larsbj@lyx.org>

# This include file contains all the floats that are defined as standard
# in most LyX layouts.


Format 4
Float
	Type                  table
	GuiName               Table
	Placement             tbp
	Extension             lot
	NumberWithin          none
	Style                 plain
	ListName              "Список таблиц"
	LaTeXBuiltin          true
End


Float
	Type                  figure
	GuiName               Figure
	Placement             tbp
	Extension             lof
	NumberWithin          none
	Style                 plain
	ListName              "Список рисунков"
	LaTeXBuiltin          true
End


Float
	Type                  algorithm
	GuiName               Algorithm
	Placement             tbp
	Extension             loa
	NumberWithin          none
	Style                 ruled
	ListName              "Список алгоритмов"
	LaTeXBuiltin          false
End

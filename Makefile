# Tools

# LATEX=xelatex -interaction=nonstopmode -shell-escape
LATEX=pdflatex
TD=./utils/texdepend
D2T=dot2tex -f pgf --crop --docpreamble "\usepackage[T2A]{fontenc} \usepackage[utf8]{inputenc} \usepackage[english, russian]{babel}"
PDFTRIMWHITE=./utils/pdfcrop

# Output file
PDF=rpz.pdf

# Input paths
DIA=graphics/dia
DOT=graphics/dot
SVG=graphics/svg
TEX=tex
DEPS=.deps
SRC=src
INC=$(TEX)/inc

# Input files
# no .tex allowed in MAINTEX!
MAINTEX=rpz
BIBFILE=$(TEX)/rpz.bib
PREAMBLE=preamble-std.tex
STYLES=$(TEX)/GostBase.clo $(TEX)/G7-32.sty $(TEX)/G7-32.cls $(TEX)/G2-105.sty
PARTS_TEX = $(wildcard $(TEX)/[0-9][0-9]-*.tex)


ifeq ($(firstword $(LATEX)), pdflatex)
	CODE_CONVERTION=iconv -f UTF-8 -t KOI8-R 
else
	CODE_CONVERTION=cat
endif


all: $(PDF)

.PHONY: all tarball clean

PARTS_DEPS=$(PARTS_TEX:tex/%=$(DEPS)/%-deps.mk)
-include $(PARTS_DEPS)

MAIN_DEP=$(DEPS)/$(MAINTEX).tex-deps.mk
-include $(MAIN_DEP)

$(DEPS)/%-deps.mk: $(TEX)/% Makefile
	mkdir -p $(DEPS)
	(/bin/echo -n "$(PDF): " ; $(TD) -print=fi -format=1 $< | grep -v '^#' | xargs /bin/echo) > $@

$(PDF): $(TEX)/$(MAINTEX).tex $(STYLES) $(BIBFILE)
	cd tex && $(LATEX) $(MAINTEX)
	cd tex && bibtex $(MAINTEX)
	cd tex && $(LATEX) $(MAINTEX)
	cd tex && $(LATEX) $(MAINTEX)
	cp tex/$(PDF) .

$(INC)/dia/%.pdf: $(DIA)/%.dia
	mkdir -p $(INC)/dia
	dia -e $@.tmp.pdf -t pdf $<
	$(PDFTRIMWHITE) $@.tmp.pdf $@

$(INC)/svg/%.pdf : $(SVG)/%.svg
	mkdir -p $(INC)/svg/
# 	inkscape -A $@ $<
# Обрезаем поля в svg автоматом:
	inkscape -A $(INC)/svg/$*-tmp.pdf $<
	cd $(INC)/svg && \
		../../../$(PDFTRIMWHITE) $*-tmp.pdf $*.pdf && \
		rm $*-tmp.pdf

# .dot -> .pdf
$(INC)/dot/%.pdf: $(DOT)/%.dot
	mkdir -p $(INC)/dot
	dot -Tpdf $< > $@
	# dot -Tpdf $< > $@.tmp.pdf
	# $(PDFTRIMWHITE) $@.tmp.pdf $@

$(INC)/src/%: $(SRC)/%
	mkdir -p $(INC)/src
	$(CODE_CONVERTION) $< > $@

clean:
	find $(TEX)/ -regextype posix-egrep -type f ! -regex ".*\.(sty|tex|clo|cls|bib|bst|gitignore)" -exec $(RM) {} \; ;
# 	$(RM) $(DIA)/*.pdf $(DIA)/*.eps
	$(RM) -r $(DEPS)
	$(RM) -r $(INC)

distclean: clean

PACK = $(addprefix latex-g7-32/, Makefile tex/* src/* utils/* graphics/*)

tarball: $(PDF) clean
	cd ..; rm latex-G7-32.tar.gz; tar -czf latex-G7-32.tar.gz $(PACK)

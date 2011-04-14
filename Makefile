# Tools

PDFLATEX=pdflatex -interaction=nonstopmode
TD=./utils/texdepend
# TODO: dot2tex lacks any record support.
# D2T=dot2tex -f tikz --crop

# Output file
PDF=rpz.pdf

# Input paths
DIA=dia
DOT=dot
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

all: $(PDF)

.PHONY: all tarball clean

PARTS_DEPS=$(PARTS_TEX:tex/%=$(DEPS)/%-deps.mk)
-include $(PARTS_DEPS)

MAIN_DEP=$(DEPS)/$(MAINTEX).tex-deps.mk
-include $(MAIN_DEP)


$(DEPS)/%-deps.mk: $(TEX)/% Makefile
	mkdir -p $(DEPS)
	(echo -n "$(PDF): " ; $(TD) -print=fi -format=1 $< | grep -v '^#' | xargs echo) > $@

$(PDF): $(TEX)/$(MAINTEX).tex $(STYLES) $(BIBFILE)
	cd tex && $(PDFLATEX) $(MAINTEX) && bibtex $(MAINTEX) && $(PDFLATEX) $(MAINTEX) && $(PDFLATEX) $(MAINTEX) && cp $(PDF) ..

$(INC)/dia/%.pdf: $(DIA)/%.dia
	mkdir -p $(INC)/dia
	dia -e $(@:%.pdf=%.eps) -t eps $< && epstopdf --outfile $@ $(@:%.pdf=%.eps)

# .dot -> .eps (via dot2)
$(INC)/dot/%.eps: $(DOT)/%.dot
	mkdir -p $(INC)/dot
	dot -Teps $< > $@

# .eps --> .pdf
$(INC)/dot/%.pdf: $(INC)/dot/%.eps
	epstopdf --outfile $@ $<


# .dot -> .tex (via dot2tex)
# $(INC)/dot/%.tex: $(DOT)/%.dot
# 	mkdir -p $(INC)/dot
# 	$(D2T) --preproc $< | $(D2T)  > $@
# 	$(D2T) $< > $@

# .dot -> .tex --> .pdf
# $(INC)/dot/%.pdf: $(INC)/dot/%.tex
# 	$(PDFLATEX) -output-directory=$(INC)/dot $<

$(INC)/src/%: $(SRC)/%
	mkdir -p $(INC)/src
	iconv -f=UTF-8 -t=KOI8-R $< > $@

clean:
	find $(TEX)/ -regextype posix-egrep -type f ! -regex ".*\.(sty|tex|clo|cls|bib|bst|gitignore)" -exec $(RM) {} \; ;
	$(RM) $(DIA)/*.pdf $(DIA)/*.eps
	$(RM) -r $(DEPS)
	$(RM) -r $(INC)

distclean: clean

PACK = $(addprefix latex-g7-32/, Makefile tex/* src/* utils/* dia/*.dia)

tarball: $(PDF) clean
	cd ..; rm latex-G7-32.tar.gz; tar -czf latex-G7-32.tar.gz $(PACK)

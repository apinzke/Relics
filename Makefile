# Makefile to produce the article.
LATEX  =  TEXINPUTS=.//: BSTINPUTS=.//: latex
DVIPS  =  dvips
FIGURES = 

.PRECIOUS: $(FIGURES)

default: paper.ps

%.ps :  $(FIGURES) %.tex
	$(LATEX) $*.tex
	TEXINPUTS=:.// BSTINPUTS=:.// bibtex $*
	cat $*.bbl | sed 's/, \\&/, /' > tmp.bbl
	mv tmp.bbl $*.bbl
	$(LATEX) $*.tex
	$(LATEX) $*.tex
	$(LATEX) $*.tex
	$(DVIPS) -o $*.ps $*.dvi
	make clean

figures/%.eps: figures/%_raw.eps figures/%.tex
	(cd figures; latex $*.tex; \
	dvips -E -o $*.eps $*.dvi; \
	perl -ane '{ s/%%BoundingBox: [-0-9]+/%%BoundingBox: 135/g; print}' $*.eps > tmp.eps; \
	mv tmp.eps $*.eps; \
	rm -f *.dvi *.log *.aux)

clean:
	rm -f *.log *.toc *.aux *.dvi *.bak *.bbl *.blg *.obj *.out

realclean:
	rm -f *.log *.toc *.aux *.dvi *.obj *.bak *.bbl *.blg *.brf \
              *.ps */*.ps *~ */*~ *.bak */*.bak 









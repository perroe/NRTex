# $Id: Makefile,v 1.18 2003-10-01 14:05:21 soleng Exp $

MAIN  = nrdoc
MANUAL = manual
PRINT  = printmanual
INSTALLPATH = /nr/group/maler/nrdoc
WEBPATH = /nr/www/virtual/intern.nr.no/htdocs/drift


.SUFFIXES: .nw .tex .dvi .pdf

src:
	noweb $(MAIN).nw

all:	src pdf 

dvi: 	src
	latex '\scrollmode \input '"$(MAIN)";\
	latex '\scrollmode \input '"$(MAIN)";\
	while ( \
	grep -s 'No file $(MAIN).toc' $(MAIN).log || \
	grep -s 'Rerun to get cross-references right'\
	$(MAIN).log ); \
	do latex '\scrollmode \input '"$(MAIN)";\
	done

bib:
	latex '\scrollmode \input '"$(MAIN)"; \
	bibtex $(MAIN)

pdf:    dvi
	dvipdfm -p a4 -o   $(MAIN).pdf $(MAIN).dvi

manual: src
	latex '\scrollmode \input '"$(MANUAL)";\
	makeindex $(MANUAL); \
	bibtex $(MANUAL); \
	latex '\scrollmode \input '"$(MANUAL)";\
	while ( \
	grep -s 'No file $(MANUAL).toc' $(MANUAL).log || \
	grep -s 'Rerun to get cross-references right'\
	$(MANUAL).log ); \
	do latex '\scrollmode \input '"$(MANUAL)"; \
	done; \
	dvipdfm -p a4 -o   $(MANUAL).pdf $(MANUAL).dvi


printmanual: src
	perl -e 'open (IFILE,"<manual.tex"); open(OFILE,">printmanual.tex"); while(<IFILE>) { s/\\documentclass\[note,screen,twoside,british,12pt\]\{nrdoc\}/\\documentclass\[note,twoside,british,12pt\]\{nrdoc\}/;print OFILE; } close(IFILE); close(OFILE)';
	latex '\scrollmode \input '"$(PRINT)";\
	makeindex $(PRINT); \
	bibtex $(PRINT); \
	latex '\scrollmode \input '"$(PRINT)";\
	while ( \
	grep -s 'No file $(PRINT).toc' $(PRINT).log || \
	grep -s 'Rerun to get cross-references right'\
	$(PRINT).log ); \
	do latex '\scrollmode \input '"$(PRINT)"; \
	done; \
	dvipdfm -p a4 -o   $(PRINT).pdf $(PRINT).dvi


html:	src
	latex2html -dir manual.web -local_icons manual

install: src pdf html manual printmanual
	cp nrdoc.cls $(INSTALLPATH)/	
	cp nrdoc.pdf $(INSTALLPATH)/	
	cp manual.pdf $(INSTALLPATH)/	
	cp nrdoc.pdf $(WEBPATH)/latex-maler/
	cp nrdoc.html $(WEBPATH)/info/latex-maler.html
	cp $(MANUAL).pdf $(WEBPATH)/latex-maler/	
	cp $(MANUAL).tex $(WEBPATH)/latex-maler/
	cp -r $(MANUAL).web/*  $(WEBPATH)/latex-maler/$(MANUAL).web/	
	cp $(PRINT).pdf $(WEBPATH)/latex-maler/

clean:
	rm -f  *~ *.aux *.dvi \
	*.log *.pdf *.bbl *.out *.blg *.brf *.ind *.ps *.toc \
	*.idx *.lof *.ilg


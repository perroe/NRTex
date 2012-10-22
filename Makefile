DESTDIR =

MAIN        = nrdoc
MANUAL      = manual
PRINT       = printmanual
DATE        = $(shell date)
VERSION     = $(shell cat version)
RELEASE     = $(shell cat release)
INSTALLPATH = $(DESTDIR)/nr/group/maler/nrdoc
WEBPATH     = $(DESTDIR)/nr/www/virtual/files.nr.no/htdocs
TGZNAME     = nrtex-${VERSION}

.SUFFIXES: .tex .dvi .pdf
.PHONY:    all clean manual printmanual html install

all:	manual

manual:  
	pdflatex '\scrollmode \input $(MANUAL)'
	makeindex $(MANUAL)
	bibtex $(MANUAL)
	pdflatex '\scrollmode \input $(MANUAL)'
	while ( \
	    grep -s 'No file $(MANUAL).toc' $(MANUAL).log || \
	    grep -s 'Rerun to get cross-references right' $(MANUAL).log ); \
	    do pdflatex '\scrollmode \input '"$(MANUAL)"; \
	    done; 

printmanual: 
	perl -pe '$$. < 10 && s/,screen,/,twoside,/' manual.tex > printmanual.tex
	pdflatex '\scrollmode \input $(PRINT)'
	makeindex $(PRINT)
	bibtex $(PRINT)
	pdflatex '\scrollmode \input $(PRINT)'
	while ( \
	    grep -s 'No file $(PRINT).toc' $(PRINT).log || \
	    grep -s 'Rerun to get cross-references right' $(PRINT).log ); \
	    do pdflatex '\scrollmode \input '"$(PRINT)"; \
	    done; 

html:	
	perl -pe 's/<<version_number>>/$(VERSION)/; s/<<patch_number>>/$(RELEASE)/; s/<<date>>/$(DATE)/;' nrdoc.html.in > nrdoc.html
	latex2html -split 0 -no_navigation -dir manual.web -local_icons manual

install: html manual printmanual
	install -m 775 -d $(INSTALLPATH)
	install -m 775 -d $(INSTALLPATH)/elements
	install -m 775 -d $(INSTALLPATH)/logos
	install -m 775 -d $(WEBPATH)/latex-maler
	install -m 775 -d $(WEBPATH)/latex-maler/$(MANUAL).web
	install -m 664 nrdoc.cls $(INSTALLPATH)
	install -m 664 elements/*.eps $(INSTALLPATH)/elements
	install -m 664 elements/*.pdf $(INSTALLPATH)/elements
	install -m 664 logos/*.eps $(INSTALLPATH)/logos
	install -m 664 logos/*.pdf $(INSTALLPATH)/logos
	install -m 664 nrdocold.cls $(INSTALLPATH)
	install -m 664 nrfoils.cls $(INSTALLPATH)
	install -m 664 background.sty $(INSTALLPATH)
	install -m 664 pause.sty $(INSTALLPATH)
	install -m 664 manual.pdf $(INSTALLPATH)
	install -m 664 apalike-url-norsk.bst $(INSTALLPATH)
	install -m 664 apalike-url.bst $(INSTALLPATH)
	install -m 664 unsrturl.bst $(INSTALLPATH)
	install -m 664 nrdoc.html $(WEBPATH)/latex-maler/index.html
	install -m 664 $(MANUAL).pdf $(WEBPATH)/latex-maler
	install -m 664 $(MANUAL).tex $(WEBPATH)/latex-maler
	install -m 664 $(MANUAL).web/* $(WEBPATH)/latex-maler/$(MANUAL).web
	install -m 664 $(PRINT).pdf $(WEBPATH)/latex-maler

tgz:	manual
	mkdir -p ${TGZNAME}
	mkdir -p ${TGZNAME}/elements
	mkdir -p ${TGZNAME}/logos
	cp logos/*.pdf logos/*.eps logos/*.jpg logos/*.png  ${TGZNAME}/logos;
	cp elements/*.eps elements/*.pdf ${TGZNAME}/elements; 
	cp ${MAIN}.cls ${MAIN}old.cls nrfoils.cls background.sty pause.sty \
	$(MANUAL).pdf apalike-url.bst apalike-url-norsk.bst \
	unsrturl.bst \
	nrunsrt.bst nrnorsk.bst  nrplain.bst ${TGZNAME}
	tar cvfz rpm/${TGZNAME}.tar.gz ${TGZNAME}

clean:
	make -C rpm clean
	rm -f  nrdoc.html printmanual.tex manual.web/* *~ *.aux *.dvi \
	*.log *.pdf *.bbl *.out *.blg *.brf *.ind *.ps *.toc \
	*.idx *.lof *.ilg
	rm -rf ${TGZNAME}

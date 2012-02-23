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
	install -d $(INSTALLPATH)
	install -d $(INSTALLPATH)/elements
	install -d $(INSTALLPATH)/logos
	install -d $(WEBPATH)/latex-maler
	install -d $(WEBPATH)/latex-maler/$(MANUAL).web
	install nrdoc.cls $(INSTALLPATH)
	install elements/*.eps $(INSTALLPATH)/elements
	install elements/*.pdf $(INSTALLPATH)/elements
	install logos/*.eps $(INSTALLPATH)/logos
	install logos/*.pdf $(INSTALLPATH)/logos
	install nrdocold.cls $(INSTALLPATH)
	install nrfoils.cls $(INSTALLPATH)
	install background.sty $(INSTALLPATH)
	install pause.sty $(INSTALLPATH)
	install manual.pdf $(INSTALLPATH)
	install apalike-url-norsk.bst $(INSTALLPATH)
	install apalike-url.bst $(INSTALLPATH)
	install unsrturl.bst $(INSTALLPATH)
	install nrdoc.html $(WEBPATH)/latex-maler/index.html
	install $(MANUAL).pdf $(WEBPATH)/latex-maler
	install $(MANUAL).tex $(WEBPATH)/latex-maler
	install $(MANUAL).web/* $(WEBPATH)/latex-maler/$(MANUAL).web
	install $(PRINT).pdf $(WEBPATH)/latex-maler
#	chgrp -Rf www  $(WEBPATH)/latex-maler   # Operation not permitted!

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

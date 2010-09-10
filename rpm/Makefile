# This makefile builds an rpm package

VERSION  = $(shell cat ../version)
RELEASE  = $(shell cat ../release)
RPMFLAGS =  --define "_sourcedir $$PWD" \
            --define "_builddir $$PWD/BUILD" \
            --define "_rpmdir $$PWD" \
            --define "_srcrpmdir $$PWD"
RPMFILE  = ../nrtex-${VERSION}-${PATCH}.i586.rpm

.PHONY:    all rpm

all:	rpm

rpm:
	perl -pe 's/<<version_number>>/$(VERSION)/; s/<<patch_number>>/$(RELEASE)/;' rpmspecfile.in > nrtex.spec
	make -C .. tgz

	-rm -rf BUILD/*
	mkdir -p BUILD
	rpmbuild ${RPMFLAGS} --target i586 -v -bb --clean  nrtex.spec

clean:
	rm -rf BUILD i586
	rm -f *.tar.gz nrtex.spec

prefix = /usr/local
bindir = $(prefix)/bin
libdir = $(prefix)/lib/supervise-scripts

install = install
installbin = $(install) -m 755
installdir = $(install) -d

PACKAGE = supervise-scripts
VERSION = 2.4
DISTDIR = $(PACKAGE)-$(VERSION)

SCRIPTS = svc-isdown svc-isup svc-waitdown svc-waitup \
	svc-start svc-stop svc-status
DOCS = COPYING README YEAR2000
DIST = Makefile configure *.in $(DOCS)

all: configure
	sh configure

install: all
	$(installdir) $(bindir)
	$(installbin) $(SCRIPTS) $(bindir)

distdir:
	rm -rf $(DISTDIR)
	mkdir $(DISTDIR)
	sed -e s/%VERSION%/$(VERSION)/ spec >$(DISTDIR)/$(DISTDIR).spec
	cp -a $(DIST) $(DISTDIR)

dist: distdir
	tar -czf $(DISTDIR).tar.gz $(DISTDIR)
	rm -rf $(DISTDIR)

rpms: dist
	rpm -ta --clean --target=noarch $(DISTDIR).tar.gz
	mv ~/redhat/RPMS/noarch/$(DISTDIR)-*.noarch.rpm .
	mv ~/redhat/SRPMS/$(DISTDIR)-*.src.rpm .

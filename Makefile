PACKAGE = supervise-scripts
VERSION = 3.1

prefix = /usr/local
bindir = $(prefix)/bin
libdir = $(prefix)/lib/supervise-scripts
mandir = $(prefix)/man
man1dir = $(mandir)/man1

install = install
installbin = $(install) -m 555
installdir = $(install) -d
installsrc = $(install) -m 444

SCRIPTS = svc-isdown svc-isup svc-waitdown svc-waitup \
	svc-start svc-stop svc-status \
	svscan-start
MAN1S = svc-add.1 svc-remove.1
DOCS = COPYING NEWS README
DIST = Makefile configure *.in svscan-start $(DOCS)

all: configure
	sh configure

install: all
	$(installdir) $(bindir)
	$(installbin) $(SCRIPTS) $(bindir)

	$(installdir) $(man1dir)
	$(installsrc) $(MAN1S) $(man1dir)

install-config: install ./svscan-add-to-inittab
	$(installdir) /service
	./svscan-add-to-inittab

distdir = $(PACKAGE)-$(VERSION)
distdir:
	$(RM) -r $(distdir)
	mkdir $(distdir)
	cp -a $(DIST) $(distdir)
	sed -e "s/%VERSION%/$(VERSION)/" spec >$(distdir)/$(distdir).spec

dist: distdir
	tar -czf $(distdir).tar.gz $(distdir)
	$(RM) -r $(distdir)

rpms: dist
	rpm -ta --clean $(distdir).tar.gz
	mv $(HOME)/redhat/SRPMS/$(distdir)-*.src.rpm .
	mv $(HOME)/redhat/RPMS/noarch/$(distdir)-*.noarch.rpm .

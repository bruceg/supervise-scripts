PACKAGE = supervise-scripts
VERSION = 3.1

install_prefix =
prefix = /usr/local
bindir = $(prefix)/bin
mandir = $(prefix)/man
man1dir = $(mandir)/man1

install = install
installbin = $(install) -m 555
installdir = $(install) -d
installsrc = $(install) -m 444

SCRIPTS = svc-isdown svc-isup svc-waitdown svc-waitup \
	svc-add svc-remove svc-start svc-stop svc-status \
	svscan-add-to-inittab svscan-start svscan-stopall
MAN1S = svc-add.1 svc-remove.1 svc-start.1 svc-stop.1
DOCS = COPYING NEWS README
DIST = $(DOCS) $(MAN1S) Makefile configure template.sh *.in \
	svscan-add-to-inittab svscan-start svscan-stopall

all: configure
	sh configure svc-*.in

install: all
	$(installdir) $(install_prefix)$(bindir)
	$(installbin) $(SCRIPTS) $(install_prefix)$(bindir)

	$(installdir) $(install_prefix)$(man1dir)
	$(installsrc) $(MAN1S) $(install_prefix)$(man1dir)

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

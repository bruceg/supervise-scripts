prefix = /usr/local
bindir = $(prefix)/bin
libdir = $(prefix)/lib/supervise-scripts

install = install
installbin = $(install) -m 755
installdir = $(install) -d

PACKAGE = supervise-scripts
VERSION = 3.0

SCRIPTS = svc-isdown svc-isup svc-waitdown svc-waitup \
	svc-start svc-stop svc-status \
	svscan-start
DOCS = COPYING NEWS README
DIST = Makefile configure *.in svscan-start $(DOCS)

all: configure
	sh configure

install: all
	$(installdir) $(bindir)
	$(installbin) $(SCRIPTS) $(bindir)

install-config: install
	if ! grep '^SV:' /etc/inittab >/dev/null 2>&1; then \
	  echo "SV:23456:respawn:/usr/bin/svscan-start /service" >>/etc/inittab\
	fi
	$(installdir) /service

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

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
DOCS = COPYING README
DIST = Makefile configure *.in $(DOCS)

all: configure
	sh configure

install: all
	$(installdir) $(bindir)
	$(installbin) $(SCRIPTS) $(bindir)


Name: supervise-scripts
Summary: Utility scripts for use with supervise and svscan.
Version: %VERSION%
Release: 1
Copyright: GPL
Group: Utilities/System
Source: http://em.ca/~bruceg/supervise-scripts/supervise-scripts-%VERSION%.tar.gz
BuildRoot: /tmp/supervise-scripts-root
BuildArch: noarch
URL: http://em.ca/~bruceg/supervise-scripts/
Packager: Bruce Guenter <bruceg@em.ca>
Requires: daemontools >= 0.70-2
Requires: fileutils
Requires: grep
Requires: sh-utils
Requires: textutils

%description
A set of scripts for handling programs managed with supervise and svscan.

%prep
%setup

%build

%install
rm -fr $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/usr
mkdir -p $RPM_BUILD_ROOT/service

make install_prefix=$RPM_BUILD_ROOT bindir=%{_bindir} mandir=%{_mandir} install

%post
/usr/bin/svscan-add-to-inittab

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
%doc COPYING NEWS README
%dir /service
%{_bindir}/*
%{_mandir}/man*/*

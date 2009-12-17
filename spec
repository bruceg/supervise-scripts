Name: supervise-scripts
Summary: Utility scripts for use with supervise and svscan.
Version: @VERSION@
Release: 1
License: GPL
Group: Utilities/System
Source: http://untroubled.org/supervise-scripts/supervise-scripts-%{version}.tar.gz
BuildRoot: %{_tmppath}/supervise-scripts-root
BuildArch: noarch
URL: http://untroubled.org/supervise-scripts/
Packager: Bruce Guenter <bruceg@em.ca>
Requires: daemontools >= 0.76
Requires: fileutils
Requires: grep
Requires: sh-utils
Requires: textutils

%description
A set of scripts for handling programs managed with supervise and svscan.

%prep
%setup

%build
echo %{_bindir} >conf-bin
echo %{_mandir} >conf-man
make programs

%install
rm -fr $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT%{_bindir}
mkdir -p $RPM_BUILD_ROOT%{_mandir}
mkdir -p $RPM_BUILD_ROOT/service
mkdir -p $RPM_BUILD_ROOT/var/service

make PREFIX=$RPM_BUILD_ROOT install

%post
%{_bindir}/svscan-add-to-inittab

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
%doc COPYING NEWS README
%{_bindir}/*
%{_mandir}/man*/*
%dir /service
%dir /var/service

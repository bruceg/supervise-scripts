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
Requires: daemontools = 0.70

%description
A set of scripts for handling programs managed with supervise and svscan.

%prep
%setup

%build

%install
rm -fr $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/usr

make prefix=$RPM_BUILD_ROOT/usr install

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
%doc COPYING README YEAR2000
/usr/bin/*


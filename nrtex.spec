# $Id: nrtex.spec,v 1.2 2003-10-15 08:14:38 soleng Exp $
%define name nrtex
%define version 0.1.0
%define release 1



Summary: NR Latex document class
Name: %{name}
Version: %{version}
Release: %{release}
Copyright: Norwegian Computing Center
Group: Applications/Publishing
BuildRoot: %{name}-buildroot
Source0:  %{name}-%{version}.tar.gz
Requires: tetex

%description
NR Latex document class. Install nrtex if you'd like to
be able to produce NR reports or notes using latex.

%prep

%setup -q

%build
# TODO now suppose already built

%install

mkdir -p -m755  %{buildroot}/usr/share/texmf/tex/latex/nrdoc/ 
mkdir -p -m755  %{buildroot}/usr/share/texmf/doc/latex/nrdoc/
mkdir -p -m755  %{buildroot}/usr/share/texmf/tex/latex/nrdoc/logos/
install -m644 manual.pdf  %{buildroot}/usr/share/texmf/doc/latex/nrdoc/
install -m644 *.eps *.pdf  %{buildroot}/usr/share/texmf/tex/latex/nrdoc/logos/
install -m644 nrdoc.cls  %{buildroot}/usr/share/texmf/tex/latex/nrdoc/

%clean
rm -rf %{buildroot}

%post -p /usr/bin/texhash

%postun -p /usr/bin/texhash

%files
%defattr(-, root, root)
/usr/share/texmf/tex/latex/nrdoc/nrdoc.cls
/usr/share/texmf/tex/latex/nrdoc/logos/*
/usr/share/texmf/doc/latex/nrdoc/manual.pdf

%changelog
* Wed Oct 15 2003 Harald H. Soleng <harald.soleng@nr.no>
- Initial Release 

# $Id: nrtex.spec,v 1.8 2003-10-21 10:16:21 jornv Exp $

# %_topdir: $HOME/nrtex/rpm
Summary: NR Latex document class
Name: nrtex
Version: 0.6.0
Release: 1
Copyright: Norwegian Computing Center
Group: Applications/Publishing
BuildRoot: %{_builddir}/%{name}-root
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
mkdir -p -m755  %{buildroot}/usr/share/texmf/bibtex/bst/nrdoc/
mkdir -p -m755  %{buildroot}/usr/share/texmf/tex/latex/nrdoc/ 
mkdir -p -m755  %{buildroot}/usr/share/texmf/doc/latex/nrdoc/
mkdir -p -m755  %{buildroot}/usr/share/texmf/tex/latex/nrdoc/logos/
install -m644 manual.pdf  %{buildroot}/usr/share/texmf/doc/latex/nrdoc/
install -m644 *.eps *.pdf  %{buildroot}/usr/share/texmf/tex/latex/nrdoc/logos/
install -m644 nrdoc.cls  %{buildroot}/usr/share/texmf/tex/latex/nrdoc/
install -m644 *.bst %{buildroot}/usr/share/texmf/bibtex/bst/nrdoc/

%clean
rm -rf %{buildroot}

%post -p /usr/bin/texhash

%postun -p /usr/bin/texhash

%files
%defattr(-, root, root)
/usr/share/texmf/tex/latex/nrdoc/nrdoc.cls
/usr/share/texmf/tex/latex/nrdoc/logos/*
/usr/share/texmf/doc/latex/nrdoc/manual.pdf
/usr/share/texmf/bibtex/bst/nrdoc/nrplain.bst
/usr/share/texmf/bibtex/bst/nrdoc/nrunsrt.bst


%changelog
* Wed Oct 15 2003 Harald H. Soleng <harald.soleng@nr.no>
- Initial Release 

# $Id: nrtex.spec,v 1.1 2003-10-14 11:42:44 jornv Exp $

# %define _resourcedir %{_datadir}/mediakit

Summary: NR Latex drafts
Name: nrtex
Version: 0.1.0
Release: 1
Group: Applications/Publishing
Source0: %{name}-%{version}.tar.gz
License:whoknows
BuildRoot: %{_tmppath}/%{name}-root
#Requires: kino
#Requires: mplayer
#Requires: mediakit_dvd

%description
NR Latex drafts

%prep
%setup -q

%build
# TODO now suppose already built

%install
rm -rf %{buildroot}
mkdir -p -m755  %{buildroot}/usr/share/texmf/tex/latex/nrdoc
mkdir -p -m755  %{buildroot}/usr/share/texmf/tex/latex/nrdoc/logos/
install -m644 *.eps *.pdf  %{buildroot}/usr/share/texmf/tex/latex/nrdoc/logos/
install -m644 nrdoc.cls  %{buildroot}/usr/share/texmf/tex/latex/nrdoc/

%clean
rm -rf %{buildroot}

%post -p /sbin/ldconfig

%postun -p /sbin/ldconfig

%files
%defattr(-, root, root)
/usr/share/texmf/tex/latex/nrdoc/nrdoc.cls
/usr/share/texmf/tex/latex/nrdoc/logos/*


%changelog
* Thu Mar 27 2003 Joern Inge Vestgaarden <jornv@nr.no>
- Initial Release 

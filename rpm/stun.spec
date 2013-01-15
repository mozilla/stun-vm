%define	download_name	stund
%define download_version	_0.96_Aug13.tgz

Name:		stun
Version:	0.96
Release:	5svc%{?dist}
Summary:	Implements a simple Stun Client
Group:		Applications/Communications
License:	Vovida Software License 1.0
Packager:	Mozilla Services Operations <services-ops@mozilla.com>
URL:		http://sourceforge.net/projects/%{name}
Source0:	http://downloads.sourceforge.net/%{name}/%{download_name}%{download_version}
BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
# Fix AWS NAT issues: http://www.voip-info.org/wiki/view/Vovida.org+STUN+server
Patch1:		stund.patch

%description
Implements a simple STUN client on Windows, Linux, and Solaris. 
The STUN protocol (Simple Traversal of UDP through NATs) is described in the 
IETF RFC 3489, available at http://www.ietf.org/rfc/rfc3489.txt

%package server
Summary:	Implements the Stun Server
Group:		Applications/Communications

%description server
Implements a simple STUN client on Windows, Linux, and Solaris.
The STUN protocol (Simple Traversal of UDP through NATs) is described in the
IETF RFC 3489, available at http://www.ietf.org/rfc/rfc3489.txt


%prep
%setup -q  -n %{download_name}
%patch1 -p1

%build
make %{?_smp_mflags}


%install
rm -rf $RPM_BUILD_ROOT

mkdir -p $RPM_BUILD_ROOT%{_bindir}
mkdir -p $RPM_BUILD_ROOT%{_sbindir}
install   client $RPM_BUILD_ROOT%{_bindir}/stun-client
install   server $RPM_BUILD_ROOT%{_sbindir}/stun-server



%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%doc rfc3489.txt
%{_bindir}/stun-client

%files server
%{_sbindir}/stun-server




%changelog
* Mon Jan 14 2013 Wesley Dawson <whd@mozilla.com> - 0.96-5svc
- Initial version for Mozilla
- Fix NAT handling for AWS (patch1)
- Remove patch0 (patch1 is a superset)

* Sun Jul 26 2009 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 0.96-4
- Rebuilt for https://fedoraproject.org/wiki/Fedora_12_Mass_Rebuild

* Sun Jul 26 2009 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 0.96-4
- Rebuilt for https://fedoraproject.org/wiki/Fedora_12_Mass_Rebuild

* Wed Feb 25 2009 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 0.96-3
- Rebuilt for https://fedoraproject.org/wiki/Fedora_11_Mass_Rebuild

* Wed Apr 9 2008 Huzaifa Sidhpurwala <huzaifas@redhat.com> - 0.96-2
- Patched for ppc and x86_64

* Mon Jan 21 2008 Huzaifa Sidhpurwala <huzaifas@redhat.com> - 0.96-1
- Used correct macros

* Mon Jan 21 2008 Huzaifa Sidhpurwala <huzaifas@redhat.com> - 0.96-0
- Initial version


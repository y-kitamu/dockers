MAINTAINER Yusuke Kitamura

# https://orebibou.com/2015/03/centos-7とsamba4で自宅用active-directory-domain-controller-ad-dcを構築する①-インスト/

FROM centos:latest

RUN echo "ADLocal" > /etc/hostname
RUN echo "HOSTNAME=ADLocal" >> /etc/sysconfig/network

RUN yum -y install perl gcc libacl-devel libblkid-devel gnutls-devel \
readline-devel python-devel gdb pkgconfig krb5-workstation \
zlib-devel setroubleshoot-server libaio-devel \
setroubleshoot-plugins policycoreutils-python \
libsemanage-python setools-libs-python setools-libs \
popt-devel libpcap-devel sqlite-devel libidn-devel \
libxml2-devel libacl-devel libsepol-devel libattr-devel \
keyutils-libs-devel cyrus-sasl-devel cups-devel bind-utils \
libxslt docbook-style-xsl openldap-devel

RUN yum -y install --downloadonly --downloaddir=/tmp perl gcc libacl-devel libblkid-devel gnutls-devel \
readline-devel python-devel gdb pkgconfig krb5-workstation \
zlib-devel setroubleshoot-server libaio-devel \
setroubleshoot-plugins policycoreutils-python \
libsemanage-python setools-libs-python setools-libs \
popt-devel libpcap-devel sqlite-devel libidn-devel \
libxml2-devel libacl-devel libsepol-devel libattr-devel \
keyutils-libs-devel cyrus-sasl-devel cups-devel bind-utils \
libxslt docbook-style-xsl openldap-devel

RUN yum localinstall --nogpgcheck ./*.rpm


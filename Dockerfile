FROM centos:8

MAINTAINER Sergey Malinkin <malinkinsa@yandex.ru>

RUN \
dnf -y install epel-release dnf-plugins-core && \
dnf config-manager --set-enabled PowerTools

RUN \
dnf -y update && \
dnf -y install epel-release && \
dnf -y install \
wget \ 
autoconf \
automake \
file \
findutils \
hiredis \
hyperscan \
iproute \
jansson \
lua-libs \
libyaml \
libnfnetlink \
libnetfilter_queue \
libnet \
libcap-ng \
libevent \
libmaxminddb \
libpcap \
libprelude \
logrotate \
lz4 \
net-tools \
nss \
nss-softokn \
pcre \
procps-ng \
python3 \
python3-yaml \
tcpdump \
which \
zlib \
file \
file-devel \
gcc \
gcc-c++ \
hiredis-devel \
hyperscan-devel \
jansson-devel \
jq \
lua-devel \
libtool \
libyaml-devel \
libnfnetlink-devel \
libnetfilter_queue-devel \
libnet-devel \
libcap-ng-devel \
libevent-devel \
libmaxminddb-devel \
libpcap-devel \
libprelude-devel \
libtool \
lz4-devel \
make \
nspr-devel \
nss-devel \
nss-softokn-devel \
pcre-devel \
pkgconfig \
python3-devel \
python3-yaml \
which \
zlib-devel \
rust \
cargo 

WORKDIR /opt

RUN wget https://www.openinfosecfoundation.org/download/suricata-5.0.3.tar.gz && tar xzf suricata-5.0.3.tar.gz

WORKDIR /opt/suricata-5.0.3

RUN ./configure --prefix=/usr/ --sysconfdir=/etc/ --localstatedir=/var/ --enable-lua --enable-geoip --enable-profiling --enable-debug && make && make install-full

RUN rm -rf /opt/suricata-5.0.3/

WORKDIR /opt

RUN mkdir -p /var/log/suricata

VOLUME /etc/suricata
VOLUME /etc/suricata/rules
VOLUME /var/log/suricata

COPY /files/docker-entrypoint.sh /
RUN chmod u+x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

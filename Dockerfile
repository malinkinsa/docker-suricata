FROM centos:7.9.2009

RUN \
yum -y install epel-release

RUN \
yum -y update && \
yum install -y \
wget \
git \
jansson-devel \
libpcap-devel \
libyaml-devel \
lua-devel \
nss-devel \
nspr-devel \
libcap-ng-devel \
libmaxminddb-devel \
python36 \
python36-PyYAML \
lz4-devel \
pcre \
pcre-devel \
file-devel \
zlib-devel \
libyaml \
make \
gcc \
pkgconfig \
rustc \
cargo

WORKDIR /opt
RUN wget https://www.openinfosecfoundation.org/download/suricata-6.0.3.tar.gz && tar xzf suricata-6.0.3.tar.gz

WORKDIR /opt/suricata-6.0.3
RUN ./configure --prefix=/usr/ --sysconfdir=/etc/ --localstatedir=/var/ --enable-lua --enable-geoip && make && make install-full && ldconfig && mkdir -p /var/log/suricata

RUN rm -rf /opt/suricata-6.0.3/ && rm -f /opt/suricata-6.0.3.tar.gz

VOLUME /etc/suricata
VOLUME /etc/suricata/rules
VOLUME /var/log/suricata

COPY /files/docker-entrypoint.sh /
RUN chmod u+x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]